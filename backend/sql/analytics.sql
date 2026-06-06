-- ===================== INÍCIO — Tendência =====================

--QUERY: faturamento_mensal
SELECT t.ano, 
       t.mes, 
       t.nome_mes,
       SUM(v.valor_total) AS faturamento
FROM financeiro.fato_venda v
JOIN geral.dim_tempo t ON v.fk_tempo = t.id_tempo
GROUP BY t.ano, t.mes, t.nome_mes
ORDER BY t.ano, t.mes;

-- ===================== INÍCIO — Distribuição de vendas =====================

--QUERY: valores_vendas_individuais
SELECT v.valor_total
FROM financeiro.fato_venda v
ORDER BY v.valor_total;

-- ===================== FINANCEIRO — ANOVA Trimestres =====================

--QUERY: faturamento_mensal_por_trimestre
SELECT t.ano, 
       t.trimestre, 
       t.mes,
       SUM(v.valor_total) AS faturamento
FROM financeiro.fato_venda v
JOIN geral.dim_tempo t ON v.fk_tempo = t.id_tempo
GROUP BY t.ano, t.trimestre, t.mes
ORDER BY t.ano, t.trimestre, t.mes;

-- ===================== FINANCEIRO — Intervalo de Confiança =====================
-- (reutiliza faturamento_mensal)

-- ===================== ADMIN — ANOVA Canais =====================

--QUERY: faturamento_mensal_por_canal
SELECT cv.canal_venda, 
       t.ano, 
       t.mes,
       SUM(v.valor_total) AS faturamento
FROM financeiro.fato_venda v
JOIN geral.dim_tempo t ON v.fk_tempo = t.id_tempo
JOIN administrativo.dim_canal_venda cv ON v.fk_canal_venda = cv.id_canal_venda
GROUP BY cv.canal_venda, t.ano, t.mes
ORDER BY cv.canal_venda, t.ano, t.mes;

-- ===================== ESTOQUE — Correlação =====================

--QUERY: estoque_vs_vendas_mensal
WITH vendas_mes AS (
    SELECT v.fk_produto, 
           t.ano,
           t.mes,
           SUM(v.quantidade) AS qtd_vendida
    FROM financeiro.fato_venda v
    JOIN geral.dim_tempo t ON v.fk_tempo = t.id_tempo
    GROUP BY v.fk_produto, t.ano, t.mes
),
estoque_mes AS (
    SELECT m.fk_produto, 
           t.ano, 
           t.mes,
           AVG(m.saldo_atual) AS estoque_medio
    FROM estoque.fato_movimentacao_estoque m
    JOIN geral.dim_tempo t ON m.fk_tempo = t.id_tempo
    GROUP BY m.fk_produto, t.ano, t.mes
)
SELECT p.nome_produto,
       vm.ano, 
       vm.mes,
       vm.qtd_vendida,
       COALESCE(em.estoque_medio, 0) AS estoque_medio
FROM vendas_mes vm
JOIN administrativo.dim_produtos p ON vm.fk_produto = p.id_produto
LEFT JOIN estoque_mes em ON vm.fk_produto = em.fk_produto
                        AND vm.ano = em.ano
                        AND vm.mes = em.mes
ORDER BY p.nome_produto, vm.ano, vm.mes;

-- ===================== ESTOQUE — Descritivas por Produto =====================

--QUERY: vendas_por_produto_detalhe
SELECT p.nome_produto,
       v.quantidade,
       v.valor_unitario,
       v.valor_total
FROM financeiro.fato_venda v
JOIN administrativo.dim_produtos p ON v.fk_produto = p.id_produto
ORDER BY p.nome_produto;
