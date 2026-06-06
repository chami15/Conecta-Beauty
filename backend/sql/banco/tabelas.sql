CREATE SCHEMA IF NOT EXISTS administrativo; --schema para gestão de clientes, fornecedores, produtos, canais de venda...
CREATE SCHEMA IF NOT EXISTS financeiro; --schema para transações, movimentações financeiras, receitas, despesas, vendas, pedidos...
CREATE SCHEMA IF NOT EXISTS estoque; --schema para estoque, movimentação, logistica e frete
CREATE SCHEMA IF NOT EXISTS geral; --schema geral compartilhado entre todos os schemas

CREATE TABLE IF NOT EXISTS geral.dim_tempo(
    id_tempo SERIAL PRIMARY KEY,
    data DATE NOT NULL UNIQUE,
    dia INT NOT NULL,
    mes INT NOT NULL,
    nome_mes VARCHAR(20) NOT NULL ,
    trimestre INT NOT NULL,
    ano INT NOT NULL,
    dia_semana VARCHAR(20) NOT NULL

    CONSTRAINT ck_dia CHECK ( dia BETWEEN 1 and 31),
    CONSTRAINT ck_mes CHECK ( mes BETWEEN 1 and 12),
    CONSTRAINT ck_trimestre CHECK ( trimestre BETWEEN 1 and 4)
);

CREATE INDEX IF NOT EXISTS idx_tempo_data ON geral.dim_tempo(data);
CREATE INDEX IF NOT EXISTS idx_tempo_ano_mes ON geral.dim_tempo(ano, mes);
CREATE INDEX IF NOT EXISTS idx_tempo_trimestre ON geral.dim_tempo(ano, trimestre);

CREATE TABLE IF NOT EXISTS geral.dim_localizacao(
    id_localizacao SERIAL PRIMARY KEY,
    cidade VARCHAR(100) NOT NULL,
    estado CHAR(2) NOT NULL,
    regiao VARCHAR(20) NOT NULL,
    valor_frete NUMERIC(10, 2)

    CONSTRAINT ck_regiao CHECK ( regiao IN ('Norte', 'Nordeste', 'Centro-Oeste', 'Sudeste', 'Sul')),
    CONSTRAINT cidade_estado UNIQUE (cidade, estado)
);

CREATE INDEX IF NOT EXISTS idx_loc_estado ON geral.dim_localizacao(estado);
CREATE INDEX IF NOT EXISTS idx_loc_regiao ON geral.dim_localizacao(regiao);

--Tabelas do schema adminstrativo
CREATE TABLE IF NOT EXISTS administrativo.dim_canal_venda(
    id_canal_venda SERIAL PRIMARY KEY,
    canal_venda VARCHAR(50) NOT NULL UNIQUE,
    tipo_canal VARCHAR(50) NOT NULL,
    ativo BOOLEAN DEFAULT TRUE

     CONSTRAINT ck_tipo_canal CHECK (tipo_canal IN ('Online', 'Físico', 'Híbrido', 'Marketplace'))
);

CREATE TABLE IF NOT EXISTS administrativo.dim_clientes(
    id_cliente SERIAL PRIMARY KEY,
    nome VARCHAR(200) NOT NULL,
    sexo CHAR(1),
    documento VARCHAR(20),
    fk_localizacao INT REFERENCES geral.dim_localizacao(id_localizacao),
    telefone VARCHAR(20),
    endereco_completo VARCHAR(200),
    created_at TIMESTAMP DEFAULT NOW(),
    update_at TIMESTAMP DEFAULT NOW()

    CONSTRAINT ck_sexo CHECK (sexo IN ('M', 'F', 'O', NULL))
);

CREATE INDEX IF NOT EXISTS idx_cliente_localizacao ON administrativo.dim_clientes(fk_localizacao);

CREATE TABLE IF NOT EXISTS administrativo.dim_categoria_produto(
    id_categoria SERIAL PRIMARY KEY,
    categoria VARCHAR(200) NOT NULL,
    subcategoria VARCHAR(200),
    linha_produto VARCHAR(100),

    CONSTRAINT hierarquia_produto UNIQUE(categoria, subcategoria, linha_produto)
);

