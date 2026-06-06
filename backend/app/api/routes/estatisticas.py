from fastapi import APIRouter, HTTPException
from app.api.analytics import estatisticas as analytics

router = APIRouter(prefix="/api/analytics", tags=["Analytics Estatísticos"])


# ─── Início ───────────────────────────────────

@router.get("/inicio/tendencia")
def tendencia_faturamento():
    """Regressão linear + projeção de 3 meses com intervalo de confiança."""
    try:
        return analytics.get_tendencia()
    except Exception as e:
        raise HTTPException(500, str(e))


@router.get("/inicio/distribuicao-vendas")
def distribuicao_vendas():
    """Histograma de valores de venda + descritivas + teste Shapiro-Wilk."""
    try:
        return analytics.get_distribuicao_vendas()
    except Exception as e:
        raise HTTPException(500, str(e))


# ─── Financeiro ───────────────────────────────

@router.get("/financeiro/anova-trimestres")
def anova_trimestres():
    """ANOVA one-way comparando faturamento entre trimestres."""
    try:
        return analytics.get_anova_trimestres()
    except Exception as e:
        raise HTTPException(500, str(e))


@router.get("/financeiro/intervalo-confianca")
def intervalo_confianca():
    """Intervalo de confiança de 95% para a receita mensal."""
    try:
        return analytics.get_intervalo_confianca()
    except Exception as e:
        raise HTTPException(500, str(e))


# ─── Administrativo ───────────────────────────

@router.get("/admin/anova-canais")
def anova_canais():
    """ANOVA one-way comparando faturamento entre canais de venda."""
    try:
        return analytics.get_anova_canais()
    except Exception as e:
        raise HTTPException(500, str(e))


# ─── Estoque ──────────────────────────────────

@router.get("/estoque/correlacao")
def correlacao_estoque_vendas():
    """Correlação de Pearson entre nível de estoque e quantidade vendida."""
    try:
        return analytics.get_correlacao_estoque_vendas()
    except Exception as e:
        raise HTTPException(500, str(e))


@router.get("/estoque/descritivas")
def descritivas_produtos():
    """Estatísticas descritivas de vendas por produto (média, mediana, desvio)."""
    try:
        return analytics.get_descritivas_produtos()
    except Exception as e:
        raise HTTPException(500, str(e))
