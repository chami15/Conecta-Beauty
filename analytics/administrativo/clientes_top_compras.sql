SELECT

    c.nome_cliente,

    SUM(v.valor_total) AS total_gasto

FROM administrativo.clientes c

JOIN financeiro.vendas v
    ON c.id_cliente = v.fk_cliente

GROUP BY
    c.nome_cliente

ORDER BY
    total_gasto DESC;