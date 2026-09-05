-- Cubo 1: Vendas Completo

CREATE MATERIALIZED VIEW financeiro.cubo_vendas AS
SELECT
    -- Dimensões temporais
    t.ano,
    t.trimestre,
    t.mes,
    t.nome_mes,
    t.dia_semana,

    -- Dimensões de produto
    cat.categoria,
    cat.subcategoria,
    cat.linha_produto,
    p.nome_produto,
    f.nome_fornecedor,

    -- Dimensões de cliente/localização
    loc.regiao AS regiao_cliente,
    loc.estado AS estado_cliente,
    loc.cidade AS cidade_cliente,

    -- Dimensões comerciais
    cv.canal_venda,
    cv.tipo_canal,
    fp.forma_pagamento,

    -- Métricas agregadas
    COUNT(*) AS qtd_vendas,
    COUNT(DISTINCT v.numero_pedido) AS qtd_pedidos,
    COUNT(DISTINCT v.fk_cliente) AS qtd_clientes,
    SUM(v.quantidade) AS qtd_produtos_vendidos,
    SUM(v.valor_total) AS faturamento_total,
    AVG(v.valor_unitario) AS preco_medio,

    -- KPIs calculados
    SUM(v.valor_total) / NULLIF(COUNT(DISTINCT v.numero_pedido), 0) AS ticket_medio,
    SUM(v.valor_total) / NULLIF(COUNT(DISTINCT v.fk_cliente), 0) AS faturamento_por_cliente,
    SUM(v.quantidade) / NULLIF(COUNT(DISTINCT v.numero_pedido), 0) AS itens_por_pedido

FROM financeiro.fato_venda v
JOIN geral.dim_tempo t ON v.fk_tempo = t.id_tempo
JOIN administrativo.dim_produtos p ON v.fk_produto = p.id_produto
JOIN administrativo.dim_categoria_produto cat ON p.id_categoria = cat.id_categoria
JOIN administrativo.dim_fornecedor f ON p.id_fornecedor = f.id_fornecedor
JOIN administrativo.dim_clientes c ON v.fk_cliente = c.id_cliente
JOIN geral.dim_localizacao loc ON c.fk_localizacao = loc.id_localizacao
JOIN administrativo.dim_canal_venda cv ON v.fk_canal_venda = cv.id_canal_venda
JOIN financeiro.dim_forma_pagamento fp ON v.fk_forma_pagamento = fp.id_forma_pagamento

GROUP BY ROLLUP (
    t.ano, t.trimestre, t.mes, t.nome_mes, t.dia_semana,
    cat.categoria, cat.subcategoria, cat.linha_produto,
    p.nome_produto,
    f.nome_fornecedor,
    loc.regiao, loc.estado, loc.cidade,
    cv.canal_venda, cv.tipo_canal,
    fp.forma_pagamento
);

-- Índices para performance
CREATE INDEX idx_cubo_vendas_ano_mes ON financeiro.cubo_vendas(ano, mes);
CREATE INDEX idx_cubo_vendas_categoria ON financeiro.cubo_vendas(categoria);
CREATE INDEX idx_cubo_vendas_regiao ON financeiro.cubo_vendas(regiao_cliente);
CREATE INDEX idx_cubo_vendas_canal ON financeiro.cubo_vendas(canal_venda);
CREATE INDEX idx_cubo_vendas_fornecedor ON financeiro.cubo_vendas(nome_fornecedor);

-- Cubo 2: Estoque e Movimentações

