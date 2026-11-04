"""K-Means para segmentação de pedidos do Conecta Beauty.

O núcleo `treinar_kmeans_dataframe` é independente do banco: recebe um DataFrame
com pedido_id e as variáveis numéricas e devolve os grupos e métricas.
As funções `*_banco` são adaptadores para a view PostgreSQL ml.pedidos_padronizados
(backend/sql/banco/ml.sql) usada pela API; o treino grava o segmento de cada pedido
em ml.segmento_pedido, lida pelo Power BI.

O frete não entra nas variáveis: Instagram e Facebook não informam frete, e tratar
a ausência como zero fazia o modelo separar os pedidos pelo canal, e não pelo perfil
de compra. Ele aparece só no resumo, como média dos pedidos que informam.
"""
from __future__ import annotations

import os
from pathlib import Path
from typing import Any

# O joblib (usado pelo scikit-learn) conta os núcleos do processador com o comando wmic,
# que não existe no Windows 11, e solta um aviso longo no terminal. Informar a contagem
# evita a consulta; precisa vir antes do import do joblib/sklearn.
os.environ.setdefault("LOKY_MAX_CPU_COUNT", str(os.cpu_count() or 1))

import joblib
import numpy as np
import pandas as pd
from sklearn.cluster import KMeans
from sklearn.metrics import silhouette_score
from sklearn.preprocessing import StandardScaler

FEATURES = [
    "valor_total",
    "quantidade_itens",
    "produtos_distintos",
    "preco_medio_item",
]
ID_COLUMN = "pedido_id"
INFO_COLUMNS = ["valor_frete"]  # só para o resumo, não entra no modelo
ARTIFACT_DIR = Path(__file__).resolve().parent / "artifacts"
MODEL_PATH = ARTIFACT_DIR / "kmeans_pedidos.joblib"
SCALER_PATH = ARTIFACT_DIR / "kmeans_scaler.joblib"
METADATA_PATH = ARTIFACT_DIR / "kmeans_metadata.joblib"
N_CLUSTERS_PADRAO = 3
AMOSTRA_SILHOUETTE = 5000  # silhouette é O(n²); acima disso usa amostra fixa

# Nomes por faixa de ticket médio, do menor para o maior grupo.
FAIXAS_TICKET = {
    2: ["Ticket baixo", "Ticket alto"],
    3: ["Ticket baixo", "Ticket médio", "Ticket alto"],
    4: ["Ticket baixo", "Ticket médio-baixo", "Ticket médio-alto", "Ticket alto"],
}


def _validar_dataframe(dados: pd.DataFrame) -> pd.DataFrame:
    if not isinstance(dados, pd.DataFrame):
        raise TypeError("Os dados devem ser fornecidos como pandas.DataFrame.")
    faltantes = [c for c in [ID_COLUMN, *FEATURES] if c not in dados.columns]
    if faltantes:
        raise ValueError("Colunas obrigatórias ausentes: " + ", ".join(faltantes))
    if dados.empty:
        raise ValueError("A tabela recebida não contém pedidos.")
    colunas = [ID_COLUMN, *FEATURES, *[c for c in INFO_COLUMNS if c in dados.columns]]
    df = dados[colunas].copy()
    if df[ID_COLUMN].isna().any():
        raise ValueError("A coluna pedido_id contém valores vazios.")
    for coluna in FEATURES + [c for c in INFO_COLUMNS if c in df.columns]:
        df[coluna] = pd.to_numeric(df[coluna], errors="coerce")
    df[FEATURES] = df[FEATURES].replace([np.inf, -np.inf], np.nan).fillna(0)
    # As variáveis representam valores/quantidades não negativos.
    df[FEATURES] = df[FEATURES].clip(lower=0)
    return df


def _matriz(df: pd.DataFrame) -> np.ndarray:
    # log1p reduz a assimetria de valores monetários (ver item 8: g1 = 2,65 no valor do pedido).
    return np.log1p(df[FEATURES].astype(float)).to_numpy()


def _silhouette(matriz: np.ndarray, rotulos: np.ndarray) -> float | None:
    if len(set(rotulos)) < 2 or len(matriz) <= len(set(rotulos)):
        return None
    amostra = AMOSTRA_SILHOUETTE if len(matriz) > AMOSTRA_SILHOUETTE else None
    return float(silhouette_score(matriz, rotulos, sample_size=amostra, random_state=42))


def _ordem_por_ticket(df: pd.DataFrame, rotulos: np.ndarray) -> dict[int, int]:
    """Renumera os grupos do menor para o maior ticket médio, para o id ser estável entre treinos."""
    medias = pd.Series(df["valor_total"].to_numpy()).groupby(rotulos).mean().sort_values()
    return {int(original): novo for novo, original in enumerate(medias.index)}


