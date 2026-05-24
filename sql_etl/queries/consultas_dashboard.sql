-- FATURAMENTO MENSAL
SELECT

    ano,
    mes,
    faturamento

FROM analytics.cubo_vendas;

-- TOP PRODUTOS
SELECT

    nome_produto,

    SUM(total_vendido) AS vendas

FROM analytics.cubo_vendas

GROUP BY nome_produto

ORDER BY vendas DESC;

-- FATURAMENTO POR ESTADO
SELECT

    estado,

    SUM(faturamento) AS total

FROM analytics.cubo_vendas

GROUP BY estado

ORDER BY total DESC;