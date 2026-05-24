SELECT

    nome_produto,

    quantidade_estoque

FROM estoque.produtos

WHERE quantidade_estoque < 5

ORDER BY quantidade_estoque;