def _nomear(resumo: list[dict[str, Any]], geral: dict[str, float]) -> None:
    faixas = FAIXAS_TICKET.get(len(resumo)) or [f"Grupo {g['cluster'] + 1}" for g in resumo]
    for grupo, faixa in zip(resumo, faixas):
        if grupo["itens_medio"] >= geral["itens_medio"]:
            perfil = "muitos itens"
        elif grupo["preco_medio_item"] >= geral["preco_medio_item"]:
            perfil = "poucos itens caros"
        else:
            perfil = "poucos itens baratos"
        grupo["segmento"] = f"{faixa} · {perfil}"


def _resumir_clusters(df: pd.DataFrame, rotulos: np.ndarray) -> list[dict[str, Any]]:
    base = df.copy()
    base["cluster"] = rotulos.astype(int)
    total = len(base)
    tem_frete = "valor_frete" in base.columns
    resumo = []
    for cluster_id in sorted(base["cluster"].unique()):
        grupo = base[base["cluster"] == cluster_id]
        frete = grupo["valor_frete"].dropna() if tem_frete else pd.Series(dtype=float)
        resumo.append({
            "cluster": int(cluster_id),
            "quantidade_pedidos": int(len(grupo)),
            "percentual": round(len(grupo) / total * 100, 2),
            "ticket_medio": round(float(grupo["valor_total"].mean()), 2),
            "faturamento": round(float(grupo["valor_total"].sum()), 2),
            "frete_medio": round(float(frete.mean()), 2) if len(frete) else None,
            "itens_medio": round(float(grupo["quantidade_itens"].mean()), 2),
            "produtos_distintos_medio": round(float(grupo["produtos_distintos"].mean()), 2),
            "preco_medio_item": round(float(grupo["preco_medio_item"].mean()), 2),
        })
    _nomear(resumo, {
        "itens_medio": float(base["quantidade_itens"].mean()),
        "preco_medio_item": float(base["preco_medio_item"].mean()),
    })
    return resumo


def _pedidos(df: pd.DataFrame, rotulos: np.ndarray, resumo: list[dict[str, Any]]) -> list[dict[str, Any]]:
    nomes = {g["cluster"]: g["segmento"] for g in resumo}
    return [
        {"pedido_id": str(pid), "cluster": int(c), "segmento": nomes[int(c)]}
        for pid, c in zip(df[ID_COLUMN].tolist(), rotulos)
    ]


