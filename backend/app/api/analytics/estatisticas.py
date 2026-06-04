import numpy as np
import pandas as pd
from scipy import stats
from utils.query_executor import executar_query


# ─────────────────────────────────────────────
# Helpers
# ─────────────────────────────────────────────

def _to_float(v):
    try:
        return float(v)
    except (TypeError, ValueError):
        return None


def _safe(v):
    """Converte tipos numpy para Python nativo (serialização JSON)."""
    if isinstance(v, (np.integer,)):
        return int(v)
    if isinstance(v, (np.floating,)):
        return None if np.isnan(v) else float(v)
    if isinstance(v, float) and np.isnan(v):
        return None
    return v


# ─────────────────────────────────────────────
# 1. Tendência — Regressão Linear + Projeção
# ─────────────────────────────────────────────

def get_tendencia():
    rows = executar_query("analytics:faturamento_mensal")

    if len(rows) < 3:
        return {"erro": "Dados insuficientes para regressão (mínimo 3 meses)"}

    df = pd.DataFrame(rows)
    df["faturamento"] = df["faturamento"].apply(_to_float)
    df = df.dropna(subset=["faturamento"])
    df = df.sort_values(["ano", "mes"]).reset_index(drop=True)
    df["t"] = np.arange(1, len(df) + 1)

    x = df["t"].values.astype(float)
    y = df["faturamento"].values.astype(float)

    slope, intercept, r_value, p_value, std_err = stats.linregress(x, y)

    n = len(x)
    t_crit = stats.t.ppf(0.975, df=n - 2)
    y_hat = intercept + slope * x
    residuals = y - y_hat
    s_res = np.sqrt(np.sum(residuals ** 2) / (n - 2))
    x_mean = np.mean(x)

    historico = []
    for i, row in df.iterrows():
        xi = float(row["t"])
        yi_hat = intercept + slope * xi
        se_pred = s_res * np.sqrt(1 / n + (xi - x_mean) ** 2 / np.sum((x - x_mean) ** 2))
        historico.append({
            "ano": int(row["ano"]),
            "mes": int(row["mes"]),
            "nome_mes": row.get("nome_mes", ""),
            "faturamento_real": _safe(row["faturamento"]),
            "faturamento_tendencia": _safe(round(yi_hat, 2)),
            "ic_lower": _safe(round(yi_hat - t_crit * se_pred, 2)),
            "ic_upper": _safe(round(yi_hat + t_crit * se_pred, 2)),
        })

    projecoes = []
    last_t = int(x[-1])
    last_row = df.iloc[-1]
    ano_proj = int(last_row["ano"])
    mes_proj = int(last_row["mes"])
    meses_nomes = ["Jan", "Fev", "Mar", "Abr", "Mai", "Jun",
                   "Jul", "Ago", "Set", "Out", "Nov", "Dez"]
    for step in range(1, 4):
        xi = last_t + step
        yi_hat = intercept + slope * xi
        se_pred = s_res * np.sqrt(1 + 1 / n + (xi - x_mean) ** 2 / np.sum((x - x_mean) ** 2))
        mes_proj = mes_proj % 12 + 1
        if mes_proj == 1:
            ano_proj += 1
        projecoes.append({
            "mes_futuro": step,
            "ano": ano_proj,
            "mes": mes_proj,
            "nome_mes": meses_nomes[mes_proj - 1],
            "faturamento_projetado": _safe(round(yi_hat, 2)),
            "ic_lower": _safe(round(yi_hat - t_crit * se_pred, 2)),
            "ic_upper": _safe(round(yi_hat + t_crit * se_pred, 2)),
        })

    return {
        "modelo": {
            "slope": _safe(round(slope, 4)),
            "intercept": _safe(round(intercept, 2)),
            "r_squared": _safe(round(r_value ** 2, 4)),
            "p_value": _safe(round(p_value, 6)),
            "tendencia": "crescente" if slope > 0 else "decrescente",
            "significativo": bool(p_value < 0.05),
        },
        "historico": historico,
        "projecoes": projecoes,
    }


