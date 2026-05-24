SELECT

    ROUND(
        AVG(valor_total),
        2
    ) AS ticket_medio

FROM financeiro.vendas;