CREATE MATERIALIZED VIEW estoque.cubo_estoque AS
SELECT
    -- Dimensões temporais
    t.ano,
    t.trimestre,
    t.mes,
    t.nome_mes,

    -- Dimensões de produto
    p.nome_produto,
    cat.categoria,
    cat.subcategoria,
    cat.linha_produto,
    f.nome_fornecedor,

    -- Dimensões de movimentação
    tm.tipo_movimentacao,
    tm.natureza,
    tm.categoria AS categoria_movimento,

    -- Métricas agregadas
    COUNT(*) AS qtd_movimentacoes,
    SUM(CASE WHEN tm.natureza = 'ENTRADA' THEN m.quantidade ELSE 0 END) AS qtd_entradas,
    SUM(CASE WHEN tm.natureza = 'SAÍDA' THEN m.quantidade ELSE 0 END) AS qtd_saidas,
    SUM(CASE WHEN tm.natureza = 'ENTRADA' THEN m.valor_total ELSE 0 END) AS valor_entradas,
    SUM(CASE WHEN tm.natureza = 'SAÍDA' THEN m.valor_total ELSE 0 END) AS valor_saidas,

    -- Saldo e custos
    MAX(m.saldo_atual) AS estoque_final,
    AVG(m.valor_unitario) AS custo_medio,
    SUM(m.valor_total) AS valor_total_movimentado,

    -- Giro de estoque (saídas / estoque médio)
    CASE
        WHEN AVG(m.saldo_atual) > 0
        THEN SUM(CASE WHEN tm.natureza = 'SAÍDA' THEN m.quantidade ELSE 0 END)::DECIMAL / AVG(m.saldo_atual)
        ELSE 0
    END AS giro_estoque

FROM estoque.fato_movimentacao_estoque m
JOIN geral.dim_tempo t ON m.fk_tempo = t.id_tempo
JOIN administrativo.dim_produtos p ON m.fk_produto = p.id_produto
JOIN administrativo.dim_categoria_produto cat ON p.id_categoria = cat.id_categoria
JOIN administrativo.dim_fornecedor f ON p.id_fornecedor = f.id_fornecedor
JOIN estoque.dim_tipo_movimentacao tm ON m.fk_tipo_movimentacao = tm.id_tipo_movimentacao

GROUP BY ROLLUP (
    t.ano, t.trimestre, t.mes, t.nome_mes,
    p.nome_produto,
    cat.categoria, cat.subcategoria, cat.linha_produto,
    f.nome_fornecedor,
    tm.tipo_movimentacao, tm.natureza, tm.categoria
);


CREATE INDEX idx_cubo_estoque_ano_mes ON estoque.cubo_estoque(ano, mes);
CREATE INDEX idx_cubo_estoque_categoria ON estoque.cubo_estoque(categoria);
CREATE INDEX idx_cubo_estoque_produto ON estoque.cubo_estoque(nome_produto);
CREATE INDEX idx_cubo_estoque_natureza ON estoque.cubo_estoque(natureza);

-- Cubo 3: Financeiro

CREATE MATERIALIZED VIEW financeiro.cubo_dre AS
SELECT
    -- Dimensões temporais
    t.ano,
    t.trimestre,
    t.mes,
    t.nome_mes,

    -- Tipo de transação
    tf.tipo_transacao,
    tf.status_transacao,

    -- Forma de pagamento (opcional)
    fp.forma_pagamento,

    -- Métricas agregadas
    COUNT(*) AS qtd_transacoes,
    SUM(tf.valor_total_transacao) AS valor_total,

    -- Separação por tipo (Crédito = Receita, Débito = Despesa)
    SUM(CASE WHEN tf.tipo_transacao = 'Credito' THEN tf.valor_total_transacao ELSE 0 END) AS receitas,
    SUM(CASE WHEN tf.tipo_transacao = 'Debito' THEN tf.valor_total_transacao ELSE 0 END) AS despesas,

    -- Resultado (Receitas - Despesas)
    SUM(CASE WHEN tf.tipo_transacao = 'Credito' THEN tf.valor_total_transacao ELSE -tf.valor_total_transacao END) AS resultado,

    -- Percentuais
    CASE
        WHEN SUM(CASE WHEN tf.tipo_transacao = 'Credito' THEN tf.valor_total_transacao ELSE 0 END) > 0
        THEN (
            SUM(CASE WHEN tf.tipo_transacao = 'Credito' THEN tf.valor_total_transacao ELSE -tf.valor_total_transacao END) /
            SUM(CASE WHEN tf.tipo_transacao = 'Credito' THEN tf.valor_total_transacao ELSE 0 END) * 100
        )
        ELSE 0
    END AS margem_resultado_pct

