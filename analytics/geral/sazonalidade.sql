SELECT

    dt.mes,

    SUM(v.valor_total) AS faturamento

FROM financeiro.vendas v

JOIN geral.dim_tempo dt
    ON v.data_venda = dt.data_completa

GROUP BY
    dt.mes

ORDER BY
    dt.mes;