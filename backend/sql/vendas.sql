--QUERY: total_faturamento
SELECT
    COALESCE(SUM(valor_total), 0) AS total_faturamento
FROM financeiro.fato_venda;

--QUERY: total_pedidos
SELECT
    COUNT(DISTINCT numero_pedido) AS total_pedidos
FROM financeiro.fato_venda;

--QUERY: ticket_medio
SELECT
    COALESCE(
        SUM(valor_total) / NULLIF(COUNT(DISTINCT numero_pedido), 0),
        0
    ) AS ticket_medio
FROM financeiro.fato_venda;

--QUERY: clientes_ativos
SELECT
    COUNT(DISTINCT fk_cliente) AS clientes_ativos
FROM financeiro.fato_venda;

--QUERY: faturamento_diario
SELECT
    t.data,
    t.dia,
    t.mes,
    t.ano,
    COALESCE(SUM(v.valor_total), 0) AS faturamento
FROM geral.dim_tempo t
JOIN financeiro.fato_venda v ON v.fk_tempo = t.id_tempo
GROUP BY t.data, t.dia, t.mes, t.ano
ORDER BY t.data;

--QUERY: pedidos_por_status
SELECT
    status_pedido,
    COUNT(*) AS quantidade
FROM financeiro.fato_pedido
GROUP BY status_pedido
ORDER BY quantidade DESC;

--QUERY: top5_produtos
SELECT
    p.nome_produto,
    SUM(v.quantidade)   AS qtd_vendida,
    SUM(v.valor_total)  AS faturamento
FROM financeiro.fato_venda v
JOIN administrativo.dim_produtos p ON v.fk_produto = p.id_produto
GROUP BY p.nome_produto
ORDER BY faturamento DESC
LIMIT 5;