FROM financeiro.fato_transacao_financeira tf
JOIN geral.dim_tempo t ON tf.fk_data_pagamento = t.id_tempo
LEFT JOIN financeiro.dim_forma_pagamento fp ON tf.fk_forma_pagamento = fp.id_forma_pagamento

WHERE tf.status_transacao IN ('Confirmada', 'Paga')

GROUP BY ROLLUP (
    t.ano, t.trimestre, t.mes, t.nome_mes,
    tf.tipo_transacao,
    tf.status_transacao,
    fp.forma_pagamento
);

-- Índices para performance
CREATE INDEX idx_cubo_dre_ano_mes ON financeiro.cubo_dre(ano, mes);
CREATE INDEX idx_cubo_dre_tipo ON financeiro.cubo_dre(tipo_transacao);
CREATE INDEX idx_cubo_dre_status ON financeiro.cubo_dre(status_transacao);

-- Cubo 4: Logística e Frete

CREATE MATERIALIZED VIEW estoque.cubo_frete AS
SELECT
    -- Dimensões temporais
    t_envio.ano AS ano_envio,
    t_envio.trimestre AS trimestre_envio,
    t_envio.mes AS mes_envio,
    t_envio.nome_mes AS nome_mes_envio,

    -- Dimensões de transportadora
    tr.nome_transportadora,

    -- Dimensões geográficas
    loc_origem.regiao AS regiao_origem,
    loc_origem.estado AS estado_origem,
    loc_destino.regiao AS regiao_destino,
    loc_destino.estado AS estado_destino,

    -- Status
    fr.status_frete,

    -- Métricas agregadas
    COUNT(*) AS qtd_fretes,
    SUM(fr.valor_frete) AS valor_total_frete,
    AVG(fr.valor_frete) AS frete_medio,

    -- Métricas de volume/peso
    SUM(fr.peso_total_kg) AS peso_total_kg,
    AVG(fr.peso_total_kg) AS peso_medio_kg,
    SUM(fr.volume_total_m3) AS volume_total_m3,
    AVG(fr.distancia_km) AS distancia_media_km,

    -- Performance
    AVG(fr.prazo_entrega_dias) AS prazo_medio_dias,
    AVG(fr.dias_atraso) AS media_atraso_dias,
    COUNT(CASE WHEN fr.houve_avaria THEN 1 END) AS qtd_avarias,
    COUNT(CASE WHEN fr.houve_avaria THEN 1 END) * 100.0 / NULLIF(COUNT(*), 0) AS taxa_avaria_pct,
    COUNT(CASE WHEN fr.status_frete = 'Extraviado' THEN 1 END) * 100.0 / NULLIF(COUNT(*), 0) AS taxa_extravio_pct,

    -- Custo por KG
    SUM(fr.valor_frete) / NULLIF(SUM(fr.peso_total_kg), 0) AS custo_por_kg

FROM estoque.fato_pedido_frete fr
JOIN geral.dim_tempo t_envio ON fr.fk_tempo_envio = t_envio.id_tempo
JOIN estoque.dim_transportadora tr ON fr.fk_transportadora = tr.id_transportadora
JOIN geral.dim_localizacao loc_origem ON fr.fk_localizacao_origem = loc_origem.id_localizacao
JOIN geral.dim_localizacao loc_destino ON fr.fk_localizacao_destino = loc_destino.id_localizacao

GROUP BY ROLLUP (
    t_envio.ano, t_envio.trimestre, t_envio.mes, t_envio.nome_mes,
    tr.nome_transportadora,
    loc_origem.regiao, loc_origem.estado,
    loc_destino.regiao, loc_destino.estado,
    fr.status_frete
);

-- Índices para performance
CREATE INDEX idx_cubo_frete_ano_mes ON estoque.cubo_frete(ano_envio, mes_envio);
CREATE INDEX idx_cubo_frete_transportadora ON estoque.cubo_frete(nome_transportadora);
CREATE INDEX idx_cubo_frete_regiao_destino ON estoque.cubo_frete(regiao_destino);
CREATE INDEX idx_cubo_frete_status ON estoque.cubo_frete(status_frete);


