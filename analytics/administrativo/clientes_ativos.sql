SELECT

    c.nome_cliente,

    COUNT(v.id_venda) AS total_compras

FROM administrativo.clientes c

JOIN financeiro.vendas v
    ON c.id_cliente = v.fk_cliente

GROUP BY
    c.nome_cliente

HAVING COUNT(v.id_venda) >= 1

ORDER BY
    total_compras DESC;