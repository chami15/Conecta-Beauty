from fastapi import HTTPException
from utils.query_executor import executar_query


# ─────────────────────────────────────────────
# Analytics
# ─────────────────────────────────────────────

def get_kpis() -> dict:
    kpi = executar_query("estoque:kpis")
    giro = executar_query("estoque:giro_medio")

    r = kpi[0] if kpi else {}
    return {
        "total_skus": int(r.get("total_skus", 0)),
        "itens_em_estoque": int(r.get("itens_em_estoque", 0)),
        "valor_em_estoque": round(float(r.get("valor_em_estoque", 0)), 2),
        "skus_em_alerta": int(r.get("skus_em_alerta", 0)),
        "giro_medio": float(giro[0]["giro_medio"]) if giro and giro[0]["giro_medio"] else 0.0,
    }


def get_movimentacoes_por_dia() -> list:
    rows = executar_query("estoque:movimentacoes_por_dia")
    return [
        {
            "data": str(r["data"]),
            "entradas": int(r["entradas"]),
            "saidas": int(r["saidas"]),
        }
        for r in rows
    ]


def get_performance_transportadoras() -> list:
    rows = executar_query("estoque:performance_transportadoras")
    return [
        {
            "transportadora": r["nome_transportadora"],
            "qtd_fretes": int(r["qtd_fretes"]),
            "frete_medio": float(r["frete_medio"]) if r["frete_medio"] else 0.0,
            "prazo_medio_dias": float(r["prazo_medio_dias"]) if r["prazo_medio_dias"] else 0.0,
            "taxa_no_prazo_pct": float(r["taxa_no_prazo_pct"]) if r["taxa_no_prazo_pct"] else 0.0,
        }
        for r in rows
    ]


def get_skus_ponto_critico() -> list:
    rows = executar_query("estoque:skus_ponto_critico")
    return [
        {
            "id_produto": r["id_produto"],
            "nome_produto": r["nome_produto"],
            "estoque_min": r["estoque_min"],
            "saldo_atual": int(r["saldo_atual"]),
            "diferenca": int(r["diferenca"]),
        }
        for r in rows
    ]


def get_calor_movimentacao() -> list:
    rows = executar_query("estoque:calor_movimentacao")
    return [
        {
            "produto": r["nome_produto"],
            "ano": r["ano"],
            "mes": r["mes"],
            "nome_mes": r["nome_mes"],
            "qtd_movimentada": int(r["qtd_movimentada"]),
        }
        for r in rows
    ]


# ─────────────────────────────────────────────
# Saldos SKUs
# ─────────────────────────────────────────────

def listar_saldos(page: int = 1, page_size: int = 20) -> dict:
    offset = (page - 1) * page_size
    rows = executar_query("estoque:listar_saldos", params=(page_size, offset))
    total = executar_query("estoque:total_saldos")
    return {
        "data": [
            {
                "id_produto": r["id_produto"],
                "nome_produto": r["nome_produto"],
                "categoria": r["categoria"],
                "estoque_min": r["estoque_min"],
                "estoque_max": r["estoque_max"],
                "saldo_atual": int(r["saldo_atual"]),
                "situacao": r["situacao"],
            }
            for r in rows
        ],
        "total": int(total[0]["total"]) if total else 0,
        "page": page,
        "page_size": page_size,
    }


# ─────────────────────────────────────────────
# CRUD — Movimentações
# ─────────────────────────────────────────────

def fmt_movimentacao(r: dict) -> dict:
    return {
        "id": r["id_movimentacao"],
        "produto": r["nome_produto"],
        "fk_produto": r["fk_produto"],
        "tipo_movimentacao": r["tipo_movimentacao"],
        "natureza": r["natureza"],
        "quantidade": r["quantidade"],
        "valor_unitario": float(r["valor_unitario"]),
        "valor_total": float(r["valor_total"]),
        "saldo_anterior": r["saldo_anterior"],
        "saldo_atual": r["saldo_atual"],
        "data_movimentacao": str(r["data_movimentacao"]),
        "fornecedor": r["nome_fornecedor"],
    }