CREATE INDEX IF NOT EXISTS idx_categoria_principal ON administrativo.dim_categoria_produto(categoria);

CREATE TABLE IF NOT EXISTS administrativo.dim_fornecedor(
    id_fornecedor SERIAL PRIMARY KEY,
    nome_fornecedor VARCHAR(200) NOT NULL,
    cnpj VARCHAR(20) UNIQUE,
    telefone VARCHAR(20),
    id_localizacao INT REFERENCES geral.dim_localizacao(id_localizacao),
    endereco_completo VARCHAR(100),
    created_at TIMESTAMP DEFAULT NOW(),
    update_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS administrativo.dim_produtos(
    id_produto SERIAL PRIMARY KEY,
    nome_produto VARCHAR(200) NOT NULL,
    descricao VARCHAR(200),
    id_categoria INT REFERENCES administrativo.dim_categoria_produto(id_categoria),
    id_fornecedor INT REFERENCES administrativo.dim_fornecedor(id_fornecedor),
    custo_unitario DECIMAL(10,2) NOT NULL,
    peso_kg DECIMAL(8,3),
    altura_cm DECIMAL(8,2),
    largura_cm DECIMAL(8,2),
    profundidade_cm DECIMAL(8,2),
    estoque_min INT DEFAULT 0,
    estoque_max INT,
    ativo BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT NOW(),
    update_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_produto_categoria ON administrativo.dim_produtos(id_categoria);
CREATE INDEX IF NOT EXISTS idx_produto_fornecedor ON administrativo.dim_produtos(id_fornecedor);

-- Tabelas do schema financeiro
CREATE TABLE IF NOT EXISTS financeiro.dim_forma_pagamento(
    id_forma_pagamento SERIAL PRIMARY KEY,
    forma_pagamento VARCHAR(50) NOT NULL UNIQUE

     CONSTRAINT ck_tipo_pagamento CHECK (forma_pagamento IN ('Débito', 'Crédito', 'PIX', 'Boleto', 'Dinheiro', 'Transferência'))
);

CREATE TABLE IF NOT EXISTS financeiro.fato_pedido(
    id_pedido SERIAL PRIMARY KEY,
    numero_pedido INT NOT NULL UNIQUE,
    fk_tempo INT NOT NULL REFERENCES geral.dim_tempo(id_tempo),
    fk_cliente INT NOT NULL REFERENCES administrativo.dim_clientes(id_cliente),
    fk_canal_venda INT NOT NULL REFERENCES administrativo.dim_canal_venda(id_canal_venda),
    fk_forma_pagamento INT NOT NULL REFERENCES financeiro.dim_forma_pagamento(id_forma_pagamento),
    qtd_itens INT NOT NULL,
    valor_total DECIMAL(10,2),
    valor_frete DECIMAL(10,2),
    status_pedido VARCHAR(20),
    data_hora_pedido TIMESTAMP NOT NULL

    CONSTRAINT ck_status_pedido CHECK (status_pedido IN ('Pendente', 'Confirmado', 'Enviado', 'Entregue', 'Cancelado'))
);

CREATE INDEX IF NOT EXISTS idx_pedido_tempo ON financeiro.fato_pedido(fk_tempo);
CREATE INDEX IF NOT EXISTS idx_pedido_cliente ON financeiro.fato_pedido(fk_cliente);
CREATE INDEX IF NOT EXISTS idx_pedido_status ON financeiro.fato_pedido(status_pedido);

CREATE TABLE IF NOT EXISTS financeiro.fato_venda(
    id_venda SERIAL PRIMARY KEY,
    numero_pedido INT NOT NULL,
    numero_item INT NOT NULL,
    fk_tempo INT NOT NULL REFERENCES geral.dim_tempo(id_tempo),
    fk_cliente INT NOT NULL REFERENCES administrativo.dim_clientes(id_cliente),
    fk_produto INT NOT NULL REFERENCES administrativo.dim_produtos(id_produto),
    fk_canal_venda INT NOT NULL REFERENCES administrativo.dim_canal_venda(id_canal_venda),
    fk_forma_pagamento INT NOT NULL REFERENCES financeiro.dim_forma_pagamento(id_forma_pagamento),
    quantidade INT NOT NULL,
    valor_unitario DECIMAL(10,2) NOT NULL,
    valor_total DECIMAL(10,2) NOT NULL,
    data_hora_venda TIMESTAMP NOT NULL,

    CONSTRAINT venda_pedido_item UNIQUE (numero_pedido, numero_item)
);

CREATE INDEX IF NOT EXISTS idx_venda_tempo ON financeiro.fato_venda(fk_tempo);
CREATE INDEX IF NOT EXISTS idx_venda_cliente ON financeiro.fato_venda(fk_cliente);
CREATE INDEX IF NOT EXISTS idx_venda_produto ON financeiro.fato_venda(fk_produto);
CREATE INDEX IF NOT EXISTS idx_venda_canal ON financeiro.fato_venda(fk_canal_venda);
CREATE INDEX IF NOT EXISTS idx_venda_data ON financeiro.fato_venda(data_hora_venda);
CREATE INDEX IF NOT EXISTS idx_venda_pedido ON financeiro.fato_venda(numero_pedido);

CREATE TABLE IF NOT EXISTS financeiro.fato_transacao_financeira(
    id_transacao SERIAL PRIMARY KEY,
    numero_transacao INT NOT NULL,
    fk_data_pagamento INT REFERENCES geral.dim_tempo(id_tempo),
    fk_forma_pagamento INT REFERENCES financeiro.dim_forma_pagamento(id_forma_pagamento),
    tipo_transacao VARCHAR(20) NOT NULL,
    valor_total_transacao DECIMAL(12,2) NOT NULL,
    status_transacao VARCHAR(20),
    historico TEXT,
    data_hora_lancamento TIMESTAMP DEFAULT now(),
    CONSTRAINT ck_tipo_transacao CHECK (tipo_transacao IN ('Debito', 'Credito')),
    CONSTRAINT ck_status_transacao CHECK (status_transacao IN ('Prevista', 'Confirmada', 'Paga', 'Cancelada'))
);

CREATE INDEX IF NOT EXISTS idx_trans_tipo ON financeiro.fato_transacao_financeira(tipo_transacao);
CREATE INDEX IF NOT EXISTS idx_trans_status ON financeiro.fato_transacao_financeira(status_transacao);

--SCHEMA ESTOQUE
CREATE TABLE IF NOT EXISTS estoque.dim_transportadora(
    id_transportadora SERIAL PRIMARY KEY,
    nome_transportadora VARCHAR(100) NOT NULL,
    cnpj VARCHAR(20) UNIQUE,
    telefone VARCHAR(20),
    media_entrega INT DEFAULT 7,
    frete_kg_base DECIMAL(8,2),
    adicional_volume DECIMAL(8,2),
    ativo BOOLEAN DEFAULT TRUE
);

CREATE INDEX IF NOT EXISTS idx_transp_ativo ON estoque.dim_transportadora(ativo);

CREATE TABLE IF NOT EXISTS estoque.dim_tipo_movimentacao(
    id_tipo_movimentacao SERIAL PRIMARY KEY,
    tipo_movimentacao VARCHAR(50) NOT NULL,
    natureza VARCHAR(20) NOT NULL,
    categoria VARCHAR(50),
    afeta_custo BOOLEAN DEFAULT FALSE,
    requer_documento BOOLEAN DEFAULT TRUE

    CONSTRAINT ck_natureza CHECK (natureza IN ('ENTRADA', 'SAÍDA'))
);

--Inserts basicos
INSERT INTO estoque.dim_tipo_movimentacao (tipo_movimentacao, natureza, categoria, afeta_custo, requer_documento) VALUES
('Compra', 'ENTRADA', 'Reposição', TRUE, TRUE),
('Devolução Cliente', 'ENTRADA', 'Devolução', FALSE, TRUE),
('Ajuste Inventário +', 'ENTRADA', 'Ajuste', TRUE, FALSE),
('Venda', 'SAÍDA', 'Comercial', TRUE, TRUE),
('Devolução Fornecedor', 'SAÍDA', 'Devolução', TRUE, TRUE),
('Perda/Quebra', 'SAÍDA', 'Perdas', TRUE, TRUE),
('Transferência Saída', 'SAÍDA', 'Transferência', FALSE, TRUE),
('Transferência Entrada', 'ENTRADA', 'Transferência', FALSE, TRUE),
('Ajuste Inventário -', 'SAÍDA', 'Ajuste', TRUE, FALSE);

CREATE TABLE IF NOT EXISTS estoque.fato_movimentacao_estoque(
    id_movimentacao SERIAL PRIMARY KEY,
    fk_tempo INT NOT NULL REFERENCES geral.dim_tempo(id_tempo),
    fk_produto INT NOT NULL REFERENCES administrativo.dim_produtos(id_produto),
    fk_tipo_movimentacao INT NOT NULL REFERENCES estoque.dim_tipo_movimentacao(id_tipo_movimentacao),
    fk_fornecedor INT REFERENCES administrativo.dim_fornecedor(id_fornecedor),
    quantidade INT NOT NULL,
    valor_unitario DECIMAL(10,2) NOT NULL,
    valor_total DECIMAL(10,2) NOT NULL,
    saldo_anterior INT NOT NULL,
    saldo_atual INT NOT NULL,
    data_hora_movimentacao TIMESTAMP NOT NULL DEFAULT now()

    CONSTRAINT ck_quantidade_positiva CHECK (quantidade > 0)
);

CREATE INDEX IF NOT EXISTS idx_mov_tempo ON estoque.fato_movimentacao_estoque(fk_tempo);
CREATE INDEX IF NOT EXISTS idx_mov_produto ON estoque.fato_movimentacao_estoque(fk_produto);
CREATE INDEX IF NOT EXISTS idx_mov_tipo ON estoque.fato_movimentacao_estoque(fk_tipo_movimentacao);
CREATE INDEX IF NOT EXISTS idx_mov_data ON estoque.fato_movimentacao_estoque(data_hora_movimentacao);

CREATE TABLE IF NOT EXISTS estoque.fato_pedido_frete(
    id_frete SERIAL PRIMARY KEY,
    numero_pedido INT NOT NULL,
    fk_tempo_envio INT REFERENCES geral.dim_tempo(id_tempo),
    fk_tempo_entrega INT REFERENCES geral.dim_tempo(id_tempo),
    fk_transportadora INT NOT NULL REFERENCES estoque.dim_transportadora(id_transportadora),
    fk_localizacao_origem INT NOT NULL REFERENCES geral.dim_localizacao(id_localizacao),
    fk_localizacao_destino INT NOT NULL REFERENCES geral.dim_localizacao(id_localizacao),
    peso_total_kg DECIMAL(8,3) NOT NULL,
    volume_total_m3 DECIMAL(8,3),
    distancia_km DECIMAL(8,2),
    valor_frete DECIMAL(10,2) NOT NULL,
    prazo_entrega_dias INT,
    data_hora_entrega TIMESTAMP,
    status_frete VARCHAR(30),
    dias_atraso INT,
    houve_avaria BOOLEAN DEFAULT FALSE

    CONSTRAINT ck_status_frete CHECK (status_frete IN ('Aguardando', 'Coletado', 'Em Trânsito', 'Entregue', 'Devolvido', 'Extraviado'))
);

CREATE INDEX IF NOT EXISTS idx_frete_pedido ON estoque.fato_pedido_frete(numero_pedido);
CREATE INDEX IF NOT EXISTS idx_frete_transportadora ON estoque.fato_pedido_frete(fk_transportadora);
CREATE INDEX IF NOT EXISTS idx_frete_status ON estoque.fato_pedido_frete(status_frete);
CREATE INDEX IF NOT EXISTS idx_frete_origem ON estoque.fato_pedido_frete(fk_localizacao_origem);
CREATE INDEX IF NOT EXISTS idx_frete_destino ON estoque.fato_pedido_frete(fk_localizacao_destino);

