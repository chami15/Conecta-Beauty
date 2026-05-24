SELECT

    EXTRACT(YEAR FROM data_venda) AS ano,

    EXTRACT(MONTH FROM data_venda) AS mes,

    SUM(valor_total) AS faturamento_total

FROM financeiro.vendas

GROUP BY
    ano,
    mes

ORDER BY
    ano,
    mes;