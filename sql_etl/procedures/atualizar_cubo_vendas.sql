CREATE OR REPLACE PROCEDURE analytics.atualizar_cubo_vendas()

LANGUAGE plpgsql

AS $$

BEGIN

    REFRESH MATERIALIZED VIEW analytics.cubo_vendas;

END;
$$;

CREATE OR REPLACE PROCEDURE analytics.relatorio_clientes()

LANGUAGE plpgsql

AS $$

DECLARE

    registro RECORD;

    cursor_clientes CURSOR FOR

        SELECT

            nome_cliente,
            estado

        FROM geral.dim_cliente;

BEGIN

    OPEN cursor_clientes;

    LOOP

        FETCH cursor_clientes INTO registro;

        EXIT WHEN NOT FOUND;

        RAISE NOTICE
            'Cliente: %, Estado: %',

            registro.nome_cliente,
            registro.estado;

    END LOOP;

    CLOSE cursor_clientes;

END;
$$;

CREATE OR REPLACE PROCEDURE analytics.consulta_dinamica(
    tabela TEXT
)

LANGUAGE plpgsql

AS $$
DECLARE
    comando TEXT;

BEGIN

    comando := 'SELECT * FROM ' || tabela;

    EXECUTE comando;

END;
$$;