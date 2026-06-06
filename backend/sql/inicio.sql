--QUERY: total_faturamento
SELECT COALESCE(SUM(valor_total), 0) AS total_faturamento
FROM financeiro.fato_venda;

--QUERY: total_pedidos
SELECT COUNT(DISTINCT numero_pedido) AS total_pedidos
FROM financeiro.fato_venda;

--QUERY: ticket_medio
SELECT COALESCE(
    SUM(valor_total) / NULLIF(COUNT(DISTINCT numero_pedido), 0),
    0
) AS ticket_medio
FROM financeiro.fato_venda;

--QUERY: clientes_ativos
SELECT COUNT(DISTINCT fk_cliente) AS clientes_ativos
FROM financeiro.fato_venda;

--QUERY: faturamento_diario
SELECT
    t.data,
    COALESCE(SUM(v.valor_total), 0) AS faturamento
FROM geral.dim_tempo t
JOIN financeiro.fato_venda v ON v.fk_tempo = t.id_tempo
WHERE t.data >= CURRENT_DATE - INTERVAL '30 days'
GROUP BY t.data
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
    SUM(v.quantidade) AS qtd_vendida,
    SUM(v.valor_total) AS faturamento
FROM financeiro.fato_venda v
JOIN administrativo.dim_produtos p ON v.fk_produto = p.id_produto
GROUP BY p.nome_produto
ORDER BY faturamento DESC
LIMIT 5;

--QUERY: saude_vendas
SELECT
    COALESCE(SUM(CASE WHEN t.data >= CURRENT_DATE - INTERVAL '30 days'
                 THEN v.valor_total ELSE 0 END), 0) AS faturamento_atual,
    COALESCE(SUM(CASE WHEN t.data BETWEEN CURRENT_DATE - INTERVAL '60 days'
                AND CURRENT_DATE - INTERVAL '31 days'
                THEN v.valor_total ELSE 0 END), 0) AS faturamento_anterior
FROM financeiro.fato_venda v
JOIN geral.dim_tempo t ON v.fk_tempo = t.id_tempo;

--QUERY: saude_margem
SELECT
    COALESCE(SUM(CASE WHEN tipo_transacao = 'Credito' THEN valor_total_transacao ELSE 0 END), 0) AS receitas,
    COALESCE(SUM(CASE WHEN tipo_transacao = 'Debito'  THEN valor_total_transacao ELSE 0 END), 0) AS despesas
FROM financeiro.fato_transacao_financeira
WHERE status_transacao IN ('Confirmada', 'Paga');

--QUERY: saude_estoque
SELECT
    COUNT(*) AS total_skus,
    COUNT(CASE WHEN p.estoque_min > 0
                AND COALESCE(m.saldo_atual, 0) <= p.estoque_min
               THEN 1 END) AS skus_em_alerta
FROM administrativo.dim_produtos p
LEFT JOIN (
    SELECT DISTINCT ON (fk_produto)
        fk_produto,
        saldo_atual
    FROM estoque.fato_movimentacao_estoque
    ORDER BY fk_produto, id_movimentacao DESC
) m ON p.id_produto = m.fk_produto
WHERE p.ativo = TRUE;

--QUERY: saude_inadimplencia
SELECT
    COUNT(CASE WHEN status_transacao = 'Prevista' THEN 1 END) AS previstas,
    COUNT(*) AS total
FROM financeiro.fato_transacao_financeira
WHERE tipo_transacao = 'Credito';

--QUERY: saude_logistica
SELECT
    COUNT(*) AS total_fretes,
    COUNT(CASE WHEN status_frete = 'Entregue'
                AND (dias_atraso IS NULL OR dias_atraso <= 0) THEN 1 END) AS no_prazo
FROM estoque.fato_pedido_frete;