# ─────────────────────────────────────────────
# 2. Distribuição de Vendas + Teste Shapiro-Wilk
# ─────────────────────────────────────────────

def get_distribuicao_vendas():
    rows = executar_query("analytics:valores_vendas_individuais")

    if len(rows) < 4:
        return {"erro": "Dados insuficientes para análise de distribuição"}

    valores = np.array([_to_float(r["valor_total"]) for r in rows], dtype=float)
    valores = valores[~np.isnan(valores)]

    n_bins = min(20, max(5, int(np.sqrt(len(valores)))))
    counts, bin_edges = np.histogram(valores, bins=n_bins)

    histograma = []
    for i in range(len(counts)):
        histograma.append({
            "bin_inicio": _safe(round(float(bin_edges[i]), 2)),
            "bin_fim": _safe(round(float(bin_edges[i + 1]), 2)),
            "frequencia": int(counts[i]),
        })

    stat_sw, p_sw = stats.shapiro(valores[:5000])

    percentis = np.percentile(valores, [25, 50, 75])

    return {
        "descritivas": {
            "n": int(len(valores)),
            "media": _safe(round(float(np.mean(valores)), 2)),
            "mediana": _safe(round(float(np.median(valores)), 2)),
            "desvio_padrao": _safe(round(float(np.std(valores)), 2)),
            "variancia": _safe(round(float(np.var(valores)), 2)),
            "minimo": _safe(round(float(np.min(valores)), 2)),
            "maximo": _safe(round(float(np.max(valores)), 2)),
            "q1": _safe(round(float(percentis[0]), 2)),
            "q3": _safe(round(float(percentis[2]), 2)),
            "assimetria": _safe(round(float(stats.skew(valores)), 4)),
            "curtose": _safe(round(float(stats.kurtosis(valores)), 4)),
        },
        "normalidade": {
            "teste": "Shapiro-Wilk",
            "estatistica": _safe(round(float(stat_sw), 6)),
            "p_value": _safe(round(float(p_sw), 6)),
            "normal": bool(p_sw >= 0.05),
            "interpretacao": "Distribuição normal (p≥0.05)" if p_sw >= 0.05 else "Distribuição não-normal (p<0.05)",
        },
        "histograma": histograma,
    }


# ─────────────────────────────────────────────
# 3. ANOVA — Faturamento por Trimestre
# ─────────────────────────────────────────────

def get_anova_trimestres():
    rows = executar_query("analytics:faturamento_mensal_por_trimestre")

    if not rows:
        return {"erro": "Sem dados para ANOVA de trimestres"}

    df = pd.DataFrame(rows)
    df["faturamento"] = df["faturamento"].apply(_to_float)
    df = df.dropna(subset=["faturamento"])

    grupos = {}
    for _, r in df.iterrows():
        chave = f"T{int(r['trimestre'])}"
        grupos.setdefault(chave, []).append(float(r["faturamento"]))

    if len(grupos) < 2:
        return {"erro": "Necessário ao menos 2 trimestres para ANOVA"}

    listas = list(grupos.values())
    f_stat, p_value = stats.f_oneway(*listas)

    resumo_grupos = []
    for nome, vals in grupos.items():
        arr = np.array(vals)
        resumo_grupos.append({
            "grupo": nome,
            "n": int(len(arr)),
            "media": _safe(round(float(np.mean(arr)), 2)),
            "desvio_padrao": _safe(round(float(np.std(arr)), 2)),
        })
    resumo_grupos.sort(key=lambda g: g["grupo"])

    return {
        "anova": {
            "f_estatistica": _safe(round(float(f_stat), 4)),
            "p_value": _safe(round(float(p_value), 6)),
            "significativo": bool(p_value < 0.05),
            "interpretacao": (
                "Diferença significativa entre trimestres (p<0.05)"
                if p_value < 0.05
                else "Sem diferença significativa entre trimestres (p≥0.05)"
            ),
        },
        "grupos": resumo_grupos,
    }


