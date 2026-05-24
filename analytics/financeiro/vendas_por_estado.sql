SELECT

    c.estado,

    SUM(v.valor_total) AS faturamento

FROM financeiro.vendas v

JOIN administrativo.clientes c
    ON v.fk_cliente = c.id_cliente

GROUP BY
    c.estado

ORDER BY
    faturamento DESC;