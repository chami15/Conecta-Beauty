-- =====================================================
-- TRIGGER 1: Auditoria de Vendas
-- Rastreia INSERT / UPDATE / DELETE em fato_venda
-- =====================================================

CREATE TABLE IF NOT EXISTS financeiro.auditoria_vendas (
    id_auditoria   SERIAL PRIMARY KEY,
    id_venda       INT,
    acao           VARCHAR(10),
    usuario        VARCHAR(100),
    data_hora      TIMESTAMP DEFAULT NOW(),
    valor_anterior DECIMAL(12,2),
    valor_novo     DECIMAL(12,2)
);

CREATE OR REPLACE FUNCTION financeiro.auditar_vendas()
RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        INSERT INTO financeiro.auditoria_vendas (id_venda, acao, usuario, valor_novo)
        VALUES (NEW.id_venda, 'INSERT', current_user, NEW.valor_total);

    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO financeiro.auditoria_vendas (id_venda, acao, usuario, valor_anterior, valor_novo)
        VALUES (NEW.id_venda, 'UPDATE', current_user, OLD.valor_total, NEW.valor_total);

    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO financeiro.auditoria_vendas (id_venda, acao, usuario, valor_anterior)
        VALUES (OLD.id_venda, 'DELETE', current_user, OLD.valor_total);
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_auditoria_vendas
AFTER INSERT OR UPDATE OR DELETE ON financeiro.fato_venda
FOR EACH ROW
EXECUTE FUNCTION financeiro.auditar_vendas();


-- =====================================================
-- TRIGGER 2: Atualizar Saldo de Estoque
-- Calcula saldo_anterior e saldo_atual automaticamente
-- e bloqueia saída que deixaria saldo negativo
-- =====================================================

CREATE OR REPLACE FUNCTION estoque.atualizar_saldo_estoque()
RETURNS TRIGGER AS $$
DECLARE
    v_saldo_atual INT;
    v_natureza    VARCHAR(20);
BEGIN
    -- Saldo atual do produto antes desta movimentação
    SELECT COALESCE(MAX(saldo_atual), 0) INTO v_saldo_atual
    FROM estoque.fato_movimentacao_estoque
    WHERE fk_produto = NEW.fk_produto;

    -- Natureza do tipo de movimentação (ENTRADA ou SAÍDA)
    SELECT natureza INTO v_natureza
    FROM estoque.dim_tipo_movimentacao
    WHERE id_tipo_movimentacao = NEW.fk_tipo_movimentacao;

    NEW.saldo_anterior := v_saldo_atual;

    IF v_natureza = 'ENTRADA' THEN
        NEW.saldo_atual := v_saldo_atual + NEW.quantidade;
    ELSE
        NEW.saldo_atual := v_saldo_atual - NEW.quantidade;
    END IF;

    IF NEW.saldo_atual < 0 THEN
        RAISE EXCEPTION
            'Saldo negativo não permitido. Produto: %, saldo atual: %, saída tentada: %',
            NEW.fk_produto, v_saldo_atual, NEW.quantidade;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_atualizar_saldo
BEFORE INSERT ON estoque.fato_movimentacao_estoque
FOR EACH ROW
EXECUTE FUNCTION estoque.atualizar_saldo_estoque();
