--QUERY: coletar_total_vendas
SELECT
    fato_vendas.sk_venda,
    fato_vendas.sk_produto,
    fato_vendas.preco_unitario
FROM
    fato_vendas;