# ─────────────────────────────────────────────
# 4. ANOVA — Faturamento por Canal de Venda
# ─────────────────────────────────────────────

def get_anova_canais():
    rows = executar_query("analytics:faturamento_mensal_por_canal")

    if not rows:
        return {"erro": "Sem dados para ANOVA de canais"}

    df = pd.DataFrame(rows)
    df["faturamento"] = df["faturamento"].apply(_to_float)
    df = df.dropna(subset=["faturamento"])

    grupos = {}
    for _, r in df.iterrows():
        canal = str(r["canal_venda"])
        grupos.setdefault(canal, []).append(float(r["faturamento"]))

    if len(grupos) < 2:
        return {"erro": "Necessário ao menos 2 canais para ANOVA"}

    listas = list(grupos.values())
    f_stat, p_value = stats.f_oneway(*listas)

    resumo_grupos = []
    for nome, vals in grupos.items():
        arr = np.array(vals)
        resumo_grupos.append({
            "canal": nome,
            "n": int(len(arr)),
            "media": _safe(round(float(np.mean(arr)), 2)),
            "desvio_padrao": _safe(round(float(np.std(arr)), 2)),
            "total": _safe(round(float(np.sum(arr)), 2)),
        })
    resumo_grupos.sort(key=lambda g: g["total"], reverse=True)

    return {
        "anova": {
            "f_estatistica": _safe(round(float(f_stat), 4)),
            "p_value": _safe(round(float(p_value), 6)),
            "significativo": bool(p_value < 0.05),
            "interpretacao": (
                "Diferença significativa entre canais (p<0.05)"
                if p_value < 0.05
                else "Sem diferença significativa entre canais (p≥0.05)"
            ),
        },
        "grupos": resumo_grupos,
    }


# ─────────────────────────────────────────────
# 5. Intervalo de Confiança — Receita Mensal (95%)
# ─────────────────────────────────────────────

def get_intervalo_confianca():
    rows = executar_query("analytics:faturamento_mensal")

    if len(rows) < 2:
        return {"erro": "Dados insuficientes para intervalo de confiança"}

    valores = np.array([_to_float(r["faturamento"]) for r in rows], dtype=float)
    valores = valores[~np.isnan(valores)]

    n = len(valores)
    media = float(np.mean(valores))
    se = float(stats.sem(valores))
    ic_low, ic_high = stats.t.interval(0.95, df=n - 1, loc=media, scale=se)

    meses_formatados = []
    df_tmp = pd.DataFrame(rows)
    df_tmp["faturamento"] = df_tmp["faturamento"].apply(_to_float)
    df_tmp = df_tmp.sort_values(["ano", "mes"])
    for _, r in df_tmp.iterrows():
        meses_formatados.append({
            "ano": int(r["ano"]),
            "mes": int(r["mes"]),
            "nome_mes": r.get("nome_mes", ""),
            "faturamento": _safe(round(float(r["faturamento"]), 2)),
        })

    return {
        "intervalo_confianca": {
            "nivel": "95%",
            "media": _safe(round(media, 2)),
            "ic_lower": _safe(round(float(ic_low), 2)),
            "ic_upper": _safe(round(float(ic_high), 2)),
            "erro_padrao": _safe(round(se, 2)),
            "n": int(n),
        },
        "serie_mensal": meses_formatados,
    }


# ─────────────────────────────────────────────
# 6. Correlação de Pearson — Estoque vs Vendas
# ─────────────────────────────────────────────

