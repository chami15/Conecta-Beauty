-- ===================== KPIs =====================

--QUERY: kpis
SELECT
    COUNT(DISTINCT m.fk_produto) AS total_skus,
    COALESCE(SUM(m.saldo_atual), 0) AS itens_em_estoque,
    COALESCE(SUM(m.saldo_atual * p.custo_unitario), 0) AS valor_em_estoque,
    COUNT(CASE WHEN p.estoque_min > 0
          AND m.saldo_atual <= p.estoque_min THEN 1 END) AS skus_em_alerta
FROM (
    SELECT DISTINCT ON (fk_produto) fk_produto, saldo_atual
    FROM estoque.fato_movimentacao_estoque
    ORDER BY fk_produto, id_movimentacao DESC
) m
JOIN administrativo.dim_produtos p ON m.fk_produto = p.id_produto
WHERE p.ativo = TRUE;

--QUERY: giro_medio
SELECT ROUND(
    AVG(CASE WHEN estoque_medio > 0 THEN saidas::DECIMAL / estoque_medio ELSE 0 END),
    2
) AS giro_medio
FROM (
    SELECT
        m.fk_produto,
        SUM(CASE WHEN tm.natureza = 'SAÍDA' THEN m.quantidade ELSE 0 END) AS saidas,
        AVG(m.saldo_atual)                                                  AS estoque_medio
    FROM estoque.fato_movimentacao_estoque m
    JOIN estoque.dim_tipo_movimentacao tm ON m.fk_tipo_movimentacao = tm.id_tipo_movimentacao
    GROUP BY m.fk_produto
) sub;

-- ===================== GRÁFICOS =====================

--QUERY: movimentacoes_por_dia
SELECT
    t.data,
    COALESCE(SUM(CASE WHEN tm.natureza = 'ENTRADA' THEN m.quantidade ELSE 0 END), 0) AS entradas,
    COALESCE(SUM(CASE WHEN tm.natureza = 'SAÍDA' THEN m.quantidade ELSE 0 END), 0) AS saidas
FROM estoque.fato_movimentacao_estoque m
JOIN geral.dim_tempo t ON m.fk_tempo = t.id_tempo
JOIN estoque.dim_tipo_movimentacao tm ON m.fk_tipo_movimentacao = tm.id_tipo_movimentacao
WHERE (%s IS NULL OR t.ano = %s)
  AND (%s IS NULL OR t.mes = %s)
GROUP BY t.data
ORDER BY t.data;

--QUERY: performance_transportadoras
SELECT
    tr.nome_transportadora,
    COUNT(*)  AS qtd_fretes,
    ROUND(AVG(fr.valor_frete)::NUMERIC, 2) AS frete_medio,
    ROUND(AVG(fr.prazo_entrega_dias)::NUMERIC, 1) AS prazo_medio_dias,
    ROUND(
        COUNT(CASE WHEN fr.status_frete = 'Entregue'
              AND (fr.dias_atraso IS NULL OR fr.dias_atraso <= 0) THEN 1 END)
        * 100.0 / NULLIF(COUNT(CASE WHEN fr.status_frete = 'Entregue' THEN 1 END), 0),
        1
    ) AS taxa_no_prazo_pct
FROM estoque.fato_pedido_frete fr
JOIN estoque.dim_transportadora tr ON fr.fk_transportadora = tr.id_transportadora
LEFT JOIN geral.dim_tempo t ON fr.fk_tempo_envio = t.id_tempo
WHERE (%s IS NULL OR t.ano = %s)
  AND (%s IS NULL OR t.mes = %s)
GROUP BY tr.nome_transportadora
ORDER BY qtd_fretes DESC;

--QUERY: skus_ponto_critico
SELECT
    p.id_produto,
    p.nome_produto,
    p.estoque_min,
    COALESCE(m.saldo_atual, 0) AS saldo_atual,
    COALESCE(m.saldo_atual, 0) - p.estoque_min AS diferenca
