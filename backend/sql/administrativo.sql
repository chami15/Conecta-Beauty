-- ===================== KPIs =====================

--QUERY: kpi_produto_lider
SELECT p.nome_produto, SUM(v.valor_total) AS faturamento
FROM financeiro.fato_venda v
JOIN administrativo.dim_produtos p ON v.fk_produto = p.id_produto
GROUP BY p.nome_produto
ORDER BY faturamento DESC
LIMIT 1;

--QUERY: kpi_melhor_cliente
SELECT c.nome, SUM(v.valor_total) AS faturamento
FROM financeiro.fato_venda v
JOIN administrativo.dim_clientes c ON v.fk_cliente = c.id_cliente
GROUP BY c.nome
ORDER BY faturamento DESC
LIMIT 1;

--QUERY: kpi_top_fornecedor
SELECT f.nome_fornecedor, SUM(v.valor_total) AS faturamento
FROM financeiro.fato_venda v
JOIN administrativo.dim_produtos p ON v.fk_produto = p.id_produto
JOIN administrativo.dim_fornecedor f ON p.id_fornecedor = f.id_fornecedor
GROUP BY f.nome_fornecedor
ORDER BY faturamento DESC
LIMIT 1;

--QUERY: kpi_canal_numero1
SELECT cv.canal_venda, COUNT(DISTINCT v.numero_pedido) AS qtd_pedidos, SUM(v.valor_total) AS faturamento
FROM financeiro.fato_venda v
JOIN administrativo.dim_canal_venda cv ON v.fk_canal_venda = cv.id_canal_venda
GROUP BY cv.canal_venda
ORDER BY faturamento DESC
LIMIT 1;

-- ===================== GRÁFICOS =====================

--QUERY: canais_por_venda
SELECT cv.canal_venda,
       cv.tipo_canal,
       COUNT(DISTINCT v.numero_pedido) AS qtd_pedidos,
       SUM(v.valor_total)              AS faturamento
FROM financeiro.fato_venda v
JOIN administrativo.dim_canal_venda cv ON v.fk_canal_venda = cv.id_canal_venda
GROUP BY cv.canal_venda, cv.tipo_canal
ORDER BY faturamento DESC;

--QUERY: clientes_por_regiao
SELECT loc.regiao,
       loc.estado,
       COUNT(DISTINCT v.fk_cliente) AS qtd_clientes,
       SUM(v.valor_total)           AS faturamento
FROM financeiro.fato_venda v
JOIN administrativo.dim_clientes c   ON v.fk_cliente      = c.id_cliente
JOIN geral.dim_localizacao loc       ON c.fk_localizacao   = loc.id_localizacao
GROUP BY loc.regiao, loc.estado
ORDER BY loc.regiao, faturamento DESC;

-- ===================== CRUD CLIENTES =====================

--QUERY: listar_clientes
SELECT c.id_cliente, c.nome, c.sexo, c.documento, c.telefone,
       c.endereco_completo, l.cidade, l.estado, l.regiao,
       c.created_at, c.update_at
FROM administrativo.dim_clientes c
LEFT JOIN geral.dim_localizacao l ON c.fk_localizacao = l.id_localizacao
ORDER BY c.id_cliente
LIMIT %s OFFSET %s;

--QUERY: total_clientes
SELECT COUNT(*) AS total FROM administrativo.dim_clientes;

--QUERY: buscar_cliente
SELECT c.id_cliente, c.nome, c.sexo, c.documento, c.telefone,
       c.endereco_completo, l.cidade, l.estado, l.regiao,
       c.created_at, c.update_at
FROM administrativo.dim_clientes c
LEFT JOIN geral.dim_localizacao l ON c.fk_localizacao = l.id_localizacao
WHERE c.id_cliente = %s;

--QUERY: inserir_cliente
INSERT INTO administrativo.dim_clientes
    (nome, sexo, documento, fk_localizacao, telefone, endereco_completo)
VALUES (%s, %s, %s, %s, %s, %s)
RETURNING id_cliente;

--QUERY: atualizar_cliente
UPDATE administrativo.dim_clientes
SET nome              = %s,
    sexo              = %s,
    documento         = %s,
    fk_localizacao    = %s,
    telefone          = %s,
    endereco_completo = %s,
    update_at         = NOW()
WHERE id_cliente = %s
RETURNING id_cliente;

--QUERY: deletar_cliente
DELETE FROM administrativo.dim_clientes WHERE id_cliente = %s RETURNING id_cliente;

-- ===================== CRUD PRODUTOS =====================

--QUERY: listar_produtos
SELECT p.id_produto, p.nome_produto, p.descricao, p.custo_unitario,
       p.peso_kg, p.estoque_min, p.estoque_max, p.ativo,
       cat.categoria, cat.subcategoria, f.nome_fornecedor,
       p.created_at, p.update_at