def listar_movimentacoes(page: int = 1, page_size: int = 20) -> dict:
    offset = (page - 1) * page_size
    rows = executar_query("estoque:listar_movimentacoes", params=(page_size, offset))
    total = executar_query("estoque:total_movimentacoes")
    return {
        "data": [fmt_movimentacao(r) for r in rows],
        "total": int(total[0]["total"]) if total else 0,
        "page": page,
        "page_size": page_size,
    }


def buscar_movimentacao(id: int) -> dict:
    rows = executar_query("estoque:buscar_movimentacao", params=(id,))
    if not rows:
        raise HTTPException(404, "Movimentação não encontrada")
    return fmt_movimentacao(rows[0])


def get_tipos_movimentacao() -> list:
    rows = executar_query("estoque:tipos_movimentacao")
    return [
        {"id": r["id_tipo_movimentacao"], "tipo": r["tipo_movimentacao"], "natureza": r["natureza"], "categoria": r["categoria"]}
        for r in rows
    ]


def criar_movimentacao(data) -> dict:
    # Busca saldo atual do produto
    saldo_rows = executar_query("estoque:saldo_atual_produto", params=(data.fk_produto,))
    saldo_anterior = int(saldo_rows[0]["saldo_atual"]) if saldo_rows else 0

    # Busca natureza do tipo de movimentação
    tipo_rows = executar_query("estoque:natureza_movimento", params=(data.fk_tipo_movimentacao,))
    if not tipo_rows:
        raise HTTPException(404, "Tipo de movimentação não encontrado")
    natureza = tipo_rows[0]["natureza"]

    # Calcula novo saldo
    if natureza == "ENTRADA":
        saldo_atual = saldo_anterior + data.quantidade
    else:
        saldo_atual = saldo_anterior - data.quantidade
        if saldo_atual < 0:
            raise HTTPException(422, f"Saldo insuficiente. Saldo atual: {saldo_anterior}, tentativa de saída: {data.quantidade}")

    valor_total = round(data.quantidade * data.valor_unitario, 2)

    rows = executar_query(
        "estoque:inserir_movimentacao",
        returning=True,
        params=(
            str(data.data_movimentacao),
            data.fk_produto,
            data.fk_tipo_movimentacao,
            data.fk_fornecedor,
            data.quantidade,
            data.valor_unitario,
            valor_total,
            saldo_anterior,
            saldo_atual,
        ),
    )
    return {"id_movimentacao": rows[0]["id_movimentacao"], "saldo_anterior": saldo_anterior, "saldo_atual": saldo_atual}


def deletar_movimentacao(id: int) -> dict:
    try:
        rows = executar_query("estoque:deletar_movimentacao", returning=True, params=(id,))
        if not rows:
            raise HTTPException(404, "Movimentação não encontrada")
        return {"deleted": True, "id_movimentacao": id}
    except HTTPException:
        raise
    except Exception:
        raise HTTPException(409, "Não é possível excluir esta movimentação")


# ─────────────────────────────────────────────
# CRUD — Fretes
# ─────────────────────────────────────────────

def fmt_frete(r: dict) -> dict:
    return {
        "id": r["id_frete"],
        "numero_pedido": r["numero_pedido"],
        "transportadora": r["nome_transportadora"],
        "origem": f"{r['cidade_origem']}/{r['estado_origem']}",
        "destino": f"{r['cidade_destino']}/{r['estado_destino']}",
        "peso_total_kg": float(r["peso_total_kg"]) if r["peso_total_kg"] else None,
        "valor_frete": float(r["valor_frete"]),
        "prazo_entrega_dias": r["prazo_entrega_dias"],
        "status_frete": r["status_frete"],
        "dias_atraso": r["dias_atraso"],
        "houve_avaria": r["houve_avaria"],
        "data_envio": str(r["data_envio"]) if r["data_envio"] else None,
        "data_entrega": str(r["data_entrega"]) if r["data_entrega"] else None,
    }


def listar_fretes(page: int = 1, page_size: int = 20) -> dict:
    offset = (page - 1) * page_size
    rows = executar_query("estoque:listar_fretes", params=(page_size, offset))
    total = executar_query("estoque:total_fretes")
    return {
        "data": [fmt_frete(r) for r in rows],
        "total": int(total[0]["total"]) if total else 0,
        "page": page,
        "page_size": page_size,
    }