FROM administrativo.dim_produtos p
LEFT JOIN (
    SELECT DISTINCT ON (fk_produto) fk_produto, saldo_atual
    FROM estoque.fato_movimentacao_estoque
    ORDER BY fk_produto, id_movimentacao DESC
) m ON p.id_produto = m.fk_produto
WHERE p.ativo = TRUE
  AND p.estoque_min > 0
  AND COALESCE(m.saldo_atual, 0) <= p.estoque_min
ORDER BY diferenca;

--QUERY: calor_movimentacao
SELECT
    p.nome_produto,
    t.ano,
    t.mes,
    t.nome_mes,
    SUM(m.quantidade) AS qtd_movimentada
FROM estoque.fato_movimentacao_estoque m
JOIN geral.dim_tempo t ON m.fk_tempo = t.id_tempo
JOIN administrativo.dim_produtos p ON m.fk_produto  = p.id_produto
WHERE (%s IS NULL OR t.ano = %s)
  AND (%s IS NULL OR t.mes = %s)
  AND p.id_produto IN (
      SELECT fk_produto
      FROM estoque.fato_movimentacao_estoque
      GROUP BY fk_produto
      ORDER BY SUM(quantidade) DESC
      LIMIT 20
  )
GROUP BY p.nome_produto, t.ano, t.mes, t.nome_mes
ORDER BY p.nome_produto, t.ano, t.mes;

-- ===================== SALDOS SKUs =====================

--QUERY: listar_saldos
SELECT
    p.id_produto,
    p.nome_produto,
    cat.categoria,
    p.estoque_min,
    p.estoque_max,
    COALESCE(m.saldo_atual, 0) AS saldo_atual,
    CASE
        WHEN p.estoque_min > 0 AND COALESCE(m.saldo_atual, 0) <= p.estoque_min THEN 'CRITICO'
        WHEN p.estoque_max IS NOT NULL AND COALESCE(m.saldo_atual, 0) >= p.estoque_max THEN 'EXCESSO'
        ELSE 'NORMAL'
    END AS situacao
FROM administrativo.dim_produtos p
LEFT JOIN administrativo.dim_categoria_produto cat ON p.id_categoria = cat.id_categoria
LEFT JOIN (
    SELECT DISTINCT ON (fk_produto) fk_produto, saldo_atual
    FROM estoque.fato_movimentacao_estoque
    ORDER BY fk_produto, id_movimentacao DESC
) m ON p.id_produto = m.fk_produto
WHERE p.ativo = TRUE
ORDER BY p.nome_produto
LIMIT %s OFFSET %s;

--QUERY: total_saldos
SELECT COUNT(*) AS total FROM administrativo.dim_produtos WHERE ativo = TRUE;

-- ===================== CRUD MOVIMENTAÇÕES =====================

--QUERY: listar_movimentacoes
SELECT m.id_movimentacao,
       p.nome_produto,     
       m.fk_produto,
       tm.tipo_movimentacao, 
       tm.natureza,
       m.quantidade, 
       m.valor_unitario, 
       m.valor_total,
       m.saldo_anterior, 
       m.saldo_atual,
       t.data AS data_movimentacao,
       m.data_hora_movimentacao,
       f.nome_fornecedor
FROM estoque.fato_movimentacao_estoque m
JOIN administrativo.dim_produtos p ON m.fk_produto = p.id_produto
JOIN estoque.dim_tipo_movimentacao tm ON m.fk_tipo_movimentacao = tm.id_tipo_movimentacao
JOIN geral.dim_tempo t ON m.fk_tempo = t.id_tempo
LEFT JOIN administrativo.dim_fornecedor f ON m.fk_fornecedor = f.id_fornecedor
ORDER BY m.data_hora_movimentacao DESC
LIMIT %s OFFSET %s;

