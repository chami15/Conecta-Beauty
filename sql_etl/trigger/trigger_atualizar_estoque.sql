CREATE OR REPLACE FUNCTION estoque.atualizar_estoque()

RETURNS TRIGGER AS $$

BEGIN

    UPDATE estoque.produtos

    SET quantidade_estoque =

        quantidade_estoque - NEW.quantidade

    WHERE id_produto = NEW.sk_produto;

    RETURN NEW;

END;

$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_saida_estoque

AFTER INSERT ON financeiro.fato_vendas

FOR EACH ROW

EXECUTE FUNCTION estoque.atualizar_estoque();