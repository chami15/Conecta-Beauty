-- Queries de apoio para os scripts de geracao de dados sinteticos (scripts/seed/)
-- Nao sao usadas pela aplicacao em tempo de execucao.

--QUERY: produtos_ativos
SELECT id_produto, nome_produto, descricao, custo_unitario
FROM administrativo.dim_produtos
WHERE ativo = TRUE
ORDER BY id_produto;
