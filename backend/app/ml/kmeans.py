"""K-Means para segmentação de pedidos do Conecta Beauty.

O núcleo `treinar_kmeans_dataframe` é independente do banco: recebe um DataFrame
com pedido_id e as cinco variáveis numéricas e devolve os grupos e métricas.
As funções `treinar_kmeans_banco` e `consultar_resultados_banco` são adaptadores
para a tabela PostgreSQL ml.pedidos_padronizados usada pela API.
"""
from __future__ import annotations

from pathlib import Path
from typing import Any

import joblib
import numpy as np
import pandas as pd
from sklearn.cluster import KMeans
from sklearn.metrics import silhouette_score
from sklearn.preprocessing import StandardScaler

FEATURES = [
    "valor_total",
    "valor_frete",
    "quantidade_itens",
    "produtos_distintos",
    "preco_medio_item",
]
ID_COLUMN = "pedido_id"
ARTIFACT_DIR = Path(__file__).resolve().parent / "artifacts"
MODEL_PATH = ARTIFACT_DIR / "kmeans_pedidos.joblib"
SCALER_PATH = ARTIFACT_DIR / "kmeans_scaler.joblib"
METADATA_PATH = ARTIFACT_DIR / "kmeans_metadata.joblib"


def _validar_dataframe(dados: pd.DataFrame) -> pd.DataFrame:
    if not isinstance(dados, pd.DataFrame):
        raise TypeError("Os dados devem ser fornecidos como pandas.DataFrame.")
    faltantes = [c for c in [ID_COLUMN, *FEATURES] if c not in dados.columns]
    if faltantes:
        raise ValueError("Colunas obrigatórias ausentes: " + ", ".join(faltantes))
    if dados.empty:
        raise ValueError("A tabela recebida não contém pedidos.")
    df = dados[[ID_COLUMN, *FEATURES]].copy()
    if df[ID_COLUMN].isna().any():
        raise ValueError("A coluna pedido_id contém valores vazios.")
    for coluna in FEATURES:
        df[coluna] = pd.to_numeric(df[coluna], errors="coerce")
    df[FEATURES] = df[FEATURES].replace([np.inf, -np.inf], np.nan).fillna(0)
    # As variáveis representam valores/quantidades não negativos.
    df[FEATURES] = df[FEATURES].clip(lower=0)
    return df


def _preparar_matriz(df: pd.DataFrame) -> tuple[np.ndarray, StandardScaler]:
    # log1p reduz a assimetria de valores monetários; scaler equaliza escalas.
    matriz_log = np.log1p(df[FEATURES].astype(float))
    scaler = StandardScaler()
    return scaler.fit_transform(matriz_log), scaler


def _resumir_clusters(df: pd.DataFrame, rotulos: np.ndarray) -> list[dict[str, Any]]:
    base = df.copy()
    base["cluster"] = rotulos.astype(int)
    resumo = []
    total = len(base)
    for cluster_id in sorted(base["cluster"].unique()):
        grupo = base[base["cluster"] == cluster_id]
        resumo.append({
            "cluster": int(cluster_id),
            "quantidade_pedidos": int(len(grupo)),
            "percentual": round(len(grupo) / total * 100, 2),
            "ticket_medio": round(float(grupo["valor_total"].mean()), 2),
            "frete_medio": round(float(grupo["valor_frete"].mean()), 2),
            "itens_medio": round(float(grupo["quantidade_itens"].mean()), 2),
            "produtos_distintos_medio": round(float(grupo["produtos_distintos"].mean()), 2),
            "preco_medio_item": round(float(grupo["preco_medio_item"].mean()), 2),
        })
    return resumo


def treinar_kmeans_dataframe(
    dados: pd.DataFrame,
    n_clusters: int = 4,
    salvar_modelo: bool = True,
) -> dict[str, Any]:
    """Treina K-Means a partir de DataFrame, sem exigir conexão com banco.

    Retorna resumo, Silhouette Score e a atribuição cluster de cada pedido.
    """
    if n_clusters < 2:
        raise ValueError("n_clusters deve ser no mínimo 2.")
    df = _validar_dataframe(dados)
    if len(df) <= n_clusters:
        raise ValueError("É necessário ter mais pedidos do que clusters.")

    matriz_log = np.log1p(df[FEATURES].astype(float))
    scaler = StandardScaler()
    matriz_padronizada = scaler.fit_transform(matriz_log)
    modelo = KMeans(n_clusters=n_clusters, random_state=42, n_init=20)
    rotulos = modelo.fit_predict(matriz_padronizada)
    score = float(silhouette_score(matriz_padronizada, rotulos)) if len(set(rotulos)) > 1 else None

    if salvar_modelo:
        ARTIFACT_DIR.mkdir(parents=True, exist_ok=True)
        joblib.dump(modelo, MODEL_PATH)
        joblib.dump(scaler, SCALER_PATH)
        joblib.dump({"n_clusters": n_clusters, "features": FEATURES, "total_pedidos_treino": len(df)}, METADATA_PATH)

    pedidos = [
        {"pedido_id": str(pedido_id), "cluster": int(cluster)}
        for pedido_id, cluster in zip(df[ID_COLUMN].tolist(), rotulos)
    ]
    return {
        "status": "ok",
        "algoritmo": "K-Means",
        "n_clusters": int(n_clusters),
        "total_pedidos": int(len(df)),
        "silhouette_score": round(score, 4) if score is not None else None,
        "clusters": _resumir_clusters(df, rotulos),
        "pedidos": pedidos,
    }


