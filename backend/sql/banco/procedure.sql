-- =====================================================
-- PROCEDURE 1: Análise de Vendas Dinâmica
-- Requisito: cursor não vinculado + query dinâmica
-- Dimensões aceitas: produto | cliente | categoria | canal
-- =====================================================

CREATE OR REPLACE PROCEDURE financeiro.analisar_vendas_dinamico(
    p_data_inicio DATE,
    p_data_fim    DATE,
    p_dimensao    VARCHAR DEFAULT 'produto',
    p_top         INT     DEFAULT 10
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_cursor   REFCURSOR;
    v_query    TEXT;
    v_registro RECORD;
    v_total    DECIMAL(12,2) := 0;
    v_contador INT           := 0;
BEGIN
    v_query := 'SELECT ';

    CASE p_dimensao
        WHEN 'produto' THEN
            v_query := v_query || 'p.nome_produto AS dimensao, SUM(v.valor_total) AS total ';
            v_query := v_query || 'FROM financeiro.fato_venda v ';
            v_query := v_query || 'JOIN administrativo.dim_produtos p ON v.fk_produto = p.id_produto ';

        WHEN 'cliente' THEN
            v_query := v_query || 'c.nome AS dimensao, SUM(v.valor_total) AS total ';
            v_query := v_query || 'FROM financeiro.fato_venda v ';
            v_query := v_query || 'JOIN administrativo.dim_clientes c ON v.fk_cliente = c.id_cliente ';

        WHEN 'categoria' THEN
            v_query := v_query || 'cat.categoria AS dimensao, SUM(v.valor_total) AS total ';
            v_query := v_query || 'FROM financeiro.fato_venda v ';
            v_query := v_query || 'JOIN administrativo.dim_produtos p ON v.fk_produto = p.id_produto ';
            v_query := v_query || 'JOIN administrativo.dim_categoria_produto cat ON p.id_categoria = cat.id_categoria ';

        WHEN 'canal' THEN
            v_query := v_query || 'cv.canal_venda AS dimensao, SUM(v.valor_total) AS total ';
            v_query := v_query || 'FROM financeiro.fato_venda v ';
            v_query := v_query || 'JOIN administrativo.dim_canal_venda cv ON v.fk_canal_venda = cv.id_canal_venda ';

        ELSE
            RAISE EXCEPTION 'Dimensão inválida: %. Use: produto | cliente | categoria | canal', p_dimensao;
    END CASE;

    v_query := v_query || 'JOIN geral.dim_tempo t ON v.fk_tempo = t.id_tempo ';
    v_query := v_query || format('WHERE t.data BETWEEN %L AND %L ', p_data_inicio, p_data_fim);
    v_query := v_query || 'GROUP BY dimensao ORDER BY total DESC LIMIT ' || p_top;

    -- Cursor não vinculado (REFCURSOR)
    OPEN v_cursor FOR EXECUTE v_query;

    RAISE NOTICE '=== ANÁLISE DE VENDAS POR % ===', UPPER(p_dimensao);
    RAISE NOTICE 'Período: % até %', p_data_inicio, p_data_fim;
    RAISE NOTICE '';

    LOOP
        FETCH v_cursor INTO v_registro;
        EXIT WHEN NOT FOUND;

        v_contador := v_contador + 1;
        v_total    := v_total + v_registro.total;

        RAISE NOTICE '#% - %: R$ %',
            v_contador,
            v_registro.dimensao,
            TO_CHAR(v_registro.total, 'FM999G999G999D90');
    END LOOP;

    CLOSE v_cursor;

    RAISE NOTICE '';
    RAISE NOTICE '=== RESUMO ===';
    RAISE NOTICE 'Registros: %  |  Total: R$ %',
        v_contador,
        TO_CHAR(v_total, 'FM999G999G999D90');
END;
$$;


-- =====================================================
-- PROCEDURE 2: Atualizar Cubos OLAP
-- Refresh de todas as Materialized Views
-- =====================================================

CREATE OR REPLACE PROCEDURE atualizar_cubos_olap()
LANGUAGE plpgsql
AS $$
BEGIN
    RAISE NOTICE '';
    RAISE NOTICE '════════════════════════════════════════════';
    RAISE NOTICE '  ATUALIZANDO CUBOS OLAP';
    RAISE NOTICE '════════════════════════════════════════════';

    RAISE NOTICE '[1/4] Atualizando cubo de vendas...';
    REFRESH MATERIALIZED VIEW CONCURRENTLY financeiro.cubo_vendas;
    RAISE NOTICE '  OK  cubo_vendas';

    RAISE NOTICE '[2/4] Atualizando cubo de estoque...';
    REFRESH MATERIALIZED VIEW CONCURRENTLY estoque.cubo_estoque;
    RAISE NOTICE '  OK  cubo_estoque';

    RAISE NOTICE '[3/4] Atualizando cubo DRE...';
    REFRESH MATERIALIZED VIEW CONCURRENTLY financeiro.cubo_dre;
    RAISE NOTICE '  OK  cubo_dre';

    RAISE NOTICE '[4/4] Atualizando cubo de frete...';
    REFRESH MATERIALIZED VIEW CONCURRENTLY estoque.cubo_frete;
    RAISE NOTICE '  OK  cubo_frete';

    RAISE NOTICE '';
    RAISE NOTICE '  Todos os cubos atualizados com sucesso!';
    RAISE NOTICE '════════════════════════════════════════════';
END;
$$;
