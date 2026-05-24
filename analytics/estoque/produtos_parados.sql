SELECT

    p.nome_produto,

    p.quantidade_estoque

FROM estoque.produtos p

LEFT JOIN financeiro.vendas v
    ON p.id_produto = v.fk_produto

WHERE v.fk_produto IS NULL;