def buscar_frete(id: int) -> dict:
    rows = executar_query("estoque:buscar_frete", params=(id,))
    if not rows:
        raise HTTPException(404, "Frete não encontrado")
    return fmt_frete(rows[0])


def criar_frete(data) -> dict:
    rows = executar_query(
        "estoque:inserir_frete",
        returning=True,
        params=(
            data.numero_pedido,
            str(data.data_envio) if data.data_envio else None,
            str(data.data_entrega) if data.data_entrega else None,
            data.fk_transportadora,
            data.fk_localizacao_origem,
            data.fk_localizacao_destino,
            data.peso_total_kg,
            data.volume_total_m3,
            data.distancia_km,
            data.valor_frete,
            data.prazo_entrega_dias,
            data.status_frete,
            data.dias_atraso,
            data.houve_avaria,
        ),
    )
    return {"id_frete": rows[0]["id_frete"]}


def atualizar_frete(id: int, data) -> dict:
    rows = executar_query(
        "estoque:atualizar_frete",
        returning=True,
        params=(
            data.status_frete,
            data.dias_atraso,
            data.houve_avaria,
            data.fk_transportadora,
            data.peso_total_kg,
            data.valor_frete,
            data.prazo_entrega_dias,
            id,
        ),
    )
    if not rows:
        raise HTTPException(404, "Frete não encontrado")
    return {"id_frete": rows[0]["id_frete"]}


def deletar_frete(id: int) -> dict:
    try:
        rows = executar_query("estoque:deletar_frete", returning=True, params=(id,))
        if not rows:
            raise HTTPException(404, "Frete não encontrado")
        return {"deleted": True, "id_frete": id}
    except HTTPException:
        raise
    except Exception:
        raise HTTPException(409, "Não é possível excluir: frete possui registros vinculados")


# ─────────────────────────────────────────────
# CRUD — Transportadoras
# ─────────────────────────────────────────────

def fmt_transportadora(r: dict) -> dict:
    return {
        "id": r["id_transportadora"],
        "nome_transportadora": r["nome_transportadora"],
        "cnpj": r["cnpj"],
        "telefone": r["telefone"],
        "media_entrega": r["media_entrega"],
        "frete_kg_base": float(r["frete_kg_base"]) if r["frete_kg_base"] else None,
        "adicional_volume": float(r["adicional_volume"]) if r["adicional_volume"] else None,
        "ativo": r["ativo"],
    }


def listar_transportadoras() -> list:
    rows = executar_query("estoque:listar_transportadoras")
    return [fmt_transportadora(r) for r in rows]


def buscar_transportadora(id: int) -> dict:
    rows = executar_query("estoque:buscar_transportadora", params=(id,))
    if not rows:
        raise HTTPException(404, "Transportadora não encontrada")
    return fmt_transportadora(rows[0])


def criar_transportadora(data) -> dict:
    rows = executar_query(
        "estoque:inserir_transportadora",
        returning=True,
        params=(data.nome_transportadora, data.cnpj, data.telefone, data.media_entrega, data.frete_kg_base, data.adicional_volume, data.ativo),
    )
    return {"id_transportadora": rows[0]["id_transportadora"]}


def atualizar_transportadora(id: int, data) -> dict:
    rows = executar_query(
        "estoque:atualizar_transportadora",
        returning=True,
        params=(data.nome_transportadora, data.cnpj, data.telefone, data.media_entrega, data.frete_kg_base, data.adicional_volume, data.ativo, id),
    )
    if not rows:
        raise HTTPException(404, "Transportadora não encontrada")
    return {"id_transportadora": rows[0]["id_transportadora"]}


def deletar_transportadora(id: int) -> dict:
    try:
        rows = executar_query("estoque:deletar_transportadora", returning=True, params=(id,))
        if not rows:
            raise HTTPException(404, "Transportadora não encontrada")
        return {"deleted": True, "id_transportadora": id}
    except HTTPException:
        raise
    except Exception:
        raise HTTPException(409, "Não é possível excluir: transportadora possui fretes vinculados")
