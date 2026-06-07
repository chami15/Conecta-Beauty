from utils.query_executor import executar_query


def _time_params(ano=None, mes=None):
    return (ano, ano, mes, mes)


def get_kpis(ano=None, mes=None) -> dict:
    params = _time_params(ano, mes)
    faturamento = executar_query("inicio:total_faturamento", params=params)
    pedidos = executar_query("inicio:total_pedidos", params=params)
    ticket = executar_query("inicio:ticket_medio", params=params)
    clientes = executar_query("inicio:clientes_ativos", params=params)

    return {
        "faturamento_total": float(faturamento[0]["total_faturamento"]) if faturamento else 0.0,
        "total_pedidos": int(pedidos[0]["total_pedidos"]) if pedidos else 0,
        "ticket_medio": float(ticket[0]["ticket_medio"]) if ticket else 0.0,
        "clientes_ativos": int(clientes[0]["clientes_ativos"]) if clientes else 0,
    }


def get_faturamento_diario(ano=None, mes=None) -> list:
    rows = executar_query("inicio:faturamento_diario", params=_time_params(ano, mes))
    return [
        {"data": str(r["data"]), "faturamento": float(r["faturamento"])}
        for r in rows
    ]


def get_pedidos_por_status(ano=None, mes=None) -> list:
    rows = executar_query("inicio:pedidos_por_status", params=_time_params(ano, mes))
    return [
        {"status": r["status_pedido"], "quantidade": int(r["quantidade"])}
        for r in rows
    ]


def get_top5_produtos(ano=None, mes=None) -> list:
    rows = executar_query("inicio:top5_produtos", params=_time_params(ano, mes))
    return [
        {
            "produto": r["nome_produto"],
            "qtd_vendida": int(r["qtd_vendida"]),
            "faturamento": float(r["faturamento"]),
        }
        for r in rows
    ]


def get_saude_empresa() -> dict:
    # --- Vendas: tendência últimos 30 dias vs 30 dias anteriores ---
    vendas = executar_query("inicio:saude_vendas")
    fat_atual = float(vendas[0]["faturamento_atual"]) if vendas else 0.0
    fat_anterior = float(vendas[0]["faturamento_anterior"]) if vendas else 0.0

    if fat_anterior > 0:
        score_vendas = min(100.0, (fat_atual / fat_anterior) * 100)
    else:
        score_vendas = 100.0 if fat_atual > 0 else 50.0

    # --- Margem: (receita - despesa) / receita ---
    margem_row = executar_query("inicio:saude_margem")
    receitas = float(margem_row[0]["receitas"]) if margem_row else 0.0
    despesas = float(margem_row[0]["despesas"]) if margem_row else 0.0

    if receitas > 0:
        margem_pct = ((receitas - despesas) / receitas) * 100
        score_margem = min(100.0, max(0.0, margem_pct * 3))  # 33% margem → 100
    else:
        score_margem = 0.0

    # --- Estoque: SKUs acima do estoque mínimo ---
    estoque_row = executar_query("inicio:saude_estoque")
    total_skus = int(estoque_row[0]["total_skus"]) if estoque_row else 0
    skus_alerta = int(estoque_row[0]["skus_em_alerta"]) if estoque_row else 0

    score_estoque = ((total_skus - skus_alerta) / total_skus * 100) if total_skus > 0 else 100.0

    # --- Inadimplência: transações de crédito ainda Previstas ---
    inadimp_row = executar_query("inicio:saude_inadimplencia")
    previstas = int(inadimp_row[0]["previstas"]) if inadimp_row else 0
    total_rec = int(inadimp_row[0]["total"]) if inadimp_row else 0

    score_inadimplencia = ((total_rec - previstas) / total_rec * 100) if total_rec > 0 else 100.0

    # --- Logística: fretes entregues no prazo ---
    log_row = executar_query("inicio:saude_logistica")
    total_fretes = int(log_row[0]["total_fretes"]) if log_row else 0
    no_prazo = int(log_row[0]["no_prazo"]) if log_row else 0

    score_logistica = (no_prazo / total_fretes * 100) if total_fretes > 0 else 100.0

    score_geral = (
        score_vendas * 0.25 +
        score_margem * 0.25 +
        score_estoque * 0.20 +
        score_inadimplencia * 0.15 +
        score_logistica * 0.15
    )

    return {
        "score_geral": round(score_geral, 1),
        "componentes": {
            "vendas": round(score_vendas, 1),
            "margem": round(score_margem, 1),
            "estoque": round(score_estoque, 1),
            "inadimplencia": round(score_inadimplencia, 1),
            "logistica": round(score_logistica, 1),
        },
    }
