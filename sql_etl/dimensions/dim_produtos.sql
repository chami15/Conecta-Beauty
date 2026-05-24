CREATE TABLE IF NOT EXISTS geral.dim_produto (

    sk_produto SERIAL PRIMARY KEY,

    id_produto INT UNIQUE,

    nome_produto VARCHAR(255),

    categoria VARCHAR(100),

    preco NUMERIC(10,2)

);