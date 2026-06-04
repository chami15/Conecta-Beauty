"""
Script de treinamento do MLPRegressor para previsão de faturamento mensal.

Pode ser executado diretamente:
    python -m app.ml.treinar

Ou importado como função:
    from app.ml.treinar import treinar_modelo
"""

import os
import numpy as np
import joblib
from sklearn.neural_network import MLPRegressor
from sklearn.preprocessing import StandardScaler
from sklearn.model_selection import TimeSeriesSplit
from sklearn.metrics import mean_absolute_error, mean_squared_error
from utils.query_executor import executar_query

MODEL_DIR = os.path.join(os.path.dirname(__file__))
MODEL_PATH = os.path.join(MODEL_DIR, "modelo.pkl")
SCALER_X_PATH = os.path.join(MODEL_DIR, "scaler_x.pkl")
SCALER_Y_PATH = os.path.join(MODEL_DIR, "scaler_y.pkl")
META_PATH = os.path.join(MODEL_DIR, "meta.pkl")

N_LAGS = 3


def _construir_features(serie: list[float]) -> tuple[np.ndarray, np.ndarray]:
    """
    Recebe série temporal ordenada de faturamento mensal.
    Retorna (X, y) com features:
      - lag_1, lag_2, lag_3  (valores anteriores)
      - mes_sin, mes_cos     (codificação cíclica do mês)
      - t                    (índice temporal normalizado)
    """
    n = len(serie)
    X_rows, y_rows = [], []

    for i in range(N_LAGS, n):
        lags = [serie[i - j] for j in range(1, N_LAGS + 1)]
        mes = (i % 12) + 1
        mes_sin = np.sin(2 * np.pi * mes / 12)
        mes_cos = np.cos(2 * np.pi * mes / 12)
        t_norm = i / n
        X_rows.append(lags + [mes_sin, mes_cos, t_norm])
        y_rows.append(serie[i])

    return np.array(X_rows, dtype=float), np.array(y_rows, dtype=float)


def treinar_modelo() -> dict:
    rows = executar_query("analytics:faturamento_mensal")
    rows_sorted = sorted(rows, key=lambda r: (int(r["ano"]), int(r["mes"])))

    if len(rows_sorted) < N_LAGS + 4:
        raise ValueError(
            f"Dados insuficientes para treinar (mínimo {N_LAGS + 4} meses, "
            f"encontrado {len(rows_sorted)})"
        )

    serie = [float(r["faturamento"]) for r in rows_sorted]
    meses_meta = [(int(r["ano"]), int(r["mes"])) for r in rows_sorted]

    X, y = _construir_features(serie)

    scaler_x = StandardScaler()
    scaler_y = StandardScaler()

    X_scaled = scaler_x.fit_transform(X)
    y_scaled = scaler_y.fit_transform(y.reshape(-1, 1)).ravel()

    modelo = MLPRegressor(
        hidden_layer_sizes=(64, 32),
        activation="relu",
        solver="adam",
        max_iter=2000,
        learning_rate_init=0.001,
        early_stopping=True,
        validation_fraction=0.15,
        n_iter_no_change=30,
        random_state=42,
    )

    # Validação cruzada em série temporal (sem data leakage)
    tscv = TimeSeriesSplit(n_splits=min(3, len(X) // 4))
    maes, rmses = [], []
    for train_idx, val_idx in tscv.split(X_scaled):
        modelo_cv = MLPRegressor(
            hidden_layer_sizes=(64, 32),
            activation="relu",
            solver="adam",
            max_iter=1000,
            random_state=42,
        )
        modelo_cv.fit(X_scaled[train_idx], y_scaled[train_idx])
        preds_scaled = modelo_cv.predict(X_scaled[val_idx])
        preds = scaler_y.inverse_transform(preds_scaled.reshape(-1, 1)).ravel()
        real = y[val_idx]
        maes.append(mean_absolute_error(real, preds))
        rmses.append(np.sqrt(mean_squared_error(real, preds)))

    # Treino final com todos os dados
    modelo.fit(X_scaled, y_scaled)

    # Persiste artefatos
    joblib.dump(modelo, MODEL_PATH)
    joblib.dump(scaler_x, SCALER_X_PATH)
    joblib.dump(scaler_y, SCALER_Y_PATH)

    meta = {
        "serie": serie,
        "meses_meta": meses_meta,
        "mae_cv": float(np.mean(maes)),
        "rmse_cv": float(np.mean(rmses)),
        "n_amostras": len(serie),
    }
    joblib.dump(meta, META_PATH)

    return {
        "status": "ok",
        "n_amostras": len(serie),
        "mae_cv": round(float(np.mean(maes)), 2),
        "rmse_cv": round(float(np.mean(rmses)), 2),
        "iteracoes": int(modelo.n_iter_),
    }


if __name__ == "__main__":
    resultado = treinar_modelo()
    print("Modelo treinado com sucesso:")
    for k, v in resultado.items():
        print(f"  {k}: {v}")