def carregar_dados_banco() -> pd.DataFrame:
    """Lê a tabela PostgreSQL ml.pedidos_padronizados do projeto."""
    from utils.db import Database

    query = """
        SELECT pedido_id, valor_total, valor_frete, quantidade_itens,
               produtos_distintos, preco_medio_item
        FROM ml.pedidos_padronizados
        ORDER BY data_pedido, pedido_id
    """
    with Database() as db:
        if db.get_conn() is None:
            raise ConnectionError("Não foi possível conectar ao banco configurado no backend.")
        db.execute(query)
        linhas = db.fetchall()
    if not linhas:
        raise ValueError("A tabela ml.pedidos_padronizados não possui pedidos.")
    return pd.DataFrame(linhas, columns=[ID_COLUMN, *FEATURES])


def treinar_kmeans_banco(n_clusters: int = 4) -> dict[str, Any]:
    """Carrega pedidos do banco configurado e treina/salva o modelo."""
    dados = carregar_dados_banco()
    return treinar_kmeans_dataframe(dados, n_clusters=n_clusters, salvar_modelo=True)


def consultar_resultados_banco(offset: int = 0, limite: int = 1000) -> dict[str, Any]:
    """Aplica o modelo salvo aos pedidos atuais e retorna resumo + página de pedidos."""
    if not all(p.exists() for p in (MODEL_PATH, SCALER_PATH, METADATA_PATH)):
        raise FileNotFoundError("Modelo K-Means não treinado. Execute POST /api/ml/kmeans/treinar.")
    dados = _validar_dataframe(carregar_dados_banco())
    modelo = joblib.load(MODEL_PATH)
    scaler = joblib.load(SCALER_PATH)
    metadata = joblib.load(METADATA_PATH)
    matriz = scaler.transform(np.log1p(dados[FEATURES].astype(float)))
    rotulos = modelo.predict(matriz)
    resultado_pedidos = [
        {"pedido_id": str(pid), "cluster": int(cluster)}
        for pid, cluster in zip(dados[ID_COLUMN].tolist(), rotulos)
    ]
    inicio = max(0, int(offset))
    tamanho = min(max(1, int(limite)), 1000)
    resumo = _resumir_clusters(dados, rotulos)
    # Silhouette é calculado sobre os dados atuais, não é acurácia/classificação supervisionada.
    score = float(silhouette_score(matriz, rotulos)) if len(set(rotulos)) > 1 and len(matriz) > len(set(rotulos)) else None
    return {
        "algoritmo": "K-Means",
        "n_clusters": int(metadata["n_clusters"]),
        "total_pedidos": int(len(dados)),
        "silhouette_score": round(score, 4) if score is not None else None,
        "clusters": resumo,
        "pedidos": resultado_pedidos[inicio:inicio + tamanho],
        "paginacao": {"offset": inicio, "limite": tamanho, "total": len(resultado_pedidos)},
    }


def status_kmeans_banco() -> dict[str, Any]:
    from utils.db import Database
    try:
        with Database() as db:
            if db.get_conn() is None:
                return {"banco_conectado": False, "tabela_disponivel": False, "total_pedidos": 0,
                        "modelo_disponivel": all(p.exists() for p in (MODEL_PATH, SCALER_PATH, METADATA_PATH))}
            db.execute("SELECT to_regclass('ml.pedidos_padronizados')")
            existe = db.fetchone()[0] is not None
            total = 0
            if existe:
                db.execute("SELECT COUNT(*) FROM ml.pedidos_padronizados")
                total = int(db.fetchone()[0])
        return {"banco_conectado": True, "tabela_disponivel": existe, "total_pedidos": total,
                "modelo_disponivel": all(p.exists() for p in (MODEL_PATH, SCALER_PATH, METADATA_PATH))}
    except Exception as exc:
        return {"banco_conectado": False, "tabela_disponivel": False, "total_pedidos": 0,
                "modelo_disponivel": all(p.exists() for p in (MODEL_PATH, SCALER_PATH, METADATA_PATH)),
                "erro": str(exc)}
