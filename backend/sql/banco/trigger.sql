CREATE TABLE IF NOT EXISTS financeiro.auditoria_vendas (
    id_auditoria SERIAL PRIMARY KEY,
    sk_venda INT,
    acao VARCHAR(10),
    usuario VARCHAR(100),
    data_hora TIMESTAMP DEFAULT NOW(),
    valor_anterior DECIMAL(12,2),
    valor_novo DECIMAL(12,2)
);
 
CREATE OR REPLACE FUNCTION financeiro.auditar_vendas()
RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        INSERT INTO financeiro.auditoria_vendas (sk_venda, acao, usuario, valor_novo)
        VALUES (NEW.sk_venda, 'INSERT', current_user, NEW.valor_liquido);
        
    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO financeiro.auditoria_vendas (sk_venda, acao, usuario, valor_anterior, valor_novo)
        VALUES (NEW.sk_venda, 'UPDATE', current_user, OLD.valor_liquido, NEW.valor_liquido);
        
    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO financeiro.auditoria_vendas (sk_venda, acao, usuario, valor_anterior)
        VALUES (OLD.sk_venda, 'DELETE', current_user, OLD.valor_liquido);
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
 
CREATE TRIGGER trg_auditoria_vendas
AFTER INSERT OR UPDATE OR DELETE ON financeiro.fato_venda
FOR EACH ROW
EXECUTE FUNCTION financeiro.auditar_vendas();

CREATE OR REPLACE FUNCTION estoque.atualizar_saldo_estoque()
RETURNS TRIGGER AS $$
DECLARE
    v_saldo_atual INT;
    v_natureza VARCHAR(20);
BEGIN
    -- Buscar saldo atual do produto
    SELECT COALESCE(MAX(saldo_atual), 0) INTO v_saldo_atual
    FROM estoque.fato_movimentacao_estoque
    WHERE sk_produto = NEW.sk_produto;
    
    -- Buscar natureza do tipo de movimentação
    SELECT natureza INTO v_natureza
    FROM estoque.dim_tipo_movimentacao
    WHERE sk_tipo_movimentacao = NEW.sk_tipo_movimentacao;
    
    -- Calcular novo saldo
    NEW.saldo_anterior := v_saldo_atual;
    
    IF v_natureza = 'ENTRADA' THEN
        NEW.saldo_atual := v_saldo_atual + NEW.quantidade;
    ELSE -- SAÍDA
        NEW.saldo_atual := v_saldo_atual - NEW.quantidade;
    END IF;
    
    -- Validar saldo negativo
    IF NEW.saldo_atual < 0 THEN
        RAISE EXCEPTION 'Saldo de estoque negativo não permitido. Produto: %, Saldo atual: %, Tentativa saída: %', 
            NEW.sk_produto, v_saldo_atual, NEW.quantidade;
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
 
CREATE TRIGGER trg_atualizar_saldo
BEFORE INSERT ON estoque.fato_movimentacao_estoque
FOR EACH ROW
EXECUTE FUNCTION estoque.atualizar_saldo_estoque();