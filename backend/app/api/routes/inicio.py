from fastapi import APIRouter, HTTPException, Query
from app.api.analytics import inicio as analytics

router = APIRouter(prefix="/api/inicio", tags=["Início"])


@router.get("/kpis")
def kpis(ano: int | None = Query(None), mes: int | None = Query(None, ge=1, le=12)):
    try:
        return analytics.get_kpis(ano=ano, mes=mes)
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


@router.get("/faturamento-diario")
def faturamento_diario(ano: int | None = Query(None), mes: int | None = Query(None, ge=1, le=12)):
    try:
        return analytics.get_faturamento_diario(ano=ano, mes=mes)
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


@router.get("/pedidos-por-status")
def pedidos_por_status(ano: int | None = Query(None), mes: int | None = Query(None, ge=1, le=12)):
    try:
        return analytics.get_pedidos_por_status(ano=ano, mes=mes)
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


@router.get("/top-produtos")
def top_produtos(ano: int | None = Query(None), mes: int | None = Query(None, ge=1, le=12)):
    try:
        return analytics.get_top5_produtos(ano=ano, mes=mes)
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


@router.get("/saude")
def saude():
    try:
        return analytics.get_saude_empresa()
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
