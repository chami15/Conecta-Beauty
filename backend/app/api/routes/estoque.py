from typing import Optional
from datetime import date
from enum import Enum
from fastapi import APIRouter, HTTPException, Query
from pydantic import BaseModel
from app.api.analytics import estoque as analytics

router = APIRouter(prefix="/api/estoque", tags=["Estoque"])


# ─────────────────────────────────────────────
# Schemas (Pydantic)
# ─────────────────────────────────────────────

class StatusFrete(str, Enum):
    aguardando = "Aguardando"
    coletado = "Coletado"
    em_transito = "Em Trânsito"
    entregue = "Entregue"
    devolvido = "Devolvido"
    extraviado = "Extraviado"


class MovimentacaoBody(BaseModel):
    data_movimentacao: date
    fk_produto: int
    fk_tipo_movimentacao: int
    fk_fornecedor: Optional[int] = None
    quantidade: int
    valor_unitario: float


class FreteBody(BaseModel):
    numero_pedido: int
    data_envio: Optional[date] = None
    data_entrega: Optional[date] = None
    fk_transportadora: int
    fk_localizacao_origem: int
    fk_localizacao_destino: int
    peso_total_kg: float
    volume_total_m3: Optional[float] = None
    distancia_km: Optional[float] = None
    valor_frete: float
    prazo_entrega_dias: Optional[int] = None
    status_frete: StatusFrete = StatusFrete.aguardando
    dias_atraso: Optional[int] = None
    houve_avaria: bool = False


class FreteUpdateBody(BaseModel):
    status_frete: StatusFrete
    dias_atraso: Optional[int] = None
    houve_avaria: bool = False
    fk_transportadora: int
    peso_total_kg: float
    valor_frete: float
    prazo_entrega_dias: Optional[int] = None


class TransportadoraBody(BaseModel):
    nome_transportadora: str
    cnpj: Optional[str] = None
    telefone: Optional[str] = None
    media_entrega: int = 7
    frete_kg_base: Optional[float] = None
    adicional_volume: Optional[float] = None
    ativo: bool = True


# ─────────────────────────────────────────────
# Analytics
# ─────────────────────────────────────────────

@router.get("/kpis")
def kpis():
    try:
        return analytics.get_kpis()
    except Exception as e:
        raise HTTPException(500, str(e))


@router.get("/movimentacoes-por-dia")
def movimentacoes_por_dia(ano: int | None = Query(None), mes: int | None = Query(None, ge=1, le=12)):
    try:
        return analytics.get_movimentacoes_por_dia(ano=ano, mes=mes)
    except Exception as e:
        raise HTTPException(500, str(e))


@router.get("/performance-transportadoras")
def performance_transportadoras(ano: int | None = Query(None), mes: int | None = Query(None, ge=1, le=12)):
    try:
        return analytics.get_performance_transportadoras(ano=ano, mes=mes)
    except Exception as e:
        raise HTTPException(500, str(e))


@router.get("/skus-ponto-critico")
def skus_ponto_critico():
    try:
        return analytics.get_skus_ponto_critico()
    except Exception as e:
        raise HTTPException(500, str(e))


@router.get("/calor-movimentacao")
def calor_movimentacao(ano: int | None = Query(None), mes: int | None = Query(None, ge=1, le=12)):
    try:
        return analytics.get_calor_movimentacao(ano=ano, mes=mes)
    except Exception as e:
        raise HTTPException(500, str(e))


# ─────────────────────────────────────────────
# Saldos SKUs
# ─────────────────────────────────────────────

@router.get("/saldos")
def listar_saldos(page: int = Query(1, ge=1), page_size: int = Query(20, ge=1, le=100)):
    try:
        return analytics.listar_saldos(page, page_size)
    except Exception as e:
        raise HTTPException(500, str(e))


# ─────────────────────────────────────────────
# CRUD — Movimentações
# ─────────────────────────────────────────────

@router.get("/tipos-movimentacao")
def tipos_movimentacao():
    try:
        return analytics.get_tipos_movimentacao()
    except Exception as e:
        raise HTTPException(500, str(e))


@router.get("/movimentacoes")
def listar_movimentacoes(page: int = Query(1, ge=1), page_size: int = Query(20, ge=1, le=100)):
    try:
        return analytics.listar_movimentacoes(page, page_size)
    except Exception as e:
        raise HTTPException(500, str(e))


@router.get("/movimentacoes/{id}")
def buscar_movimentacao(id: int):
    return analytics.buscar_movimentacao(id)


@router.post("/movimentacoes", status_code=201)
def criar_movimentacao(body: MovimentacaoBody):
    try:
        return analytics.criar_movimentacao(body)
    except HTTPException:
        raise
    except Exception as e:
        raise HTTPException(500, str(e))


@router.delete("/movimentacoes/{id}")
def deletar_movimentacao(id: int):
    return analytics.deletar_movimentacao(id)


# ─────────────────────────────────────────────
# CRUD — Fretes
# ─────────────────────────────────────────────

@router.get("/fretes")
def listar_fretes(page: int = Query(1, ge=1), page_size: int = Query(20, ge=1, le=100)):
    try:
        return analytics.listar_fretes(page, page_size)
    except Exception as e:
        raise HTTPException(500, str(e))


@router.get("/fretes/{id}")
def buscar_frete(id: int):
    return analytics.buscar_frete(id)


@router.post("/fretes", status_code=201)
def criar_frete(body: FreteBody):
    try:
        return analytics.criar_frete(body)
    except Exception as e:
        raise HTTPException(500, str(e))


@router.put("/fretes/{id}")
def atualizar_frete(id: int, body: FreteUpdateBody):
    return analytics.atualizar_frete(id, body)


@router.delete("/fretes/{id}")
def deletar_frete(id: int):
    return analytics.deletar_frete(id)


# ─────────────────────────────────────────────
# CRUD — Transportadoras
# ─────────────────────────────────────────────

@router.get("/transportadoras")
def listar_transportadoras():
    try:
        return analytics.listar_transportadoras()
    except Exception as e:
        raise HTTPException(500, str(e))


@router.get("/transportadoras/{id}")
def buscar_transportadora(id: int):
    return analytics.buscar_transportadora(id)


@router.post("/transportadoras", status_code=201)
def criar_transportadora(body: TransportadoraBody):
    try:
        return analytics.criar_transportadora(body)
    except Exception as e:
        raise HTTPException(500, str(e))


@router.put("/transportadoras/{id}")
def atualizar_transportadora(id: int, body: TransportadoraBody):
    return analytics.atualizar_transportadora(id, body)


@router.delete("/transportadoras/{id}")
def deletar_transportadora(id: int):
    return analytics.deletar_transportadora(id)
