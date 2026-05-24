SELECT

    f.nome_fornecedor,

    COUNT(p.id_produto) AS total_produtos

FROM administrativo.fornecedores f

JOIN estoque.produtos p
    ON f.id_fornecedor = p.fk_fornecedor

GROUP BY
    f.nome_fornecedor

ORDER BY
    total_produtos DESC;