--QUERY: total_movimentacoes
SELECT COUNT(*) AS total FROM estoque.fato_movimentacao_estoque;

--QUERY: buscar_movimentacao
SELECT m.id_movimentacao,
       p.nome_produto, 
       m.fk_produto,
       tm.tipo_movimentacao, 
       tm.natureza, 
       m.fk_tipo_movimentacao,
       m.quantidade, 
       m.valor_unitario, 
       m.valor_total,
       m.saldo_anterior, 
       m.saldo_atual,
       t.data AS data_movimentacao, 
       m.data_hora_movimentacao,
       f.nome_fornecedor, 
       m.fk_fornecedor
FROM estoque.fato_movimentacao_estoque m
JOIN administrativo.dim_produtos p ON m.fk_produto = p.id_produto
JOIN estoque.dim_tipo_movimentacao tm ON m.fk_tipo_movimentacao = tm.id_tipo_movimentacao
JOIN geral.dim_tempo t ON m.fk_tempo = t.id_tempo
LEFT JOIN administrativo.dim_fornecedor f ON m.fk_fornecedor = f.id_fornecedor
WHERE m.id_movimentacao = %s;

--QUERY: saldo_atual_produto
SELECT COALESCE(
    (SELECT saldo_atual FROM estoque.fato_movimentacao_estoque
     WHERE fk_produto = %s ORDER BY id_movimentacao DESC LIMIT 1),
    0
) AS saldo_atual;

--QUERY: natureza_movimento
SELECT natureza FROM estoque.dim_tipo_movimentacao WHERE id_tipo_movimentacao = %s;

--QUERY: tipos_movimentacao
SELECT id_tipo_movimentacao, 
       tipo_movimentacao, 
       natureza, 
       categoria
FROM estoque.dim_tipo_movimentacao
ORDER BY natureza, tipo_movimentacao;

--QUERY: inserir_movimentacao
INSERT INTO estoque.fato_movimentacao_estoque
    (fk_tempo, fk_produto, fk_tipo_movimentacao, fk_fornecedor,
     quantidade, valor_unitario, valor_total, saldo_anterior, saldo_atual)
VALUES (
    (SELECT id_tempo FROM geral.dim_tempo WHERE data = %s),
    %s, %s, %s, %s, %s, %s, %s, %s
)
RETURNING id_movimentacao;

--QUERY: deletar_movimentacao
DELETE FROM estoque.fato_movimentacao_estoque WHERE id_movimentacao = %s RETURNING id_movimentacao;

-- ===================== CRUD FRETES =====================

--QUERY: listar_fretes
SELECT fr.id_frete, fr.numero_pedido,
       tr.nome_transportadora,
       lo.cidade AS cidade_origem, 
       lo.estado AS estado_origem,
       ld.cidade AS cidade_destino, 
       ld.estado AS estado_destino,
       fr.peso_total_kg, 
       fr.valor_frete, 
       fr.prazo_entrega_dias,
       fr.status_frete, 
       fr.dias_atraso, fr.houve_avaria,
       te.data AS data_envio,
       teg.data AS data_entrega
FROM estoque.fato_pedido_frete fr
JOIN estoque.dim_transportadora tr ON fr.fk_transportadora = tr.id_transportadora
JOIN geral.dim_localizacao lo ON fr.fk_localizacao_origem = lo.id_localizacao
JOIN geral.dim_localizacao ld ON fr.fk_localizacao_destino = ld.id_localizacao
LEFT JOIN geral.dim_tempo te ON fr.fk_tempo_envio = te.id_tempo
LEFT JOIN geral.dim_tempo teg ON fr.fk_tempo_entrega = teg.id_tempo
ORDER BY fr.id_frete DESC
LIMIT %s OFFSET %s;

--QUERY: total_fretes
SELECT COUNT(*) AS total FROM estoque.fato_pedido_frete;

