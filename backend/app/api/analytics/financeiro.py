from fastapi import HTTPException
from utils.query_executor import executar_query


# ─────────────────────────────────────────────
# Analytics
# ─────────────────────────────────────────────

def get_kpis() -> dict:
    rows = executar_query("financeiro:kpis")
    if not rows:
        return {"receita": 0, "despesas": 0, "resultado_liquido": 0, "inadimplencia_pct": 0, "valor_inadimplente": 0}

    r = rows[0]
    receita = float(r["receita"])
    despesas = float(r["despesas"])
    valor_inadimplente = float(r["valor_inadimplente"])
    qtd_inadimplente = int(r["qtd_inadimplente"])
    total_creditos = int(r["total_creditos"]) if r["total_creditos"] else 0

    inadimplencia_pct = round((qtd_inadimplente / total_creditos * 100), 1) if total_creditos > 0 else 0.0

    return {
        "receita": receita,
        "despesas": despesas,
        "resultado_liquido": round(receita - despesas, 2),
        "inadimplencia_pct": inadimplencia_pct,
        "valor_inadimplente": valor_inadimplente,
    }


def get_receita_vs_despesa() -> list:
    rows = executar_query("financeiro:receita_vs_despesa_mensal")
    return [
        {
            "ano": r["ano"],
            "mes": r["mes"],
            "nome_mes": r["nome_mes"],
            "receita": float(r["receita"]),
            "despesas": float(r["despesas"]),
            "resultado": round(float(r["receita"]) - float(r["despesas"]), 2),
        }
        for r in rows
    ]


def get_mix_pagamento() -> list:
    rows = executar_query("financeiro:mix_forma_pagamento")
    total = sum(float(r["faturamento"]) for r in rows)
    return [
        {
            "forma_pagamento": r["forma_pagamento"],
            "qtd_transacoes": int(r["qtd_transacoes"]),
            "faturamento": float(r["faturamento"]),
            "percentual": round(float(r["faturamento"]) / total * 100, 1) if total > 0 else 0,
        }
        for r in rows
    ]


# ─────────────────────────────────────────────
# Helpers
# ─────────────────────────────────────────────

def fmt_transacao(r: dict) -> dict:
    return {
        "id": r["id_transacao"],
        "numero_transacao": r["numero_transacao"],
        "tipo_transacao": r["tipo_transacao"],
        "valor": float(r["valor_total_transacao"]),
        "status": r["status_transacao"],
        "historico": r["historico"],
        "forma_pagamento": r["forma_pagamento"],
        "data_pagamento": str(r["data_pagamento"]) if r["data_pagamento"] else None,
        "data_hora_lancamento": str(r["data_hora_lancamento"]),
    }


# ─────────────────────────────────────────────
# CRUD — Transações
# ─────────────────────────────────────────────

def listar_transacoes(page: int = 1, page_size: int = 20) -> dict:
    offset = (page - 1) * page_size
    rows = executar_query("financeiro:listar_transacoes", params=(page_size, offset))
    total = executar_query("financeiro:total_transacoes")
    return {
        "data": [fmt_transacao(r) for r in rows],
        "total": int(total[0]["total"]) if total else 0,
        "page": page,
        "page_size": page_size,
    }


def listar_a_receber(page: int = 1, page_size: int = 20) -> dict:
    offset = (page - 1) * page_size
    rows = executar_query("financeiro:listar_a_receber", params=(page_size, offset))
    total = executar_query("financeiro:total_a_receber")
    return {
        "data": [fmt_transacao(r) for r in rows],
        "total": int(total[0]["total"]) if total else 0,
        "page": page,
        "page_size": page_size,
    }


def listar_a_pagar(page: int = 1, page_size: int = 20) -> dict:
    offset = (page - 1) * page_size
    rows = executar_query("financeiro:listar_a_pagar", params=(page_size, offset))
    total = executar_query("financeiro:total_a_pagar")
    return {
        "data": [fmt_transacao(r) for r in rows],
        "total": int(total[0]["total"]) if total else 0,
        "page": page,
        "page_size": page_size,
    }


def buscar_transacao(id: int) -> dict:
    rows = executar_query("financeiro:buscar_transacao", params=(id,))
    if not rows:
        raise HTTPException(404, "Transação não encontrada")
    return fmt_transacao(rows[0])


def criar_transacao(data) -> dict:
    rows = executar_query(
        "financeiro:inserir_transacao",
        returning=True,
        params=(
            data.numero_transacao,
            str(data.data_pagamento) if data.data_pagamento else None,
            data.fk_forma_pagamento,
            data.tipo_transacao,
            data.valor_total_transacao,
            data.status_transacao,
            data.historico,
        ),
    )
    return {"id_transacao": rows[0]["id_transacao"]}


def atualizar_transacao(id: int, data) -> dict:
    rows = executar_query(
        "financeiro:atualizar_transacao",
        returning=True,
        params=(
            data.numero_transacao,
            str(data.data_pagamento) if data.data_pagamento else None,
            data.fk_forma_pagamento,
            data.tipo_transacao,
            data.valor_total_transacao,
            data.status_transacao,
            data.historico,
            id,
        ),
    )
    if not rows:
        raise HTTPException(404, "Transação não encontrada")
    return {"id_transacao": rows[0]["id_transacao"]}


def deletar_transacao(id: int) -> dict:
    try:
        rows = executar_query("financeiro:deletar_transacao", returning=True, params=(id,))
        if not rows:
            raise HTTPException(404, "Transação não encontrada")
        return {"deleted": True, "id_transacao": id}
    except HTTPException:
        raise
    except Exception:
        raise HTTPException(409, "Não é possível excluir: transação possui registros vinculados")


# ─────────────────────────────────────────────
# CRUD — Formas de Pagamento
# ─────────────────────────────────────────────

def listar_formas_pagamento() -> list:
    rows = executar_query("financeiro:listar_formas_pagamento")
    return [{"id": r["id_forma_pagamento"], "forma_pagamento": r["forma_pagamento"]} for r in rows]


def buscar_forma_pagamento(id: int) -> dict:
    rows = executar_query("financeiro:buscar_forma_pagamento", params=(id,))
    if not rows:
        raise HTTPException(404, "Forma de pagamento não encontrada")
    return {"id": rows[0]["id_forma_pagamento"], "forma_pagamento": rows[0]["forma_pagamento"]}


def criar_forma_pagamento(data) -> dict:
    rows = executar_query(
        "financeiro:inserir_forma_pagamento",
        returning=True,
        params=(data.forma_pagamento,),
    )
    return {"id_forma_pagamento": rows[0]["id_forma_pagamento"]}


def atualizar_forma_pagamento(id: int, data) -> dict:
    rows = executar_query(
        "financeiro:atualizar_forma_pagamento",
        returning=True,
        params=(data.forma_pagamento, id),
    )
    if not rows:
        raise HTTPException(404, "Forma de pagamento não encontrada")
    return {"id_forma_pagamento": rows[0]["id_forma_pagamento"]}


def deletar_forma_pagamento(id: int) -> dict:
    try:
        rows = executar_query("financeiro:deletar_forma_pagamento", returning=True, params=(id,))
        if not rows:
            raise HTTPException(404, "Forma de pagamento não encontrada")
        return {"deleted": True, "id_forma_pagamento": id}
    except HTTPException:
        raise
    except Exception:
        raise HTTPException(409, "Não é possível excluir: forma de pagamento possui registros vinculados")