def treinar_kmeans_dataframe(
    dados: pd.DataFrame,
    n_clusters: int = N_CLUSTERS_PADRAO,
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

    scaler = StandardScaler()
    matriz = scaler.fit_transform(_matriz(df))
    modelo = KMeans(n_clusters=n_clusters, random_state=42, n_init=20)
    brutos = modelo.fit_predict(matriz)
    ordem = _ordem_por_ticket(df, brutos)
    rotulos = np.array([ordem[int(r)] for r in brutos])
    score = _silhouette(matriz, rotulos)
    resumo = _resumir_clusters(df, rotulos)

    if salvar_modelo:
        ARTIFACT_DIR.mkdir(parents=True, exist_ok=True)
        joblib.dump(modelo, MODEL_PATH)
        joblib.dump(scaler, SCALER_PATH)
        joblib.dump({"n_clusters": n_clusters, "features": FEATURES, "ordem": ordem,
                     "total_pedidos_treino": len(df)}, METADATA_PATH)

    return {
        "status": "ok",
        "algoritmo": "K-Means",
        "n_clusters": int(n_clusters),
        "features": FEATURES,
        "total_pedidos": int(len(df)),
        "silhouette_score": round(score, 4) if score is not None else None,
        "clusters": resumo,
        "pedidos": _pedidos(df, rotulos, resumo),
    }


def avaliar_k_dataframe(dados: pd.DataFrame, k_min: int = 2, k_max: int = 8) -> list[dict[str, Any]]:
    """Silhouette e inércia (método do cotovelo) para cada k, para justificar a escolha do número de grupos."""
    df = _validar_dataframe(dados)
    matriz = StandardScaler().fit_transform(_matriz(df))
    resultado = []
    for k in range(max(2, k_min), min(k_max, len(df) - 1) + 1):
        modelo = KMeans(n_clusters=k, random_state=42, n_init=10)
        rotulos = modelo.fit_predict(matriz)
        score = _silhouette(matriz, rotulos)
        resultado.append({"k": k, "silhouette_score": round(score, 4) if score is not None else None,
                          "inercia": round(float(modelo.inertia_), 2)})
    return resultado


def carregar_dados_banco() -> pd.DataFrame:
    """Lê a view PostgreSQL ml.pedidos_padronizados do projeto."""
    from utils.db import Database

    query = f"""
        SELECT {ID_COLUMN}, {", ".join(FEATURES + INFO_COLUMNS)}
        FROM ml.pedidos_padronizados
        ORDER BY data_pedido, pedido_id
    """
    with Database() as db:
        if db.get_conn() is None:
            raise ConnectionError("Não foi possível conectar ao banco configurado no backend.")
        db.execute(query)
        linhas = db.fetchall()
    if not linhas:
        raise ValueError("A view ml.pedidos_padronizados não possui pedidos.")
    return pd.DataFrame(linhas, columns=[ID_COLUMN, *FEATURES, *INFO_COLUMNS])


def gravar_segmentos_banco(pedidos: list[dict[str, Any]]) -> int:
    """Regrava ml.segmento_pedido com o segmento de cada pedido (uma transação)."""
    from utils.db import Database

    valores = [(int(p["pedido_id"]), p["cluster"], p["segmento"]) for p in pedidos]
    with Database() as db:
        if db.get_conn() is None:
            raise ConnectionError("Não foi possível conectar ao banco configurado no backend.")
        db.execute("TRUNCATE ml.segmento_pedido")
        db.execute_values(
            "INSERT INTO ml.segmento_pedido (pedido_id, cluster, segmento) VALUES %s", valores)
        db.commit()
    return len(valores)


def treinar_kmeans_banco(n_clusters: int = N_CLUSTERS_PADRAO) -> dict[str, Any]:
    """Carrega pedidos do banco, treina/salva o modelo e grava o segmento de cada pedido."""
    resultado = treinar_kmeans_dataframe(carregar_dados_banco(), n_clusters=n_clusters, salvar_modelo=True)
    resultado["pedidos_gravados"] = gravar_segmentos_banco(resultado["pedidos"])
    # A tabela completa fica no banco; a resposta devolve só uma amostra.
    resultado["pedidos"] = resultado["pedidos"][:100]
    return resultado


def avaliar_k_banco(k_min: int = 2, k_max: int = 8) -> list[dict[str, Any]]:
    return avaliar_k_dataframe(carregar_dados_banco(), k_min=k_min, k_max=k_max)


def consultar_resultados_banco(offset: int = 0, limite: int = 1000) -> dict[str, Any]:
    """Aplica o modelo salvo aos pedidos atuais e retorna resumo + página de pedidos."""
    if not all(p.exists() for p in (MODEL_PATH, SCALER_PATH, METADATA_PATH)):
        raise FileNotFoundError("Modelo K-Means não treinado. Execute POST /api/ml/kmeans/treinar.")
    metadata = joblib.load(METADATA_PATH)
    if metadata.get("features") != FEATURES:
        raise FileNotFoundError("Modelo salvo usa outras variáveis. Treine novamente em POST /api/ml/kmeans/treinar.")
    dados = _validar_dataframe(carregar_dados_banco())
    modelo = joblib.load(MODEL_PATH)
    scaler = joblib.load(SCALER_PATH)
    matriz = scaler.transform(_matriz(dados))
    ordem = metadata["ordem"]
    rotulos = np.array([ordem[int(r)] for r in modelo.predict(matriz)])
    resumo = _resumir_clusters(dados, rotulos)
    pedidos = _pedidos(dados, rotulos, resumo)
    inicio = max(0, int(offset))
    tamanho = min(max(1, int(limite)), 1000)
    # Silhouette é calculado sobre os dados atuais, não é acurácia/classificação supervisionada.
    score = _silhouette(matriz, rotulos)
    return {
        "algoritmo": "K-Means",
        "n_clusters": int(metadata["n_clusters"]),
        "features": FEATURES,
        "total_pedidos": int(len(dados)),
        "silhouette_score": round(score, 4) if score is not None else None,
        "clusters": resumo,
        "pedidos": pedidos[inicio:inicio + tamanho],
        "paginacao": {"offset": inicio, "limite": tamanho, "total": len(pedidos)},
    }


def status_kmeans_banco() -> dict[str, Any]:
    from utils.db import Database
    modelo = all(p.exists() for p in (MODEL_PATH, SCALER_PATH, METADATA_PATH))
    try:
        with Database() as db:
            if db.get_conn() is None:
                return {"banco_conectado": False, "tabela_disponivel": False, "total_pedidos": 0,
                        "modelo_disponivel": modelo}
            db.execute("SELECT to_regclass('ml.pedidos_padronizados')")
            existe = db.fetchone()[0] is not None
            total = 0
            if existe:
                db.execute("SELECT COUNT(*) FROM ml.pedidos_padronizados")
                total = int(db.fetchone()[0])
        return {"banco_conectado": True, "tabela_disponivel": existe, "total_pedidos": total,
                "modelo_disponivel": modelo}
    except Exception as exc:
        return {"banco_conectado": False, "tabela_disponivel": False, "total_pedidos": 0,
                "modelo_disponivel": modelo, "erro": str(exc)}