--QUERY: buscar_frete
SELECT fr.id_frete, 
       fr.numero_pedido,
       fr.fk_transportadora,
       tr.nome_transportadora,
       fr.fk_localizacao_origem, 
       lo.cidade AS cidade_origem, 
       lo.estado AS estado_origem,
       fr.fk_localizacao_destino, 
       ld.cidade AS cidade_destino, 
       ld.estado AS estado_destino,
       fr.peso_total_kg, 
       fr.volume_total_m3, 
       fr.distancia_km, 
       fr.valor_frete,
       fr.prazo_entrega_dias, 
       fr.status_frete, 
       fr.dias_atraso, 
       fr.houve_avaria,
       te.data AS data_envio,
       teg.data AS data_entrega
FROM estoque.fato_pedido_frete fr
JOIN estoque.dim_transportadora tr ON fr.fk_transportadora = tr.id_transportadora
JOIN geral.dim_localizacao lo ON fr.fk_localizacao_origem = lo.id_localizacao
JOIN geral.dim_localizacao ld ON fr.fk_localizacao_destino = ld.id_localizacao
LEFT JOIN geral.dim_tempo te ON fr.fk_tempo_envio = te.id_tempo
LEFT JOIN geral.dim_tempo teg ON fr.fk_tempo_entrega = teg.id_tempo
WHERE fr.id_frete = %s;

--QUERY: inserir_frete
INSERT INTO estoque.fato_pedido_frete
    (numero_pedido, fk_tempo_envio, fk_tempo_entrega, fk_transportadora,
     fk_localizacao_origem, fk_localizacao_destino,
     peso_total_kg, volume_total_m3, distancia_km, valor_frete,
     prazo_entrega_dias, status_frete, dias_atraso, houve_avaria)
VALUES (
    %s,
    (SELECT id_tempo FROM geral.dim_tempo WHERE data = %s),
    (SELECT id_tempo FROM geral.dim_tempo WHERE data = %s),
    %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s
)
RETURNING id_frete;

--QUERY: atualizar_frete
UPDATE estoque.fato_pedido_frete
SET status_frete = %s,
    dias_atraso = %s,
    houve_avaria = %s,
    fk_transportadora = %s,
    peso_total_kg = %s,
    valor_frete = %s,
    prazo_entrega_dias = %s
WHERE id_frete = %s
RETURNING id_frete;

--QUERY: deletar_frete
DELETE FROM estoque.fato_pedido_frete WHERE id_frete = %s RETURNING id_frete;

-- ===================== CRUD TRANSPORTADORAS =====================

--QUERY: listar_transportadoras
SELECT id_transportadora, 
       nome_transportadora, 
       cnpj, 
       telefone,
       media_entrega, 
       frete_kg_base, 
       adicional_volume, 
       ativo
FROM estoque.dim_transportadora
ORDER BY id_transportadora DESC;

--QUERY: buscar_transportadora
SELECT id_transportadora, 
       nome_transportadora, 
       cnpj, 
       telefone,
       media_entrega, 
       frete_kg_base, 
       adicional_volume, 
       ativo
FROM estoque.dim_transportadora
WHERE id_transportadora = %s;

--QUERY: inserir_transportadora
INSERT INTO estoque.dim_transportadora
    (nome_transportadora, cnpj, telefone, media_entrega, frete_kg_base, adicional_volume, ativo)
VALUES (%s, %s, %s, %s, %s, %s, %s)
RETURNING id_transportadora;

--QUERY: atualizar_transportadora
UPDATE estoque.dim_transportadora
SET nome_transportadora = %s,
    cnpj = %s,
    telefone = %s,
    media_entrega = %s,
    frete_kg_base = %s,
    adicional_volume = %s,
    ativo = %s
WHERE id_transportadora = %s
RETURNING id_transportadora;

--QUERY: deletar_transportadora
DELETE FROM estoque.dim_transportadora WHERE id_transportadora = %s RETURNING id_transportadora;
