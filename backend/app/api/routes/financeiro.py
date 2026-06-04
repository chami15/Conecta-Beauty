from typing import Optional
from datetime import date
from enum import Enum
from fastapi import APIRouter, HTTPException, Query
from pydantic import BaseModel
from app.api.analytics import financeiro as analytics

router = APIRouter(prefix="/api/financeiro", tags=["Financeiro"])


# ─────────────────────────────────────────────
# Schemas (Pydantic)
# ─────────────────────────────────────────────

class TipoTransacao(str, Enum):
    credito = "Credito"
    debito  = "Debito"


class StatusTransacao(str, Enum):
    prevista   = "Prevista"
    confirmada = "Confirmada"
    paga       = "Paga"
    cancelada  = "Cancelada"


class FormaPagamentoEnum(str, Enum):
    debito        = "Débito"
    credito       = "Crédito"
    pix           = "PIX"
    boleto        = "Boleto"
    dinheiro      = "Dinheiro"
    transferencia = "Transferência"


class TransacaoBody(BaseModel):
    numero_transacao:      int
    data_pagamento:        Optional[date] = None
    fk_forma_pagamento:    Optional[int] = None
    tipo_transacao:        TipoTransacao
    valor_total_transacao: float
    status_transacao:      StatusTransacao = StatusTransacao.prevista
    historico:             Optional[str] = None


class FormaPagamentoBody(BaseModel):
    forma_pagamento: FormaPagamentoEnum


# ─────────────────────────────────────────────
# Analytics
# ─────────────────────────────────────────────

@router.get("/kpis")
def kpis():
    try:
        return analytics.get_kpis()
    except Exception as e:
        raise HTTPException(500, str(e))


@router.get("/receita-vs-despesa")
def receita_vs_despesa():
    try:
        return analytics.get_receita_vs_despesa()
    except Exception as e:
        raise HTTPException(500, str(e))


@router.get("/mix-pagamento")
def mix_pagamento():
    try:
        return analytics.get_mix_pagamento()
    except Exception as e:
        raise HTTPException(500, str(e))


# ─────────────────────────────────────────────
# CRUD — Transações
# ─────────────────────────────────────────────

@router.get("/transacoes")
def listar_transacoes(page: int = Query(1, ge=1), page_size: int = Query(20, ge=1, le=100)):
    try:
        return analytics.listar_transacoes(page, page_size)
    except Exception as e:
        raise HTTPException(500, str(e))


@router.get("/a-receber")
def a_receber(page: int = Query(1, ge=1), page_size: int = Query(20, ge=1, le=100)):
    try:
        return analytics.listar_a_receber(page, page_size)
    except Exception as e:
        raise HTTPException(500, str(e))


@router.get("/a-pagar")
def a_pagar(page: int = Query(1, ge=1), page_size: int = Query(20, ge=1, le=100)):
    try:
        return analytics.listar_a_pagar(page, page_size)
    except Exception as e:
        raise HTTPException(500, str(e))


@router.get("/transacoes/{id}")
def buscar_transacao(id: int):
    return analytics.buscar_transacao(id)


@router.post("/transacoes", status_code=201)
def criar_transacao(body: TransacaoBody):
    try:
        return analytics.criar_transacao(body)
    except Exception as e:
        raise HTTPException(500, str(e))


@router.put("/transacoes/{id}")
def atualizar_transacao(id: int, body: TransacaoBody):
    return analytics.atualizar_transacao(id, body)


@router.delete("/transacoes/{id}")
def deletar_transacao(id: int):
    return analytics.deletar_transacao(id)


# ─────────────────────────────────────────────
# CRUD — Formas de Pagamento
# ─────────────────────────────────────────────

@router.get("/formas-pagamento")
def listar_formas_pagamento():
    try:
        return analytics.listar_formas_pagamento()
    except Exception as e:
        raise HTTPException(500, str(e))


@router.get("/formas-pagamento/{id}")
def buscar_forma_pagamento(id: int):
    return analytics.buscar_forma_pagamento(id)


@router.post("/formas-pagamento", status_code=201)
def criar_forma_pagamento(body: FormaPagamentoBody):
    try:
        return analytics.criar_forma_pagamento(body)
    except Exception as e:
        raise HTTPException(500, str(e))


@router.put("/formas-pagamento/{id}")
def atualizar_forma_pagamento(id: int, body: FormaPagamentoBody):
    return analytics.atualizar_forma_pagamento(id, body)


@router.delete("/formas-pagamento/{id}")
def deletar_forma_pagamento(id: int):
    return analytics.deletar_forma_pagamento(id)
