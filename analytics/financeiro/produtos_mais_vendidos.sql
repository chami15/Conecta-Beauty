SELECT

    p.nome_produto,

    SUM(v.quantidade) AS total_vendido

FROM financeiro.vendas v

JOIN estoque.produtos p
    ON v.fk_produto = p.id_produto

GROUP BY
    p.nome_produto

ORDER BY
    total_vendido DESC;