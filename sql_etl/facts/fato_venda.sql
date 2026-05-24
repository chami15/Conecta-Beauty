CREATE TABLE IF NOT EXISTS financeiro.fato_vendas (

    sk_venda SERIAL PRIMARY KEY,

    id_venda INT UNIQUE,

    sk_cliente INT,

    sk_produto INT,

    sk_tempo INT,

    quantidade INT,

    valor_total NUMERIC(10,2),

    ticket_medio NUMERIC(10,2),

    categoria_venda VARCHAR(100),

    CONSTRAINT fk_cliente
        FOREIGN KEY (sk_cliente)
        REFERENCES geral.dim_cliente(sk_cliente),

    CONSTRAINT fk_produto
        FOREIGN KEY (sk_produto)
        REFERENCES geral.dim_produto(sk_produto),

    CONSTRAINT fk_tempo
        FOREIGN KEY (sk_tempo)
        REFERENCES geral.dim_tempo(sk_tempo)

);