FROM administrativo.dim_produtos p
LEFT JOIN administrativo.dim_categoria_produto cat ON p.id_categoria   = cat.id_categoria
LEFT JOIN administrativo.dim_fornecedor        f   ON p.id_fornecedor  = f.id_fornecedor
ORDER BY p.id_produto
LIMIT %s OFFSET %s;

--QUERY: total_produtos
SELECT COUNT(*) AS total FROM administrativo.dim_produtos;

--QUERY: buscar_produto
SELECT p.id_produto, p.nome_produto, p.descricao, p.custo_unitario,
       p.peso_kg, p.altura_cm, p.largura_cm, p.profundidade_cm,
       p.estoque_min, p.estoque_max, p.ativo,
       p.id_categoria, cat.categoria, cat.subcategoria,
       p.id_fornecedor, f.nome_fornecedor,
       p.created_at, p.update_at
FROM administrativo.dim_produtos p
LEFT JOIN administrativo.dim_categoria_produto cat ON p.id_categoria  = cat.id_categoria
LEFT JOIN administrativo.dim_fornecedor        f   ON p.id_fornecedor = f.id_fornecedor
WHERE p.id_produto = %s;

--QUERY: inserir_produto
INSERT INTO administrativo.dim_produtos
    (nome_produto, descricao, id_categoria, id_fornecedor, custo_unitario,
     peso_kg, altura_cm, largura_cm, profundidade_cm, estoque_min, estoque_max, ativo)
VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
RETURNING id_produto;

--QUERY: atualizar_produto
UPDATE administrativo.dim_produtos
SET nome_produto    = %s,
    descricao       = %s,
    id_categoria    = %s,
    id_fornecedor   = %s,
    custo_unitario  = %s,
    peso_kg         = %s,
    altura_cm       = %s,
    largura_cm      = %s,
    profundidade_cm = %s,
    estoque_min     = %s,
    estoque_max     = %s,
    ativo           = %s,
    update_at       = NOW()
WHERE id_produto = %s
RETURNING id_produto;

--QUERY: deletar_produto
DELETE FROM administrativo.dim_produtos WHERE id_produto = %s RETURNING id_produto;

-- ===================== CRUD FORNECEDORES =====================

--QUERY: listar_fornecedores
SELECT f.id_fornecedor, f.nome_fornecedor, f.cnpj, f.telefone,
       f.endereco_completo, l.cidade, l.estado, l.regiao,
       f.created_at, f.update_at
FROM administrativo.dim_fornecedor f
LEFT JOIN geral.dim_localizacao l ON f.id_localizacao = l.id_localizacao
ORDER BY f.id_fornecedor
LIMIT %s OFFSET %s;

--QUERY: total_fornecedores
SELECT COUNT(*) AS total FROM administrativo.dim_fornecedor;

--QUERY: buscar_fornecedor
SELECT f.id_fornecedor, f.nome_fornecedor, f.cnpj, f.telefone,
       f.endereco_completo, l.cidade, l.estado, l.regiao,
       f.created_at, f.update_at
FROM administrativo.dim_fornecedor f
LEFT JOIN geral.dim_localizacao l ON f.id_localizacao = l.id_localizacao
WHERE f.id_fornecedor = %s;

--QUERY: inserir_fornecedor
INSERT INTO administrativo.dim_fornecedor
    (nome_fornecedor, cnpj, telefone, id_localizacao, endereco_completo)
VALUES (%s, %s, %s, %s, %s)
RETURNING id_fornecedor;

--QUERY: atualizar_fornecedor
UPDATE administrativo.dim_fornecedor
SET nome_fornecedor   = %s,
    cnpj              = %s,
    telefone          = %s,
    id_localizacao    = %s,
    endereco_completo = %s,
    update_at         = NOW()
WHERE id_fornecedor = %s
RETURNING id_fornecedor;

--QUERY: deletar_fornecedor
DELETE FROM administrativo.dim_fornecedor WHERE id_fornecedor = %s RETURNING id_fornecedor;

-- ===================== CRUD CANAIS DE VENDA =====================

--QUERY: listar_canais
SELECT id_canal_venda, canal_venda, tipo_canal, ativo
FROM administrativo.dim_canal_venda
ORDER BY id_canal_venda;

--QUERY: buscar_canal
SELECT id_canal_venda, canal_venda, tipo_canal, ativo
FROM administrativo.dim_canal_venda
WHERE id_canal_venda = %s;

--QUERY: inserir_canal
INSERT INTO administrativo.dim_canal_venda (canal_venda, tipo_canal, ativo)
VALUES (%s, %s, %s)
RETURNING id_canal_venda;

--QUERY: atualizar_canal
UPDATE administrativo.dim_canal_venda
SET canal_venda = %s,
    tipo_canal  = %s,
    ativo       = %s
WHERE id_canal_venda = %s
RETURNING id_canal_venda;

--QUERY: deletar_canal
DELETE FROM administrativo.dim_canal_venda WHERE id_canal_venda = %s RETURNING id_canal_venda;
