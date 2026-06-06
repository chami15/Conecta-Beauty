from fastapi import APIRouter, HTTPException
from app.api.analytics import inicio as analytics

router = APIRouter(prefix="/api/inicio", tags=["Início"])


@router.get("/kpis")
def kpis():
    try:
        return analytics.get_kpis()
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


@router.get("/faturamento-diario")
def faturamento_diario():
    try:
        return analytics.get_faturamento_diario()
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


@router.get("/pedidos-por-status")
def pedidos_por_status():
    try:
        return analytics.get_pedidos_por_status()
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


@router.get("/top-produtos")
def top_produtos():
    try:
        return analytics.get_top5_produtos()
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


@router.get("/saude")
def saude():
    try:
        return analytics.get_saude_empresa()
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
