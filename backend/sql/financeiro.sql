-- ===================== KPIs =====================

--QUERY: kpis
SELECT
    COALESCE(SUM(CASE WHEN tipo_transacao = 'Credito'
                AND status_transacao IN ('Confirmada', 'Paga')
                THEN valor_total_transacao ELSE 0 END), 0) AS receita,
    COALESCE(SUM(CASE WHEN tipo_transacao = 'Debito'
                AND status_transacao IN ('Confirmada', 'Paga')
                THEN valor_total_transacao ELSE 0 END), 0) AS despesas,
    COALESCE(SUM(CASE WHEN tipo_transacao = 'Credito'
                AND status_transacao = 'Prevista'
                THEN valor_total_transacao ELSE 0 END), 0) AS valor_inadimplente,
    COUNT(CASE WHEN tipo_transacao = 'Credito'
               AND status_transacao = 'Prevista' THEN 1 END)      AS qtd_inadimplente,
    NULLIF(COUNT(CASE WHEN tipo_transacao = 'Credito' THEN 1 END), 0) AS total_creditos
FROM financeiro.fato_transacao_financeira;

-- ===================== GRÁFICOS =====================

--QUERY: receita_vs_despesa_mensal
SELECT
    t.ano,
    t.mes,
    t.nome_mes,
    COALESCE(SUM(CASE WHEN tf.tipo_transacao = 'Credito'
                THEN tf.valor_total_transacao ELSE 0 END), 0) AS receita,
    COALESCE(SUM(CASE WHEN tf.tipo_transacao = 'Debito'
                THEN tf.valor_total_transacao ELSE 0 END), 0) AS despesas
FROM financeiro.fato_transacao_financeira tf
JOIN geral.dim_tempo t ON tf.fk_data_pagamento = t.id_tempo
WHERE tf.status_transacao IN ('Confirmada', 'Paga')
GROUP BY t.ano, t.mes, t.nome_mes
ORDER BY t.ano, t.mes;

--QUERY: mix_forma_pagamento
SELECT
    fp.forma_pagamento,
    COUNT(*) AS qtd_transacoes,
    SUM(v.valor_total) AS faturamento
FROM financeiro.fato_venda v
JOIN financeiro.dim_forma_pagamento fp ON v.fk_forma_pagamento = fp.id_forma_pagamento
GROUP BY fp.forma_pagamento
ORDER BY faturamento DESC;

-- ===================== CRUD TRANSAÇÕES =====================

--QUERY: listar_transacoes
SELECT tf.id_transacao, 
       tf.numero_transacao, 
       tf.tipo_transacao,
       tf.valor_total_transacao, 
       tf.status_transacao, 
       tf.historico,
       tf.data_hora_lancamento,
       fp.forma_pagamento,
       t.data AS data_pagamento
FROM financeiro.fato_transacao_financeira tf
LEFT JOIN financeiro.dim_forma_pagamento fp ON tf.fk_forma_pagamento = fp.id_forma_pagamento
LEFT JOIN geral.dim_tempo t ON tf.fk_data_pagamento  = t.id_tempo
ORDER BY tf.data_hora_lancamento DESC
LIMIT %s OFFSET %s;

--QUERY: total_transacoes
SELECT COUNT(*) AS total FROM financeiro.fato_transacao_financeira;

--QUERY: listar_a_receber
SELECT tf.id_transacao, 
       tf.numero_transacao, 
       tf.valor_total_transacao,
       tf.status_transacao, 
       tf.historico, 
       tf.data_hora_lancamento,
       fp.forma_pagamento,
       t.data AS data_pagamento
FROM financeiro.fato_transacao_financeira tf
LEFT JOIN financeiro.dim_forma_pagamento fp ON tf.fk_forma_pagamento = fp.id_forma_pagamento
LEFT JOIN geral.dim_tempo t ON tf.fk_data_pagamento  = t.id_tempo
WHERE tf.tipo_transacao = 'Credito'
  AND tf.status_transacao IN ('Prevista', 'Confirmada')
ORDER BY t.data
LIMIT %s OFFSET %s;

