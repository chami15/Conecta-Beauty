CREATE TABLE IF NOT EXISTS geral.dim_cliente (

    sk_cliente SERIAL PRIMARY KEY,

    id_cliente INT UNIQUE,

    nome_cliente VARCHAR(255),

    cidade VARCHAR(100),

    estado VARCHAR(50),

    regiao VARCHAR(100),

    data_cadastro DATE

);