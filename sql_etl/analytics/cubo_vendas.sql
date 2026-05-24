CREATE MATERIALIZED VIEW analytics.cubo_vendas AS

SELECT

    dt.ano,

    dt.mes,

    dc.estado,

    dp.nome_produto,

    SUM(fv.valor_total) AS faturamento,

    SUM(fv.quantidade) AS total_vendido

FROM financeiro.fato_vendas fv

JOIN geral.dim_cliente dc
    ON fv.sk_cliente = dc.sk_cliente

JOIN geral.dim_produto dp
    ON fv.sk_produto = dp.sk_produto

JOIN geral.dim_tempo dt
    ON fv.sk_tempo = dt.sk_tempo

GROUP BY

    dt.ano,
    dt.mes,
    dc.estado,
    dp.nome_produto;