--QUERY: total_a_receber
SELECT COUNT(*) AS total
FROM financeiro.fato_transacao_financeira
WHERE tipo_transacao = 'Credito' AND status_transacao IN ('Prevista', 'Confirmada');

--QUERY: listar_a_pagar
SELECT tf.id_transacao, 
       tf.numero_transacao, 
       tf.valor_total_transacao,
       tf.status_transacao, 
       tf.historico, 
       tf.data_hora_lancamento,
       fp.forma_pagamento,
       t.data AS data_pagamento
FROM financeiro.fato_transacao_financeira tf
LEFT JOIN financeiro.dim_forma_pagamento fp ON tf.fk_forma_pagamento = fp.id_forma_pagamento
LEFT JOIN geral.dim_tempo t                 ON tf.fk_data_pagamento  = t.id_tempo
WHERE tf.tipo_transacao = 'Debito'
  AND tf.status_transacao IN ('Prevista', 'Confirmada')
ORDER BY t.data
LIMIT %s OFFSET %s;

--QUERY: total_a_pagar
SELECT COUNT(*) AS total
FROM financeiro.fato_transacao_financeira
WHERE tipo_transacao = 'Debito' AND status_transacao IN ('Prevista', 'Confirmada');

--QUERY: buscar_transacao
SELECT tf.id_transacao, 
       tf.numero_transacao, 
       tf.tipo_transacao,
       tf.valor_total_transacao, 
       tf.status_transacao, 
       tf.historico,
       tf.data_hora_lancamento, 
       tf.fk_forma_pagamento,
       fp.forma_pagamento,
       t.data AS data_pagamento
FROM financeiro.fato_transacao_financeira tf
LEFT JOIN financeiro.dim_forma_pagamento fp ON tf.fk_forma_pagamento = fp.id_forma_pagamento
LEFT JOIN geral.dim_tempo t                 ON tf.fk_data_pagamento  = t.id_tempo
WHERE tf.id_transacao = %s;

--QUERY: inserir_transacao
INSERT INTO financeiro.fato_transacao_financeira
    (numero_transacao, fk_data_pagamento, fk_forma_pagamento,
     tipo_transacao, valor_total_transacao, status_transacao, historico)
VALUES (
    %s,
    (SELECT id_tempo FROM geral.dim_tempo WHERE data = %s),
    %s, %s, %s, %s, %s
)
RETURNING id_transacao;

--QUERY: atualizar_transacao
UPDATE financeiro.fato_transacao_financeira
SET numero_transacao = %s,
    fk_data_pagamento = (SELECT id_tempo FROM geral.dim_tempo WHERE data = %s),
    fk_forma_pagamento = %s,
    tipo_transacao = %s,
    valor_total_transacao = %s,
    status_transacao = %s,
    historico = %s
WHERE id_transacao = %s
RETURNING id_transacao;

--QUERY: deletar_transacao
DELETE FROM financeiro.fato_transacao_financeira WHERE id_transacao = %s RETURNING id_transacao;

-- ===================== CRUD FORMAS DE PAGAMENTO =====================

--QUERY: listar_formas_pagamento
SELECT id_forma_pagamento, 
       forma_pagamento
FROM financeiro.dim_forma_pagamento
ORDER BY id_forma_pagamento;

--QUERY: buscar_forma_pagamento
SELECT id_forma_pagamento, 
       forma_pagamento
FROM financeiro.dim_forma_pagamento
WHERE id_forma_pagamento = %s;

--QUERY: inserir_forma_pagamento
INSERT INTO financeiro.dim_forma_pagamento (forma_pagamento)
VALUES (%s)
RETURNING id_forma_pagamento;

--QUERY: atualizar_forma_pagamento
UPDATE financeiro.dim_forma_pagamento
SET forma_pagamento = %s
WHERE id_forma_pagamento = %s
RETURNING id_forma_pagamento;

--QUERY: deletar_forma_pagamento
DELETE FROM financeiro.dim_forma_pagamento WHERE id_forma_pagamento = %s RETURNING id_forma_pagamento;
