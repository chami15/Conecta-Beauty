"""
Singleton que carrega o modelo treinado e serve previsões.
O modelo é carregado uma única vez quando o módulo é importado.
"""

import os
import numpy as np
import joblib

MODEL_DIR = os.path.dirname(__file__)
MODEL_PATH = os.path.join(MODEL_DIR, "modelo.pkl")
SCALER_X_PATH = os.path.join(MODEL_DIR, "scaler_x.pkl")
SCALER_Y_PATH = os.path.join(MODEL_DIR, "scaler_y.pkl")
META_PATH = os.path.join(MODEL_DIR, "meta.pkl")

N_LAGS = 3

_modelo = None
_scaler_x = None
_scaler_y = None
_meta = None


def modelo_disponivel() -> bool:
    return all(os.path.exists(p) for p in [MODEL_PATH, SCALER_X_PATH, SCALER_Y_PATH, META_PATH])


def carregar():
    global _modelo, _scaler_x, _scaler_y, _meta
    if _modelo is None:
        if not modelo_disponivel():
            raise FileNotFoundError(
                "Modelo não encontrado. Execute o treino primeiro: "
                "POST /api/ml/treinar"
            )
        _modelo = joblib.load(MODEL_PATH)
        _scaler_x = joblib.load(SCALER_X_PATH)
        _scaler_y = joblib.load(SCALER_Y_PATH)
        _meta = joblib.load(META_PATH)


def nome_mes(mes: int) -> str:
    nomes = ["Jan", "Fev", "Mar", "Abr", "Mai", "Jun",
             "Jul", "Ago", "Set", "Out", "Nov", "Dez"]
    return nomes[mes - 1]


def proximo_ano_mes(ano: int, mes: int) -> tuple[int, int]:
    mes += 1
    if mes > 12:
        mes = 1
        ano += 1
    return ano, mes


def prever(horizonte: int = 3) -> dict:
    carregar()

    serie = list(_meta["serie"])
    meses_meta = list(_meta["meses_meta"])
    n_total = len(serie)

    ultimo_ano, ultimo_mes = meses_meta[-1]

    previsoes = []
    serie_extendida = serie.copy()

    for step in range(horizonte):
        lags = [serie_extendida[-(j + 1)] for j in range(N_LAGS)]
        idx = n_total + step
        mes_num = (idx % 12) + 1
        mes_sin = np.sin(2 * np.pi * mes_num / 12)
        mes_cos = np.cos(2 * np.pi * mes_num / 12)
        t_norm = idx / n_total

        x_input = np.array([lags + [mes_sin, mes_cos, t_norm]], dtype=float)
        x_scaled = _scaler_x.transform(x_input)
        y_scaled = _modelo.predict(x_scaled)
        y_pred = float(_scaler_y.inverse_transform(y_scaled.reshape(-1, 1)).ravel()[0])
        y_pred = max(0.0, y_pred)

        ultimo_ano, ultimo_mes = proximo_ano_mes(ultimo_ano, ultimo_mes)

        margem = _meta["mae_cv"] * 1.5
        previsoes.append({
            "passo": step + 1,
            "ano": ultimo_ano,
            "mes": ultimo_mes,
            "nome_mes": nome_mes(ultimo_mes),
            "faturamento_previsto": round(y_pred, 2),
            "ic_lower": round(max(0.0, y_pred - margem), 2),
            "ic_upper": round(y_pred + margem, 2),
        })
        serie_extendida.append(y_pred)

    historico = []
    for (ano, mes), fat in zip(meses_meta, serie):
        historico.append({
            "ano": ano,
            "mes": mes,
            "nome_mes": nome_mes(mes),
            "faturamento_real": round(fat, 2),
        })

    return {
        "modelo": {
            "mae_cv": round(_meta["mae_cv"], 2),
            "rmse_cv": round(_meta["rmse_cv"], 2),
            "n_amostras_treino": _meta["n_amostras"],
        },
        "historico": historico,
        "previsoes": previsoes,
    }


def recarregar():
    """Força recarga dos artefatos do disco (usado após novo treino)."""
    global _modelo, _scaler_x, _scaler_y, _meta
    _modelo = _scaler_x = _scaler_y = _meta = None
    carregar()
