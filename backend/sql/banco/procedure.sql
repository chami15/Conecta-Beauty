CREATE OR REPLACE PROCEDURE financeiro.analisar_vendas_dinamico(
    p_data_inicio DATE,
    p_data_fim DATE,
    p_dimensao VARCHAR DEFAULT 'produto',
    p_top INT DEFAULT 10
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_cursor REFCURSOR;
    v_query TEXT;
    v_registro RECORD;
    v_total DECIMAL(12,2) := 0;
    v_contador INT := 0;
BEGIN
    -- Construir query dinâmica baseada na dimensão
    v_query := 'SELECT ';
    
    CASE p_dimensao
        WHEN 'produto' THEN
            v_query := v_query || 'p.nome_produto AS dimensao, SUM(v.valor_liquido) AS total ';
            v_query := v_query || 'FROM comercial.fato_venda v ';
            v_query := v_query || 'JOIN administrativo.dim_produto p ON v.sk_produto = p.sk_produto ';
            
        WHEN 'cliente' THEN
            v_query := v_query || 'c.nome AS dimensao, SUM(v.valor_liquido) AS total ';
            v_query := v_query || 'FROM comercial.fato_venda v ';
            v_query := v_query || 'JOIN administrativo.dim_cliente c ON v.sk_cliente = c.sk_cliente ';
            
        WHEN 'categoria' THEN
            v_query := v_query || 'cat.categoria AS dimensao, SUM(v.valor_liquido) AS total ';
            v_query := v_query || 'FROM comercial.fato_venda v ';
            v_query := v_query || 'JOIN administrativo.dim_produto p ON v.sk_produto = p.sk_produto ';
            v_query := v_query || 'JOIN administrativo.dim_categoria_produto cat ON p.sk_categoria = cat.sk_categoria ';
            
        WHEN 'canal' THEN
            v_query := v_query || 'cv.canal_venda AS dimensao, SUM(v.valor_liquido) AS total ';
            v_query := v_query || 'FROM comercial.fato_venda v ';
            v_query := v_query || 'JOIN comercial.dim_canal_venda cv ON v.sk_canal_venda = cv.sk_canal_venda ';
            
        ELSE
            RAISE EXCEPTION 'Dimensão inválida: %', p_dimensao;
    END CASE;
    
    -- Adicionar filtro de data
    v_query := v_query || 'JOIN comum.dim_tempo t ON v.sk_tempo = t.sk_tempo ';
    v_query := v_query || format('WHERE t.data BETWEEN %L AND %L ', p_data_inicio, p_data_fim);
    v_query := v_query || 'GROUP BY dimensao ORDER BY total DESC LIMIT ' || p_top;
    
    -- Abrir cursor não vinculado
    OPEN v_cursor FOR EXECUTE v_query;
    
    -- Log inicial
    RAISE NOTICE '=== ANÁLISE DE VENDAS POR % ===', UPPER(p_dimensao);
    RAISE NOTICE 'Período: % até %', p_data_inicio, p_data_fim;
    RAISE NOTICE '';
    
    -- Processar resultados
    LOOP
        FETCH v_cursor INTO v_registro;
        EXIT WHEN NOT FOUND;
        
        v_contador := v_contador + 1;
        v_total := v_total + v_registro.total;
        
        RAISE NOTICE '#% - %: R$ %', 
            v_contador, 
            v_registro.dimensao, 
            TO_CHAR(v_registro.total, 'FM999G999G999D90');
    END LOOP;
    
    CLOSE v_cursor;
    
    -- Resumo final
    RAISE NOTICE '';
    RAISE NOTICE '=== RESUMO ===';
    RAISE NOTICE 'Total de registros: %', v_contador;
    RAISE NOTICE 'Total vendas: R$ %', TO_CHAR(v_total, 'FM999G999G999D90');
    
END;
$$;