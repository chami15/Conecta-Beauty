-- Queries de apoio para os scripts de geracao de dados sinteticos (scripts/seed/)
-- Nao sao usadas pela aplicacao em tempo de execucao.

--QUERY: produtos_ativos
SELECT id_produto, nome_produto, descricao, custo_unitario
FROM administrativo.dim_produtos
WHERE ativo = TRUE
ORDER BY id_produto;

--QUERY: pedidos_por_mes
-- Volume mensal de pedidos ja existentes no ERP: o gerador distribui as datas dos
-- pedidos dos canais externos na mesma proporcao (mesmo crescimento e sazonalidade).
SELECT EXTRACT(YEAR FROM data_hora_pedido)::int AS ano,
       EXTRACT(MONTH FROM data_hora_pedido)::int AS mes,
       COUNT(*) AS pedidos
FROM financeiro.fato_pedido
WHERE data_hora_pedido >= %s AND data_hora_pedido < %s
GROUP BY 1, 2
ORDER BY 1, 2;