def get_correlacao_estoque_vendas():
    rows = executar_query("analytics:estoque_vs_vendas_mensal")

    if len(rows) < 5:
        return {"erro": "Dados insuficientes para correlação (mínimo 5 observações)"}

    df = pd.DataFrame(rows)
    df["qtd_vendida"] = df["qtd_vendida"].apply(_to_float)
    df["estoque_medio"] = df["estoque_medio"].apply(_to_float)
    df = df.dropna(subset=["qtd_vendida", "estoque_medio"])

    r, p_value = stats.pearsonr(df["estoque_medio"].values, df["qtd_vendida"].values)

    if abs(r) >= 0.7:
        forca = "forte"
    elif abs(r) >= 0.4:
        forca = "moderada"
    else:
        forca = "fraca"
    direcao = "positiva" if r >= 0 else "negativa"

    pontos = []
    for _, row in df.iterrows():
        pontos.append({
            "produto": row.get("nome_produto", ""),
            "ano": int(row["ano"]),
            "mes": int(row["mes"]),
            "estoque_medio": _safe(round(float(row["estoque_medio"]), 2)),
            "qtd_vendida": _safe(round(float(row["qtd_vendida"]), 2)),
        })

    por_produto = df.groupby("nome_produto").agg(
        estoque_medio=("estoque_medio", "mean"),
        qtd_vendida=("qtd_vendida", "mean"),
    ).reset_index()

    resumo_produtos = []
    for _, r_prod in por_produto.iterrows():
        resumo_produtos.append({
            "produto": r_prod["nome_produto"],
            "estoque_medio": _safe(round(float(r_prod["estoque_medio"]), 2)),
            "media_vendas": _safe(round(float(r_prod["qtd_vendida"]), 2)),
        })
    resumo_produtos.sort(key=lambda p: p["media_vendas"] or 0, reverse=True)

    return {
        "correlacao": {
            "r": _safe(round(float(r), 4)),
            "r_squared": _safe(round(float(r ** 2), 4)),
            "p_value": _safe(round(float(p_value), 6)),
            "significativo": bool(p_value < 0.05),
            "forca": forca,
            "direcao": direcao,
            "interpretacao": f"Correlação {forca} {direcao} entre estoque e vendas",
        },
        "scatter": pontos,
        "resumo_por_produto": resumo_produtos,
    }


# ─────────────────────────────────────────────
# 7. Estatísticas Descritivas por Produto
# ─────────────────────────────────────────────

def get_descritivas_produtos():
    rows = executar_query("analytics:vendas_por_produto_detalhe")

    if not rows:
        return {"erro": "Sem dados de vendas por produto"}

    df = pd.DataFrame(rows)
    df["quantidade"] = df["quantidade"].apply(_to_float)
    df["valor_unitario"] = df["valor_unitario"].apply(_to_float)
    df["valor_total"] = df["valor_total"].apply(_to_float)
    df = df.dropna(subset=["quantidade", "valor_total"])

    produtos = []
    for nome, grupo in df.groupby("nome_produto"):
        qtd = grupo["quantidade"].values.astype(float)
        vt = grupo["valor_total"].values.astype(float)
        vu = grupo["valor_unitario"].values.astype(float)

        produtos.append({
            "produto": nome,
            "n_vendas": int(len(grupo)),
            "quantidade": {
                "total": _safe(round(float(np.sum(qtd)), 0)),
                "media": _safe(round(float(np.mean(qtd)), 2)),
                "mediana": _safe(round(float(np.median(qtd)), 2)),
                "desvio_padrao": _safe(round(float(np.std(qtd)), 2)),
            },
            "valor_total": {
                "soma": _safe(round(float(np.sum(vt)), 2)),
                "media": _safe(round(float(np.mean(vt)), 2)),
                "mediana": _safe(round(float(np.median(vt)), 2)),
                "desvio_padrao": _safe(round(float(np.std(vt)), 2)),
            },
            "preco_unitario": {
                "media": _safe(round(float(np.mean(vu)), 2)),
                "min": _safe(round(float(np.min(vu)), 2)),
                "max": _safe(round(float(np.max(vu)), 2)),
            },
        })

    produtos.sort(key=lambda p: p["valor_total"]["soma"] or 0, reverse=True)

    totais = df["valor_total"].values.astype(float)
    return {
        "resumo_geral": {
            "total_produtos": int(df["nome_produto"].nunique()),
            "total_vendas": int(len(df)),
            "receita_total": _safe(round(float(np.sum(totais)), 2)),
            "ticket_medio": _safe(round(float(np.mean(totais)), 2)),
        },
        "por_produto": produtos,
    }
