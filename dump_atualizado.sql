--
-- PostgreSQL database dump
--

\restrict Jsl8EVjLF4uDxkfennRkZZ2ZwaG28Yk5hK8UJdUPLcnOedSMR6I7TQysZmKHerJ

-- Dumped from database version 16.13 (Debian 16.13-1.pgdg13+1)
-- Dumped by pg_dump version 16.13 (Debian 16.13-1.pgdg13+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: administrativo; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA administrativo;


ALTER SCHEMA administrativo OWNER TO postgres;

--
-- Name: estoque; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA estoque;


ALTER SCHEMA estoque OWNER TO postgres;

--
-- Name: financeiro; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA financeiro;


ALTER SCHEMA financeiro OWNER TO postgres;

--
-- Name: geral; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA geral;


ALTER SCHEMA geral OWNER TO postgres;

--
-- Name: atualizar_cubos_olap(); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.atualizar_cubos_olap()
    LANGUAGE plpgsql
    AS $$
BEGIN
    RAISE NOTICE '';
    RAISE NOTICE 'ÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉ';
    RAISE NOTICE '  ATUALIZANDO CUBOS OLAP';
    RAISE NOTICE 'ÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉ';
    RAISE NOTICE '';

    -- Cubo de Vendas
    RAISE NOTICE '[1/4] Atualizando cubo de vendas...';
    REFRESH MATERIALIZED VIEW CONCURRENTLY financeiro.cubo_vendas;
    RAISE NOTICE 'Ô£ô Cubo de Vendas atualizado';

    -- Cubo de Estoque
    RAISE NOTICE '[2/4] Atualizando cubo de estoque...';
    REFRESH MATERIALIZED VIEW CONCURRENTLY estoque.cubo_estoque;
    RAISE NOTICE 'Ô£ô Cubo de Estoque atualizado';

    -- Cubo DRE
    RAISE NOTICE '[3/4] Atualizando cubo DRE...';
    REFRESH MATERIALIZED VIEW CONCURRENTLY financeiro.cubo_dre;
    RAISE NOTICE 'Ô£ô Cubo DRE atualizado';

    -- Cubo de Frete
    RAISE NOTICE '[4/4] Atualizando cubo de frete...';
    REFRESH MATERIALIZED VIEW CONCURRENTLY estoque.cubo_frete;
    RAISE NOTICE 'Ô£ô Cubo de Frete atualizado';

    RAISE NOTICE '';
    RAISE NOTICE 'ÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉ';
    RAISE NOTICE '  Ô£ô Todos os cubos OLAP foram atualizados com sucesso!';
    RAISE NOTICE 'ÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉÔòÉ';
    RAISE NOTICE '';
END;
$$;


ALTER PROCEDURE public.atualizar_cubos_olap() OWNER TO postgres;

--
-- Name: PROCEDURE atualizar_cubos_olap(); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON PROCEDURE public.atualizar_cubos_olap() IS 'Atualiza todas as materialized views (cubos OLAP) do sistema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: dim_canal_venda; Type: TABLE; Schema: administrativo; Owner: postgres
--

CREATE TABLE administrativo.dim_canal_venda (
    id_canal_venda integer NOT NULL,
    canal_venda character varying(50) NOT NULL,
    tipo_canal character varying(50) NOT NULL,
    ativo boolean DEFAULT true,
    CONSTRAINT ck_tipo_canal CHECK (((tipo_canal)::text = ANY ((ARRAY['Online'::character varying, 'F├¡sico'::character varying, 'H├¡brido'::character varying, 'Marketplace'::character varying])::text[])))
);


ALTER TABLE administrativo.dim_canal_venda OWNER TO postgres;

--
-- Name: dim_canal_venda_id_canal_venda_seq; Type: SEQUENCE; Schema: administrativo; Owner: postgres
--

CREATE SEQUENCE administrativo.dim_canal_venda_id_canal_venda_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE administrativo.dim_canal_venda_id_canal_venda_seq OWNER TO postgres;

--
-- Name: dim_canal_venda_id_canal_venda_seq; Type: SEQUENCE OWNED BY; Schema: administrativo; Owner: postgres
--

ALTER SEQUENCE administrativo.dim_canal_venda_id_canal_venda_seq OWNED BY administrativo.dim_canal_venda.id_canal_venda;


--
-- Name: dim_categoria_produto; Type: TABLE; Schema: administrativo; Owner: postgres
--

CREATE TABLE administrativo.dim_categoria_produto (
    id_categoria integer NOT NULL,
    categoria character varying(200) NOT NULL,
    subcategoria character varying(200),
    linha_produto character varying(100)
);


ALTER TABLE administrativo.dim_categoria_produto OWNER TO postgres;

--
-- Name: dim_categoria_produto_id_categoria_seq; Type: SEQUENCE; Schema: administrativo; Owner: postgres
--

CREATE SEQUENCE administrativo.dim_categoria_produto_id_categoria_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE administrativo.dim_categoria_produto_id_categoria_seq OWNER TO postgres;

--
-- Name: dim_categoria_produto_id_categoria_seq; Type: SEQUENCE OWNED BY; Schema: administrativo; Owner: postgres
--

ALTER SEQUENCE administrativo.dim_categoria_produto_id_categoria_seq OWNED BY administrativo.dim_categoria_produto.id_categoria;


--
-- Name: dim_clientes; Type: TABLE; Schema: administrativo; Owner: postgres
--

CREATE TABLE administrativo.dim_clientes (
    id_cliente integer NOT NULL,
    nome character varying(200) NOT NULL,
    sexo character(1),
    documento character varying(20),
    fk_localizacao integer,
    telefone character varying(20),
    endereco_completo character varying(200),
    created_at timestamp without time zone DEFAULT now(),
    update_at timestamp without time zone DEFAULT now(),
    CONSTRAINT ck_sexo CHECK ((sexo = ANY (ARRAY['M'::bpchar, 'F'::bpchar, 'O'::bpchar, NULL::bpchar])))
);


ALTER TABLE administrativo.dim_clientes OWNER TO postgres;

--
-- Name: dim_clientes_id_cliente_seq; Type: SEQUENCE; Schema: administrativo; Owner: postgres
--

CREATE SEQUENCE administrativo.dim_clientes_id_cliente_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE administrativo.dim_clientes_id_cliente_seq OWNER TO postgres;

--
-- Name: dim_clientes_id_cliente_seq; Type: SEQUENCE OWNED BY; Schema: administrativo; Owner: postgres
--

ALTER SEQUENCE administrativo.dim_clientes_id_cliente_seq OWNED BY administrativo.dim_clientes.id_cliente;


--
-- Name: dim_fornecedor; Type: TABLE; Schema: administrativo; Owner: postgres
--

CREATE TABLE administrativo.dim_fornecedor (
    id_fornecedor integer NOT NULL,
    nome_fornecedor character varying(200) NOT NULL,
    cnpj character varying(20),
    telefone character varying(20),
    id_localizacao integer,
    endereco_completo character varying(100),
    created_at timestamp without time zone DEFAULT now(),
    update_at timestamp without time zone DEFAULT now()
);


ALTER TABLE administrativo.dim_fornecedor OWNER TO postgres;

--
-- Name: dim_fornecedor_id_fornecedor_seq; Type: SEQUENCE; Schema: administrativo; Owner: postgres
--

CREATE SEQUENCE administrativo.dim_fornecedor_id_fornecedor_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE administrativo.dim_fornecedor_id_fornecedor_seq OWNER TO postgres;

--
-- Name: dim_fornecedor_id_fornecedor_seq; Type: SEQUENCE OWNED BY; Schema: administrativo; Owner: postgres
--

ALTER SEQUENCE administrativo.dim_fornecedor_id_fornecedor_seq OWNED BY administrativo.dim_fornecedor.id_fornecedor;


--
-- Name: dim_produtos; Type: TABLE; Schema: administrativo; Owner: postgres
--

CREATE TABLE administrativo.dim_produtos (
    id_produto integer NOT NULL,
    nome_produto character varying(200) NOT NULL,
    descricao character varying(200),
    id_categoria integer,
    id_fornecedor integer,
    custo_unitario numeric(10,2) NOT NULL,
    peso_kg numeric(8,3),
    altura_cm numeric(8,2),
    largura_cm numeric(8,2),
    profundidade_cm numeric(8,2),
    estoque_min integer DEFAULT 0,
    estoque_max integer,
    ativo boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT now(),
    update_at timestamp without time zone DEFAULT now()
);


ALTER TABLE administrativo.dim_produtos OWNER TO postgres;

--
-- Name: dim_produtos_id_produto_seq; Type: SEQUENCE; Schema: administrativo; Owner: postgres
--

CREATE SEQUENCE administrativo.dim_produtos_id_produto_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE administrativo.dim_produtos_id_produto_seq OWNER TO postgres;

--
-- Name: dim_produtos_id_produto_seq; Type: SEQUENCE OWNED BY; Schema: administrativo; Owner: postgres
--

ALTER SEQUENCE administrativo.dim_produtos_id_produto_seq OWNED BY administrativo.dim_produtos.id_produto;


--
-- Name: dim_tipo_movimentacao; Type: TABLE; Schema: estoque; Owner: postgres
--

CREATE TABLE estoque.dim_tipo_movimentacao (
    id_tipo_movimentacao integer NOT NULL,
    tipo_movimentacao character varying(50) NOT NULL,
    natureza character varying(20) NOT NULL,
    categoria character varying(50),
    afeta_custo boolean DEFAULT false,
    requer_documento boolean DEFAULT true,
    CONSTRAINT ck_natureza CHECK (((natureza)::text = ANY ((ARRAY['ENTRADA'::character varying, 'SA├ìDA'::character varying])::text[])))
);


ALTER TABLE estoque.dim_tipo_movimentacao OWNER TO postgres;

--
-- Name: fato_movimentacao_estoque; Type: TABLE; Schema: estoque; Owner: postgres
--

CREATE TABLE estoque.fato_movimentacao_estoque (
    id_movimentacao integer NOT NULL,
    fk_tempo integer NOT NULL,
    fk_produto integer NOT NULL,
    fk_tipo_movimentacao integer NOT NULL,
    fk_fornecedor integer,
    quantidade integer NOT NULL,
    valor_unitario numeric(10,2) NOT NULL,
    valor_total numeric(10,2) NOT NULL,
    saldo_anterior integer NOT NULL,
    saldo_atual integer NOT NULL,
    data_hora_movimentacao timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT ck_quantidade_positiva CHECK ((quantidade > 0))
);


ALTER TABLE estoque.fato_movimentacao_estoque OWNER TO postgres;

--
-- Name: dim_tempo; Type: TABLE; Schema: geral; Owner: postgres
--

CREATE TABLE geral.dim_tempo (
    id_tempo integer NOT NULL,
    data date NOT NULL,
    dia integer NOT NULL,
    mes integer NOT NULL,
    nome_mes character varying(20) NOT NULL,
    trimestre integer NOT NULL,
    ano integer NOT NULL,
    dia_semana character varying(20) NOT NULL,
    CONSTRAINT ck_dia CHECK (((dia >= 1) AND (dia <= 31))),
    CONSTRAINT ck_mes CHECK (((mes >= 1) AND (mes <= 12))),
    CONSTRAINT ck_trimestre CHECK (((trimestre >= 1) AND (trimestre <= 4)))
);


ALTER TABLE geral.dim_tempo OWNER TO postgres;

--
-- Name: cubo_estoque; Type: MATERIALIZED VIEW; Schema: estoque; Owner: postgres
--

CREATE MATERIALIZED VIEW estoque.cubo_estoque AS
 SELECT t.ano,
    t.trimestre,
    t.mes,
    t.nome_mes,
    p.nome_produto,
    cat.categoria,
    cat.subcategoria,
    cat.linha_produto,
    f.nome_fornecedor,
    tm.tipo_movimentacao,
    tm.natureza,
    tm.categoria AS categoria_movimento,
    count(*) AS qtd_movimentacoes,
    sum(
        CASE
            WHEN ((tm.natureza)::text = 'ENTRADA'::text) THEN m.quantidade
            ELSE 0
        END) AS qtd_entradas,
    sum(
        CASE
            WHEN ((tm.natureza)::text = 'SA├ìDA'::text) THEN m.quantidade
            ELSE 0
        END) AS qtd_saidas,
    sum(
        CASE
            WHEN ((tm.natureza)::text = 'ENTRADA'::text) THEN m.valor_total
            ELSE (0)::numeric
        END) AS valor_entradas,
    sum(
        CASE
            WHEN ((tm.natureza)::text = 'SA├ìDA'::text) THEN m.valor_total
            ELSE (0)::numeric
        END) AS valor_saidas,
    max(m.saldo_atual) AS estoque_final,
    avg(m.valor_unitario) AS custo_medio,
    sum(m.valor_total) AS valor_total_movimentado,
        CASE
            WHEN (avg(m.saldo_atual) > (0)::numeric) THEN ((sum(
            CASE
                WHEN ((tm.natureza)::text = 'SA├ìDA'::text) THEN m.quantidade
                ELSE 0
            END))::numeric / avg(m.saldo_atual))
            ELSE (0)::numeric
        END AS giro_estoque
   FROM (((((estoque.fato_movimentacao_estoque m
     JOIN geral.dim_tempo t ON ((m.fk_tempo = t.id_tempo)))
     JOIN administrativo.dim_produtos p ON ((m.fk_produto = p.id_produto)))
     JOIN administrativo.dim_categoria_produto cat ON ((p.id_categoria = cat.id_categoria)))
     JOIN administrativo.dim_fornecedor f ON ((p.id_fornecedor = f.id_fornecedor)))
     JOIN estoque.dim_tipo_movimentacao tm ON ((m.fk_tipo_movimentacao = tm.id_tipo_movimentacao)))
  GROUP BY ROLLUP(t.ano, t.trimestre, t.mes, t.nome_mes, p.nome_produto, cat.categoria, cat.subcategoria, cat.linha_produto, f.nome_fornecedor, tm.tipo_movimentacao, tm.natureza, tm.categoria)
  WITH NO DATA;


ALTER MATERIALIZED VIEW estoque.cubo_estoque OWNER TO postgres;

--
-- Name: MATERIALIZED VIEW cubo_estoque; Type: COMMENT; Schema: estoque; Owner: postgres
--

COMMENT ON MATERIALIZED VIEW estoque.cubo_estoque IS 'Cubo OLAP de estoque - an├ílises de movimenta├º├Áes e giro';


--
-- Name: dim_transportadora; Type: TABLE; Schema: estoque; Owner: postgres
--

CREATE TABLE estoque.dim_transportadora (
    id_transportadora integer NOT NULL,
    nome_transportadora character varying(100) NOT NULL,
    cnpj character varying(20),
    telefone character varying(20),
    media_entrega integer DEFAULT 7,
    frete_kg_base numeric(8,2),
    adicional_volume numeric(8,2),
    ativo boolean DEFAULT true
);


ALTER TABLE estoque.dim_transportadora OWNER TO postgres;

--
-- Name: fato_pedido_frete; Type: TABLE; Schema: estoque; Owner: postgres
--

CREATE TABLE estoque.fato_pedido_frete (
    id_frete integer NOT NULL,
    numero_pedido integer NOT NULL,
    fk_tempo_envio integer,
    fk_tempo_entrega integer,
    fk_transportadora integer NOT NULL,
    fk_localizacao_origem integer NOT NULL,
    fk_localizacao_destino integer NOT NULL,
    peso_total_kg numeric(8,3) NOT NULL,
    volume_total_m3 numeric(8,3),
    distancia_km numeric(8,2),
    valor_frete numeric(10,2) NOT NULL,
    prazo_entrega_dias integer,
    data_hora_entrega timestamp without time zone,
    status_frete character varying(30),
    dias_atraso integer,
    houve_avaria boolean DEFAULT false,
    CONSTRAINT ck_status_frete CHECK (((status_frete)::text = ANY ((ARRAY['Aguardando'::character varying, 'Coletado'::character varying, 'Em Tr├ónsito'::character varying, 'Entregue'::character varying, 'Devolvido'::character varying, 'Extraviado'::character varying])::text[])))
);


ALTER TABLE estoque.fato_pedido_frete OWNER TO postgres;

--
-- Name: dim_localizacao; Type: TABLE; Schema: geral; Owner: postgres
--

CREATE TABLE geral.dim_localizacao (
    id_localizacao integer NOT NULL,
    cidade character varying(100) NOT NULL,
    estado character(2) NOT NULL,
    regiao character varying(20) NOT NULL,
    valor_frete numeric(10,2),
    CONSTRAINT ck_regiao CHECK (((regiao)::text = ANY ((ARRAY['Norte'::character varying, 'Nordeste'::character varying, 'Centro-Oeste'::character varying, 'Sudeste'::character varying, 'Sul'::character varying])::text[])))
);


ALTER TABLE geral.dim_localizacao OWNER TO postgres;

--
-- Name: cubo_frete; Type: MATERIALIZED VIEW; Schema: estoque; Owner: postgres
--

CREATE MATERIALIZED VIEW estoque.cubo_frete AS
 SELECT t_envio.ano AS ano_envio,
    t_envio.trimestre AS trimestre_envio,
    t_envio.mes AS mes_envio,
    t_envio.nome_mes AS nome_mes_envio,
    tr.nome_transportadora,
    loc_origem.regiao AS regiao_origem,
    loc_origem.estado AS estado_origem,
    loc_destino.regiao AS regiao_destino,
    loc_destino.estado AS estado_destino,
    fr.status_frete,
    count(*) AS qtd_fretes,
    sum(fr.valor_frete) AS valor_total_frete,
    avg(fr.valor_frete) AS frete_medio,
    sum(fr.peso_total_kg) AS peso_total_kg,
    avg(fr.peso_total_kg) AS peso_medio_kg,
    sum(fr.volume_total_m3) AS volume_total_m3,
    avg(fr.distancia_km) AS distancia_media_km,
    avg(fr.prazo_entrega_dias) AS prazo_medio_dias,
    avg(fr.dias_atraso) AS media_atraso_dias,
    count(
        CASE
            WHEN fr.houve_avaria THEN 1
            ELSE NULL::integer
        END) AS qtd_avarias,
    (((count(
        CASE
            WHEN fr.houve_avaria THEN 1
            ELSE NULL::integer
        END))::numeric * 100.0) / (NULLIF(count(*), 0))::numeric) AS taxa_avaria_pct,
    (((count(
        CASE
            WHEN ((fr.status_frete)::text = 'Extraviado'::text) THEN 1
            ELSE NULL::integer
        END))::numeric * 100.0) / (NULLIF(count(*), 0))::numeric) AS taxa_extravio_pct,
    (sum(fr.valor_frete) / NULLIF(sum(fr.peso_total_kg), (0)::numeric)) AS custo_por_kg
   FROM ((((estoque.fato_pedido_frete fr
     JOIN geral.dim_tempo t_envio ON ((fr.fk_tempo_envio = t_envio.id_tempo)))
     JOIN estoque.dim_transportadora tr ON ((fr.fk_transportadora = tr.id_transportadora)))
     JOIN geral.dim_localizacao loc_origem ON ((fr.fk_localizacao_origem = loc_origem.id_localizacao)))
     JOIN geral.dim_localizacao loc_destino ON ((fr.fk_localizacao_destino = loc_destino.id_localizacao)))
  GROUP BY ROLLUP(t_envio.ano, t_envio.trimestre, t_envio.mes, t_envio.nome_mes, tr.nome_transportadora, loc_origem.regiao, loc_origem.estado, loc_destino.regiao, loc_destino.estado, fr.status_frete)
  WITH NO DATA;


ALTER MATERIALIZED VIEW estoque.cubo_frete OWNER TO postgres;

--
-- Name: MATERIALIZED VIEW cubo_frete; Type: COMMENT; Schema: estoque; Owner: postgres
--

COMMENT ON MATERIALIZED VIEW estoque.cubo_frete IS 'Cubo OLAP de frete - an├ílises de log├¡stica e performance de transportadoras';


--
-- Name: dim_tipo_movimentacao_id_tipo_movimentacao_seq; Type: SEQUENCE; Schema: estoque; Owner: postgres
--

CREATE SEQUENCE estoque.dim_tipo_movimentacao_id_tipo_movimentacao_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE estoque.dim_tipo_movimentacao_id_tipo_movimentacao_seq OWNER TO postgres;

--
-- Name: dim_tipo_movimentacao_id_tipo_movimentacao_seq; Type: SEQUENCE OWNED BY; Schema: estoque; Owner: postgres
--

ALTER SEQUENCE estoque.dim_tipo_movimentacao_id_tipo_movimentacao_seq OWNED BY estoque.dim_tipo_movimentacao.id_tipo_movimentacao;


--
-- Name: dim_transportadora_id_transportadora_seq; Type: SEQUENCE; Schema: estoque; Owner: postgres
--

CREATE SEQUENCE estoque.dim_transportadora_id_transportadora_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE estoque.dim_transportadora_id_transportadora_seq OWNER TO postgres;

--
-- Name: dim_transportadora_id_transportadora_seq; Type: SEQUENCE OWNED BY; Schema: estoque; Owner: postgres
--

ALTER SEQUENCE estoque.dim_transportadora_id_transportadora_seq OWNED BY estoque.dim_transportadora.id_transportadora;


--
-- Name: fato_movimentacao_estoque_id_movimentacao_seq; Type: SEQUENCE; Schema: estoque; Owner: postgres
--

CREATE SEQUENCE estoque.fato_movimentacao_estoque_id_movimentacao_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE estoque.fato_movimentacao_estoque_id_movimentacao_seq OWNER TO postgres;

--
-- Name: fato_movimentacao_estoque_id_movimentacao_seq; Type: SEQUENCE OWNED BY; Schema: estoque; Owner: postgres
--

ALTER SEQUENCE estoque.fato_movimentacao_estoque_id_movimentacao_seq OWNED BY estoque.fato_movimentacao_estoque.id_movimentacao;


--
-- Name: fato_pedido_frete_id_frete_seq; Type: SEQUENCE; Schema: estoque; Owner: postgres
--

CREATE SEQUENCE estoque.fato_pedido_frete_id_frete_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE estoque.fato_pedido_frete_id_frete_seq OWNER TO postgres;

--
-- Name: fato_pedido_frete_id_frete_seq; Type: SEQUENCE OWNED BY; Schema: estoque; Owner: postgres
--

ALTER SEQUENCE estoque.fato_pedido_frete_id_frete_seq OWNED BY estoque.fato_pedido_frete.id_frete;


--
-- Name: dim_forma_pagamento; Type: TABLE; Schema: financeiro; Owner: postgres
--

CREATE TABLE financeiro.dim_forma_pagamento (
    id_forma_pagamento integer NOT NULL,
    forma_pagamento character varying(50) NOT NULL,
    CONSTRAINT ck_tipo_pagamento CHECK (((forma_pagamento)::text = ANY ((ARRAY['D├®bito'::character varying, 'Cr├®dito'::character varying, 'PIX'::character varying, 'Boleto'::character varying, 'Dinheiro'::character varying, 'Transfer├¬ncia'::character varying])::text[])))
);


ALTER TABLE financeiro.dim_forma_pagamento OWNER TO postgres;

--
-- Name: fato_transacao_financeira; Type: TABLE; Schema: financeiro; Owner: postgres
--

CREATE TABLE financeiro.fato_transacao_financeira (
    id_transacao integer NOT NULL,
    numero_transacao integer NOT NULL,
    fk_data_pagamento integer,
    fk_forma_pagamento integer,
    tipo_transacao character varying(20) NOT NULL,
    valor_total_transacao numeric(12,2) NOT NULL,
    status_transacao character varying(20),
    historico text,
    data_hora_lancamento timestamp without time zone DEFAULT now(),
    CONSTRAINT ck_status_transacao CHECK (((status_transacao)::text = ANY ((ARRAY['Prevista'::character varying, 'Confirmada'::character varying, 'Paga'::character varying, 'Cancelada'::character varying])::text[]))),
    CONSTRAINT ck_tipo_transacao CHECK (((tipo_transacao)::text = ANY ((ARRAY['Debito'::character varying, 'Credito'::character varying])::text[])))
);


ALTER TABLE financeiro.fato_transacao_financeira OWNER TO postgres;

--
-- Name: cubo_dre; Type: MATERIALIZED VIEW; Schema: financeiro; Owner: postgres
--

CREATE MATERIALIZED VIEW financeiro.cubo_dre AS
 SELECT t.ano,
    t.trimestre,
    t.mes,
    t.nome_mes,
    tf.tipo_transacao,
    tf.status_transacao,
    fp.forma_pagamento,
    count(*) AS qtd_transacoes,
    sum(tf.valor_total_transacao) AS valor_total,
    sum(
        CASE
            WHEN ((tf.tipo_transacao)::text = 'Credito'::text) THEN tf.valor_total_transacao
            ELSE (0)::numeric
        END) AS receitas,
    sum(
        CASE
            WHEN ((tf.tipo_transacao)::text = 'Debito'::text) THEN tf.valor_total_transacao
            ELSE (0)::numeric
        END) AS despesas,
    sum(
        CASE
            WHEN ((tf.tipo_transacao)::text = 'Credito'::text) THEN tf.valor_total_transacao
            ELSE (- tf.valor_total_transacao)
        END) AS resultado,
        CASE
            WHEN (sum(
            CASE
                WHEN ((tf.tipo_transacao)::text = 'Credito'::text) THEN tf.valor_total_transacao
                ELSE (0)::numeric
            END) > (0)::numeric) THEN ((sum(
            CASE
                WHEN ((tf.tipo_transacao)::text = 'Credito'::text) THEN tf.valor_total_transacao
                ELSE (- tf.valor_total_transacao)
            END) / sum(
            CASE
                WHEN ((tf.tipo_transacao)::text = 'Credito'::text) THEN tf.valor_total_transacao
                ELSE (0)::numeric
            END)) * (100)::numeric)
            ELSE (0)::numeric
        END AS margem_resultado_pct
   FROM ((financeiro.fato_transacao_financeira tf
     JOIN geral.dim_tempo t ON ((tf.fk_data_pagamento = t.id_tempo)))
     LEFT JOIN financeiro.dim_forma_pagamento fp ON ((tf.fk_forma_pagamento = fp.id_forma_pagamento)))
  WHERE ((tf.status_transacao)::text = ANY ((ARRAY['Confirmada'::character varying, 'Paga'::character varying])::text[]))
  GROUP BY ROLLUP(t.ano, t.trimestre, t.mes, t.nome_mes, tf.tipo_transacao, tf.status_transacao, fp.forma_pagamento)
  WITH NO DATA;


ALTER MATERIALIZED VIEW financeiro.cubo_dre OWNER TO postgres;

--
-- Name: MATERIALIZED VIEW cubo_dre; Type: COMMENT; Schema: financeiro; Owner: postgres
--

COMMENT ON MATERIALIZED VIEW financeiro.cubo_dre IS 'Cubo OLAP para DRE - demonstra├º├úo de resultado (receitas vs despesas)';


--
-- Name: fato_venda; Type: TABLE; Schema: financeiro; Owner: postgres
--

CREATE TABLE financeiro.fato_venda (
    id_venda integer NOT NULL,
    numero_pedido integer NOT NULL,
    numero_item integer NOT NULL,
    fk_tempo integer NOT NULL,
    fk_cliente integer NOT NULL,
    fk_produto integer NOT NULL,
    fk_canal_venda integer NOT NULL,
    fk_forma_pagamento integer NOT NULL,
    quantidade integer NOT NULL,
    valor_unitario numeric(10,2) NOT NULL,
    valor_total numeric(10,2) NOT NULL,
    data_hora_venda timestamp without time zone NOT NULL
);


ALTER TABLE financeiro.fato_venda OWNER TO postgres;

--
-- Name: cubo_vendas; Type: MATERIALIZED VIEW; Schema: financeiro; Owner: postgres
--

CREATE MATERIALIZED VIEW financeiro.cubo_vendas AS
 SELECT t.ano,
    t.trimestre,
    t.mes,
    t.nome_mes,
    t.dia_semana,
    cat.categoria,
    cat.subcategoria,
    cat.linha_produto,
    p.nome_produto,
    f.nome_fornecedor,
    loc.regiao AS regiao_cliente,
    loc.estado AS estado_cliente,
    loc.cidade AS cidade_cliente,
    cv.canal_venda,
    cv.tipo_canal,
    fp.forma_pagamento,
    count(*) AS qtd_vendas,
    count(DISTINCT v.numero_pedido) AS qtd_pedidos,
    count(DISTINCT v.fk_cliente) AS qtd_clientes,
    sum(v.quantidade) AS qtd_produtos_vendidos,
    sum(v.valor_total) AS faturamento_total,
    avg(v.valor_unitario) AS preco_medio,
    (sum(v.valor_total) / (NULLIF(count(DISTINCT v.numero_pedido), 0))::numeric) AS ticket_medio,
    (sum(v.valor_total) / (NULLIF(count(DISTINCT v.fk_cliente), 0))::numeric) AS faturamento_por_cliente,
    (sum(v.quantidade) / NULLIF(count(DISTINCT v.numero_pedido), 0)) AS itens_por_pedido
   FROM ((((((((financeiro.fato_venda v
     JOIN geral.dim_tempo t ON ((v.fk_tempo = t.id_tempo)))
     JOIN administrativo.dim_produtos p ON ((v.fk_produto = p.id_produto)))
     JOIN administrativo.dim_categoria_produto cat ON ((p.id_categoria = cat.id_categoria)))
     JOIN administrativo.dim_fornecedor f ON ((p.id_fornecedor = f.id_fornecedor)))
     JOIN administrativo.dim_clientes c ON ((v.fk_cliente = c.id_cliente)))
     JOIN geral.dim_localizacao loc ON ((c.fk_localizacao = loc.id_localizacao)))
     JOIN administrativo.dim_canal_venda cv ON ((v.fk_canal_venda = cv.id_canal_venda)))
     JOIN financeiro.dim_forma_pagamento fp ON ((v.fk_forma_pagamento = fp.id_forma_pagamento)))
  GROUP BY ROLLUP(t.ano, t.trimestre, t.mes, t.nome_mes, t.dia_semana, cat.categoria, cat.subcategoria, cat.linha_produto, p.nome_produto, f.nome_fornecedor, loc.regiao, loc.estado, loc.cidade, cv.canal_venda, cv.tipo_canal, fp.forma_pagamento)
  WITH NO DATA;


ALTER MATERIALIZED VIEW financeiro.cubo_vendas OWNER TO postgres;

--
-- Name: MATERIALIZED VIEW cubo_vendas; Type: COMMENT; Schema: financeiro; Owner: postgres
--

COMMENT ON MATERIALIZED VIEW financeiro.cubo_vendas IS 'Cubo OLAP de vendas - an├ílises multidimensionais com drill-down completo';


--
-- Name: dim_forma_pagamento_id_forma_pagamento_seq; Type: SEQUENCE; Schema: financeiro; Owner: postgres
--

CREATE SEQUENCE financeiro.dim_forma_pagamento_id_forma_pagamento_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE financeiro.dim_forma_pagamento_id_forma_pagamento_seq OWNER TO postgres;

--
-- Name: dim_forma_pagamento_id_forma_pagamento_seq; Type: SEQUENCE OWNED BY; Schema: financeiro; Owner: postgres
--

ALTER SEQUENCE financeiro.dim_forma_pagamento_id_forma_pagamento_seq OWNED BY financeiro.dim_forma_pagamento.id_forma_pagamento;


--
-- Name: fato_pedido; Type: TABLE; Schema: financeiro; Owner: postgres
--

CREATE TABLE financeiro.fato_pedido (
    id_pedido integer NOT NULL,
    numero_pedido integer NOT NULL,
    fk_tempo integer NOT NULL,
    fk_cliente integer NOT NULL,
    fk_canal_venda integer NOT NULL,
    fk_forma_pagamento integer NOT NULL,
    qtd_itens integer NOT NULL,
    valor_total numeric(10,2),
    valor_frete numeric(10,2),
    status_pedido character varying(20),
    data_hora_pedido timestamp without time zone NOT NULL,
    CONSTRAINT ck_status_pedido CHECK (((status_pedido)::text = ANY ((ARRAY['Pendente'::character varying, 'Confirmado'::character varying, 'Enviado'::character varying, 'Entregue'::character varying, 'Cancelado'::character varying])::text[])))
);


ALTER TABLE financeiro.fato_pedido OWNER TO postgres;

--
-- Name: fato_pedido_id_pedido_seq; Type: SEQUENCE; Schema: financeiro; Owner: postgres
--

CREATE SEQUENCE financeiro.fato_pedido_id_pedido_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE financeiro.fato_pedido_id_pedido_seq OWNER TO postgres;

--
-- Name: fato_pedido_id_pedido_seq; Type: SEQUENCE OWNED BY; Schema: financeiro; Owner: postgres
--

ALTER SEQUENCE financeiro.fato_pedido_id_pedido_seq OWNED BY financeiro.fato_pedido.id_pedido;


--
-- Name: fato_transacao_financeira_id_transacao_seq; Type: SEQUENCE; Schema: financeiro; Owner: postgres
--

CREATE SEQUENCE financeiro.fato_transacao_financeira_id_transacao_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE financeiro.fato_transacao_financeira_id_transacao_seq OWNER TO postgres;

--
-- Name: fato_transacao_financeira_id_transacao_seq; Type: SEQUENCE OWNED BY; Schema: financeiro; Owner: postgres
--

ALTER SEQUENCE financeiro.fato_transacao_financeira_id_transacao_seq OWNED BY financeiro.fato_transacao_financeira.id_transacao;


--
-- Name: fato_venda_id_venda_seq; Type: SEQUENCE; Schema: financeiro; Owner: postgres
--

CREATE SEQUENCE financeiro.fato_venda_id_venda_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE financeiro.fato_venda_id_venda_seq OWNER TO postgres;

--
-- Name: fato_venda_id_venda_seq; Type: SEQUENCE OWNED BY; Schema: financeiro; Owner: postgres
--

ALTER SEQUENCE financeiro.fato_venda_id_venda_seq OWNED BY financeiro.fato_venda.id_venda;


--
-- Name: dim_localizacao_id_localizacao_seq; Type: SEQUENCE; Schema: geral; Owner: postgres
--

CREATE SEQUENCE geral.dim_localizacao_id_localizacao_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE geral.dim_localizacao_id_localizacao_seq OWNER TO postgres;

--
-- Name: dim_localizacao_id_localizacao_seq; Type: SEQUENCE OWNED BY; Schema: geral; Owner: postgres
--

ALTER SEQUENCE geral.dim_localizacao_id_localizacao_seq OWNED BY geral.dim_localizacao.id_localizacao;


--
-- Name: dim_tempo_id_tempo_seq; Type: SEQUENCE; Schema: geral; Owner: postgres
--

CREATE SEQUENCE geral.dim_tempo_id_tempo_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE geral.dim_tempo_id_tempo_seq OWNER TO postgres;

--
-- Name: dim_tempo_id_tempo_seq; Type: SEQUENCE OWNED BY; Schema: geral; Owner: postgres
--

ALTER SEQUENCE geral.dim_tempo_id_tempo_seq OWNED BY geral.dim_tempo.id_tempo;


--
-- Name: dim_canal_venda id_canal_venda; Type: DEFAULT; Schema: administrativo; Owner: postgres
--

ALTER TABLE ONLY administrativo.dim_canal_venda ALTER COLUMN id_canal_venda SET DEFAULT nextval('administrativo.dim_canal_venda_id_canal_venda_seq'::regclass);


--
-- Name: dim_categoria_produto id_categoria; Type: DEFAULT; Schema: administrativo; Owner: postgres
--

ALTER TABLE ONLY administrativo.dim_categoria_produto ALTER COLUMN id_categoria SET DEFAULT nextval('administrativo.dim_categoria_produto_id_categoria_seq'::regclass);


--
-- Name: dim_clientes id_cliente; Type: DEFAULT; Schema: administrativo; Owner: postgres
--

ALTER TABLE ONLY administrativo.dim_clientes ALTER COLUMN id_cliente SET DEFAULT nextval('administrativo.dim_clientes_id_cliente_seq'::regclass);


--
-- Name: dim_fornecedor id_fornecedor; Type: DEFAULT; Schema: administrativo; Owner: postgres
--

ALTER TABLE ONLY administrativo.dim_fornecedor ALTER COLUMN id_fornecedor SET DEFAULT nextval('administrativo.dim_fornecedor_id_fornecedor_seq'::regclass);


--
-- Name: dim_produtos id_produto; Type: DEFAULT; Schema: administrativo; Owner: postgres
--

ALTER TABLE ONLY administrativo.dim_produtos ALTER COLUMN id_produto SET DEFAULT nextval('administrativo.dim_produtos_id_produto_seq'::regclass);


--
-- Name: dim_tipo_movimentacao id_tipo_movimentacao; Type: DEFAULT; Schema: estoque; Owner: postgres
--

ALTER TABLE ONLY estoque.dim_tipo_movimentacao ALTER COLUMN id_tipo_movimentacao SET DEFAULT nextval('estoque.dim_tipo_movimentacao_id_tipo_movimentacao_seq'::regclass);


--
-- Name: dim_transportadora id_transportadora; Type: DEFAULT; Schema: estoque; Owner: postgres
--

ALTER TABLE ONLY estoque.dim_transportadora ALTER COLUMN id_transportadora SET DEFAULT nextval('estoque.dim_transportadora_id_transportadora_seq'::regclass);


--
-- Name: fato_movimentacao_estoque id_movimentacao; Type: DEFAULT; Schema: estoque; Owner: postgres
--

ALTER TABLE ONLY estoque.fato_movimentacao_estoque ALTER COLUMN id_movimentacao SET DEFAULT nextval('estoque.fato_movimentacao_estoque_id_movimentacao_seq'::regclass);


--
-- Name: fato_pedido_frete id_frete; Type: DEFAULT; Schema: estoque; Owner: postgres
--

ALTER TABLE ONLY estoque.fato_pedido_frete ALTER COLUMN id_frete SET DEFAULT nextval('estoque.fato_pedido_frete_id_frete_seq'::regclass);


--
-- Name: dim_forma_pagamento id_forma_pagamento; Type: DEFAULT; Schema: financeiro; Owner: postgres
--

ALTER TABLE ONLY financeiro.dim_forma_pagamento ALTER COLUMN id_forma_pagamento SET DEFAULT nextval('financeiro.dim_forma_pagamento_id_forma_pagamento_seq'::regclass);


--
-- Name: fato_pedido id_pedido; Type: DEFAULT; Schema: financeiro; Owner: postgres
--

ALTER TABLE ONLY financeiro.fato_pedido ALTER COLUMN id_pedido SET DEFAULT nextval('financeiro.fato_pedido_id_pedido_seq'::regclass);


--
-- Name: fato_transacao_financeira id_transacao; Type: DEFAULT; Schema: financeiro; Owner: postgres
--

ALTER TABLE ONLY financeiro.fato_transacao_financeira ALTER COLUMN id_transacao SET DEFAULT nextval('financeiro.fato_transacao_financeira_id_transacao_seq'::regclass);


--
-- Name: fato_venda id_venda; Type: DEFAULT; Schema: financeiro; Owner: postgres
--

ALTER TABLE ONLY financeiro.fato_venda ALTER COLUMN id_venda SET DEFAULT nextval('financeiro.fato_venda_id_venda_seq'::regclass);


--
-- Name: dim_localizacao id_localizacao; Type: DEFAULT; Schema: geral; Owner: postgres
--

ALTER TABLE ONLY geral.dim_localizacao ALTER COLUMN id_localizacao SET DEFAULT nextval('geral.dim_localizacao_id_localizacao_seq'::regclass);


--
-- Name: dim_tempo id_tempo; Type: DEFAULT; Schema: geral; Owner: postgres
--

ALTER TABLE ONLY geral.dim_tempo ALTER COLUMN id_tempo SET DEFAULT nextval('geral.dim_tempo_id_tempo_seq'::regclass);


--
-- Data for Name: dim_canal_venda; Type: TABLE DATA; Schema: administrativo; Owner: postgres
--

COPY administrativo.dim_canal_venda (id_canal_venda, canal_venda, tipo_canal, ativo) FROM stdin;
1	Loja F├¡sica	F├¡sico	t
2	WhatsApp	Online	t
3	Representante	F├¡sico	t
4	Instagram	Online	t
5	Facebook	Online	t
6	Telefone	F├¡sico	t
\.


--
-- Data for Name: dim_categoria_produto; Type: TABLE DATA; Schema: administrativo; Owner: postgres
--

COPY administrativo.dim_categoria_produto (id_categoria, categoria, subcategoria, linha_produto) FROM stdin;
1	Cosm├®ticos	Colora├º├úo	Profissional
2	Cosm├®ticos	Hidrata├º├úo	Profissional
3	Cosm├®ticos	Finaliza├º├úo	Profissional
4	Cosm├®ticos	Shampoo	Profissional
5	M├│veis MDF	Console	Sal├úo
6	M├│veis MDF	Carrinho	Sal├úo
7	M├│veis MDF	Balc├úo	Sal├úo
8	M├│veis MDF	Toalheiro	Sal├úo
9	Lavat├│rio	Cuba Fibra	Sal├úo
10	Lavat├│rio	Cuba Lou├ºa	Sal├úo
11	Cadeiras	Reclin├ível	Sal├úo
12	Cadeiras	Fixa	Sal├úo
13	Acess├│rios	Ferramentas	Sal├úo
14	Manicure	\N	\N
15	Est├®tica	Maca	Cl├¡nica
\.


--
-- Data for Name: dim_clientes; Type: TABLE DATA; Schema: administrativo; Owner: postgres
--

COPY administrativo.dim_clientes (id_cliente, nome, sexo, documento, fk_localizacao, telefone, endereco_completo, created_at, update_at) FROM stdin;
1	Maria Helena	F	753.879.019-40	4	(11) 96693-3958	Rua Genaro Olavide N?? 290	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
2	Maykon Romero	M	627.708.065-92	4	(11) 95959-4002	Rua Campo Florido N?? 507	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
3	Anderson Felipe	M	007.002.324-59	3	(11) 947144469	Endere├ºo n├úo informado	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
4	Ricardo Melo Oliveira	M	107.606.970-40	3	(11)98519-8141	Endere├ºo n├úo informado	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
5	L├í├ícia Cristina	F	255.799.735-77	4	(11) 97197-6588	Endere├ºo n├úo informado	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
6	Cida Aparecida	F	265.021.806-31	4	(11) 94293-8419	Endere├ºo n├úo informado	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
7	Ivan (Representante)	M	647.469.237-75	4	(11) 99874-9468	Endere├ºo n├úo informado	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
8	Barbara Reis	F	940.477.722-46	4	(11) 96090-8983	Endere├ºo n├úo informado	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
9	Katia	F	663.029.301-60	3	(11) 97300-4662	Endere├ºo n├úo informado	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
10	Erica Rodrigues dos Santos	F	366.290.527-46	4	(11)95167-6462	Rua Forte do Triunfo N??361 Ap 32 Torre 2	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
11	Marilene Neves Dos Santos	F	758.891.489-57	3	(11)93563-8018	Avenida Sapopemba N?? 468	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
12	Cliente Loja (Sem identifica├í├í├í├ío)	\N	324.323.860-21	8	(11) 91518-8358	Endere├ºo n├úo informado	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
13	Fernando Ribeiro	M	177.163.817-37	5	(11) 99513-7213	Rua Andre Fernandes N?? 138 Vila Florida	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
14	M├í├ínica Cristina Da Cruz	F	075.294.061-79	9	(11)98560-1790	Rua Cachoreira das 7 quedas N?? 22 Barro Branco	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
15	Vilma Neves Monteiro	F	319.975.616-27	\N	(11)96017-8366	Rua Serra de Itabajara N?? 816	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
16	Maria de Fatima	F	835.527.806-23	24	(11) 98260-4336	Avenida Sapopemba N?? 15774	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
17	Antonio L.	M	816.874.861-92	4	(11) 97274-9972	Avenida Mateo Bei 3369	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
18	Joice Batista de Brito	F	650.047.562-52	4	(11)93801-6917	Avenida Mateo Bei 2635	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
19	Cliente Loja (Sem identifica├í├í├í├ío)	\N	558.227.002-25	3	(11) 91052-5255	Endere├ºo n├úo informado	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
20	Ana Carolina Elias Cardoso	F	834.410.092-65	19	(14)99654-6910	Rua Aleides Lopes Peres N??162  Agua Branca	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
21	Luzi A.	F	505.346.595-18	4	(11) 97220-6330	Endere├ºo n├úo informado	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
22	Raquel Dos Santos	F	039.932.462-65	4	(11) 94525-1165	Avenida Mateo bei 1575 Sala 03	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
23	Cliente Loja (Sem identifica├í├í├í├ío)	\N	142.483.816-41	4	(11) 96066-7047	Endere├ºo n├úo informado	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
24	Dantas (Representante)	M	679.779.546-05	\N	(11)99933-0442	Endere├ºo n├úo informado	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
25	Dibi R.	F	311.095.909-24	23	(11) 92743-4553	Rua Manoel Quirino de Mattos N??2197	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
26	Diego(Representante)	M	885.335.347-01	\N	(11) 94748-7347	Endere├ºo n├úo informado	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
27	Mariana G.	M	768.284.841-61	4	(11)96909-6757	Endere├ºo n├úo informado	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
28	Rose Machado	F	003.122.409-84	4	(11)95811-2159	Rua Doutor Paulo Queiroz N??1794	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
29	Raquel Lima	F	771.568.053-00	4	(11)987650376	Avenida Mateo Bei 5786	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
30	Roseli Emilia	F	915.867.333-02	\N	(11)99155-6818	Rua Ilha de Capri N??225	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
31	Ivonete Alves	F	659.726.546-69	4	(11)98726-6055	Rua Conego Antonio Dias Pequeno n??51	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
32	Ant├í├ínia	F	429.531.568-55	3	(11) 93500-9245	Endere├ºo n├úo informado	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
33	Thabata Camargo	F	852.858.691-84	10	(11)97303-2714	Avenida Jo??o Batista Media N?? 302	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
34	Cliente Loja (Sem identifica├í├í├í├ío)	M	556.069.510-47	11	(11) 98381-4642	Endere├ºo n├úo informado	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
35	Amanda Cintia	F	284.529.949-13	4	(11)95219-8895	Travessa Paz na Terra N??77 Jd da Conquista	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
36	Fabiane T.	F	538.022.551-41	4	(11)99742-1120	Rua Esquivel Navarro N??118	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
37	Valeria Rocha	F	776.612.170-32	4	(11)98285-5735	Rua Carlos Cossi N??13	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
38	Geyja L.	F	040.690.912-55	4	(11) 96383-1568	Endere├ºo n├úo informado	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
39	Hellen Cristina	F	822.390.327-23	4	(11)9977-5750	Rua Francicos dos Santos Coimbra N??128	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
40	Gabriel Barbearia XV Novembro	M	472.466.677-93	19	(11) 94526266	Rua XV de Novembro 265	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
41	Daniel (Representante)	M	890.784.564-01	\N	(11) 99714-9883	Endere├ºo n├úo informado	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
42	Ant├í├ínio Correia	M	509.459.874-17	4	(11)94915-1442	Rua Jo??o Gomes Pereira N??953	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
43	Rosangela A.	F	703.046.155-59	4	(11) 95447-1071	Endere├ºo n├úo informado	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
44	Simone Gama da Silva	F	414.778.107-61	4	(11)99374-7123	Travessa Henrique Guerrer N??49 Fazenda da Juta	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
45	F├í├ítima F.	F	861.897.631-13	\N	(11) 96907-8488	Endere├ºo n├úo informado	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
46	Elisangela R.	F	106.053.052-75	4	(11) 92774-6325	Avenida Ragueb Chofi	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
47	Hellen Almeida	F	368.210.826-79	\N	(11)94977-5750	Rua Afranio Peixoto N??224 Jd. Utigna	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
48	Claudiana M.	F	651.122.038-38	3	(11) 98325-2067	Endere├ºo n├úo informado	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
49	Celeste Silva	F	168.009.913-28	4	(11) 99889-5925	Rua Conego Antonio Dias Pequeno n??483	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
50	Penha Jardim Marilu	F	528.471.826-40	4	(11)94731-9812	Endere├ºo n├úo informado	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
51	Raquel L.	F	919.351.007-92	3	(11) 91087-9004	Endere├ºo n├úo informado	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
52	Natally da Silva	F	505.993.638-35	4	(11)95222-8204	Travessa Salassie N??92 Jd da Conquista	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
53	Luanne Fernandes Leite	F	917.736.263-14	4	(11) 96072-5414	Rua Domingos Ribeiro N?? 12 Jardim Ester	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
54	Deja Pereira	F	638.769.233-26	4	(11)98739-7509	Rua Doutor Miguel Bombarda N??251	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
55	Lorraine Pinheiro	F	189.352.752-45	4	(11) 96056-5864	Jd Sapopemba	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
56	Deca (Representante)	M	579.496.457-83	\N	(11) 99830-3631	Endere├ºo n├úo informado	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
57	Eliane Souza	F	885.541.755-55	12	(11) 99122-2886	Rua Geronimo Coelho N??225	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
58	Fabr├í├ício A.	M	218.366.893-80	4	(11) 97075-9363	Jd. Santo Andr??	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
59	Katia N.	F	272.131.160-23	4	(11) 92180-6228	Jd. S??o Roberto	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
60	Cristiane Aciolli	F	442.111.607-70	13	(11)9810-54759	Avenida Rio das Pedras N??3522	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
61	Vera Lucia Alexandre	F	738.456.162-57	14	(11)98844-4272	Rua Delmiro Gouveia N??265	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
62	Ane Almeida	F	095.874.158-40	\N	(11)99387-8464	Rua Madagascar N??12 Sala 04	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
63	Fernando	M	175.646.829-32	\N	(11) 93525-3293	Endere├ºo n├úo informado	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
64	Rosangela Marques	F	729.099.920-73	4	(11)98253-2165	Rua Jo??o Gomes Pereira N??95	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
65	Graciene Lopes	F	391.827.954-35	15	(11)98729-0348	Rua Itamarati N??44 Heliopolis	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
66	Gabriela N.	F	714.107.264-35	4	(11) 95339-6445	Avenida Maria Cursi	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
67	Ana Paula	F	914.709.563-38	\N	(11) 96348-8971	Grimaldi	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
68	Ana Paula Ferreira	F	364.561.885-85	16	(11)99571-8383	Rua Santo Ouvidio N??208	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
69	Samires Silva	F	960.275.449-88	4	(11) 92078-4225	Rua Maestro Isa??as Savio N??317	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
70	Charleide Costa	F	628.116.399-21	\N	(11) 91615-8868	Rua Evangelista de Souza N??1609	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
71	Leandro (Barbearia Five Stars)	M	100.608.828-12	9	(11) 99705-7880	Av. Doutor Guilherme de Abreu Sodre N??51	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
72	J├í├í Novaes	F	389.903.302-54	\N	(11) 91544-8777	Rua Bento Pires Ribeiro N??4  Jd Santo Andre	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
73	Cleusa A.	F	486.517.276-18	21	(11) 97055-4684	Endere├ºo n├úo informado	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
74	Nalva	F	255.443.076-38	\N	(11) 94889-1276	Endere├ºo n├úo informado	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
75	Francisco Rocha	M	555.602.819-44	4	(11)95637-9826	Rua Jacarand?? Mimoso N??19	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
76	Solage Rodrigues	F	334.493.099-54	4	(11)95045-1206	Avenida Riacho dos Machados N??417	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
77	Vileuda Ribeiro	F	577.568.258-53	17	(11)99390-6584	Rua Ana Popovice N??130	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
78	Eliete Acltastel	F	826.281.464-88	4	(11)99937-8612	Rua Luiz Botta N??304	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
79	Katheleen F.	F	722.682.790-06	4	(11)98548-9107	Rua Astart?? N??103	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
80	Pele Ferreira	M	863.668.875-94	14	(11) 98249-4228	Endere├ºo n├úo informado	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
81	Bruna Rodrigues	F	386.596.751-67	4	(11) 97764-7470	Endere├ºo n├úo informado	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
82	Vitor Lucio	M	548.668.107-17	4	(11)94015-7727	Av. Osvaldo Vale Cordeiro	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
83	Suelen V.	F	147.235.899-09	\N	(11) 95310-5131	Rua Suecia N??16 Parque das Na????es	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
84	Lilian Regina Alves	F	427.146.247-71	\N	(11)99306-8809	Rua Duque de Caxias N??47	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
85	Paulo C.	M	407.452.066-92	3	(11)995137213	Av. Brigadeira Faria Lima	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
86	Maria Aparecida N.	F	850.686.258-58	\N	(11)95798-7196	Rua Francisco Miguinone 905	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
87	Micheli Souza	F	770.048.275-07	4	(11)98892-6760	Rua S??o Francisco N??17	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
88	Priscila Soares Dos Santos	F	806.812.550-07	4	(11)99016-1352	Rua Solidonio Leite N??2410 Sala 4	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
89	Bianka Bianchi	F	044.280.463-45	4	(11)98436-9366	Rua Cachoeira de Minas N??355A	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
90	Francisco Rocha	M	147.584.916-09	\N	(11) 96973-7393	Jd. Arantes	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
91	Michele Castro	F	715.847.078-39	8	(11)98892-6760	Rua Dias Lemes N??18	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
92	Bruna Ferreira	F	824.408.720-84	4	(11) 91613-1183	St. Ad??lia	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
93	Marcos (Representante)	M	286.917.786-58	27	(11) 97421-3593	Endere├ºo n├úo informado	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
94	Silmara A.	F	890.364.693-67	4	(11) 95417-8864	Avenida Alto Alegre	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
95	Fl├í├ívio Souza	M	304.312.627-43	9	(11) 94345-2216	Endere├ºo n├úo informado	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
96	Riso Josefa Santos	F	306.851.277-79	4	(11)96659-1084	Rua Jacob Santos N??18A	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
97	Cristiane Vieira Nunes	F	156.591.941-68	4	(11)94822-8431	Rua Manoel da Luz Drummond N??360	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
98	Israel Mendes da Silva	F	279.553.776-48	17	(11)94885-1447	Av. Arquiteto Vila Nova N??229	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
99	Kayque Fernando	M	843.377.276-07	4	(11)96437-0863	Avenida Via de Pedeste Silecia	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
100	J├í├íssica Pereira	F	853.215.019-94	4	(11)96348-1525	Rua Francisco de Melo Palheta N??706	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
101	Eduardo Cerrades	M	067.521.297-82	\N	(11)94489-2080	Avenida Nagib Farah Maluf N??407	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
102	Jinelson A.	M	934.098.003-49	4	(11) 91095-1891	Vila Primavera	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
103	Gustavo Mainairt	M	952.979.516-62	\N	(11) 99099-9257	Rua Francisco Louren??o N??1	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
104	Jawila De Paula	F	551.957.192-60	4	(11)95843-7443	Rua Antonio Caetinho N??192	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
105	Tiago Gon├í├íalves Dias	M	961.448.329-99	4	(11)98367-1954	Rua James Naris N??296	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
106	Carlos Allan	M	862.637.805-07	4	(11)98544-565	Rua Maria Luiza Val Penteado N??616	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
107	Edinho(Representante)	M	788.463.542-44	\N	(11) 93098-8432	Endere├ºo n├úo informado	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
108	Roberto	M	506.865.510-87	8	(11) 98332-3633	Endere├ºo n├úo informado	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
109	Cintia Stoko	F	079.808.877-09	4	(11)98706-1295	Rua Abilio Campos Peixe N??111	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
110	Crislane Dos Santos Alves	F	042.264.193-31	4	(11)95244-9477	Rua M??o Rainha N??62	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
111	Rosilda(Representante)	F	580.003.126-50	26	(11) 99952-4892	Endere├ºo n├úo informado	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
112	Ivaneide Silva	F	718.169.975-25	\N	(11)96458-4006	Rua Ingair N??32	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
113	Ant├í├ínio F. Pereira	M	324.631.157-68	4	(11)94914-3787	Rua Noite de Maio N??315	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
114	Neusa Esteves Samuel	F	880.385.619-80	\N	(11)94923-7120	Rua Greg??rio Petondi S/N	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
115	Sandra Moura	F	967.037.063-97	4	(11)97600-5769	Rua Rui Deaveiro N??48	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
116	Andreia Cristina de Souza	F	998.247.800-18	14	(11)99549-4115	Rua Soldado Candido da Luz Paiva N??223	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
117	Hilario T.	M	544.459.238-66	\N	(11)95297-2274	Av. Dr Frederico Martins da Costa Carvalo N??653	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
118	Edson Barbosa	M	108.222.690-68	4	(11)95305-1914	Rua Andre de Almeida N??897	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
119	T├í├ínia Teixeira Brito	F	539.739.741-74	4	(11)95439-7295	Av. Ragueb Chofi N??5097	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
120	Suzi Daiane	F	079.866.697-17	\N	(11)96017-5836	Rua 15 de Novembro	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
121	Caroline S.	F	688.895.905-81	4	(11) 93882-2170	Sapopemba	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
122	Edson Freire	M	501.862.862-93	4	(11) 97386-3002	Endere├ºo n├úo informado	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
123	Mazin R.	M	541.160.871-13	27	(11)94821-4152	Rua Giacinto Tognato N??755	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
124	Pamela Riveles	F	006.335.907-83	\N	(11)96307-2605	Endere├ºo n├úo informado	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
125	Ana Caroline	F	552.287.707-36	4	(11)93941-7742	Rua Serra Borborena N??20	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
126	Luzia Alves	F	828.801.902-92	\N	(11)98869-0143	Rua Doutor Tost??i de Carvalho	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
127	Ti├í├ío Menezes	M	477.526.292-47	4	(11)97651-3541	Rua Sebasti??o Mendon??a N??55	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
128	Rog├í├írio Torres	M	196.022.683-50	\N	(11)98352-7519	Rua Tuiuti N??2724	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
129	Wesley F.	M	501.448.355-84	4	(11)95854-3714	Rua Manoel Quirino de Mattos N??1769	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
130	Angelina N.	F	557.713.198-60	\N	(11) 99773-4113	Rua Jer??nimo Gon??alves N??162	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
131	Adelma Alves	F	710.595.559-33	\N	(11)94893-7253	Rua Ilha Trindade N??578	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
132	Celma Souza	F	142.429.995-17	4	(11) 96556-7270	Endere├ºo n├úo informado	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
133	Cida Fernandes	F	495.545.870-48	4	(11)96613-2939	Endere├ºo n├úo informado	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
134	Soraia A.	F	664.293.555-09	4	(11) 92947-7069	Endere├ºo n├úo informado	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
135	Edgard L.	M	949.246.545-12	\N	(11) 91160-1556	Rua Orquidea N??50	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
136	Cinval Antunes	M	609.913.661-91	8	(11)95489-1324	Avenida Orat??rio N??5075	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
137	Paulo Cesar de Oliveira	M	473.452.234-24	4	(11)95783-1791	Rua Miguel Lobo N??100	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
138	Higor Santana Dos Santos	M	953.347.628-11	\N	(11)97645-9871	Rua Erechin N??12 Itamarati	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
139	Maycon A,	M	854.492.952-24	4	(11) 95796-1797	Endere├ºo n├úo informado	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
140	Lanya Souza	F	390.646.103-97	4	(11) 91052-3111	Rua Eliisio Ferreira N??438	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
141	Gilvam (Representante)	M	252.700.054-77	\N	(11) 97166-6555	Endere├ºo n├úo informado	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
142	Adban Vietoc Chaves	M	919.128.830-75	4	(11)94977-1842	Endere├ºo n├úo informado	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
143	Helena Santos	F	560.937.128-28	4	(11)94599-9124	Rua Cachoeira de Minas N??56B	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
144	Nilsa Nunes	F	873.249.756-46	4	(11) 91631-9407	Endere├ºo n├úo informado	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
145	Rodrigo Bezerra Joaquim	M	332.778.456-90	4	(11)96798-9242	Rua Luiz Bota N??1249	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
146	Clayton Silva	M	839.229.973-44	\N	(11)97969-5863	Rua Aldeia Santo In??cio N??816	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
147	Edneide Oliveira	F	591.509.728-21	17	(11)95990-9213	Rua Alberto Popovice N??170	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
148	Rog├í├írio (Representante)	M	661.936.238-29	\N	(11) 93082-3710	Endere├ºo n├úo informado	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
149	Venaldo (Representante)	M	582.659.139-75	\N	(11) 93568-3507	Endere├ºo n├úo informado	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
150	Will Melo	M	525.332.713-88	\N	(11)93077-8711	Rua Vice Presidente Francisco Alvaro Bueno N??218	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
151	Josefa Da Silva	F	816.321.851-66	13	(11)98195-9346	Avenida dos Latinos N??1554	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
152	Claudio Nunes	M	341.470.071-55	\N	(11)98833-8399	Rua Orfanato N??1071	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
153	Andreia Cerrantes	F	772.510.101-41	9	(11)94230-3068	Rua Santa Fl??via Donatella N??85	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
154	Irene Concei├í├í├í├ío	F	165.448.755-59	17	(11)95396-2637	Avenida Cust??dio de S?? N??630	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
155	Gilma Vieira	F	195.839.089-25	\N	(11)95025-6549	Rua do Gino N??10	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
156	Joelma Dos Santos	F	432.175.941-51	\N	(11) 95032-4755	Rua Dentista Barreto N??572	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
157	Ana Caroline Machado	F	833.157.742-10	4	(11)96367-0812	Travessa Sabor de Mim N??532	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
158	Alan Souza	M	122.885.888-29	\N	(11)94013-8985	Rua Imirim N??832	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
159	Elaine da Silva Souza	F	374.933.433-12	\N	(11)98995-7815	Rua Miguel Ferreira de Melo N??01	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
160	Steven Ferreira	M	072.941.286-75	13	(11) 92286-7475	Endere├ºo n├úo informado	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
161	Maria Ivone Campos	F	893.353.143-25	\N	(11)95420-6919	Rua Baltazar Vidal N??206	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
162	Ros├í├íngela Souza	F	036.533.497-92	\N	(11) 93026-1350	Rua Jo??o Gomes Pereira N??953	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
163	Eduardo Teixeira	M	289.645.562-14	14	(11)981262983	Avenida Israel Fonseca N??162	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
164	Jo├í├ío Ant├í├ínio Freire	M	871.061.766-64	\N	(11) 94542-1753	Rua Marcos Ant??nio Marques N??36A	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
165	Ant├í├ínia Sanches	F	915.712.351-94	\N	(11095900-2374	Rua Baltazar Vidal N??220	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
166	Neves Silva	F	188.013.918-91	\N	(11) 97893-4375	Endere├ºo n├úo informado	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
167	Amanda Nogueira	F	753.522.255-04	\N	(11) 97504-7147	Endere├ºo n├úo informado	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
168	Alex Silva	M	243.666.727-22	4	(11)98302-9588	Avenida Francisco de Santa Maria N??1219	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
169	Francisco Rocha Brito	M	362.207.106-96	4	(11)95637-9826	Rua Jacund?? Mimoso N??19	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
170	Maria Alice Nunes	F	332.090.789-30	\N	(11) 92380-1298	Endere├ºo n├úo informado	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
171	Regina Cristina Almeida	F	126.310.539-18	\N	(11) 91201-4056	Endere├ºo n├úo informado	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
172	Daniela Bas├í├ílio Silva	F	343.782.243-60	4	(11)95148-7210	Rua Fernando Dias Paes N??645	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
173	Danilo Pereira da Silva	M	226.526.089-60	4	(11)9334-29291	Rua Forro das Pedras N??901	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
174	Francisco Souza	F	713.369.197-67	4	(11) 92027-1040	Endere├ºo n├úo informado	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
175	Maria Ines Jala	F	085.580.976-36	\N	(11)98426-7746	Av. Roberto Pires Maciel	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
176	B├í├íbara Kellen	F	184.506.819-79	\N	(11)95289-1037	Rua Santa Rosa N??212	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
177	Joyce Brambillo	F	970.121.454-66	4	(11)99733-6905	Av. Sapopemba N??28509	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
178	Nathalia Porto	F	308.319.973-40	4	(11)96933-4109	Rua Felipe Marinete N??366	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
179	Felicia Manoela Nunes	F	892.231.930-06	\N	(11) 97934-1079	Endere├ºo n├úo informado	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
180	Adson F.(Representante)	M	375.446.601-96	16	(11) 97748-4637	Endere├ºo n├úo informado	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
181	Laiane Fernandes	F	483.466.969-54	\N	(11)93372-6148	Avenida Dos Sertanista 1175B	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
182	Beatriz Godoy	F	428.408.511-02	\N	(11) 91218-4833	Rua Teresina Dos Santos N??464	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
183	Dinho Gomes	M	200.604.826-69	\N	(11)96236-7890	Rua Confidera????o dos Tom??es N??397	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
184	Mariele Ferreira	F	503.881.712-91	4	(11)93012-5060	Rua Embaixador Ioldefonso Falc??o N??132	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
185	Fernando Soares	M	163.401.181-90	14	(11)94710-3027	Av. Vila Ema N??5621	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
186	Alex Nery dos Santos	M	719.405.201-96	4	(11)95822-4990	Rua Marcos Freire N??1	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
187	Mayra Barros	F	608.443.453-47	\N	(11)94011-7350	Av. Dom Pedro I N??392	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
188	Helio Souza	M	674.607.368-55	4	(11) 91803-6220	Av Mateo Bei N??7746	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
189	Evellyn Souza	F	674.526.512-31	4	(11)98655-8394	Rua Torres Florencio E. Rieli N??89	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
190	Beatriz Silva	F	198.307.249-48	12	(11)94016-8892	Rua Batista Francisco N??791	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
191	Geane Aparecida Garcia	F	026.387.454-65	4	(11)99580-4858	Av. Jos?? Rodrigues Santarem N??1135	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
192	Erica Lozano	F	299.262.251-90	\N	(11)99995-3040	Rua Major Paladino N??510	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
193	Danizete Leite	F	590.763.705-37	\N	(11)95259-9467	Rua Chantal N??22	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
194	Fernando Antero	M	462.406.216-01	\N	(11)99805-3899	Rua Benedito Leite N??29	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
195	Irene Silva	F	409.153.279-64	\N	(11) 98707-4732	Endere├ºo n├úo informado	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
196	Larrisa de Paula	F	645.116.628-56	4	(11)98139-7772	Rua Flores da Primavera N??31	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
197	Julia Pedrosa	F	693.589.652-17	5	(11)97479-3520	Endere├ºo n├úo informado	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
198	Liliane De Jesus	F	524.495.593-52	3	(11)95299-4018	Rua Nova Bras??lia 69A	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
199	Ant├í├ínio Bezerra	F	238.006.836-24	4	(11)97738-7054	Rua Estrada da Adutora Rio Claro N??3	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
200	Claudinei Gomes de Souza	F	988.125.973-34	4	(11) 91974-5935	Rua Confedera????o Dos Tamoios N??397	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
201	Denise Ferreira	F	732.754.233-73	\N	(11)99171-2238	Rua Pedro de Castro Velho N??478	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
202	Janaina Moreira Ferreira	F	695.139.090-59	4	(11)97984-6343	Avenida Sapopemba 14B	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
203	Jhony Moraes	F	475.722.886-11	\N	(11) 92604-8502	Endere├ºo n├úo informado	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
204	Etevaldo Alexandre	M	168.928.216-94	3	(11) 96277-7422	Endere├ºo n├úo informado	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
205	Cristiane Correa	F	193.031.032-29	4	(11) 91714-4850	Endere├ºo n├úo informado	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
206	Kleber De Souza Oliveira	M	518.986.527-90	4	(11)96070-4177	Endere├ºo n├úo informado	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
207	Suelen Vasconcelos	F	011.794.163-61	4	(11)97444-4035	Rua Triste Berante N??45	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
208	Let├í├ícia Oliveira	F	863.955.477-67	4	(11)94903-7922	Travessa Tantos Caminhos N??212	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
209	Jocelino Santos	F	372.184.195-22	4	(11)98850-0758	Rua Passagem Eduardo Ledevim N??56	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
210	F├í├íbio Jos├í├í Silva	M	914.233.125-36	\N	(11)98974-0112	Rua Miguel Ferreira de Melo N??73	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
211	Priscila Ferras	F	080.967.573-99	\N	(11)99178-8675	Rua Tolst??i de Carvalho N??35	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
212	Claudio Martinho	M	695.855.262-58	\N	(11) 96511-1474	Endere├ºo n├úo informado	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
213	Dionete Ferraz	F	770.110.698-90	4	(11) 99949-5303	Endere├ºo n├úo informado	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
214	Agenor Alves de Freitas	M	320.307.209-79	\N	(11)99690-6210	Estrada do Carneiro N??2923	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
215	Shirley Cristina	F	935.851.609-41	23	(11)97146-0908	Rua Everton Ressa N??211	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
216	Marcelo Araujo	M	935.620.010-06	8	(11)93302-1150	Rua da Mooca N??2505	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
217	Rafael Silva	M	496.285.877-02	13	(11)98638-4853	Avenida Rio das Pedras N??4021	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
218	Edilene Da Silva Severiano	F	750.150.505-79	\N	(11)97173-7715	Rua Ant??nio de Mendon??a N??15	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
219	Viviane Oliveira Pereira	F	745.888.841-78	\N	(11)98620-5941	Rua Raimundo de Oliveira N??240	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
220	Fabr├í├ício Ferreira	M	382.581.355-56	\N	(11)97711-1512	Rua Vit??rio Azadia N??547	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
221	Evandro Oliveira	M	328.724.557-51	\N	(11)99485-0832	Rua Nova Alian??a N??3	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
222	Ingrid Lacerda Santos	F	603.586.192-35	4	(11)98382-7258	Rua Roberto Park N??55	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
223	Simone dos Santos	F	926.442.301-85	\N	(11)99689-0401	Rua Pedro Corte Real N??132	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
224	Andr├í├í Luiz Farias	M	120.977.959-90	4	(11)94565-0052	Rua Flores da Primavera N??38	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
225	Samey Da Silva	F	150.140.471-52	4	(11)96984-6704	Rua Erva Imperial N??595	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
226	Hugo Tiago Teixeira	F	711.965.718-25	4	(11)97391-1705	Av. Sapopemba N??23011	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
227	Demirio Andr├í├í	M	389.524.603-88	4	(11) 91309-7124	Rua Flora da Primavera	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
228	Joelma Lima	F	123.975.568-65	4	(11)98606-1552	Rua Doutor Dan N??111	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
229	Patr├í├ícia Rodrigues	F	224.472.064-80	29	(11) 91334-9486	Endere├ºo n├úo informado	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
230	Cleusa Ferreira	F	449.092.615-90	11	(11)944759097	Rua Miguel Fernandes N??74	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
231	Fabiana Reis	F	611.240.124-59	\N	(11) 99630-7650	Endere├ºo n├úo informado	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
232	Nilda Nunes	F	510.394.824-38	12	(11)95164-5394	Rua Paulo Sergio N??14	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
233	Nadia Brito	F	913.451.322-89	4	(69)99279-3343	Rua Confedera????o Dos Tamoios N??342	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
234	Caio Gustavo	M	136.239.793-85	\N	(11)98334-5304	Rua C??u Azul N??21	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
235	Monaliza A.	F	008.715.166-21	4	(11) 99856-1098	Endere├ºo n├úo informado	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
236	Cristiane Sampaio Aciolli	F	388.270.057-18	13	(11)98105-4759	Av. Rio das Pedras N??3524	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
237	Elaine Cristina de Angela	F	220.146.516-71	\N	(14)99769-2502	Endere├ºo n├úo informado	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
238	Jeane Rodrigues	F	659.166.301-47	4	(11)96611-4040	Rua Carlos Cossi N??145	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
239	Higor Rocha	M	906.536.372-55	\N	(11)95485-8815	Rua Damo??o Fernandes N??105	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
240	Caio Almeida Freire	M	625.453.893-69	4	(11)96870-1103	Endere├ºo n├úo informado	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
241	Liss Ferreira	F	153.953.976-59	4	(11) 91427-5168	Travessa Terras do Sul N??168	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
242	Claudio de Jesus	M	099.783.320-87	4	(11)95109-7576	Endere├ºo n├úo informado	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
243	Juliano Flores Almeida	M	422.695.134-83	4	(11)96974-4874	Rua Paulino CursI N??577	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
244	Marcia Alves	F	830.422.171-02	4	(11)95142-3615	Rua Paca N??665A	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
245	Orlando Silva Souza	M	863.041.324-22	\N	(11)94940-0878	Avenida Luiz Pires de Minas N??31	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
246	Ronaldo Dias	M	995.132.218-25	4	(11)94467-3637	Avenida Sapopemba N??9044	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
247	Bianca Gomes	F	945.340.605-38	4	(11)95434-8184	Rua Morro das Pedras N??310	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
248	Daniela Santos Silva	F	189.916.532-83	16	(11)96016-8618	Rua Frank Domingos Bochia N??46	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
249	Crislene Vieira Nunes	F	408.055.651-20	4	(11)93146-3425	Rua Manoel da Luz Drummond N??630	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
250	Damabiah Lana Moraes	F	185.252.904-76	8	(11)99964-7112	Rua Doutor Jos?? Higino N??729	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
251	Viviane Alves	F	207.558.324-52	\N	(11)93295-2325	Rua Jequitiba Branco N??10	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
252	Bruna Fagundes	F	396.654.045-36	4	(11)98897-3181	Rua Boa Fam??lia N??678	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
253	Luciana Alves	F	828.439.754-15	16	(11)94886-9713	Rua Sargento Osvaldo Concei????o N??78	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
254	Marianilda de Andrade	F	230.486.068-08	9	(11)95447-4435	Rua Vargas Nova N??31	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
255	Arinne Cavalcante da Silva	F	783.910.092-34	\N	(11)95015-3046	Rua Armada Cabralina N??61	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
256	Lucas Alexandre	M	634.788.192-53	\N	(11)4059-4446	Rua Anny N??1262	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
257	Fernando Martins	M	410.247.266-50	\N	(11) 97715-4474	Endere├ºo n├úo informado	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
258	Nice Ferreira	F	313.814.825-09	4	(11)95912-0468	Rua Jo??o Batista Conti N??498	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
259	Luziane da Silva	F	609.037.703-60	5	(11)99420-4505	Avenida Jasmine N??29	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
260	Caio Gon├í├íalves	M	488.981.319-22	4	(11)95216-5369	Travessa Sabor de Mim N??19A	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
261	Ana Paula Santos	F	657.388.974-04	15	(11) 94250-2712	Endere├ºo n├úo informado	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
262	Jo├í├ío Pedro Silva	F	417.641.436-93	\N	(11)98748-6593	Avenida Dos Sertanista 1176B	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
263	Juliana Monteiro	F	522.755.280-84	4	(11)99105-8309	Rua Touro N??170	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
264	Danubia Silva Araujo	F	763.222.605-32	\N	(11) 98623-4097	Rua 06 Quadra17 Lote07	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
265	Adriana Marreiros Alves	F	805.461.831-81	\N	(21)98839-8685	Rua Coronel Raul Costa N??335	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
266	Eduardo Santos	M	105.074.883-14	4	(11)94886-5039	Rua Francisco Matias N??117A	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
267	Jos├í├í Maria Dos Santos	M	574.624.089-89	\N	(85)98944-4484	Rua do Campo N??71	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
268	Eliete Fernandes	F	656.713.430-43	4	(11)2015-8891	Rua Agostinho de Magalh??es N??280	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
269	Betoldo Nunes	F	736.498.438-96	8	(11) 97733-5859	Endere├ºo n├úo informado	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
270	Luana Almeida	F	299.681.077-27	9	(11) 96034-1218	Endere├ºo n├úo informado	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
271	Sergio Ferreira	M	439.707.323-55	\N	(11) 97535-1505	Endere├ºo n├úo informado	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
272	M├í├ínica Janaina dos Santos	F	076.134.924-79	\N	(21)99847-9514	Rua Calixto Fernandes das Neves N??648	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
273	Fabiana Gomes Leal	F	137.352.499-94	\N	(99)99180-5473	Rua Iamante J??nior N??513	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
274	Davi Souza	M	504.644.443-62	4	(11)93380-7526	Rua El??sio Ferreira N??88	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
275	Orlando(Representante)	M	302.134.425-82	5	(11) 95758-9803	Endere├ºo n├úo informado	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
276	C├í├ícera Romano	F	818.162.073-19	4	(11)94542-9006	Rua Pedro Ramazani N??2000	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
277	Reinaldo Fernandes	M	249.215.940-94	4	(11)91357-5173	Avenida Doutor Guilherme de Abreu Sodre N??1492	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
278	Cristina Beltrano	F	337.011.934-30	13	(11) 95905-1578	Endere├ºo n├úo informado	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
279	Janilson F.	M	896.298.315-75	4	(11)95984-3444	Rua Alcelmo Almeida Monteiro	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
280	Rodrigo Ferreira da Silva	M	930.368.892-21	\N	(11) 92745-1450	Rua Rodolfo Corsi N??234	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
281	Renan Souza	M	900.089.780-83	5	(11) 96815-3884	Endere├ºo n├úo informado	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
282	Sheila Cristina dos Santos da Costa	F	674.624.605-94	\N	(11) 98069-5623	Rua Passagem de S??o Pedro N??326	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
283	Juliana Cristina da Silva	F	990.089.891-38	4	(11)94008-0631	Avenida Jos?? Velho Barreto N??142	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
284	Jane Malveira Bianco	F	446.421.516-29	\N	(11)97309-3112	Rua Ettore Ximenes N??350 Sl 04	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
285	Vanusa Santos	F	681.692.592-96	\N	(11)96398-4192	Rua Aldeia Maria N??193	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
286	Geisa Cristina	F	485.133.772-27	\N	(11)95811-6617	Travessa Edith Evans N??45	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
287	M├í├ínica Ferreira Silva	F	745.675.042-61	\N	(99)99118-2997	Rua Radical Norte Qd24 Lote15	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
288	Celi Patr├í├ício Lins	F	531.984.683-34	15	(11)98107-1980	Av. Carioca N??813	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
289	Eduardo Nunes	M	689.838.541-12	16	(11)94489-2080	Av. Nagib Farah Maluf N??408	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
290	Joyce Santos	F	433.152.844-44	4	(11)93801-6917	Av. Mateo Bei N??2635	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
291	Lurdes Alves	F	450.130.395-10	4	(11)98637-5994	Rua Felipe Castrin N??251	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
292	Juliana Dos Anjos	F	728.306.787-43	\N	(11)94594-8839	Alameda Benfort N??50	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
293	Barbara Aline Diogo da Silva	F	436.734.721-41	\N	(11) 99310-8075	Rua Manoel Gerv??sio N??158	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
294	Gil Raimundo	M	955.627.567-85	4	(11)99847-2274	Rua Padre Luiz de Birquina N??444	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
295	Manoel Souza	M	392.157.063-34	4	(11) 97966-1384	Endere├ºo n├úo informado	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
296	Ornilda de Abreu	F	052.803.726-47	\N	(11) 96106-7474	Endere├ºo n├úo informado	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
297	Bet├í├ínia	F	122.968.837-50	\N	(11)97532-7002	Rua Delta N??381	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
298	C├í├íssia Pelose	F	355.122.824-13	\N	(11) 96148-9873	Endere├ºo n├úo informado	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
299	Jo├í├ío Gabriel	M	527.214.496-91	5	(11)98768-0921	Av. Alberto Lupo N??2c	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
300	Luzinete Rodrigues	F	088.942.869-45	\N	(11)99297-4620	Travessa S??o Sebasti??o N??11	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
301	P├í├ímela Lima	F	417.686.217-37	\N	(11)96307-2605	Endere├ºo n├úo informado	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
302	Anderson de Andrade	M	674.346.470-92	4	(11)95901-4184	Rua S??rios N??49	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
303	Edvaldo Moraes	M	047.565.600-04	\N	(11) 96526-3281	Rua Estrada dos Fidelis N??97	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
304	Geisa Paulino de Melo	F	754.046.265-49	4	(11)98559-4062	Rua Amalia Cordelli Cardenoto N??31	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
305	Felipe Santos da Silva	M	465.612.489-45	4	(11)96837-6650	Endere├ºo n├úo informado	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
306	Ang├í├ílica Ferreira	F	595.936.491-26	\N	(11)91025-6560	Rua Manoel de Abreu N??26	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
307	Geraldo Carlos Prestes	M	144.247.855-77	4	(11) 91394-9980	Endere├ºo n├úo informado	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
308	Wesley Bittencourt	F	518.110.205-43	3	(11)99940-0893	Endere├ºo n├úo informado	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
309	Angela Maria de F├í├ítima	F	827.800.345-16	\N	(11)95757-5421	Av. Moraes Costa N??108 Sala 5	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
310	Cilene Ribeiro Alves	F	573.181.407-84	14	(11)96522-5888	Av. Vila Ema N??2349	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
311	Rafael Moreira	M	327.194.012-26	9	(11) 91164-6497	Endere├ºo n├úo informado	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
312	Jos├í├í Leandro Bueno	M	861.493.150-83	4	(11)99194-9639	Rua Domisiano Rossi N??630	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
313	Douglas Campos	M	072.379.096-05	4	(11) 92463-2816	Rua Doutor Felice Buscaglia 397	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
314	Larissa Concei├í├í├í├ío dos Santos	F	761.801.128-30	8	(11)98501-5809	Rua Doutor Jos?? Higino N??890	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
315	Silvana Simplicio	F	338.190.191-29	4	(11)98440-7406	Av. Cl??udio Augusto Fernandes N??754	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
316	Maria das Gra├í├ías dos Santos	F	217.928.708-34	\N	(11)99517-2348	Rua Tom?? da Rocha N??67	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
317	Alana Cristina	F	652.247.844-91	4	(11)96197-3030	Endere├ºo n├úo informado	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
318	Mary Barbosa	F	271.391.993-81	4	(11)95199-9520	Rua Manoel Rebelo N??126	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
319	Lucas De Oliveira Almeida	M	609.427.472-67	\N	(28)99914-7036	Rua Cacapava N??07	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
320	Natalia Nazar da Silva	F	183.581.851-86	4	(11)98436-8091	Rua Bnadeira de Aracambi N??430	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
321	Jurandir Freitas (Representante)	M	909.954.264-65	16	(11) 92086-2395	Endere├ºo n├úo informado	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
322	Thiago Barbosa	M	213.700.897-96	4	(11)98226-8063	Rua Felipe Marinete N??324	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
323	Isabel M.	M	101.759.949-52	\N	(11) 98526-2710	Endere├ºo n├úo informado	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
324	Jhonatas Freire	M	192.048.924-58	4	(11) 92971-5451	Rua Maria Luiza Val Penteado N??495	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
325	Joana Dark	F	783.809.818-56	\N	(11)97982-4055	Av. Sapopemba N?? 7841	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
326	Cida Oliveira	F	795.002.684-05	17	(11)96835-5829	Rua Alexandre Albriv Nx??121	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
327	Anderson Nunes	M	704.284.350-33	17	(11)96543-4452	Av. Sapopemba N??14519	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
328	Tiago Queiroz	M	862.017.820-67	\N	(11)985422762	Av. Celso Garcia N??3474	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
329	Marcia Ferreira	F	308.029.832-66	\N	(11) 94727-1606	Endere├ºo n├úo informado	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
330	Mayara Fernandes	F	362.201.067-36	\N	(11) 94788-2741	Avenida Ettore N??790	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
331	Ana Paula Almeida	F	207.879.653-16	\N	(11)98288-6490	Rua dos Santana N??35	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
332	Lais Siqueira	F	362.558.229-09	4	(11) 91305-9176	Travessa Maria Padilha N??12	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
333	Mikaela F.	F	078.184.421-56	\N	(11)95937-2139	Rua Getulina N??66	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
334	Renan Lima	M	444.544.229-11	4	(11) 93639-2805	Endere├ºo n├úo informado	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
335	Aline de Aguiar	F	238.374.211-75	\N	(11)98455-7182	Rua das Figueiras N??2780	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
336	Claudia Menezes	F	040.923.704-75	4	(11) 94128-3166	Rua Doutor Felice Buscaglia 608	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
337	Raquel Moreira de Alcantra	F	723.796.345-74	4	(11)95609-5155	Rua Dr. Edmur Whitaker N??670	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
338	Patr├í├ícia Branger	F	724.476.991-26	\N	(45)99906-1728	Rua Eurico Eloi Marcelino N??225	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
339	Kleber de Souza	M	207.537.845-66	4	(11)96070-4177	Endere├ºo n├úo informado	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
340	Claudia Mota Paix├í├ío	F	690.305.374-44	\N	(11)99271-5771	Rua Joaquim Abreu luz N??338	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
341	Rog├í├írio Carvalho	M	627.381.542-70	\N	(11)96548-5605	Rua Padre Gabriel Malagrida N??19	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
342	Adriana Santana	F	841.560.388-45	5	(11)94240-1318	Rua Andr?? Fernandes N??138	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
343	Lizandra Souza	F	831.715.398-22	4	(11) 91900-1871	Endere├ºo n├úo informado	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
344	Jessica Rodrigues	F	518.027.393-90	\N	(11) 92463-2732	Rua Bartolomeu Correia Bueno N??134	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
345	Jessica Gon├í├íalves da Silva	F	171.550.631-96	16	(11)97992-6765	Rua Ant??o Leme da Silva N??202	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
346	Denilson Manoel de Lima	M	657.957.108-81	\N	(81)98524-4935	Rua Venturosa N??381	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
347	Janete ( Representante)	F	267.855.704-12	16	(11) 94157-8231	Endere├ºo n├úo informado	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
348	Andreia L.	F	853.407.317-25	4	(11)97588-6073	Rua Liberato Barroso N??162	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
349	Glecia Vieira	F	559.824.279-61	\N	(11) 96274-7555	Av. Roney Clube N??1211	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
350	Jo├í├ío Almeida de Freitas	M	336.704.227-08	\N	(11) 91227-9311	Endere├ºo n├úo informado	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
351	Nilson Vieira	M	201.707.482-05	4	(11)98216-5715	Rua Itinga N??48	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
352	Rosineide Alves	F	970.755.491-55	3	(11)95335-5852	Rua Guido Frederica N??10	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
353	Daniele Ferreira	F	881.660.780-68	3	(11) 93533-2312	Endere├ºo n├úo informado	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
354	Bruno Almeida de Melo	M	250.210.261-79	3	(11) 97741-7419	Endere├ºo n├úo informado	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
355	Maria Cleciane Queiroz dos Santos	F	825.109.537-27	3	(11)97083-1504	Av. Dos Sertanistas N??1967	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
356	Marcelo Paix├í├ío	M	770.895.080-79	3	(11)94545-1176	Rua Luiz de Oliveira Bulh??es N??518	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
357	Graziela Cristina	F	502.232.015-53	3	(11) 94313-4878	Rua Ascabuz N??206	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
358	Marli A.	F	008.125.425-11	3	(11) 97491-7886	Endere├ºo n├úo informado	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
359	Norma Ferreira	F	010.929.614-23	3	(11) 97644-3423	Rua Itacoatiara N??231	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
360	Roney Ferreira da Proen├í├ía	F	831.528.557-34	3	(11)96355-8854	Rua Major Sert??rio N??561	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
361	Damiana Louren├í├ío	F	052.511.902-77	3	(11)95457-2678	Rua Dom Diogo Furtado N??180	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
362	Ver├í├ínica (Representante)	F	761.362.110-07	3	(11)95457-2679	Av. Maria Cursi N??985	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
363	Walne(Representatnet)	M	654.772.838-11	3	(11) 91698-3878	Endere├ºo n├úo informado	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
364	Andreia M.	F	551.535.303-87	14	(11)98374-5138	Rua Oronzo Mastrokosa N??71	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
365	Alzira Nunes	F	105.601.519-58	3	(11) 98391-1722	Endere├ºo n├úo informado	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
366	Lucas Henrique	M	005.395.356-64	16	(11)96440-4139	Rua Guido Frederica N??20	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
367	D├í├írio Pereira de Souza Junior	M	656.863.582-98	36	(11) 94234-3347	Rua Sorocaba N??08 Loja 2	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
368	Cleber Fernandes	M	072.307.466-68	\N	(11)96070-4177	Rua Beira Rio N??64	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
369	Alex Santana Carvalho	M	401.449.732-83	\N	(73)99975-4758	Rua Adelar Maria de Andrade N??231	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
370	Kelly Andradae	F	725.615.578-97	\N	(11)95798-4585	Rua Eldorado N??473	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
371	Inael(Representante)	M	171.101.795-74	3	(11) 94268-3000	Endere├ºo n├úo informado	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
372	F├í├íbio Jos├í├í de Carvalho	M	907.569.921-65	\N	(86)98117-6382	Rua Raimundo Fernandes da Silva N??735	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
373	Neci Almeida	F	216.687.073-06	4	(11)95131-3811	Rua Luiz Guidiei N??694	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
374	Lorena Prado	F	806.948.538-72	4	(11)99703-806	Rua Netuno N??113	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
375	Lucas Gabriel S. Costa	M	426.003.618-02	4	(11)95236-5155	Rua Domenico Alberti N??121	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
376	Paulo Andr├í├í Siqueira Mendes	M	556.536.319-42	36	(22)98801-6001	Estrada Embaixador S??o Vicente N??284	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
377	Marluce Silva	F	123.741.049-56	13	(11)94119-8948	Avenida Bassamo Del Grappa N??220	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
378	Talita Paraiso	F	874.167.067-20	\N	(11)96462-5839	Rua Dona Carmela N??245	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
379	Micaele Santos Maria	F	454.225.200-63	4	(11)95354-8871	Rua Carlos Coccia N??106	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
380	Roque Martins	M	986.855.754-90	\N	(11)96712-7112	Endere├ºo n├úo informado	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
381	Leda Maria de Souza	F	676.807.076-27	4	(11)95869-2375	Rua Pastor Agenor Diniz N??178	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
382	Ros├í├íngela Martins	F	405.262.480-54	4	(11) 92983-8213	Endere├ºo n├úo informado	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
383	Phillipe Ferreira (Representante)	M	335.811.879-05	\N	(11) 96567-2896	Endere├ºo n├úo informado	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
384	Roberta Ferreira	F	770.202.494-12	4	(11) 96083-9611	Endere├ºo n├úo informado	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
385	Miqueias Pinheiro	F	484.660.872-40	4	(11)99563-5264	Rua Ettore Andreazza N??363	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
386	Noelle Cristini Dourado	F	535.360.884-76	17	(11)98703-3902	Rua Lirio do Vale N??385	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
387	Neusa Stevem	F	937.697.545-76	4	(11) 95333-8658	Rua Gedge Beckeby N??7	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
388	Zulmira Lima	F	958.560.322-28	4	(11) 91240-1647	Endere├ºo n├úo informado	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
389	Ana Cl├í├íudia Freitas	F	019.673.602-45	\N	(11)95988-0890	Av. Sapopemba	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
390	Graziele Da Silva Brand├í├ío	F	631.868.640-83	\N	(11)99517-1076	Rua Orlando Teles N??45	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
391	Derik F.	M	318.409.052-89	12	(11)93957-5094	Rua Francisco de Paula N??42	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
392	Vieto Costa Gomes	F	887.788.163-43	\N	(11)93012-9128	Rua Tavares N??46	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
393	Elisangela Alves Selaris	F	908.002.376-07	17	(11)95127-5106	Av. Sapopemba N??5570	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
394	Lucas Nascimento	M	146.769.766-79	\N	(11) 91477-1692	Rua Ant??nio Carllas Dalla N??435	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
395	Shirley da Silva	F	724.259.902-39	\N	(11)98873-2887	Rua Campo de Piratininga N??336	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
396	Elen Regina de Oliveira	F	378.856.477-67	\N	(11) 96344-5205	Rua Travessa Augusto Baron N??161	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
397	Larissa Yara Gomes	F	773.662.635-71	16	(11)97634-8424	Rua Domingos Rubino N??359	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
398	Rose R.	F	006.487.925-21	4	(11)94863-1253	Rua Tenente Lauro Sodr?? N??1398	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
399	Adenilda N.	F	070.957.315-40	4	(11)93602-0161	Rua Serra Navio N??785	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
400	Rose Machado	F	271.324.757-16	4	(11)95811-2159	Rua Jos?? Francisco Dos Santos	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
401	Karen Fernanda Mendes	F	461.995.988-84	\N	(19)99802-7401	Rua Jos?? Ricardo Pagionotto N??215	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
402	Ednalva Carneiro	M	787.112.539-36	36	(11) 95846-2912	Estrada Santa Marinha N??59	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
403	Ulivandia Moreira Silva	F	605.421.916-52	\N	(31)98604-3951	Rua Serra do Mar N??865	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
404	Vera L├í├ícia Ferras	F	951.782.600-71	\N	(11)97689-0508	Rua Ipiranga N??80	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
405	Josy De Jesus Nascimento	F	541.188.534-44	4	(11)94774-4502	Rua Henrique Mazalte N??530	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
406	Dineia Maria Ribeiro Soares	F	200.016.084-54	\N	(11) 96883-4809	Rua Arlindo Neves N??346	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
407	Jorge Nunes	M	389.508.586-69	4	(11)98527-4827	Travessa Zasueira N??68	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
408	Suzane Lacerda Dantas	F	384.290.674-72	\N	(63)99209-2012	Rua Sul N??206	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
409	Ellen Kellen Virginia da Silva	F	857.510.297-49	36	(27)98577-8561	Rua Joaquim de Queiroz N??233	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
410	Roberta Nascimento	F	507.684.997-85	4	(11)94880-8768	Travessa Nogueria N??68	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
411	Josuel Rodrigues da Silva Junior	M	382.437.133-35	8	(11)96429-1976	Rua Vitoriano Pereira N??105	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
412	Bianca Costa	F	213.280.848-45	14	(11)95877-9066	Rua Soldado Teonilio de Souza N??110	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
413	L├í├ícia Araujo do Nascimento	F	533.858.964-64	4	(11)96717-5501	Rua Prof. Braz??lio Barni N??160	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
414	Jussara de Souza Campos	F	274.864.339-83	\N	(65)99244-6557	Rua das Palmeiras N??168	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
415	Anides Bispo de Oliveira	F	118.879.340-44	4	(11)99747-1182	Travessa Sol do Girassol N??131	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
416	Gildania Leonilda Souza	F	614.102.806-29	17	(11)97012-8681	Travessa Benedito Costa Gomes N??42b	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
417	J├í├ílio Cesar Sabioni	M	396.174.228-27	\N	(11)97616-2189	Rua Serra de Botucatu	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
418	Mariana Pessoa da Silva	F	673.061.063-82	16	(11)95956-9950	Rua Teodora Oliveira N??346	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
419	Solange Da Silva Dias	F	645.574.321-17	4	(11)99943-8548	Rua Abner de Souza e Silva N??27	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
420	Karolen Kamila Mendes da Rocha	F	326.563.121-21	\N	(96)99166-6443	Av do A??ai N??704	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
421	Paula Bianca de Souza Resende	F	465.961.145-22	\N	(32)99939-4024	Ria Moreira da Rocha N??45	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
422	Cleideana Le├í├ío	F	219.681.162-07	3	(11)98589-9450	Av. Brigadeiro Faria Lima N??1257 Loja 4	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
423	Liu Tmashiro	F	481.397.716-74	4	(11) 93152-2554	Rua Cristov??o de Oliveira N??75a	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
424	Carla de Souza	F	801.030.451-38	3	(11)99116-7882	Rua Pangava N??43	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
425	Sidney Ferreira	M	698.272.404-57	4	(11)95360-8567	Rua Amazonas N??22	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
426	Jos├í├í Carlos Freitas	M	031.579.398-14	4	(11)95899-0456	Endere├ºo n├úo informado	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
427	Marilia Antunes	F	267.875.347-47	4	(11) 92123-4710	Endere├ºo n├úo informado	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
428	Jos├í├í Carlos Almeida Henrique	M	254.590.107-00	\N	(11) 93671-2132	Endere├ºo n├úo informado	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
429	Fabiana Gomes dos Santos	F	047.948.389-59	\N	(11) 98798-6647	Rua Aristides Milton N??453	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
430	Vanessa Ferreira de Almeida	F	858.558.793-05	\N	(81)98340-5274	Rua Luiz Barbalho N??255	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
431	Angelina Da Silva Cordeiro	F	076.591.297-41	5	(11) 94699-4152	Rua Giovanni Da Coegliano N??426	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
432	Laudete Rocha	F	593.299.398-95	4	(11)96754-7240	Rua Jos?? Joaquim N??31	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
433	Leonardo (Esta├í├í├í├ío 011)	M	498.865.998-35	4	(11)94034-5592	Endere├ºo n├úo informado	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
434	Tatiana Louren├í├ío	F	796.325.564-63	4	(11)96702-6689	Rua Nova Bahia N??69	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
435	Karen Figuereido	F	280.405.327-94	4	(11)98688-0838	Rua Bandeira do Sul N??307	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
436	Nicolas Perrini	M	045.784.262-19	\N	(11)94002-3079	Rua Principal N??26a	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
437	Neila Cruz de Castro	F	717.999.866-64	\N	(75)99240-3500	Rua Goi??s N??307	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
438	Tayna Nunes	F	204.152.545-42	\N	(11) 94301-9973	Endere├ºo n├úo informado	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
439	Evelyn Silva	F	203.255.887-83	4	(11)96181-9783	Av. Manoel Velho Moreira N??1178A	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
440	Dinho Nunes	M	961.765.546-17	4	(11) 96166-4791	Rua Corrego Dias Pequeno N??403	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
441	Ana Carolina de Lima Souza	F	742.834.977-70	10	(11)98618-1068	Rua dos Geografo N??80A	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
442	Maria do Carmo Silva	F	297.831.929-47	\N	(11)99712-5377	Rua Takaominari N ??18	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
443	Natalia de Lima e Silva	F	757.760.483-09	3	(11)96628-3160	Rua Domingos Ros??lia N??289	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
444	Maria Aparecida de Almeida	F	967.993.114-56	\N	(11)96275-0613	Av. Get??lio Vargas N??801	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
445	Nathally Cristiny Silva	F	249.583.889-67	4	(11)98872-9042	Travessa Selassie N??92	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
446	Malba Delian Assis Belfort	F	641.083.733-35	\N	(11) 96070-4861	Rua Tinoco Valente N??155	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
447	Tanylia Jos├í├ília Almeida dos Santos	F	764.429.276-61	\N	(11) 95854-4025	Rua Guianazes N??880	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
448	Cleuza Maria de Almeida Santos	F	690.410.062-57	\N	(11)97362-9567	Rua Tomas Beneviete N??9A	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
449	Luciane Maria Alves Martins	F	916.802.824-11	4	(11)95456-6966	Rua S??o Geraldo N??37	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
450	Juliana Gomes Vieira	F	220.953.260-19	\N	(11)98915-2439	Rua Pedro Ramazani N??123	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
451	Maria Eulina Almeida Vieira	F	012.605.443-13	\N	(11) 93232-4862	Rua Diomedes Lobo N??732	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
452	Janete Fidelis da Costa	F	599.099.179-61	8	(11)98906-8285	Rua Siqueira Bueno N??2271	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
453	Lucas Veraneio	M	022.707.627-80	17	(11)96414-7361	Rua Campos do Jord??o N??15	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
454	Narjara de Andrade	F	135.736.498-06	\N	(11) 99548-7068	Rua Helio Farias de Mendon??a	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
455	J├í├íssica Santos	F	206.043.756-31	5	(11)93435-1331	Rua Salvia N??21	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
456	Valdemir de Souza Rufino	M	008.012.629-81	\N	(11)97582-1427	Rua Babil??nia N??10	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
457	Pel├í├í Almeida Martins	M	778.823.825-41	\N	(11) 91554-9453	Rua Padre Jo??o N??41	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
458	Juliete Pereira Ribeiro	F	856.286.152-46	\N	(11) 99973-1013	Rua Principal N??28a	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
459	Gisele Ferreira Samavilla	F	826.120.802-79	\N	(55)98457-9504	Rua Flavio Boanowski N??487	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
460	Aline Candido da Silva	F	979.414.587-51	\N	(55)99349-1001	Rua Gon??alo Nunes dos Santos	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
461	Adriana Rose Pereira	F	870.659.117-30	4	(11)96036-2281	Rua Angelo de Candia N??1127	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
462	Mayza Monteiro	F	480.332.903-99	4	(11)90145-4073	Rua Takaominari N ??61	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
463	Maycon Cicero Amaral	M	073.410.669-18	\N	(11)98253-4333	Rua T??nia N??61	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
464	Nadya Albuquerque	F	664.270.544-22	4	(11)95464-0604	Rua Abner Ribeiro Borges N??211	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
465	Fabiana Aparecida Maria de Oliveira	F	028.733.830-15	\N	(13)99161-9530	Rua Manoel Ferreira Festas N??188	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
466	Milca Vieira da Silva	F	991.070.047-55	17	(11)97743-2422	Rua Sim??o Nunes	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
467	M├í├írcia Andrea da Silva	F	605.882.024-87	30	(11)98647-9906	Rua General Synzeno Sarmento N??1214	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
468	Leandro Nunes	M	786.203.839-91	\N	(11)99649-4873	Av. das Na????es n??641	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
469	Luzia Patr├í├ícia Silva Nogueira	F	882.969.422-65	\N	(11) 91435-2526	Rua Bar??o do Rio Branco N??1307	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
470	Suziana Mendes	F	544.276.822-67	\N	(11)94921-4890	Av. Marginal do Orat??rio N??18	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
471	Rosineide Machado Mariano	F	247.566.590-83	4	(11)97962-3600	Rua Jim Baku N??1	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
472	J├í├íssica de Mendon├í├ía Lima	F	199.723.499-46	36	(21)99115-8008	Rua Jo??o de Barros N??5	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
473	Dayane Cristine de Souza	F	112.924.734-08	16	(11)94590-5413	Av. Caititu N??1320	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
474	Ramon Alves	M	222.140.677-81	\N	(11)97115-7607	Rua Felipe Angeli N??44	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
475	Matheus Lucas Nunes da Silva	M	009.620.803-10	\N	(11) 99320-6183	Rua Ben??cio Oliveira Lima	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
476	Andreia L.	F	977.474.617-95	4	(11) 92634-8289	Rua Cl??udio Augusto Fernandes	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
477	Salatiel Figueireido	M	042.183.131-79	4	(11)99162-5712	Rua Jo??o Antunes Maciel N??227	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
478	Genilda Teixeira	F	578.676.889-19	\N	(11)98575-2281	Rua Redu????o de Guaranbar?? N182	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
479	Tatiane Aparecida de Lima	F	417.861.149-61	4	(11)98120-4240	Rua Leopoldo Felix N??437	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
480	Ediane Silva	F	748.723.341-59	\N	(11) 96976-7066	Rua Violeta N??103	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
481	Jade de Almeida	F	964.972.204-49	16	(11)97734-4534	Rua Lagoa da Prata N??242	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
482	Douglas Richard de Jesus Pereira	M	947.874.888-42	\N	(13)97409-5940	Rua Ofelina Chaves de Meireles N??562	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
483	Adalgisa Pereira	F	133.420.064-73	\N	(11)97672-4120	Rua Itapark N??1590	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
484	Rodolfo Santos	M	130.821.769-53	4	(11)98230-9037	Rua Bandeira de Aracabina N??323	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
485	Yvan Sanon	M	167.845.180-67	4	(11)9806-8167	Rua Flore da Primavera N??253	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
486	Ramon Hiat Magalh├í├íes	M	752.408.820-86	\N	(11) 97421-2730	Rua Rafael Cazzotino N??116	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
487	Maria Helena Godoy Machado	F	875.590.599-82	\N	(11) 93179-5126	Rua Boa Vista N??3056	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
488	La├í├ís Mar├í├ília de Almeida	F	111.448.472-28	37	(11) 98881-4909	Rua Ursula Paulino N??1804	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
489	Maria Ivonete	F	012.342.769-93	\N	(11)99403-6556	Rua Redu????o de Guaranbar?? N395	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
490	Eduardo dos Santos	M	434.409.450-09	17	(11)94886-5039	Rua Francisco Matias N??117A	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
491	Andreia Caroline de Mattos Silva	F	605.540.090-08	\N	(14)99690-5039	Rua Jos?? Alencar N??84	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
492	Lucas Alexandre	M	637.579.395-05	\N	(11)94059-4456	Rua Anny N??1262	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
493	L├í├ícia Maria de Teodoro de Jesus	F	377.536.067-38	\N	(71)98879-3279	Rua Mundo Novo N??34B	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
494	Brenda Cardoso	F	951.353.661-19	\N	(11) 96598-3960	Rua Adiles Peixoto N??283	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
495	Beatriz Ribeiro	F	856.820.288-58	\N	(11) 91018-9555	Rua dos Bibliotec??rios N??257	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
496	Izildinha de Souza Crivano Sales	F	737.933.784-18	5	(11)9255-9189	Rua Benidito N??527b	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
497	J├í├íssica da Silva Rodrigues de Fraga	F	703.588.342-09	\N	(51)9789-3559	Avenida Placido Mattin N??2301	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
498	Andreia Silva Costa	F	965.429.557-23	\N	(11) 96404-8128	Rua Alagoas Nova N??1321	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
499	Alessandra Bourguignon Costa	F	363.568.032-19	\N	(11) 93242-5235	Rua Sim??o Bassuil N??222	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
500	Lucicleide Oliveira	F	846.725.288-95	4	(11)95494-0188	Rua Candecia N??97	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
501	Thiago Monteiro	M	048.697.376-64	4	(11)98367-1959	Rua James Naves N??351	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
502	Daniela Silveira Guimar├í├íes	F	204.555.411-27	\N	(51)99215-0093	Rua Sival Hoff Pereira N??330	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
503	Anderson Arias de Souza	M	130.784.971-31	\N	(11)99497-5825	Rua Leonardo Cerveira	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
504	Cristina Minelavina	F	794.956.005-56	16	(11)98728-0736	Rua Jos?? Vidal N??110	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
505	Iasmim Milena Martins da Silva	F	725.250.604-95	\N	(81)98667-6066	Rua Juscelino Kubitschek N??50	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
506	Ronise de Lima	F	333.909.209-78	\N	(55)99672-7963	Rua 20 de Setembro N??2010	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
507	Gabriela Carvalho da Concei├í├í├í├ío	F	687.173.309-76	\N	(11) 95916-6291	Rua dos Trabalhadores N??643	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
508	Camila de Macedo	F	165.810.053-33	16	(11)95531-5358	Rua Morumbiaba N??1016	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
509	Marcelo(Representante)	M	471.715.469-66	13	(11) 94003-8510	Endere├ºo n├úo informado	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
510	Lady Daiane	F	554.856.724-43	4	(11)94821-7266	Rua Jos?? Francisco Dos Santos N??771	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
511	Margarete Fidelis	F	812.968.316-36	8	(11)94815-1555	Rua Fernando Falc??o N??872	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
512	Talita Melo	F	746.684.845-91	16	(11)98641-0955	Rua Joaquim Meira Siqueira N??807	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
513	Raimundo Freitas	F	551.364.844-06	4	(11)99178-9031	Rua Barros Peteado N??361	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
514	Israel Martins	M	468.665.701-13	14	(11)91031-8977	Rua Joaquim Pinheiro N??14	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
515	H├í├ílio Freitas( Representante)	M	177.888.443-19	4	(11) 94107-1239	Endere├ºo n├úo informado	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
516	Maria Lucia Martina	F	680.246.775-55	4	(11)95278-8021	Rua Curumartins N??76	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
517	Diessica Jocasta Toebe	F	357.509.238-18	\N	(11)99752-4747	Rua Dom Guilherme Muller N??1153	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
518	Bianka Bianche	F	722.731.015-83	13	(11)98436-9366	Rua Alberto de Macedo N??240	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
519	Jennifer Coelho Carmago	F	484.912.384-59	9	(11)98076-9933	Rua Iguarap?? das Miss??es N??29	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
520	Rita Maria	M	093.496.013-62	4	(11)96323-8815	Rua Alexandre Crapolli N??125	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
521	Silmara Lopes	F	003.680.020-85	4	(11)97068-4460	Rua Doutor Felice Buscaglia N??467	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
522	Juliana Aparecida dos Reis Rufino	F	585.495.851-87	\N	(18)99121-4936	Rua Natalino Pena N??347	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
523	Jucilene C. Da Silva	F	579.909.471-40	4	(11) 97641-8298	Endere├ºo n├úo informado	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
524	Feliciana Rute Silva de Mascena	F	298.188.265-46	\N	(71)98240-9966	Rua Frei Miguel N??24	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
525	Naiara Gon├í├íalves Carmargo	F	997.652.668-42	\N	(48)99834-7316	Rua S??o Nicolau N??776	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
526	Tatiana Cimas Mendes	F	731.585.168-40	\N	(16)99707-4042	Rua Lavineiro de Arruda Falc??o N??1071	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
527	Katia Janaina Marques Mota	F	572.156.448-31	\N	(81)98606-3120	Av. Doutor Carlos Gueiros Leite N??4328	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
528	Luana Santos Fernandes	F	984.766.947-58	5	(11)95208-2780	Av. Julio Bueno N??1588	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
529	Ana Caroline Alves de Carvalho	F	938.283.332-17	\N	(86)99573-5755	Rua Inham?? N??5585	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
530	J├í├íssica Pinto Silva	F	938.581.431-13	4	(11)98577-6452	Rua Edgar Pinto C??sar N??23	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
531	Williane Pinto	F	694.363.370-20	\N	(11) 92957-3195	Endere├ºo n├úo informado	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
532	Lucas Vinic├í├íuis de Morais	M	789.911.692-05	\N	(11) 95977-6690	Av. Rio Tocantis N??52	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
533	Erik Fl├í├ívio Santos	M	918.228.424-29	5	(11) 98200-2345	Rua Dores de Campos N??456	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
534	Igor Orneles	M	078.088.629-42	\N	(11)94392-5992	Rua Coleta Saaf N??86	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
535	Beatriz Eduarda Ribeiro	F	109.576.803-64	\N	(19)99394-5301	Rua Resedes N??60	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
536	Juliana Pereira Gon├í├íalves	F	119.437.616-32	\N	(11)95924-9364	Av. Estrada dos Alvarengas N??7862	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
537	Gessica Caroline Dos Santos Leite	F	749.791.041-92	\N	(79)99921-3442	Rua Duzentos e Vinte e dois N??166	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
538	Meire Ferreira	F	765.629.939-31	4	(11)98171-8328	Rua Roberto Park N??705	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
\.


--
-- Data for Name: dim_fornecedor; Type: TABLE DATA; Schema: administrativo; Owner: postgres
--

COPY administrativo.dim_fornecedor (id_fornecedor, nome_fornecedor, cnpj, telefone, id_localizacao, endereco_completo, created_at, update_at) FROM stdin;
1	Deca	01.868.663/0001-87	(11) 1276-1724	3	Endere├ºo comercial - Deca	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
2	Bullon	02.485.696/0001-88	(11) 5949-2048	3	Endere├ºo comercial - Bullon	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
3	-	03.648.842/0001-92	(11) 2572-6969	3	Endere├ºo comercial - -	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
4	Vand??o	04.949.326/0001-68	(11) 5942-1970	3	Endere├ºo comercial - Vand??o	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
5	Itallian Collor	05.165.530/0001-26	(11) 1843-7234	3	Endere├ºo comercial - Itallian Collor	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
6	Enok	06.796.398/0001-77	(11) 9636-3721	3	Endere├ºo comercial - Enok	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
7	Paulo Dias 	07.287.057/0001-85	(11) 6895-3772	3	Endere├ºo comercial - Paulo Dias 	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
8	Thiago Registros Ltda	08.056.948/0001-73	(11) 3193-8121	3	Endere├ºo comercial - Thiago Registros Ltda	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
9	Val	09.949.449/0001-73	(11) 2260-6401	3	Endere├ºo comercial - Val	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
10	Ivair	10.540.570/0001-88	(11) 6519-9583	3	Endere├ºo comercial - Ivair	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
11	Darus	11.239.902/0001-24	(11) 4791-9229	3	Endere├ºo comercial - Darus	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
12	Edgar	12.697.907/0001-82	(11) 5815-3935	3	Endere├ºo comercial - Edgar	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
13	Sandro	13.266.132/0001-04	(11) 8290-7386	3	Endere├ºo comercial - Sandro	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
14	Dompel	14.596.137/0001-96	(11) 2440-4743	3	Endere├ºo comercial - Dompel	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
15	Ver??nica	15.146.381/0001-74	(11) 1815-1250	3	Endere├ºo comercial - Ver??nica	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
16	Mofashi	16.718.287/0001-40	(11) 4696-4896	3	Endere├ºo comercial - Mofashi	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
17	Arlete	17.714.972/0001-26	(11) 5661-9500	3	Endere├ºo comercial - Arlete	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
18	Rei da M??quinas(Rog??rio)	18.610.076/0001-55	(11) 3200-2038	3	Endere├ºo comercial - Rei da M??quinas(Rog??rio)	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
19	Skylire	19.002.395/0001-36	(11) 9738-1706	3	Endere├ºo comercial - Skylire	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
20	Leo  ia????es	20.776.903/0001-66	(11) 3804-7818	3	Endere├ºo comercial - Leo  ia????es	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
21	Michelle	21.976.236/0001-43	(11) 3964-7632	3	Endere├ºo comercial - Michelle	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
\.


--
-- Data for Name: dim_produtos; Type: TABLE DATA; Schema: administrativo; Owner: postgres
--

COPY administrativo.dim_produtos (id_produto, nome_produto, descricao, id_categoria, id_fornecedor, custo_unitario, peso_kg, altura_cm, largura_cm, profundidade_cm, estoque_min, estoque_max, ativo, created_at, update_at) FROM stdin;
1	Oxidante 30	Produto Oxidante 30	\N	5	27.60	8.070	79.67	29.28	12.99	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
2	Colora????o	Produto Colora????o	\N	5	13.20	8.410	23.35	33.55	57.23	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
3	Oxidante 20	Produto Oxidante 20	\N	5	27.60	3.280	47.61	25.34	23.51	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
4	Shampoo 1L Trivitt	Produto Shampoo 1L Trivitt	\N	5	54.00	5.530	24.00	44.63	43.85	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
5	Lavat??rio Compacto Cuba Fibra	Produto Lavat??rio Compacto Cuba Fibra	\N	4	1020.00	8.710	67.39	34.35	32.33	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
6	Console Plus	Produto Console Plus	\N	12	330.00	4.740	79.76	30.14	35.63	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
7	Nicho Expositor 4 V??os	Produto Nicho Expositor 4 V??os	\N	12	180.00	10.150	66.09	18.52	48.74	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
8	Carrinho Auxiliar 4 Gavetas	Produto Carrinho Auxiliar 4 Gavetas	\N	12	300.00	7.210	20.69	10.68	56.57	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
9	Aquecedor 220v	Produto Aquecedor 220v	\N	6	60.00	8.780	76.56	55.68	31.22	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
10	Mesa Simples Manicure	Produto Mesa Simples Manicure	\N	12	120.00	3.080	73.81	26.92	53.19	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
11	Ciranda Manicure Scarlet	Produto Ciranda Manicure Scarlet	14	10	240.00	8.440	44.20	65.79	26.28	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
12	Mesa Star Manciure	Produto Mesa Star Manciure	\N	12	270.00	8.590	39.27	40.38	69.06	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
13	Cadeira Elegance Rec. Base Quadrada	Produto Cadeira Elegance Rec. Base Quadrada	11	9	894.00	0.740	76.93	65.56	33.24	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
14	Cuba de Fibra	Produto Cuba de Fibra	\N	6	180.00	8.300	13.80	63.59	21.68	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
15	Reparador de Pontas	Produto Reparador de Pontas	\N	5	17.40	6.980	14.68	51.04	34.89	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
16	Hidrata????o Triviit 250g	Produto Hidrata????o Triviit 250g	\N	5	22.20	6.300	73.09	41.56	49.53	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
17	P?? Descolorante 300g	Produto P?? Descolorante 300g	\N	5	30.00	7.090	18.50	67.15	33.96	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
18	Hidrata????o Itallian 2kg	Produto Hidrata????o Itallian 2kg	\N	5	60.00	7.500	60.92	55.01	23.78	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
19	Cadeira Elegance Arredonda Rec. Base Quadrada	Produto Cadeira Elegance Arredonda Rec. Base Quadrada	11	9	1134.00	1.230	37.83	59.60	69.74	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
20	Console Retty 1.35m	Produto Console Retty 1.35m	\N	12	294.00	4.520	53.57	36.49	58.32	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
21	Toalheiro Vertical 	Produto Toalheiro Vertical 	\N	12	399.00	3.430	83.76	53.57	42.39	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
22	Lavat??rio Elegance Cuba de Lou??a Branca	Produto Lavat??rio Elegance Cuba de Lou??a Branca	\N	9	1494.00	7.680	18.17	55.64	53.53	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
23	Carrinho Auxiliar 3 Gavetas	Produto Carrinho Auxiliar 3 Gavetas	\N	12	252.00	4.300	24.99	22.52	36.35	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
24	M??quina de Corte Galletz	Produto M??quina de Corte Galletz	\N	18	174.00	4.510	30.51	41.38	55.51	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
25	Carrinho Auxiliar 2 Gavetas 1 Porta	Produto Carrinho Auxiliar 2 Gavetas 1 Porta	\N	12	210.00	9.210	17.81	25.95	37.70	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
26	Lavat??rio Italiano	Produto Lavat??rio Italiano	\N	6	414.00	5.800	78.77	27.24	59.06	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
27	Sof?? Confort	Produto Sof?? Confort	14	10	234.00	0.660	40.14	34.40	26.13	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
28	Cadeira Futurama	Produto Cadeira Futurama	11	10	510.00	9.670	43.19	62.35	20.08	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
29	Cadeira Elegance Fixa Base Quadrada	Produto Cadeira Elegance Fixa Base Quadrada	11	9	834.00	3.010	37.53	63.70	69.66	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
30	Toalhas	Produto Toalhas	\N	1	6.00	8.440	29.71	30.31	47.85	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
31	Tesoura de Corte	Produto Tesoura de Corte	\N	16	60.00	2.530	69.65	13.14	63.48	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
32	Capa de Corte 	Produto Capa de Corte 	\N	16	12.00	3.060	17.52	65.94	18.03	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
33	Cadeira Elegance Rec. Base Pentap??	Produto Cadeira Elegance Rec. Base Pentap??	11	9	1019.99	4.370	42.38	45.36	46.90	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
34	Segredo Cabeleireiro Trivitt	Produto Segredo Cabeleireiro Trivitt	\N	5	43.20	5.190	19.92	60.84	24.38	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
35	Base Inovattor	Produto Base Inovattor	\N	5	20.40	6.360	39.49	36.96	60.51	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
36	Cauteriza????o Trivitt	Produto Cauteriza????o Trivitt	\N	5	37.20	10.010	67.78	55.07	13.99	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
37	Balc??o Recep????o 70cm	Produto Balc??o Recep????o 70cm	\N	12	252.00	9.300	31.65	30.78	54.40	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
38	Lavat??rio Neon	Produto Lavat??rio Neon	\N	2	539.99	2.400	40.98	23.13	49.23	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
39	Expositor 5 Nichos	Produto Expositor 5 Nichos	\N	12	179.99	5.580	50.67	41.56	49.25	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
40	Resist??ncia 220V	Produto Resist??ncia 220V	\N	6	36.00	7.490	25.25	52.76	63.70	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
41	Balc??o Recep????o 100 cm	Produto Balc??o Recep????o 100 cm	\N	12	306.00	4.490	47.44	69.16	33.95	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
42	Mesa Elegance Tampo de Vidro	Produto Mesa Elegance Tampo de Vidro	\N	12	594.00	4.730	28.15	17.62	12.54	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
43	Esmalteiro Grande	Produto Esmalteiro Grande	\N	12	149.99	9.600	61.43	56.41	64.01	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
44	Leav-in	Produto Leav-in	\N	5	149.99	3.270	35.19	41.46	22.54	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
45	Ativador Inovattor	Produto Ativador Inovattor	\N	5	20.40	3.940	39.38	55.37	58.84	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
46	Kit Manuten????o Trivitt	Produto Kit Manuten????o Trivitt	\N	5	54.00	1.760	64.74	10.83	35.00	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
47	Arm??rio Utilit??rio 2 Portas	Produto Arm??rio Utilit??rio 2 Portas	\N	12	276.00	3.950	44.93	27.02	18.11	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
48	Flu??do Trivitt	Produto Flu??do Trivitt	\N	5	24.60	1.890	50.18	13.36	69.21	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
49	Shampoo 2L Itallian	Produto Shampoo 2L Itallian	\N	5	55.80	3.150	17.18	34.59	42.10	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
50	Estrutura Lavat??rio Elegance	Produto Estrutura Lavat??rio Elegance	\N	9	894.00	8.030	84.48	49.80	43.55	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
51	Suporte de P?? Colorido	Produto Suporte de P?? Colorido	\N	6	47.40	7.660	10.77	12.86	23.32	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
52	Cadeira TS	Produto Cadeira TS	11	19	101.99	5.030	44.84	40.06	38.36	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
53	Hidrata????o Trivitt  1KG	Produto Hidrata????o Trivitt  1KG	\N	5	54.00	7.960	36.44	14.34	21.13	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
54	Oxidante 40	Produto Oxidante 40	\N	5	27.60	3.510	44.00	24.35	25.50	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
55	Console Barber	Produto Console Barber	\N	12	252.00	8.170	47.24	40.44	24.74	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
56	Bancada Plus	Produto Bancada Plus	\N	12	180.00	6.360	78.69	23.48	10.93	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
57	Lavat??rio Confort Cuba de Lou??a Branca	Produto Lavat??rio Confort Cuba de Lou??a Branca	\N	10	1494.00	3.250	54.47	20.55	58.56	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
58	Baby Puff	Produto Baby Puff	\N	10	41.40	7.930	23.39	48.34	20.02	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
59	Toalheiro c/ Porta 	Produto Toalheiro c/ Porta 	\N	12	300.00	6.140	76.27	44.94	34.53	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
60	Lavat??rio Confort Cuba de Fibra	Produto Lavat??rio Confort Cuba de Fibra	\N	2	1019.94	3.640	28.99	30.44	15.06	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
61	Cadeira Elegance Arredonda Rec. Base Redonda	Produto Cadeira Elegance Arredonda Rec. Base Redonda	11	9	1260.00	8.950	89.16	20.92	33.47	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
62	Carrinho Auxiliar 3 Bandejas	Produto Carrinho Auxiliar 3 Bandejas	\N	12	150.00	3.540	89.50	40.44	24.54	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
63	Shampoo 5L	Produto Shampoo 5L	\N	15	35.99	0.650	62.45	13.72	24.86	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
64	Condicionador 5L	Produto Condicionador 5L	\N	15	35.99	1.470	43.82	20.08	56.91	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
65	Condicionador Inovattor 250g	Produto Condicionador Inovattor 250g	\N	5	26.40	1.500	64.29	55.82	35.51	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
66	Bancada Person	Produto Bancada Person	\N	12	178.80	9.730	76.93	43.31	23.95	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
67	Carrinho de Esmaltes	Produto Carrinho de Esmaltes	\N	12	132.00	1.560	35.74	22.60	67.20	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
68	Amortecedor de Cadeira	Produto Amortecedor de Cadeira	\N	6	72.00	10.280	56.45	39.02	19.68	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
69	Console Person	Produto Console Person	\N	12	330.00	8.040	17.26	40.04	19.30	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
70	P?? Platinum	Produto P?? Platinum	\N	5	64.80	1.330	32.18	34.34	65.22	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
71	Shampoo Matizante Pequeno	Produto Shampoo Matizante Pequeno	\N	5	25.20	0.590	46.53	10.40	36.96	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
72	Cadeira Elegance Fixa Base Pentap??	Produto Cadeira Elegance Fixa Base Pentap??	11	9	834.00	7.050	59.55	54.02	22.34	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
73	Protetor Cuba de Lou??a	Produto Protetor Cuba de Lou??a	\N	6	24.00	5.210	27.22	15.65	64.52	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
74	Toalheiro Mini	Produto Toalheiro Mini	\N	12	149.99	5.970	82.91	62.29	31.71	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
75	Modelador em P??	Produto Modelador em P??	\N	5	27.60	10.040	42.12	47.06	28.81	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
76	Pomada Alta Fixa????o	Produto Pomada Alta Fixa????o	\N	5	25.20	8.040	48.18	36.36	33.34	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
77	Brilho Intensivo	Produto Brilho Intensivo	\N	5	30.00	6.950	34.24	12.16	65.34	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
78	Spray Lacca	Produto Spray Lacca	\N	5	37.80	3.440	16.22	21.66	10.75	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
79	Balc??o Person	Produto Balc??o Person	\N	12	318.00	2.070	79.59	41.59	18.18	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
80	Mocho Est??tica	Produto Mocho Est??tica	11	6	294.00	6.330	69.84	36.79	59.87	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
81	Cadeira Simples Manicure	Produto Cadeira Simples Manicure	11	6	60.00	6.150	63.55	58.13	44.98	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
82	Maca 3 posi????es	Produto Maca 3 posi????es	\N	17	389.99	3.190	84.23	47.98	14.96	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
83	Maca Fixa	Produto Maca Fixa	\N	17	459.00	4.620	86.39	57.50	27.91	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
84	Escada Para Maca	Produto Escada Para Maca	\N	17	59.40	7.210	67.95	26.80	31.41	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
85	Esmalteiro M??dio	Produto Esmalteiro M??dio	\N	12	131.40	6.730	44.15	13.15	62.51	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
86	Bancada 1 Gaveta	Produto Bancada 1 Gaveta	\N	12	240.00	6.760	50.31	18.92	25.09	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
87	Oxidante 6	Produto Oxidante 6	\N	5	31.20	5.930	50.70	57.17	50.41	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
88	Carrinho 4 Gavetas com Tampo de Vidro	Produto Carrinho 4 Gavetas com Tampo de Vidro	\N	12	441.00	7.780	18.55	53.79	27.99	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
89	Cadeira Pratic Base Pentap??	Produto Cadeira Pratic Base Pentap??	11	21	594.00	6.300	78.06	50.08	51.45	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
90	Kit Escovas	Produto Kit Escovas	\N	16	77.99	5.050	64.09	38.99	42.35	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
91	Carrinho Auxiliar CF1	Produto Carrinho Auxiliar CF1	\N	14	114.00	8.660	42.95	33.57	69.57	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
92	Kit Guanidina	Produto Kit Guanidina	\N	5	89.40	1.370	84.65	65.39	51.92	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
93	Cadeira Pratic Luxo Rec. Base Quadrada	Produto Cadeira Pratic Luxo Rec. Base Quadrada	11	6	990.00	6.390	87.44	40.27	54.39	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
94	Cadeira Elegance Rec. Redonda Pentap??	Produto Cadeira Elegance Rec. Redonda Pentap??	11	9	1080.00	6.280	53.24	54.21	26.49	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
95	Hidrata????o Pequena Inovattor	Produto Hidrata????o Pequena Inovattor	\N	5	26.40	3.250	87.04	69.10	51.46	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
96	Cadeira Dubai	Produto Cadeira Dubai	11	11	1734.00	1.010	31.44	30.89	59.66	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
97	Lavat??rio Champ	Produto Lavat??rio Champ	\N	14	516.00	3.060	27.25	43.98	35.65	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
98	Hidrata????o Inovattor 1kg	Produto Hidrata????o Inovattor 1kg	\N	5	61.80	6.040	85.13	16.81	41.83	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
99	Balc??o Recep????o L	Produto Balc??o Recep????o L	\N	12	539.40	4.020	43.07	12.01	15.10	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
100	Console Camarim Fascinio	Produto Console Camarim Fascinio	\N	12	180.00	6.920	17.16	67.21	18.76	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
101	??rmario Expositor 	Produto ??rmario Expositor 	\N	12	330.00	4.570	56.66	66.25	54.96	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
102	Registro Metal	Produto Registro Metal	\N	12	107.40	6.490	33.05	60.88	65.84	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
103	Esmalteiro Pequeno	Produto Esmalteiro Pequeno	\N	8	47.40	10.450	65.92	18.75	60.57	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
104	Ciranda Manicure Simples	Produto Ciranda Manicure Simples	\N	10	150.00	8.590	25.37	65.14	33.44	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
105	Suporte para Secador 	Produto Suporte para Secador 	\N	12	300.00	5.240	24.12	31.29	26.20	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
106	Carrinho Auxiliar Barbeiro	Produto Carrinho Auxiliar Barbeiro	\N	12	179.40	0.830	50.78	53.74	49.42	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
107	Nicho de Bancada	Produto Nicho de Bancada	\N	12	36.00	2.870	20.58	41.29	43.15	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
108	Monocomando Cuba	Produto Monocomando Cuba	\N	9	1200.00	9.710	67.36	29.57	20.01	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
109	Poltrona Elegance com Pezeira	Produto Poltrona Elegance com Pezeira	\N	10	480.00	0.970	26.07	13.87	40.24	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
110	Longarina 2 Lugares	Produto Longarina 2 Lugares	\N	17	1140.00	10.260	31.10	67.52	46.96	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
111	Kit Mangueira e Chuveiro de Luxo	Produto Kit Mangueira e Chuveiro de Luxo	11	10	354.00	9.540	36.05	14.06	15.99	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
112	Assento Cadeira	Produto Assento Cadeira	\N	10	288.00	5.230	49.92	63.27	14.29	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
113	Escova 	Produto Escova 	\N	6	6.00	2.720	40.29	47.52	32.26	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
114	Maca Total Confort	Produto Maca Total Confort	11	19	228.00	0.590	33.77	35.38	55.58	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
115	Shampoo Triviit 250g	Produto Shampoo Triviit 250g	\N	12	414.00	6.190	72.24	40.34	19.36	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
116	Kit Manicure	Produto Kit Manicure	11	9	1284.00	9.530	37.64	35.15	11.05	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
117	Poltrona Espera 2 Lugares	Produto Poltrona Espera 2 Lugares	\N	6	57.00	1.940	76.04	68.63	10.57	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
118	Lavat??rio Elegance Cuba de Fibra	Produto Lavat??rio Elegance Cuba de Fibra	\N	6	180.00	7.050	73.80	25.86	56.65	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
119	Aquecedor Com Mangueira	Produto Aquecedor Com Mangueira	\N	6	90.00	4.880	67.27	27.11	61.30	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
120	Cadeira Elegance Reclin??vel Base Redonda	Produto Cadeira Elegance Reclin??vel Base Redonda	11	9	1140.00	0.660	87.60	16.00	13.95	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
121	Bancada Barber	Produto Bancada Barber	\N	12	159.00	5.860	63.85	43.01	18.04	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
122	Progressiva Trivitt Liss	Produto Progressiva Trivitt Liss	\N	6	354.00	7.400	50.34	69.16	54.10	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
123	Bancada Led Camarim	Produto Bancada Led Camarim	\N	12	210.00	8.950	52.26	24.06	49.30	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
124	Bancada 2 gavetas	Produto Bancada 2 gavetas	\N	12	150.00	8.080	49.64	33.35	18.71	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
125	Shampoo Inovattor 250g	Produto Shampoo Inovattor 250g	\N	12	225.00	6.940	69.35	43.22	64.31	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
126	Hidraulico Quadradado	Produto Hidraulico Quadradado	\N	5	70.80	9.940	82.39	25.37	41.36	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
127	Rodinha Para Ciranda	Produto Rodinha Para Ciranda	\N	16	24.00	2.700	21.66	30.43	42.01	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
128	Console Simples	Produto Console Simples	\N	5	27.00	1.630	83.05	52.38	51.27	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
129	Console Fasc??nio	Produto Console Fasc??nio	\N	6	41.40	3.490	28.15	44.91	50.01	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
130	Chapinha Nano Lins	Produto Chapinha Nano Lins	\N	7	299.99	5.010	83.63	63.21	12.50	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
131	Kit Matizante Trivitt	Produto Kit Matizante Trivitt	\N	12	240.00	10.180	63.45	62.26	61.77	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
132	Cadeira Elegance Reclin??vel Base Inox	Produto Cadeira Elegance Reclin??vel Base Inox	11	9	1020.00	7.950	68.98	20.98	28.81	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
133	Console Barber	Produto Console Barber	\N	12	180.00	8.760	37.34	13.64	38.99	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
134	Hidrata????o Matizante 2kg	Produto Hidrata????o Matizante 2kg	\N	5	22.20	10.190	26.16	41.47	24.64	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
135	Console Retty Big 1.80	Produto Console Retty Big 1.80	\N	5	24.60	7.520	34.92	32.36	12.74	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
136	Toalheiro 4 V??os	Produto Toalheiro 4 V??os	\N	12	570.00	4.490	82.22	35.46	47.62	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
137	Nicho de Bancada	Produto Nicho de Bancada	\N	14	390.00	5.360	73.47	60.21	44.13	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
138	Longarina 3 Lugares	Produto Longarina 3 Lugares	11	19	300.00	8.360	22.36	36.74	59.34	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
139	Carrinho Auxiliar Vegas	Produto Carrinho Auxiliar Vegas	\N	14	162.00	2.400	10.73	54.08	13.72	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
140	Cadeira Top??zio	Produto Cadeira Top??zio	11	13	899.99	9.970	14.11	66.00	26.89	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
141	Painel Fasc??nio 1.70	Produto Painel Fasc??nio 1.70	\N	5	59.40	7.070	33.05	18.90	18.50	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
142	Toalheiro Comeia	Produto Toalheiro Comeia	\N	12	300.00	1.380	18.15	37.92	24.22	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
143	Protetor T??rmico	Produto Protetor T??rmico	\N	5	61.80	0.880	55.54	42.64	58.82	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
144	Condicionador 2.5L	Produto Condicionador 2.5L	\N	5	63.00	2.070	46.68	22.02	36.45	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
145	Poltrona Bra??o Cromado	Produto Poltrona Bra??o Cromado	11	10	261.00	6.620	43.79	56.69	41.57	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
146	Painel Fasc??nio 1.35	Produto Painel Fasc??nio 1.35	\N	12	222.00	2.500	43.05	30.20	68.48	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
147	Kit Home Care Inovattor	Produto Kit Home Care Inovattor	\N	5	49.80	7.510	18.11	25.87	65.62	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
148	Kit Home Care Extreme-up	Produto Kit Home Care Extreme-up	\N	5	55.20	3.720	39.87	48.22	12.78	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
149	Cadeira Capton?? Reclin??vel Bra??o Madeira	Produto Cadeira Capton?? Reclin??vel Bra??o Madeira	11	9	1074.00	9.350	34.94	30.43	15.71	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
150	Cadeira Capton?? Fixa Bra??o Madeira	Produto Cadeira Capton?? Fixa Bra??o Madeira	11	9	894.00	0.520	71.93	66.52	35.30	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
151	Lavat??rio Capton?? Bra??o Madeira Cuba de Lou??a Branca	Produto Lavat??rio Capton?? Bra??o Madeira Cuba de Lou??a Branca	\N	9	1494.00	5.070	81.06	39.84	23.84	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
152	Avental Barbeiro	Produto Avental Barbeiro	\N	16	30.00	1.880	73.27	49.15	62.95	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
153	Lavat??rio Capton?? Cuba de Lou??a Branca	Produto Lavat??rio Capton?? Cuba de Lou??a Branca	\N	10	1494.00	3.330	59.01	26.02	31.93	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
154	Suporte de P?? Dompel	Produto Suporte de P?? Dompel	\N	14	51.00	10.340	65.00	37.20	45.25	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
155	Cadeira Elegance Fixa Base Inox	Produto Cadeira Elegance Fixa Base Inox	11	9	1014.00	6.390	47.73	47.22	56.09	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
156	Kit Extreme UP	Produto Kit Extreme UP	\N	5	311.40	2.980	75.73	11.73	67.91	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
157	Ciranda Spyder Manicure	Produto Ciranda Spyder Manicure	\N	11	419.40	3.690	58.54	57.09	56.52	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
158	Ciranda Big Scarlet 	Produto Ciranda Big Scarlet 	\N	10	359.40	5.230	31.47	14.80	64.97	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
159	Cadeira Arizona	Produto Cadeira Arizona	11	11	1500.00	2.260	78.55	53.80	16.22	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
160	Cadeira Capton?? Fixa Base Quadrada	Produto Cadeira Capton?? Fixa Base Quadrada	11	10	810.00	3.930	58.91	65.92	65.40	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
161	Cadeira Capton?? Reclin??vel Base Quadrada	Produto Cadeira Capton?? Reclin??vel Base Quadrada	11	10	930.00	10.100	48.29	69.30	26.47	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
162	Ciranda Big Capton??	Produto Ciranda Big Capton??	\N	10	360.00	10.110	85.75	36.76	51.91	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
163	Cadeira Capton?? Fixa Base Pentap??	Produto Cadeira Capton?? Fixa Base Pentap??	11	10	810.00	5.310	64.94	13.36	33.78	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
164	Kit Extreme UP Manuten????o	Produto Kit Extreme UP Manuten????o	\N	5	61.20	10.150	23.76	30.94	51.93	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
165	Kit Pentes de M??quina	Produto Kit Pentes de M??quina	\N	16	29.40	9.280	81.65	13.48	45.08	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
166	Maca Maleta	Produto Maca Maleta	\N	17	414.00	3.870	19.25	14.32	30.81	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
167	 ia????o de Tesoura 	Produto  ia????o de Tesoura 	\N	20	27.00	6.620	66.89	58.39	54.73	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
168	Lavat??rio Elegance Cuba de Lou??a Preta	Produto Lavat??rio Elegance Cuba de Lou??a Preta	\N	9	1560.00	5.830	72.10	42.12	42.96	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
169	Condicionador Trivitt Pequeno	Produto Condicionador Trivitt Pequeno	\N	5	24.60	10.420	33.72	18.58	56.42	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
170	Ciranda Scarlet Big	Produto Ciranda Scarlet Big	\N	10	354.00	8.950	46.27	19.08	52.73	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
171	P??zinho de Cadeira	Produto P??zinho de Cadeira	\N	6	6.00	3.790	16.11	36.96	61.01	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
172	Ducha Sais Minerais	Produto Ducha Sais Minerais	\N	6	60.00	7.390	79.81	35.98	50.88	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
173	Suporte de Ciranda	Produto Suporte de Ciranda	\N	10	6.00	1.260	81.14	54.78	39.87	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
174	Ciranda Elegance 	Produto Ciranda Elegance 	\N	9	294.00	9.750	51.50	56.68	37.82	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
175	Mangueira Cromada	Produto Mangueira Cromada	\N	6	72.00	9.120	45.90	21.18	20.09	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
176	Ciranda Capton??	Produto Ciranda Capton??	\N	10	300.00	2.790	71.86	10.62	29.12	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
177	Mangueira Simples	Produto Mangueira Simples	\N	6	30.00	5.980	85.06	64.31	35.53	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
178	Parap?? de Cadeira	Produto Parap?? de Cadeira	\N	6	36.00	6.520	17.56	30.59	49.86	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
179	Bancada Fascinio 3 Gavetas	Produto Bancada Fascinio 3 Gavetas	\N	12	228.00	8.170	72.99	55.97	45.00	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
180	Ciranda Elegance Big	Produto Ciranda Elegance Big	\N	9	360.00	5.050	30.64	66.62	17.69	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
181	Mesa Manicure Havanna	Produto Mesa Manicure Havanna	\N	11	840.00	0.610	42.25	54.48	33.23	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
182	Console Havanna	Produto Console Havanna	\N	11	600.00	6.880	67.07	41.03	38.96	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
183	Assento Elegance	Produto Assento Elegance	11	9	480.00	5.550	34.81	43.98	60.34	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
184	M??scara 2kg	Produto M??scara 2kg	\N	15	154.80	9.660	47.63	29.33	38.89	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
185	Hidrata????o Matizante 250g	Produto Hidrata????o Matizante 250g	\N	5	25.20	9.820	63.33	66.41	13.15	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
186	Power Oil	Produto Power Oil	\N	5	25.20	1.460	87.95	57.19	64.23	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
187	Borracha de Lavat??rio	Produto Borracha de Lavat??rio	\N	6	78.00	6.190	78.34	68.39	56.15	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
188	Bancada Fascinio 3 Gavetas 2m	Produto Bancada Fascinio 3 Gavetas 2m	\N	12	360.00	1.770	38.17	35.94	27.56	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
189	Aparador de C ??	Produto Aparador de C ??	\N	3	300.00	5.400	73.56	10.57	15.11	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
190	Kit Lavat??rio	Produto Kit Lavat??rio	\N	5	216.00	9.470	47.57	41.27	19.41	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
191	Hidrata????o Matizante Pequena	Produto Hidrata????o Matizante Pequena	\N	5	25.20	8.790	51.25	18.67	46.19	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
192	Toalheiro 6 V??os	Produto Toalheiro 6 V??os	\N	12	270.00	6.150	72.53	46.12	15.60	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
193	Cabe??ote de Cadeira	Produto Cabe??ote de Cadeira	\N	6	18.00	8.290	51.49	33.34	63.28	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
194	Bico Secador	Produto Bico Secador	\N	16	12.00	9.340	62.21	53.68	55.37	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
195	Mesa rm L	Produto Mesa rm L	\N	12	270.00	9.050	52.66	39.74	62.58	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
196	Blinda Fios	Produto Blinda Fios	\N	5	57.00	7.210	76.02	33.62	33.98	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
197	Poltrona Maquiagem com Pezeira	Produto Poltrona Maquiagem com Pezeira	11	13	1199.40	3.240	21.76	47.12	54.02	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
198	Carrinho M??naco 	Produto Carrinho M??naco 	\N	11	360.00	9.760	73.15	42.29	21.41	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
199	Chuveiro I??nico 	Produto Chuveiro I??nico 	\N	6	30.00	4.090	33.29	61.49	26.56	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
200	Mesa L 	Produto Mesa L 	\N	12	239.40	4.930	44.00	13.97	50.63	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
201	Selagem	Produto Selagem	\N	5	60.00	1.160	78.70	52.21	40.73	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
202	Kit Elegance (2 cad Fixa/ 1 Lav)	Produto Kit Elegance (2 cad Fixa/ 1 Lav)	11	9	3660.00	8.270	67.15	27.02	28.89	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
203	Kit Suporte Manicure	Produto Kit Suporte Manicure	\N	10	180.00	3.080	15.87	68.44	58.41	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
204	Kit Triviit Sal??o	Produto Kit Triviit Sal??o	\N	5	192.00	4.970	84.66	10.12	53.86	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
205	NutriL??pidca	Produto NutriL??pidca	\N	5	93.00	3.600	49.73	17.41	46.67	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
206	Kit Elegance (1 cad Fixa/ 1 Lav)	Produto Kit Elegance (1 cad Fixa/ 1 Lav)	11	9	2400.00	3.140	35.73	64.76	51.16	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
207	Mousse Penteado	Produto Mousse Penteado	\N	5	42.00	6.370	80.96	66.67	51.30	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
208	Chuveiro Simples	Produto Chuveiro Simples	\N	6	30.00	7.820	46.21	11.92	54.44	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
209	Lavat??rio Elegance com Pezeira	Produto Lavat??rio Elegance com Pezeira	\N	9	2034.00	4.400	54.08	14.51	48.10	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
210	S??rum Inovattor	Produto S??rum Inovattor	\N	5	60.00	2.860	12.04	34.23	20.21	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
211	??cido Hialur??nico	Produto ??cido Hialur??nico	\N	5	11.40	9.050	38.64	64.61	58.90	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
212	Poltrona Elegance Bra??o Arrendondado Fixa Base Quadrada	Produto Poltrona Elegance Bra??o Arrendondado Fixa Base Quadrada	11	9	1079.99	1.580	66.01	58.76	44.02	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
213	Apoio de Lavat??rio	Produto Apoio de Lavat??rio	11	9	210.00	7.640	55.59	53.01	17.04	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
214	Kit Elegance (2 cad Recl/ 1 Lav)	Produto Kit Elegance (2 cad Recl/ 1 Lav)	11	9	3876.00	5.820	20.04	57.15	23.09	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
215	Kit Capton?? (1 Cad Fixa / 1 Lav)	Produto Kit Capton?? (1 Cad Fixa / 1 Lav)	11	10	2508.00	3.960	81.63	21.11	35.11	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
216	Pezinho de Apoi Base Hidraulico	Produto Pezinho de Apoi Base Hidraulico	\N	6	4.20	8.860	72.61	15.56	32.54	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
217	Sof?? Elegance	Produto Sof?? Elegance	11	9	498.00	1.040	36.08	65.34	67.08	5	50	t	2026-05-20 02:08:03.924705	2026-05-20 02:08:03.924705
\.


--
-- Data for Name: dim_tipo_movimentacao; Type: TABLE DATA; Schema: estoque; Owner: postgres
--

COPY estoque.dim_tipo_movimentacao (id_tipo_movimentacao, tipo_movimentacao, natureza, categoria, afeta_custo, requer_documento) FROM stdin;
1	Compra	ENTRADA	Reposi├º├úo	t	t
2	Devolu├º├úo Cliente	ENTRADA	Devolu├º├úo	f	t
3	Ajuste Invent├írio +	ENTRADA	Ajuste	t	f
4	Venda	SA├ìDA	Comercial	t	t
5	Devolu├º├úo Fornecedor	SA├ìDA	Devolu├º├úo	t	t
6	Perda/Quebra	SA├ìDA	Perdas	t	t
7	Transfer├¬ncia Sa├¡da	SA├ìDA	Transfer├¬ncia	f	t
8	Transfer├¬ncia Entrada	ENTRADA	Transfer├¬ncia	f	t
9	Ajuste Invent├írio -	SA├ìDA	Ajuste	t	f
10	Compra	ENTRADA	Reposi├º├úo	t	t
11	Devolu├º├úo Cliente	ENTRADA	Devolu├º├úo	f	t
12	Ajuste Invent├írio +	ENTRADA	Ajuste	t	f
13	Venda	SA├ìDA	Comercial	t	t
14	Devolu├º├úo Fornecedor	SA├ìDA	Devolu├º├úo	t	t
15	Perda/Quebra	SA├ìDA	Perdas	t	t
16	Transfer├¬ncia Sa├¡da	SA├ìDA	Transfer├¬ncia	f	t
17	Transfer├¬ncia Entrada	ENTRADA	Transfer├¬ncia	f	t
18	Ajuste Invent├írio -	SA├ìDA	Ajuste	t	f
\.


--
-- Data for Name: dim_transportadora; Type: TABLE DATA; Schema: estoque; Owner: postgres
--

COPY estoque.dim_transportadora (id_transportadora, nome_transportadora, cnpj, telefone, media_entrega, frete_kg_base, adicional_volume, ativo) FROM stdin;
1	RodoMax Log	13.206.664/0001-53	(11) 1643-2128	6	5.00	2.00	t
2	JadLog	04.884.082/0001-35	(11) 9157-7631	4	5.00	2.00	t
3	Group X	41.541.486/0001-52	(11) 1947-4423	7	5.00	2.00	t
4	Tadex Transportes	60.652.120/0002-86	(11) 3868-1414	8	5.00	2.00	t
5	Trasnorte Transportes	18.650.773/0001-89	(11) 5197-3153	24	5.00	2.00	t
6	Speed Transportes	18.226.648/0001-46	(11) 9316-4872	20	5.00	2.00	t
7	Amazon Transportes	01.661.770/0018-96	(11) 5072-2499	26	5.00	2.00	t
8	Aceville Transportes	81.560.047/0001-01	(11) 8970-7519	9	5.00	2.00	t
9	Tr??nsito Brasil	92.528.538/0001-91	(11) 6247-5273	12	5.00	2.00	t
10	Alfa Transportes	82.110.818/0001-21	(11) 1299-4453	10	5.00	2.00	t
11	P??ssaro Transportes	20.287.188/0006-12	(11) 4389-9023	15	5.00	2.00	t
12	Luz Transportes	17.344.049/0002-45	(11) 4387-3020	15	5.00	2.00	t
13	TPN - Transportadora Primeiro do Nordeste	15.129.315/0001-00	(11) 8794-6006	18	5.00	2.00	t
14	Expresso Rio Vermelho	07.655.407/0002-87	(11) 8939-1671	14	5.00	2.00	t
15	Manda-l?? Transportes	03.298.420/0001-94	(11) 5768-3405	12	5.00	2.00	t
\.


--
-- Data for Name: fato_movimentacao_estoque; Type: TABLE DATA; Schema: estoque; Owner: postgres
--

COPY estoque.fato_movimentacao_estoque (id_movimentacao, fk_tempo, fk_produto, fk_tipo_movimentacao, fk_fornecedor, quantidade, valor_unitario, valor_total, saldo_anterior, saldo_atual, data_hora_movimentacao) FROM stdin;
1	4615	161	1	16	65	210.00	21450.00	0	555	2021-08-21 00:00:00
2	4627	161	1	16	87	210.00	28710.00	555	213	2021-09-02 00:00:00
3	4730	161	1	16	19	210.00	6270.00	213	306	2021-12-14 00:00:00
4	4858	161	1	16	59	210.00	19470.00	306	144	2022-04-21 00:00:00
5	4725	161	1	16	80	210.00	26400.00	144	705	2021-12-09 00:00:00
6	4501	161	1	16	57	210.00	18810.00	705	521	2021-04-29 00:00:00
7	4585	161	1	16	33	210.00	10890.00	521	481	2021-07-22 00:00:00
8	4859	161	1	16	99	210.00	32670.00	481	893	2022-04-22 00:00:00
9	4570	161	1	16	9	210.00	2970.00	893	54	2021-07-07 00:00:00
10	4478	161	1	16	35	210.00	11550.00	54	881	2021-04-06 00:00:00
11	4681	161	1	16	92	210.00	30360.00	881	462	2021-10-26 00:00:00
12	4665	161	1	16	100	210.00	33000.00	462	427	2021-10-10 00:00:00
13	4653	161	1	16	59	210.00	19470.00	427	792	2021-09-28 00:00:00
14	4411	161	1	16	100	210.00	33000.00	792	917	2021-01-29 00:00:00
15	4873	161	1	16	4	210.00	1320.00	917	249	2022-05-06 00:00:00
16	4692	161	1	16	30	210.00	9900.00	249	611	2021-11-06 00:00:00
17	4773	161	1	16	34	210.00	11220.00	611	529	2022-01-26 00:00:00
18	4737	161	1	16	81	210.00	26730.00	529	966	2021-12-21 00:00:00
19	4886	161	1	16	88	210.00	29040.00	966	643	2022-05-19 00:00:00
20	4425	161	1	16	78	210.00	25740.00	643	594	2021-02-12 00:00:00
21	4466	161	1	16	78	210.00	25740.00	594	349	2021-03-25 00:00:00
22	4635	161	1	16	69	210.00	22770.00	349	168	2021-09-10 00:00:00
23	4498	161	1	16	32	210.00	10560.00	168	334	2021-04-26 00:00:00
24	4590	161	1	16	96	210.00	31680.00	334	350	2021-07-27 00:00:00
25	4812	161	1	16	94	210.00	31020.00	350	115	2022-03-06 00:00:00
26	4520	161	1	16	78	210.00	25740.00	115	294	2021-05-18 00:00:00
27	4687	161	1	16	46	210.00	15180.00	294	444	2021-11-01 00:00:00
28	4723	161	1	16	43	210.00	14190.00	444	643	2021-12-07 00:00:00
29	4773	161	1	16	44	210.00	14520.00	643	979	2022-01-26 00:00:00
30	4900	161	1	16	65	210.00	21450.00	979	801	2022-06-02 00:00:00
31	4397	161	1	16	30	210.00	9900.00	801	657	2021-01-15 00:00:00
32	4507	161	1	16	36	210.00	11880.00	657	706	2021-05-05 00:00:00
33	4776	161	1	16	32	210.00	10560.00	706	759	2022-01-29 00:00:00
34	4701	161	1	16	24	210.00	7920.00	759	902	2021-11-15 00:00:00
35	4474	161	1	16	74	210.00	24420.00	902	417	2021-04-02 00:00:00
36	4734	161	1	16	47	210.00	15510.00	417	842	2021-12-18 00:00:00
37	4494	161	1	16	66	210.00	21780.00	842	798	2021-04-22 00:00:00
38	4594	161	1	16	88	210.00	29040.00	798	511	2021-07-31 00:00:00
39	4752	161	1	16	78	210.00	25740.00	511	55	2022-01-05 00:00:00
40	4631	161	1	16	28	210.00	9240.00	55	844	2021-09-06 00:00:00
41	4587	161	1	16	47	210.00	15510.00	844	296	2021-07-24 00:00:00
42	4852	161	1	16	83	210.00	27390.00	296	261	2022-04-15 00:00:00
43	4535	161	1	16	85	210.00	28050.00	261	802	2021-06-02 00:00:00
44	4709	161	1	16	2	210.00	660.00	802	401	2021-11-23 00:00:00
45	4843	161	1	16	69	210.00	22770.00	401	356	2022-04-06 00:00:00
46	4829	161	1	16	52	210.00	17160.00	356	466	2022-03-23 00:00:00
47	4899	161	1	16	33	210.00	10890.00	466	306	2022-06-01 00:00:00
48	4466	161	1	16	71	210.00	23430.00	306	692	2021-03-25 00:00:00
49	4725	161	1	16	59	210.00	19470.00	692	209	2021-12-09 00:00:00
50	4615	161	1	16	11	210.00	3630.00	209	354	2021-08-21 00:00:00
51	4791	161	1	16	90	210.00	29700.00	354	759	2022-02-13 00:00:00
52	4612	161	1	16	51	210.00	16830.00	759	66	2021-08-18 00:00:00
53	4912	161	1	16	87	210.00	28710.00	66	626	2022-06-14 00:00:00
54	4814	161	1	16	13	210.00	4290.00	626	176	2022-03-08 00:00:00
55	4448	161	1	16	97	210.00	32010.00	176	790	2021-03-07 00:00:00
56	4509	161	1	16	81	210.00	26730.00	790	170	2021-05-07 00:00:00
57	4385	161	1	16	33	210.00	10890.00	170	463	2021-01-03 00:00:00
58	4750	161	1	16	18	210.00	5940.00	463	810	2022-01-03 00:00:00
59	4503	161	1	16	82	210.00	27060.00	810	599	2021-05-01 00:00:00
60	4606	161	1	16	2	210.00	660.00	599	746	2021-08-12 00:00:00
61	4474	161	1	16	10	210.00	3300.00	746	134	2021-04-02 00:00:00
62	4824	161	1	16	55	210.00	18150.00	134	264	2022-03-18 00:00:00
63	4722	161	1	16	4	210.00	1320.00	264	66	2021-12-06 00:00:00
64	4410	161	1	16	86	210.00	28380.00	66	76	2021-01-28 00:00:00
65	4466	161	1	16	33	210.00	10890.00	76	389	2021-03-25 00:00:00
66	4518	161	1	16	3	210.00	990.00	389	558	2021-05-16 00:00:00
67	4716	161	1	16	95	210.00	31350.00	558	492	2021-11-30 00:00:00
68	4488	161	1	16	64	210.00	21120.00	492	374	2021-04-16 00:00:00
69	4451	161	1	16	70	210.00	23100.00	374	974	2021-03-10 00:00:00
70	4437	161	1	16	18	210.00	5940.00	974	961	2021-02-24 00:00:00
71	4487	161	1	16	8	210.00	2640.00	961	115	2021-04-15 00:00:00
72	4659	161	1	16	51	210.00	16830.00	115	880	2021-10-04 00:00:00
73	4651	161	1	16	2	210.00	660.00	880	640	2021-09-26 00:00:00
74	4633	161	1	16	82	210.00	27060.00	640	147	2021-09-08 00:00:00
75	4675	161	1	16	21	210.00	6930.00	147	662	2021-10-20 00:00:00
76	4535	161	1	16	62	210.00	20460.00	662	976	2021-06-02 00:00:00
77	4434	161	1	16	24	210.00	7920.00	976	979	2021-02-21 00:00:00
78	4843	161	1	16	79	210.00	26070.00	979	651	2022-04-06 00:00:00
79	4552	161	1	16	83	210.00	27390.00	651	961	2021-06-19 00:00:00
80	4830	161	1	16	4	210.00	1320.00	961	518	2022-03-24 00:00:00
81	4876	161	1	16	8	210.00	2640.00	518	236	2022-05-09 00:00:00
82	4418	161	1	16	51	210.00	16830.00	236	764	2021-02-05 00:00:00
83	4752	161	1	16	23	210.00	7590.00	764	486	2022-01-05 00:00:00
84	4554	161	1	16	84	210.00	27720.00	486	841	2021-06-21 00:00:00
85	4861	161	1	16	39	210.00	12870.00	841	920	2022-04-24 00:00:00
86	4846	161	1	16	19	210.00	6270.00	920	226	2022-04-09 00:00:00
87	4580	161	1	16	92	210.00	30360.00	226	241	2021-07-17 00:00:00
88	4725	161	1	16	20	210.00	6600.00	241	451	2021-12-09 00:00:00
89	4460	161	1	16	4	210.00	1320.00	451	65	2021-03-19 00:00:00
90	4846	161	1	16	43	210.00	14190.00	65	736	2022-04-09 00:00:00
91	4544	161	1	16	26	210.00	8580.00	736	364	2021-06-11 00:00:00
92	4773	161	1	16	4	210.00	1320.00	364	774	2022-01-26 00:00:00
93	4888	161	1	16	33	210.00	10890.00	774	728	2022-05-21 00:00:00
94	4792	161	1	16	85	210.00	28050.00	728	988	2022-02-14 00:00:00
95	4410	161	1	16	68	210.00	22440.00	988	82	2021-01-28 00:00:00
96	4640	161	1	16	5	210.00	1650.00	82	62	2021-09-15 00:00:00
97	4646	161	1	16	82	210.00	27060.00	62	139	2021-09-21 00:00:00
98	4796	161	1	16	45	210.00	14850.00	139	962	2022-02-18 00:00:00
99	4724	161	1	16	47	210.00	15510.00	962	341	2021-12-08 00:00:00
100	4821	161	1	16	22	210.00	7260.00	341	305	2022-03-15 00:00:00
101	4476	161	1	16	33	210.00	10890.00	305	164	2021-04-04 00:00:00
102	4611	161	1	16	54	210.00	17820.00	164	344	2021-08-17 00:00:00
103	4503	161	1	16	2	210.00	660.00	344	288	2021-05-01 00:00:00
104	4536	161	1	16	19	210.00	6270.00	288	930	2021-06-03 00:00:00
105	4884	161	1	16	70	210.00	23100.00	930	252	2022-05-17 00:00:00
106	4856	161	1	16	85	210.00	28050.00	252	180	2022-04-19 00:00:00
107	4517	161	1	16	100	210.00	33000.00	180	666	2021-05-15 00:00:00
108	4716	161	1	16	14	210.00	4620.00	666	871	2021-11-30 00:00:00
109	4568	161	1	16	28	210.00	9240.00	871	946	2021-07-05 00:00:00
110	4624	161	1	16	99	210.00	32670.00	946	698	2021-08-30 00:00:00
111	4418	161	1	16	41	210.00	13530.00	698	553	2021-02-05 00:00:00
112	4694	161	1	16	30	210.00	9900.00	553	102	2021-11-08 00:00:00
113	4586	161	1	16	89	210.00	29370.00	102	156	2021-07-23 00:00:00
114	4450	161	1	16	42	210.00	13860.00	156	786	2021-03-09 00:00:00
115	4823	161	1	16	28	210.00	9240.00	786	526	2022-03-17 00:00:00
116	4388	161	1	16	50	210.00	16500.00	526	879	2021-01-06 00:00:00
117	4669	161	1	16	98	210.00	32340.00	879	90	2021-10-14 00:00:00
118	4456	161	1	16	50	210.00	16500.00	90	922	2021-03-15 00:00:00
119	4720	161	1	16	13	210.00	4290.00	922	318	2021-12-04 00:00:00
120	4564	161	1	16	10	210.00	3300.00	318	115	2021-07-01 00:00:00
121	4524	161	1	16	54	210.00	17820.00	115	659	2021-05-22 00:00:00
122	4692	161	1	16	14	210.00	4620.00	659	468	2021-11-06 00:00:00
123	4784	161	1	16	37	210.00	12210.00	468	272	2022-02-06 00:00:00
124	4898	161	1	16	94	210.00	31020.00	272	817	2022-05-31 00:00:00
125	4448	161	1	16	29	210.00	9570.00	817	305	2021-03-07 00:00:00
126	4459	161	1	16	60	210.00	19800.00	305	364	2021-03-18 00:00:00
127	4658	161	1	16	15	210.00	4950.00	364	780	2021-10-03 00:00:00
128	4824	161	1	16	53	210.00	17490.00	780	422	2022-03-18 00:00:00
129	4830	161	1	16	6	210.00	1980.00	422	596	2022-03-24 00:00:00
130	4560	161	1	16	67	210.00	22110.00	596	139	2021-06-27 00:00:00
131	4666	161	1	16	93	210.00	30690.00	139	204	2021-10-11 00:00:00
132	4466	161	1	16	56	210.00	18480.00	204	550	2021-03-25 00:00:00
133	4820	161	1	16	82	210.00	27060.00	550	577	2022-03-14 00:00:00
134	4579	161	1	16	52	210.00	17160.00	577	544	2021-07-16 00:00:00
135	4660	161	1	16	2	210.00	660.00	544	141	2021-10-05 00:00:00
136	4501	161	1	16	41	210.00	13530.00	141	697	2021-04-29 00:00:00
137	4396	161	1	16	3	210.00	990.00	697	318	2021-01-14 00:00:00
138	4686	161	1	16	89	210.00	29370.00	318	659	2021-10-31 00:00:00
139	4721	161	1	16	19	210.00	6270.00	659	310	2021-12-05 00:00:00
140	4671	161	1	16	14	210.00	4620.00	310	733	2021-10-16 00:00:00
141	4622	161	1	16	6	210.00	1980.00	733	941	2021-08-28 00:00:00
142	4611	161	1	16	95	210.00	31350.00	941	65	2021-08-17 00:00:00
143	4914	161	1	16	56	210.00	18480.00	65	653	2022-06-16 00:00:00
144	4824	161	1	16	28	210.00	9240.00	653	517	2022-03-18 00:00:00
145	4427	161	1	16	28	210.00	9240.00	517	326	2021-02-14 00:00:00
146	4846	161	1	16	64	210.00	21120.00	326	354	2022-04-09 00:00:00
147	4450	161	1	16	72	210.00	23760.00	354	187	2021-03-09 00:00:00
148	4736	161	1	16	5	210.00	1650.00	187	934	2021-12-20 00:00:00
149	4834	161	1	16	76	210.00	25080.00	934	231	2022-03-28 00:00:00
150	4751	161	1	16	64	210.00	21120.00	231	714	2022-01-04 00:00:00
151	4544	161	1	16	76	210.00	25080.00	714	664	2021-06-11 00:00:00
152	4873	161	1	16	12	210.00	3960.00	664	587	2022-05-06 00:00:00
153	4642	161	1	16	34	210.00	11220.00	587	804	2021-09-17 00:00:00
154	4853	161	1	16	49	210.00	16170.00	804	747	2022-04-16 00:00:00
155	4698	161	1	16	6	210.00	1980.00	747	509	2021-11-12 00:00:00
156	4896	161	1	16	8	210.00	2640.00	509	852	2022-05-29 00:00:00
157	4830	161	1	16	100	210.00	33000.00	852	277	2022-03-24 00:00:00
158	4569	161	1	16	96	210.00	31680.00	277	455	2021-07-06 00:00:00
159	4576	161	1	16	94	210.00	31020.00	455	971	2021-07-13 00:00:00
160	4914	161	1	16	5	210.00	1650.00	971	829	2022-06-16 00:00:00
161	4647	161	1	16	77	210.00	25410.00	829	343	2021-09-22 00:00:00
162	4686	161	1	16	7	210.00	2310.00	343	333	2021-10-31 00:00:00
163	4432	161	1	16	74	210.00	24420.00	333	68	2021-02-19 00:00:00
164	4560	161	1	16	38	210.00	12540.00	68	430	2021-06-27 00:00:00
165	4779	161	1	16	12	210.00	3960.00	430	208	2022-02-01 00:00:00
166	4849	161	1	16	53	210.00	17490.00	208	572	2022-04-12 00:00:00
167	4771	161	1	16	37	210.00	12210.00	572	232	2022-01-24 00:00:00
168	4563	161	1	16	90	210.00	29700.00	232	620	2021-06-30 00:00:00
169	4466	161	1	16	59	210.00	19470.00	620	191	2021-03-25 00:00:00
170	4541	161	1	16	89	210.00	29370.00	191	58	2021-06-08 00:00:00
171	4748	161	1	16	22	210.00	7260.00	58	815	2022-01-01 00:00:00
172	4622	161	1	16	1	210.00	330.00	815	872	2021-08-28 00:00:00
173	4888	161	1	16	4	210.00	1320.00	872	530	2022-05-21 00:00:00
174	4570	161	1	16	84	210.00	27720.00	530	492	2021-07-07 00:00:00
175	4652	161	1	16	61	210.00	20130.00	492	271	2021-09-27 00:00:00
176	4599	161	1	16	95	210.00	31350.00	271	586	2021-08-05 00:00:00
177	4410	161	1	16	9	210.00	2970.00	586	547	2021-01-28 00:00:00
178	4546	161	1	16	83	210.00	27390.00	547	783	2021-06-13 00:00:00
179	4551	161	1	16	73	210.00	24090.00	783	764	2021-06-18 00:00:00
180	4527	161	1	16	18	210.00	5940.00	764	760	2021-05-25 00:00:00
181	4530	161	1	16	74	210.00	24420.00	760	792	2021-05-28 00:00:00
182	4640	161	1	16	76	210.00	25080.00	792	119	2021-09-15 00:00:00
183	4481	161	1	16	61	210.00	20130.00	119	280	2021-04-09 00:00:00
184	4735	161	1	16	56	210.00	18480.00	280	911	2021-12-19 00:00:00
185	4456	161	1	16	62	210.00	20460.00	911	546	2021-03-15 00:00:00
186	4818	161	1	16	92	210.00	30360.00	546	73	2022-03-12 00:00:00
187	4413	161	1	16	93	210.00	30690.00	73	711	2021-01-31 00:00:00
188	4564	161	1	16	11	210.00	3630.00	711	438	2021-07-01 00:00:00
189	4647	161	1	16	41	210.00	13530.00	438	248	2021-09-22 00:00:00
190	4821	161	1	16	75	210.00	24750.00	248	804	2022-03-15 00:00:00
191	4649	161	1	16	97	210.00	32010.00	804	230	2021-09-24 00:00:00
192	4614	161	1	16	91	210.00	30030.00	230	163	2021-08-20 00:00:00
193	4813	161	1	16	59	210.00	19470.00	163	170	2022-03-07 00:00:00
194	4740	161	1	16	14	210.00	4620.00	170	908	2021-12-24 00:00:00
195	4665	161	1	16	63	210.00	20790.00	908	448	2021-10-10 00:00:00
196	4458	161	1	16	74	210.00	24420.00	448	968	2021-03-17 00:00:00
197	4857	161	1	16	17	210.00	5610.00	968	761	2022-04-20 00:00:00
198	4440	161	1	16	72	210.00	23760.00	761	128	2021-02-27 00:00:00
199	4781	161	1	16	20	210.00	6600.00	128	906	2022-02-03 00:00:00
200	4735	161	1	16	68	210.00	22440.00	906	153	2021-12-19 00:00:00
201	4504	161	1	16	10	210.00	3300.00	153	639	2021-05-02 00:00:00
202	4821	161	1	16	34	210.00	11220.00	639	676	2022-03-15 00:00:00
203	4737	161	1	16	56	210.00	18480.00	676	997	2021-12-21 00:00:00
204	4883	161	1	16	6	210.00	1980.00	997	288	2022-05-16 00:00:00
205	4388	161	1	16	28	210.00	9240.00	288	782	2021-01-06 00:00:00
206	4391	161	1	16	15	210.00	4950.00	782	108	2021-01-09 00:00:00
207	4611	161	1	16	50	210.00	16500.00	108	807	2021-08-17 00:00:00
208	4562	161	1	16	75	210.00	24750.00	807	865	2021-06-29 00:00:00
209	4421	161	1	16	96	210.00	31680.00	865	363	2021-02-08 00:00:00
210	4716	161	1	16	8	210.00	2640.00	363	304	2021-11-30 00:00:00
211	4534	161	1	16	75	210.00	24750.00	304	312	2021-06-01 00:00:00
212	4587	161	1	16	78	210.00	25740.00	312	839	2021-07-24 00:00:00
213	4621	161	1	16	99	210.00	32670.00	839	172	2021-08-27 00:00:00
214	4752	161	1	16	94	210.00	31020.00	172	378	2022-01-05 00:00:00
215	4610	161	1	16	97	210.00	32010.00	378	674	2021-08-16 00:00:00
216	4438	161	1	16	74	210.00	24420.00	674	728	2021-02-25 00:00:00
217	4915	161	1	16	97	210.00	32010.00	728	571	2022-06-17 00:00:00
218	4428	161	1	16	69	210.00	22770.00	571	566	2021-02-15 00:00:00
219	4596	161	1	16	77	210.00	25410.00	566	356	2021-08-02 00:00:00
220	4427	161	1	16	7	210.00	2310.00	356	375	2021-02-14 00:00:00
221	4522	161	1	16	72	210.00	23760.00	375	174	2021-05-20 00:00:00
222	4821	161	1	16	81	210.00	26730.00	174	129	2022-03-15 00:00:00
223	4851	161	1	16	28	210.00	9240.00	129	119	2022-04-14 00:00:00
224	4635	161	1	16	50	210.00	16500.00	119	474	2021-09-10 00:00:00
225	4688	161	1	16	84	210.00	27720.00	474	748	2021-11-02 00:00:00
226	4912	161	1	16	93	210.00	30690.00	748	906	2022-06-14 00:00:00
227	4679	161	1	16	75	210.00	24750.00	906	593	2021-10-24 00:00:00
228	4863	161	1	16	42	210.00	13860.00	593	126	2022-04-26 00:00:00
229	4453	161	1	16	78	210.00	25740.00	126	789	2021-03-12 00:00:00
230	4396	161	1	16	56	210.00	18480.00	789	571	2021-01-14 00:00:00
231	4462	161	1	16	93	210.00	30690.00	571	326	2021-03-21 00:00:00
232	4494	161	1	16	13	210.00	4290.00	326	444	2021-04-22 00:00:00
233	4829	161	1	16	37	210.00	12210.00	444	548	2022-03-23 00:00:00
234	4507	161	1	16	68	210.00	22440.00	548	75	2021-05-05 00:00:00
235	4392	161	1	16	28	210.00	9240.00	75	447	2021-01-10 00:00:00
236	4424	161	1	16	62	210.00	20460.00	447	713	2021-02-11 00:00:00
237	4830	161	1	16	4	210.00	1320.00	713	739	2022-03-24 00:00:00
238	4618	161	1	16	69	210.00	22770.00	739	941	2021-08-24 00:00:00
239	4635	161	1	16	59	210.00	19470.00	941	472	2021-09-10 00:00:00
240	4876	161	1	16	50	210.00	16500.00	472	438	2022-05-09 00:00:00
241	4775	161	1	16	28	210.00	9240.00	438	798	2022-01-28 00:00:00
242	4539	161	1	16	97	210.00	32010.00	798	747	2021-06-06 00:00:00
243	4792	161	1	16	40	210.00	13200.00	747	688	2022-02-14 00:00:00
244	4810	161	1	16	33	210.00	10890.00	688	190	2022-03-04 00:00:00
245	4861	161	1	16	55	210.00	18150.00	190	521	2022-04-24 00:00:00
246	4850	161	1	16	45	210.00	14850.00	521	620	2022-04-13 00:00:00
247	4775	161	1	16	36	210.00	11880.00	620	620	2022-01-28 00:00:00
248	4522	161	1	16	8	210.00	2640.00	620	607	2021-05-20 00:00:00
249	4639	161	1	16	44	210.00	14520.00	607	359	2021-09-14 00:00:00
250	4615	161	1	16	95	210.00	31350.00	359	560	2021-08-21 00:00:00
251	4711	161	1	16	64	210.00	21120.00	560	273	2021-11-25 00:00:00
252	4448	161	1	16	39	210.00	12870.00	273	381	2021-03-07 00:00:00
253	4535	161	1	16	32	210.00	10560.00	381	863	2021-06-02 00:00:00
254	4737	161	1	16	98	210.00	32340.00	863	397	2021-12-21 00:00:00
255	4800	161	1	16	87	210.00	28710.00	397	518	2022-02-22 00:00:00
256	4608	161	1	16	31	210.00	10230.00	518	899	2021-08-14 00:00:00
257	4387	161	1	16	73	210.00	24090.00	899	677	2021-01-05 00:00:00
258	4550	161	1	16	19	210.00	6270.00	677	320	2021-06-17 00:00:00
259	4585	161	1	16	46	210.00	15180.00	320	290	2021-07-22 00:00:00
260	4740	161	1	16	40	210.00	13200.00	290	788	2021-12-24 00:00:00
261	4671	161	1	16	27	210.00	8910.00	788	169	2021-10-16 00:00:00
262	4666	161	1	16	40	210.00	13200.00	169	413	2021-10-11 00:00:00
263	4558	161	1	16	71	210.00	23430.00	413	172	2021-06-25 00:00:00
264	4891	161	1	16	57	210.00	18810.00	172	443	2022-05-24 00:00:00
265	4741	161	1	16	58	210.00	19140.00	443	934	2021-12-25 00:00:00
266	4427	161	1	16	67	210.00	22110.00	934	500	2021-02-14 00:00:00
267	4668	161	1	16	50	210.00	16500.00	500	681	2021-10-13 00:00:00
268	4450	161	1	16	30	210.00	9900.00	681	974	2021-03-09 00:00:00
269	4751	161	1	16	78	210.00	25740.00	974	988	2022-01-04 00:00:00
270	4397	161	1	16	10	210.00	3300.00	988	199	2021-01-15 00:00:00
271	4876	161	1	16	64	210.00	21120.00	199	328	2022-05-09 00:00:00
272	4709	161	1	16	31	210.00	10230.00	328	374	2021-11-23 00:00:00
273	4684	161	1	16	3	210.00	990.00	374	888	2021-10-29 00:00:00
274	4829	161	1	16	30	210.00	9900.00	888	189	2022-03-23 00:00:00
275	4659	161	1	16	23	210.00	7590.00	189	175	2021-10-04 00:00:00
276	4838	161	1	16	30	210.00	9900.00	175	707	2022-04-01 00:00:00
277	4750	161	1	16	13	210.00	4290.00	707	325	2022-01-03 00:00:00
278	4891	161	1	16	80	210.00	26400.00	325	948	2022-05-24 00:00:00
279	4809	161	1	16	79	210.00	26070.00	948	151	2022-03-03 00:00:00
280	4448	161	1	16	10	210.00	3300.00	151	893	2021-03-07 00:00:00
281	4455	161	1	16	94	210.00	31020.00	893	703	2021-03-14 00:00:00
282	4643	161	1	16	19	210.00	6270.00	703	135	2021-09-18 00:00:00
283	4840	161	1	16	10	210.00	3300.00	135	90	2022-04-03 00:00:00
284	4734	161	1	16	60	210.00	19800.00	90	246	2021-12-18 00:00:00
285	4856	161	1	16	80	210.00	26400.00	246	872	2022-04-19 00:00:00
286	4537	161	1	16	90	210.00	29700.00	872	256	2021-06-04 00:00:00
287	4811	161	1	16	31	210.00	10230.00	256	162	2022-03-05 00:00:00
288	4453	161	1	16	94	210.00	31020.00	162	131	2021-03-12 00:00:00
289	4788	161	1	16	53	210.00	17490.00	131	761	2022-02-10 00:00:00
290	4748	161	1	16	82	210.00	27060.00	761	430	2022-01-01 00:00:00
291	4796	161	1	16	9	210.00	2970.00	430	850	2022-02-18 00:00:00
292	4385	161	1	16	46	210.00	15180.00	850	194	2021-01-03 00:00:00
293	4483	161	1	16	49	210.00	16170.00	194	748	2021-04-11 00:00:00
294	4725	161	1	16	23	210.00	7590.00	748	86	2021-12-09 00:00:00
295	4750	161	1	16	91	210.00	30030.00	86	371	2022-01-03 00:00:00
296	4788	161	1	16	46	210.00	15180.00	371	835	2022-02-10 00:00:00
297	4810	161	1	16	89	210.00	29370.00	835	816	2022-03-04 00:00:00
298	4876	161	1	16	26	210.00	8580.00	816	542	2022-05-09 00:00:00
299	4545	161	1	16	74	210.00	24420.00	542	345	2021-06-12 00:00:00
300	4648	161	1	16	71	210.00	23430.00	345	642	2021-09-23 00:00:00
301	4392	161	1	16	44	210.00	14520.00	642	715	2021-01-10 00:00:00
302	4609	161	1	16	76	210.00	25080.00	715	666	2021-08-15 00:00:00
303	4653	161	1	16	99	210.00	32670.00	666	398	2021-09-28 00:00:00
304	4642	161	1	16	52	210.00	17160.00	398	543	2021-09-17 00:00:00
305	4737	161	1	16	42	210.00	13860.00	543	291	2021-12-21 00:00:00
306	4913	161	1	16	90	210.00	29700.00	291	149	2022-06-15 00:00:00
307	4498	161	1	16	64	210.00	21120.00	149	990	2021-04-26 00:00:00
308	4563	161	1	16	5	210.00	1650.00	990	988	2021-06-30 00:00:00
309	4488	161	1	16	55	210.00	18150.00	988	619	2021-04-16 00:00:00
310	4540	161	1	16	3	210.00	990.00	619	937	2021-06-07 00:00:00
311	4829	161	1	16	11	210.00	3630.00	937	913	2022-03-23 00:00:00
312	4656	161	1	16	45	210.00	14850.00	913	391	2021-10-01 00:00:00
313	4579	161	1	16	58	210.00	19140.00	391	98	2021-07-16 00:00:00
314	4629	161	1	16	71	210.00	23430.00	98	143	2021-09-04 00:00:00
315	4724	161	1	16	32	210.00	10560.00	143	332	2021-12-08 00:00:00
316	4753	161	1	16	88	210.00	29040.00	332	892	2022-01-06 00:00:00
317	4654	161	1	16	7	210.00	2310.00	892	518	2021-09-29 00:00:00
318	4652	161	1	16	73	210.00	24090.00	518	57	2021-09-27 00:00:00
319	4652	161	1	16	99	210.00	32670.00	57	604	2021-09-27 00:00:00
320	4482	161	1	16	51	210.00	16830.00	604	614	2021-04-10 00:00:00
321	4434	161	1	16	8	210.00	2640.00	614	378	2021-02-21 00:00:00
322	4812	161	1	16	1	210.00	330.00	378	721	2022-03-06 00:00:00
323	4413	161	1	16	61	210.00	20130.00	721	186	2021-01-31 00:00:00
324	4459	161	1	16	79	210.00	26070.00	186	842	2021-03-18 00:00:00
325	4539	161	1	16	25	210.00	8250.00	842	145	2021-06-06 00:00:00
326	4509	161	1	16	56	210.00	18480.00	145	825	2021-05-07 00:00:00
327	4482	161	1	16	99	210.00	32670.00	825	805	2021-04-10 00:00:00
328	4507	161	1	16	53	210.00	17490.00	805	500	2021-05-05 00:00:00
329	4632	161	1	16	63	210.00	20790.00	500	629	2021-09-07 00:00:00
330	4659	161	1	16	80	210.00	26400.00	629	575	2021-10-04 00:00:00
331	4888	161	1	16	81	210.00	26730.00	575	974	2022-05-21 00:00:00
332	4536	161	1	16	14	210.00	4620.00	974	340	2021-06-03 00:00:00
333	4788	161	1	16	67	210.00	22110.00	340	563	2022-02-10 00:00:00
334	4896	161	1	16	37	210.00	12210.00	563	892	2022-05-29 00:00:00
335	4544	161	1	16	39	210.00	12870.00	892	318	2021-06-11 00:00:00
336	4671	161	1	16	37	210.00	12210.00	318	871	2021-10-16 00:00:00
337	4706	161	1	16	34	210.00	11220.00	871	618	2021-11-20 00:00:00
338	4775	161	1	16	90	210.00	29700.00	618	95	2022-01-28 00:00:00
339	4582	161	1	16	59	210.00	19470.00	95	449	2021-07-19 00:00:00
340	4696	161	1	16	22	210.00	7260.00	449	269	2021-11-10 00:00:00
341	4841	161	1	16	91	210.00	30030.00	269	244	2022-04-04 00:00:00
342	4633	161	1	16	2	210.00	660.00	244	232	2021-09-08 00:00:00
343	4432	161	1	16	10	210.00	3300.00	232	334	2021-02-19 00:00:00
344	4813	161	1	16	77	210.00	25410.00	334	744	2022-03-07 00:00:00
345	4701	161	1	16	4	210.00	1320.00	744	151	2021-11-15 00:00:00
346	4596	161	1	16	59	210.00	19470.00	151	970	2021-08-02 00:00:00
347	4896	161	1	16	81	210.00	26730.00	970	463	2022-05-29 00:00:00
348	4517	161	1	16	39	210.00	12870.00	463	259	2021-05-15 00:00:00
349	4398	161	1	16	34	210.00	11220.00	259	849	2021-01-16 00:00:00
350	4593	161	1	16	90	210.00	29700.00	849	173	2021-07-30 00:00:00
351	4795	161	1	16	76	210.00	25080.00	173	743	2022-02-17 00:00:00
352	4405	161	1	16	21	210.00	6930.00	743	273	2021-01-23 00:00:00
353	4738	161	1	16	63	210.00	20790.00	273	281	2021-12-22 00:00:00
354	4874	161	1	16	100	210.00	33000.00	281	170	2022-05-07 00:00:00
355	4833	161	1	16	45	210.00	14850.00	170	713	2022-03-27 00:00:00
356	4480	161	1	16	11	210.00	3630.00	713	838	2021-04-08 00:00:00
357	4596	161	1	16	31	210.00	10230.00	838	641	2021-08-02 00:00:00
358	4635	161	1	16	46	210.00	15180.00	641	150	2021-09-10 00:00:00
359	4627	161	1	16	85	210.00	28050.00	150	67	2021-09-02 00:00:00
360	4487	161	1	16	76	210.00	25080.00	67	413	2021-04-15 00:00:00
361	4916	161	1	16	36	210.00	11880.00	413	568	2022-06-18 00:00:00
362	4418	161	1	16	54	210.00	17820.00	568	770	2021-02-05 00:00:00
363	4391	161	1	16	75	210.00	24750.00	770	492	2021-01-09 00:00:00
364	4570	161	1	16	46	210.00	15180.00	492	890	2021-07-07 00:00:00
365	4428	161	1	16	6	210.00	1980.00	890	476	2021-02-15 00:00:00
366	4716	161	1	16	88	210.00	29040.00	476	961	2021-11-30 00:00:00
367	4631	161	1	16	41	210.00	13530.00	961	633	2021-09-06 00:00:00
368	4544	161	1	16	62	210.00	20460.00	633	455	2021-06-11 00:00:00
369	4643	161	1	16	89	210.00	29370.00	455	830	2021-09-18 00:00:00
370	4541	161	1	16	56	210.00	18480.00	830	60	2021-06-08 00:00:00
371	4645	161	1	16	11	210.00	3630.00	60	871	2021-09-20 00:00:00
372	4647	161	1	16	88	210.00	29040.00	871	734	2021-09-22 00:00:00
373	4457	161	1	16	93	210.00	30690.00	734	613	2021-03-16 00:00:00
374	4829	161	1	16	8	210.00	2640.00	613	259	2022-03-23 00:00:00
375	4535	161	1	16	32	210.00	10560.00	259	466	2021-06-02 00:00:00
376	4549	161	1	16	45	210.00	14850.00	466	579	2021-06-16 00:00:00
377	4903	161	1	16	35	210.00	11550.00	579	650	2022-06-05 00:00:00
378	4474	161	1	16	35	210.00	11550.00	650	886	2021-04-02 00:00:00
379	4830	161	1	16	96	210.00	31680.00	886	564	2022-03-24 00:00:00
380	4405	161	1	16	56	210.00	18480.00	564	656	2021-01-23 00:00:00
381	4833	161	1	16	63	210.00	20790.00	656	173	2022-03-27 00:00:00
382	4611	161	1	16	40	210.00	13200.00	173	948	2021-08-17 00:00:00
383	4642	161	1	16	25	210.00	8250.00	948	370	2021-09-17 00:00:00
384	4590	161	1	16	81	210.00	26730.00	370	744	2021-07-27 00:00:00
385	4511	161	1	16	70	210.00	23100.00	744	844	2021-05-09 00:00:00
386	4883	161	1	16	41	210.00	13530.00	844	907	2022-05-16 00:00:00
387	4848	161	1	16	70	210.00	23100.00	907	905	2022-04-11 00:00:00
388	4856	161	1	16	29	210.00	9570.00	905	172	2022-04-19 00:00:00
389	4530	161	1	16	81	210.00	26730.00	172	400	2021-05-28 00:00:00
390	4511	161	1	16	52	210.00	17160.00	400	837	2021-05-09 00:00:00
391	4877	161	1	16	96	210.00	31680.00	837	275	2022-05-10 00:00:00
392	4518	161	1	16	80	210.00	26400.00	275	799	2021-05-16 00:00:00
393	4498	161	1	16	100	210.00	33000.00	799	703	2021-04-26 00:00:00
394	4798	161	1	16	38	210.00	12540.00	703	747	2022-02-20 00:00:00
395	4552	161	1	16	32	210.00	10560.00	747	843	2021-06-19 00:00:00
396	4785	161	1	16	51	210.00	16830.00	843	117	2022-02-07 00:00:00
397	4424	161	1	16	1	210.00	330.00	117	115	2021-02-11 00:00:00
398	4812	161	1	16	53	210.00	17490.00	115	576	2022-03-06 00:00:00
399	4425	161	1	16	50	210.00	16500.00	576	962	2021-02-12 00:00:00
400	4905	161	1	16	58	210.00	19140.00	962	641	2022-06-07 00:00:00
401	4490	161	1	16	89	210.00	29370.00	641	876	2021-04-18 00:00:00
402	4724	161	1	16	69	210.00	22770.00	876	167	2021-12-08 00:00:00
403	4521	161	1	16	31	210.00	10230.00	167	857	2021-05-19 00:00:00
404	4779	161	1	16	17	210.00	5610.00	857	879	2022-02-01 00:00:00
405	4636	161	1	16	22	210.00	7260.00	879	949	2021-09-11 00:00:00
406	4485	161	1	16	39	210.00	12870.00	949	161	2021-04-13 00:00:00
407	4535	161	1	16	88	210.00	29040.00	161	358	2021-06-02 00:00:00
408	4631	161	1	16	21	210.00	6930.00	358	210	2021-09-06 00:00:00
409	4479	161	1	16	8	210.00	2640.00	210	189	2021-04-07 00:00:00
410	4507	161	1	16	97	210.00	32010.00	189	760	2021-05-05 00:00:00
411	4873	161	1	16	14	210.00	4620.00	760	138	2022-05-06 00:00:00
412	4809	161	1	16	34	210.00	11220.00	138	934	2022-03-03 00:00:00
413	4750	161	1	16	26	210.00	8580.00	934	918	2022-01-03 00:00:00
414	4424	161	1	16	47	210.00	15510.00	918	390	2021-02-11 00:00:00
415	4550	161	1	16	47	210.00	15510.00	390	332	2021-06-17 00:00:00
416	4792	161	1	16	19	210.00	6270.00	332	451	2022-02-14 00:00:00
417	4547	161	1	16	61	210.00	20130.00	451	399	2021-06-14 00:00:00
418	4411	161	1	16	2	210.00	660.00	399	206	2021-01-29 00:00:00
419	4815	161	1	16	29	210.00	9570.00	206	90	2022-03-09 00:00:00
420	4816	161	1	16	19	210.00	6270.00	90	863	2022-03-10 00:00:00
421	4878	161	1	16	40	210.00	13200.00	863	763	2022-05-11 00:00:00
422	4411	161	1	16	31	210.00	10230.00	763	122	2021-01-29 00:00:00
423	4586	161	1	16	31	210.00	10230.00	122	439	2021-07-23 00:00:00
424	4828	161	1	16	62	210.00	20460.00	439	617	2022-03-22 00:00:00
425	4737	161	1	16	76	210.00	25080.00	617	631	2021-12-21 00:00:00
426	4856	161	1	16	74	210.00	24420.00	631	810	2022-04-19 00:00:00
427	4474	161	1	16	72	210.00	23760.00	810	469	2021-04-02 00:00:00
428	4515	161	1	16	77	210.00	25410.00	469	223	2021-05-13 00:00:00
429	4919	161	1	16	14	210.00	4620.00	223	136	2022-06-21 00:00:00
430	4612	161	1	16	61	210.00	20130.00	136	666	2021-08-18 00:00:00
431	4535	161	1	16	20	210.00	6600.00	666	796	2021-06-02 00:00:00
432	4845	161	1	16	50	210.00	16500.00	796	299	2022-04-08 00:00:00
433	4747	161	1	16	86	210.00	28380.00	299	292	2021-12-31 00:00:00
434	4679	161	1	16	78	210.00	25740.00	292	962	2021-10-24 00:00:00
435	4482	161	1	16	15	210.00	4950.00	962	233	2021-04-10 00:00:00
436	4884	161	1	16	43	210.00	14190.00	233	475	2022-05-17 00:00:00
437	4534	161	1	16	47	210.00	15510.00	475	505	2021-06-01 00:00:00
438	4716	161	1	16	90	210.00	29700.00	505	510	2021-11-30 00:00:00
439	4490	161	1	16	91	210.00	30030.00	510	958	2021-04-18 00:00:00
440	4618	161	1	16	14	210.00	4620.00	958	414	2021-08-24 00:00:00
441	4898	161	1	16	7	210.00	2310.00	414	882	2022-05-31 00:00:00
442	4561	161	1	16	4	210.00	1320.00	882	628	2021-06-28 00:00:00
443	4751	161	1	16	66	210.00	21780.00	628	868	2022-01-04 00:00:00
444	4612	161	1	16	14	210.00	4620.00	868	318	2021-08-18 00:00:00
445	4759	161	1	16	51	210.00	16830.00	318	549	2022-01-12 00:00:00
446	4676	161	1	16	88	210.00	29040.00	549	168	2021-10-21 00:00:00
447	4520	161	1	16	98	210.00	32340.00	168	733	2021-05-18 00:00:00
448	4495	161	1	16	36	210.00	11880.00	733	656	2021-04-23 00:00:00
449	4880	161	1	16	4	210.00	1320.00	656	127	2022-05-13 00:00:00
450	4511	161	1	16	2	210.00	660.00	127	731	2021-05-09 00:00:00
451	4631	161	1	16	73	210.00	24090.00	731	780	2021-09-06 00:00:00
452	4491	161	1	16	50	210.00	16500.00	780	876	2021-04-19 00:00:00
453	4713	161	1	16	9	210.00	2970.00	876	860	2021-11-27 00:00:00
454	4563	161	1	16	34	210.00	11220.00	860	683	2021-06-30 00:00:00
455	4589	161	1	16	32	210.00	10560.00	683	778	2021-07-26 00:00:00
456	4753	161	1	16	93	210.00	30690.00	778	859	2022-01-06 00:00:00
457	4854	161	1	16	12	210.00	3960.00	859	760	2022-04-17 00:00:00
458	4778	161	1	16	5	210.00	1650.00	760	587	2022-01-31 00:00:00
459	4761	161	1	16	15	210.00	4950.00	587	431	2022-01-14 00:00:00
460	4711	161	1	16	50	210.00	16500.00	431	767	2021-11-25 00:00:00
461	4459	161	1	16	59	210.00	19470.00	767	415	2021-03-18 00:00:00
462	4622	161	1	16	93	210.00	30690.00	415	841	2021-08-28 00:00:00
463	4862	161	1	16	87	210.00	28710.00	841	698	2022-04-25 00:00:00
464	4891	161	1	16	18	210.00	5940.00	698	694	2022-05-24 00:00:00
465	4852	161	1	16	9	210.00	2970.00	694	980	2022-04-15 00:00:00
466	4643	161	1	16	54	210.00	17820.00	980	743	2021-09-18 00:00:00
467	4524	161	1	16	49	210.00	16170.00	743	809	2021-05-22 00:00:00
468	4768	161	1	16	29	210.00	9570.00	809	189	2022-01-21 00:00:00
469	4750	161	1	16	99	210.00	32670.00	189	104	2022-01-03 00:00:00
470	4459	161	1	16	38	210.00	12540.00	104	255	2021-03-18 00:00:00
471	4432	161	1	16	60	210.00	19800.00	255	426	2021-02-19 00:00:00
472	4511	161	1	16	9	210.00	2970.00	426	243	2021-05-09 00:00:00
473	4678	161	1	16	85	210.00	28050.00	243	856	2021-10-23 00:00:00
474	4752	161	1	16	22	210.00	7260.00	856	385	2022-01-05 00:00:00
475	4684	161	1	16	40	210.00	13200.00	385	905	2021-10-29 00:00:00
476	4550	161	1	16	32	210.00	10560.00	905	768	2021-06-17 00:00:00
477	4564	161	1	16	81	210.00	26730.00	768	374	2021-07-01 00:00:00
478	4474	161	1	16	59	210.00	19470.00	374	877	2021-04-02 00:00:00
479	4448	161	1	16	18	210.00	5940.00	877	183	2021-03-07 00:00:00
480	4412	161	1	16	24	210.00	7920.00	183	367	2021-01-30 00:00:00
481	4811	161	1	16	4	210.00	1320.00	367	360	2022-03-05 00:00:00
482	4738	161	1	16	89	210.00	29370.00	360	446	2021-12-22 00:00:00
483	4824	161	1	16	98	210.00	32340.00	446	569	2022-03-18 00:00:00
484	4609	161	1	16	40	210.00	13200.00	569	490	2021-08-15 00:00:00
485	4555	161	1	16	82	210.00	27060.00	490	587	2021-06-22 00:00:00
486	4517	161	1	16	68	210.00	22440.00	587	53	2021-05-15 00:00:00
487	4552	161	1	16	72	210.00	23760.00	53	196	2021-06-19 00:00:00
488	4919	161	1	16	50	210.00	16500.00	196	235	2022-06-21 00:00:00
489	4672	161	1	16	62	210.00	20460.00	235	507	2021-10-17 00:00:00
490	4482	161	1	16	4	210.00	1320.00	507	268	2021-04-10 00:00:00
491	4863	161	1	16	39	210.00	12870.00	268	717	2022-04-26 00:00:00
492	4915	161	1	16	10	210.00	3300.00	717	910	2022-06-17 00:00:00
493	4665	161	1	16	89	210.00	29370.00	910	139	2021-10-10 00:00:00
494	4514	161	1	16	80	210.00	26400.00	139	568	2021-05-12 00:00:00
495	4437	161	1	16	97	210.00	32010.00	568	268	2021-02-24 00:00:00
496	4568	161	1	16	94	210.00	31020.00	268	982	2021-07-05 00:00:00
497	4779	161	1	16	70	210.00	23100.00	982	987	2022-02-01 00:00:00
498	4826	161	1	16	29	210.00	9570.00	987	153	2022-03-20 00:00:00
499	4562	161	1	16	24	210.00	7920.00	153	527	2021-06-29 00:00:00
500	4516	161	1	16	50	210.00	16500.00	527	192	2021-05-14 00:00:00
\.


--
-- Data for Name: fato_pedido_frete; Type: TABLE DATA; Schema: estoque; Owner: postgres
--

COPY estoque.fato_pedido_frete (id_frete, numero_pedido, fk_tempo_envio, fk_tempo_entrega, fk_transportadora, fk_localizacao_origem, fk_localizacao_destino, peso_total_kg, volume_total_m3, distancia_km, valor_frete, prazo_entrega_dias, data_hora_entrega, status_frete, dias_atraso, houve_avaria) FROM stdin;
\.


--
-- Data for Name: dim_forma_pagamento; Type: TABLE DATA; Schema: financeiro; Owner: postgres
--

COPY financeiro.dim_forma_pagamento (id_forma_pagamento, forma_pagamento) FROM stdin;
1	D├®bito
2	Cr├®dito
3	PIX
4	Boleto
5	Dinheiro
6	Transfer├¬ncia
\.


--
-- Data for Name: fato_pedido; Type: TABLE DATA; Schema: financeiro; Owner: postgres
--

COPY financeiro.fato_pedido (id_pedido, numero_pedido, fk_tempo, fk_cliente, fk_canal_venda, fk_forma_pagamento, qtd_itens, valor_total, valor_frete, status_pedido, data_hora_pedido) FROM stdin;
1	1798	4853	457	1	3	1	2815.73	22.23	Entregue	2022-04-16 00:00:00
2	1489	4503	457	1	3	1	309.10	26.82	Entregue	2021-05-01 00:00:00
3	1269	4677	457	1	3	1	0.01	53.98	Entregue	2021-10-22 00:00:00
4	652	4418	457	1	3	1	507.88	45.22	Entregue	2021-02-05 00:00:00
5	273	4440	457	1	3	1	4275.35	29.71	Entregue	2021-02-27 00:00:00
6	1560	4442	457	1	3	1	332.15	55.23	Entregue	2021-03-01 00:00:00
7	51	4741	457	1	3	1	1.68	68.18	Entregue	2021-12-25 00:00:00
8	951	4485	457	1	3	1	16.50	28.03	Entregue	2021-04-13 00:00:00
9	1898	4629	457	1	3	1	22161.35	31.81	Entregue	2021-09-04 00:00:00
10	70	4512	457	1	3	1	1609.40	59.71	Entregue	2021-05-10 00:00:00
11	350	4520	457	1	3	1	4133.28	32.25	Entregue	2021-05-18 00:00:00
12	758	4522	457	1	3	1	375.17	37.37	Entregue	2021-05-20 00:00:00
13	1750	4600	457	1	3	1	4525.28	28.96	Entregue	2021-08-06 00:00:00
14	1136	4654	457	1	3	1	138.69	49.99	Entregue	2021-09-29 00:00:00
15	176	4793	457	1	3	1	258.81	66.48	Entregue	2022-02-15 00:00:00
16	576	4577	457	1	3	1	1843.20	24.80	Entregue	2021-07-14 00:00:00
17	1831	4631	457	1	3	1	0.01	37.83	Entregue	2021-09-06 00:00:00
18	1003	4537	457	1	3	1	20.02	38.41	Entregue	2021-06-04 00:00:00
19	292	4687	457	1	3	1	2066.98	40.42	Entregue	2021-11-01 00:00:00
20	1331	4874	457	1	3	1	4941.16	35.24	Entregue	2022-05-07 00:00:00
21	929	4884	457	1	3	1	3249.64	58.96	Entregue	2022-05-17 00:00:00
22	663	4646	457	1	3	1	490.25	22.84	Entregue	2021-09-21 00:00:00
23	1552	4740	457	1	3	1	336.93	27.52	Entregue	2021-12-24 00:00:00
24	1589	4446	457	1	3	1	3867.36	32.97	Entregue	2021-03-05 00:00:00
25	1493	4626	457	1	3	1	16827.73	36.84	Entregue	2021-09-01 00:00:00
26	1811	4734	457	1	3	1	151.16	47.98	Entregue	2021-12-18 00:00:00
27	1373	4668	457	1	3	1	334.68	47.01	Entregue	2021-10-13 00:00:00
28	764	4514	457	1	3	1	47.00	64.04	Entregue	2021-05-12 00:00:00
29	556	4883	457	1	3	1	2268.28	36.50	Entregue	2022-05-16 00:00:00
30	1268	4854	457	1	3	1	0.01	40.70	Entregue	2022-04-17 00:00:00
31	638	4677	457	1	3	1	410.58	27.16	Entregue	2021-10-22 00:00:00
32	940	4491	457	1	3	1	19672.77	39.13	Entregue	2021-04-19 00:00:00
33	173	4534	457	1	3	1	216.01	52.61	Entregue	2021-06-01 00:00:00
34	1963	4697	457	1	3	1	5643.76	58.09	Entregue	2021-11-11 00:00:00
35	42	4706	457	1	3	1	2678.58	61.40	Entregue	2021-11-20 00:00:00
36	876	4870	457	1	3	1	0.01	37.95	Entregue	2022-05-03 00:00:00
37	161	4562	457	1	3	1	4251.28	53.15	Entregue	2021-06-29 00:00:00
38	113	4849	457	1	3	1	1555.83	59.82	Entregue	2022-04-12 00:00:00
39	1742	4420	457	1	3	1	2950.00	56.95	Entregue	2021-02-07 00:00:00
40	1595	4549	457	1	3	1	2983.47	38.12	Entregue	2021-06-16 00:00:00
41	1372	4898	457	1	3	1	24815.75	28.12	Entregue	2022-05-31 00:00:00
42	632	4450	457	1	3	1	8817.16	25.71	Entregue	2021-03-09 00:00:00
43	658	4873	457	1	3	1	13160.21	26.70	Entregue	2022-05-06 00:00:00
44	815	4459	457	1	3	1	7363.72	60.20	Entregue	2021-03-18 00:00:00
45	1422	4685	457	1	3	1	1725.35	20.18	Entregue	2021-10-30 00:00:00
46	440	4701	457	1	3	1	231.98	64.10	Entregue	2021-11-15 00:00:00
47	1004	4559	457	1	3	1	287.13	64.85	Entregue	2021-06-26 00:00:00
48	57	4725	457	1	3	1	2182.90	50.53	Entregue	2021-12-09 00:00:00
49	1313	4552	457	1	3	1	1591.83	51.28	Entregue	2021-06-19 00:00:00
50	19	4796	457	1	3	1	1497.08	32.51	Entregue	2022-02-18 00:00:00
51	160	4892	457	1	3	1	1296.24	54.59	Entregue	2022-05-25 00:00:00
52	644	4824	457	1	3	1	2312.85	34.32	Entregue	2022-03-18 00:00:00
53	824	4578	457	1	3	1	13321.12	52.38	Entregue	2021-07-15 00:00:00
54	1857	4416	457	1	3	1	140.11	23.02	Entregue	2021-02-03 00:00:00
55	1262	4850	457	1	3	1	8042.54	38.83	Entregue	2022-04-13 00:00:00
56	357	4622	457	1	3	1	0.01	34.16	Entregue	2021-08-28 00:00:00
57	1143	4483	457	1	3	1	1431.16	67.14	Entregue	2021-04-11 00:00:00
58	1782	4896	457	1	3	1	979.88	65.87	Entregue	2022-05-29 00:00:00
59	769	4812	457	1	3	1	562.15	49.36	Entregue	2022-03-06 00:00:00
60	266	4892	457	1	3	1	250.03	38.73	Entregue	2022-05-25 00:00:00
61	1550	4434	457	1	3	1	11844.71	26.70	Entregue	2021-02-21 00:00:00
62	1287	4861	457	1	3	1	612.83	58.49	Entregue	2022-04-24 00:00:00
63	366	4854	457	1	3	1	1856.95	44.02	Entregue	2022-04-17 00:00:00
64	307	4490	457	1	3	1	115.80	29.75	Entregue	2021-04-18 00:00:00
65	1644	4751	457	1	3	1	1046.85	22.62	Entregue	2022-01-04 00:00:00
66	91	4863	457	1	3	1	655.13	21.67	Entregue	2022-04-26 00:00:00
67	305	4478	457	1	3	1	6203.28	28.05	Entregue	2021-04-06 00:00:00
68	1606	4579	457	1	3	1	277.01	48.79	Entregue	2021-07-16 00:00:00
69	1312	4462	457	1	3	1	7407.86	40.38	Entregue	2021-03-21 00:00:00
70	743	4520	457	1	3	1	0.01	49.54	Entregue	2021-05-18 00:00:00
71	1484	4748	457	1	3	1	8712.20	45.14	Entregue	2022-01-01 00:00:00
72	10	4741	457	1	3	1	3244.78	38.63	Entregue	2021-12-25 00:00:00
73	1940	4845	457	1	3	1	0.01	60.68	Entregue	2022-04-08 00:00:00
74	1984	4568	457	1	3	1	778.38	59.84	Entregue	2021-07-05 00:00:00
75	1602	4802	457	1	3	1	2412.40	59.75	Entregue	2022-02-24 00:00:00
76	1662	4386	457	1	3	1	3.80	33.69	Entregue	2021-01-04 00:00:00
77	823	4743	457	1	3	1	132.40	60.85	Entregue	2021-12-27 00:00:00
78	822	4616	457	1	3	1	1406.59	31.07	Entregue	2021-08-22 00:00:00
79	1118	4662	457	1	3	1	2265.16	64.99	Entregue	2021-10-07 00:00:00
80	1990	4568	457	1	3	1	0.01	36.03	Entregue	2021-07-05 00:00:00
81	1025	4513	457	1	3	1	5.85	61.11	Entregue	2021-05-11 00:00:00
82	241	4384	457	1	3	1	0.01	50.08	Entregue	2021-01-02 00:00:00
83	175	4730	457	1	3	1	0.01	35.18	Entregue	2021-12-14 00:00:00
84	596	4488	457	1	3	1	11826.00	68.60	Entregue	2021-04-16 00:00:00
85	50	4773	457	1	3	1	540.27	60.12	Entregue	2022-01-26 00:00:00
86	13	4654	457	1	3	1	112.37	53.83	Entregue	2021-09-29 00:00:00
87	1319	4448	457	1	3	1	228.19	66.92	Entregue	2021-03-07 00:00:00
88	1776	4823	457	1	3	1	318.32	45.34	Entregue	2022-03-17 00:00:00
89	1104	4392	457	1	3	1	1237.74	66.89	Entregue	2021-01-10 00:00:00
90	2	4620	457	1	3	1	0.01	55.51	Entregue	2021-08-26 00:00:00
91	699	4606	457	1	3	1	164.26	62.05	Entregue	2021-08-12 00:00:00
92	1975	4504	457	1	3	1	2436.96	47.79	Entregue	2021-05-02 00:00:00
93	1936	4911	457	1	3	1	4567.18	62.18	Entregue	2022-06-13 00:00:00
94	1603	4774	457	1	3	1	0.01	67.43	Entregue	2022-01-27 00:00:00
95	246	4798	457	1	3	1	247.03	38.13	Entregue	2022-02-20 00:00:00
96	75	4389	457	1	3	1	708.87	57.20	Entregue	2021-01-07 00:00:00
97	128	4636	457	1	3	1	1254.26	52.82	Entregue	2021-09-11 00:00:00
98	1942	4645	457	1	3	1	267.96	65.40	Entregue	2021-09-20 00:00:00
99	1992	4411	457	1	3	1	17.57	49.54	Entregue	2021-01-29 00:00:00
100	344	4482	457	1	3	1	115.96	27.96	Entregue	2021-04-10 00:00:00
101	1078	4524	457	1	3	1	145.27	21.83	Entregue	2021-05-22 00:00:00
102	534	4688	457	1	3	1	6670.91	23.15	Entregue	2021-11-02 00:00:00
103	1522	4416	457	1	3	1	2509.64	33.22	Entregue	2021-02-03 00:00:00
104	1967	4797	457	1	3	1	6891.08	62.74	Entregue	2022-02-19 00:00:00
105	637	4668	457	1	3	1	61.94	62.76	Entregue	2021-10-13 00:00:00
106	355	4517	457	1	3	1	22321.10	28.82	Entregue	2021-05-15 00:00:00
107	1279	4424	457	1	3	1	3239.98	57.97	Entregue	2021-02-11 00:00:00
108	1403	4503	457	1	3	1	148.87	39.57	Entregue	2021-05-01 00:00:00
109	222	4568	457	1	3	1	423.40	38.42	Entregue	2021-07-05 00:00:00
110	1006	4884	457	1	3	1	0.01	61.78	Entregue	2022-05-17 00:00:00
111	922	4497	457	1	3	1	0.01	59.17	Entregue	2021-04-25 00:00:00
112	453	4775	457	1	3	1	403.25	36.17	Entregue	2022-01-28 00:00:00
113	787	4595	457	1	3	1	20.78	45.40	Entregue	2021-08-01 00:00:00
114	182	4532	457	1	3	1	2285.39	57.49	Entregue	2021-05-30 00:00:00
115	1950	4688	457	1	3	1	19742.06	50.20	Entregue	2021-11-02 00:00:00
116	528	4633	457	1	3	1	351.43	64.81	Entregue	2021-09-08 00:00:00
117	1549	4839	457	1	3	1	2935.98	49.26	Entregue	2022-04-02 00:00:00
118	811	4697	457	1	3	1	667.89	51.56	Entregue	2021-11-11 00:00:00
119	563	4784	457	1	3	1	111.86	69.70	Entregue	2022-02-06 00:00:00
120	1474	4706	457	1	3	1	711.44	53.48	Entregue	2021-11-20 00:00:00
121	1616	4725	457	1	3	1	90.60	37.14	Entregue	2021-12-09 00:00:00
122	1613	4713	457	1	3	1	138.80	62.06	Entregue	2021-11-27 00:00:00
123	667	4408	457	1	3	1	2112.23	55.97	Entregue	2021-01-26 00:00:00
124	481	4738	457	1	3	1	3953.67	57.43	Entregue	2021-12-22 00:00:00
125	1828	4665	457	1	3	1	2435.95	42.57	Entregue	2021-10-10 00:00:00
126	1779	4478	457	1	3	1	99.78	42.81	Entregue	2021-04-06 00:00:00
127	1804	4818	457	1	3	1	5389.32	49.05	Entregue	2022-03-12 00:00:00
128	438	4534	457	1	3	1	140.98	34.36	Entregue	2021-06-01 00:00:00
129	382	4612	457	1	3	1	2371.94	21.10	Entregue	2021-08-18 00:00:00
130	853	4478	457	1	3	1	3895.20	53.79	Entregue	2021-04-06 00:00:00
131	378	4415	457	1	3	1	1147.50	29.71	Entregue	2021-02-02 00:00:00
132	1349	4824	457	1	3	1	0.01	64.82	Entregue	2022-03-18 00:00:00
133	1050	4851	457	1	3	1	89.83	45.67	Entregue	2022-04-14 00:00:00
134	1788	4644	457	1	3	1	2279.63	40.97	Entregue	2021-09-19 00:00:00
135	799	4644	457	1	3	1	468.67	59.17	Entregue	2021-09-19 00:00:00
136	276	4695	457	1	3	1	3015.45	65.48	Entregue	2021-11-09 00:00:00
137	1523	4530	457	1	3	1	3328.25	44.22	Entregue	2021-05-28 00:00:00
138	1044	4510	457	1	3	1	7860.01	65.33	Entregue	2021-05-08 00:00:00
139	97	4711	457	1	3	1	907.17	27.53	Entregue	2021-11-25 00:00:00
140	1823	4550	457	1	3	1	2284.22	45.41	Entregue	2021-06-17 00:00:00
141	1848	4752	457	1	3	1	2304.83	61.98	Entregue	2022-01-05 00:00:00
142	589	4460	457	1	3	1	2059.68	68.62	Entregue	2021-03-19 00:00:00
143	1167	4524	457	1	3	1	3744.06	60.90	Entregue	2021-05-22 00:00:00
144	555	4886	457	1	3	1	599.26	69.26	Entregue	2022-05-19 00:00:00
145	1583	4825	457	1	3	1	0.01	27.17	Entregue	2022-03-19 00:00:00
146	682	4405	457	1	3	1	1832.60	27.78	Entregue	2021-01-23 00:00:00
147	567	4584	457	1	3	1	212.66	24.58	Entregue	2021-07-21 00:00:00
148	329	4854	457	1	3	1	221.11	65.95	Entregue	2022-04-17 00:00:00
149	44	4810	457	1	3	1	63.49	53.10	Entregue	2022-03-04 00:00:00
150	1144	4446	457	1	3	1	274.40	54.61	Entregue	2021-03-05 00:00:00
151	816	4555	457	1	3	1	4466.62	39.77	Entregue	2021-06-22 00:00:00
152	1585	4852	457	1	3	1	0.01	59.82	Entregue	2022-04-15 00:00:00
153	1646	4464	457	1	3	1	3692.72	28.74	Entregue	2021-03-23 00:00:00
154	1398	4865	457	1	3	1	1721.64	30.91	Entregue	2022-04-28 00:00:00
155	1987	4564	457	1	3	1	1500.70	38.93	Entregue	2021-07-01 00:00:00
156	1022	4478	457	1	3	1	4687.80	51.98	Entregue	2021-04-06 00:00:00
157	507	4450	457	1	3	1	0.01	29.93	Entregue	2021-03-09 00:00:00
158	944	4515	457	1	3	1	1399.07	24.39	Entregue	2021-05-13 00:00:00
159	847	4627	457	1	3	1	1017.42	53.35	Entregue	2021-09-02 00:00:00
160	419	4741	457	1	3	1	13438.60	30.38	Entregue	2021-12-25 00:00:00
161	1336	4883	457	1	3	1	13114.77	31.91	Entregue	2022-05-16 00:00:00
162	664	4843	457	1	3	1	84.73	36.26	Entregue	2022-04-06 00:00:00
163	551	4686	457	1	3	1	93.62	61.95	Entregue	2021-10-31 00:00:00
164	948	4504	457	1	3	1	2178.23	48.97	Entregue	2021-05-02 00:00:00
165	95	4792	457	1	3	1	8626.64	38.01	Entregue	2022-02-14 00:00:00
166	1540	4830	457	1	3	1	7148.72	48.77	Entregue	2022-03-24 00:00:00
167	1434	4631	457	1	3	1	228.51	46.17	Entregue	2021-09-06 00:00:00
168	519	4709	457	1	3	1	1135.65	51.35	Entregue	2021-11-23 00:00:00
169	1250	4410	457	1	3	1	1092.64	22.50	Entregue	2021-01-28 00:00:00
170	965	4660	457	1	3	1	152.72	33.73	Entregue	2021-10-05 00:00:00
171	172	4420	457	1	3	1	345.75	43.76	Entregue	2021-02-07 00:00:00
172	1966	4654	457	1	3	1	574.45	21.78	Entregue	2021-09-29 00:00:00
173	409	4658	457	1	3	1	2902.78	41.57	Entregue	2021-10-03 00:00:00
174	30	4776	457	1	3	1	11256.93	39.89	Entregue	2022-01-29 00:00:00
175	521	4466	457	1	3	1	0.01	68.87	Entregue	2021-03-25 00:00:00
176	936	4748	457	1	3	1	11620.33	28.95	Entregue	2022-01-01 00:00:00
177	1561	4480	457	1	3	1	14844.82	30.41	Entregue	2021-04-08 00:00:00
178	981	4421	457	1	3	1	3580.78	43.52	Entregue	2021-02-08 00:00:00
179	1334	4912	457	1	3	1	4747.14	55.21	Entregue	2022-06-14 00:00:00
180	1221	4855	457	1	3	1	0.01	31.46	Entregue	2022-04-18 00:00:00
181	249	4425	457	1	3	1	0.01	44.28	Entregue	2021-02-12 00:00:00
182	255	4576	457	1	3	1	2729.79	42.84	Entregue	2021-07-13 00:00:00
183	1678	4613	457	1	3	1	5069.58	23.22	Entregue	2021-08-19 00:00:00
184	639	4537	457	1	3	1	2554.42	25.84	Entregue	2021-06-04 00:00:00
185	296	4658	457	1	3	1	3829.01	27.68	Entregue	2021-10-03 00:00:00
186	209	4615	457	1	3	1	1794.41	34.72	Entregue	2021-08-21 00:00:00
187	74	4422	457	1	3	1	2248.12	26.06	Entregue	2021-02-09 00:00:00
188	937	4450	457	1	3	1	2.07	45.99	Entregue	2021-03-09 00:00:00
189	138	4753	457	1	3	1	287.81	52.05	Entregue	2022-01-06 00:00:00
190	34	4697	457	1	3	1	1663.69	57.27	Entregue	2021-11-11 00:00:00
191	1774	4434	457	1	3	1	0.01	37.60	Entregue	2021-02-21 00:00:00
192	1747	4775	457	1	3	1	0.01	53.52	Entregue	2022-01-28 00:00:00
193	1748	4510	457	1	3	1	0.01	21.84	Entregue	2021-05-08 00:00:00
194	947	4531	457	1	3	1	81.45	54.44	Entregue	2021-05-29 00:00:00
195	1411	4397	457	1	3	1	89.16	23.38	Entregue	2021-01-15 00:00:00
196	972	4873	457	1	3	1	0.01	24.71	Entregue	2022-05-06 00:00:00
197	761	4584	457	1	3	1	21.09	61.05	Entregue	2021-07-21 00:00:00
198	1084	4855	457	1	3	1	661.29	64.73	Entregue	2022-04-18 00:00:00
199	90	4640	457	1	3	1	0.01	60.54	Entregue	2021-09-15 00:00:00
200	1681	4890	457	1	3	1	2048.25	58.44	Entregue	2022-05-23 00:00:00
201	1956	4416	457	1	3	1	0.01	21.13	Entregue	2021-02-03 00:00:00
202	904	4903	457	1	3	1	15.71	42.19	Entregue	2022-06-05 00:00:00
203	443	4816	457	1	3	1	825.76	40.96	Entregue	2022-03-10 00:00:00
204	526	4843	457	1	3	1	3326.50	47.33	Entregue	2022-04-06 00:00:00
205	1428	4810	457	1	3	1	11808.94	55.12	Entregue	2022-03-04 00:00:00
206	393	4495	457	1	3	1	142.81	38.03	Entregue	2021-04-23 00:00:00
207	524	4562	457	1	3	1	0.01	23.76	Entregue	2021-06-29 00:00:00
208	312	4511	457	1	3	1	528.29	27.06	Entregue	2021-05-09 00:00:00
209	1151	4647	457	1	3	1	504.44	57.83	Entregue	2021-09-22 00:00:00
210	498	4640	457	1	3	1	66.85	46.95	Entregue	2021-09-15 00:00:00
211	862	4398	457	1	3	1	768.94	38.97	Entregue	2021-01-16 00:00:00
212	1185	4607	457	1	3	1	167.04	40.94	Entregue	2021-08-13 00:00:00
213	494	4638	457	1	3	1	1796.65	66.41	Entregue	2021-09-13 00:00:00
214	469	4760	457	1	3	1	2387.85	61.73	Entregue	2022-01-13 00:00:00
215	118	4898	457	1	3	1	450.61	32.49	Entregue	2022-05-31 00:00:00
216	1265	4867	457	1	3	1	2383.43	62.57	Entregue	2022-04-30 00:00:00
217	1793	4626	457	1	3	1	492.47	25.60	Entregue	2021-09-01 00:00:00
218	1986	4832	457	1	3	1	6875.66	47.50	Entregue	2022-03-26 00:00:00
219	488	4705	457	1	3	1	629.59	61.45	Entregue	2021-11-19 00:00:00
220	1101	4438	457	1	3	1	0.01	37.77	Entregue	2021-02-25 00:00:00
221	1048	4510	457	1	3	1	6700.17	60.46	Entregue	2021-05-08 00:00:00
222	1995	4590	457	1	3	1	782.21	69.20	Entregue	2021-07-27 00:00:00
223	360	4621	457	1	3	1	916.51	45.21	Entregue	2021-08-27 00:00:00
224	1770	4880	457	1	3	1	5322.20	58.74	Entregue	2022-05-13 00:00:00
225	99	4916	457	1	3	1	167.42	35.90	Entregue	2022-06-18 00:00:00
226	629	4553	457	1	3	1	0.01	27.97	Entregue	2021-06-20 00:00:00
227	726	4809	457	1	3	1	246.74	69.46	Entregue	2022-03-03 00:00:00
228	1215	4722	457	1	3	1	1390.71	51.34	Entregue	2021-12-06 00:00:00
229	1476	4580	457	1	3	1	3199.81	25.73	Entregue	2021-07-17 00:00:00
230	1727	4622	457	1	3	1	2824.87	64.59	Entregue	2021-08-28 00:00:00
231	442	4585	457	1	3	1	986.01	28.37	Entregue	2021-07-22 00:00:00
232	354	4613	457	1	3	1	2877.05	51.69	Entregue	2021-08-19 00:00:00
233	1238	4682	457	1	3	1	2563.71	27.53	Entregue	2021-10-27 00:00:00
234	12	4796	457	1	3	1	118.05	31.69	Entregue	2022-02-18 00:00:00
235	1792	4682	457	1	3	1	0.01	52.95	Entregue	2021-10-27 00:00:00
236	479	4389	457	1	3	1	0.01	35.42	Entregue	2021-01-07 00:00:00
237	1354	4697	457	1	3	1	161.56	41.01	Entregue	2021-11-11 00:00:00
238	1976	4751	457	1	3	1	375.36	68.64	Entregue	2022-01-04 00:00:00
239	1574	4497	457	1	3	1	1973.81	25.98	Entregue	2021-04-25 00:00:00
240	1283	4485	457	1	3	1	226.82	43.92	Entregue	2021-04-13 00:00:00
241	1503	4778	457	1	3	1	5782.10	26.13	Entregue	2022-01-31 00:00:00
242	899	4829	457	1	3	1	554.20	46.28	Entregue	2022-03-23 00:00:00
243	935	4744	457	1	3	1	1278.55	62.66	Entregue	2021-12-28 00:00:00
244	675	4530	457	1	3	1	233.97	32.97	Entregue	2021-05-28 00:00:00
245	696	4826	457	1	3	1	61.68	41.80	Entregue	2022-03-20 00:00:00
246	969	4649	457	1	3	1	1784.73	43.66	Entregue	2021-09-24 00:00:00
247	264	4646	457	1	3	1	2660.91	41.00	Entregue	2021-09-21 00:00:00
248	1253	4856	457	1	3	1	168.00	58.72	Entregue	2022-04-19 00:00:00
249	270	4888	457	1	3	1	5382.75	46.78	Entregue	2022-05-21 00:00:00
250	898	4507	457	1	3	1	1434.62	57.30	Entregue	2021-05-05 00:00:00
251	435	4797	457	1	3	1	420.54	65.38	Entregue	2022-02-19 00:00:00
252	384	4548	457	1	3	1	98.99	38.05	Entregue	2021-06-15 00:00:00
253	1713	4684	457	1	3	1	1827.10	25.98	Entregue	2021-10-29 00:00:00
254	1145	4568	457	1	3	1	2497.86	37.15	Entregue	2021-07-05 00:00:00
255	837	4830	457	1	3	1	2976.04	26.13	Entregue	2022-03-24 00:00:00
256	826	4665	457	1	3	1	7569.69	41.98	Entregue	2021-10-10 00:00:00
257	431	4697	457	1	3	1	58.21	38.66	Entregue	2021-11-11 00:00:00
258	1226	4559	457	1	3	1	6615.28	32.12	Entregue	2021-06-26 00:00:00
259	911	4752	457	1	3	1	7807.99	34.30	Entregue	2022-01-05 00:00:00
260	491	4859	457	1	3	1	997.60	61.07	Entregue	2022-04-22 00:00:00
261	462	4827	457	1	3	1	0.01	23.43	Entregue	2022-03-21 00:00:00
262	855	4440	457	1	3	1	0.01	30.17	Entregue	2021-02-27 00:00:00
263	1615	4706	457	1	3	1	5000.55	52.67	Entregue	2021-11-20 00:00:00
264	1248	4621	457	1	3	1	6802.99	25.41	Entregue	2021-08-27 00:00:00
265	436	4883	457	1	3	1	147.89	67.37	Entregue	2022-05-16 00:00:00
266	870	4562	457	1	3	1	225.59	36.00	Entregue	2021-06-29 00:00:00
267	1564	4537	457	1	3	1	374.17	29.95	Entregue	2021-06-04 00:00:00
268	1397	4689	457	1	3	1	305.17	34.37	Entregue	2021-11-03 00:00:00
269	1844	4720	457	1	3	1	0.01	68.69	Entregue	2021-12-04 00:00:00
270	1579	4504	457	1	3	1	0.01	47.66	Entregue	2021-05-02 00:00:00
271	711	4437	457	1	3	1	3910.37	35.59	Entregue	2021-02-24 00:00:00
272	768	4757	457	1	3	1	1578.30	45.30	Entregue	2022-01-10 00:00:00
273	1036	4820	457	1	3	1	56.56	55.59	Entregue	2022-03-14 00:00:00
274	838	4692	457	1	3	1	0.01	61.74	Entregue	2021-11-06 00:00:00
275	149	4795	457	1	3	1	3501.96	28.36	Entregue	2022-02-17 00:00:00
276	280	4586	457	1	3	1	8680.43	21.33	Entregue	2021-07-23 00:00:00
277	1928	4659	457	1	3	1	624.98	25.00	Entregue	2021-10-04 00:00:00
278	88	4495	457	1	3	1	0.01	34.67	Entregue	2021-04-23 00:00:00
279	188	4900	457	1	3	1	523.77	47.74	Entregue	2022-06-02 00:00:00
280	461	4761	457	1	3	1	1689.26	39.42	Entregue	2022-01-14 00:00:00
281	240	4564	457	1	3	1	3968.06	69.56	Entregue	2021-07-01 00:00:00
282	1878	4779	457	1	3	1	862.14	42.62	Entregue	2022-02-01 00:00:00
283	1467	4478	457	1	3	1	1903.63	36.31	Entregue	2021-04-06 00:00:00
284	1046	4618	457	1	3	1	7883.27	24.12	Entregue	2021-08-24 00:00:00
285	1328	4610	457	1	3	1	2664.23	55.57	Entregue	2021-08-16 00:00:00
286	1932	4823	457	1	3	1	3768.41	58.70	Entregue	2022-03-17 00:00:00
287	650	4524	457	1	3	1	2272.60	35.56	Entregue	2021-05-22 00:00:00
288	703	4397	457	1	3	1	36.81	44.43	Entregue	2021-01-15 00:00:00
289	226	4762	457	1	3	1	1720.09	25.69	Entregue	2022-01-15 00:00:00
290	1161	4791	457	1	3	1	939.67	64.73	Entregue	2022-02-13 00:00:00
291	843	4421	457	1	3	1	3931.11	34.89	Entregue	2021-02-08 00:00:00
292	447	4437	457	1	3	1	2230.99	66.73	Entregue	2021-02-24 00:00:00
293	1911	4523	457	1	3	1	4997.02	65.75	Entregue	2021-05-21 00:00:00
294	298	4510	457	1	3	1	0.01	29.69	Entregue	2021-05-08 00:00:00
295	1647	4820	457	1	3	1	855.35	69.21	Entregue	2022-03-14 00:00:00
296	81	4560	457	1	3	1	1402.59	23.83	Entregue	2021-06-27 00:00:00
297	1684	4412	457	1	3	1	0.01	27.67	Entregue	2021-01-30 00:00:00
298	1944	4609	457	1	3	1	9998.87	31.89	Entregue	2021-08-15 00:00:00
299	1639	4560	457	1	3	1	477.49	37.84	Entregue	2021-06-27 00:00:00
300	800	4648	457	1	3	1	12249.65	45.48	Entregue	2021-09-23 00:00:00
301	1495	4832	457	1	3	1	5281.75	59.39	Entregue	2022-03-26 00:00:00
302	204	4708	457	1	3	1	2078.45	67.30	Entregue	2021-11-22 00:00:00
303	1021	4875	457	1	3	1	2786.48	62.22	Entregue	2022-05-08 00:00:00
304	5	4649	457	1	3	1	414.77	56.83	Entregue	2021-09-24 00:00:00
305	1165	4713	457	1	3	1	482.50	46.63	Entregue	2021-11-27 00:00:00
306	1608	4734	457	1	3	1	0.01	62.55	Entregue	2021-12-18 00:00:00
307	1429	4708	457	1	3	1	98.98	44.66	Entregue	2021-11-22 00:00:00
308	283	4436	457	1	3	1	0.01	32.20	Entregue	2021-02-23 00:00:00
309	807	4662	457	1	3	1	171.66	31.41	Entregue	2021-10-07 00:00:00
310	624	4687	457	1	3	1	0.01	22.75	Entregue	2021-11-01 00:00:00
311	681	4521	457	1	3	1	323.37	53.96	Entregue	2021-05-19 00:00:00
312	361	4546	457	1	3	1	109.24	64.86	Entregue	2021-06-13 00:00:00
313	1173	4466	457	1	3	1	3329.50	67.02	Entregue	2021-03-25 00:00:00
314	1508	4735	457	1	3	1	2296.96	31.85	Entregue	2021-12-19 00:00:00
315	829	4413	457	1	3	1	3871.69	57.50	Entregue	2021-01-31 00:00:00
316	1557	4837	457	1	3	1	344.17	56.18	Entregue	2022-03-31 00:00:00
317	785	4544	457	1	3	1	402.69	33.41	Entregue	2021-06-11 00:00:00
318	643	4701	457	1	3	1	0.01	22.74	Entregue	2021-11-15 00:00:00
319	472	4888	457	1	3	1	0.01	51.17	Entregue	2022-05-21 00:00:00
320	444	4682	457	1	3	1	18865.74	46.95	Entregue	2021-10-27 00:00:00
321	537	4863	457	1	3	1	5164.57	24.90	Entregue	2022-04-26 00:00:00
322	1914	4633	457	1	3	1	599.50	64.18	Entregue	2021-09-08 00:00:00
323	1401	4850	457	1	3	1	463.94	24.15	Entregue	2022-04-13 00:00:00
324	373	4679	457	1	3	1	126.15	43.27	Entregue	2021-10-24 00:00:00
325	252	4912	457	1	3	1	351.80	63.33	Entregue	2022-06-14 00:00:00
326	343	4737	457	1	3	1	2158.65	61.54	Entregue	2021-12-21 00:00:00
327	31	4592	457	1	3	1	2177.37	66.17	Entregue	2021-07-29 00:00:00
328	1199	4561	457	1	3	1	905.06	25.30	Entregue	2021-06-28 00:00:00
329	1316	4483	457	1	3	1	2556.25	63.98	Entregue	2021-04-11 00:00:00
330	1086	4642	457	1	3	1	22327.43	40.11	Entregue	2021-09-17 00:00:00
331	722	4384	457	1	3	1	1056.36	55.14	Entregue	2021-01-02 00:00:00
332	1757	4633	457	1	3	1	11253.13	59.74	Entregue	2021-09-08 00:00:00
333	1097	4649	457	1	3	1	1436.60	35.55	Entregue	2021-09-24 00:00:00
334	199	4747	457	1	3	1	3519.68	29.53	Entregue	2021-12-31 00:00:00
335	1374	4877	457	1	3	1	13220.26	69.30	Entregue	2022-05-10 00:00:00
336	369	4537	457	1	3	1	1228.31	30.33	Entregue	2021-06-04 00:00:00
337	243	4792	457	1	3	1	1451.30	33.55	Entregue	2022-02-14 00:00:00
338	1264	4857	457	1	3	1	0.01	23.48	Entregue	2022-04-20 00:00:00
339	902	4647	457	1	3	1	54.58	35.50	Entregue	2021-09-22 00:00:00
340	1309	4515	457	1	3	1	1692.00	28.80	Entregue	2021-05-13 00:00:00
341	1142	4736	457	1	3	1	0.01	31.84	Entregue	2021-12-20 00:00:00
342	740	4478	457	1	3	1	136.55	56.68	Entregue	2021-04-06 00:00:00
343	1178	4398	457	1	3	1	8702.17	25.02	Entregue	2021-01-16 00:00:00
344	856	4678	457	1	3	1	527.50	22.21	Entregue	2021-10-23 00:00:00
345	230	4645	457	1	3	1	74.47	62.03	Entregue	2021-09-20 00:00:00
346	1864	4831	457	1	3	1	3151.91	65.70	Entregue	2022-03-25 00:00:00
347	1917	4897	457	1	3	1	3403.98	54.79	Entregue	2022-05-30 00:00:00
348	1663	4760	457	1	3	1	519.48	69.68	Entregue	2022-01-13 00:00:00
349	78	4802	457	1	3	1	2166.15	49.88	Entregue	2022-02-24 00:00:00
350	573	4720	457	1	3	1	11271.05	54.51	Entregue	2021-12-04 00:00:00
351	1998	4698	457	1	3	1	14877.02	66.46	Entregue	2021-11-12 00:00:00
352	1451	4747	457	1	3	1	2863.50	46.76	Entregue	2021-12-31 00:00:00
353	987	4665	457	1	3	1	528.76	36.12	Entregue	2021-10-10 00:00:00
354	852	4398	457	1	3	1	3765.06	49.51	Entregue	2021-01-16 00:00:00
355	250	4796	457	1	3	1	1925.50	33.03	Entregue	2022-02-18 00:00:00
356	1927	4772	457	1	3	1	7709.60	36.27	Entregue	2022-01-25 00:00:00
357	611	4730	457	1	3	1	0.01	38.80	Entregue	2021-12-14 00:00:00
358	621	4482	457	1	3	1	157.21	35.79	Entregue	2021-04-10 00:00:00
359	1246	4412	457	1	3	1	604.81	69.69	Entregue	2021-01-30 00:00:00
360	1382	4446	457	1	3	1	4151.07	33.43	Entregue	2021-03-05 00:00:00
361	1206	4854	457	1	3	1	815.96	30.98	Entregue	2022-04-17 00:00:00
362	1852	4507	457	1	3	1	5244.16	67.88	Entregue	2021-05-05 00:00:00
363	1937	4897	457	1	3	1	1332.86	51.48	Entregue	2022-05-30 00:00:00
364	585	4450	457	1	3	1	0.01	60.28	Entregue	2021-03-09 00:00:00
365	1775	4858	457	1	3	1	248.00	39.95	Entregue	2022-04-21 00:00:00
366	1310	4587	457	1	3	1	3340.91	60.40	Entregue	2021-07-24 00:00:00
367	708	4748	457	1	3	1	6693.85	59.72	Entregue	2022-01-01 00:00:00
368	455	4724	457	1	3	1	2763.29	31.27	Entregue	2021-12-08 00:00:00
369	1630	4576	457	1	3	1	757.40	60.77	Entregue	2021-07-13 00:00:00
370	1693	4862	457	1	3	1	196.07	60.74	Entregue	2022-04-25 00:00:00
371	1592	4811	457	1	3	1	0.01	42.43	Entregue	2022-03-05 00:00:00
372	713	4534	457	1	3	1	0.01	26.45	Entregue	2021-06-01 00:00:00
373	1205	4547	457	1	3	1	2019.57	36.62	Entregue	2021-06-14 00:00:00
374	448	4448	457	1	3	1	2749.28	55.33	Entregue	2021-03-07 00:00:00
375	930	4691	457	1	3	1	4183.46	56.20	Entregue	2021-11-05 00:00:00
376	701	4737	457	1	3	1	4902.26	27.43	Entregue	2021-12-21 00:00:00
377	1861	4759	457	1	3	1	578.33	33.93	Entregue	2022-01-12 00:00:00
378	1092	4762	457	1	3	1	0.01	66.28	Entregue	2022-01-15 00:00:00
379	132	4466	457	1	3	1	13652.86	37.66	Entregue	2021-03-25 00:00:00
380	322	4541	457	1	3	1	2588.13	35.75	Entregue	2021-06-08 00:00:00
381	1414	4590	457	1	3	1	2607.48	39.48	Entregue	2021-07-27 00:00:00
382	1953	4626	457	1	3	1	1147.15	50.35	Entregue	2021-09-01 00:00:00
383	863	4678	457	1	3	1	1003.59	43.36	Entregue	2021-10-23 00:00:00
384	1106	4748	457	1	3	1	0.01	65.65	Entregue	2022-01-01 00:00:00
385	1886	4815	457	1	3	1	841.98	65.75	Entregue	2022-03-09 00:00:00
386	1052	4652	457	1	3	1	183.95	59.34	Entregue	2021-09-27 00:00:00
387	1413	4441	457	1	3	1	1978.27	41.68	Entregue	2021-02-28 00:00:00
388	289	4547	457	1	3	1	1538.12	58.64	Entregue	2021-06-14 00:00:00
389	583	4384	457	1	3	1	984.62	51.07	Entregue	2021-01-02 00:00:00
390	65	4405	457	1	3	1	465.75	38.25	Entregue	2021-01-23 00:00:00
391	1202	4464	457	1	3	1	4680.90	52.87	Entregue	2021-03-23 00:00:00
392	693	4709	457	1	3	1	645.11	40.98	Entregue	2021-11-23 00:00:00
393	1400	4455	457	1	3	1	670.73	44.11	Entregue	2021-03-14 00:00:00
394	744	4587	457	1	3	1	1392.57	50.74	Entregue	2021-07-24 00:00:00
395	1462	4586	457	1	3	1	11.66	20.87	Entregue	2021-07-23 00:00:00
396	527	4387	457	1	3	1	6453.15	44.75	Entregue	2021-01-05 00:00:00
397	490	4740	457	1	3	1	2781.94	21.70	Entregue	2021-12-24 00:00:00
398	627	4413	457	1	3	1	0.01	63.60	Entregue	2021-01-31 00:00:00
399	119	4721	457	1	3	1	747.12	50.45	Entregue	2021-12-05 00:00:00
400	286	4589	457	1	3	1	582.54	24.42	Entregue	2021-07-26 00:00:00
401	376	4398	457	1	3	1	118.57	47.38	Entregue	2021-01-16 00:00:00
402	147	4897	457	1	3	1	4849.68	64.56	Entregue	2022-05-30 00:00:00
403	860	4877	457	1	3	1	763.29	61.22	Entregue	2022-05-10 00:00:00
404	480	4408	457	1	3	1	3947.21	47.33	Entregue	2021-01-26 00:00:00
405	1834	4916	457	1	3	1	3852.62	44.87	Entregue	2022-06-18 00:00:00
406	1941	4413	457	1	3	1	159.91	62.61	Entregue	2021-01-31 00:00:00
407	1470	4568	457	1	3	1	296.79	57.61	Entregue	2021-07-05 00:00:00
408	989	4533	457	1	3	1	4420.81	52.52	Entregue	2021-05-31 00:00:00
409	535	4386	457	1	3	1	990.87	21.75	Entregue	2021-01-04 00:00:00
410	1159	4611	457	1	3	1	3343.69	57.48	Entregue	2021-08-17 00:00:00
411	642	4464	457	1	3	1	0.01	48.81	Entregue	2021-03-23 00:00:00
412	725	4861	457	1	3	1	927.56	65.84	Entregue	2022-04-24 00:00:00
413	832	4665	457	1	3	1	4875.94	39.90	Entregue	2021-10-10 00:00:00
414	907	4912	457	1	3	1	9829.57	53.24	Entregue	2022-06-14 00:00:00
415	1784	4680	457	1	3	1	1902.54	54.22	Entregue	2021-10-25 00:00:00
416	1766	4831	457	1	3	1	1648.88	34.97	Entregue	2022-03-25 00:00:00
417	1001	4833	457	1	3	1	2069.36	27.99	Entregue	2022-03-27 00:00:00
418	746	4912	457	1	3	1	2956.41	25.84	Entregue	2022-06-14 00:00:00
419	1469	4462	457	1	3	1	856.15	31.80	Entregue	2021-03-21 00:00:00
420	1820	4490	457	1	3	1	93.51	44.22	Entregue	2021-04-18 00:00:00
421	1863	4612	457	1	3	1	22165.60	44.11	Entregue	2021-08-18 00:00:00
422	1764	4649	457	1	3	1	6573.15	66.42	Entregue	2021-09-24 00:00:00
423	1335	4391	457	1	3	1	69.39	21.87	Entregue	2021-01-09 00:00:00
424	1305	4459	457	1	3	1	738.95	47.01	Entregue	2021-03-18 00:00:00
425	1943	4424	457	1	3	1	236.07	54.20	Entregue	2021-02-11 00:00:00
426	1568	4460	457	1	3	1	0.01	57.88	Entregue	2021-03-19 00:00:00
427	1297	4384	457	1	3	1	3087.52	51.44	Entregue	2021-01-02 00:00:00
428	1869	4624	457	1	3	1	234.07	26.46	Entregue	2021-08-30 00:00:00
429	918	4773	457	1	3	1	0.01	22.01	Entregue	2022-01-26 00:00:00
430	1293	4722	457	1	3	1	1361.75	23.51	Entregue	2021-12-06 00:00:00
431	848	4385	457	1	3	1	0.01	54.03	Entregue	2021-01-03 00:00:00
432	1303	4694	457	1	3	1	290.09	58.48	Entregue	2021-11-08 00:00:00
433	430	4436	457	1	3	1	10946.26	28.54	Entregue	2021-02-23 00:00:00
434	158	4460	457	1	3	1	0.01	46.42	Entregue	2021-03-19 00:00:00
435	1703	4721	457	1	3	1	373.30	22.33	Entregue	2021-12-05 00:00:00
436	459	4750	457	1	3	1	319.35	54.64	Entregue	2022-01-03 00:00:00
437	1783	4490	457	1	3	1	11623.83	68.95	Entregue	2021-04-18 00:00:00
438	1588	4809	457	1	3	1	4381.21	68.37	Entregue	2022-03-03 00:00:00
439	123	4385	457	1	3	1	13154.49	59.96	Entregue	2021-01-03 00:00:00
440	1418	4476	457	1	3	1	2113.22	61.50	Entregue	2021-04-04 00:00:00
441	1180	4771	457	1	3	1	4683.44	27.68	Entregue	2022-01-24 00:00:00
442	881	4384	457	1	3	1	3359.71	62.77	Entregue	2021-01-02 00:00:00
443	385	4544	457	1	3	1	2506.36	58.79	Entregue	2021-06-11 00:00:00
444	492	4845	457	1	3	1	2963.15	35.38	Entregue	2022-04-08 00:00:00
445	544	4793	457	1	3	1	0.01	47.52	Entregue	2022-02-15 00:00:00
446	1631	4425	457	1	3	1	1961.94	55.65	Entregue	2021-02-12 00:00:00
447	1680	4686	457	1	3	1	2041.37	43.01	Entregue	2021-10-31 00:00:00
448	606	4627	457	1	3	1	4925.73	34.51	Entregue	2021-09-02 00:00:00
449	1667	4512	457	1	3	1	3178.88	30.41	Entregue	2021-05-10 00:00:00
450	308	4529	457	1	3	1	79.77	44.96	Entregue	2021-05-27 00:00:00
451	880	4892	457	1	3	1	2295.01	20.96	Entregue	2022-05-25 00:00:00
452	1072	4695	457	1	3	1	11735.28	52.62	Entregue	2021-11-09 00:00:00
453	1586	4647	457	1	3	1	1856.41	34.61	Entregue	2021-09-22 00:00:00
454	248	4387	457	1	3	1	5519.94	21.32	Entregue	2021-01-05 00:00:00
455	1918	4570	457	1	3	1	3073.23	56.85	Entregue	2021-07-07 00:00:00
456	208	4524	457	1	3	1	1653.51	42.98	Entregue	2021-05-22 00:00:00
457	614	4685	457	1	3	1	5486.57	62.46	Entregue	2021-10-30 00:00:00
458	24	4850	457	1	3	1	1782.88	30.23	Entregue	2022-04-13 00:00:00
459	1607	4563	457	1	3	1	0.01	23.95	Entregue	2021-06-30 00:00:00
460	966	4532	457	1	3	1	1039.82	49.86	Entregue	2021-05-30 00:00:00
461	94	4735	457	1	3	1	830.63	28.17	Entregue	2021-12-19 00:00:00
462	1055	4410	457	1	3	1	322.40	38.90	Entregue	2021-01-28 00:00:00
463	1188	4846	457	1	3	1	14892.80	64.22	Entregue	2022-04-09 00:00:00
464	49	4813	457	1	3	1	1138.86	48.22	Entregue	2022-03-07 00:00:00
465	1955	4892	457	1	3	1	13249.80	31.15	Entregue	2022-05-25 00:00:00
466	1502	4870	457	1	3	1	305.05	66.58	Entregue	2022-05-03 00:00:00
467	1752	4662	457	1	3	1	357.80	27.95	Entregue	2021-10-07 00:00:00
468	846	4688	457	1	3	1	5848.36	32.08	Entregue	2021-11-02 00:00:00
469	1969	4662	457	1	3	1	551.37	67.62	Entregue	2021-10-07 00:00:00
470	1642	4593	457	1	3	1	1121.60	36.49	Entregue	2021-07-30 00:00:00
471	1580	4679	457	1	3	1	0.01	69.88	Entregue	2021-10-24 00:00:00
472	477	4865	457	1	3	1	9912.58	47.64	Entregue	2022-04-28 00:00:00
473	781	4627	457	1	3	1	4794.48	52.23	Entregue	2021-09-02 00:00:00
474	1554	4753	457	1	3	1	15196.36	48.81	Entregue	2022-01-06 00:00:00
475	1362	4798	457	1	3	1	1606.66	21.16	Entregue	2022-02-20 00:00:00
476	858	4858	457	1	3	1	560.15	36.54	Entregue	2022-04-21 00:00:00
477	1799	4854	457	1	3	1	1400.23	41.73	Entregue	2022-04-17 00:00:00
478	406	4545	457	1	3	1	11782.29	69.33	Entregue	2021-06-12 00:00:00
479	1509	4455	457	1	3	1	3669.52	31.48	Entregue	2021-03-14 00:00:00
480	1683	4870	457	1	3	1	2304.15	61.69	Entregue	2022-05-03 00:00:00
481	1686	4589	457	1	3	1	4961.56	49.90	Entregue	2021-07-26 00:00:00
482	849	4564	457	1	3	1	165.32	37.10	Entregue	2021-07-01 00:00:00
483	1573	4408	457	1	3	1	323.98	30.33	Entregue	2021-01-26 00:00:00
484	1905	4671	457	1	3	1	3222.33	21.76	Entregue	2021-10-16 00:00:00
485	1698	4725	457	1	3	1	744.61	34.95	Entregue	2021-12-09 00:00:00
486	1348	4595	457	1	3	1	1937.46	63.98	Entregue	2021-08-01 00:00:00
487	919	4735	457	1	3	1	15119.89	41.46	Entregue	2021-12-19 00:00:00
488	1894	4669	457	1	3	1	3908.30	53.06	Entregue	2021-10-14 00:00:00
489	1096	4676	457	1	3	1	2641.15	67.83	Entregue	2021-10-21 00:00:00
490	932	4906	457	1	3	1	362.48	48.46	Entregue	2022-06-08 00:00:00
491	1273	4594	457	1	3	1	13.97	29.17	Entregue	2021-07-31 00:00:00
492	1673	4497	457	1	3	1	9890.55	42.47	Entregue	2021-04-25 00:00:00
493	961	4464	457	1	3	1	2388.05	60.72	Entregue	2021-03-23 00:00:00
494	1433	4861	457	1	3	1	2446.40	37.21	Entregue	2022-04-24 00:00:00
495	1781	4494	457	1	3	1	2892.33	47.80	Entregue	2021-04-22 00:00:00
496	733	4411	457	1	3	1	193.42	65.19	Entregue	2021-01-29 00:00:00
497	269	4719	457	1	3	1	563.50	33.56	Entregue	2021-12-03 00:00:00
498	1728	4696	457	1	3	1	1528.98	64.59	Entregue	2021-11-10 00:00:00
499	1594	4413	457	1	3	1	2311.11	39.39	Entregue	2021-01-31 00:00:00
500	261	4428	457	1	3	1	3149.29	59.57	Entregue	2021-02-15 00:00:00
501	125	4595	457	1	3	1	797.42	56.64	Entregue	2021-08-01 00:00:00
502	1426	4875	457	1	3	1	2983.34	49.30	Entregue	2022-05-08 00:00:00
503	700	4545	457	1	3	1	30.81	63.93	Entregue	2021-06-12 00:00:00
504	1308	4915	457	1	3	1	4922.68	40.70	Entregue	2022-06-17 00:00:00
505	43	4562	457	1	3	1	850.98	42.43	Entregue	2021-06-29 00:00:00
506	587	4494	457	1	3	1	766.57	25.91	Entregue	2021-04-22 00:00:00
507	1908	4641	457	1	3	1	1301.26	68.91	Entregue	2021-09-16 00:00:00
508	1649	4539	457	1	3	1	379.29	67.82	Entregue	2021-06-06 00:00:00
509	1444	4641	457	1	3	1	7227.96	63.74	Entregue	2021-09-16 00:00:00
510	1090	4781	457	1	3	1	609.33	48.33	Entregue	2022-02-03 00:00:00
511	1687	4870	457	1	3	1	470.27	68.12	Entregue	2022-05-03 00:00:00
512	349	4411	457	1	3	1	4938.75	68.52	Entregue	2021-01-29 00:00:00
513	187	4605	457	1	3	1	13449.43	48.28	Entregue	2021-08-11 00:00:00
514	766	4410	457	1	3	1	559.88	66.40	Entregue	2021-01-28 00:00:00
515	1533	4488	457	1	3	1	0.01	24.55	Entregue	2021-04-16 00:00:00
516	1978	4585	457	1	3	1	500.14	29.63	Entregue	2021-07-22 00:00:00
517	1789	4884	457	1	3	1	571.41	20.38	Entregue	2022-05-17 00:00:00
518	1416	4705	457	1	3	1	3935.33	49.56	Entregue	2021-11-19 00:00:00
519	242	4884	457	1	3	1	6016.69	60.81	Entregue	2022-05-17 00:00:00
520	1024	4768	457	1	3	1	2022.41	49.72	Entregue	2022-01-21 00:00:00
521	1576	4388	457	1	3	1	211.87	26.65	Entregue	2021-01-06 00:00:00
522	677	4911	457	1	3	1	218.07	44.53	Entregue	2022-06-13 00:00:00
523	1954	4706	457	1	3	1	564.56	37.06	Entregue	2021-11-20 00:00:00
524	1232	4504	457	1	3	1	3850.23	66.18	Entregue	2021-05-02 00:00:00
525	1543	4912	457	1	3	1	576.32	32.45	Entregue	2022-06-14 00:00:00
526	1028	4837	457	1	3	1	824.65	50.87	Entregue	2022-03-31 00:00:00
527	29	4818	457	1	3	1	0.01	36.13	Entregue	2022-03-12 00:00:00
528	4	4495	457	1	3	1	2070.92	47.75	Entregue	2021-04-23 00:00:00
529	96	4450	457	1	3	1	1540.12	37.50	Entregue	2021-03-09 00:00:00
530	844	4632	457	1	3	1	9728.30	38.62	Entregue	2021-09-07 00:00:00
531	980	4883	457	1	3	1	2667.38	48.36	Entregue	2022-05-16 00:00:00
532	1890	4785	457	1	3	1	333.14	62.17	Entregue	2022-02-07 00:00:00
533	1787	4540	457	1	3	1	300.92	44.10	Entregue	2021-06-07 00:00:00
534	1039	4462	457	1	3	1	56.22	63.45	Entregue	2021-03-21 00:00:00
535	631	4686	457	1	3	1	872.66	47.48	Entregue	2021-10-31 00:00:00
536	107	4614	457	1	3	1	2921.46	43.06	Entregue	2021-08-20 00:00:00
537	6	4611	457	1	3	1	750.99	25.41	Entregue	2021-08-17 00:00:00
538	1551	4495	457	1	3	1	1867.36	34.61	Entregue	2021-04-23 00:00:00
539	1163	4757	457	1	3	1	297.68	28.48	Entregue	2022-01-10 00:00:00
540	1148	4534	457	1	3	1	3704.64	48.68	Entregue	2021-06-01 00:00:00
541	1641	4638	457	1	3	1	3827.81	43.61	Entregue	2021-09-13 00:00:00
542	1628	4797	457	1	3	1	2745.53	24.68	Entregue	2022-02-19 00:00:00
543	363	4641	457	1	3	1	0.01	30.53	Entregue	2021-09-16 00:00:00
544	1979	4611	457	1	3	1	174.11	29.84	Entregue	2021-08-17 00:00:00
545	1432	4897	457	1	3	1	1071.91	32.66	Entregue	2022-05-30 00:00:00
546	1650	4859	457	1	3	1	47.44	42.84	Entregue	2022-04-22 00:00:00
547	66	4623	457	1	3	1	513.39	52.62	Entregue	2021-08-29 00:00:00
548	661	4418	457	1	3	1	2268.45	40.34	Entregue	2021-02-05 00:00:00
549	512	4488	457	1	3	1	4976.90	36.36	Entregue	2021-04-16 00:00:00
550	340	4776	457	1	3	1	0.01	24.24	Entregue	2022-01-29 00:00:00
551	1653	4479	457	1	3	1	95.21	58.58	Entregue	2021-04-07 00:00:00
552	523	4462	457	1	3	1	520.76	23.50	Entregue	2021-03-21 00:00:00
553	356	4761	457	1	3	1	3225.26	67.51	Entregue	2022-01-14 00:00:00
554	1919	4843	457	1	3	1	4790.34	45.58	Entregue	2022-04-06 00:00:00
555	458	4913	457	1	3	1	870.88	69.18	Entregue	2022-06-15 00:00:00
556	1970	4810	457	1	3	1	644.58	66.31	Entregue	2022-03-04 00:00:00
557	1572	4563	457	1	3	1	1903.84	69.57	Entregue	2021-06-30 00:00:00
558	368	4716	457	1	3	1	2129.06	33.74	Entregue	2021-11-30 00:00:00
559	1982	4599	457	1	3	1	871.85	23.34	Entregue	2021-08-05 00:00:00
560	1850	4671	457	1	3	1	503.06	41.72	Entregue	2021-10-16 00:00:00
561	538	4513	457	1	3	1	77.54	37.05	Entregue	2021-05-11 00:00:00
562	595	4892	457	1	3	1	361.56	62.87	Entregue	2022-05-25 00:00:00
563	142	4791	457	1	3	1	0.01	50.85	Entregue	2022-02-13 00:00:00
564	924	4734	457	1	3	1	17227.26	63.62	Entregue	2021-12-18 00:00:00
565	872	4421	457	1	3	1	0.01	38.21	Entregue	2021-02-08 00:00:00
566	1140	4413	457	1	3	1	1149.23	22.14	Entregue	2021-01-31 00:00:00
567	1054	4840	457	1	3	1	1652.43	61.54	Entregue	2022-04-03 00:00:00
568	792	4384	457	1	3	1	1379.06	53.61	Entregue	2021-01-02 00:00:00
569	1965	4687	457	1	3	1	147.31	67.33	Entregue	2021-11-01 00:00:00
570	896	4890	457	1	3	1	720.06	66.49	Entregue	2022-05-23 00:00:00
571	651	4516	457	1	3	1	2409.59	46.45	Entregue	2021-05-14 00:00:00
572	38	4445	457	1	3	1	3607.11	63.63	Entregue	2021-03-04 00:00:00
573	1005	4568	457	1	3	1	112.77	49.42	Entregue	2021-07-05 00:00:00
574	359	4563	457	1	3	1	166.52	35.98	Entregue	2021-06-30 00:00:00
575	1449	4697	457	1	3	1	228.94	31.88	Entregue	2021-11-11 00:00:00
576	1212	4517	457	1	3	1	120.31	22.13	Entregue	2021-05-15 00:00:00
577	217	4589	457	1	3	1	386.73	20.33	Entregue	2021-07-26 00:00:00
578	1332	4867	457	1	3	1	1341.79	59.18	Entregue	2022-04-30 00:00:00
579	985	4857	457	1	3	1	445.85	56.89	Entregue	2022-04-20 00:00:00
580	1601	4705	457	1	3	1	68.76	36.71	Entregue	2021-11-19 00:00:00
581	779	4412	457	1	3	1	2496.86	57.55	Entregue	2021-01-30 00:00:00
582	1737	4886	457	1	3	1	991.04	38.65	Entregue	2022-05-19 00:00:00
583	1721	4750	457	1	3	1	296.09	61.55	Entregue	2022-01-03 00:00:00
584	1251	4490	457	1	3	1	2242.40	63.94	Entregue	2021-04-18 00:00:00
585	931	4586	457	1	3	1	103.01	51.94	Entregue	2021-07-23 00:00:00
586	1706	4863	457	1	3	1	772.25	58.74	Entregue	2022-04-26 00:00:00
587	1189	4833	457	1	3	1	946.45	42.39	Entregue	2022-03-27 00:00:00
588	718	4623	457	1	3	1	2385.57	51.61	Entregue	2021-08-29 00:00:00
589	1712	4839	457	1	3	1	301.03	51.72	Entregue	2022-04-02 00:00:00
590	623	4479	457	1	3	1	245.50	42.90	Entregue	2021-04-07 00:00:00
591	1654	4815	457	1	3	1	379.16	63.19	Entregue	2022-03-09 00:00:00
592	1364	4903	457	1	3	1	1763.65	64.23	Entregue	2022-06-05 00:00:00
593	1991	4676	457	1	3	1	1230.48	45.50	Entregue	2021-10-21 00:00:00
594	1889	4480	457	1	3	1	1337.32	52.12	Entregue	2021-04-08 00:00:00
595	229	4797	457	1	3	1	1780.20	68.85	Entregue	2022-02-19 00:00:00
596	1112	4884	457	1	3	1	6488.61	66.10	Entregue	2022-05-17 00:00:00
597	559	4788	457	1	3	1	3.44	26.80	Entregue	2022-02-10 00:00:00
598	788	4522	457	1	3	1	1133.09	56.32	Entregue	2021-05-20 00:00:00
599	304	4596	457	1	3	1	1742.45	52.81	Entregue	2021-08-02 00:00:00
600	1971	4896	457	1	3	1	1845.30	34.92	Entregue	2022-05-29 00:00:00
601	52	4784	457	1	3	1	3945.62	43.98	Entregue	2022-02-06 00:00:00
602	633	4594	457	1	3	1	0.01	49.61	Entregue	2021-07-31 00:00:00
603	450	4550	457	1	3	1	222.25	50.38	Entregue	2021-06-17 00:00:00
604	900	4698	457	1	3	1	2014.48	38.07	Entregue	2021-11-12 00:00:00
605	405	4750	457	1	3	1	485.06	56.36	Entregue	2022-01-03 00:00:00
606	996	4485	457	1	3	1	0.01	38.33	Entregue	2021-04-13 00:00:00
607	762	4680	457	1	3	1	615.35	59.21	Entregue	2021-10-25 00:00:00
608	1197	4456	457	1	3	1	237.52	60.72	Entregue	2021-03-15 00:00:00
609	1063	4513	457	1	3	1	0.01	39.01	Entregue	2021-05-11 00:00:00
610	69	4870	457	1	3	1	1871.03	25.62	Entregue	2022-05-03 00:00:00
611	1059	4624	457	1	3	1	30.19	66.58	Entregue	2021-08-30 00:00:00
612	878	4497	457	1	3	1	218.50	47.43	Entregue	2021-04-25 00:00:00
613	679	4859	457	1	3	1	2829.69	67.33	Entregue	2022-04-22 00:00:00
614	1912	4529	457	1	3	1	0.01	50.37	Entregue	2021-05-27 00:00:00
615	983	4794	457	1	3	1	76.55	61.56	Entregue	2022-02-16 00:00:00
616	375	4701	457	1	3	1	2629.99	39.91	Entregue	2021-11-15 00:00:00
617	976	4905	457	1	3	1	2842.73	65.91	Entregue	2022-06-07 00:00:00
618	729	4551	457	1	3	1	97.75	64.07	Entregue	2021-06-18 00:00:00
619	1242	4831	457	1	3	1	2216.73	46.18	Entregue	2022-03-25 00:00:00
620	680	4544	457	1	3	1	335.07	29.31	Entregue	2021-06-11 00:00:00
621	408	4585	457	1	3	1	14.54	33.12	Entregue	2021-07-22 00:00:00
622	782	4857	457	1	3	1	1287.40	44.38	Entregue	2022-04-20 00:00:00
623	1160	4841	457	1	3	1	1265.11	53.62	Entregue	2022-04-04 00:00:00
624	1514	4531	457	1	3	1	457.51	50.06	Entregue	2021-05-29 00:00:00
625	1338	4897	457	1	3	1	221.06	55.51	Entregue	2022-05-30 00:00:00
626	1359	4828	457	1	3	1	4198.66	25.68	Entregue	2022-03-22 00:00:00
627	982	4792	457	1	3	1	1035.26	21.15	Entregue	2022-02-14 00:00:00
628	1079	4800	457	1	3	1	0.01	56.31	Entregue	2022-02-22 00:00:00
629	1445	4711	457	1	3	1	375.24	43.10	Entregue	2021-11-25 00:00:00
630	11	4878	457	1	3	1	2614.37	61.47	Entregue	2022-05-11 00:00:00
631	1152	4438	457	1	3	1	845.14	28.02	Entregue	2021-02-25 00:00:00
632	1384	4544	457	1	3	1	453.58	57.00	Entregue	2021-06-11 00:00:00
633	1330	4457	457	1	3	1	4090.42	39.00	Entregue	2021-03-16 00:00:00
634	821	4554	457	1	3	1	117.57	47.34	Entregue	2021-06-21 00:00:00
635	1826	4649	457	1	3	1	160.28	31.55	Entregue	2021-09-24 00:00:00
636	1141	4397	457	1	3	1	385.67	38.56	Entregue	2021-01-15 00:00:00
637	1329	4534	457	1	3	1	3000.42	41.48	Entregue	2021-06-01 00:00:00
638	659	4610	457	1	3	1	105.75	38.03	Entregue	2021-08-16 00:00:00
639	279	4548	457	1	3	1	3295.93	66.66	Entregue	2021-06-15 00:00:00
640	1481	4596	457	1	3	1	0.01	68.77	Entregue	2021-08-02 00:00:00
641	1480	4665	457	1	3	1	153.79	23.99	Entregue	2021-10-10 00:00:00
642	9	4545	457	1	3	1	657.11	35.83	Entregue	2021-06-12 00:00:00
643	903	4709	457	1	3	1	273.21	58.09	Entregue	2021-11-23 00:00:00
644	1490	4862	457	1	3	1	4271.92	67.06	Entregue	2022-04-25 00:00:00
645	736	4742	457	1	3	1	4438.36	25.04	Entregue	2021-12-26 00:00:00
646	565	4509	457	1	3	1	204.92	42.29	Entregue	2021-05-07 00:00:00
647	1947	4774	457	1	3	1	360.05	39.31	Entregue	2022-01-27 00:00:00
648	566	4741	457	1	3	1	515.38	41.63	Entregue	2021-12-25 00:00:00
649	457	4645	457	1	3	1	488.69	67.14	Entregue	2021-09-20 00:00:00
650	592	4554	457	1	3	1	0.01	49.40	Entregue	2021-06-21 00:00:00
651	1041	4759	457	1	3	1	0.01	44.08	Entregue	2022-01-12 00:00:00
652	553	4546	457	1	3	1	2652.43	41.45	Entregue	2021-06-13 00:00:00
653	1640	4840	457	1	3	1	3948.84	58.70	Entregue	2022-04-03 00:00:00
654	302	4608	457	1	3	1	185.32	35.36	Entregue	2021-08-14 00:00:00
655	1520	4520	457	1	3	1	577.32	20.09	Entregue	2021-05-18 00:00:00
656	1968	4595	457	1	3	1	0.01	50.48	Entregue	2021-08-01 00:00:00
657	927	4515	457	1	3	1	616.52	65.17	Entregue	2021-05-13 00:00:00
658	774	4641	457	1	3	1	86.76	66.72	Entregue	2021-09-16 00:00:00
659	1385	4510	457	1	3	1	502.17	28.07	Entregue	2021-05-08 00:00:00
660	398	4645	457	1	3	1	421.29	44.57	Entregue	2021-09-20 00:00:00
661	1726	4747	457	1	3	1	692.28	20.95	Entregue	2021-12-31 00:00:00
662	1732	4607	457	1	3	1	273.62	37.36	Entregue	2021-08-13 00:00:00
663	1233	4458	457	1	3	1	0.01	47.70	Entregue	2021-03-17 00:00:00
664	165	4676	457	1	3	1	6529.46	34.53	Entregue	2021-10-21 00:00:00
665	56	4504	457	1	3	1	1095.43	53.33	Entregue	2021-05-02 00:00:00
666	820	4549	457	1	3	1	214.11	49.13	Entregue	2021-06-16 00:00:00
667	1267	4768	457	1	3	1	0.01	49.73	Entregue	2022-01-21 00:00:00
668	992	4544	457	1	3	1	2151.17	66.97	Entregue	2021-06-11 00:00:00
669	894	4863	457	1	3	1	651.49	68.17	Entregue	2022-04-26 00:00:00
670	1357	4848	457	1	3	1	0.01	35.27	Entregue	2022-04-11 00:00:00
671	245	4639	457	1	3	1	0.01	35.43	Entregue	2021-09-14 00:00:00
672	1326	4915	457	1	3	1	3178.62	26.33	Entregue	2022-06-17 00:00:00
673	1020	4550	457	1	3	1	1996.08	27.03	Entregue	2021-06-17 00:00:00
674	1807	4578	457	1	3	1	0.01	66.76	Entregue	2021-07-15 00:00:00
675	1127	4843	457	1	3	1	24.65	67.49	Entregue	2022-04-06 00:00:00
676	1060	4549	457	1	3	1	2220.70	50.75	Entregue	2021-06-16 00:00:00
677	1017	4859	457	1	3	1	31.43	32.83	Entregue	2022-04-22 00:00:00
678	484	4751	457	1	3	1	303.72	34.88	Entregue	2022-01-04 00:00:00
679	558	4522	457	1	3	1	93.52	59.11	Entregue	2021-05-20 00:00:00
680	144	4691	457	1	3	1	3338.04	20.17	Entregue	2021-11-05 00:00:00
681	1720	4635	457	1	3	1	0.01	65.11	Entregue	2021-09-10 00:00:00
682	1885	4577	457	1	3	1	0.01	68.10	Entregue	2021-07-14 00:00:00
683	1754	4491	457	1	3	1	1377.22	51.05	Entregue	2021-04-19 00:00:00
684	1538	4563	457	1	3	1	3706.46	45.37	Entregue	2021-06-30 00:00:00
685	1224	4389	457	1	3	1	2623.86	57.14	Entregue	2021-01-07 00:00:00
686	168	4420	457	1	3	1	4772.11	51.05	Entregue	2021-02-07 00:00:00
687	598	4744	457	1	3	1	287.93	20.40	Entregue	2021-12-28 00:00:00
688	471	4695	457	1	3	1	3271.47	39.22	Entregue	2021-11-09 00:00:00
689	1930	4652	457	1	3	1	3999.12	49.68	Entregue	2021-09-27 00:00:00
690	1051	4875	457	1	3	1	0.01	27.72	Entregue	2022-05-08 00:00:00
691	1424	4711	457	1	3	1	1281.84	49.74	Entregue	2021-11-25 00:00:00
692	287	4761	457	1	3	1	3767.90	38.53	Entregue	2022-01-14 00:00:00
693	167	4615	457	1	3	1	142.61	69.01	Entregue	2021-08-21 00:00:00
694	290	4595	457	1	3	1	270.26	42.50	Entregue	2021-08-01 00:00:00
695	1716	4906	457	1	3	1	5669.90	52.68	Entregue	2022-06-08 00:00:00
696	1352	4516	457	1	3	1	802.78	40.88	Entregue	2021-05-14 00:00:00
697	1859	4716	457	1	3	1	259.84	47.57	Entregue	2021-11-30 00:00:00
698	1441	4397	457	1	3	1	7529.02	38.32	Entregue	2021-01-15 00:00:00
699	1035	4553	457	1	3	1	1818.98	53.91	Entregue	2021-06-20 00:00:00
700	367	4651	457	1	3	1	0.01	57.66	Entregue	2021-09-26 00:00:00
701	41	4816	457	1	3	1	445.08	24.32	Entregue	2022-03-10 00:00:00
702	1389	4699	457	1	3	1	0.01	65.80	Entregue	2021-11-13 00:00:00
703	572	4498	457	1	3	1	47.70	31.84	Entregue	2021-04-26 00:00:00
704	32	4802	457	1	3	1	1664.70	63.21	Entregue	2022-02-24 00:00:00
705	1735	4899	457	1	3	1	85.74	21.24	Entregue	2022-06-01 00:00:00
706	247	4614	457	1	3	1	438.50	68.78	Entregue	2021-08-20 00:00:00
707	423	4555	457	1	3	1	148.99	49.46	Entregue	2021-06-22 00:00:00
708	1240	4391	457	1	3	1	383.86	46.91	Entregue	2021-01-09 00:00:00
709	1881	4495	457	1	3	1	9926.91	59.12	Entregue	2021-04-23 00:00:00
710	1621	4440	457	1	3	1	865.84	52.99	Entregue	2021-02-27 00:00:00
711	1182	4815	457	1	3	1	806.88	26.80	Entregue	2022-03-09 00:00:00
712	1946	4474	457	1	3	1	15044.80	21.21	Entregue	2021-04-02 00:00:00
713	411	4874	457	1	3	1	11180.57	63.46	Entregue	2022-05-07 00:00:00
714	869	4845	457	1	3	1	415.74	20.32	Entregue	2022-04-08 00:00:00
715	864	4886	457	1	3	1	1622.92	54.86	Entregue	2022-05-19 00:00:00
716	672	4867	457	1	3	1	2606.34	47.66	Entregue	2022-04-30 00:00:00
717	1584	4794	457	1	3	1	0.01	45.83	Entregue	2022-02-16 00:00:00
718	1454	4517	457	1	3	1	12935.37	32.52	Entregue	2021-05-15 00:00:00
719	316	4831	457	1	3	1	2436.96	51.34	Entregue	2022-03-25 00:00:00
720	1282	4554	457	1	3	1	0.01	66.19	Entregue	2021-06-21 00:00:00
721	256	4865	457	1	3	1	397.09	64.54	Entregue	2022-04-28 00:00:00
722	332	4569	457	1	3	1	104.24	64.30	Entregue	2021-07-06 00:00:00
723	1812	4797	457	1	3	1	4734.24	34.60	Entregue	2022-02-19 00:00:00
724	628	4696	457	1	3	1	124.88	49.40	Entregue	2021-11-10 00:00:00
725	1860	4661	457	1	3	1	0.01	43.16	Entregue	2021-10-06 00:00:00
726	885	4659	457	1	3	1	0.01	35.50	Entregue	2021-10-04 00:00:00
727	422	4466	457	1	3	1	112.11	44.12	Entregue	2021-03-25 00:00:00
728	185	4606	457	1	3	1	334.81	35.81	Entregue	2021-08-12 00:00:00
729	215	4753	457	1	3	1	1321.17	33.43	Entregue	2022-01-06 00:00:00
730	1275	4815	457	1	3	1	1455.75	62.00	Entregue	2022-03-09 00:00:00
731	1107	4645	457	1	3	1	0.01	60.61	Entregue	2021-09-20 00:00:00
732	1465	4396	457	1	3	1	0.01	48.78	Entregue	2021-01-14 00:00:00
733	1157	4539	457	1	3	1	0.01	29.55	Entregue	2021-06-06 00:00:00
734	625	4605	457	1	3	1	3688.97	25.82	Entregue	2021-08-11 00:00:00
735	1155	4856	457	1	3	1	18809.15	39.29	Entregue	2022-04-19 00:00:00
736	1526	4456	457	1	3	1	666.74	61.16	Entregue	2021-03-15 00:00:00
737	617	4692	457	1	3	1	7892.93	49.13	Entregue	2021-11-06 00:00:00
738	1541	4579	457	1	3	1	215.64	45.93	Entregue	2021-07-16 00:00:00
739	1531	4482	457	1	3	1	5612.17	67.26	Entregue	2021-04-10 00:00:00
740	1671	4385	457	1	3	1	19716.49	21.06	Entregue	2021-01-03 00:00:00
741	819	4427	457	1	3	1	386.37	52.94	Entregue	2021-02-14 00:00:00
742	314	4696	457	1	3	1	1551.36	26.38	Entregue	2021-11-10 00:00:00
743	817	4686	457	1	3	1	2715.11	56.20	Entregue	2021-10-31 00:00:00
744	1274	4891	457	1	3	1	2336.35	43.38	Entregue	2022-05-24 00:00:00
745	426	4510	457	1	3	1	1530.22	48.12	Entregue	2021-05-08 00:00:00
746	1891	4594	457	1	3	1	0.01	40.72	Entregue	2021-07-31 00:00:00
747	1840	4504	457	1	3	1	0.01	53.38	Entregue	2021-05-02 00:00:00
748	1805	4592	457	1	3	1	1334.30	61.37	Entregue	2021-07-29 00:00:00
749	877	4533	457	1	3	1	0.01	57.97	Entregue	2021-05-31 00:00:00
750	299	4855	457	1	3	1	671.04	64.61	Entregue	2022-04-18 00:00:00
751	169	4855	457	1	3	1	4212.16	40.03	Entregue	2022-04-18 00:00:00
752	1113	4448	457	1	3	1	0.01	36.07	Entregue	2021-03-07 00:00:00
753	605	4466	457	1	3	1	170.34	63.89	Entregue	2021-03-25 00:00:00
754	1317	4665	457	1	3	1	100.70	69.14	Entregue	2021-10-10 00:00:00
755	1702	4870	457	1	3	1	95.49	30.05	Entregue	2022-05-03 00:00:00
756	971	4408	457	1	3	1	84.92	26.69	Entregue	2021-01-26 00:00:00
757	660	4652	457	1	3	1	0.01	47.96	Entregue	2021-09-27 00:00:00
758	1825	4855	457	1	3	1	1992.92	22.08	Entregue	2022-04-18 00:00:00
759	1759	4579	457	1	3	1	291.14	55.23	Entregue	2021-07-16 00:00:00
760	910	4564	457	1	3	1	1300.57	63.82	Entregue	2021-07-01 00:00:00
761	1707	4626	457	1	3	1	4809.86	33.23	Entregue	2021-09-01 00:00:00
762	236	4398	457	1	3	1	1103.50	55.78	Entregue	2021-01-16 00:00:00
763	941	4589	457	1	3	1	0.01	64.49	Entregue	2021-07-26 00:00:00
764	949	4812	457	1	3	1	0.01	49.96	Entregue	2022-03-06 00:00:00
765	135	4412	457	1	3	1	976.41	38.74	Entregue	2021-01-30 00:00:00
766	1751	4818	457	1	3	1	178.73	38.73	Entregue	2022-03-12 00:00:00
767	1626	4771	457	1	3	1	209.09	59.92	Entregue	2022-01-24 00:00:00
768	1064	4541	457	1	3	1	5430.47	49.91	Entregue	2021-06-08 00:00:00
769	454	4614	457	1	3	1	2260.91	63.05	Entregue	2021-08-20 00:00:00
770	1193	4853	457	1	3	1	4164.35	49.69	Entregue	2022-04-16 00:00:00
771	879	4385	457	1	3	1	17371.07	69.10	Entregue	2021-01-03 00:00:00
772	227	4883	457	1	3	1	2491.97	47.48	Entregue	2022-05-16 00:00:00
773	500	4833	457	1	3	1	1560.48	29.56	Entregue	2022-03-27 00:00:00
774	1204	4552	457	1	3	1	2771.76	28.05	Entregue	2021-06-19 00:00:00
775	73	4644	457	1	3	1	1219.17	39.72	Entregue	2021-09-19 00:00:00
776	1169	4429	457	1	3	1	3836.27	37.86	Entregue	2021-02-16 00:00:00
777	1994	4695	457	1	3	1	0.01	49.71	Entregue	2021-11-09 00:00:00
778	1874	4850	457	1	3	1	2777.97	57.37	Entregue	2022-04-13 00:00:00
779	1171	4612	457	1	3	1	22284.08	54.36	Entregue	2021-08-18 00:00:00
780	1138	4709	457	1	3	1	5307.42	52.15	Entregue	2021-11-23 00:00:00
781	1085	4490	457	1	3	1	2947.68	20.58	Entregue	2021-04-18 00:00:00
782	239	4480	457	1	3	1	67.77	55.04	Entregue	2021-04-08 00:00:00
783	121	4891	457	1	3	1	1217.51	33.66	Entregue	2022-05-24 00:00:00
784	1353	4544	457	1	3	1	0.01	37.35	Entregue	2021-06-11 00:00:00
785	1438	4743	457	1	3	1	473.00	56.24	Entregue	2021-12-27 00:00:00
786	1407	4839	457	1	3	1	26.53	49.71	Entregue	2022-04-02 00:00:00
787	561	4577	457	1	3	1	1729.06	35.20	Entregue	2021-07-14 00:00:00
788	1688	4445	457	1	3	1	6.87	22.47	Entregue	2021-03-04 00:00:00
789	755	4776	457	1	3	1	0.01	62.60	Entregue	2022-01-29 00:00:00
790	1184	4599	457	1	3	1	1389.05	59.52	Entregue	2021-08-05 00:00:00
791	1031	4772	457	1	3	1	756.74	64.49	Entregue	2022-01-25 00:00:00
792	1670	4812	457	1	3	1	337.72	20.88	Entregue	2022-03-06 00:00:00
793	15	4586	457	1	3	1	4762.09	63.99	Entregue	2021-07-23 00:00:00
794	1865	4622	457	1	3	1	0.01	69.93	Entregue	2021-08-28 00:00:00
795	1129	4656	457	1	3	1	359.90	55.95	Entregue	2021-10-01 00:00:00
796	859	4491	457	1	3	1	637.86	53.72	Entregue	2021-04-19 00:00:00
797	842	4422	457	1	3	1	11001.63	58.59	Entregue	2021-02-09 00:00:00
798	767	4853	457	1	3	1	154.08	56.25	Entregue	2022-04-16 00:00:00
799	1367	4516	457	1	3	1	3378.93	50.33	Entregue	2021-05-14 00:00:00
800	244	4442	457	1	3	1	1423.80	23.19	Entregue	2021-03-01 00:00:00
801	1192	4633	457	1	3	1	35.34	25.69	Entregue	2021-09-08 00:00:00
802	1088	4432	457	1	3	1	262.11	51.25	Entregue	2021-02-19 00:00:00
803	1124	4629	457	1	3	1	266.56	31.03	Entregue	2021-09-04 00:00:00
804	468	4534	457	1	3	1	285.36	36.61	Entregue	2021-06-01 00:00:00
805	1717	4647	457	1	3	1	2825.64	22.92	Entregue	2021-09-22 00:00:00
806	1738	4648	457	1	3	1	7.14	21.32	Entregue	2021-09-23 00:00:00
807	1725	4446	457	1	3	1	349.53	52.05	Entregue	2021-03-05 00:00:00
808	1243	4888	457	1	3	1	0.01	32.92	Entregue	2022-05-21 00:00:00
809	721	4820	457	1	3	1	78.61	35.23	Entregue	2022-03-14 00:00:00
810	251	4535	457	1	3	1	364.54	51.87	Entregue	2021-06-02 00:00:00
811	1100	4623	457	1	3	1	35.66	64.09	Entregue	2021-08-29 00:00:00
812	1270	4653	457	1	3	1	9329.88	31.55	Entregue	2021-09-28 00:00:00
813	1436	4639	457	1	3	1	52.32	54.01	Entregue	2021-09-14 00:00:00
814	960	4494	457	1	3	1	1132.99	28.88	Entregue	2021-04-22 00:00:00
815	1516	4501	457	1	3	1	5.27	37.18	Entregue	2021-04-29 00:00:00
816	786	4487	457	1	3	1	1513.60	24.86	Entregue	2021-04-15 00:00:00
817	1945	4795	457	1	3	1	128.36	42.97	Entregue	2022-02-17 00:00:00
818	1455	4391	457	1	3	1	525.15	31.61	Entregue	2021-01-09 00:00:00
819	321	4464	457	1	3	1	143.94	61.60	Entregue	2021-03-23 00:00:00
820	105	4643	457	1	3	1	0.01	49.09	Entregue	2021-09-18 00:00:00
821	402	4411	457	1	3	1	155.86	63.20	Entregue	2021-01-29 00:00:00
822	804	4404	457	1	3	1	3871.25	51.15	Entregue	2021-01-22 00:00:00
823	1934	4737	457	1	3	1	203.19	41.15	Entregue	2021-12-21 00:00:00
824	866	4647	457	1	3	1	16756.18	30.60	Entregue	2021-09-22 00:00:00
825	1542	4577	457	1	3	1	0.01	56.41	Entregue	2021-07-14 00:00:00
826	1487	4651	457	1	3	1	9319.71	40.57	Entregue	2021-09-26 00:00:00
827	991	4779	457	1	3	1	1976.77	26.11	Entregue	2022-02-01 00:00:00
828	1391	4645	457	1	3	1	961.12	59.08	Entregue	2021-09-20 00:00:00
829	776	4568	457	1	3	1	4264.92	37.07	Entregue	2021-07-05 00:00:00
830	467	4411	457	1	3	1	7.29	20.27	Entregue	2021-01-29 00:00:00
831	327	4815	457	1	3	1	6377.97	25.82	Entregue	2022-03-09 00:00:00
832	1636	4534	457	1	3	1	0.01	20.79	Entregue	2021-06-01 00:00:00
833	1177	4385	457	1	3	1	68.83	60.29	Entregue	2021-01-03 00:00:00
834	1121	4900	457	1	3	1	1517.04	44.42	Entregue	2022-06-02 00:00:00
835	1882	4762	457	1	3	1	3541.47	45.94	Entregue	2022-01-15 00:00:00
836	1566	4660	457	1	3	1	5254.57	50.50	Entregue	2021-10-05 00:00:00
837	1343	4577	457	1	3	1	1183.06	63.52	Entregue	2021-07-14 00:00:00
838	724	4709	457	1	3	1	1361.98	49.34	Entregue	2021-11-23 00:00:00
839	1785	4689	457	1	3	1	4330.84	42.66	Entregue	2021-11-03 00:00:00
840	1323	4640	457	1	3	1	0.01	43.17	Entregue	2021-09-15 00:00:00
841	1222	4861	457	1	3	1	5464.76	62.78	Entregue	2022-04-24 00:00:00
842	1921	4824	457	1	3	1	241.36	37.77	Entregue	2022-03-18 00:00:00
843	1714	4541	457	1	3	1	230.65	22.12	Entregue	2021-06-08 00:00:00
844	372	4798	457	1	3	1	1661.93	51.13	Entregue	2022-02-20 00:00:00
845	1358	4798	457	1	3	1	2656.81	27.54	Entregue	2022-02-20 00:00:00
846	339	4549	457	1	3	1	68.07	68.27	Entregue	2021-06-16 00:00:00
847	600	4649	457	1	3	1	1973.50	27.50	Entregue	2021-09-24 00:00:00
848	772	4689	457	1	3	1	35.88	68.99	Entregue	2021-11-03 00:00:00
849	335	4724	457	1	3	1	1237.56	33.28	Entregue	2021-12-08 00:00:00
850	1596	4533	457	1	3	1	0.01	58.30	Entregue	2021-05-31 00:00:00
851	1931	4589	457	1	3	1	2028.87	30.16	Entregue	2021-07-26 00:00:00
852	1756	4455	457	1	3	1	4169.72	54.17	Entregue	2021-03-14 00:00:00
853	591	4742	457	1	3	1	8261.92	22.99	Entregue	2021-12-26 00:00:00
854	808	4539	457	1	3	1	3450.86	42.37	Entregue	2021-06-06 00:00:00
855	1695	4814	457	1	3	1	563.26	43.97	Entregue	2022-03-08 00:00:00
856	1768	4611	457	1	3	1	499.78	53.51	Entregue	2021-08-17 00:00:00
857	827	4599	457	1	3	1	0.01	64.56	Entregue	2021-08-05 00:00:00
858	254	4427	457	1	3	1	346.52	32.69	Entregue	2021-02-14 00:00:00
859	1360	4858	457	1	3	1	528.18	69.87	Entregue	2022-04-21 00:00:00
860	377	4914	457	1	3	1	1144.15	39.91	Entregue	2022-06-16 00:00:00
861	952	4510	457	1	3	1	285.34	60.81	Entregue	2021-05-08 00:00:00
862	159	4550	457	1	3	1	465.00	24.97	Entregue	2021-06-17 00:00:00
863	1399	4778	457	1	3	1	0.01	48.70	Entregue	2022-01-31 00:00:00
864	986	4896	457	1	3	1	0.01	59.00	Entregue	2022-05-29 00:00:00
865	857	4852	457	1	3	1	46.78	27.20	Entregue	2022-04-15 00:00:00
866	619	4877	457	1	3	1	9173.51	55.46	Entregue	2022-05-10 00:00:00
867	890	4684	457	1	3	1	13.51	38.46	Entregue	2021-10-29 00:00:00
868	1214	4824	457	1	3	1	4013.75	46.94	Entregue	2022-03-18 00:00:00
869	20	4900	457	1	3	1	993.16	39.82	Entregue	2022-06-02 00:00:00
870	1394	4896	457	1	3	1	56.37	56.88	Entregue	2022-05-29 00:00:00
871	1341	4512	457	1	3	1	1556.43	24.51	Entregue	2021-05-10 00:00:00
872	1074	4896	457	1	3	1	3823.28	20.16	Entregue	2022-05-29 00:00:00
873	517	4642	457	1	3	1	0.01	62.97	Entregue	2021-09-17 00:00:00
874	1873	4516	457	1	3	1	161.33	24.52	Entregue	2021-05-14 00:00:00
875	1999	4606	457	1	3	1	716.71	31.03	Entregue	2021-08-12 00:00:00
876	1957	4915	457	1	3	1	63.90	20.33	Entregue	2022-06-17 00:00:00
877	1111	4916	457	1	3	1	5016.53	68.28	Entregue	2022-06-18 00:00:00
878	1082	4824	457	1	3	1	14852.58	67.02	Entregue	2022-03-18 00:00:00
879	129	4645	457	1	3	1	1834.84	52.38	Entregue	2021-09-20 00:00:00
880	203	4781	457	1	3	1	24788.86	55.89	Entregue	2022-02-03 00:00:00
881	1838	4411	457	1	3	1	1829.35	27.94	Entregue	2021-01-29 00:00:00
882	1181	4558	457	1	3	1	11722.03	50.53	Entregue	2021-06-25 00:00:00
883	789	4740	457	1	3	1	69.11	54.83	Entregue	2021-12-24 00:00:00
884	1491	4747	457	1	3	1	6179.81	34.93	Entregue	2021-12-31 00:00:00
885	1023	4520	457	1	3	1	189.79	28.70	Entregue	2021-05-18 00:00:00
886	1172	4504	457	1	3	1	0.01	42.34	Entregue	2021-05-02 00:00:00
887	1208	4832	457	1	3	1	5309.04	57.59	Entregue	2022-03-26 00:00:00
888	511	4851	457	1	3	1	3995.32	34.51	Entregue	2022-04-14 00:00:00
889	1351	4785	457	1	3	1	0.01	22.31	Entregue	2022-02-07 00:00:00
890	1660	4849	457	1	3	1	165.02	21.50	Entregue	2022-04-12 00:00:00
891	1183	4388	457	1	3	1	2232.22	45.61	Entregue	2021-01-06 00:00:00
892	1333	4748	457	1	3	1	762.60	58.65	Entregue	2022-01-01 00:00:00
893	1610	4742	457	1	3	1	399.08	45.95	Entregue	2021-12-26 00:00:00
894	1034	4455	457	1	3	1	262.99	42.75	Entregue	2021-03-14 00:00:00
895	943	4875	457	1	3	1	239.08	23.11	Entregue	2022-05-08 00:00:00
896	330	4876	457	1	3	1	5386.07	48.48	Entregue	2022-05-09 00:00:00
897	1903	4744	457	1	3	1	1549.01	58.97	Entregue	2021-12-28 00:00:00
898	1220	4897	457	1	3	1	793.67	35.45	Entregue	2022-05-30 00:00:00
899	451	4899	457	1	3	1	241.33	64.53	Entregue	2022-06-01 00:00:00
900	1466	4759	457	1	3	1	24804.70	39.57	Entregue	2022-01-12 00:00:00
901	323	4820	457	1	3	1	1194.47	33.34	Entregue	2022-03-14 00:00:00
902	348	4582	457	1	3	1	0.01	67.73	Entregue	2021-07-19 00:00:00
903	1634	4870	457	1	3	1	164.55	56.71	Entregue	2022-05-03 00:00:00
904	1363	4876	457	1	3	1	2222.93	37.28	Entregue	2022-05-09 00:00:00
905	112	4442	457	1	3	1	13353.50	51.37	Entregue	2021-03-01 00:00:00
906	560	4490	457	1	3	1	3978.58	67.12	Entregue	2021-04-18 00:00:00
907	1042	4649	457	1	3	1	83.89	49.19	Entregue	2021-09-24 00:00:00
908	613	4555	457	1	3	1	1281.31	66.20	Entregue	2021-06-22 00:00:00
909	268	4705	457	1	3	1	306.82	32.69	Entregue	2021-11-19 00:00:00
910	1745	4706	457	1	3	1	428.22	59.95	Entregue	2021-11-20 00:00:00
911	1404	4478	457	1	3	1	8799.81	67.73	Entregue	2021-04-06 00:00:00
912	615	4676	457	1	3	1	13464.71	64.58	Entregue	2021-10-21 00:00:00
913	830	4415	457	1	3	1	0.01	35.15	Entregue	2021-02-02 00:00:00
914	1545	4498	457	1	3	1	4808.09	40.74	Entregue	2021-04-26 00:00:00
915	1581	4816	457	1	3	1	0.01	39.83	Entregue	2022-03-10 00:00:00
916	1482	4873	457	1	3	1	320.94	69.78	Entregue	2022-05-06 00:00:00
917	1657	4568	457	1	3	1	4225.63	53.07	Entregue	2021-07-05 00:00:00
918	988	4794	457	1	3	1	498.72	33.14	Entregue	2022-02-16 00:00:00
919	1340	4855	457	1	3	1	6225.14	43.13	Entregue	2022-04-18 00:00:00
920	964	4632	457	1	3	1	325.20	40.62	Entregue	2021-09-07 00:00:00
921	601	4876	457	1	3	1	1799.47	60.80	Entregue	2022-05-09 00:00:00
922	590	4582	457	1	3	1	508.05	42.15	Entregue	2021-07-19 00:00:00
923	82	4829	457	1	3	1	693.81	29.52	Entregue	2022-03-23 00:00:00
924	2000	4680	457	1	3	1	3759.41	48.15	Entregue	2021-10-25 00:00:00
925	1396	4495	457	1	3	1	3035.31	36.15	Entregue	2021-04-23 00:00:00
926	1534	4744	457	1	3	1	2147.34	47.61	Entregue	2021-12-28 00:00:00
927	202	4615	457	1	3	1	0.01	52.26	Entregue	2021-08-21 00:00:00
928	610	4873	457	1	3	1	342.61	40.35	Entregue	2022-05-06 00:00:00
929	1425	4411	457	1	3	1	1041.27	69.87	Entregue	2021-01-29 00:00:00
930	678	4427	457	1	3	1	33.07	36.49	Entregue	2021-02-14 00:00:00
931	1906	4640	457	1	3	1	244.01	51.85	Entregue	2021-09-15 00:00:00
932	812	4497	457	1	3	1	234.44	30.81	Entregue	2021-04-25 00:00:00
933	1390	4713	457	1	3	1	75.73	65.90	Entregue	2021-11-27 00:00:00
934	579	4451	457	1	3	1	3629.06	36.71	Entregue	2021-03-10 00:00:00
935	510	4721	457	1	3	1	1541.98	66.25	Entregue	2021-12-05 00:00:00
936	1981	4761	457	1	3	1	0.01	56.56	Entregue	2022-01-14 00:00:00
937	1176	4481	457	1	3	1	4295.96	49.31	Entregue	2021-04-09 00:00:00
938	1186	4573	457	1	3	1	3161.22	49.71	Entregue	2021-07-10 00:00:00
939	198	4823	457	1	3	1	2407.33	39.08	Entregue	2022-03-17 00:00:00
940	212	4906	457	1	3	1	393.54	21.21	Entregue	2022-06-08 00:00:00
941	28	4720	457	1	3	1	4.31	50.32	Entregue	2021-12-04 00:00:00
942	1796	4678	457	1	3	1	1321.35	49.06	Entregue	2021-10-23 00:00:00
943	1089	4398	457	1	3	1	0.01	42.59	Entregue	2021-01-16 00:00:00
944	1380	4735	457	1	3	1	46.26	34.69	Entregue	2021-12-19 00:00:00
945	1656	4747	457	1	3	1	10073.56	53.44	Entregue	2021-12-31 00:00:00
946	1147	4660	457	1	3	1	265.03	55.72	Entregue	2021-10-05 00:00:00
947	720	4896	457	1	3	1	563.36	67.59	Entregue	2022-05-29 00:00:00
948	917	4821	457	1	3	1	62.00	31.29	Entregue	2022-03-15 00:00:00
949	489	4679	457	1	3	1	3450.27	64.15	Entregue	2021-10-24 00:00:00
950	1605	4722	457	1	3	1	2552.13	38.52	Entregue	2021-12-06 00:00:00
951	1555	4605	457	1	3	1	41.17	47.01	Entregue	2021-08-11 00:00:00
952	515	4867	457	1	3	1	3890.62	33.27	Entregue	2022-04-30 00:00:00
953	1256	4522	457	1	3	1	11296.84	69.10	Entregue	2021-05-20 00:00:00
954	1000	4645	457	1	3	1	347.84	53.08	Entregue	2021-09-20 00:00:00
955	706	4759	457	1	3	1	2244.87	53.40	Entregue	2022-01-12 00:00:00
956	1230	4823	457	1	3	1	633.51	59.11	Entregue	2022-03-17 00:00:00
957	571	4823	457	1	3	1	0.01	60.43	Entregue	2022-03-17 00:00:00
958	1423	4552	457	1	3	1	0.01	44.86	Entregue	2021-06-19 00:00:00
959	956	4629	457	1	3	1	251.66	65.93	Entregue	2021-09-04 00:00:00
960	666	4413	457	1	3	1	4760.10	24.53	Entregue	2021-01-31 00:00:00
961	216	4676	457	1	3	1	2344.30	30.19	Entregue	2021-10-21 00:00:00
962	958	4850	457	1	3	1	801.65	21.46	Entregue	2022-04-13 00:00:00
963	295	4886	457	1	3	1	136.98	68.42	Entregue	2022-05-19 00:00:00
964	1730	4740	457	1	3	1	2488.23	47.90	Entregue	2021-12-24 00:00:00
965	1655	4660	457	1	3	1	4977.11	23.52	Entregue	2021-10-05 00:00:00
966	694	4442	457	1	3	1	1836.13	67.32	Entregue	2021-03-01 00:00:00
967	213	4798	457	1	3	1	2325.17	52.18	Entregue	2022-02-20 00:00:00
968	1114	4428	457	1	3	1	2606.90	40.91	Entregue	2021-02-15 00:00:00
969	833	4668	457	1	3	1	722.44	48.45	Entregue	2021-10-13 00:00:00
970	1244	4781	457	1	3	1	16744.67	21.72	Entregue	2022-02-03 00:00:00
971	752	4551	457	1	3	1	7208.63	54.66	Entregue	2021-06-18 00:00:00
972	1013	4792	457	1	3	1	1096.75	20.52	Entregue	2022-02-14 00:00:00
973	1760	4432	457	1	3	1	792.74	25.11	Entregue	2021-02-19 00:00:00
974	1553	4658	457	1	3	1	3.42	51.48	Entregue	2021-10-03 00:00:00
975	594	4878	457	1	3	1	9496.31	61.89	Entregue	2022-05-11 00:00:00
976	460	4580	457	1	3	1	6528.95	50.24	Entregue	2021-07-17 00:00:00
977	499	4501	457	1	3	1	0.01	36.55	Entregue	2021-04-29 00:00:00
978	265	4550	457	1	3	1	4813.56	55.32	Entregue	2021-06-17 00:00:00
979	1839	4696	457	1	3	1	0.01	43.14	Entregue	2021-11-10 00:00:00
980	1530	4878	457	1	3	1	529.66	53.03	Entregue	2022-05-11 00:00:00
981	851	4846	457	1	3	1	0.01	28.27	Entregue	2022-04-09 00:00:00
982	62	4434	457	1	3	1	4962.47	53.88	Entregue	2021-02-21 00:00:00
983	893	4688	457	1	3	1	137.31	69.71	Entregue	2021-11-02 00:00:00
984	1318	4660	457	1	3	1	735.31	62.92	Entregue	2021-10-05 00:00:00
985	993	4428	457	1	3	1	1965.94	62.49	Entregue	2021-02-15 00:00:00
986	568	4570	457	1	3	1	1016.86	59.88	Entregue	2021-07-07 00:00:00
987	805	4752	457	1	3	1	0.01	26.32	Entregue	2022-01-05 00:00:00
988	1822	4537	457	1	3	1	2792.26	24.96	Entregue	2021-06-04 00:00:00
989	1139	4405	457	1	3	1	794.61	46.03	Entregue	2021-01-23 00:00:00
990	413	4740	457	1	3	1	261.05	22.57	Entregue	2021-12-24 00:00:00
991	649	4413	457	1	3	1	12381.98	62.22	Entregue	2021-01-31 00:00:00
992	100	4750	457	1	3	1	1440.95	44.06	Entregue	2022-01-03 00:00:00
993	1223	4640	457	1	3	1	7163.13	26.97	Entregue	2021-09-15 00:00:00
994	925	4785	457	1	3	1	179.78	54.27	Entregue	2022-02-07 00:00:00
995	1342	4592	457	1	3	1	911.22	30.74	Entregue	2021-07-29 00:00:00
996	421	4624	457	1	3	1	0.01	65.60	Entregue	2021-08-30 00:00:00
997	429	4793	457	1	3	1	1662.34	59.36	Entregue	2022-02-15 00:00:00
998	1498	4433	457	1	3	1	298.01	25.78	Entregue	2021-02-20 00:00:00
999	835	4676	457	1	3	1	1737.61	38.87	Entregue	2021-10-21 00:00:00
1000	25	4896	457	1	3	1	0.01	20.76	Entregue	2022-05-29 00:00:00
1001	141	4537	457	1	3	1	204.32	51.42	Entregue	2021-06-04 00:00:00
1002	1026	4635	457	1	3	1	0.01	35.22	Entregue	2021-09-10 00:00:00
1003	434	4582	457	1	3	1	1918.15	65.27	Entregue	2021-07-19 00:00:00
1004	211	4636	457	1	3	1	93.61	26.00	Entregue	2021-09-11 00:00:00
1005	1420	4495	457	1	3	1	4341.86	35.89	Entregue	2021-04-23 00:00:00
1006	1320	4551	457	1	3	1	259.07	64.37	Entregue	2021-06-18 00:00:00
1007	1191	4631	457	1	3	1	13685.57	50.48	Entregue	2021-09-06 00:00:00
1008	901	4691	457	1	3	1	5533.31	41.85	Entregue	2021-11-05 00:00:00
1009	465	4875	457	1	3	1	0.01	26.65	Entregue	2022-05-08 00:00:00
1010	449	4428	457	1	3	1	3544.92	64.47	Entregue	2021-02-15 00:00:00
1011	1853	4485	457	1	3	1	5809.37	26.90	Entregue	2021-04-13 00:00:00
1012	64	4838	457	1	3	1	6662.80	64.42	Entregue	2022-04-01 00:00:00
1013	1421	4829	457	1	3	1	0.01	69.83	Entregue	2022-03-23 00:00:00
1014	828	4883	457	1	3	1	16.23	56.50	Entregue	2022-05-16 00:00:00
1015	1989	4795	457	1	3	1	2503.08	35.22	Entregue	2022-02-17 00:00:00
1016	1587	4747	457	1	3	1	4902.32	35.12	Entregue	2021-12-31 00:00:00
1017	1091	4577	457	1	3	1	1229.09	21.64	Entregue	2021-07-14 00:00:00
1018	839	4830	457	1	3	1	3722.06	53.66	Entregue	2022-03-24 00:00:00
1019	1075	4862	457	1	3	1	2211.12	51.74	Entregue	2022-04-25 00:00:00
1020	539	4831	457	1	3	1	337.59	54.43	Entregue	2022-03-25 00:00:00
1021	1108	4437	457	1	3	1	1066.03	37.85	Entregue	2021-02-24 00:00:00
1022	1128	4758	457	1	3	1	123.63	69.20	Entregue	2022-01-11 00:00:00
1023	1284	4489	457	1	3	1	200.96	61.64	Entregue	2021-04-17 00:00:00
1024	874	4620	457	1	3	1	1157.73	64.52	Entregue	2021-08-26 00:00:00
1025	1899	4509	457	1	3	1	197.92	64.05	Entregue	2021-05-07 00:00:00
1026	278	4649	457	1	3	1	0.01	46.54	Entregue	2021-09-24 00:00:00
1027	1691	4685	457	1	3	1	2442.01	69.54	Entregue	2021-10-30 00:00:00
1028	946	4888	457	1	3	1	183.17	67.92	Entregue	2022-05-21 00:00:00
1029	1494	4800	457	1	3	1	3715.05	50.89	Entregue	2022-02-22 00:00:00
1030	1045	4413	457	1	3	1	3980.51	48.83	Entregue	2021-01-31 00:00:00
1031	1307	4720	457	1	3	1	1208.34	56.70	Entregue	2021-12-04 00:00:00
1032	770	4595	457	1	3	1	6156.98	31.76	Entregue	2021-08-01 00:00:00
1033	271	4828	457	1	3	1	73.17	33.27	Entregue	2022-03-22 00:00:00
1034	22	4774	457	1	3	1	18787.20	60.45	Entregue	2022-01-27 00:00:00
1035	1883	4809	457	1	3	1	6715.05	40.69	Entregue	2022-03-03 00:00:00
1036	1558	4595	457	1	3	1	370.24	63.00	Entregue	2021-08-01 00:00:00
1037	417	4478	457	1	3	1	1106.90	43.32	Entregue	2021-04-06 00:00:00
1038	1175	4738	457	1	3	1	2010.95	65.18	Entregue	2021-12-22 00:00:00
1039	529	4600	457	1	3	1	1757.97	45.03	Entregue	2021-08-06 00:00:00
1040	791	4858	457	1	3	1	20.07	43.83	Entregue	2022-04-21 00:00:00
1041	775	4839	457	1	3	1	52.60	61.40	Entregue	2022-04-02 00:00:00
1042	1830	4544	457	1	3	1	11605.58	45.74	Entregue	2021-06-11 00:00:00
1043	390	4837	457	1	3	1	343.24	21.05	Entregue	2022-03-31 00:00:00
1044	1018	4503	457	1	3	1	191.14	58.31	Entregue	2021-05-01 00:00:00
1045	1833	4518	457	1	3	1	197.91	49.10	Entregue	2021-05-16 00:00:00
1046	1263	4903	457	1	3	1	698.56	64.86	Entregue	2022-06-05 00:00:00
1047	189	4831	457	1	3	1	5959.62	20.80	Entregue	2022-03-25 00:00:00
1048	1682	4721	457	1	3	1	3549.37	24.01	Entregue	2021-12-05 00:00:00
1049	1431	4878	457	1	3	1	3911.22	66.84	Entregue	2022-05-11 00:00:00
1050	120	4518	457	1	3	1	6524.84	48.87	Entregue	2021-05-16 00:00:00
1051	1289	4518	457	1	3	1	0.01	62.88	Entregue	2021-05-16 00:00:00
1052	802	4694	457	1	3	1	1864.48	46.59	Entregue	2021-11-08 00:00:00
1053	578	4590	457	1	3	1	24857.51	40.13	Entregue	2021-07-27 00:00:00
1054	695	4888	457	1	3	1	0.01	54.15	Entregue	2022-05-21 00:00:00
1055	1415	4856	457	1	3	1	3327.34	36.61	Entregue	2022-04-19 00:00:00
1056	794	4815	457	1	3	1	0.85	40.93	Entregue	2022-03-09 00:00:00
1057	1510	4436	457	1	3	1	1586.21	24.54	Entregue	2021-02-23 00:00:00
1058	1749	4425	457	1	3	1	2321.63	27.81	Entregue	2021-02-12 00:00:00
1059	1368	4818	457	1	3	1	4559.11	64.60	Entregue	2022-03-12 00:00:00
1060	508	4884	457	1	3	1	7975.08	32.89	Entregue	2022-05-17 00:00:00
1061	1692	4905	457	1	3	1	1423.23	26.97	Entregue	2022-06-07 00:00:00
1062	1194	4795	457	1	3	1	742.78	57.79	Entregue	2022-02-17 00:00:00
1063	1705	4914	457	1	3	1	2389.70	25.62	Entregue	2022-06-16 00:00:00
1064	1463	4722	457	1	3	1	5847.87	59.01	Entregue	2021-12-06 00:00:00
1065	1829	4479	457	1	3	1	1304.39	66.72	Entregue	2021-04-07 00:00:00
1066	315	4666	457	1	3	1	1103.98	58.33	Entregue	2021-10-11 00:00:00
1067	1162	4913	457	1	3	1	384.90	51.98	Entregue	2022-06-15 00:00:00
1068	1841	4797	457	1	3	1	1527.14	65.34	Entregue	2022-02-19 00:00:00
1069	841	4638	457	1	3	1	5532.88	25.06	Entregue	2021-09-13 00:00:00
1070	1030	4394	457	1	3	1	1266.38	43.91	Entregue	2021-01-12 00:00:00
1071	1694	4527	457	1	3	1	408.11	42.42	Entregue	2021-05-25 00:00:00
1072	1614	4474	457	1	3	1	1581.54	60.67	Entregue	2021-04-02 00:00:00
1073	1239	4530	457	1	3	1	8676.46	47.13	Entregue	2021-05-28 00:00:00
1074	803	4488	457	1	3	1	6687.24	55.78	Entregue	2021-04-16 00:00:00
1075	54	4698	457	1	3	1	0.01	64.68	Entregue	2021-11-12 00:00:00
1076	181	4624	457	1	3	1	58.84	56.26	Entregue	2021-08-30 00:00:00
1077	35	4537	457	1	3	1	1988.09	48.14	Entregue	2021-06-04 00:00:00
1078	1755	4647	457	1	3	1	9681.13	42.51	Entregue	2021-09-22 00:00:00
1079	963	4677	457	1	3	1	0.01	63.22	Entregue	2021-10-22 00:00:00
1080	220	4762	457	1	3	1	456.63	47.08	Entregue	2022-01-15 00:00:00
1081	1913	4504	457	1	3	1	607.22	60.09	Entregue	2021-05-02 00:00:00
1082	1278	4819	457	1	3	1	145.63	34.39	Entregue	2022-03-13 00:00:00
1083	400	4681	457	1	3	1	339.55	24.71	Entregue	2021-10-26 00:00:00
1084	1007	4761	457	1	3	1	13309.04	36.39	Entregue	2022-01-14 00:00:00
1085	285	4772	457	1	3	1	5832.46	49.33	Entregue	2022-01-25 00:00:00
1086	1880	4568	457	1	3	1	0.01	25.22	Entregue	2021-07-05 00:00:00
1087	1266	4779	457	1	3	1	201.04	38.40	Entregue	2022-02-01 00:00:00
1088	391	4570	457	1	3	1	970.19	31.06	Entregue	2021-07-07 00:00:00
1089	1922	4708	457	1	3	1	0.01	42.46	Entregue	2021-11-22 00:00:00
1090	487	4646	457	1	3	1	1059.87	25.15	Entregue	2021-09-21 00:00:00
1091	1718	4545	457	1	3	1	2254.85	21.73	Entregue	2021-06-12 00:00:00
1092	1664	4456	457	1	3	1	2685.14	69.15	Entregue	2021-03-15 00:00:00
1093	1190	4708	457	1	3	1	2773.98	33.34	Entregue	2021-11-22 00:00:00
1094	714	4654	457	1	3	1	8013.08	34.43	Entregue	2021-09-29 00:00:00
1095	1920	4621	457	1	3	1	0.01	45.36	Entregue	2021-08-27 00:00:00
1096	906	4394	457	1	3	1	760.12	69.07	Entregue	2021-01-12 00:00:00
1097	1321	4518	457	1	3	1	2920.73	65.75	Entregue	2021-05-16 00:00:00
1098	909	4590	457	1	3	1	2726.23	50.81	Entregue	2021-07-27 00:00:00
1099	745	4466	457	1	3	1	556.26	69.45	Entregue	2021-03-25 00:00:00
1100	152	4834	457	1	3	1	4684.47	61.69	Entregue	2022-03-28 00:00:00
1101	1216	4455	457	1	3	1	495.62	64.51	Entregue	2021-03-14 00:00:00
1102	1685	4625	457	1	3	1	0.01	57.89	Entregue	2021-08-31 00:00:00
1103	1049	4797	457	1	3	1	15135.09	53.26	Entregue	2022-02-19 00:00:00
1104	428	4520	457	1	3	1	3714.70	64.53	Entregue	2021-05-18 00:00:00
1105	1786	4537	457	1	3	1	487.93	28.09	Entregue	2021-06-04 00:00:00
1106	747	4854	457	1	3	1	399.42	62.40	Entregue	2022-04-17 00:00:00
1107	1324	4629	457	1	3	1	0.01	61.44	Entregue	2021-09-04 00:00:00
1108	1008	4849	457	1	3	1	0.01	68.94	Entregue	2022-04-12 00:00:00
1109	777	4479	457	1	3	1	6773.78	63.90	Entregue	2021-04-07 00:00:00
1110	164	4760	457	1	3	1	4317.19	42.03	Entregue	2022-01-13 00:00:00
1111	1098	4816	457	1	3	1	271.77	32.88	Entregue	2022-03-10 00:00:00
1112	1325	4829	457	1	3	1	1462.82	21.71	Entregue	2022-03-23 00:00:00
1113	186	4573	457	1	3	1	1062.80	29.48	Entregue	2021-07-10 00:00:00
1114	1929	4665	457	1	3	1	108.26	20.09	Entregue	2021-10-10 00:00:00
1115	1548	4774	457	1	3	1	826.23	68.75	Entregue	2022-01-27 00:00:00
1116	501	4876	457	1	3	1	528.63	54.35	Entregue	2022-05-09 00:00:00
1117	750	4534	457	1	3	1	65.57	26.55	Entregue	2021-06-01 00:00:00
1118	1952	4851	457	1	3	1	271.00	32.20	Entregue	2022-04-14 00:00:00
1119	1679	4623	457	1	3	1	98.44	33.26	Entregue	2021-08-29 00:00:00
1120	545	4675	457	1	3	1	2220.31	44.84	Entregue	2021-10-20 00:00:00
1121	977	4587	457	1	3	1	665.09	43.31	Entregue	2021-07-24 00:00:00
1122	18	4408	457	1	3	1	1792.63	65.34	Entregue	2021-01-26 00:00:00
1123	1507	4737	457	1	3	1	226.80	25.07	Entregue	2021-12-21 00:00:00
1124	1900	4560	457	1	3	1	4310.94	45.82	Entregue	2021-06-27 00:00:00
1125	27	4768	457	1	3	1	161.35	27.76	Entregue	2022-01-21 00:00:00
1126	1959	4546	457	1	3	1	7327.99	61.34	Entregue	2021-06-13 00:00:00
1127	143	4706	457	1	3	1	250.58	21.06	Entregue	2021-11-20 00:00:00
1128	1907	4791	457	1	3	1	238.05	32.03	Entregue	2022-02-13 00:00:00
1129	496	4632	457	1	3	1	2162.72	24.05	Entregue	2021-09-07 00:00:00
1130	1762	4892	457	1	3	1	874.00	48.60	Entregue	2022-05-25 00:00:00
1131	58	4771	457	1	3	1	484.29	32.46	Entregue	2022-01-24 00:00:00
1132	228	4678	457	1	3	1	103.63	33.94	Entregue	2021-10-23 00:00:00
1133	1845	4899	457	1	3	1	0.01	34.84	Entregue	2022-06-01 00:00:00
1134	814	4573	457	1	3	1	387.80	52.17	Entregue	2021-07-10 00:00:00
1135	668	4865	457	1	3	1	869.43	40.16	Entregue	2022-04-28 00:00:00
1136	850	4891	457	1	3	1	652.04	29.03	Entregue	2022-05-24 00:00:00
1137	294	4425	457	1	3	1	27.44	51.33	Entregue	2021-02-12 00:00:00
1138	1800	4564	457	1	3	1	3411.35	23.18	Entregue	2021-07-01 00:00:00
1139	1629	4658	457	1	3	1	2378.99	32.71	Entregue	2021-10-03 00:00:00
1140	926	4740	457	1	3	1	297.54	35.38	Entregue	2021-12-24 00:00:00
1141	645	4531	457	1	3	1	0.01	68.46	Entregue	2021-05-29 00:00:00
1142	1009	4618	457	1	3	1	767.61	34.67	Entregue	2021-08-24 00:00:00
1143	1460	4640	457	1	3	1	236.49	57.52	Entregue	2021-09-15 00:00:00
1144	607	4795	457	1	3	1	105.30	55.83	Entregue	2022-02-17 00:00:00
1145	258	4744	457	1	3	1	2413.29	63.98	Entregue	2021-12-28 00:00:00
1146	1546	4859	457	1	3	1	65.27	54.20	Entregue	2022-04-22 00:00:00
1147	483	4772	457	1	3	1	742.73	42.33	Entregue	2022-01-25 00:00:00
1148	1816	4398	457	1	3	1	0.01	26.62	Entregue	2021-01-16 00:00:00
1149	1708	4886	457	1	3	1	2850.03	53.50	Entregue	2022-05-19 00:00:00
1150	1619	4837	457	1	3	1	6525.91	60.19	Entregue	2022-03-31 00:00:00
1151	84	4489	457	1	3	1	2720.18	68.22	Entregue	2021-04-17 00:00:00
1152	1836	4429	457	1	3	1	8653.88	37.45	Entregue	2021-02-16 00:00:00
1153	1877	4498	457	1	3	1	3131.58	50.97	Entregue	2021-04-26 00:00:00
1154	646	4459	457	1	3	1	319.65	36.86	Entregue	2021-03-18 00:00:00
1155	1815	4794	457	1	3	1	1682.24	58.67	Entregue	2022-02-16 00:00:00
1156	1259	4411	457	1	3	1	182.85	48.64	Entregue	2021-01-29 00:00:00
1157	379	4886	457	1	3	1	467.68	36.81	Entregue	2022-05-19 00:00:00
1158	320	4832	457	1	3	1	1683.49	59.71	Entregue	2022-03-26 00:00:00
1159	1062	4546	457	1	3	1	751.85	34.93	Entregue	2021-06-13 00:00:00
1160	942	4498	457	1	3	1	1816.78	59.47	Entregue	2021-04-26 00:00:00
1161	115	4721	457	1	3	1	1339.37	32.17	Entregue	2021-12-05 00:00:00
1162	1458	4545	457	1	3	1	234.95	54.56	Entregue	2021-06-12 00:00:00
1163	108	4867	457	1	3	1	0.01	50.60	Entregue	2022-04-30 00:00:00
1164	59	4515	457	1	3	1	1755.09	37.52	Entregue	2021-05-13 00:00:00
1165	1862	4385	457	1	3	1	6794.02	33.48	Entregue	2021-01-03 00:00:00
1166	1535	4577	457	1	3	1	363.09	69.73	Entregue	2021-07-14 00:00:00
1167	127	4501	457	1	3	1	0.01	62.78	Entregue	2021-04-29 00:00:00
1168	1697	4773	457	1	3	1	18664.69	68.89	Entregue	2022-01-26 00:00:00
1169	1285	4620	457	1	3	1	1879.32	38.54	Entregue	2021-08-26 00:00:00
1170	1924	4460	457	1	3	1	2869.91	26.33	Entregue	2021-03-19 00:00:00
1171	1447	4699	457	1	3	1	92.12	26.39	Entregue	2021-11-13 00:00:00
1172	1866	4708	457	1	3	1	1272.13	47.46	Entregue	2021-11-22 00:00:00
1173	676	4849	457	1	3	1	0.01	62.52	Entregue	2022-04-12 00:00:00
1174	153	4457	457	1	3	1	1146.49	52.93	Entregue	2021-03-16 00:00:00
1175	778	4743	457	1	3	1	3506.60	61.85	Entregue	2021-12-27 00:00:00
1176	214	4412	457	1	3	1	227.38	30.13	Entregue	2021-01-30 00:00:00
1177	1753	4915	457	1	3	1	5655.01	48.46	Entregue	2022-06-17 00:00:00
1178	1170	4609	457	1	3	1	0.01	58.19	Entregue	2021-08-15 00:00:00
1179	532	4466	457	1	3	1	2710.97	49.04	Entregue	2021-03-25 00:00:00
1180	945	4859	457	1	3	1	4219.51	55.02	Entregue	2022-04-22 00:00:00
1181	1371	4616	457	1	3	1	691.28	49.02	Entregue	2021-08-22 00:00:00
1182	1951	4437	457	1	3	1	597.11	67.26	Entregue	2021-02-24 00:00:00
1183	259	4826	457	1	3	1	1819.69	52.88	Entregue	2022-03-20 00:00:00
1184	1203	4877	457	1	3	1	11265.14	53.02	Entregue	2022-05-10 00:00:00
1185	1915	4760	457	1	3	1	34.66	68.36	Entregue	2022-01-13 00:00:00
1186	840	4772	457	1	3	1	0.01	30.88	Entregue	2022-01-25 00:00:00
1187	1378	4410	457	1	3	1	1580.98	37.12	Entregue	2021-01-28 00:00:00
1188	1038	4428	457	1	3	1	5748.86	63.24	Entregue	2021-02-15 00:00:00
1189	3	4686	457	1	3	1	385.64	53.56	Entregue	2021-10-31 00:00:00
1190	324	4412	457	1	3	1	4816.84	33.82	Entregue	2021-01-30 00:00:00
1191	921	4646	457	1	3	1	89.33	47.22	Entregue	2021-09-21 00:00:00
1192	1227	4677	457	1	3	1	207.94	23.59	Entregue	2021-10-22 00:00:00
1193	1923	4896	457	1	3	1	329.45	48.70	Entregue	2022-05-29 00:00:00
1194	1780	4512	457	1	3	1	1208.95	40.36	Entregue	2021-05-10 00:00:00
1195	1295	4458	457	1	3	1	101.07	39.78	Entregue	2021-03-17 00:00:00
1196	1126	4697	457	1	3	1	3959.79	41.88	Entregue	2021-11-11 00:00:00
1197	1217	4425	457	1	3	1	1546.08	56.74	Entregue	2021-02-12 00:00:00
1198	984	4724	457	1	3	1	1252.29	59.46	Entregue	2021-12-08 00:00:00
1199	1249	4607	457	1	3	1	120.92	24.30	Entregue	2021-08-13 00:00:00
1200	868	4845	457	1	3	1	284.00	39.49	Entregue	2022-04-08 00:00:00
1201	418	4531	457	1	3	1	631.42	20.02	Entregue	2021-05-29 00:00:00
1202	1870	4699	457	1	3	1	215.94	38.79	Entregue	2021-11-13 00:00:00
1203	1524	4831	457	1	3	1	1186.74	56.88	Entregue	2022-03-25 00:00:00
1204	1229	4679	457	1	3	1	1961.72	28.14	Entregue	2021-10-24 00:00:00
1205	978	4518	457	1	3	1	621.64	41.83	Entregue	2021-05-16 00:00:00
1206	407	4895	457	1	3	1	2749.01	67.18	Entregue	2022-05-28 00:00:00
1207	387	4616	457	1	3	1	0.01	61.83	Entregue	2021-08-22 00:00:00
1208	1337	4481	457	1	3	1	142.60	39.03	Entregue	2021-04-09 00:00:00
1209	39	4408	457	1	3	1	819.11	46.23	Entregue	2021-01-26 00:00:00
1210	690	4422	457	1	3	1	183.59	65.36	Entregue	2021-02-09 00:00:00
1211	1477	4684	457	1	3	1	4514.99	52.16	Entregue	2021-10-29 00:00:00
1212	1209	4738	457	1	3	1	19847.51	28.98	Entregue	2021-12-22 00:00:00
1213	1837	4916	457	1	3	1	3068.03	39.94	Entregue	2022-06-18 00:00:00
1214	1569	4813	457	1	3	1	2523.17	29.53	Entregue	2022-03-07 00:00:00
1215	1674	4912	457	1	3	1	4143.38	66.67	Entregue	2022-06-14 00:00:00
1216	683	4589	457	1	3	1	2848.53	27.92	Entregue	2021-07-26 00:00:00
1217	793	4582	457	1	3	1	600.72	44.07	Entregue	2021-07-19 00:00:00
1218	608	4589	457	1	3	1	6971.26	44.79	Entregue	2021-07-26 00:00:00
1219	317	4558	457	1	3	1	402.49	33.71	Entregue	2021-06-25 00:00:00
1220	702	4569	457	1	3	1	398.31	31.73	Entregue	2021-07-06 00:00:00
1221	126	4685	457	1	3	1	2602.78	41.26	Entregue	2021-10-30 00:00:00
1222	194	4466	457	1	3	1	3436.48	57.96	Entregue	2021-03-25 00:00:00
1223	1620	4819	457	1	3	1	276.53	51.24	Entregue	2022-03-13 00:00:00
1224	463	4623	457	1	3	1	3500.15	20.93	Entregue	2021-08-29 00:00:00
1225	1570	4427	457	1	3	1	11742.59	59.12	Entregue	2021-02-14 00:00:00
1226	476	4838	457	1	3	1	13459.92	66.76	Entregue	2022-04-01 00:00:00
1227	883	4643	457	1	3	1	0.01	69.15	Entregue	2021-09-18 00:00:00
1228	1887	4821	457	1	3	1	2366.79	63.03	Entregue	2022-03-15 00:00:00
1229	374	4491	457	1	3	1	7193.85	55.73	Entregue	2021-04-19 00:00:00
1230	1146	4391	457	1	3	1	5252.45	66.64	Entregue	2021-01-09 00:00:00
1231	1544	4661	457	1	3	1	1436.28	42.57	Entregue	2021-10-06 00:00:00
1232	1632	4620	457	1	3	1	232.40	67.78	Entregue	2021-08-26 00:00:00
1233	1210	4633	457	1	3	1	4527.61	32.76	Entregue	2021-09-08 00:00:00
1234	224	4607	457	1	3	1	2442.49	62.94	Entregue	2021-08-13 00:00:00
1235	719	4396	457	1	3	1	251.33	67.73	Entregue	2021-01-14 00:00:00
1236	756	4916	457	1	3	1	8333.12	50.60	Entregue	2022-06-18 00:00:00
1237	318	4888	457	1	3	1	14906.20	58.99	Entregue	2022-05-21 00:00:00
1238	1665	4791	457	1	3	1	9254.38	26.86	Entregue	2022-02-13 00:00:00
1239	933	4457	457	1	3	1	237.23	40.62	Entregue	2021-03-16 00:00:00
1240	647	4740	457	1	3	1	155.18	59.23	Entregue	2021-12-24 00:00:00
1241	1296	4792	457	1	3	1	33.91	24.81	Entregue	2022-02-14 00:00:00
1242	593	4895	457	1	3	1	154.47	65.41	Entregue	2022-05-28 00:00:00
1243	293	4846	457	1	3	1	305.15	48.48	Entregue	2022-04-09 00:00:00
1244	1808	4811	457	1	3	1	7303.44	22.58	Entregue	2022-03-05 00:00:00
1245	1120	4578	457	1	3	1	11607.12	66.61	Entregue	2021-07-15 00:00:00
1246	495	4524	457	1	3	1	0.01	60.69	Entregue	2021-05-22 00:00:00
1247	1257	4784	457	1	3	1	5982.52	39.67	Entregue	2022-02-06 00:00:00
1248	154	4837	457	1	3	1	0.01	48.93	Entregue	2022-03-31 00:00:00
1249	657	4691	457	1	3	1	176.09	53.93	Entregue	2021-11-05 00:00:00
1250	234	4624	457	1	3	1	161.95	34.35	Entregue	2021-08-30 00:00:00
1251	1645	4792	457	1	3	1	2241.09	26.02	Entregue	2022-02-14 00:00:00
1252	1306	4476	457	1	3	1	3854.48	34.56	Entregue	2021-04-04 00:00:00
1253	474	4563	457	1	3	1	3774.84	31.93	Entregue	2021-06-30 00:00:00
1254	1961	4608	457	1	3	1	1554.35	41.67	Entregue	2021-08-14 00:00:00
1255	748	4385	457	1	3	1	3743.36	30.30	Entregue	2021-01-03 00:00:00
1256	1666	4579	457	1	3	1	5653.78	23.94	Entregue	2021-07-16 00:00:00
1257	1910	4495	457	1	3	1	5600.88	32.59	Entregue	2021-04-23 00:00:00
1258	1179	4573	457	1	3	1	763.44	35.01	Entregue	2021-07-10 00:00:00
1259	1847	4584	457	1	3	1	1159.62	37.33	Entregue	2021-07-21 00:00:00
1260	1700	4672	457	1	3	1	104.72	45.18	Entregue	2021-10-17 00:00:00
1261	351	4535	457	1	3	1	137.83	55.28	Entregue	2021-06-02 00:00:00
1262	116	4460	457	1	3	1	2564.97	64.84	Entregue	2021-03-19 00:00:00
1263	1791	4853	457	1	3	1	819.43	25.98	Entregue	2022-04-16 00:00:00
1264	1810	4555	457	1	3	1	8.97	68.09	Entregue	2021-06-22 00:00:00
1265	1733	4684	457	1	3	1	0.01	49.44	Entregue	2021-10-29 00:00:00
1266	970	4697	457	1	3	1	200.85	47.53	Entregue	2021-11-11 00:00:00
1267	1974	4615	457	1	3	1	2722.55	53.57	Entregue	2021-08-21 00:00:00
1268	1977	4811	457	1	3	1	382.60	28.79	Entregue	2022-03-05 00:00:00
1269	732	4675	457	1	3	1	0.01	37.89	Entregue	2021-10-20 00:00:00
1270	1711	4451	457	1	3	1	368.94	20.57	Entregue	2021-03-10 00:00:00
1271	1856	4550	457	1	3	1	0.01	68.53	Entregue	2021-06-17 00:00:00
1272	1627	4897	457	1	3	1	182.90	67.47	Entregue	2022-05-30 00:00:00
1273	734	4614	457	1	3	1	1932.50	50.78	Entregue	2021-08-20 00:00:00
1274	1767	4850	457	1	3	1	75.99	53.06	Entregue	2022-04-13 00:00:00
1275	1272	4625	457	1	3	1	7.90	40.40	Entregue	2021-08-31 00:00:00
1276	1563	4826	457	1	3	1	65.23	36.43	Entregue	2022-03-20 00:00:00
1277	1567	4510	457	1	3	1	5.58	45.47	Entregue	2021-05-08 00:00:00
1278	180	4800	457	1	3	1	0.01	27.47	Entregue	2022-02-22 00:00:00
1279	1219	4900	457	1	3	1	41.86	56.68	Entregue	2022-06-02 00:00:00
1280	967	4421	457	1	3	1	11162.36	62.25	Entregue	2021-02-08 00:00:00
1281	1827	4678	457	1	3	1	1759.41	25.95	Entregue	2021-10-23 00:00:00
1282	626	4843	457	1	3	1	1174.56	48.16	Entregue	2022-04-06 00:00:00
1283	263	4521	457	1	3	1	0.01	47.01	Entregue	2021-05-19 00:00:00
1284	836	4775	457	1	3	1	168.13	41.71	Entregue	2022-01-28 00:00:00
1285	784	4681	457	1	3	1	915.43	66.47	Entregue	2021-10-26 00:00:00
1286	1571	4648	457	1	3	1	0.01	62.92	Entregue	2021-09-23 00:00:00
1287	470	4515	457	1	3	1	1138.54	30.89	Entregue	2021-05-13 00:00:00
1288	1565	4800	457	1	3	1	12373.42	61.59	Entregue	2022-02-22 00:00:00
1289	780	4825	457	1	3	1	43.01	40.22	Entregue	2022-03-19 00:00:00
1290	1668	4833	457	1	3	1	562.63	26.64	Entregue	2022-03-27 00:00:00
1291	478	4651	457	1	3	1	12954.76	59.79	Entregue	2021-09-26 00:00:00
1292	1301	4888	457	1	3	1	5816.83	23.62	Entregue	2022-05-21 00:00:00
1293	577	4636	457	1	3	1	0.01	62.62	Entregue	2021-09-11 00:00:00
1294	505	4659	457	1	3	1	0.01	63.69	Entregue	2021-10-04 00:00:00
1295	1057	4397	457	1	3	1	0.01	48.85	Entregue	2021-01-15 00:00:00
1296	328	4724	457	1	3	1	114.77	33.42	Entregue	2021-12-08 00:00:00
1297	717	4518	457	1	3	1	1187.35	62.25	Entregue	2021-05-16 00:00:00
1298	525	4669	457	1	3	1	0.01	36.50	Entregue	2021-10-14 00:00:00
1299	634	4689	457	1	3	1	3093.80	37.12	Entregue	2021-11-03 00:00:00
1300	1771	4722	457	1	3	1	0.01	53.23	Entregue	2021-12-06 00:00:00
1301	1938	4605	457	1	3	1	1375.21	45.14	Entregue	2021-08-11 00:00:00
1302	210	4668	457	1	3	1	10154.53	27.79	Entregue	2021-10-13 00:00:00
1303	710	4589	457	1	3	1	662.52	27.80	Entregue	2021-07-26 00:00:00
1304	48	4531	457	1	3	1	16720.63	47.96	Entregue	2021-05-29 00:00:00
1305	1016	4841	457	1	3	1	2595.28	38.91	Entregue	2022-04-04 00:00:00
1306	1015	4391	457	1	3	1	13893.07	43.70	Entregue	2021-01-09 00:00:00
1307	1661	4554	457	1	3	1	2006.27	51.82	Entregue	2021-06-21 00:00:00
1308	954	4914	457	1	3	1	1349.72	24.55	Entregue	2022-06-16 00:00:00
1309	1218	4774	457	1	3	1	597.79	50.59	Entregue	2022-01-27 00:00:00
1310	1077	4592	457	1	3	1	0.01	40.80	Entregue	2021-07-29 00:00:00
1311	456	4821	457	1	3	1	12946.15	33.96	Entregue	2022-03-15 00:00:00
1312	796	4915	457	1	3	1	10.42	43.90	Entregue	2022-06-17 00:00:00
1313	1896	4445	457	1	3	1	62.73	25.39	Entregue	2021-03-04 00:00:00
1314	1281	4433	457	1	3	1	787.47	51.47	Entregue	2021-02-20 00:00:00
1315	1247	4654	457	1	3	1	153.68	42.00	Entregue	2021-09-29 00:00:00
1316	531	4796	457	1	3	1	14684.32	61.44	Entregue	2022-02-18 00:00:00
1317	1409	4541	457	1	3	1	0.01	48.43	Entregue	2021-06-08 00:00:00
1318	546	4578	457	1	3	1	4745.16	42.58	Entregue	2021-07-15 00:00:00
1319	1427	4576	457	1	3	1	2448.05	26.82	Entregue	2021-07-13 00:00:00
1320	686	4643	457	1	3	1	408.99	27.35	Entregue	2021-09-18 00:00:00
1321	297	4713	457	1	3	1	2027.13	38.33	Entregue	2021-11-27 00:00:00
1322	1658	4537	457	1	3	1	24706.69	29.99	Entregue	2021-06-04 00:00:00
1323	1622	4391	457	1	3	1	19668.54	54.27	Entregue	2021-01-09 00:00:00
1324	303	4453	457	1	3	1	3324.84	38.30	Entregue	2021-03-12 00:00:00
1325	1261	4662	457	1	3	1	1249.44	40.49	Entregue	2021-10-07 00:00:00
1326	974	4536	457	1	3	1	536.14	51.80	Entregue	2021-06-03 00:00:00
1327	1406	4586	457	1	3	1	0.01	58.65	Entregue	2021-07-23 00:00:00
1328	1741	4753	457	1	3	1	11800.44	21.26	Entregue	2022-01-06 00:00:00
1329	1849	4734	457	1	3	1	1001.02	58.15	Entregue	2021-12-18 00:00:00
1330	233	4516	457	1	3	1	331.14	52.01	Entregue	2021-05-14 00:00:00
1331	1149	4441	457	1	3	1	1197.24	37.56	Entregue	2021-02-28 00:00:00
1332	1370	4772	457	1	3	1	2513.60	32.37	Entregue	2022-01-25 00:00:00
1333	1115	4672	457	1	3	1	5071.15	32.84	Entregue	2021-10-17 00:00:00
1334	1993	4540	457	1	3	1	18.57	47.46	Entregue	2021-06-07 00:00:00
1335	93	4653	457	1	3	1	93.45	63.30	Entregue	2021-09-28 00:00:00
1336	89	4607	457	1	3	1	10231.32	25.99	Entregue	2021-08-13 00:00:00
1337	1383	4577	457	1	3	1	102.04	48.28	Entregue	2021-07-14 00:00:00
1338	1345	4456	457	1	3	1	27.06	23.32	Entregue	2021-03-15 00:00:00
1339	723	4831	457	1	3	1	33.10	51.66	Entregue	2022-03-25 00:00:00
1340	497	4518	457	1	3	1	2724.67	59.62	Entregue	2021-05-16 00:00:00
1341	1513	4814	457	1	3	1	108.07	33.57	Entregue	2022-03-08 00:00:00
1342	884	4819	457	1	3	1	1253.49	42.56	Entregue	2022-03-13 00:00:00
1343	155	4518	457	1	3	1	8376.89	47.91	Entregue	2021-05-16 00:00:00
1344	1871	4800	457	1	3	1	1053.78	53.62	Entregue	2022-02-22 00:00:00
1345	953	4880	457	1	3	1	12.57	47.21	Entregue	2022-05-13 00:00:00
1346	609	4434	457	1	3	1	59.40	22.57	Entregue	2021-02-21 00:00:00
1347	416	4837	457	1	3	1	336.28	32.16	Entregue	2022-03-31 00:00:00
1348	1286	4681	457	1	3	1	4133.79	61.22	Entregue	2021-10-26 00:00:00
1349	195	4459	457	1	3	1	4267.95	26.06	Entregue	2021-03-18 00:00:00
1350	1529	4796	457	1	3	1	1828.01	41.26	Entregue	2022-02-18 00:00:00
1351	1153	4537	457	1	3	1	13210.51	61.58	Entregue	2021-06-04 00:00:00
1352	1137	4686	457	1	3	1	1278.91	35.23	Entregue	2021-10-31 00:00:00
1353	441	4853	457	1	3	1	2084.51	25.52	Entregue	2022-04-16 00:00:00
1354	1744	4824	457	1	3	1	0.01	68.51	Entregue	2022-03-18 00:00:00
1355	1047	4539	457	1	3	1	219.40	22.58	Entregue	2021-06-06 00:00:00
1356	892	4517	457	1	3	1	1153.47	49.57	Entregue	2021-05-15 00:00:00
1357	1083	4516	457	1	3	1	0.01	53.88	Entregue	2021-05-14 00:00:00
1358	1949	4420	457	1	3	1	0.01	26.38	Entregue	2021-02-07 00:00:00
1359	1675	4633	457	1	3	1	1871.94	42.42	Entregue	2021-09-08 00:00:00
1360	503	4711	457	1	3	1	2499.33	35.13	Entregue	2021-11-25 00:00:00
1361	1154	4760	457	1	3	1	0.01	58.26	Entregue	2022-01-13 00:00:00
1362	1888	4533	457	1	3	1	22.51	40.17	Entregue	2021-05-31 00:00:00
1363	1356	4549	457	1	3	1	226.44	23.40	Entregue	2021-06-16 00:00:00
1364	994	4551	457	1	3	1	483.64	34.62	Entregue	2021-06-18 00:00:00
1365	1099	4507	457	1	3	1	3202.30	58.92	Entregue	2021-05-05 00:00:00
1366	865	4906	457	1	3	1	3247.68	37.67	Entregue	2022-06-08 00:00:00
1367	1893	4547	457	1	3	1	221.59	68.88	Entregue	2021-06-14 00:00:00
1368	962	4394	457	1	3	1	0.01	55.17	Entregue	2021-01-12 00:00:00
1369	106	4697	457	1	3	1	138.37	28.34	Entregue	2021-11-11 00:00:00
1370	1200	4791	457	1	3	1	1419.46	43.56	Entregue	2022-02-13 00:00:00
1371	1010	4491	457	1	3	1	169.02	37.99	Entregue	2021-04-19 00:00:00
1372	178	4832	457	1	3	1	11833.56	21.54	Entregue	2022-03-26 00:00:00
1373	795	4740	457	1	3	1	544.52	43.28	Entregue	2021-12-24 00:00:00
1374	809	4827	457	1	3	1	173.48	35.40	Entregue	2022-03-21 00:00:00
1375	8	4863	457	1	3	1	3736.98	54.67	Entregue	2022-04-26 00:00:00
1376	934	4488	457	1	3	1	8965.79	25.30	Entregue	2021-04-16 00:00:00
1377	1690	4608	457	1	3	1	2903.94	28.30	Entregue	2021-08-14 00:00:00
1378	908	4428	457	1	3	1	24748.56	49.65	Entregue	2021-02-15 00:00:00
1379	1556	4536	457	1	3	1	518.69	25.13	Entregue	2021-06-03 00:00:00
1380	370	4830	457	1	3	1	1065.26	61.75	Entregue	2022-03-24 00:00:00
1381	684	4698	457	1	3	1	3503.38	53.59	Entregue	2021-11-12 00:00:00
1382	1135	4701	457	1	3	1	4760.53	68.41	Entregue	2021-11-15 00:00:00
1383	1156	4416	457	1	3	1	68.09	24.46	Entregue	2021-02-03 00:00:00
1384	1935	4684	457	1	3	1	3384.05	43.85	Entregue	2021-10-29 00:00:00
1385	396	4899	457	1	3	1	47.50	40.75	Entregue	2022-06-01 00:00:00
1386	1395	4488	457	1	3	1	396.56	62.30	Entregue	2021-04-16 00:00:00
1387	1472	4625	457	1	3	1	17336.43	21.24	Entregue	2021-08-31 00:00:00
1388	514	4915	457	1	3	1	9876.33	64.02	Entregue	2022-06-17 00:00:00
1389	1234	4599	457	1	3	1	13318.89	21.02	Entregue	2021-08-05 00:00:00
1390	854	4759	457	1	3	1	539.18	23.35	Entregue	2022-01-12 00:00:00
1391	389	4560	457	1	3	1	909.81	66.98	Entregue	2021-06-27 00:00:00
1392	1056	4564	457	1	3	1	7.92	69.42	Entregue	2021-07-01 00:00:00
1393	916	4886	457	1	3	1	4427.17	53.71	Entregue	2022-05-19 00:00:00
1394	1471	4814	457	1	3	1	1119.96	55.42	Entregue	2022-03-08 00:00:00
1395	114	4854	457	1	3	1	3995.68	32.60	Entregue	2022-04-17 00:00:00
1396	60	4458	457	1	3	1	717.13	33.87	Entregue	2021-03-17 00:00:00
1397	754	4785	457	1	3	1	212.67	25.48	Entregue	2022-02-07 00:00:00
1398	518	4427	457	1	3	1	0.01	38.66	Entregue	2021-02-14 00:00:00
1399	1299	4456	457	1	3	1	0.01	35.89	Entregue	2021-03-15 00:00:00
1400	98	4518	457	1	3	1	1127.10	34.61	Entregue	2021-05-16 00:00:00
1401	1488	4735	457	1	3	1	18669.99	49.92	Entregue	2021-12-19 00:00:00
1402	715	4517	457	1	3	1	273.48	67.67	Entregue	2021-05-15 00:00:00
1403	235	4582	457	1	3	1	5225.85	53.10	Entregue	2021-07-19 00:00:00
1404	1132	4391	457	1	3	1	699.08	25.72	Entregue	2021-01-09 00:00:00
1405	763	4513	457	1	3	1	1851.11	69.14	Entregue	2021-05-11 00:00:00
1406	306	4462	457	1	3	1	742.40	56.24	Entregue	2021-03-21 00:00:00
1407	1809	4646	457	1	3	1	0.01	34.89	Entregue	2021-09-21 00:00:00
1408	338	4699	457	1	3	1	901.93	61.45	Entregue	2021-11-13 00:00:00
1409	1066	4558	457	1	3	1	896.80	55.11	Entregue	2021-06-25 00:00:00
1410	358	4558	457	1	3	1	501.02	21.94	Entregue	2021-06-25 00:00:00
1411	412	4773	457	1	3	1	0.01	48.76	Entregue	2022-01-26 00:00:00
1412	26	4389	457	1	3	1	1469.18	64.11	Entregue	2021-01-07 00:00:00
1413	950	4672	457	1	3	1	5843.63	44.67	Entregue	2021-10-17 00:00:00
1414	564	4913	457	1	3	1	399.70	26.05	Entregue	2022-06-15 00:00:00
1415	72	4568	457	1	3	1	0.01	53.18	Entregue	2021-07-05 00:00:00
1416	1168	4915	457	1	3	1	5808.62	69.47	Entregue	2022-06-17 00:00:00
1417	1960	4750	457	1	3	1	16919.57	31.90	Entregue	2022-01-03 00:00:00
1418	1527	4456	457	1	3	1	1519.07	52.33	Entregue	2021-03-15 00:00:00
1419	1260	4897	457	1	3	1	889.89	62.52	Entregue	2022-05-30 00:00:00
1420	232	4762	457	1	3	1	2104.19	55.03	Entregue	2022-01-15 00:00:00
1421	77	4531	457	1	3	1	24.14	62.22	Entregue	2021-05-29 00:00:00
1422	1916	4408	457	1	3	1	0.01	46.95	Entregue	2021-01-26 00:00:00
1423	131	4595	457	1	3	1	0.01	64.60	Entregue	2021-08-01 00:00:00
1424	310	4854	457	1	3	1	305.92	62.97	Entregue	2022-04-17 00:00:00
1425	37	4421	457	1	3	1	42.29	66.37	Entregue	2021-02-08 00:00:00
1426	1962	4441	457	1	3	1	2106.38	54.16	Entregue	2021-02-28 00:00:00
1427	1624	4724	457	1	3	1	2105.61	38.59	Entregue	2021-12-08 00:00:00
1428	584	4840	457	1	3	1	0.01	47.04	Entregue	2022-04-03 00:00:00
1429	1821	4903	457	1	3	1	325.63	29.33	Entregue	2022-06-05 00:00:00
1430	1609	4646	457	1	3	1	0.01	47.79	Entregue	2021-09-21 00:00:00
1431	806	4848	457	1	3	1	3419.84	53.14	Entregue	2022-04-11 00:00:00
1432	353	4586	457	1	3	1	1797.88	23.05	Entregue	2021-07-23 00:00:00
1433	939	4466	457	1	3	1	324.59	28.82	Entregue	2021-03-25 00:00:00
1434	834	4534	457	1	3	1	0.01	32.11	Entregue	2021-06-01 00:00:00
1435	831	4626	457	1	3	1	3708.82	20.67	Entregue	2021-09-01 00:00:00
1436	813	4725	457	1	3	1	4256.71	53.68	Entregue	2021-12-09 00:00:00
1437	1164	4747	457	1	3	1	832.96	36.66	Entregue	2021-12-31 00:00:00
1438	1298	4481	457	1	3	1	3417.89	37.15	Entregue	2021-04-09 00:00:00
1439	574	4681	457	1	3	1	3187.16	32.00	Entregue	2021-10-26 00:00:00
1440	1443	4863	457	1	3	1	0.01	29.44	Entregue	2022-04-26 00:00:00
1441	225	4906	457	1	3	1	2303.07	32.51	Entregue	2022-06-08 00:00:00
1442	1344	4743	457	1	3	1	2594.76	23.45	Entregue	2021-12-27 00:00:00
1443	333	4892	457	1	3	1	832.55	33.14	Entregue	2022-05-25 00:00:00
1444	1496	4820	457	1	3	1	3367.23	69.08	Entregue	2022-03-14 00:00:00
1445	1446	4507	457	1	3	1	2973.15	40.63	Entregue	2021-05-05 00:00:00
1446	174	4635	457	1	3	1	502.00	67.88	Entregue	2021-09-10 00:00:00
1447	45	4914	457	1	3	1	3035.39	65.94	Entregue	2022-06-16 00:00:00
1448	1375	4606	457	1	3	1	25.39	35.43	Entregue	2021-08-12 00:00:00
1449	891	4531	457	1	3	1	2372.13	23.68	Entregue	2021-05-29 00:00:00
1450	134	4437	457	1	3	1	13650.26	34.68	Entregue	2021-02-24 00:00:00
1451	1430	4812	457	1	3	1	120.60	47.62	Entregue	2022-03-06 00:00:00
1452	1419	4798	457	1	3	1	1774.74	69.32	Entregue	2022-02-20 00:00:00
1453	1241	4412	457	1	3	1	136.49	43.10	Entregue	2021-01-30 00:00:00
1454	1790	4811	457	1	3	1	392.35	65.35	Entregue	2022-03-05 00:00:00
1455	1577	4913	457	1	3	1	2528.40	23.59	Entregue	2022-06-15 00:00:00
1456	975	4584	457	1	3	1	760.61	32.75	Entregue	2021-07-21 00:00:00
1457	36	4558	457	1	3	1	146.66	54.09	Entregue	2021-06-25 00:00:00
1458	1802	4512	457	1	3	1	3793.71	54.37	Entregue	2021-05-10 00:00:00
1459	102	4711	457	1	3	1	2680.12	35.67	Entregue	2021-11-25 00:00:00
1460	1292	4684	457	1	3	1	44.87	41.28	Entregue	2021-10-29 00:00:00
1461	533	4730	457	1	3	1	0.01	68.02	Entregue	2021-12-14 00:00:00
1462	915	4535	457	1	3	1	105.61	47.48	Entregue	2021-06-02 00:00:00
1463	1677	4738	457	1	3	1	13.88	34.32	Entregue	2021-12-22 00:00:00
1464	207	4748	457	1	3	1	4872.96	44.97	Entregue	2022-01-01 00:00:00
1465	979	4632	457	1	3	1	621.90	42.67	Entregue	2021-09-07 00:00:00
1466	1901	4490	457	1	3	1	0.01	58.52	Entregue	2021-04-18 00:00:00
1467	1884	4831	457	1	3	1	96.36	43.51	Entregue	2022-03-25 00:00:00
1468	871	4455	457	1	3	1	2087.47	28.30	Entregue	2021-03-14 00:00:00
1469	1410	4867	457	1	3	1	2950.67	66.56	Entregue	2022-04-30 00:00:00
1470	1758	4785	457	1	3	1	34.91	41.75	Entregue	2022-02-07 00:00:00
1471	1996	4466	457	1	3	1	150.55	60.34	Entregue	2021-03-25 00:00:00
1472	1442	4483	457	1	3	1	197.48	65.94	Entregue	2021-04-11 00:00:00
1473	365	4437	457	1	3	1	42.78	33.40	Entregue	2021-02-24 00:00:00
1474	704	4554	457	1	3	1	3495.90	55.10	Entregue	2021-06-21 00:00:00
1475	157	4716	457	1	3	1	445.40	63.25	Entregue	2021-11-30 00:00:00
1476	1559	4480	457	1	3	1	8320.23	27.28	Entregue	2021-04-08 00:00:00
1477	1909	4629	457	1	3	1	1730.47	47.33	Entregue	2021-09-04 00:00:00
1478	618	4626	457	1	3	1	30.19	51.74	Entregue	2021-09-01 00:00:00
1479	1851	4742	457	1	3	1	7387.58	47.68	Entregue	2021-12-26 00:00:00
1480	313	4738	457	1	3	1	14932.78	35.11	Entregue	2021-12-22 00:00:00
1481	1080	4445	457	1	3	1	2301.89	50.36	Entregue	2021-03-04 00:00:00
1482	140	4553	457	1	3	1	0.01	46.75	Entregue	2021-06-20 00:00:00
1483	137	4384	457	1	3	1	6942.24	49.06	Entregue	2021-01-02 00:00:00
1484	392	4855	457	1	3	1	6775.05	22.76	Entregue	2022-04-18 00:00:00
1485	191	4802	457	1	3	1	10066.94	66.41	Entregue	2022-02-24 00:00:00
1486	1972	4545	457	1	3	1	1643.40	42.39	Entregue	2021-06-12 00:00:00
1487	760	4593	457	1	3	1	0.01	52.89	Entregue	2021-07-30 00:00:00
1488	1539	4442	457	1	3	1	18829.75	45.01	Entregue	2021-03-01 00:00:00
1489	218	4608	457	1	3	1	420.91	61.40	Entregue	2021-08-14 00:00:00
1490	1515	4696	457	1	3	1	90.21	37.37	Entregue	2021-11-10 00:00:00
1491	1500	4384	457	1	3	1	2093.06	57.81	Entregue	2021-01-02 00:00:00
1492	1736	4641	457	1	3	1	9886.01	60.13	Entregue	2021-09-16 00:00:00
1493	671	4813	457	1	3	1	2440.38	41.02	Entregue	2022-03-07 00:00:00
1494	580	4823	457	1	3	1	0.01	42.09	Entregue	2022-03-17 00:00:00
1495	1131	4643	457	1	3	1	2321.58	41.60	Entregue	2021-09-18 00:00:00
1496	1625	4722	457	1	3	1	878.78	24.05	Entregue	2021-12-06 00:00:00
1497	742	4757	457	1	3	1	0.01	65.55	Entregue	2022-01-10 00:00:00
1498	912	4507	457	1	3	1	109.50	54.24	Entregue	2021-05-05 00:00:00
1499	1478	4427	457	1	3	1	3064.46	45.89	Entregue	2021-02-14 00:00:00
1500	1964	4625	457	1	3	1	4867.48	55.52	Entregue	2021-08-31 00:00:00
1501	938	4778	457	1	3	1	433.10	52.57	Entregue	2022-01-31 00:00:00
1502	1158	4385	457	1	3	1	488.33	34.25	Entregue	2021-01-03 00:00:00
1503	1037	4660	457	1	3	1	18.42	27.84	Entregue	2021-10-05 00:00:00
1504	184	4546	457	1	3	1	2438.75	21.11	Entregue	2021-06-13 00:00:00
1505	87	4859	457	1	3	1	705.07	55.77	Entregue	2022-04-22 00:00:00
1506	753	4553	457	1	3	1	6566.29	54.08	Entregue	2021-06-20 00:00:00
1507	1300	4878	457	1	3	1	2444.11	48.60	Entregue	2022-05-11 00:00:00
1508	550	4743	457	1	3	1	1563.02	68.84	Entregue	2021-12-27 00:00:00
1509	394	4624	457	1	3	1	10937.87	22.96	Entregue	2021-08-30 00:00:00
1510	272	4676	457	1	3	1	1980.47	53.49	Entregue	2021-10-21 00:00:00
1511	1437	4829	457	1	3	1	14918.15	52.61	Entregue	2022-03-23 00:00:00
1512	867	4811	457	1	3	1	1204.44	57.63	Entregue	2022-03-05 00:00:00
1513	190	4569	457	1	3	1	125.39	23.98	Entregue	2021-07-06 00:00:00
1514	554	4874	457	1	3	1	1035.50	40.70	Entregue	2022-05-07 00:00:00
1515	424	4698	457	1	3	1	603.95	46.68	Entregue	2021-11-12 00:00:00
1516	670	4892	457	1	3	1	4197.98	42.71	Entregue	2022-05-25 00:00:00
1517	1933	4514	457	1	3	1	0.01	50.92	Entregue	2021-05-12 00:00:00
1518	309	4459	457	1	3	1	38.52	61.46	Entregue	2021-03-18 00:00:00
1519	1612	4541	457	1	3	1	10342.30	27.10	Entregue	2021-06-08 00:00:00
1520	1854	4489	457	1	3	1	32.07	33.00	Entregue	2021-04-17 00:00:00
1521	509	4546	457	1	3	1	3846.08	52.04	Entregue	2021-06-13 00:00:00
1522	1366	4711	457	1	3	1	1218.87	64.09	Entregue	2021-11-25 00:00:00
1523	1067	4474	457	1	3	1	11897.50	58.05	Entregue	2021-04-02 00:00:00
1524	156	4418	457	1	3	1	3412.42	49.08	Entregue	2021-02-05 00:00:00
1525	1599	4559	457	1	3	1	502.90	52.68	Entregue	2021-06-26 00:00:00
1526	1408	4682	457	1	3	1	792.19	41.99	Entregue	2021-10-27 00:00:00
1527	641	4849	457	1	3	1	80.84	23.53	Entregue	2022-04-12 00:00:00
1528	475	4404	457	1	3	1	349.59	25.25	Entregue	2021-01-22 00:00:00
1529	1475	4654	457	1	3	1	163.39	32.85	Entregue	2021-09-29 00:00:00
1530	888	4480	457	1	3	1	0.01	27.31	Entregue	2021-04-08 00:00:00
1531	1235	4768	457	1	3	1	539.37	52.71	Entregue	2022-01-21 00:00:00
1532	282	4668	457	1	3	1	250.73	29.07	Entregue	2021-10-13 00:00:00
1533	1604	4462	457	1	3	1	1029.32	35.51	Entregue	2021-03-21 00:00:00
1534	502	4560	457	1	3	1	223.52	32.13	Entregue	2021-06-27 00:00:00
1535	1872	4857	457	1	3	1	66.18	30.36	Entregue	2022-04-20 00:00:00
1536	117	4479	457	1	3	1	2478.75	48.62	Entregue	2021-04-07 00:00:00
1537	257	4545	457	1	3	1	0.01	50.31	Entregue	2021-06-12 00:00:00
1538	40	4564	457	1	3	1	10139.58	52.20	Entregue	2021-07-01 00:00:00
1539	1122	4451	457	1	3	1	86.14	38.38	Entregue	2021-03-10 00:00:00
1540	1485	4851	457	1	3	1	0.01	61.99	Entregue	2022-04-14 00:00:00
1541	1258	4854	457	1	3	1	458.25	53.01	Entregue	2022-04-17 00:00:00
1542	1166	4554	457	1	3	1	387.20	47.93	Entregue	2021-06-21 00:00:00
1543	1637	4639	457	1	3	1	5624.36	31.93	Entregue	2021-09-14 00:00:00
1544	1519	4647	457	1	3	1	4869.32	33.44	Entregue	2021-09-22 00:00:00
1545	914	4564	457	1	3	1	2176.15	56.88	Entregue	2021-07-01 00:00:00
1546	728	4413	457	1	3	1	1595.18	58.48	Entregue	2021-01-31 00:00:00
1547	1150	4880	457	1	3	1	8444.94	62.46	Entregue	2022-05-13 00:00:00
1548	1119	4476	457	1	3	1	6643.81	25.55	Entregue	2021-04-04 00:00:00
1549	506	4708	457	1	3	1	24684.29	28.15	Entregue	2021-11-22 00:00:00
1550	1501	4507	457	1	3	1	401.83	44.07	Entregue	2021-05-05 00:00:00
1551	331	4716	457	1	3	1	632.25	46.20	Entregue	2021-11-30 00:00:00
1552	1578	4784	457	1	3	1	0.01	63.74	Entregue	2022-02-06 00:00:00
1553	913	4679	457	1	3	1	11911.68	23.91	Entregue	2021-10-24 00:00:00
1554	599	4450	457	1	3	1	236.02	31.82	Entregue	2021-03-09 00:00:00
1555	1468	4641	457	1	3	1	2796.83	41.76	Entregue	2021-09-16 00:00:00
1556	1464	4880	457	1	3	1	0.01	25.71	Entregue	2022-05-13 00:00:00
1557	1486	4915	457	1	3	1	8.00	53.60	Entregue	2022-06-17 00:00:00
1558	1461	4427	457	1	3	1	2910.32	46.45	Entregue	2021-02-14 00:00:00
1559	1525	4522	457	1	3	1	4812.94	63.38	Entregue	2021-05-20 00:00:00
1560	698	4672	457	1	3	1	173.05	21.92	Entregue	2021-10-17 00:00:00
1561	466	4457	457	1	3	1	2260.73	65.64	Entregue	2021-03-16 00:00:00
1562	201	4750	457	1	3	1	1598.79	66.75	Entregue	2022-01-03 00:00:00
1563	1617	4699	457	1	3	1	0.01	68.48	Entregue	2021-11-13 00:00:00
1564	1201	4540	457	1	3	1	895.19	48.00	Entregue	2021-06-07 00:00:00
1565	1778	4725	457	1	3	1	8318.35	66.61	Entregue	2021-12-09 00:00:00
1566	1314	4391	457	1	3	1	14961.98	44.81	Entregue	2021-01-09 00:00:00
1567	1196	4761	457	1	3	1	0.01	41.02	Entregue	2022-01-14 00:00:00
1568	446	4723	457	1	3	1	162.08	30.56	Entregue	2021-12-07 00:00:00
1569	749	4553	457	1	3	1	2715.46	48.02	Entregue	2021-06-20 00:00:00
1570	86	4645	457	1	3	1	14650.69	41.31	Entregue	2021-09-20 00:00:00
1571	920	4627	457	1	3	1	3825.98	49.40	Entregue	2021-09-02 00:00:00
1572	1843	4830	457	1	3	1	443.61	66.28	Entregue	2022-03-24 00:00:00
1573	1058	4586	457	1	3	1	4296.94	34.39	Entregue	2021-07-23 00:00:00
1574	219	4422	457	1	3	1	3368.14	41.14	Entregue	2021-02-09 00:00:00
1575	231	4856	457	1	3	1	0.01	28.78	Entregue	2022-04-19 00:00:00
1576	1213	4687	457	1	3	1	2740.72	29.57	Entregue	2021-11-01 00:00:00
1577	873	4709	457	1	3	1	233.31	66.92	Entregue	2021-11-23 00:00:00
1578	1803	4751	457	1	3	1	57.43	20.83	Entregue	2022-01-04 00:00:00
1579	1505	4672	457	1	3	1	2219.34	32.83	Entregue	2021-10-17 00:00:00
1580	1311	4614	457	1	3	1	4122.89	53.24	Entregue	2021-08-20 00:00:00
1581	414	4549	457	1	3	1	100.76	32.67	Entregue	2021-06-16 00:00:00
1582	640	4606	457	1	3	1	1307.36	30.60	Entregue	2021-08-12 00:00:00
1583	1053	4743	457	1	3	1	3861.31	41.57	Entregue	2021-12-27 00:00:00
1584	1452	4504	457	1	3	1	75.35	30.29	Entregue	2021-05-02 00:00:00
1585	735	4607	457	1	3	1	371.47	52.92	Entregue	2021-08-13 00:00:00
1586	1813	4494	457	1	3	1	739.85	28.86	Entregue	2021-04-22 00:00:00
1587	166	4554	457	1	3	1	384.12	24.39	Entregue	2021-06-21 00:00:00
1588	1846	4791	457	1	3	1	1506.34	61.98	Entregue	2022-02-13 00:00:00
1589	1648	4662	457	1	3	1	34.16	38.77	Entregue	2021-10-07 00:00:00
1590	410	4396	457	1	3	1	24620.22	22.98	Entregue	2021-01-14 00:00:00
1591	1381	4781	457	1	3	1	3991.24	61.74	Entregue	2022-02-03 00:00:00
1592	381	4433	457	1	3	1	3030.96	38.28	Entregue	2021-02-20 00:00:00
1593	597	4405	457	1	3	1	434.89	25.49	Entregue	2021-01-23 00:00:00
1594	1291	4474	457	1	3	1	0.01	59.45	Entregue	2021-04-02 00:00:00
1595	193	4507	457	1	3	1	3247.57	31.31	Entregue	2021-05-05 00:00:00
1596	1435	4466	457	1	3	1	538.12	68.56	Entregue	2021-03-25 00:00:00
1597	1012	4680	457	1	3	1	308.30	55.18	Entregue	2021-10-25 00:00:00
1598	730	4867	457	1	3	1	0.01	57.87	Entregue	2022-04-30 00:00:00
1599	548	4775	457	1	3	1	2128.29	66.68	Entregue	2022-01-28 00:00:00
1600	1087	4843	457	1	3	1	1604.24	44.72	Entregue	2022-04-06 00:00:00
1601	1769	4743	457	1	3	1	150.98	34.82	Entregue	2021-12-27 00:00:00
1602	1457	4532	457	1	3	1	0.01	51.89	Entregue	2021-05-30 00:00:00
1603	1902	4580	457	1	3	1	2301.00	37.79	Entregue	2021-07-17 00:00:00
1604	1635	4612	457	1	3	1	4002.03	24.43	Entregue	2021-08-18 00:00:00
1605	709	4824	457	1	3	1	8471.23	65.89	Entregue	2022-03-18 00:00:00
1606	47	4722	457	1	3	1	1464.40	69.53	Entregue	2021-12-06 00:00:00
1607	1105	4553	457	1	3	1	0.01	40.65	Entregue	2021-06-20 00:00:00
1608	886	4459	457	1	3	1	75.22	37.93	Entregue	2021-03-18 00:00:00
1609	177	4891	457	1	3	1	275.18	57.34	Entregue	2022-05-24 00:00:00
1610	727	4639	457	1	3	1	2626.41	38.13	Entregue	2021-09-14 00:00:00
1611	1405	4883	457	1	3	1	0.01	68.37	Entregue	2022-05-16 00:00:00
1612	810	4608	457	1	3	1	7.72	47.06	Entregue	2021-08-14 00:00:00
1613	1231	4527	457	1	3	1	57.88	58.60	Entregue	2021-05-25 00:00:00
1614	1276	4730	457	1	3	1	178.34	30.88	Entregue	2021-12-14 00:00:00
1615	1117	4495	457	1	3	1	2922.43	22.63	Entregue	2021-04-23 00:00:00
1616	110	4875	457	1	3	1	796.60	66.59	Entregue	2022-05-08 00:00:00
1617	1710	4888	457	1	3	1	1954.10	50.24	Entregue	2022-05-21 00:00:00
1618	145	4679	457	1	3	1	312.17	67.01	Entregue	2021-10-24 00:00:00
1619	557	4451	457	1	3	1	82.69	36.25	Entregue	2021-03-10 00:00:00
1620	485	4545	457	1	3	1	12231.18	45.07	Entregue	2021-06-12 00:00:00
1621	1439	4694	457	1	3	1	2356.56	35.65	Entregue	2021-11-08 00:00:00
1622	1388	4680	457	1	3	1	1451.03	48.42	Entregue	2021-10-25 00:00:00
1623	1081	4668	457	1	3	1	4683.28	25.48	Entregue	2021-10-13 00:00:00
1624	1315	4605	457	1	3	1	1213.20	52.84	Entregue	2021-08-11 00:00:00
1625	1102	4829	457	1	3	1	11734.07	48.24	Entregue	2022-03-23 00:00:00
1626	1453	4590	457	1	3	1	512.98	41.07	Entregue	2021-07-27 00:00:00
1627	1198	4721	457	1	3	1	2748.17	37.40	Entregue	2021-12-05 00:00:00
1628	341	4809	457	1	3	1	2740.21	63.30	Entregue	2022-03-03 00:00:00
1629	1506	4636	457	1	3	1	47.14	65.92	Entregue	2021-09-11 00:00:00
1630	1195	4513	457	1	3	1	533.93	62.85	Entregue	2021-05-11 00:00:00
1631	170	4514	457	1	3	1	1454.38	59.96	Entregue	2021-05-12 00:00:00
1632	712	4546	457	1	3	1	2725.17	27.53	Entregue	2021-06-13 00:00:00
1633	192	4609	457	1	3	1	2625.14	38.63	Entregue	2021-08-15 00:00:00
1634	1696	4611	457	1	3	1	413.27	48.10	Entregue	2021-08-17 00:00:00
1635	1174	4578	457	1	3	1	824.72	40.63	Entregue	2021-07-15 00:00:00
1636	1740	4645	457	1	3	1	239.33	46.73	Entregue	2021-09-20 00:00:00
1637	513	4875	457	1	3	1	74.36	68.44	Entregue	2022-05-08 00:00:00
1638	101	4694	457	1	3	1	0.01	42.89	Entregue	2021-11-08 00:00:00
1639	473	4411	457	1	3	1	27.85	44.08	Entregue	2021-01-29 00:00:00
1640	1824	4550	457	1	3	1	6003.10	45.45	Entregue	2021-06-17 00:00:00
1641	1575	4587	457	1	3	1	1979.11	28.69	Entregue	2021-07-24 00:00:00
1642	415	4738	457	1	3	1	0.01	22.19	Entregue	2021-12-22 00:00:00
1643	1835	4466	457	1	3	1	1772.87	68.38	Entregue	2021-03-25 00:00:00
1644	1376	4859	457	1	3	1	117.89	29.76	Entregue	2022-04-22 00:00:00
1645	1365	4552	457	1	3	1	0.01	45.47	Entregue	2021-06-19 00:00:00
1646	1897	4686	457	1	3	1	0.01	62.08	Entregue	2021-10-31 00:00:00
1647	689	4638	457	1	3	1	3995.22	68.42	Entregue	2021-09-13 00:00:00
1648	522	4420	457	1	3	1	1948.76	65.37	Entregue	2021-02-07 00:00:00
1649	1806	4593	457	1	3	1	0.01	67.63	Entregue	2021-07-30 00:00:00
1650	674	4682	457	1	3	1	0.01	65.17	Entregue	2021-10-27 00:00:00
1651	630	4394	457	1	3	1	1560.39	66.16	Entregue	2021-01-12 00:00:00
1652	1723	4671	457	1	3	1	788.24	62.20	Entregue	2021-10-16 00:00:00
1653	1704	4680	457	1	3	1	1696.10	43.89	Entregue	2021-10-25 00:00:00
1654	575	4878	457	1	3	1	254.76	31.55	Entregue	2022-05-11 00:00:00
1655	1492	4877	457	1	3	1	559.53	25.64	Entregue	2022-05-10 00:00:00
1656	401	4398	457	1	3	1	2141.36	49.06	Entregue	2021-01-16 00:00:00
1657	1701	4684	457	1	3	1	322.54	55.81	Entregue	2021-10-29 00:00:00
1658	1456	4751	457	1	3	1	667.08	63.49	Entregue	2022-01-04 00:00:00
1659	1483	4631	457	1	3	1	320.71	54.81	Entregue	2021-09-06 00:00:00
1660	739	4813	457	1	3	1	1280.44	47.70	Entregue	2022-03-07 00:00:00
1661	1094	4618	457	1	3	1	24.69	38.10	Entregue	2021-08-24 00:00:00
1662	1948	4761	457	1	3	1	0.01	50.70	Entregue	2022-01-14 00:00:00
1663	1110	4428	457	1	3	1	1528.44	54.89	Entregue	2021-02-15 00:00:00
1664	1743	4510	457	1	3	1	8408.92	62.27	Entregue	2021-05-08 00:00:00
1665	741	4858	457	1	3	1	0.01	27.81	Entregue	2022-04-21 00:00:00
1666	716	4856	457	1	3	1	661.97	43.68	Entregue	2022-04-19 00:00:00
1667	897	4509	457	1	3	1	433.11	27.43	Entregue	2021-05-07 00:00:00
1668	543	4425	457	1	3	1	3090.49	64.83	Entregue	2021-02-12 00:00:00
1669	1562	4428	457	1	3	1	101.40	21.57	Entregue	2021-02-15 00:00:00
1670	1473	4774	457	1	3	1	231.09	25.32	Entregue	2022-01-27 00:00:00
1671	1130	4504	457	1	3	1	2745.39	43.29	Entregue	2021-05-02 00:00:00
1672	85	4511	457	1	3	1	0.01	58.07	Entregue	2021-05-09 00:00:00
1673	1440	4436	457	1	3	1	0.01	38.56	Entregue	2021-02-23 00:00:00
1674	281	4585	457	1	3	1	13520.12	34.44	Entregue	2021-07-22 00:00:00
1675	687	4590	457	1	3	1	4834.96	20.20	Entregue	2021-07-27 00:00:00
1676	288	4818	457	1	3	1	2800.46	49.62	Entregue	2022-03-12 00:00:00
1677	21	4648	457	1	3	1	304.58	69.68	Entregue	2021-09-23 00:00:00
1678	1814	4722	457	1	3	1	5579.47	28.89	Entregue	2021-12-06 00:00:00
1679	622	4442	457	1	3	1	2146.63	25.18	Entregue	2021-03-01 00:00:00
1680	1765	4639	457	1	3	1	995.66	30.71	Entregue	2021-09-14 00:00:00
1681	1027	4512	457	1	3	1	3124.76	21.42	Entregue	2021-05-10 00:00:00
1682	1479	4785	457	1	3	1	2116.14	42.90	Entregue	2022-02-07 00:00:00
1683	1593	4776	457	1	3	1	5215.23	29.68	Entregue	2022-01-29 00:00:00
1684	1926	4886	457	1	3	1	91.07	35.62	Entregue	2022-05-19 00:00:00
1685	1832	4708	457	1	3	1	5165.27	58.40	Entregue	2021-11-22 00:00:00
1686	635	4522	457	1	3	1	2381.92	63.21	Entregue	2021-05-20 00:00:00
1687	1672	4569	457	1	3	1	724.78	36.80	Entregue	2021-07-06 00:00:00
1688	388	4459	457	1	3	1	15069.54	48.97	Entregue	2021-03-18 00:00:00
1689	151	4631	457	1	3	1	87.96	52.64	Entregue	2021-09-06 00:00:00
1690	1346	4646	457	1	3	1	1563.66	47.44	Entregue	2021-09-21 00:00:00
1691	620	4576	457	1	3	1	1968.24	51.99	Entregue	2021-07-13 00:00:00
1692	205	4570	457	1	3	1	97.19	45.61	Entregue	2021-07-07 00:00:00
1693	67	4874	457	1	3	1	1146.48	36.98	Entregue	2022-05-07 00:00:00
1694	325	4784	457	1	3	1	5254.20	39.46	Entregue	2022-02-06 00:00:00
1695	895	4600	457	1	3	1	780.29	21.86	Entregue	2021-08-06 00:00:00
1696	673	4559	457	1	3	1	3529.51	51.65	Entregue	2021-06-26 00:00:00
1697	1377	4830	457	1	3	1	375.72	41.82	Entregue	2022-03-24 00:00:00
1698	1638	4458	457	1	3	1	14.71	51.12	Entregue	2021-03-17 00:00:00
1699	783	4428	457	1	3	1	228.26	28.12	Entregue	2021-02-15 00:00:00
1700	1794	4539	457	1	3	1	11101.80	62.57	Entregue	2021-06-06 00:00:00
1701	334	4743	457	1	3	1	924.27	56.66	Entregue	2021-12-27 00:00:00
1702	1071	4411	457	1	3	1	14742.36	38.75	Entregue	2021-01-29 00:00:00
1703	540	4774	457	1	3	1	204.67	30.24	Entregue	2022-01-27 00:00:00
1704	1739	4796	457	1	3	1	695.20	33.04	Entregue	2022-02-18 00:00:00
1705	464	4793	457	1	3	1	154.81	44.68	Entregue	2022-02-15 00:00:00
1706	1109	4625	457	1	3	1	130.04	20.75	Entregue	2021-08-31 00:00:00
1707	277	4876	457	1	3	1	4441.51	23.96	Entregue	2022-05-09 00:00:00
1708	1777	4520	457	1	3	1	814.92	65.33	Entregue	2021-05-18 00:00:00
1709	1980	4736	457	1	3	1	0.01	51.35	Entregue	2021-12-20 00:00:00
1710	1842	4845	457	1	3	1	671.95	52.67	Entregue	2022-04-08 00:00:00
1711	300	4394	457	1	3	1	421.47	30.25	Entregue	2021-01-12 00:00:00
1712	662	4651	457	1	3	1	54.26	27.74	Entregue	2021-09-26 00:00:00
1713	284	4884	457	1	3	1	7368.47	64.92	Entregue	2022-05-17 00:00:00
1714	1254	4696	457	1	3	1	141.56	52.18	Entregue	2021-11-10 00:00:00
1715	342	4697	457	1	3	1	0.01	39.73	Entregue	2021-11-11 00:00:00
1716	1133	4647	457	1	3	1	7418.38	42.48	Entregue	2021-09-22 00:00:00
1717	1271	4532	457	1	3	1	22238.37	34.84	Entregue	2021-05-30 00:00:00
1718	1073	4905	457	1	3	1	0.01	34.23	Entregue	2022-06-07 00:00:00
1719	588	4794	457	1	3	1	1856.40	47.35	Entregue	2022-02-16 00:00:00
1720	1019	4625	457	1	3	1	4110.36	61.73	Entregue	2021-08-31 00:00:00
1721	439	4445	457	1	3	1	524.24	49.15	Entregue	2021-03-04 00:00:00
1722	206	4482	457	1	3	1	105.48	68.84	Entregue	2021-04-10 00:00:00
1723	46	4592	457	1	3	1	2423.99	48.14	Entregue	2021-07-29 00:00:00
1724	1773	4515	457	1	3	1	380.57	54.73	Entregue	2021-05-13 00:00:00
1725	586	4716	457	1	3	1	4718.02	60.07	Entregue	2021-11-30 00:00:00
1726	53	4838	457	1	3	1	167.14	47.27	Entregue	2022-04-01 00:00:00
1727	336	4609	457	1	3	1	650.75	67.44	Entregue	2021-08-15 00:00:00
1728	275	4386	457	1	3	1	176.11	32.06	Entregue	2021-01-04 00:00:00
1729	1801	4698	457	1	3	1	2931.20	33.49	Entregue	2021-11-12 00:00:00
1730	1412	4408	457	1	3	1	52.04	58.95	Entregue	2021-01-26 00:00:00
1731	260	4656	457	1	3	1	3.24	50.97	Entregue	2021-10-01 00:00:00
1732	136	4845	457	1	3	1	5260.04	58.03	Entregue	2022-04-08 00:00:00
1733	139	4521	457	1	3	1	0.01	51.30	Entregue	2021-05-19 00:00:00
1734	1459	4596	457	1	3	1	3863.66	41.57	Entregue	2021-08-02 00:00:00
1735	1537	4857	457	1	3	1	549.29	52.16	Entregue	2022-04-20 00:00:00
1736	1033	4561	457	1	3	1	160.37	58.92	Entregue	2021-06-28 00:00:00
1737	1868	4466	457	1	3	1	1949.48	52.35	Entregue	2021-03-25 00:00:00
1738	425	4772	457	1	3	1	4313.88	47.52	Entregue	2022-01-25 00:00:00
1739	1499	4533	457	1	3	1	348.60	47.74	Entregue	2021-05-31 00:00:00
1740	1734	4852	457	1	3	1	231.65	21.21	Entregue	2022-04-15 00:00:00
1741	825	4818	457	1	3	1	292.44	42.25	Entregue	2022-03-12 00:00:00
1742	1040	4643	457	1	3	1	4848.88	44.21	Entregue	2021-09-18 00:00:00
1743	731	4759	457	1	3	1	213.96	57.07	Entregue	2022-01-12 00:00:00
1744	403	4593	457	1	3	1	423.30	21.66	Entregue	2021-07-30 00:00:00
1745	1597	4448	457	1	3	1	674.73	39.10	Entregue	2021-03-07 00:00:00
1746	1350	4396	457	1	3	1	1450.57	51.34	Entregue	2021-01-14 00:00:00
1747	654	4582	457	1	3	1	1623.74	54.79	Entregue	2021-07-19 00:00:00
1748	33	4648	457	1	3	1	86.02	28.61	Entregue	2021-09-23 00:00:00
1749	1643	4476	457	1	3	1	773.52	56.50	Entregue	2021-04-04 00:00:00
1750	549	4852	457	1	3	1	0.01	59.23	Entregue	2022-04-15 00:00:00
1751	1858	4604	457	1	3	1	0.01	29.96	Entregue	2021-08-10 00:00:00
1752	653	4530	457	1	3	1	3223.54	44.89	Entregue	2021-05-28 00:00:00
1753	380	4865	457	1	3	1	183.37	32.09	Entregue	2022-04-28 00:00:00
1754	1339	4476	457	1	3	1	0.01	32.89	Entregue	2021-04-04 00:00:00
1755	130	4517	457	1	3	1	0.01	21.93	Entregue	2021-05-15 00:00:00
1756	23	4609	457	1	3	1	972.49	39.01	Entregue	2021-08-15 00:00:00
1757	612	4675	457	1	3	1	2709.83	36.52	Entregue	2021-10-20 00:00:00
1758	486	4511	457	1	3	1	1626.14	44.20	Entregue	2021-05-09 00:00:00
1759	1521	4774	457	1	3	1	244.58	62.25	Entregue	2022-01-27 00:00:00
1760	1528	4751	457	1	3	1	0.01	59.73	Entregue	2022-01-04 00:00:00
1761	765	4828	457	1	3	1	3380.53	24.82	Entregue	2022-03-22 00:00:00
1762	1277	4900	457	1	3	1	942.82	61.64	Entregue	2022-06-02 00:00:00
1763	1855	4768	457	1	3	1	411.69	61.39	Entregue	2022-01-21 00:00:00
1764	552	4633	457	1	3	1	7663.43	27.91	Entregue	2021-09-08 00:00:00
1765	887	4854	457	1	3	1	2646.62	61.31	Entregue	2022-04-17 00:00:00
1766	1772	4914	457	1	3	1	3728.34	30.23	Entregue	2022-06-16 00:00:00
1767	1669	4596	457	1	3	1	2678.85	62.00	Entregue	2021-08-02 00:00:00
1768	959	4606	457	1	3	1	115.39	20.47	Entregue	2021-08-12 00:00:00
1769	1983	4616	457	1	3	1	1487.61	30.34	Entregue	2021-08-22 00:00:00
1770	386	4495	457	1	3	1	305.91	43.32	Entregue	2021-04-23 00:00:00
1771	1797	4495	457	1	3	1	0.01	25.92	Entregue	2021-04-23 00:00:00
1772	433	4573	457	1	3	1	249.66	29.34	Entregue	2021-07-10 00:00:00
1773	364	4823	457	1	3	1	358.58	61.95	Entregue	2022-03-17 00:00:00
1774	1187	4652	457	1	3	1	10372.26	23.85	Entregue	2021-09-27 00:00:00
1775	1123	4802	457	1	3	1	1355.04	25.99	Entregue	2022-02-24 00:00:00
1776	345	4482	457	1	3	1	4214.78	63.86	Entregue	2021-04-10 00:00:00
1777	92	4455	457	1	3	1	3072.53	64.96	Entregue	2021-03-14 00:00:00
1778	541	4611	457	1	3	1	2711.67	49.67	Entregue	2021-08-17 00:00:00
1779	1517	4833	457	1	3	1	608.37	31.95	Entregue	2022-03-27 00:00:00
1780	1598	4524	457	1	3	1	664.37	23.90	Entregue	2021-05-22 00:00:00
1781	437	4389	457	1	3	1	2778.52	31.07	Entregue	2021-01-07 00:00:00
1782	957	4845	457	1	3	1	2143.29	47.81	Entregue	2022-04-08 00:00:00
1783	1065	4646	457	1	3	1	0.01	69.87	Entregue	2021-09-21 00:00:00
1784	998	4644	457	1	3	1	0.01	62.97	Entregue	2021-09-19 00:00:00
1785	1795	4848	457	1	3	1	3309.18	21.54	Entregue	2022-04-11 00:00:00
1786	1719	4568	457	1	3	1	2093.73	34.40	Entregue	2021-07-05 00:00:00
1787	197	4633	457	1	3	1	0.01	63.24	Entregue	2021-09-08 00:00:00
1788	999	4741	457	1	3	1	744.22	34.56	Entregue	2021-12-25 00:00:00
1789	493	4883	457	1	3	1	0.01	58.06	Entregue	2022-05-16 00:00:00
1790	1536	4442	457	1	3	1	0.01	25.49	Entregue	2021-03-01 00:00:00
1791	707	4388	457	1	3	1	2098.83	34.12	Entregue	2021-01-06 00:00:00
1792	665	4699	457	1	3	1	1570.88	23.48	Entregue	2021-11-13 00:00:00
1793	759	4404	457	1	3	1	99.90	56.03	Entregue	2021-01-22 00:00:00
1794	482	4511	457	1	3	1	748.52	21.96	Entregue	2021-05-09 00:00:00
1795	1547	4455	457	1	3	1	544.16	40.16	Entregue	2021-03-14 00:00:00
1796	311	4464	457	1	3	1	71.72	52.28	Entregue	2021-03-23 00:00:00
1797	103	4433	457	1	3	1	405.78	38.00	Entregue	2021-02-20 00:00:00
1798	1252	4559	457	1	3	1	653.91	44.66	Entregue	2021-06-26 00:00:00
1799	1236	4708	457	1	3	1	8.82	47.45	Entregue	2021-11-22 00:00:00
1800	875	4609	457	1	3	1	2553.12	68.60	Entregue	2021-08-15 00:00:00
1801	1255	4412	457	1	3	1	185.46	58.10	Entregue	2021-01-30 00:00:00
1802	420	4802	457	1	3	1	120.87	24.40	Entregue	2022-02-24 00:00:00
1803	1651	4623	457	1	3	1	0.01	50.49	Entregue	2021-08-29 00:00:00
1804	1722	4778	457	1	3	1	2259.93	36.25	Entregue	2022-01-31 00:00:00
1805	1322	4549	457	1	3	1	15290.05	68.67	Entregue	2021-06-16 00:00:00
1806	845	4514	457	1	3	1	586.20	68.76	Entregue	2021-05-12 00:00:00
1807	1985	4479	457	1	3	1	17.65	22.94	Entregue	2021-04-07 00:00:00
1808	1761	4636	457	1	3	1	52.86	60.52	Entregue	2021-09-11 00:00:00
1809	196	4730	457	1	3	1	324.39	69.48	Entregue	2021-12-14 00:00:00
1810	291	4874	457	1	3	1	98.71	42.67	Entregue	2022-05-07 00:00:00
1811	1069	4659	457	1	3	1	23.21	49.42	Entregue	2021-10-04 00:00:00
1812	1361	4760	457	1	3	1	5826.71	67.89	Entregue	2022-01-13 00:00:00
1813	61	4747	457	1	3	1	12.99	64.50	Entregue	2021-12-31 00:00:00
1814	1043	4672	457	1	3	1	1.89	21.99	Entregue	2021-10-17 00:00:00
1815	602	4711	457	1	3	1	2583.33	38.60	Entregue	2021-11-25 00:00:00
1816	691	4547	457	1	3	1	0.01	56.77	Entregue	2021-06-14 00:00:00
1817	697	4427	457	1	3	1	1723.71	42.28	Entregue	2021-02-14 00:00:00
1818	705	4532	457	1	3	1	120.03	34.89	Entregue	2021-05-30 00:00:00
1819	104	4504	457	1	3	1	285.29	62.03	Entregue	2021-05-02 00:00:00
1820	1032	4737	457	1	3	1	2554.88	51.88	Entregue	2021-12-21 00:00:00
1821	171	4563	457	1	3	1	911.67	66.66	Entregue	2021-06-30 00:00:00
1822	1591	4553	457	1	3	1	1296.84	57.13	Entregue	2021-06-20 00:00:00
1823	1729	4616	457	1	3	1	3322.36	48.58	Entregue	2021-08-22 00:00:00
1824	1988	4662	457	1	3	1	20.03	52.51	Entregue	2021-10-07 00:00:00
1825	397	4629	457	1	3	1	4765.25	46.89	Entregue	2021-09-04 00:00:00
1826	604	4636	457	1	3	1	1122.68	62.11	Entregue	2021-09-11 00:00:00
1827	427	4668	457	1	3	1	5001.70	39.20	Entregue	2021-10-13 00:00:00
1828	347	4428	457	1	3	1	2552.45	61.91	Entregue	2021-02-15 00:00:00
1829	179	4614	457	1	3	1	529.94	68.52	Entregue	2021-08-20 00:00:00
1830	562	4875	457	1	3	1	2471.78	39.02	Entregue	2022-05-08 00:00:00
1831	636	4877	457	1	3	1	140.87	22.96	Entregue	2022-05-10 00:00:00
1832	1228	4504	457	1	3	1	4389.59	55.42	Entregue	2021-05-02 00:00:00
1833	1652	4553	457	1	3	1	1799.63	50.95	Entregue	2021-06-20 00:00:00
1834	1518	4517	457	1	3	1	2022.96	34.72	Entregue	2021-05-15 00:00:00
1835	1387	4658	457	1	3	1	4998.66	20.67	Entregue	2021-10-03 00:00:00
1836	1819	4856	457	1	3	1	3452.95	33.92	Entregue	2022-04-19 00:00:00
1837	445	4610	457	1	3	1	124.46	43.43	Entregue	2021-08-16 00:00:00
1838	889	4651	457	1	3	1	164.63	32.59	Entregue	2021-09-26 00:00:00
1839	1611	4605	457	1	3	1	121.55	39.78	Entregue	2021-08-11 00:00:00
1840	1724	4458	457	1	3	1	3099.99	55.70	Entregue	2021-03-17 00:00:00
1841	1746	4558	457	1	3	1	12361.11	55.25	Entregue	2021-06-25 00:00:00
1842	253	4397	457	1	3	1	630.48	41.86	Entregue	2021-01-15 00:00:00
1843	1369	4555	457	1	3	1	1128.77	38.32	Entregue	2021-06-22 00:00:00
1844	692	4784	457	1	3	1	94.18	54.54	Entregue	2022-02-06 00:00:00
1845	581	4839	457	1	3	1	74.06	36.26	Entregue	2022-04-02 00:00:00
1846	14	4686	457	1	3	1	0.01	53.89	Entregue	2021-10-31 00:00:00
1847	109	4586	457	1	3	1	29.13	49.70	Entregue	2021-07-23 00:00:00
1848	133	4624	457	1	3	1	154.61	40.17	Entregue	2021-08-30 00:00:00
1849	1134	4424	457	1	3	1	0.01	41.21	Entregue	2021-02-11 00:00:00
1850	1237	4772	457	1	3	1	69.46	26.17	Entregue	2022-01-25 00:00:00
1851	1511	4774	457	1	3	1	735.65	22.28	Entregue	2022-01-27 00:00:00
1852	1818	4711	457	1	3	1	265.08	44.32	Entregue	2021-11-25 00:00:00
1853	603	4800	457	1	3	1	3887.24	58.80	Entregue	2022-02-22 00:00:00
1854	383	4413	457	1	3	1	4685.71	46.46	Entregue	2021-01-31 00:00:00
1855	301	4706	457	1	3	1	11726.62	32.13	Entregue	2021-11-20 00:00:00
1856	7	4539	457	1	3	1	0.01	25.08	Entregue	2021-06-06 00:00:00
1857	1011	4524	457	1	3	1	8405.26	42.99	Entregue	2021-05-22 00:00:00
1858	757	4852	457	1	3	1	337.77	26.24	Entregue	2022-04-15 00:00:00
1859	1600	4605	457	1	3	1	293.42	52.71	Entregue	2021-08-11 00:00:00
1860	771	4682	457	1	3	1	3101.31	36.22	Entregue	2021-10-27 00:00:00
1861	1497	4648	457	1	3	1	3954.38	41.64	Entregue	2021-09-23 00:00:00
1862	1875	4696	457	1	3	1	3039.32	28.89	Entregue	2021-11-10 00:00:00
1863	1618	4654	457	1	3	1	13304.11	31.69	Entregue	2021-09-29 00:00:00
1864	1402	4762	457	1	3	1	2651.89	59.38	Entregue	2022-01-15 00:00:00
1865	432	4848	457	1	3	1	1156.53	69.83	Entregue	2022-04-11 00:00:00
1866	1582	4462	457	1	3	1	11798.84	64.25	Entregue	2021-03-21 00:00:00
1867	1763	4797	457	1	3	1	397.72	50.21	Entregue	2022-02-19 00:00:00
1868	1347	4568	457	1	3	1	12172.16	42.14	Entregue	2021-07-05 00:00:00
1869	1061	4410	457	1	3	1	6661.76	68.42	Entregue	2021-01-28 00:00:00
1870	319	4559	457	1	3	1	2669.97	27.12	Entregue	2021-06-26 00:00:00
1871	1417	4800	457	1	3	1	36.66	62.29	Entregue	2022-02-22 00:00:00
1872	1	4451	457	1	3	1	3930.09	66.97	Entregue	2021-03-10 00:00:00
1873	76	4456	457	1	3	1	0.01	65.13	Entregue	2021-03-15 00:00:00
1874	1392	4600	457	1	3	1	8459.93	54.06	Entregue	2021-08-06 00:00:00
1875	346	4659	457	1	3	1	2646.54	31.69	Entregue	2021-10-04 00:00:00
1876	71	4595	457	1	3	1	761.95	61.86	Entregue	2021-08-01 00:00:00
1877	267	4552	457	1	3	1	3418.77	41.47	Entregue	2021-06-19 00:00:00
1878	68	4394	457	1	3	1	14794.93	47.87	Entregue	2021-01-12 00:00:00
1879	1002	4540	457	1	3	1	4664.51	24.13	Entregue	2021-06-07 00:00:00
1880	773	4633	457	1	3	1	784.40	52.49	Entregue	2021-09-08 00:00:00
1881	1817	4654	457	1	3	1	2086.64	48.68	Entregue	2021-09-29 00:00:00
1882	146	4709	457	1	3	1	896.78	33.62	Entregue	2021-11-23 00:00:00
1883	80	4824	457	1	3	1	476.29	59.67	Entregue	2022-03-18 00:00:00
1884	861	4643	457	1	3	1	2655.16	21.63	Entregue	2021-09-18 00:00:00
1885	162	4809	457	1	3	1	2525.93	56.83	Entregue	2022-03-03 00:00:00
1886	738	4474	457	1	3	1	677.68	62.52	Entregue	2021-04-02 00:00:00
1887	797	4747	457	1	3	1	2374.89	53.30	Entregue	2021-12-31 00:00:00
1888	1633	4523	457	1	3	1	0.01	22.28	Entregue	2021-05-21 00:00:00
1889	582	4398	457	1	3	1	0.01	57.02	Entregue	2021-01-16 00:00:00
1890	1676	4495	457	1	3	1	151.62	44.74	Entregue	2021-04-23 00:00:00
1891	1095	4599	457	1	3	1	0.01	22.19	Entregue	2021-08-05 00:00:00
1892	1958	4856	457	1	3	1	123.93	66.95	Entregue	2022-04-19 00:00:00
1893	1973	4785	457	1	3	1	644.17	23.87	Entregue	2022-02-07 00:00:00
1894	1386	4541	457	1	3	1	417.93	58.29	Entregue	2021-06-08 00:00:00
1895	751	4659	457	1	3	1	0.01	58.80	Entregue	2021-10-04 00:00:00
1896	237	4512	457	1	3	1	12339.51	51.62	Entregue	2021-05-10 00:00:00
1897	1892	4671	457	1	3	1	2434.36	20.97	Entregue	2021-10-16 00:00:00
1898	262	4622	457	1	3	1	0.01	64.01	Entregue	2021-08-28 00:00:00
1899	337	4684	457	1	3	1	4843.27	57.78	Entregue	2021-10-29 00:00:00
1900	1997	4865	457	1	3	1	77.60	51.71	Entregue	2022-04-28 00:00:00
1901	1689	4640	457	1	3	1	470.13	53.43	Entregue	2021-09-15 00:00:00
1902	504	4671	457	1	3	1	269.27	23.25	Entregue	2021-10-16 00:00:00
1903	1504	4507	457	1	3	1	0.01	52.15	Entregue	2021-05-05 00:00:00
1904	399	4605	457	1	3	1	15115.37	28.06	Entregue	2021-08-11 00:00:00
1905	238	4649	457	1	3	1	48.27	59.86	Entregue	2021-09-24 00:00:00
1906	1699	4867	457	1	3	1	464.69	66.25	Entregue	2022-04-30 00:00:00
1907	547	4547	457	1	3	1	0.01	21.04	Entregue	2021-06-14 00:00:00
1908	818	4899	457	1	3	1	1611.50	36.20	Entregue	2022-06-01 00:00:00
1909	737	4913	457	1	3	1	1415.48	26.30	Entregue	2022-06-15 00:00:00
1910	569	4912	457	1	3	1	1147.10	38.47	Entregue	2022-06-14 00:00:00
1911	124	4434	457	1	3	1	0.01	43.18	Entregue	2021-02-21 00:00:00
1912	452	4810	457	1	3	1	0.01	38.79	Entregue	2022-03-04 00:00:00
1913	798	4510	457	1	3	1	823.58	48.55	Entregue	2021-05-08 00:00:00
1914	200	4914	457	1	3	1	3316.01	56.06	Entregue	2022-06-16 00:00:00
1915	1623	4564	457	1	3	1	1109.95	66.67	Entregue	2021-07-01 00:00:00
1916	990	4837	457	1	3	1	8718.50	66.69	Entregue	2022-03-31 00:00:00
1917	685	4412	457	1	3	1	124.90	67.43	Entregue	2021-01-30 00:00:00
1918	905	4821	457	1	3	1	290.03	63.69	Entregue	2022-03-15 00:00:00
1919	1379	4568	457	1	3	1	5532.86	51.15	Entregue	2021-07-05 00:00:00
1920	973	4606	457	1	3	1	3482.91	20.96	Entregue	2021-08-12 00:00:00
1921	79	4438	457	1	3	1	2788.35	45.40	Entregue	2021-02-25 00:00:00
1922	1532	4888	457	1	3	1	67.24	53.40	Entregue	2022-05-21 00:00:00
1923	1925	4781	457	1	3	1	3213.71	44.23	Entregue	2022-02-03 00:00:00
1924	1895	4604	457	1	3	1	109.11	24.94	Entregue	2021-08-10 00:00:00
1925	1448	4873	457	1	3	1	0.01	60.62	Entregue	2022-05-06 00:00:00
1926	17	4752	457	1	3	1	4185.42	65.19	Entregue	2022-01-05 00:00:00
1927	1116	4605	457	1	3	1	736.08	26.98	Entregue	2021-08-11 00:00:00
1928	1290	4865	457	1	3	1	5224.41	64.84	Entregue	2022-04-28 00:00:00
1929	1070	4546	457	1	3	1	3326.63	37.72	Entregue	2021-06-13 00:00:00
1930	404	4388	457	1	3	1	10826.35	59.10	Entregue	2021-01-06 00:00:00
1931	997	4661	457	1	3	1	2451.39	58.99	Entregue	2021-10-06 00:00:00
1932	1280	4504	457	1	3	1	177.70	47.77	Entregue	2021-05-02 00:00:00
1933	1029	4641	457	1	3	1	0.01	40.88	Entregue	2021-09-16 00:00:00
1934	1068	4863	457	1	3	1	2857.16	63.49	Entregue	2022-04-26 00:00:00
1935	1245	4608	457	1	3	1	125.45	44.73	Entregue	2021-08-14 00:00:00
1936	616	4563	457	1	3	1	1945.64	55.07	Entregue	2021-06-30 00:00:00
1937	1211	4891	457	1	3	1	1555.89	56.87	Entregue	2022-05-24 00:00:00
1938	1393	4705	457	1	3	1	4180.23	48.64	Entregue	2021-11-19 00:00:00
1939	83	4775	457	1	3	1	411.67	69.14	Entregue	2022-01-28 00:00:00
1940	63	4820	457	1	3	1	182.02	53.84	Entregue	2022-03-14 00:00:00
1941	516	4809	457	1	3	1	349.20	64.00	Entregue	2022-03-03 00:00:00
1942	542	4744	457	1	3	1	6666.46	68.77	Entregue	2021-12-28 00:00:00
1943	395	4411	457	1	3	1	7191.27	27.09	Entregue	2021-01-29 00:00:00
1944	1294	4831	457	1	3	1	584.38	29.21	Entregue	2022-03-25 00:00:00
1945	882	4524	457	1	3	1	0.01	28.42	Entregue	2021-05-22 00:00:00
1946	955	4779	457	1	3	1	12472.92	55.78	Entregue	2022-02-01 00:00:00
1947	274	4672	457	1	3	1	0.01	45.78	Entregue	2021-10-17 00:00:00
1948	1876	4669	457	1	3	1	358.08	64.30	Entregue	2021-10-14 00:00:00
1949	1304	4483	457	1	3	1	4441.28	45.48	Entregue	2021-04-11 00:00:00
1950	1590	4561	457	1	3	1	4134.46	41.91	Entregue	2021-06-28 00:00:00
1951	1904	4389	457	1	3	1	2315.51	46.58	Entregue	2021-01-07 00:00:00
1952	801	4424	457	1	3	1	89.50	53.60	Entregue	2021-02-11 00:00:00
1953	163	4892	457	1	3	1	3039.82	31.51	Entregue	2022-05-25 00:00:00
1954	1302	4692	457	1	3	1	6564.99	67.87	Entregue	2021-11-06 00:00:00
1955	1103	4564	457	1	3	1	4907.03	61.95	Entregue	2021-07-01 00:00:00
1956	669	4517	457	1	3	1	13216.11	69.92	Entregue	2021-05-15 00:00:00
1957	223	4736	457	1	3	1	267.62	26.42	Entregue	2021-12-20 00:00:00
1958	352	4665	457	1	3	1	1581.72	54.78	Entregue	2021-10-10 00:00:00
1959	1512	4511	457	1	3	1	239.02	34.47	Entregue	2021-05-09 00:00:00
1960	362	4396	457	1	3	1	536.88	48.75	Entregue	2021-01-14 00:00:00
1961	221	4738	457	1	3	1	4563.44	53.69	Entregue	2021-12-22 00:00:00
1962	688	4899	457	1	3	1	137.74	61.22	Entregue	2022-06-01 00:00:00
1963	1288	4856	457	1	3	1	3494.79	39.69	Entregue	2022-04-19 00:00:00
1964	1207	4563	457	1	3	1	3358.50	51.76	Entregue	2021-06-30 00:00:00
1965	111	4413	457	1	3	1	4021.77	45.77	Entregue	2021-01-31 00:00:00
1966	1093	4796	457	1	3	1	1058.59	42.18	Entregue	2022-02-18 00:00:00
1967	1076	4870	457	1	3	1	0.01	63.04	Entregue	2022-05-03 00:00:00
1968	1709	4658	457	1	3	1	680.40	44.41	Entregue	2021-10-03 00:00:00
1969	968	4662	457	1	3	1	4707.64	27.36	Entregue	2021-10-07 00:00:00
1970	16	4853	457	1	3	1	479.30	35.79	Entregue	2022-04-16 00:00:00
1971	1659	4451	457	1	3	1	0.01	22.60	Entregue	2021-03-10 00:00:00
1972	326	4795	457	1	3	1	2074.67	54.02	Entregue	2022-02-17 00:00:00
1973	1879	4615	457	1	3	1	3251.46	33.99	Entregue	2021-08-21 00:00:00
1974	371	4455	457	1	3	1	843.71	63.16	Entregue	2021-03-14 00:00:00
1975	1939	4479	457	1	3	1	874.58	24.58	Entregue	2021-04-07 00:00:00
1976	655	4457	457	1	3	1	44.37	65.75	Entregue	2021-03-16 00:00:00
1977	1327	4394	457	1	3	1	316.40	68.22	Entregue	2021-01-12 00:00:00
1978	1450	4722	457	1	3	1	596.68	43.21	Entregue	2021-12-06 00:00:00
1979	183	4594	457	1	3	1	287.85	20.09	Entregue	2021-07-31 00:00:00
1980	1225	4593	457	1	3	1	4591.04	60.72	Entregue	2021-07-30 00:00:00
1981	150	4649	457	1	3	1	402.73	26.44	Entregue	2021-09-24 00:00:00
1982	656	4898	457	1	3	1	302.17	65.42	Entregue	2022-05-31 00:00:00
1983	1731	4480	457	1	3	1	8732.86	62.30	Entregue	2021-04-08 00:00:00
1984	122	4515	457	1	3	1	91.03	36.12	Entregue	2021-05-13 00:00:00
1985	1355	4880	457	1	3	1	434.16	57.50	Entregue	2022-05-13 00:00:00
1986	648	4389	457	1	3	1	7206.21	60.01	Entregue	2021-01-07 00:00:00
1987	570	4560	457	1	3	1	443.28	38.55	Entregue	2021-06-27 00:00:00
1988	923	4839	457	1	3	1	2157.14	38.82	Entregue	2022-04-02 00:00:00
1989	995	4829	457	1	3	1	0.01	38.68	Entregue	2022-03-23 00:00:00
1990	1867	4831	457	1	3	1	2310.21	40.40	Entregue	2022-03-25 00:00:00
1991	1014	4828	457	1	3	1	853.97	65.53	Entregue	2022-03-22 00:00:00
1992	1125	4633	457	1	3	1	280.83	24.13	Entregue	2021-09-08 00:00:00
1993	530	4413	457	1	3	1	3357.15	49.28	Entregue	2021-01-31 00:00:00
1994	928	4676	457	1	3	1	0.01	21.64	Entregue	2021-10-21 00:00:00
1995	536	4797	457	1	3	1	0.01	34.14	Entregue	2022-02-19 00:00:00
1996	1715	4824	457	1	3	1	1574.52	39.98	Entregue	2022-03-18 00:00:00
1997	520	4677	457	1	3	1	0.01	66.06	Entregue	2021-10-22 00:00:00
1998	55	4621	457	1	3	1	2637.50	38.28	Entregue	2021-08-27 00:00:00
1999	148	4867	457	1	3	1	72.89	27.46	Entregue	2022-04-30 00:00:00
2000	790	4774	457	1	3	1	1473.63	50.44	Entregue	2022-01-27 00:00:00
\.


--
-- Data for Name: fato_transacao_financeira; Type: TABLE DATA; Schema: financeiro; Owner: postgres
--

COPY financeiro.fato_transacao_financeira (id_transacao, numero_transacao, fk_data_pagamento, fk_forma_pagamento, tipo_transacao, valor_total_transacao, status_transacao, historico, data_hora_lancamento) FROM stdin;
1	1798	4853	3	Credito	2815.73	Paga	Receita de venda - Pedido #1798	2026-05-20 02:08:03.924705
2	1489	4503	3	Credito	309.10	Paga	Receita de venda - Pedido #1489	2026-05-20 02:08:03.924705
3	1269	4677	3	Credito	0.01	Paga	Receita de venda - Pedido #1269	2026-05-20 02:08:03.924705
4	652	4418	3	Credito	507.88	Paga	Receita de venda - Pedido #652	2026-05-20 02:08:03.924705
5	273	4440	3	Credito	4275.35	Paga	Receita de venda - Pedido #273	2026-05-20 02:08:03.924705
6	1560	4442	3	Credito	332.15	Paga	Receita de venda - Pedido #1560	2026-05-20 02:08:03.924705
7	51	4741	3	Credito	1.68	Paga	Receita de venda - Pedido #51	2026-05-20 02:08:03.924705
8	951	4485	3	Credito	16.50	Paga	Receita de venda - Pedido #951	2026-05-20 02:08:03.924705
9	1898	4629	3	Credito	22161.35	Paga	Receita de venda - Pedido #1898	2026-05-20 02:08:03.924705
10	70	4512	3	Credito	1609.40	Paga	Receita de venda - Pedido #70	2026-05-20 02:08:03.924705
11	350	4520	3	Credito	4133.28	Paga	Receita de venda - Pedido #350	2026-05-20 02:08:03.924705
12	758	4522	3	Credito	375.17	Paga	Receita de venda - Pedido #758	2026-05-20 02:08:03.924705
13	1750	4600	3	Credito	4525.28	Paga	Receita de venda - Pedido #1750	2026-05-20 02:08:03.924705
14	1136	4654	3	Credito	138.69	Paga	Receita de venda - Pedido #1136	2026-05-20 02:08:03.924705
15	176	4793	3	Credito	258.81	Paga	Receita de venda - Pedido #176	2026-05-20 02:08:03.924705
16	576	4577	3	Credito	1843.20	Paga	Receita de venda - Pedido #576	2026-05-20 02:08:03.924705
17	1831	4631	3	Credito	0.01	Paga	Receita de venda - Pedido #1831	2026-05-20 02:08:03.924705
18	1003	4537	3	Credito	20.02	Paga	Receita de venda - Pedido #1003	2026-05-20 02:08:03.924705
19	292	4687	3	Credito	2066.98	Paga	Receita de venda - Pedido #292	2026-05-20 02:08:03.924705
20	1331	4874	3	Credito	4941.16	Paga	Receita de venda - Pedido #1331	2026-05-20 02:08:03.924705
21	929	4884	3	Credito	3249.64	Paga	Receita de venda - Pedido #929	2026-05-20 02:08:03.924705
22	663	4646	3	Credito	490.25	Paga	Receita de venda - Pedido #663	2026-05-20 02:08:03.924705
23	1552	4740	3	Credito	336.93	Paga	Receita de venda - Pedido #1552	2026-05-20 02:08:03.924705
24	1589	4446	3	Credito	3867.36	Paga	Receita de venda - Pedido #1589	2026-05-20 02:08:03.924705
25	1493	4626	3	Credito	16827.73	Paga	Receita de venda - Pedido #1493	2026-05-20 02:08:03.924705
26	1811	4734	3	Credito	151.16	Paga	Receita de venda - Pedido #1811	2026-05-20 02:08:03.924705
27	1373	4668	3	Credito	334.68	Paga	Receita de venda - Pedido #1373	2026-05-20 02:08:03.924705
28	764	4514	3	Credito	47.00	Paga	Receita de venda - Pedido #764	2026-05-20 02:08:03.924705
29	556	4883	3	Credito	2268.28	Paga	Receita de venda - Pedido #556	2026-05-20 02:08:03.924705
30	1268	4854	3	Credito	0.01	Paga	Receita de venda - Pedido #1268	2026-05-20 02:08:03.924705
31	638	4677	3	Credito	410.58	Paga	Receita de venda - Pedido #638	2026-05-20 02:08:03.924705
32	940	4491	3	Credito	19672.77	Paga	Receita de venda - Pedido #940	2026-05-20 02:08:03.924705
33	173	4534	3	Credito	216.01	Paga	Receita de venda - Pedido #173	2026-05-20 02:08:03.924705
34	1963	4697	3	Credito	5643.76	Paga	Receita de venda - Pedido #1963	2026-05-20 02:08:03.924705
35	42	4706	3	Credito	2678.58	Paga	Receita de venda - Pedido #42	2026-05-20 02:08:03.924705
36	876	4870	3	Credito	0.01	Paga	Receita de venda - Pedido #876	2026-05-20 02:08:03.924705
37	161	4562	3	Credito	4251.28	Paga	Receita de venda - Pedido #161	2026-05-20 02:08:03.924705
38	113	4849	3	Credito	1555.83	Paga	Receita de venda - Pedido #113	2026-05-20 02:08:03.924705
39	1742	4420	3	Credito	2950.00	Paga	Receita de venda - Pedido #1742	2026-05-20 02:08:03.924705
40	1595	4549	3	Credito	2983.47	Paga	Receita de venda - Pedido #1595	2026-05-20 02:08:03.924705
41	1372	4898	3	Credito	24815.75	Paga	Receita de venda - Pedido #1372	2026-05-20 02:08:03.924705
42	632	4450	3	Credito	8817.16	Paga	Receita de venda - Pedido #632	2026-05-20 02:08:03.924705
43	658	4873	3	Credito	13160.21	Paga	Receita de venda - Pedido #658	2026-05-20 02:08:03.924705
44	815	4459	3	Credito	7363.72	Paga	Receita de venda - Pedido #815	2026-05-20 02:08:03.924705
45	1422	4685	3	Credito	1725.35	Paga	Receita de venda - Pedido #1422	2026-05-20 02:08:03.924705
46	440	4701	3	Credito	231.98	Paga	Receita de venda - Pedido #440	2026-05-20 02:08:03.924705
47	1004	4559	3	Credito	287.13	Paga	Receita de venda - Pedido #1004	2026-05-20 02:08:03.924705
48	57	4725	3	Credito	2182.90	Paga	Receita de venda - Pedido #57	2026-05-20 02:08:03.924705
49	1313	4552	3	Credito	1591.83	Paga	Receita de venda - Pedido #1313	2026-05-20 02:08:03.924705
50	19	4796	3	Credito	1497.08	Paga	Receita de venda - Pedido #19	2026-05-20 02:08:03.924705
51	160	4892	3	Credito	1296.24	Paga	Receita de venda - Pedido #160	2026-05-20 02:08:03.924705
52	644	4824	3	Credito	2312.85	Paga	Receita de venda - Pedido #644	2026-05-20 02:08:03.924705
53	824	4578	3	Credito	13321.12	Paga	Receita de venda - Pedido #824	2026-05-20 02:08:03.924705
54	1857	4416	3	Credito	140.11	Paga	Receita de venda - Pedido #1857	2026-05-20 02:08:03.924705
55	1262	4850	3	Credito	8042.54	Paga	Receita de venda - Pedido #1262	2026-05-20 02:08:03.924705
56	357	4622	3	Credito	0.01	Paga	Receita de venda - Pedido #357	2026-05-20 02:08:03.924705
57	1143	4483	3	Credito	1431.16	Paga	Receita de venda - Pedido #1143	2026-05-20 02:08:03.924705
58	1782	4896	3	Credito	979.88	Paga	Receita de venda - Pedido #1782	2026-05-20 02:08:03.924705
59	769	4812	3	Credito	562.15	Paga	Receita de venda - Pedido #769	2026-05-20 02:08:03.924705
60	266	4892	3	Credito	250.03	Paga	Receita de venda - Pedido #266	2026-05-20 02:08:03.924705
61	1550	4434	3	Credito	11844.71	Paga	Receita de venda - Pedido #1550	2026-05-20 02:08:03.924705
62	1287	4861	3	Credito	612.83	Paga	Receita de venda - Pedido #1287	2026-05-20 02:08:03.924705
63	366	4854	3	Credito	1856.95	Paga	Receita de venda - Pedido #366	2026-05-20 02:08:03.924705
64	307	4490	3	Credito	115.80	Paga	Receita de venda - Pedido #307	2026-05-20 02:08:03.924705
65	1644	4751	3	Credito	1046.85	Paga	Receita de venda - Pedido #1644	2026-05-20 02:08:03.924705
66	91	4863	3	Credito	655.13	Paga	Receita de venda - Pedido #91	2026-05-20 02:08:03.924705
67	305	4478	3	Credito	6203.28	Paga	Receita de venda - Pedido #305	2026-05-20 02:08:03.924705
68	1606	4579	3	Credito	277.01	Paga	Receita de venda - Pedido #1606	2026-05-20 02:08:03.924705
69	1312	4462	3	Credito	7407.86	Paga	Receita de venda - Pedido #1312	2026-05-20 02:08:03.924705
70	743	4520	3	Credito	0.01	Paga	Receita de venda - Pedido #743	2026-05-20 02:08:03.924705
71	1484	4748	3	Credito	8712.20	Paga	Receita de venda - Pedido #1484	2026-05-20 02:08:03.924705
72	10	4741	3	Credito	3244.78	Paga	Receita de venda - Pedido #10	2026-05-20 02:08:03.924705
73	1940	4845	3	Credito	0.01	Paga	Receita de venda - Pedido #1940	2026-05-20 02:08:03.924705
74	1984	4568	3	Credito	778.38	Paga	Receita de venda - Pedido #1984	2026-05-20 02:08:03.924705
75	1602	4802	3	Credito	2412.40	Paga	Receita de venda - Pedido #1602	2026-05-20 02:08:03.924705
76	1662	4386	3	Credito	3.80	Paga	Receita de venda - Pedido #1662	2026-05-20 02:08:03.924705
77	823	4743	3	Credito	132.40	Paga	Receita de venda - Pedido #823	2026-05-20 02:08:03.924705
78	822	4616	3	Credito	1406.59	Paga	Receita de venda - Pedido #822	2026-05-20 02:08:03.924705
79	1118	4662	3	Credito	2265.16	Paga	Receita de venda - Pedido #1118	2026-05-20 02:08:03.924705
80	1990	4568	3	Credito	0.01	Paga	Receita de venda - Pedido #1990	2026-05-20 02:08:03.924705
81	1025	4513	3	Credito	5.85	Paga	Receita de venda - Pedido #1025	2026-05-20 02:08:03.924705
82	241	4384	3	Credito	0.01	Paga	Receita de venda - Pedido #241	2026-05-20 02:08:03.924705
83	175	4730	3	Credito	0.01	Paga	Receita de venda - Pedido #175	2026-05-20 02:08:03.924705
84	596	4488	3	Credito	11826.00	Paga	Receita de venda - Pedido #596	2026-05-20 02:08:03.924705
85	50	4773	3	Credito	540.27	Paga	Receita de venda - Pedido #50	2026-05-20 02:08:03.924705
86	13	4654	3	Credito	112.37	Paga	Receita de venda - Pedido #13	2026-05-20 02:08:03.924705
87	1319	4448	3	Credito	228.19	Paga	Receita de venda - Pedido #1319	2026-05-20 02:08:03.924705
88	1776	4823	3	Credito	318.32	Paga	Receita de venda - Pedido #1776	2026-05-20 02:08:03.924705
89	1104	4392	3	Credito	1237.74	Paga	Receita de venda - Pedido #1104	2026-05-20 02:08:03.924705
90	2	4620	3	Credito	0.01	Paga	Receita de venda - Pedido #2	2026-05-20 02:08:03.924705
91	699	4606	3	Credito	164.26	Paga	Receita de venda - Pedido #699	2026-05-20 02:08:03.924705
92	1975	4504	3	Credito	2436.96	Paga	Receita de venda - Pedido #1975	2026-05-20 02:08:03.924705
93	1936	4911	3	Credito	4567.18	Paga	Receita de venda - Pedido #1936	2026-05-20 02:08:03.924705
94	1603	4774	3	Credito	0.01	Paga	Receita de venda - Pedido #1603	2026-05-20 02:08:03.924705
95	246	4798	3	Credito	247.03	Paga	Receita de venda - Pedido #246	2026-05-20 02:08:03.924705
96	75	4389	3	Credito	708.87	Paga	Receita de venda - Pedido #75	2026-05-20 02:08:03.924705
97	128	4636	3	Credito	1254.26	Paga	Receita de venda - Pedido #128	2026-05-20 02:08:03.924705
98	1942	4645	3	Credito	267.96	Paga	Receita de venda - Pedido #1942	2026-05-20 02:08:03.924705
99	1992	4411	3	Credito	17.57	Paga	Receita de venda - Pedido #1992	2026-05-20 02:08:03.924705
100	344	4482	3	Credito	115.96	Paga	Receita de venda - Pedido #344	2026-05-20 02:08:03.924705
101	1078	4524	3	Credito	145.27	Paga	Receita de venda - Pedido #1078	2026-05-20 02:08:03.924705
102	534	4688	3	Credito	6670.91	Paga	Receita de venda - Pedido #534	2026-05-20 02:08:03.924705
103	1522	4416	3	Credito	2509.64	Paga	Receita de venda - Pedido #1522	2026-05-20 02:08:03.924705
104	1967	4797	3	Credito	6891.08	Paga	Receita de venda - Pedido #1967	2026-05-20 02:08:03.924705
105	637	4668	3	Credito	61.94	Paga	Receita de venda - Pedido #637	2026-05-20 02:08:03.924705
106	355	4517	3	Credito	22321.10	Paga	Receita de venda - Pedido #355	2026-05-20 02:08:03.924705
107	1279	4424	3	Credito	3239.98	Paga	Receita de venda - Pedido #1279	2026-05-20 02:08:03.924705
108	1403	4503	3	Credito	148.87	Paga	Receita de venda - Pedido #1403	2026-05-20 02:08:03.924705
109	222	4568	3	Credito	423.40	Paga	Receita de venda - Pedido #222	2026-05-20 02:08:03.924705
110	1006	4884	3	Credito	0.01	Paga	Receita de venda - Pedido #1006	2026-05-20 02:08:03.924705
111	922	4497	3	Credito	0.01	Paga	Receita de venda - Pedido #922	2026-05-20 02:08:03.924705
112	453	4775	3	Credito	403.25	Paga	Receita de venda - Pedido #453	2026-05-20 02:08:03.924705
113	787	4595	3	Credito	20.78	Paga	Receita de venda - Pedido #787	2026-05-20 02:08:03.924705
114	182	4532	3	Credito	2285.39	Paga	Receita de venda - Pedido #182	2026-05-20 02:08:03.924705
115	1950	4688	3	Credito	19742.06	Paga	Receita de venda - Pedido #1950	2026-05-20 02:08:03.924705
116	528	4633	3	Credito	351.43	Paga	Receita de venda - Pedido #528	2026-05-20 02:08:03.924705
117	1549	4839	3	Credito	2935.98	Paga	Receita de venda - Pedido #1549	2026-05-20 02:08:03.924705
118	811	4697	3	Credito	667.89	Paga	Receita de venda - Pedido #811	2026-05-20 02:08:03.924705
119	563	4784	3	Credito	111.86	Paga	Receita de venda - Pedido #563	2026-05-20 02:08:03.924705
120	1474	4706	3	Credito	711.44	Paga	Receita de venda - Pedido #1474	2026-05-20 02:08:03.924705
121	1616	4725	3	Credito	90.60	Paga	Receita de venda - Pedido #1616	2026-05-20 02:08:03.924705
122	1613	4713	3	Credito	138.80	Paga	Receita de venda - Pedido #1613	2026-05-20 02:08:03.924705
123	667	4408	3	Credito	2112.23	Paga	Receita de venda - Pedido #667	2026-05-20 02:08:03.924705
124	481	4738	3	Credito	3953.67	Paga	Receita de venda - Pedido #481	2026-05-20 02:08:03.924705
125	1828	4665	3	Credito	2435.95	Paga	Receita de venda - Pedido #1828	2026-05-20 02:08:03.924705
126	1779	4478	3	Credito	99.78	Paga	Receita de venda - Pedido #1779	2026-05-20 02:08:03.924705
127	1804	4818	3	Credito	5389.32	Paga	Receita de venda - Pedido #1804	2026-05-20 02:08:03.924705
128	438	4534	3	Credito	140.98	Paga	Receita de venda - Pedido #438	2026-05-20 02:08:03.924705
129	382	4612	3	Credito	2371.94	Paga	Receita de venda - Pedido #382	2026-05-20 02:08:03.924705
130	853	4478	3	Credito	3895.20	Paga	Receita de venda - Pedido #853	2026-05-20 02:08:03.924705
131	378	4415	3	Credito	1147.50	Paga	Receita de venda - Pedido #378	2026-05-20 02:08:03.924705
132	1349	4824	3	Credito	0.01	Paga	Receita de venda - Pedido #1349	2026-05-20 02:08:03.924705
133	1050	4851	3	Credito	89.83	Paga	Receita de venda - Pedido #1050	2026-05-20 02:08:03.924705
134	1788	4644	3	Credito	2279.63	Paga	Receita de venda - Pedido #1788	2026-05-20 02:08:03.924705
135	799	4644	3	Credito	468.67	Paga	Receita de venda - Pedido #799	2026-05-20 02:08:03.924705
136	276	4695	3	Credito	3015.45	Paga	Receita de venda - Pedido #276	2026-05-20 02:08:03.924705
137	1523	4530	3	Credito	3328.25	Paga	Receita de venda - Pedido #1523	2026-05-20 02:08:03.924705
138	1044	4510	3	Credito	7860.01	Paga	Receita de venda - Pedido #1044	2026-05-20 02:08:03.924705
139	97	4711	3	Credito	907.17	Paga	Receita de venda - Pedido #97	2026-05-20 02:08:03.924705
140	1823	4550	3	Credito	2284.22	Paga	Receita de venda - Pedido #1823	2026-05-20 02:08:03.924705
141	1848	4752	3	Credito	2304.83	Paga	Receita de venda - Pedido #1848	2026-05-20 02:08:03.924705
142	589	4460	3	Credito	2059.68	Paga	Receita de venda - Pedido #589	2026-05-20 02:08:03.924705
143	1167	4524	3	Credito	3744.06	Paga	Receita de venda - Pedido #1167	2026-05-20 02:08:03.924705
144	555	4886	3	Credito	599.26	Paga	Receita de venda - Pedido #555	2026-05-20 02:08:03.924705
145	1583	4825	3	Credito	0.01	Paga	Receita de venda - Pedido #1583	2026-05-20 02:08:03.924705
146	682	4405	3	Credito	1832.60	Paga	Receita de venda - Pedido #682	2026-05-20 02:08:03.924705
147	567	4584	3	Credito	212.66	Paga	Receita de venda - Pedido #567	2026-05-20 02:08:03.924705
148	329	4854	3	Credito	221.11	Paga	Receita de venda - Pedido #329	2026-05-20 02:08:03.924705
149	44	4810	3	Credito	63.49	Paga	Receita de venda - Pedido #44	2026-05-20 02:08:03.924705
150	1144	4446	3	Credito	274.40	Paga	Receita de venda - Pedido #1144	2026-05-20 02:08:03.924705
151	816	4555	3	Credito	4466.62	Paga	Receita de venda - Pedido #816	2026-05-20 02:08:03.924705
152	1585	4852	3	Credito	0.01	Paga	Receita de venda - Pedido #1585	2026-05-20 02:08:03.924705
153	1646	4464	3	Credito	3692.72	Paga	Receita de venda - Pedido #1646	2026-05-20 02:08:03.924705
154	1398	4865	3	Credito	1721.64	Paga	Receita de venda - Pedido #1398	2026-05-20 02:08:03.924705
155	1987	4564	3	Credito	1500.70	Paga	Receita de venda - Pedido #1987	2026-05-20 02:08:03.924705
156	1022	4478	3	Credito	4687.80	Paga	Receita de venda - Pedido #1022	2026-05-20 02:08:03.924705
157	507	4450	3	Credito	0.01	Paga	Receita de venda - Pedido #507	2026-05-20 02:08:03.924705
158	944	4515	3	Credito	1399.07	Paga	Receita de venda - Pedido #944	2026-05-20 02:08:03.924705
159	847	4627	3	Credito	1017.42	Paga	Receita de venda - Pedido #847	2026-05-20 02:08:03.924705
160	419	4741	3	Credito	13438.60	Paga	Receita de venda - Pedido #419	2026-05-20 02:08:03.924705
161	1336	4883	3	Credito	13114.77	Paga	Receita de venda - Pedido #1336	2026-05-20 02:08:03.924705
162	664	4843	3	Credito	84.73	Paga	Receita de venda - Pedido #664	2026-05-20 02:08:03.924705
163	551	4686	3	Credito	93.62	Paga	Receita de venda - Pedido #551	2026-05-20 02:08:03.924705
164	948	4504	3	Credito	2178.23	Paga	Receita de venda - Pedido #948	2026-05-20 02:08:03.924705
165	95	4792	3	Credito	8626.64	Paga	Receita de venda - Pedido #95	2026-05-20 02:08:03.924705
166	1540	4830	3	Credito	7148.72	Paga	Receita de venda - Pedido #1540	2026-05-20 02:08:03.924705
167	1434	4631	3	Credito	228.51	Paga	Receita de venda - Pedido #1434	2026-05-20 02:08:03.924705
168	519	4709	3	Credito	1135.65	Paga	Receita de venda - Pedido #519	2026-05-20 02:08:03.924705
169	1250	4410	3	Credito	1092.64	Paga	Receita de venda - Pedido #1250	2026-05-20 02:08:03.924705
170	965	4660	3	Credito	152.72	Paga	Receita de venda - Pedido #965	2026-05-20 02:08:03.924705
171	172	4420	3	Credito	345.75	Paga	Receita de venda - Pedido #172	2026-05-20 02:08:03.924705
172	1966	4654	3	Credito	574.45	Paga	Receita de venda - Pedido #1966	2026-05-20 02:08:03.924705
173	409	4658	3	Credito	2902.78	Paga	Receita de venda - Pedido #409	2026-05-20 02:08:03.924705
174	30	4776	3	Credito	11256.93	Paga	Receita de venda - Pedido #30	2026-05-20 02:08:03.924705
175	521	4466	3	Credito	0.01	Paga	Receita de venda - Pedido #521	2026-05-20 02:08:03.924705
176	936	4748	3	Credito	11620.33	Paga	Receita de venda - Pedido #936	2026-05-20 02:08:03.924705
177	1561	4480	3	Credito	14844.82	Paga	Receita de venda - Pedido #1561	2026-05-20 02:08:03.924705
178	981	4421	3	Credito	3580.78	Paga	Receita de venda - Pedido #981	2026-05-20 02:08:03.924705
179	1334	4912	3	Credito	4747.14	Paga	Receita de venda - Pedido #1334	2026-05-20 02:08:03.924705
180	1221	4855	3	Credito	0.01	Paga	Receita de venda - Pedido #1221	2026-05-20 02:08:03.924705
181	249	4425	3	Credito	0.01	Paga	Receita de venda - Pedido #249	2026-05-20 02:08:03.924705
182	255	4576	3	Credito	2729.79	Paga	Receita de venda - Pedido #255	2026-05-20 02:08:03.924705
183	1678	4613	3	Credito	5069.58	Paga	Receita de venda - Pedido #1678	2026-05-20 02:08:03.924705
184	639	4537	3	Credito	2554.42	Paga	Receita de venda - Pedido #639	2026-05-20 02:08:03.924705
185	296	4658	3	Credito	3829.01	Paga	Receita de venda - Pedido #296	2026-05-20 02:08:03.924705
186	209	4615	3	Credito	1794.41	Paga	Receita de venda - Pedido #209	2026-05-20 02:08:03.924705
187	74	4422	3	Credito	2248.12	Paga	Receita de venda - Pedido #74	2026-05-20 02:08:03.924705
188	937	4450	3	Credito	2.07	Paga	Receita de venda - Pedido #937	2026-05-20 02:08:03.924705
189	138	4753	3	Credito	287.81	Paga	Receita de venda - Pedido #138	2026-05-20 02:08:03.924705
190	34	4697	3	Credito	1663.69	Paga	Receita de venda - Pedido #34	2026-05-20 02:08:03.924705
191	1774	4434	3	Credito	0.01	Paga	Receita de venda - Pedido #1774	2026-05-20 02:08:03.924705
192	1747	4775	3	Credito	0.01	Paga	Receita de venda - Pedido #1747	2026-05-20 02:08:03.924705
193	1748	4510	3	Credito	0.01	Paga	Receita de venda - Pedido #1748	2026-05-20 02:08:03.924705
194	947	4531	3	Credito	81.45	Paga	Receita de venda - Pedido #947	2026-05-20 02:08:03.924705
195	1411	4397	3	Credito	89.16	Paga	Receita de venda - Pedido #1411	2026-05-20 02:08:03.924705
196	972	4873	3	Credito	0.01	Paga	Receita de venda - Pedido #972	2026-05-20 02:08:03.924705
197	761	4584	3	Credito	21.09	Paga	Receita de venda - Pedido #761	2026-05-20 02:08:03.924705
198	1084	4855	3	Credito	661.29	Paga	Receita de venda - Pedido #1084	2026-05-20 02:08:03.924705
199	90	4640	3	Credito	0.01	Paga	Receita de venda - Pedido #90	2026-05-20 02:08:03.924705
200	1681	4890	3	Credito	2048.25	Paga	Receita de venda - Pedido #1681	2026-05-20 02:08:03.924705
201	1956	4416	3	Credito	0.01	Paga	Receita de venda - Pedido #1956	2026-05-20 02:08:03.924705
202	904	4903	3	Credito	15.71	Paga	Receita de venda - Pedido #904	2026-05-20 02:08:03.924705
203	443	4816	3	Credito	825.76	Paga	Receita de venda - Pedido #443	2026-05-20 02:08:03.924705
204	526	4843	3	Credito	3326.50	Paga	Receita de venda - Pedido #526	2026-05-20 02:08:03.924705
205	1428	4810	3	Credito	11808.94	Paga	Receita de venda - Pedido #1428	2026-05-20 02:08:03.924705
206	393	4495	3	Credito	142.81	Paga	Receita de venda - Pedido #393	2026-05-20 02:08:03.924705
207	524	4562	3	Credito	0.01	Paga	Receita de venda - Pedido #524	2026-05-20 02:08:03.924705
208	312	4511	3	Credito	528.29	Paga	Receita de venda - Pedido #312	2026-05-20 02:08:03.924705
209	1151	4647	3	Credito	504.44	Paga	Receita de venda - Pedido #1151	2026-05-20 02:08:03.924705
210	498	4640	3	Credito	66.85	Paga	Receita de venda - Pedido #498	2026-05-20 02:08:03.924705
211	862	4398	3	Credito	768.94	Paga	Receita de venda - Pedido #862	2026-05-20 02:08:03.924705
212	1185	4607	3	Credito	167.04	Paga	Receita de venda - Pedido #1185	2026-05-20 02:08:03.924705
213	494	4638	3	Credito	1796.65	Paga	Receita de venda - Pedido #494	2026-05-20 02:08:03.924705
214	469	4760	3	Credito	2387.85	Paga	Receita de venda - Pedido #469	2026-05-20 02:08:03.924705
215	118	4898	3	Credito	450.61	Paga	Receita de venda - Pedido #118	2026-05-20 02:08:03.924705
216	1265	4867	3	Credito	2383.43	Paga	Receita de venda - Pedido #1265	2026-05-20 02:08:03.924705
217	1793	4626	3	Credito	492.47	Paga	Receita de venda - Pedido #1793	2026-05-20 02:08:03.924705
218	1986	4832	3	Credito	6875.66	Paga	Receita de venda - Pedido #1986	2026-05-20 02:08:03.924705
219	488	4705	3	Credito	629.59	Paga	Receita de venda - Pedido #488	2026-05-20 02:08:03.924705
220	1101	4438	3	Credito	0.01	Paga	Receita de venda - Pedido #1101	2026-05-20 02:08:03.924705
221	1048	4510	3	Credito	6700.17	Paga	Receita de venda - Pedido #1048	2026-05-20 02:08:03.924705
222	1995	4590	3	Credito	782.21	Paga	Receita de venda - Pedido #1995	2026-05-20 02:08:03.924705
223	360	4621	3	Credito	916.51	Paga	Receita de venda - Pedido #360	2026-05-20 02:08:03.924705
224	1770	4880	3	Credito	5322.20	Paga	Receita de venda - Pedido #1770	2026-05-20 02:08:03.924705
225	99	4916	3	Credito	167.42	Paga	Receita de venda - Pedido #99	2026-05-20 02:08:03.924705
226	629	4553	3	Credito	0.01	Paga	Receita de venda - Pedido #629	2026-05-20 02:08:03.924705
227	726	4809	3	Credito	246.74	Paga	Receita de venda - Pedido #726	2026-05-20 02:08:03.924705
228	1215	4722	3	Credito	1390.71	Paga	Receita de venda - Pedido #1215	2026-05-20 02:08:03.924705
229	1476	4580	3	Credito	3199.81	Paga	Receita de venda - Pedido #1476	2026-05-20 02:08:03.924705
230	1727	4622	3	Credito	2824.87	Paga	Receita de venda - Pedido #1727	2026-05-20 02:08:03.924705
231	442	4585	3	Credito	986.01	Paga	Receita de venda - Pedido #442	2026-05-20 02:08:03.924705
232	354	4613	3	Credito	2877.05	Paga	Receita de venda - Pedido #354	2026-05-20 02:08:03.924705
233	1238	4682	3	Credito	2563.71	Paga	Receita de venda - Pedido #1238	2026-05-20 02:08:03.924705
234	12	4796	3	Credito	118.05	Paga	Receita de venda - Pedido #12	2026-05-20 02:08:03.924705
235	1792	4682	3	Credito	0.01	Paga	Receita de venda - Pedido #1792	2026-05-20 02:08:03.924705
236	479	4389	3	Credito	0.01	Paga	Receita de venda - Pedido #479	2026-05-20 02:08:03.924705
237	1354	4697	3	Credito	161.56	Paga	Receita de venda - Pedido #1354	2026-05-20 02:08:03.924705
238	1976	4751	3	Credito	375.36	Paga	Receita de venda - Pedido #1976	2026-05-20 02:08:03.924705
239	1574	4497	3	Credito	1973.81	Paga	Receita de venda - Pedido #1574	2026-05-20 02:08:03.924705
240	1283	4485	3	Credito	226.82	Paga	Receita de venda - Pedido #1283	2026-05-20 02:08:03.924705
241	1503	4778	3	Credito	5782.10	Paga	Receita de venda - Pedido #1503	2026-05-20 02:08:03.924705
242	899	4829	3	Credito	554.20	Paga	Receita de venda - Pedido #899	2026-05-20 02:08:03.924705
243	935	4744	3	Credito	1278.55	Paga	Receita de venda - Pedido #935	2026-05-20 02:08:03.924705
244	675	4530	3	Credito	233.97	Paga	Receita de venda - Pedido #675	2026-05-20 02:08:03.924705
245	696	4826	3	Credito	61.68	Paga	Receita de venda - Pedido #696	2026-05-20 02:08:03.924705
246	969	4649	3	Credito	1784.73	Paga	Receita de venda - Pedido #969	2026-05-20 02:08:03.924705
247	264	4646	3	Credito	2660.91	Paga	Receita de venda - Pedido #264	2026-05-20 02:08:03.924705
248	1253	4856	3	Credito	168.00	Paga	Receita de venda - Pedido #1253	2026-05-20 02:08:03.924705
249	270	4888	3	Credito	5382.75	Paga	Receita de venda - Pedido #270	2026-05-20 02:08:03.924705
250	898	4507	3	Credito	1434.62	Paga	Receita de venda - Pedido #898	2026-05-20 02:08:03.924705
251	435	4797	3	Credito	420.54	Paga	Receita de venda - Pedido #435	2026-05-20 02:08:03.924705
252	384	4548	3	Credito	98.99	Paga	Receita de venda - Pedido #384	2026-05-20 02:08:03.924705
253	1713	4684	3	Credito	1827.10	Paga	Receita de venda - Pedido #1713	2026-05-20 02:08:03.924705
254	1145	4568	3	Credito	2497.86	Paga	Receita de venda - Pedido #1145	2026-05-20 02:08:03.924705
255	837	4830	3	Credito	2976.04	Paga	Receita de venda - Pedido #837	2026-05-20 02:08:03.924705
256	826	4665	3	Credito	7569.69	Paga	Receita de venda - Pedido #826	2026-05-20 02:08:03.924705
257	431	4697	3	Credito	58.21	Paga	Receita de venda - Pedido #431	2026-05-20 02:08:03.924705
258	1226	4559	3	Credito	6615.28	Paga	Receita de venda - Pedido #1226	2026-05-20 02:08:03.924705
259	911	4752	3	Credito	7807.99	Paga	Receita de venda - Pedido #911	2026-05-20 02:08:03.924705
260	491	4859	3	Credito	997.60	Paga	Receita de venda - Pedido #491	2026-05-20 02:08:03.924705
261	462	4827	3	Credito	0.01	Paga	Receita de venda - Pedido #462	2026-05-20 02:08:03.924705
262	855	4440	3	Credito	0.01	Paga	Receita de venda - Pedido #855	2026-05-20 02:08:03.924705
263	1615	4706	3	Credito	5000.55	Paga	Receita de venda - Pedido #1615	2026-05-20 02:08:03.924705
264	1248	4621	3	Credito	6802.99	Paga	Receita de venda - Pedido #1248	2026-05-20 02:08:03.924705
265	436	4883	3	Credito	147.89	Paga	Receita de venda - Pedido #436	2026-05-20 02:08:03.924705
266	870	4562	3	Credito	225.59	Paga	Receita de venda - Pedido #870	2026-05-20 02:08:03.924705
267	1564	4537	3	Credito	374.17	Paga	Receita de venda - Pedido #1564	2026-05-20 02:08:03.924705
268	1397	4689	3	Credito	305.17	Paga	Receita de venda - Pedido #1397	2026-05-20 02:08:03.924705
269	1844	4720	3	Credito	0.01	Paga	Receita de venda - Pedido #1844	2026-05-20 02:08:03.924705
270	1579	4504	3	Credito	0.01	Paga	Receita de venda - Pedido #1579	2026-05-20 02:08:03.924705
271	711	4437	3	Credito	3910.37	Paga	Receita de venda - Pedido #711	2026-05-20 02:08:03.924705
272	768	4757	3	Credito	1578.30	Paga	Receita de venda - Pedido #768	2026-05-20 02:08:03.924705
273	1036	4820	3	Credito	56.56	Paga	Receita de venda - Pedido #1036	2026-05-20 02:08:03.924705
274	838	4692	3	Credito	0.01	Paga	Receita de venda - Pedido #838	2026-05-20 02:08:03.924705
275	149	4795	3	Credito	3501.96	Paga	Receita de venda - Pedido #149	2026-05-20 02:08:03.924705
276	280	4586	3	Credito	8680.43	Paga	Receita de venda - Pedido #280	2026-05-20 02:08:03.924705
277	1928	4659	3	Credito	624.98	Paga	Receita de venda - Pedido #1928	2026-05-20 02:08:03.924705
278	88	4495	3	Credito	0.01	Paga	Receita de venda - Pedido #88	2026-05-20 02:08:03.924705
279	188	4900	3	Credito	523.77	Paga	Receita de venda - Pedido #188	2026-05-20 02:08:03.924705
280	461	4761	3	Credito	1689.26	Paga	Receita de venda - Pedido #461	2026-05-20 02:08:03.924705
281	240	4564	3	Credito	3968.06	Paga	Receita de venda - Pedido #240	2026-05-20 02:08:03.924705
282	1878	4779	3	Credito	862.14	Paga	Receita de venda - Pedido #1878	2026-05-20 02:08:03.924705
283	1467	4478	3	Credito	1903.63	Paga	Receita de venda - Pedido #1467	2026-05-20 02:08:03.924705
284	1046	4618	3	Credito	7883.27	Paga	Receita de venda - Pedido #1046	2026-05-20 02:08:03.924705
285	1328	4610	3	Credito	2664.23	Paga	Receita de venda - Pedido #1328	2026-05-20 02:08:03.924705
286	1932	4823	3	Credito	3768.41	Paga	Receita de venda - Pedido #1932	2026-05-20 02:08:03.924705
287	650	4524	3	Credito	2272.60	Paga	Receita de venda - Pedido #650	2026-05-20 02:08:03.924705
288	703	4397	3	Credito	36.81	Paga	Receita de venda - Pedido #703	2026-05-20 02:08:03.924705
289	226	4762	3	Credito	1720.09	Paga	Receita de venda - Pedido #226	2026-05-20 02:08:03.924705
290	1161	4791	3	Credito	939.67	Paga	Receita de venda - Pedido #1161	2026-05-20 02:08:03.924705
291	843	4421	3	Credito	3931.11	Paga	Receita de venda - Pedido #843	2026-05-20 02:08:03.924705
292	447	4437	3	Credito	2230.99	Paga	Receita de venda - Pedido #447	2026-05-20 02:08:03.924705
293	1911	4523	3	Credito	4997.02	Paga	Receita de venda - Pedido #1911	2026-05-20 02:08:03.924705
294	298	4510	3	Credito	0.01	Paga	Receita de venda - Pedido #298	2026-05-20 02:08:03.924705
295	1647	4820	3	Credito	855.35	Paga	Receita de venda - Pedido #1647	2026-05-20 02:08:03.924705
296	81	4560	3	Credito	1402.59	Paga	Receita de venda - Pedido #81	2026-05-20 02:08:03.924705
297	1684	4412	3	Credito	0.01	Paga	Receita de venda - Pedido #1684	2026-05-20 02:08:03.924705
298	1944	4609	3	Credito	9998.87	Paga	Receita de venda - Pedido #1944	2026-05-20 02:08:03.924705
299	1639	4560	3	Credito	477.49	Paga	Receita de venda - Pedido #1639	2026-05-20 02:08:03.924705
300	800	4648	3	Credito	12249.65	Paga	Receita de venda - Pedido #800	2026-05-20 02:08:03.924705
301	1495	4832	3	Credito	5281.75	Paga	Receita de venda - Pedido #1495	2026-05-20 02:08:03.924705
302	204	4708	3	Credito	2078.45	Paga	Receita de venda - Pedido #204	2026-05-20 02:08:03.924705
303	1021	4875	3	Credito	2786.48	Paga	Receita de venda - Pedido #1021	2026-05-20 02:08:03.924705
304	5	4649	3	Credito	414.77	Paga	Receita de venda - Pedido #5	2026-05-20 02:08:03.924705
305	1165	4713	3	Credito	482.50	Paga	Receita de venda - Pedido #1165	2026-05-20 02:08:03.924705
306	1608	4734	3	Credito	0.01	Paga	Receita de venda - Pedido #1608	2026-05-20 02:08:03.924705
307	1429	4708	3	Credito	98.98	Paga	Receita de venda - Pedido #1429	2026-05-20 02:08:03.924705
308	283	4436	3	Credito	0.01	Paga	Receita de venda - Pedido #283	2026-05-20 02:08:03.924705
309	807	4662	3	Credito	171.66	Paga	Receita de venda - Pedido #807	2026-05-20 02:08:03.924705
310	624	4687	3	Credito	0.01	Paga	Receita de venda - Pedido #624	2026-05-20 02:08:03.924705
311	681	4521	3	Credito	323.37	Paga	Receita de venda - Pedido #681	2026-05-20 02:08:03.924705
312	361	4546	3	Credito	109.24	Paga	Receita de venda - Pedido #361	2026-05-20 02:08:03.924705
313	1173	4466	3	Credito	3329.50	Paga	Receita de venda - Pedido #1173	2026-05-20 02:08:03.924705
314	1508	4735	3	Credito	2296.96	Paga	Receita de venda - Pedido #1508	2026-05-20 02:08:03.924705
315	829	4413	3	Credito	3871.69	Paga	Receita de venda - Pedido #829	2026-05-20 02:08:03.924705
316	1557	4837	3	Credito	344.17	Paga	Receita de venda - Pedido #1557	2026-05-20 02:08:03.924705
317	785	4544	3	Credito	402.69	Paga	Receita de venda - Pedido #785	2026-05-20 02:08:03.924705
318	643	4701	3	Credito	0.01	Paga	Receita de venda - Pedido #643	2026-05-20 02:08:03.924705
319	472	4888	3	Credito	0.01	Paga	Receita de venda - Pedido #472	2026-05-20 02:08:03.924705
320	444	4682	3	Credito	18865.74	Paga	Receita de venda - Pedido #444	2026-05-20 02:08:03.924705
321	537	4863	3	Credito	5164.57	Paga	Receita de venda - Pedido #537	2026-05-20 02:08:03.924705
322	1914	4633	3	Credito	599.50	Paga	Receita de venda - Pedido #1914	2026-05-20 02:08:03.924705
323	1401	4850	3	Credito	463.94	Paga	Receita de venda - Pedido #1401	2026-05-20 02:08:03.924705
324	373	4679	3	Credito	126.15	Paga	Receita de venda - Pedido #373	2026-05-20 02:08:03.924705
325	252	4912	3	Credito	351.80	Paga	Receita de venda - Pedido #252	2026-05-20 02:08:03.924705
326	343	4737	3	Credito	2158.65	Paga	Receita de venda - Pedido #343	2026-05-20 02:08:03.924705
327	31	4592	3	Credito	2177.37	Paga	Receita de venda - Pedido #31	2026-05-20 02:08:03.924705
328	1199	4561	3	Credito	905.06	Paga	Receita de venda - Pedido #1199	2026-05-20 02:08:03.924705
329	1316	4483	3	Credito	2556.25	Paga	Receita de venda - Pedido #1316	2026-05-20 02:08:03.924705
330	1086	4642	3	Credito	22327.43	Paga	Receita de venda - Pedido #1086	2026-05-20 02:08:03.924705
331	722	4384	3	Credito	1056.36	Paga	Receita de venda - Pedido #722	2026-05-20 02:08:03.924705
332	1757	4633	3	Credito	11253.13	Paga	Receita de venda - Pedido #1757	2026-05-20 02:08:03.924705
333	1097	4649	3	Credito	1436.60	Paga	Receita de venda - Pedido #1097	2026-05-20 02:08:03.924705
334	199	4747	3	Credito	3519.68	Paga	Receita de venda - Pedido #199	2026-05-20 02:08:03.924705
335	1374	4877	3	Credito	13220.26	Paga	Receita de venda - Pedido #1374	2026-05-20 02:08:03.924705
336	369	4537	3	Credito	1228.31	Paga	Receita de venda - Pedido #369	2026-05-20 02:08:03.924705
337	243	4792	3	Credito	1451.30	Paga	Receita de venda - Pedido #243	2026-05-20 02:08:03.924705
338	1264	4857	3	Credito	0.01	Paga	Receita de venda - Pedido #1264	2026-05-20 02:08:03.924705
339	902	4647	3	Credito	54.58	Paga	Receita de venda - Pedido #902	2026-05-20 02:08:03.924705
340	1309	4515	3	Credito	1692.00	Paga	Receita de venda - Pedido #1309	2026-05-20 02:08:03.924705
341	1142	4736	3	Credito	0.01	Paga	Receita de venda - Pedido #1142	2026-05-20 02:08:03.924705
342	740	4478	3	Credito	136.55	Paga	Receita de venda - Pedido #740	2026-05-20 02:08:03.924705
343	1178	4398	3	Credito	8702.17	Paga	Receita de venda - Pedido #1178	2026-05-20 02:08:03.924705
344	856	4678	3	Credito	527.50	Paga	Receita de venda - Pedido #856	2026-05-20 02:08:03.924705
345	230	4645	3	Credito	74.47	Paga	Receita de venda - Pedido #230	2026-05-20 02:08:03.924705
346	1864	4831	3	Credito	3151.91	Paga	Receita de venda - Pedido #1864	2026-05-20 02:08:03.924705
347	1917	4897	3	Credito	3403.98	Paga	Receita de venda - Pedido #1917	2026-05-20 02:08:03.924705
348	1663	4760	3	Credito	519.48	Paga	Receita de venda - Pedido #1663	2026-05-20 02:08:03.924705
349	78	4802	3	Credito	2166.15	Paga	Receita de venda - Pedido #78	2026-05-20 02:08:03.924705
350	573	4720	3	Credito	11271.05	Paga	Receita de venda - Pedido #573	2026-05-20 02:08:03.924705
351	1998	4698	3	Credito	14877.02	Paga	Receita de venda - Pedido #1998	2026-05-20 02:08:03.924705
352	1451	4747	3	Credito	2863.50	Paga	Receita de venda - Pedido #1451	2026-05-20 02:08:03.924705
353	987	4665	3	Credito	528.76	Paga	Receita de venda - Pedido #987	2026-05-20 02:08:03.924705
354	852	4398	3	Credito	3765.06	Paga	Receita de venda - Pedido #852	2026-05-20 02:08:03.924705
355	250	4796	3	Credito	1925.50	Paga	Receita de venda - Pedido #250	2026-05-20 02:08:03.924705
356	1927	4772	3	Credito	7709.60	Paga	Receita de venda - Pedido #1927	2026-05-20 02:08:03.924705
357	611	4730	3	Credito	0.01	Paga	Receita de venda - Pedido #611	2026-05-20 02:08:03.924705
358	621	4482	3	Credito	157.21	Paga	Receita de venda - Pedido #621	2026-05-20 02:08:03.924705
359	1246	4412	3	Credito	604.81	Paga	Receita de venda - Pedido #1246	2026-05-20 02:08:03.924705
360	1382	4446	3	Credito	4151.07	Paga	Receita de venda - Pedido #1382	2026-05-20 02:08:03.924705
361	1206	4854	3	Credito	815.96	Paga	Receita de venda - Pedido #1206	2026-05-20 02:08:03.924705
362	1852	4507	3	Credito	5244.16	Paga	Receita de venda - Pedido #1852	2026-05-20 02:08:03.924705
363	1937	4897	3	Credito	1332.86	Paga	Receita de venda - Pedido #1937	2026-05-20 02:08:03.924705
364	585	4450	3	Credito	0.01	Paga	Receita de venda - Pedido #585	2026-05-20 02:08:03.924705
365	1775	4858	3	Credito	248.00	Paga	Receita de venda - Pedido #1775	2026-05-20 02:08:03.924705
366	1310	4587	3	Credito	3340.91	Paga	Receita de venda - Pedido #1310	2026-05-20 02:08:03.924705
367	708	4748	3	Credito	6693.85	Paga	Receita de venda - Pedido #708	2026-05-20 02:08:03.924705
368	455	4724	3	Credito	2763.29	Paga	Receita de venda - Pedido #455	2026-05-20 02:08:03.924705
369	1630	4576	3	Credito	757.40	Paga	Receita de venda - Pedido #1630	2026-05-20 02:08:03.924705
370	1693	4862	3	Credito	196.07	Paga	Receita de venda - Pedido #1693	2026-05-20 02:08:03.924705
371	1592	4811	3	Credito	0.01	Paga	Receita de venda - Pedido #1592	2026-05-20 02:08:03.924705
372	713	4534	3	Credito	0.01	Paga	Receita de venda - Pedido #713	2026-05-20 02:08:03.924705
373	1205	4547	3	Credito	2019.57	Paga	Receita de venda - Pedido #1205	2026-05-20 02:08:03.924705
374	448	4448	3	Credito	2749.28	Paga	Receita de venda - Pedido #448	2026-05-20 02:08:03.924705
375	930	4691	3	Credito	4183.46	Paga	Receita de venda - Pedido #930	2026-05-20 02:08:03.924705
376	701	4737	3	Credito	4902.26	Paga	Receita de venda - Pedido #701	2026-05-20 02:08:03.924705
377	1861	4759	3	Credito	578.33	Paga	Receita de venda - Pedido #1861	2026-05-20 02:08:03.924705
378	1092	4762	3	Credito	0.01	Paga	Receita de venda - Pedido #1092	2026-05-20 02:08:03.924705
379	132	4466	3	Credito	13652.86	Paga	Receita de venda - Pedido #132	2026-05-20 02:08:03.924705
380	322	4541	3	Credito	2588.13	Paga	Receita de venda - Pedido #322	2026-05-20 02:08:03.924705
381	1414	4590	3	Credito	2607.48	Paga	Receita de venda - Pedido #1414	2026-05-20 02:08:03.924705
382	1953	4626	3	Credito	1147.15	Paga	Receita de venda - Pedido #1953	2026-05-20 02:08:03.924705
383	863	4678	3	Credito	1003.59	Paga	Receita de venda - Pedido #863	2026-05-20 02:08:03.924705
384	1106	4748	3	Credito	0.01	Paga	Receita de venda - Pedido #1106	2026-05-20 02:08:03.924705
385	1886	4815	3	Credito	841.98	Paga	Receita de venda - Pedido #1886	2026-05-20 02:08:03.924705
386	1052	4652	3	Credito	183.95	Paga	Receita de venda - Pedido #1052	2026-05-20 02:08:03.924705
387	1413	4441	3	Credito	1978.27	Paga	Receita de venda - Pedido #1413	2026-05-20 02:08:03.924705
388	289	4547	3	Credito	1538.12	Paga	Receita de venda - Pedido #289	2026-05-20 02:08:03.924705
389	583	4384	3	Credito	984.62	Paga	Receita de venda - Pedido #583	2026-05-20 02:08:03.924705
390	65	4405	3	Credito	465.75	Paga	Receita de venda - Pedido #65	2026-05-20 02:08:03.924705
391	1202	4464	3	Credito	4680.90	Paga	Receita de venda - Pedido #1202	2026-05-20 02:08:03.924705
392	693	4709	3	Credito	645.11	Paga	Receita de venda - Pedido #693	2026-05-20 02:08:03.924705
393	1400	4455	3	Credito	670.73	Paga	Receita de venda - Pedido #1400	2026-05-20 02:08:03.924705
394	744	4587	3	Credito	1392.57	Paga	Receita de venda - Pedido #744	2026-05-20 02:08:03.924705
395	1462	4586	3	Credito	11.66	Paga	Receita de venda - Pedido #1462	2026-05-20 02:08:03.924705
396	527	4387	3	Credito	6453.15	Paga	Receita de venda - Pedido #527	2026-05-20 02:08:03.924705
397	490	4740	3	Credito	2781.94	Paga	Receita de venda - Pedido #490	2026-05-20 02:08:03.924705
398	627	4413	3	Credito	0.01	Paga	Receita de venda - Pedido #627	2026-05-20 02:08:03.924705
399	119	4721	3	Credito	747.12	Paga	Receita de venda - Pedido #119	2026-05-20 02:08:03.924705
400	286	4589	3	Credito	582.54	Paga	Receita de venda - Pedido #286	2026-05-20 02:08:03.924705
401	376	4398	3	Credito	118.57	Paga	Receita de venda - Pedido #376	2026-05-20 02:08:03.924705
402	147	4897	3	Credito	4849.68	Paga	Receita de venda - Pedido #147	2026-05-20 02:08:03.924705
403	860	4877	3	Credito	763.29	Paga	Receita de venda - Pedido #860	2026-05-20 02:08:03.924705
404	480	4408	3	Credito	3947.21	Paga	Receita de venda - Pedido #480	2026-05-20 02:08:03.924705
405	1834	4916	3	Credito	3852.62	Paga	Receita de venda - Pedido #1834	2026-05-20 02:08:03.924705
406	1941	4413	3	Credito	159.91	Paga	Receita de venda - Pedido #1941	2026-05-20 02:08:03.924705
407	1470	4568	3	Credito	296.79	Paga	Receita de venda - Pedido #1470	2026-05-20 02:08:03.924705
408	989	4533	3	Credito	4420.81	Paga	Receita de venda - Pedido #989	2026-05-20 02:08:03.924705
409	535	4386	3	Credito	990.87	Paga	Receita de venda - Pedido #535	2026-05-20 02:08:03.924705
410	1159	4611	3	Credito	3343.69	Paga	Receita de venda - Pedido #1159	2026-05-20 02:08:03.924705
411	642	4464	3	Credito	0.01	Paga	Receita de venda - Pedido #642	2026-05-20 02:08:03.924705
412	725	4861	3	Credito	927.56	Paga	Receita de venda - Pedido #725	2026-05-20 02:08:03.924705
413	832	4665	3	Credito	4875.94	Paga	Receita de venda - Pedido #832	2026-05-20 02:08:03.924705
414	907	4912	3	Credito	9829.57	Paga	Receita de venda - Pedido #907	2026-05-20 02:08:03.924705
415	1784	4680	3	Credito	1902.54	Paga	Receita de venda - Pedido #1784	2026-05-20 02:08:03.924705
416	1766	4831	3	Credito	1648.88	Paga	Receita de venda - Pedido #1766	2026-05-20 02:08:03.924705
417	1001	4833	3	Credito	2069.36	Paga	Receita de venda - Pedido #1001	2026-05-20 02:08:03.924705
418	746	4912	3	Credito	2956.41	Paga	Receita de venda - Pedido #746	2026-05-20 02:08:03.924705
419	1469	4462	3	Credito	856.15	Paga	Receita de venda - Pedido #1469	2026-05-20 02:08:03.924705
420	1820	4490	3	Credito	93.51	Paga	Receita de venda - Pedido #1820	2026-05-20 02:08:03.924705
421	1863	4612	3	Credito	22165.60	Paga	Receita de venda - Pedido #1863	2026-05-20 02:08:03.924705
422	1764	4649	3	Credito	6573.15	Paga	Receita de venda - Pedido #1764	2026-05-20 02:08:03.924705
423	1335	4391	3	Credito	69.39	Paga	Receita de venda - Pedido #1335	2026-05-20 02:08:03.924705
424	1305	4459	3	Credito	738.95	Paga	Receita de venda - Pedido #1305	2026-05-20 02:08:03.924705
425	1943	4424	3	Credito	236.07	Paga	Receita de venda - Pedido #1943	2026-05-20 02:08:03.924705
426	1568	4460	3	Credito	0.01	Paga	Receita de venda - Pedido #1568	2026-05-20 02:08:03.924705
427	1297	4384	3	Credito	3087.52	Paga	Receita de venda - Pedido #1297	2026-05-20 02:08:03.924705
428	1869	4624	3	Credito	234.07	Paga	Receita de venda - Pedido #1869	2026-05-20 02:08:03.924705
429	918	4773	3	Credito	0.01	Paga	Receita de venda - Pedido #918	2026-05-20 02:08:03.924705
430	1293	4722	3	Credito	1361.75	Paga	Receita de venda - Pedido #1293	2026-05-20 02:08:03.924705
431	848	4385	3	Credito	0.01	Paga	Receita de venda - Pedido #848	2026-05-20 02:08:03.924705
432	1303	4694	3	Credito	290.09	Paga	Receita de venda - Pedido #1303	2026-05-20 02:08:03.924705
433	430	4436	3	Credito	10946.26	Paga	Receita de venda - Pedido #430	2026-05-20 02:08:03.924705
434	158	4460	3	Credito	0.01	Paga	Receita de venda - Pedido #158	2026-05-20 02:08:03.924705
435	1703	4721	3	Credito	373.30	Paga	Receita de venda - Pedido #1703	2026-05-20 02:08:03.924705
436	459	4750	3	Credito	319.35	Paga	Receita de venda - Pedido #459	2026-05-20 02:08:03.924705
437	1783	4490	3	Credito	11623.83	Paga	Receita de venda - Pedido #1783	2026-05-20 02:08:03.924705
438	1588	4809	3	Credito	4381.21	Paga	Receita de venda - Pedido #1588	2026-05-20 02:08:03.924705
439	123	4385	3	Credito	13154.49	Paga	Receita de venda - Pedido #123	2026-05-20 02:08:03.924705
440	1418	4476	3	Credito	2113.22	Paga	Receita de venda - Pedido #1418	2026-05-20 02:08:03.924705
441	1180	4771	3	Credito	4683.44	Paga	Receita de venda - Pedido #1180	2026-05-20 02:08:03.924705
442	881	4384	3	Credito	3359.71	Paga	Receita de venda - Pedido #881	2026-05-20 02:08:03.924705
443	385	4544	3	Credito	2506.36	Paga	Receita de venda - Pedido #385	2026-05-20 02:08:03.924705
444	492	4845	3	Credito	2963.15	Paga	Receita de venda - Pedido #492	2026-05-20 02:08:03.924705
445	544	4793	3	Credito	0.01	Paga	Receita de venda - Pedido #544	2026-05-20 02:08:03.924705
446	1631	4425	3	Credito	1961.94	Paga	Receita de venda - Pedido #1631	2026-05-20 02:08:03.924705
447	1680	4686	3	Credito	2041.37	Paga	Receita de venda - Pedido #1680	2026-05-20 02:08:03.924705
448	606	4627	3	Credito	4925.73	Paga	Receita de venda - Pedido #606	2026-05-20 02:08:03.924705
449	1667	4512	3	Credito	3178.88	Paga	Receita de venda - Pedido #1667	2026-05-20 02:08:03.924705
450	308	4529	3	Credito	79.77	Paga	Receita de venda - Pedido #308	2026-05-20 02:08:03.924705
451	880	4892	3	Credito	2295.01	Paga	Receita de venda - Pedido #880	2026-05-20 02:08:03.924705
452	1072	4695	3	Credito	11735.28	Paga	Receita de venda - Pedido #1072	2026-05-20 02:08:03.924705
453	1586	4647	3	Credito	1856.41	Paga	Receita de venda - Pedido #1586	2026-05-20 02:08:03.924705
454	248	4387	3	Credito	5519.94	Paga	Receita de venda - Pedido #248	2026-05-20 02:08:03.924705
455	1918	4570	3	Credito	3073.23	Paga	Receita de venda - Pedido #1918	2026-05-20 02:08:03.924705
456	208	4524	3	Credito	1653.51	Paga	Receita de venda - Pedido #208	2026-05-20 02:08:03.924705
457	614	4685	3	Credito	5486.57	Paga	Receita de venda - Pedido #614	2026-05-20 02:08:03.924705
458	24	4850	3	Credito	1782.88	Paga	Receita de venda - Pedido #24	2026-05-20 02:08:03.924705
459	1607	4563	3	Credito	0.01	Paga	Receita de venda - Pedido #1607	2026-05-20 02:08:03.924705
460	966	4532	3	Credito	1039.82	Paga	Receita de venda - Pedido #966	2026-05-20 02:08:03.924705
461	94	4735	3	Credito	830.63	Paga	Receita de venda - Pedido #94	2026-05-20 02:08:03.924705
462	1055	4410	3	Credito	322.40	Paga	Receita de venda - Pedido #1055	2026-05-20 02:08:03.924705
463	1188	4846	3	Credito	14892.80	Paga	Receita de venda - Pedido #1188	2026-05-20 02:08:03.924705
464	49	4813	3	Credito	1138.86	Paga	Receita de venda - Pedido #49	2026-05-20 02:08:03.924705
465	1955	4892	3	Credito	13249.80	Paga	Receita de venda - Pedido #1955	2026-05-20 02:08:03.924705
466	1502	4870	3	Credito	305.05	Paga	Receita de venda - Pedido #1502	2026-05-20 02:08:03.924705
467	1752	4662	3	Credito	357.80	Paga	Receita de venda - Pedido #1752	2026-05-20 02:08:03.924705
468	846	4688	3	Credito	5848.36	Paga	Receita de venda - Pedido #846	2026-05-20 02:08:03.924705
469	1969	4662	3	Credito	551.37	Paga	Receita de venda - Pedido #1969	2026-05-20 02:08:03.924705
470	1642	4593	3	Credito	1121.60	Paga	Receita de venda - Pedido #1642	2026-05-20 02:08:03.924705
471	1580	4679	3	Credito	0.01	Paga	Receita de venda - Pedido #1580	2026-05-20 02:08:03.924705
472	477	4865	3	Credito	9912.58	Paga	Receita de venda - Pedido #477	2026-05-20 02:08:03.924705
473	781	4627	3	Credito	4794.48	Paga	Receita de venda - Pedido #781	2026-05-20 02:08:03.924705
474	1554	4753	3	Credito	15196.36	Paga	Receita de venda - Pedido #1554	2026-05-20 02:08:03.924705
475	1362	4798	3	Credito	1606.66	Paga	Receita de venda - Pedido #1362	2026-05-20 02:08:03.924705
476	858	4858	3	Credito	560.15	Paga	Receita de venda - Pedido #858	2026-05-20 02:08:03.924705
477	1799	4854	3	Credito	1400.23	Paga	Receita de venda - Pedido #1799	2026-05-20 02:08:03.924705
478	406	4545	3	Credito	11782.29	Paga	Receita de venda - Pedido #406	2026-05-20 02:08:03.924705
479	1509	4455	3	Credito	3669.52	Paga	Receita de venda - Pedido #1509	2026-05-20 02:08:03.924705
480	1683	4870	3	Credito	2304.15	Paga	Receita de venda - Pedido #1683	2026-05-20 02:08:03.924705
481	1686	4589	3	Credito	4961.56	Paga	Receita de venda - Pedido #1686	2026-05-20 02:08:03.924705
482	849	4564	3	Credito	165.32	Paga	Receita de venda - Pedido #849	2026-05-20 02:08:03.924705
483	1573	4408	3	Credito	323.98	Paga	Receita de venda - Pedido #1573	2026-05-20 02:08:03.924705
484	1905	4671	3	Credito	3222.33	Paga	Receita de venda - Pedido #1905	2026-05-20 02:08:03.924705
485	1698	4725	3	Credito	744.61	Paga	Receita de venda - Pedido #1698	2026-05-20 02:08:03.924705
486	1348	4595	3	Credito	1937.46	Paga	Receita de venda - Pedido #1348	2026-05-20 02:08:03.924705
487	919	4735	3	Credito	15119.89	Paga	Receita de venda - Pedido #919	2026-05-20 02:08:03.924705
488	1894	4669	3	Credito	3908.30	Paga	Receita de venda - Pedido #1894	2026-05-20 02:08:03.924705
489	1096	4676	3	Credito	2641.15	Paga	Receita de venda - Pedido #1096	2026-05-20 02:08:03.924705
490	932	4906	3	Credito	362.48	Paga	Receita de venda - Pedido #932	2026-05-20 02:08:03.924705
491	1273	4594	3	Credito	13.97	Paga	Receita de venda - Pedido #1273	2026-05-20 02:08:03.924705
492	1673	4497	3	Credito	9890.55	Paga	Receita de venda - Pedido #1673	2026-05-20 02:08:03.924705
493	961	4464	3	Credito	2388.05	Paga	Receita de venda - Pedido #961	2026-05-20 02:08:03.924705
494	1433	4861	3	Credito	2446.40	Paga	Receita de venda - Pedido #1433	2026-05-20 02:08:03.924705
495	1781	4494	3	Credito	2892.33	Paga	Receita de venda - Pedido #1781	2026-05-20 02:08:03.924705
496	733	4411	3	Credito	193.42	Paga	Receita de venda - Pedido #733	2026-05-20 02:08:03.924705
497	269	4719	3	Credito	563.50	Paga	Receita de venda - Pedido #269	2026-05-20 02:08:03.924705
498	1728	4696	3	Credito	1528.98	Paga	Receita de venda - Pedido #1728	2026-05-20 02:08:03.924705
499	1594	4413	3	Credito	2311.11	Paga	Receita de venda - Pedido #1594	2026-05-20 02:08:03.924705
500	261	4428	3	Credito	3149.29	Paga	Receita de venda - Pedido #261	2026-05-20 02:08:03.924705
501	125	4595	3	Credito	797.42	Paga	Receita de venda - Pedido #125	2026-05-20 02:08:03.924705
502	1426	4875	3	Credito	2983.34	Paga	Receita de venda - Pedido #1426	2026-05-20 02:08:03.924705
503	700	4545	3	Credito	30.81	Paga	Receita de venda - Pedido #700	2026-05-20 02:08:03.924705
504	1308	4915	3	Credito	4922.68	Paga	Receita de venda - Pedido #1308	2026-05-20 02:08:03.924705
505	43	4562	3	Credito	850.98	Paga	Receita de venda - Pedido #43	2026-05-20 02:08:03.924705
506	587	4494	3	Credito	766.57	Paga	Receita de venda - Pedido #587	2026-05-20 02:08:03.924705
507	1908	4641	3	Credito	1301.26	Paga	Receita de venda - Pedido #1908	2026-05-20 02:08:03.924705
508	1649	4539	3	Credito	379.29	Paga	Receita de venda - Pedido #1649	2026-05-20 02:08:03.924705
509	1444	4641	3	Credito	7227.96	Paga	Receita de venda - Pedido #1444	2026-05-20 02:08:03.924705
510	1090	4781	3	Credito	609.33	Paga	Receita de venda - Pedido #1090	2026-05-20 02:08:03.924705
511	1687	4870	3	Credito	470.27	Paga	Receita de venda - Pedido #1687	2026-05-20 02:08:03.924705
512	349	4411	3	Credito	4938.75	Paga	Receita de venda - Pedido #349	2026-05-20 02:08:03.924705
513	187	4605	3	Credito	13449.43	Paga	Receita de venda - Pedido #187	2026-05-20 02:08:03.924705
514	766	4410	3	Credito	559.88	Paga	Receita de venda - Pedido #766	2026-05-20 02:08:03.924705
515	1533	4488	3	Credito	0.01	Paga	Receita de venda - Pedido #1533	2026-05-20 02:08:03.924705
516	1978	4585	3	Credito	500.14	Paga	Receita de venda - Pedido #1978	2026-05-20 02:08:03.924705
517	1789	4884	3	Credito	571.41	Paga	Receita de venda - Pedido #1789	2026-05-20 02:08:03.924705
518	1416	4705	3	Credito	3935.33	Paga	Receita de venda - Pedido #1416	2026-05-20 02:08:03.924705
519	242	4884	3	Credito	6016.69	Paga	Receita de venda - Pedido #242	2026-05-20 02:08:03.924705
520	1024	4768	3	Credito	2022.41	Paga	Receita de venda - Pedido #1024	2026-05-20 02:08:03.924705
521	1576	4388	3	Credito	211.87	Paga	Receita de venda - Pedido #1576	2026-05-20 02:08:03.924705
522	677	4911	3	Credito	218.07	Paga	Receita de venda - Pedido #677	2026-05-20 02:08:03.924705
523	1954	4706	3	Credito	564.56	Paga	Receita de venda - Pedido #1954	2026-05-20 02:08:03.924705
524	1232	4504	3	Credito	3850.23	Paga	Receita de venda - Pedido #1232	2026-05-20 02:08:03.924705
525	1543	4912	3	Credito	576.32	Paga	Receita de venda - Pedido #1543	2026-05-20 02:08:03.924705
526	1028	4837	3	Credito	824.65	Paga	Receita de venda - Pedido #1028	2026-05-20 02:08:03.924705
527	29	4818	3	Credito	0.01	Paga	Receita de venda - Pedido #29	2026-05-20 02:08:03.924705
528	4	4495	3	Credito	2070.92	Paga	Receita de venda - Pedido #4	2026-05-20 02:08:03.924705
529	96	4450	3	Credito	1540.12	Paga	Receita de venda - Pedido #96	2026-05-20 02:08:03.924705
530	844	4632	3	Credito	9728.30	Paga	Receita de venda - Pedido #844	2026-05-20 02:08:03.924705
531	980	4883	3	Credito	2667.38	Paga	Receita de venda - Pedido #980	2026-05-20 02:08:03.924705
532	1890	4785	3	Credito	333.14	Paga	Receita de venda - Pedido #1890	2026-05-20 02:08:03.924705
533	1787	4540	3	Credito	300.92	Paga	Receita de venda - Pedido #1787	2026-05-20 02:08:03.924705
534	1039	4462	3	Credito	56.22	Paga	Receita de venda - Pedido #1039	2026-05-20 02:08:03.924705
535	631	4686	3	Credito	872.66	Paga	Receita de venda - Pedido #631	2026-05-20 02:08:03.924705
536	107	4614	3	Credito	2921.46	Paga	Receita de venda - Pedido #107	2026-05-20 02:08:03.924705
537	6	4611	3	Credito	750.99	Paga	Receita de venda - Pedido #6	2026-05-20 02:08:03.924705
538	1551	4495	3	Credito	1867.36	Paga	Receita de venda - Pedido #1551	2026-05-20 02:08:03.924705
539	1163	4757	3	Credito	297.68	Paga	Receita de venda - Pedido #1163	2026-05-20 02:08:03.924705
540	1148	4534	3	Credito	3704.64	Paga	Receita de venda - Pedido #1148	2026-05-20 02:08:03.924705
541	1641	4638	3	Credito	3827.81	Paga	Receita de venda - Pedido #1641	2026-05-20 02:08:03.924705
542	1628	4797	3	Credito	2745.53	Paga	Receita de venda - Pedido #1628	2026-05-20 02:08:03.924705
543	363	4641	3	Credito	0.01	Paga	Receita de venda - Pedido #363	2026-05-20 02:08:03.924705
544	1979	4611	3	Credito	174.11	Paga	Receita de venda - Pedido #1979	2026-05-20 02:08:03.924705
545	1432	4897	3	Credito	1071.91	Paga	Receita de venda - Pedido #1432	2026-05-20 02:08:03.924705
546	1650	4859	3	Credito	47.44	Paga	Receita de venda - Pedido #1650	2026-05-20 02:08:03.924705
547	66	4623	3	Credito	513.39	Paga	Receita de venda - Pedido #66	2026-05-20 02:08:03.924705
548	661	4418	3	Credito	2268.45	Paga	Receita de venda - Pedido #661	2026-05-20 02:08:03.924705
549	512	4488	3	Credito	4976.90	Paga	Receita de venda - Pedido #512	2026-05-20 02:08:03.924705
550	340	4776	3	Credito	0.01	Paga	Receita de venda - Pedido #340	2026-05-20 02:08:03.924705
551	1653	4479	3	Credito	95.21	Paga	Receita de venda - Pedido #1653	2026-05-20 02:08:03.924705
552	523	4462	3	Credito	520.76	Paga	Receita de venda - Pedido #523	2026-05-20 02:08:03.924705
553	356	4761	3	Credito	3225.26	Paga	Receita de venda - Pedido #356	2026-05-20 02:08:03.924705
554	1919	4843	3	Credito	4790.34	Paga	Receita de venda - Pedido #1919	2026-05-20 02:08:03.924705
555	458	4913	3	Credito	870.88	Paga	Receita de venda - Pedido #458	2026-05-20 02:08:03.924705
556	1970	4810	3	Credito	644.58	Paga	Receita de venda - Pedido #1970	2026-05-20 02:08:03.924705
557	1572	4563	3	Credito	1903.84	Paga	Receita de venda - Pedido #1572	2026-05-20 02:08:03.924705
558	368	4716	3	Credito	2129.06	Paga	Receita de venda - Pedido #368	2026-05-20 02:08:03.924705
559	1982	4599	3	Credito	871.85	Paga	Receita de venda - Pedido #1982	2026-05-20 02:08:03.924705
560	1850	4671	3	Credito	503.06	Paga	Receita de venda - Pedido #1850	2026-05-20 02:08:03.924705
561	538	4513	3	Credito	77.54	Paga	Receita de venda - Pedido #538	2026-05-20 02:08:03.924705
562	595	4892	3	Credito	361.56	Paga	Receita de venda - Pedido #595	2026-05-20 02:08:03.924705
563	142	4791	3	Credito	0.01	Paga	Receita de venda - Pedido #142	2026-05-20 02:08:03.924705
564	924	4734	3	Credito	17227.26	Paga	Receita de venda - Pedido #924	2026-05-20 02:08:03.924705
565	872	4421	3	Credito	0.01	Paga	Receita de venda - Pedido #872	2026-05-20 02:08:03.924705
566	1140	4413	3	Credito	1149.23	Paga	Receita de venda - Pedido #1140	2026-05-20 02:08:03.924705
567	1054	4840	3	Credito	1652.43	Paga	Receita de venda - Pedido #1054	2026-05-20 02:08:03.924705
568	792	4384	3	Credito	1379.06	Paga	Receita de venda - Pedido #792	2026-05-20 02:08:03.924705
569	1965	4687	3	Credito	147.31	Paga	Receita de venda - Pedido #1965	2026-05-20 02:08:03.924705
570	896	4890	3	Credito	720.06	Paga	Receita de venda - Pedido #896	2026-05-20 02:08:03.924705
571	651	4516	3	Credito	2409.59	Paga	Receita de venda - Pedido #651	2026-05-20 02:08:03.924705
572	38	4445	3	Credito	3607.11	Paga	Receita de venda - Pedido #38	2026-05-20 02:08:03.924705
573	1005	4568	3	Credito	112.77	Paga	Receita de venda - Pedido #1005	2026-05-20 02:08:03.924705
574	359	4563	3	Credito	166.52	Paga	Receita de venda - Pedido #359	2026-05-20 02:08:03.924705
575	1449	4697	3	Credito	228.94	Paga	Receita de venda - Pedido #1449	2026-05-20 02:08:03.924705
576	1212	4517	3	Credito	120.31	Paga	Receita de venda - Pedido #1212	2026-05-20 02:08:03.924705
577	217	4589	3	Credito	386.73	Paga	Receita de venda - Pedido #217	2026-05-20 02:08:03.924705
578	1332	4867	3	Credito	1341.79	Paga	Receita de venda - Pedido #1332	2026-05-20 02:08:03.924705
579	985	4857	3	Credito	445.85	Paga	Receita de venda - Pedido #985	2026-05-20 02:08:03.924705
580	1601	4705	3	Credito	68.76	Paga	Receita de venda - Pedido #1601	2026-05-20 02:08:03.924705
581	779	4412	3	Credito	2496.86	Paga	Receita de venda - Pedido #779	2026-05-20 02:08:03.924705
582	1737	4886	3	Credito	991.04	Paga	Receita de venda - Pedido #1737	2026-05-20 02:08:03.924705
583	1721	4750	3	Credito	296.09	Paga	Receita de venda - Pedido #1721	2026-05-20 02:08:03.924705
584	1251	4490	3	Credito	2242.40	Paga	Receita de venda - Pedido #1251	2026-05-20 02:08:03.924705
585	931	4586	3	Credito	103.01	Paga	Receita de venda - Pedido #931	2026-05-20 02:08:03.924705
586	1706	4863	3	Credito	772.25	Paga	Receita de venda - Pedido #1706	2026-05-20 02:08:03.924705
587	1189	4833	3	Credito	946.45	Paga	Receita de venda - Pedido #1189	2026-05-20 02:08:03.924705
588	718	4623	3	Credito	2385.57	Paga	Receita de venda - Pedido #718	2026-05-20 02:08:03.924705
589	1712	4839	3	Credito	301.03	Paga	Receita de venda - Pedido #1712	2026-05-20 02:08:03.924705
590	623	4479	3	Credito	245.50	Paga	Receita de venda - Pedido #623	2026-05-20 02:08:03.924705
591	1654	4815	3	Credito	379.16	Paga	Receita de venda - Pedido #1654	2026-05-20 02:08:03.924705
592	1364	4903	3	Credito	1763.65	Paga	Receita de venda - Pedido #1364	2026-05-20 02:08:03.924705
593	1991	4676	3	Credito	1230.48	Paga	Receita de venda - Pedido #1991	2026-05-20 02:08:03.924705
594	1889	4480	3	Credito	1337.32	Paga	Receita de venda - Pedido #1889	2026-05-20 02:08:03.924705
595	229	4797	3	Credito	1780.20	Paga	Receita de venda - Pedido #229	2026-05-20 02:08:03.924705
596	1112	4884	3	Credito	6488.61	Paga	Receita de venda - Pedido #1112	2026-05-20 02:08:03.924705
597	559	4788	3	Credito	3.44	Paga	Receita de venda - Pedido #559	2026-05-20 02:08:03.924705
598	788	4522	3	Credito	1133.09	Paga	Receita de venda - Pedido #788	2026-05-20 02:08:03.924705
599	304	4596	3	Credito	1742.45	Paga	Receita de venda - Pedido #304	2026-05-20 02:08:03.924705
600	1971	4896	3	Credito	1845.30	Paga	Receita de venda - Pedido #1971	2026-05-20 02:08:03.924705
601	52	4784	3	Credito	3945.62	Paga	Receita de venda - Pedido #52	2026-05-20 02:08:03.924705
602	633	4594	3	Credito	0.01	Paga	Receita de venda - Pedido #633	2026-05-20 02:08:03.924705
603	450	4550	3	Credito	222.25	Paga	Receita de venda - Pedido #450	2026-05-20 02:08:03.924705
604	900	4698	3	Credito	2014.48	Paga	Receita de venda - Pedido #900	2026-05-20 02:08:03.924705
605	405	4750	3	Credito	485.06	Paga	Receita de venda - Pedido #405	2026-05-20 02:08:03.924705
606	996	4485	3	Credito	0.01	Paga	Receita de venda - Pedido #996	2026-05-20 02:08:03.924705
607	762	4680	3	Credito	615.35	Paga	Receita de venda - Pedido #762	2026-05-20 02:08:03.924705
608	1197	4456	3	Credito	237.52	Paga	Receita de venda - Pedido #1197	2026-05-20 02:08:03.924705
609	1063	4513	3	Credito	0.01	Paga	Receita de venda - Pedido #1063	2026-05-20 02:08:03.924705
610	69	4870	3	Credito	1871.03	Paga	Receita de venda - Pedido #69	2026-05-20 02:08:03.924705
611	1059	4624	3	Credito	30.19	Paga	Receita de venda - Pedido #1059	2026-05-20 02:08:03.924705
612	878	4497	3	Credito	218.50	Paga	Receita de venda - Pedido #878	2026-05-20 02:08:03.924705
613	679	4859	3	Credito	2829.69	Paga	Receita de venda - Pedido #679	2026-05-20 02:08:03.924705
614	1912	4529	3	Credito	0.01	Paga	Receita de venda - Pedido #1912	2026-05-20 02:08:03.924705
615	983	4794	3	Credito	76.55	Paga	Receita de venda - Pedido #983	2026-05-20 02:08:03.924705
616	375	4701	3	Credito	2629.99	Paga	Receita de venda - Pedido #375	2026-05-20 02:08:03.924705
617	976	4905	3	Credito	2842.73	Paga	Receita de venda - Pedido #976	2026-05-20 02:08:03.924705
618	729	4551	3	Credito	97.75	Paga	Receita de venda - Pedido #729	2026-05-20 02:08:03.924705
619	1242	4831	3	Credito	2216.73	Paga	Receita de venda - Pedido #1242	2026-05-20 02:08:03.924705
620	680	4544	3	Credito	335.07	Paga	Receita de venda - Pedido #680	2026-05-20 02:08:03.924705
621	408	4585	3	Credito	14.54	Paga	Receita de venda - Pedido #408	2026-05-20 02:08:03.924705
622	782	4857	3	Credito	1287.40	Paga	Receita de venda - Pedido #782	2026-05-20 02:08:03.924705
623	1160	4841	3	Credito	1265.11	Paga	Receita de venda - Pedido #1160	2026-05-20 02:08:03.924705
624	1514	4531	3	Credito	457.51	Paga	Receita de venda - Pedido #1514	2026-05-20 02:08:03.924705
625	1338	4897	3	Credito	221.06	Paga	Receita de venda - Pedido #1338	2026-05-20 02:08:03.924705
626	1359	4828	3	Credito	4198.66	Paga	Receita de venda - Pedido #1359	2026-05-20 02:08:03.924705
627	982	4792	3	Credito	1035.26	Paga	Receita de venda - Pedido #982	2026-05-20 02:08:03.924705
628	1079	4800	3	Credito	0.01	Paga	Receita de venda - Pedido #1079	2026-05-20 02:08:03.924705
629	1445	4711	3	Credito	375.24	Paga	Receita de venda - Pedido #1445	2026-05-20 02:08:03.924705
630	11	4878	3	Credito	2614.37	Paga	Receita de venda - Pedido #11	2026-05-20 02:08:03.924705
631	1152	4438	3	Credito	845.14	Paga	Receita de venda - Pedido #1152	2026-05-20 02:08:03.924705
632	1384	4544	3	Credito	453.58	Paga	Receita de venda - Pedido #1384	2026-05-20 02:08:03.924705
633	1330	4457	3	Credito	4090.42	Paga	Receita de venda - Pedido #1330	2026-05-20 02:08:03.924705
634	821	4554	3	Credito	117.57	Paga	Receita de venda - Pedido #821	2026-05-20 02:08:03.924705
635	1826	4649	3	Credito	160.28	Paga	Receita de venda - Pedido #1826	2026-05-20 02:08:03.924705
636	1141	4397	3	Credito	385.67	Paga	Receita de venda - Pedido #1141	2026-05-20 02:08:03.924705
637	1329	4534	3	Credito	3000.42	Paga	Receita de venda - Pedido #1329	2026-05-20 02:08:03.924705
638	659	4610	3	Credito	105.75	Paga	Receita de venda - Pedido #659	2026-05-20 02:08:03.924705
639	279	4548	3	Credito	3295.93	Paga	Receita de venda - Pedido #279	2026-05-20 02:08:03.924705
640	1481	4596	3	Credito	0.01	Paga	Receita de venda - Pedido #1481	2026-05-20 02:08:03.924705
641	1480	4665	3	Credito	153.79	Paga	Receita de venda - Pedido #1480	2026-05-20 02:08:03.924705
642	9	4545	3	Credito	657.11	Paga	Receita de venda - Pedido #9	2026-05-20 02:08:03.924705
643	903	4709	3	Credito	273.21	Paga	Receita de venda - Pedido #903	2026-05-20 02:08:03.924705
644	1490	4862	3	Credito	4271.92	Paga	Receita de venda - Pedido #1490	2026-05-20 02:08:03.924705
645	736	4742	3	Credito	4438.36	Paga	Receita de venda - Pedido #736	2026-05-20 02:08:03.924705
646	565	4509	3	Credito	204.92	Paga	Receita de venda - Pedido #565	2026-05-20 02:08:03.924705
647	1947	4774	3	Credito	360.05	Paga	Receita de venda - Pedido #1947	2026-05-20 02:08:03.924705
648	566	4741	3	Credito	515.38	Paga	Receita de venda - Pedido #566	2026-05-20 02:08:03.924705
649	457	4645	3	Credito	488.69	Paga	Receita de venda - Pedido #457	2026-05-20 02:08:03.924705
650	592	4554	3	Credito	0.01	Paga	Receita de venda - Pedido #592	2026-05-20 02:08:03.924705
651	1041	4759	3	Credito	0.01	Paga	Receita de venda - Pedido #1041	2026-05-20 02:08:03.924705
652	553	4546	3	Credito	2652.43	Paga	Receita de venda - Pedido #553	2026-05-20 02:08:03.924705
653	1640	4840	3	Credito	3948.84	Paga	Receita de venda - Pedido #1640	2026-05-20 02:08:03.924705
654	302	4608	3	Credito	185.32	Paga	Receita de venda - Pedido #302	2026-05-20 02:08:03.924705
655	1520	4520	3	Credito	577.32	Paga	Receita de venda - Pedido #1520	2026-05-20 02:08:03.924705
656	1968	4595	3	Credito	0.01	Paga	Receita de venda - Pedido #1968	2026-05-20 02:08:03.924705
657	927	4515	3	Credito	616.52	Paga	Receita de venda - Pedido #927	2026-05-20 02:08:03.924705
658	774	4641	3	Credito	86.76	Paga	Receita de venda - Pedido #774	2026-05-20 02:08:03.924705
659	1385	4510	3	Credito	502.17	Paga	Receita de venda - Pedido #1385	2026-05-20 02:08:03.924705
660	398	4645	3	Credito	421.29	Paga	Receita de venda - Pedido #398	2026-05-20 02:08:03.924705
661	1726	4747	3	Credito	692.28	Paga	Receita de venda - Pedido #1726	2026-05-20 02:08:03.924705
662	1732	4607	3	Credito	273.62	Paga	Receita de venda - Pedido #1732	2026-05-20 02:08:03.924705
663	1233	4458	3	Credito	0.01	Paga	Receita de venda - Pedido #1233	2026-05-20 02:08:03.924705
664	165	4676	3	Credito	6529.46	Paga	Receita de venda - Pedido #165	2026-05-20 02:08:03.924705
665	56	4504	3	Credito	1095.43	Paga	Receita de venda - Pedido #56	2026-05-20 02:08:03.924705
666	820	4549	3	Credito	214.11	Paga	Receita de venda - Pedido #820	2026-05-20 02:08:03.924705
667	1267	4768	3	Credito	0.01	Paga	Receita de venda - Pedido #1267	2026-05-20 02:08:03.924705
668	992	4544	3	Credito	2151.17	Paga	Receita de venda - Pedido #992	2026-05-20 02:08:03.924705
669	894	4863	3	Credito	651.49	Paga	Receita de venda - Pedido #894	2026-05-20 02:08:03.924705
670	1357	4848	3	Credito	0.01	Paga	Receita de venda - Pedido #1357	2026-05-20 02:08:03.924705
671	245	4639	3	Credito	0.01	Paga	Receita de venda - Pedido #245	2026-05-20 02:08:03.924705
672	1326	4915	3	Credito	3178.62	Paga	Receita de venda - Pedido #1326	2026-05-20 02:08:03.924705
673	1020	4550	3	Credito	1996.08	Paga	Receita de venda - Pedido #1020	2026-05-20 02:08:03.924705
674	1807	4578	3	Credito	0.01	Paga	Receita de venda - Pedido #1807	2026-05-20 02:08:03.924705
675	1127	4843	3	Credito	24.65	Paga	Receita de venda - Pedido #1127	2026-05-20 02:08:03.924705
676	1060	4549	3	Credito	2220.70	Paga	Receita de venda - Pedido #1060	2026-05-20 02:08:03.924705
677	1017	4859	3	Credito	31.43	Paga	Receita de venda - Pedido #1017	2026-05-20 02:08:03.924705
678	484	4751	3	Credito	303.72	Paga	Receita de venda - Pedido #484	2026-05-20 02:08:03.924705
679	558	4522	3	Credito	93.52	Paga	Receita de venda - Pedido #558	2026-05-20 02:08:03.924705
680	144	4691	3	Credito	3338.04	Paga	Receita de venda - Pedido #144	2026-05-20 02:08:03.924705
681	1720	4635	3	Credito	0.01	Paga	Receita de venda - Pedido #1720	2026-05-20 02:08:03.924705
682	1885	4577	3	Credito	0.01	Paga	Receita de venda - Pedido #1885	2026-05-20 02:08:03.924705
683	1754	4491	3	Credito	1377.22	Paga	Receita de venda - Pedido #1754	2026-05-20 02:08:03.924705
684	1538	4563	3	Credito	3706.46	Paga	Receita de venda - Pedido #1538	2026-05-20 02:08:03.924705
685	1224	4389	3	Credito	2623.86	Paga	Receita de venda - Pedido #1224	2026-05-20 02:08:03.924705
686	168	4420	3	Credito	4772.11	Paga	Receita de venda - Pedido #168	2026-05-20 02:08:03.924705
687	598	4744	3	Credito	287.93	Paga	Receita de venda - Pedido #598	2026-05-20 02:08:03.924705
688	471	4695	3	Credito	3271.47	Paga	Receita de venda - Pedido #471	2026-05-20 02:08:03.924705
689	1930	4652	3	Credito	3999.12	Paga	Receita de venda - Pedido #1930	2026-05-20 02:08:03.924705
690	1051	4875	3	Credito	0.01	Paga	Receita de venda - Pedido #1051	2026-05-20 02:08:03.924705
691	1424	4711	3	Credito	1281.84	Paga	Receita de venda - Pedido #1424	2026-05-20 02:08:03.924705
692	287	4761	3	Credito	3767.90	Paga	Receita de venda - Pedido #287	2026-05-20 02:08:03.924705
693	167	4615	3	Credito	142.61	Paga	Receita de venda - Pedido #167	2026-05-20 02:08:03.924705
694	290	4595	3	Credito	270.26	Paga	Receita de venda - Pedido #290	2026-05-20 02:08:03.924705
695	1716	4906	3	Credito	5669.90	Paga	Receita de venda - Pedido #1716	2026-05-20 02:08:03.924705
696	1352	4516	3	Credito	802.78	Paga	Receita de venda - Pedido #1352	2026-05-20 02:08:03.924705
697	1859	4716	3	Credito	259.84	Paga	Receita de venda - Pedido #1859	2026-05-20 02:08:03.924705
698	1441	4397	3	Credito	7529.02	Paga	Receita de venda - Pedido #1441	2026-05-20 02:08:03.924705
699	1035	4553	3	Credito	1818.98	Paga	Receita de venda - Pedido #1035	2026-05-20 02:08:03.924705
700	367	4651	3	Credito	0.01	Paga	Receita de venda - Pedido #367	2026-05-20 02:08:03.924705
701	41	4816	3	Credito	445.08	Paga	Receita de venda - Pedido #41	2026-05-20 02:08:03.924705
702	1389	4699	3	Credito	0.01	Paga	Receita de venda - Pedido #1389	2026-05-20 02:08:03.924705
703	572	4498	3	Credito	47.70	Paga	Receita de venda - Pedido #572	2026-05-20 02:08:03.924705
704	32	4802	3	Credito	1664.70	Paga	Receita de venda - Pedido #32	2026-05-20 02:08:03.924705
705	1735	4899	3	Credito	85.74	Paga	Receita de venda - Pedido #1735	2026-05-20 02:08:03.924705
706	247	4614	3	Credito	438.50	Paga	Receita de venda - Pedido #247	2026-05-20 02:08:03.924705
707	423	4555	3	Credito	148.99	Paga	Receita de venda - Pedido #423	2026-05-20 02:08:03.924705
708	1240	4391	3	Credito	383.86	Paga	Receita de venda - Pedido #1240	2026-05-20 02:08:03.924705
709	1881	4495	3	Credito	9926.91	Paga	Receita de venda - Pedido #1881	2026-05-20 02:08:03.924705
710	1621	4440	3	Credito	865.84	Paga	Receita de venda - Pedido #1621	2026-05-20 02:08:03.924705
711	1182	4815	3	Credito	806.88	Paga	Receita de venda - Pedido #1182	2026-05-20 02:08:03.924705
712	1946	4474	3	Credito	15044.80	Paga	Receita de venda - Pedido #1946	2026-05-20 02:08:03.924705
713	411	4874	3	Credito	11180.57	Paga	Receita de venda - Pedido #411	2026-05-20 02:08:03.924705
714	869	4845	3	Credito	415.74	Paga	Receita de venda - Pedido #869	2026-05-20 02:08:03.924705
715	864	4886	3	Credito	1622.92	Paga	Receita de venda - Pedido #864	2026-05-20 02:08:03.924705
716	672	4867	3	Credito	2606.34	Paga	Receita de venda - Pedido #672	2026-05-20 02:08:03.924705
717	1584	4794	3	Credito	0.01	Paga	Receita de venda - Pedido #1584	2026-05-20 02:08:03.924705
718	1454	4517	3	Credito	12935.37	Paga	Receita de venda - Pedido #1454	2026-05-20 02:08:03.924705
719	316	4831	3	Credito	2436.96	Paga	Receita de venda - Pedido #316	2026-05-20 02:08:03.924705
720	1282	4554	3	Credito	0.01	Paga	Receita de venda - Pedido #1282	2026-05-20 02:08:03.924705
721	256	4865	3	Credito	397.09	Paga	Receita de venda - Pedido #256	2026-05-20 02:08:03.924705
722	332	4569	3	Credito	104.24	Paga	Receita de venda - Pedido #332	2026-05-20 02:08:03.924705
723	1812	4797	3	Credito	4734.24	Paga	Receita de venda - Pedido #1812	2026-05-20 02:08:03.924705
724	628	4696	3	Credito	124.88	Paga	Receita de venda - Pedido #628	2026-05-20 02:08:03.924705
725	1860	4661	3	Credito	0.01	Paga	Receita de venda - Pedido #1860	2026-05-20 02:08:03.924705
726	885	4659	3	Credito	0.01	Paga	Receita de venda - Pedido #885	2026-05-20 02:08:03.924705
727	422	4466	3	Credito	112.11	Paga	Receita de venda - Pedido #422	2026-05-20 02:08:03.924705
728	185	4606	3	Credito	334.81	Paga	Receita de venda - Pedido #185	2026-05-20 02:08:03.924705
729	215	4753	3	Credito	1321.17	Paga	Receita de venda - Pedido #215	2026-05-20 02:08:03.924705
730	1275	4815	3	Credito	1455.75	Paga	Receita de venda - Pedido #1275	2026-05-20 02:08:03.924705
731	1107	4645	3	Credito	0.01	Paga	Receita de venda - Pedido #1107	2026-05-20 02:08:03.924705
732	1465	4396	3	Credito	0.01	Paga	Receita de venda - Pedido #1465	2026-05-20 02:08:03.924705
733	1157	4539	3	Credito	0.01	Paga	Receita de venda - Pedido #1157	2026-05-20 02:08:03.924705
734	625	4605	3	Credito	3688.97	Paga	Receita de venda - Pedido #625	2026-05-20 02:08:03.924705
735	1155	4856	3	Credito	18809.15	Paga	Receita de venda - Pedido #1155	2026-05-20 02:08:03.924705
736	1526	4456	3	Credito	666.74	Paga	Receita de venda - Pedido #1526	2026-05-20 02:08:03.924705
737	617	4692	3	Credito	7892.93	Paga	Receita de venda - Pedido #617	2026-05-20 02:08:03.924705
738	1541	4579	3	Credito	215.64	Paga	Receita de venda - Pedido #1541	2026-05-20 02:08:03.924705
739	1531	4482	3	Credito	5612.17	Paga	Receita de venda - Pedido #1531	2026-05-20 02:08:03.924705
740	1671	4385	3	Credito	19716.49	Paga	Receita de venda - Pedido #1671	2026-05-20 02:08:03.924705
741	819	4427	3	Credito	386.37	Paga	Receita de venda - Pedido #819	2026-05-20 02:08:03.924705
742	314	4696	3	Credito	1551.36	Paga	Receita de venda - Pedido #314	2026-05-20 02:08:03.924705
743	817	4686	3	Credito	2715.11	Paga	Receita de venda - Pedido #817	2026-05-20 02:08:03.924705
744	1274	4891	3	Credito	2336.35	Paga	Receita de venda - Pedido #1274	2026-05-20 02:08:03.924705
745	426	4510	3	Credito	1530.22	Paga	Receita de venda - Pedido #426	2026-05-20 02:08:03.924705
746	1891	4594	3	Credito	0.01	Paga	Receita de venda - Pedido #1891	2026-05-20 02:08:03.924705
747	1840	4504	3	Credito	0.01	Paga	Receita de venda - Pedido #1840	2026-05-20 02:08:03.924705
748	1805	4592	3	Credito	1334.30	Paga	Receita de venda - Pedido #1805	2026-05-20 02:08:03.924705
749	877	4533	3	Credito	0.01	Paga	Receita de venda - Pedido #877	2026-05-20 02:08:03.924705
750	299	4855	3	Credito	671.04	Paga	Receita de venda - Pedido #299	2026-05-20 02:08:03.924705
751	169	4855	3	Credito	4212.16	Paga	Receita de venda - Pedido #169	2026-05-20 02:08:03.924705
752	1113	4448	3	Credito	0.01	Paga	Receita de venda - Pedido #1113	2026-05-20 02:08:03.924705
753	605	4466	3	Credito	170.34	Paga	Receita de venda - Pedido #605	2026-05-20 02:08:03.924705
754	1317	4665	3	Credito	100.70	Paga	Receita de venda - Pedido #1317	2026-05-20 02:08:03.924705
755	1702	4870	3	Credito	95.49	Paga	Receita de venda - Pedido #1702	2026-05-20 02:08:03.924705
756	971	4408	3	Credito	84.92	Paga	Receita de venda - Pedido #971	2026-05-20 02:08:03.924705
757	660	4652	3	Credito	0.01	Paga	Receita de venda - Pedido #660	2026-05-20 02:08:03.924705
758	1825	4855	3	Credito	1992.92	Paga	Receita de venda - Pedido #1825	2026-05-20 02:08:03.924705
759	1759	4579	3	Credito	291.14	Paga	Receita de venda - Pedido #1759	2026-05-20 02:08:03.924705
760	910	4564	3	Credito	1300.57	Paga	Receita de venda - Pedido #910	2026-05-20 02:08:03.924705
761	1707	4626	3	Credito	4809.86	Paga	Receita de venda - Pedido #1707	2026-05-20 02:08:03.924705
762	236	4398	3	Credito	1103.50	Paga	Receita de venda - Pedido #236	2026-05-20 02:08:03.924705
763	941	4589	3	Credito	0.01	Paga	Receita de venda - Pedido #941	2026-05-20 02:08:03.924705
764	949	4812	3	Credito	0.01	Paga	Receita de venda - Pedido #949	2026-05-20 02:08:03.924705
765	135	4412	3	Credito	976.41	Paga	Receita de venda - Pedido #135	2026-05-20 02:08:03.924705
766	1751	4818	3	Credito	178.73	Paga	Receita de venda - Pedido #1751	2026-05-20 02:08:03.924705
767	1626	4771	3	Credito	209.09	Paga	Receita de venda - Pedido #1626	2026-05-20 02:08:03.924705
768	1064	4541	3	Credito	5430.47	Paga	Receita de venda - Pedido #1064	2026-05-20 02:08:03.924705
769	454	4614	3	Credito	2260.91	Paga	Receita de venda - Pedido #454	2026-05-20 02:08:03.924705
770	1193	4853	3	Credito	4164.35	Paga	Receita de venda - Pedido #1193	2026-05-20 02:08:03.924705
771	879	4385	3	Credito	17371.07	Paga	Receita de venda - Pedido #879	2026-05-20 02:08:03.924705
772	227	4883	3	Credito	2491.97	Paga	Receita de venda - Pedido #227	2026-05-20 02:08:03.924705
773	500	4833	3	Credito	1560.48	Paga	Receita de venda - Pedido #500	2026-05-20 02:08:03.924705
774	1204	4552	3	Credito	2771.76	Paga	Receita de venda - Pedido #1204	2026-05-20 02:08:03.924705
775	73	4644	3	Credito	1219.17	Paga	Receita de venda - Pedido #73	2026-05-20 02:08:03.924705
776	1169	4429	3	Credito	3836.27	Paga	Receita de venda - Pedido #1169	2026-05-20 02:08:03.924705
777	1994	4695	3	Credito	0.01	Paga	Receita de venda - Pedido #1994	2026-05-20 02:08:03.924705
778	1874	4850	3	Credito	2777.97	Paga	Receita de venda - Pedido #1874	2026-05-20 02:08:03.924705
779	1171	4612	3	Credito	22284.08	Paga	Receita de venda - Pedido #1171	2026-05-20 02:08:03.924705
780	1138	4709	3	Credito	5307.42	Paga	Receita de venda - Pedido #1138	2026-05-20 02:08:03.924705
781	1085	4490	3	Credito	2947.68	Paga	Receita de venda - Pedido #1085	2026-05-20 02:08:03.924705
782	239	4480	3	Credito	67.77	Paga	Receita de venda - Pedido #239	2026-05-20 02:08:03.924705
783	121	4891	3	Credito	1217.51	Paga	Receita de venda - Pedido #121	2026-05-20 02:08:03.924705
784	1353	4544	3	Credito	0.01	Paga	Receita de venda - Pedido #1353	2026-05-20 02:08:03.924705
785	1438	4743	3	Credito	473.00	Paga	Receita de venda - Pedido #1438	2026-05-20 02:08:03.924705
786	1407	4839	3	Credito	26.53	Paga	Receita de venda - Pedido #1407	2026-05-20 02:08:03.924705
787	561	4577	3	Credito	1729.06	Paga	Receita de venda - Pedido #561	2026-05-20 02:08:03.924705
788	1688	4445	3	Credito	6.87	Paga	Receita de venda - Pedido #1688	2026-05-20 02:08:03.924705
789	755	4776	3	Credito	0.01	Paga	Receita de venda - Pedido #755	2026-05-20 02:08:03.924705
790	1184	4599	3	Credito	1389.05	Paga	Receita de venda - Pedido #1184	2026-05-20 02:08:03.924705
791	1031	4772	3	Credito	756.74	Paga	Receita de venda - Pedido #1031	2026-05-20 02:08:03.924705
792	1670	4812	3	Credito	337.72	Paga	Receita de venda - Pedido #1670	2026-05-20 02:08:03.924705
793	15	4586	3	Credito	4762.09	Paga	Receita de venda - Pedido #15	2026-05-20 02:08:03.924705
794	1865	4622	3	Credito	0.01	Paga	Receita de venda - Pedido #1865	2026-05-20 02:08:03.924705
795	1129	4656	3	Credito	359.90	Paga	Receita de venda - Pedido #1129	2026-05-20 02:08:03.924705
796	859	4491	3	Credito	637.86	Paga	Receita de venda - Pedido #859	2026-05-20 02:08:03.924705
797	842	4422	3	Credito	11001.63	Paga	Receita de venda - Pedido #842	2026-05-20 02:08:03.924705
798	767	4853	3	Credito	154.08	Paga	Receita de venda - Pedido #767	2026-05-20 02:08:03.924705
799	1367	4516	3	Credito	3378.93	Paga	Receita de venda - Pedido #1367	2026-05-20 02:08:03.924705
800	244	4442	3	Credito	1423.80	Paga	Receita de venda - Pedido #244	2026-05-20 02:08:03.924705
801	1192	4633	3	Credito	35.34	Paga	Receita de venda - Pedido #1192	2026-05-20 02:08:03.924705
802	1088	4432	3	Credito	262.11	Paga	Receita de venda - Pedido #1088	2026-05-20 02:08:03.924705
803	1124	4629	3	Credito	266.56	Paga	Receita de venda - Pedido #1124	2026-05-20 02:08:03.924705
804	468	4534	3	Credito	285.36	Paga	Receita de venda - Pedido #468	2026-05-20 02:08:03.924705
805	1717	4647	3	Credito	2825.64	Paga	Receita de venda - Pedido #1717	2026-05-20 02:08:03.924705
806	1738	4648	3	Credito	7.14	Paga	Receita de venda - Pedido #1738	2026-05-20 02:08:03.924705
807	1725	4446	3	Credito	349.53	Paga	Receita de venda - Pedido #1725	2026-05-20 02:08:03.924705
808	1243	4888	3	Credito	0.01	Paga	Receita de venda - Pedido #1243	2026-05-20 02:08:03.924705
809	721	4820	3	Credito	78.61	Paga	Receita de venda - Pedido #721	2026-05-20 02:08:03.924705
810	251	4535	3	Credito	364.54	Paga	Receita de venda - Pedido #251	2026-05-20 02:08:03.924705
811	1100	4623	3	Credito	35.66	Paga	Receita de venda - Pedido #1100	2026-05-20 02:08:03.924705
812	1270	4653	3	Credito	9329.88	Paga	Receita de venda - Pedido #1270	2026-05-20 02:08:03.924705
813	1436	4639	3	Credito	52.32	Paga	Receita de venda - Pedido #1436	2026-05-20 02:08:03.924705
814	960	4494	3	Credito	1132.99	Paga	Receita de venda - Pedido #960	2026-05-20 02:08:03.924705
815	1516	4501	3	Credito	5.27	Paga	Receita de venda - Pedido #1516	2026-05-20 02:08:03.924705
816	786	4487	3	Credito	1513.60	Paga	Receita de venda - Pedido #786	2026-05-20 02:08:03.924705
817	1945	4795	3	Credito	128.36	Paga	Receita de venda - Pedido #1945	2026-05-20 02:08:03.924705
818	1455	4391	3	Credito	525.15	Paga	Receita de venda - Pedido #1455	2026-05-20 02:08:03.924705
819	321	4464	3	Credito	143.94	Paga	Receita de venda - Pedido #321	2026-05-20 02:08:03.924705
820	105	4643	3	Credito	0.01	Paga	Receita de venda - Pedido #105	2026-05-20 02:08:03.924705
821	402	4411	3	Credito	155.86	Paga	Receita de venda - Pedido #402	2026-05-20 02:08:03.924705
822	804	4404	3	Credito	3871.25	Paga	Receita de venda - Pedido #804	2026-05-20 02:08:03.924705
823	1934	4737	3	Credito	203.19	Paga	Receita de venda - Pedido #1934	2026-05-20 02:08:03.924705
824	866	4647	3	Credito	16756.18	Paga	Receita de venda - Pedido #866	2026-05-20 02:08:03.924705
825	1542	4577	3	Credito	0.01	Paga	Receita de venda - Pedido #1542	2026-05-20 02:08:03.924705
826	1487	4651	3	Credito	9319.71	Paga	Receita de venda - Pedido #1487	2026-05-20 02:08:03.924705
827	991	4779	3	Credito	1976.77	Paga	Receita de venda - Pedido #991	2026-05-20 02:08:03.924705
828	1391	4645	3	Credito	961.12	Paga	Receita de venda - Pedido #1391	2026-05-20 02:08:03.924705
829	776	4568	3	Credito	4264.92	Paga	Receita de venda - Pedido #776	2026-05-20 02:08:03.924705
830	467	4411	3	Credito	7.29	Paga	Receita de venda - Pedido #467	2026-05-20 02:08:03.924705
831	327	4815	3	Credito	6377.97	Paga	Receita de venda - Pedido #327	2026-05-20 02:08:03.924705
832	1636	4534	3	Credito	0.01	Paga	Receita de venda - Pedido #1636	2026-05-20 02:08:03.924705
833	1177	4385	3	Credito	68.83	Paga	Receita de venda - Pedido #1177	2026-05-20 02:08:03.924705
834	1121	4900	3	Credito	1517.04	Paga	Receita de venda - Pedido #1121	2026-05-20 02:08:03.924705
835	1882	4762	3	Credito	3541.47	Paga	Receita de venda - Pedido #1882	2026-05-20 02:08:03.924705
836	1566	4660	3	Credito	5254.57	Paga	Receita de venda - Pedido #1566	2026-05-20 02:08:03.924705
837	1343	4577	3	Credito	1183.06	Paga	Receita de venda - Pedido #1343	2026-05-20 02:08:03.924705
838	724	4709	3	Credito	1361.98	Paga	Receita de venda - Pedido #724	2026-05-20 02:08:03.924705
839	1785	4689	3	Credito	4330.84	Paga	Receita de venda - Pedido #1785	2026-05-20 02:08:03.924705
840	1323	4640	3	Credito	0.01	Paga	Receita de venda - Pedido #1323	2026-05-20 02:08:03.924705
841	1222	4861	3	Credito	5464.76	Paga	Receita de venda - Pedido #1222	2026-05-20 02:08:03.924705
842	1921	4824	3	Credito	241.36	Paga	Receita de venda - Pedido #1921	2026-05-20 02:08:03.924705
843	1714	4541	3	Credito	230.65	Paga	Receita de venda - Pedido #1714	2026-05-20 02:08:03.924705
844	372	4798	3	Credito	1661.93	Paga	Receita de venda - Pedido #372	2026-05-20 02:08:03.924705
845	1358	4798	3	Credito	2656.81	Paga	Receita de venda - Pedido #1358	2026-05-20 02:08:03.924705
846	339	4549	3	Credito	68.07	Paga	Receita de venda - Pedido #339	2026-05-20 02:08:03.924705
847	600	4649	3	Credito	1973.50	Paga	Receita de venda - Pedido #600	2026-05-20 02:08:03.924705
848	772	4689	3	Credito	35.88	Paga	Receita de venda - Pedido #772	2026-05-20 02:08:03.924705
849	335	4724	3	Credito	1237.56	Paga	Receita de venda - Pedido #335	2026-05-20 02:08:03.924705
850	1596	4533	3	Credito	0.01	Paga	Receita de venda - Pedido #1596	2026-05-20 02:08:03.924705
851	1931	4589	3	Credito	2028.87	Paga	Receita de venda - Pedido #1931	2026-05-20 02:08:03.924705
852	1756	4455	3	Credito	4169.72	Paga	Receita de venda - Pedido #1756	2026-05-20 02:08:03.924705
853	591	4742	3	Credito	8261.92	Paga	Receita de venda - Pedido #591	2026-05-20 02:08:03.924705
854	808	4539	3	Credito	3450.86	Paga	Receita de venda - Pedido #808	2026-05-20 02:08:03.924705
855	1695	4814	3	Credito	563.26	Paga	Receita de venda - Pedido #1695	2026-05-20 02:08:03.924705
856	1768	4611	3	Credito	499.78	Paga	Receita de venda - Pedido #1768	2026-05-20 02:08:03.924705
857	827	4599	3	Credito	0.01	Paga	Receita de venda - Pedido #827	2026-05-20 02:08:03.924705
858	254	4427	3	Credito	346.52	Paga	Receita de venda - Pedido #254	2026-05-20 02:08:03.924705
859	1360	4858	3	Credito	528.18	Paga	Receita de venda - Pedido #1360	2026-05-20 02:08:03.924705
860	377	4914	3	Credito	1144.15	Paga	Receita de venda - Pedido #377	2026-05-20 02:08:03.924705
861	952	4510	3	Credito	285.34	Paga	Receita de venda - Pedido #952	2026-05-20 02:08:03.924705
862	159	4550	3	Credito	465.00	Paga	Receita de venda - Pedido #159	2026-05-20 02:08:03.924705
863	1399	4778	3	Credito	0.01	Paga	Receita de venda - Pedido #1399	2026-05-20 02:08:03.924705
864	986	4896	3	Credito	0.01	Paga	Receita de venda - Pedido #986	2026-05-20 02:08:03.924705
865	857	4852	3	Credito	46.78	Paga	Receita de venda - Pedido #857	2026-05-20 02:08:03.924705
866	619	4877	3	Credito	9173.51	Paga	Receita de venda - Pedido #619	2026-05-20 02:08:03.924705
867	890	4684	3	Credito	13.51	Paga	Receita de venda - Pedido #890	2026-05-20 02:08:03.924705
868	1214	4824	3	Credito	4013.75	Paga	Receita de venda - Pedido #1214	2026-05-20 02:08:03.924705
869	20	4900	3	Credito	993.16	Paga	Receita de venda - Pedido #20	2026-05-20 02:08:03.924705
870	1394	4896	3	Credito	56.37	Paga	Receita de venda - Pedido #1394	2026-05-20 02:08:03.924705
871	1341	4512	3	Credito	1556.43	Paga	Receita de venda - Pedido #1341	2026-05-20 02:08:03.924705
872	1074	4896	3	Credito	3823.28	Paga	Receita de venda - Pedido #1074	2026-05-20 02:08:03.924705
873	517	4642	3	Credito	0.01	Paga	Receita de venda - Pedido #517	2026-05-20 02:08:03.924705
874	1873	4516	3	Credito	161.33	Paga	Receita de venda - Pedido #1873	2026-05-20 02:08:03.924705
875	1999	4606	3	Credito	716.71	Paga	Receita de venda - Pedido #1999	2026-05-20 02:08:03.924705
876	1957	4915	3	Credito	63.90	Paga	Receita de venda - Pedido #1957	2026-05-20 02:08:03.924705
877	1111	4916	3	Credito	5016.53	Paga	Receita de venda - Pedido #1111	2026-05-20 02:08:03.924705
878	1082	4824	3	Credito	14852.58	Paga	Receita de venda - Pedido #1082	2026-05-20 02:08:03.924705
879	129	4645	3	Credito	1834.84	Paga	Receita de venda - Pedido #129	2026-05-20 02:08:03.924705
880	203	4781	3	Credito	24788.86	Paga	Receita de venda - Pedido #203	2026-05-20 02:08:03.924705
881	1838	4411	3	Credito	1829.35	Paga	Receita de venda - Pedido #1838	2026-05-20 02:08:03.924705
882	1181	4558	3	Credito	11722.03	Paga	Receita de venda - Pedido #1181	2026-05-20 02:08:03.924705
883	789	4740	3	Credito	69.11	Paga	Receita de venda - Pedido #789	2026-05-20 02:08:03.924705
884	1491	4747	3	Credito	6179.81	Paga	Receita de venda - Pedido #1491	2026-05-20 02:08:03.924705
885	1023	4520	3	Credito	189.79	Paga	Receita de venda - Pedido #1023	2026-05-20 02:08:03.924705
886	1172	4504	3	Credito	0.01	Paga	Receita de venda - Pedido #1172	2026-05-20 02:08:03.924705
887	1208	4832	3	Credito	5309.04	Paga	Receita de venda - Pedido #1208	2026-05-20 02:08:03.924705
888	511	4851	3	Credito	3995.32	Paga	Receita de venda - Pedido #511	2026-05-20 02:08:03.924705
889	1351	4785	3	Credito	0.01	Paga	Receita de venda - Pedido #1351	2026-05-20 02:08:03.924705
890	1660	4849	3	Credito	165.02	Paga	Receita de venda - Pedido #1660	2026-05-20 02:08:03.924705
891	1183	4388	3	Credito	2232.22	Paga	Receita de venda - Pedido #1183	2026-05-20 02:08:03.924705
892	1333	4748	3	Credito	762.60	Paga	Receita de venda - Pedido #1333	2026-05-20 02:08:03.924705
893	1610	4742	3	Credito	399.08	Paga	Receita de venda - Pedido #1610	2026-05-20 02:08:03.924705
894	1034	4455	3	Credito	262.99	Paga	Receita de venda - Pedido #1034	2026-05-20 02:08:03.924705
895	943	4875	3	Credito	239.08	Paga	Receita de venda - Pedido #943	2026-05-20 02:08:03.924705
896	330	4876	3	Credito	5386.07	Paga	Receita de venda - Pedido #330	2026-05-20 02:08:03.924705
897	1903	4744	3	Credito	1549.01	Paga	Receita de venda - Pedido #1903	2026-05-20 02:08:03.924705
898	1220	4897	3	Credito	793.67	Paga	Receita de venda - Pedido #1220	2026-05-20 02:08:03.924705
899	451	4899	3	Credito	241.33	Paga	Receita de venda - Pedido #451	2026-05-20 02:08:03.924705
900	1466	4759	3	Credito	24804.70	Paga	Receita de venda - Pedido #1466	2026-05-20 02:08:03.924705
901	323	4820	3	Credito	1194.47	Paga	Receita de venda - Pedido #323	2026-05-20 02:08:03.924705
902	348	4582	3	Credito	0.01	Paga	Receita de venda - Pedido #348	2026-05-20 02:08:03.924705
903	1634	4870	3	Credito	164.55	Paga	Receita de venda - Pedido #1634	2026-05-20 02:08:03.924705
904	1363	4876	3	Credito	2222.93	Paga	Receita de venda - Pedido #1363	2026-05-20 02:08:03.924705
905	112	4442	3	Credito	13353.50	Paga	Receita de venda - Pedido #112	2026-05-20 02:08:03.924705
906	560	4490	3	Credito	3978.58	Paga	Receita de venda - Pedido #560	2026-05-20 02:08:03.924705
907	1042	4649	3	Credito	83.89	Paga	Receita de venda - Pedido #1042	2026-05-20 02:08:03.924705
908	613	4555	3	Credito	1281.31	Paga	Receita de venda - Pedido #613	2026-05-20 02:08:03.924705
909	268	4705	3	Credito	306.82	Paga	Receita de venda - Pedido #268	2026-05-20 02:08:03.924705
910	1745	4706	3	Credito	428.22	Paga	Receita de venda - Pedido #1745	2026-05-20 02:08:03.924705
911	1404	4478	3	Credito	8799.81	Paga	Receita de venda - Pedido #1404	2026-05-20 02:08:03.924705
912	615	4676	3	Credito	13464.71	Paga	Receita de venda - Pedido #615	2026-05-20 02:08:03.924705
913	830	4415	3	Credito	0.01	Paga	Receita de venda - Pedido #830	2026-05-20 02:08:03.924705
914	1545	4498	3	Credito	4808.09	Paga	Receita de venda - Pedido #1545	2026-05-20 02:08:03.924705
915	1581	4816	3	Credito	0.01	Paga	Receita de venda - Pedido #1581	2026-05-20 02:08:03.924705
916	1482	4873	3	Credito	320.94	Paga	Receita de venda - Pedido #1482	2026-05-20 02:08:03.924705
917	1657	4568	3	Credito	4225.63	Paga	Receita de venda - Pedido #1657	2026-05-20 02:08:03.924705
918	988	4794	3	Credito	498.72	Paga	Receita de venda - Pedido #988	2026-05-20 02:08:03.924705
919	1340	4855	3	Credito	6225.14	Paga	Receita de venda - Pedido #1340	2026-05-20 02:08:03.924705
920	964	4632	3	Credito	325.20	Paga	Receita de venda - Pedido #964	2026-05-20 02:08:03.924705
921	601	4876	3	Credito	1799.47	Paga	Receita de venda - Pedido #601	2026-05-20 02:08:03.924705
922	590	4582	3	Credito	508.05	Paga	Receita de venda - Pedido #590	2026-05-20 02:08:03.924705
923	82	4829	3	Credito	693.81	Paga	Receita de venda - Pedido #82	2026-05-20 02:08:03.924705
924	2000	4680	3	Credito	3759.41	Paga	Receita de venda - Pedido #2000	2026-05-20 02:08:03.924705
925	1396	4495	3	Credito	3035.31	Paga	Receita de venda - Pedido #1396	2026-05-20 02:08:03.924705
926	1534	4744	3	Credito	2147.34	Paga	Receita de venda - Pedido #1534	2026-05-20 02:08:03.924705
927	202	4615	3	Credito	0.01	Paga	Receita de venda - Pedido #202	2026-05-20 02:08:03.924705
928	610	4873	3	Credito	342.61	Paga	Receita de venda - Pedido #610	2026-05-20 02:08:03.924705
929	1425	4411	3	Credito	1041.27	Paga	Receita de venda - Pedido #1425	2026-05-20 02:08:03.924705
930	678	4427	3	Credito	33.07	Paga	Receita de venda - Pedido #678	2026-05-20 02:08:03.924705
931	1906	4640	3	Credito	244.01	Paga	Receita de venda - Pedido #1906	2026-05-20 02:08:03.924705
932	812	4497	3	Credito	234.44	Paga	Receita de venda - Pedido #812	2026-05-20 02:08:03.924705
933	1390	4713	3	Credito	75.73	Paga	Receita de venda - Pedido #1390	2026-05-20 02:08:03.924705
934	579	4451	3	Credito	3629.06	Paga	Receita de venda - Pedido #579	2026-05-20 02:08:03.924705
935	510	4721	3	Credito	1541.98	Paga	Receita de venda - Pedido #510	2026-05-20 02:08:03.924705
936	1981	4761	3	Credito	0.01	Paga	Receita de venda - Pedido #1981	2026-05-20 02:08:03.924705
937	1176	4481	3	Credito	4295.96	Paga	Receita de venda - Pedido #1176	2026-05-20 02:08:03.924705
938	1186	4573	3	Credito	3161.22	Paga	Receita de venda - Pedido #1186	2026-05-20 02:08:03.924705
939	198	4823	3	Credito	2407.33	Paga	Receita de venda - Pedido #198	2026-05-20 02:08:03.924705
940	212	4906	3	Credito	393.54	Paga	Receita de venda - Pedido #212	2026-05-20 02:08:03.924705
941	28	4720	3	Credito	4.31	Paga	Receita de venda - Pedido #28	2026-05-20 02:08:03.924705
942	1796	4678	3	Credito	1321.35	Paga	Receita de venda - Pedido #1796	2026-05-20 02:08:03.924705
943	1089	4398	3	Credito	0.01	Paga	Receita de venda - Pedido #1089	2026-05-20 02:08:03.924705
944	1380	4735	3	Credito	46.26	Paga	Receita de venda - Pedido #1380	2026-05-20 02:08:03.924705
945	1656	4747	3	Credito	10073.56	Paga	Receita de venda - Pedido #1656	2026-05-20 02:08:03.924705
946	1147	4660	3	Credito	265.03	Paga	Receita de venda - Pedido #1147	2026-05-20 02:08:03.924705
947	720	4896	3	Credito	563.36	Paga	Receita de venda - Pedido #720	2026-05-20 02:08:03.924705
948	917	4821	3	Credito	62.00	Paga	Receita de venda - Pedido #917	2026-05-20 02:08:03.924705
949	489	4679	3	Credito	3450.27	Paga	Receita de venda - Pedido #489	2026-05-20 02:08:03.924705
950	1605	4722	3	Credito	2552.13	Paga	Receita de venda - Pedido #1605	2026-05-20 02:08:03.924705
951	1555	4605	3	Credito	41.17	Paga	Receita de venda - Pedido #1555	2026-05-20 02:08:03.924705
952	515	4867	3	Credito	3890.62	Paga	Receita de venda - Pedido #515	2026-05-20 02:08:03.924705
953	1256	4522	3	Credito	11296.84	Paga	Receita de venda - Pedido #1256	2026-05-20 02:08:03.924705
954	1000	4645	3	Credito	347.84	Paga	Receita de venda - Pedido #1000	2026-05-20 02:08:03.924705
955	706	4759	3	Credito	2244.87	Paga	Receita de venda - Pedido #706	2026-05-20 02:08:03.924705
956	1230	4823	3	Credito	633.51	Paga	Receita de venda - Pedido #1230	2026-05-20 02:08:03.924705
957	571	4823	3	Credito	0.01	Paga	Receita de venda - Pedido #571	2026-05-20 02:08:03.924705
958	1423	4552	3	Credito	0.01	Paga	Receita de venda - Pedido #1423	2026-05-20 02:08:03.924705
959	956	4629	3	Credito	251.66	Paga	Receita de venda - Pedido #956	2026-05-20 02:08:03.924705
960	666	4413	3	Credito	4760.10	Paga	Receita de venda - Pedido #666	2026-05-20 02:08:03.924705
961	216	4676	3	Credito	2344.30	Paga	Receita de venda - Pedido #216	2026-05-20 02:08:03.924705
962	958	4850	3	Credito	801.65	Paga	Receita de venda - Pedido #958	2026-05-20 02:08:03.924705
963	295	4886	3	Credito	136.98	Paga	Receita de venda - Pedido #295	2026-05-20 02:08:03.924705
964	1730	4740	3	Credito	2488.23	Paga	Receita de venda - Pedido #1730	2026-05-20 02:08:03.924705
965	1655	4660	3	Credito	4977.11	Paga	Receita de venda - Pedido #1655	2026-05-20 02:08:03.924705
966	694	4442	3	Credito	1836.13	Paga	Receita de venda - Pedido #694	2026-05-20 02:08:03.924705
967	213	4798	3	Credito	2325.17	Paga	Receita de venda - Pedido #213	2026-05-20 02:08:03.924705
968	1114	4428	3	Credito	2606.90	Paga	Receita de venda - Pedido #1114	2026-05-20 02:08:03.924705
969	833	4668	3	Credito	722.44	Paga	Receita de venda - Pedido #833	2026-05-20 02:08:03.924705
970	1244	4781	3	Credito	16744.67	Paga	Receita de venda - Pedido #1244	2026-05-20 02:08:03.924705
971	752	4551	3	Credito	7208.63	Paga	Receita de venda - Pedido #752	2026-05-20 02:08:03.924705
972	1013	4792	3	Credito	1096.75	Paga	Receita de venda - Pedido #1013	2026-05-20 02:08:03.924705
973	1760	4432	3	Credito	792.74	Paga	Receita de venda - Pedido #1760	2026-05-20 02:08:03.924705
974	1553	4658	3	Credito	3.42	Paga	Receita de venda - Pedido #1553	2026-05-20 02:08:03.924705
975	594	4878	3	Credito	9496.31	Paga	Receita de venda - Pedido #594	2026-05-20 02:08:03.924705
976	460	4580	3	Credito	6528.95	Paga	Receita de venda - Pedido #460	2026-05-20 02:08:03.924705
977	499	4501	3	Credito	0.01	Paga	Receita de venda - Pedido #499	2026-05-20 02:08:03.924705
978	265	4550	3	Credito	4813.56	Paga	Receita de venda - Pedido #265	2026-05-20 02:08:03.924705
979	1839	4696	3	Credito	0.01	Paga	Receita de venda - Pedido #1839	2026-05-20 02:08:03.924705
980	1530	4878	3	Credito	529.66	Paga	Receita de venda - Pedido #1530	2026-05-20 02:08:03.924705
981	851	4846	3	Credito	0.01	Paga	Receita de venda - Pedido #851	2026-05-20 02:08:03.924705
982	62	4434	3	Credito	4962.47	Paga	Receita de venda - Pedido #62	2026-05-20 02:08:03.924705
983	893	4688	3	Credito	137.31	Paga	Receita de venda - Pedido #893	2026-05-20 02:08:03.924705
984	1318	4660	3	Credito	735.31	Paga	Receita de venda - Pedido #1318	2026-05-20 02:08:03.924705
985	993	4428	3	Credito	1965.94	Paga	Receita de venda - Pedido #993	2026-05-20 02:08:03.924705
986	568	4570	3	Credito	1016.86	Paga	Receita de venda - Pedido #568	2026-05-20 02:08:03.924705
987	805	4752	3	Credito	0.01	Paga	Receita de venda - Pedido #805	2026-05-20 02:08:03.924705
988	1822	4537	3	Credito	2792.26	Paga	Receita de venda - Pedido #1822	2026-05-20 02:08:03.924705
989	1139	4405	3	Credito	794.61	Paga	Receita de venda - Pedido #1139	2026-05-20 02:08:03.924705
990	413	4740	3	Credito	261.05	Paga	Receita de venda - Pedido #413	2026-05-20 02:08:03.924705
991	649	4413	3	Credito	12381.98	Paga	Receita de venda - Pedido #649	2026-05-20 02:08:03.924705
992	100	4750	3	Credito	1440.95	Paga	Receita de venda - Pedido #100	2026-05-20 02:08:03.924705
993	1223	4640	3	Credito	7163.13	Paga	Receita de venda - Pedido #1223	2026-05-20 02:08:03.924705
994	925	4785	3	Credito	179.78	Paga	Receita de venda - Pedido #925	2026-05-20 02:08:03.924705
995	1342	4592	3	Credito	911.22	Paga	Receita de venda - Pedido #1342	2026-05-20 02:08:03.924705
996	421	4624	3	Credito	0.01	Paga	Receita de venda - Pedido #421	2026-05-20 02:08:03.924705
997	429	4793	3	Credito	1662.34	Paga	Receita de venda - Pedido #429	2026-05-20 02:08:03.924705
998	1498	4433	3	Credito	298.01	Paga	Receita de venda - Pedido #1498	2026-05-20 02:08:03.924705
999	835	4676	3	Credito	1737.61	Paga	Receita de venda - Pedido #835	2026-05-20 02:08:03.924705
1000	25	4896	3	Credito	0.01	Paga	Receita de venda - Pedido #25	2026-05-20 02:08:03.924705
1001	141	4537	3	Credito	204.32	Paga	Receita de venda - Pedido #141	2026-05-20 02:08:03.924705
1002	1026	4635	3	Credito	0.01	Paga	Receita de venda - Pedido #1026	2026-05-20 02:08:03.924705
1003	434	4582	3	Credito	1918.15	Paga	Receita de venda - Pedido #434	2026-05-20 02:08:03.924705
1004	211	4636	3	Credito	93.61	Paga	Receita de venda - Pedido #211	2026-05-20 02:08:03.924705
1005	1420	4495	3	Credito	4341.86	Paga	Receita de venda - Pedido #1420	2026-05-20 02:08:03.924705
1006	1320	4551	3	Credito	259.07	Paga	Receita de venda - Pedido #1320	2026-05-20 02:08:03.924705
1007	1191	4631	3	Credito	13685.57	Paga	Receita de venda - Pedido #1191	2026-05-20 02:08:03.924705
1008	901	4691	3	Credito	5533.31	Paga	Receita de venda - Pedido #901	2026-05-20 02:08:03.924705
1009	465	4875	3	Credito	0.01	Paga	Receita de venda - Pedido #465	2026-05-20 02:08:03.924705
1010	449	4428	3	Credito	3544.92	Paga	Receita de venda - Pedido #449	2026-05-20 02:08:03.924705
1011	1853	4485	3	Credito	5809.37	Paga	Receita de venda - Pedido #1853	2026-05-20 02:08:03.924705
1012	64	4838	3	Credito	6662.80	Paga	Receita de venda - Pedido #64	2026-05-20 02:08:03.924705
1013	1421	4829	3	Credito	0.01	Paga	Receita de venda - Pedido #1421	2026-05-20 02:08:03.924705
1014	828	4883	3	Credito	16.23	Paga	Receita de venda - Pedido #828	2026-05-20 02:08:03.924705
1015	1989	4795	3	Credito	2503.08	Paga	Receita de venda - Pedido #1989	2026-05-20 02:08:03.924705
1016	1587	4747	3	Credito	4902.32	Paga	Receita de venda - Pedido #1587	2026-05-20 02:08:03.924705
1017	1091	4577	3	Credito	1229.09	Paga	Receita de venda - Pedido #1091	2026-05-20 02:08:03.924705
1018	839	4830	3	Credito	3722.06	Paga	Receita de venda - Pedido #839	2026-05-20 02:08:03.924705
1019	1075	4862	3	Credito	2211.12	Paga	Receita de venda - Pedido #1075	2026-05-20 02:08:03.924705
1020	539	4831	3	Credito	337.59	Paga	Receita de venda - Pedido #539	2026-05-20 02:08:03.924705
1021	1108	4437	3	Credito	1066.03	Paga	Receita de venda - Pedido #1108	2026-05-20 02:08:03.924705
1022	1128	4758	3	Credito	123.63	Paga	Receita de venda - Pedido #1128	2026-05-20 02:08:03.924705
1023	1284	4489	3	Credito	200.96	Paga	Receita de venda - Pedido #1284	2026-05-20 02:08:03.924705
1024	874	4620	3	Credito	1157.73	Paga	Receita de venda - Pedido #874	2026-05-20 02:08:03.924705
1025	1899	4509	3	Credito	197.92	Paga	Receita de venda - Pedido #1899	2026-05-20 02:08:03.924705
1026	278	4649	3	Credito	0.01	Paga	Receita de venda - Pedido #278	2026-05-20 02:08:03.924705
1027	1691	4685	3	Credito	2442.01	Paga	Receita de venda - Pedido #1691	2026-05-20 02:08:03.924705
1028	946	4888	3	Credito	183.17	Paga	Receita de venda - Pedido #946	2026-05-20 02:08:03.924705
1029	1494	4800	3	Credito	3715.05	Paga	Receita de venda - Pedido #1494	2026-05-20 02:08:03.924705
1030	1045	4413	3	Credito	3980.51	Paga	Receita de venda - Pedido #1045	2026-05-20 02:08:03.924705
1031	1307	4720	3	Credito	1208.34	Paga	Receita de venda - Pedido #1307	2026-05-20 02:08:03.924705
1032	770	4595	3	Credito	6156.98	Paga	Receita de venda - Pedido #770	2026-05-20 02:08:03.924705
1033	271	4828	3	Credito	73.17	Paga	Receita de venda - Pedido #271	2026-05-20 02:08:03.924705
1034	22	4774	3	Credito	18787.20	Paga	Receita de venda - Pedido #22	2026-05-20 02:08:03.924705
1035	1883	4809	3	Credito	6715.05	Paga	Receita de venda - Pedido #1883	2026-05-20 02:08:03.924705
1036	1558	4595	3	Credito	370.24	Paga	Receita de venda - Pedido #1558	2026-05-20 02:08:03.924705
1037	417	4478	3	Credito	1106.90	Paga	Receita de venda - Pedido #417	2026-05-20 02:08:03.924705
1038	1175	4738	3	Credito	2010.95	Paga	Receita de venda - Pedido #1175	2026-05-20 02:08:03.924705
1039	529	4600	3	Credito	1757.97	Paga	Receita de venda - Pedido #529	2026-05-20 02:08:03.924705
1040	791	4858	3	Credito	20.07	Paga	Receita de venda - Pedido #791	2026-05-20 02:08:03.924705
1041	775	4839	3	Credito	52.60	Paga	Receita de venda - Pedido #775	2026-05-20 02:08:03.924705
1042	1830	4544	3	Credito	11605.58	Paga	Receita de venda - Pedido #1830	2026-05-20 02:08:03.924705
1043	390	4837	3	Credito	343.24	Paga	Receita de venda - Pedido #390	2026-05-20 02:08:03.924705
1044	1018	4503	3	Credito	191.14	Paga	Receita de venda - Pedido #1018	2026-05-20 02:08:03.924705
1045	1833	4518	3	Credito	197.91	Paga	Receita de venda - Pedido #1833	2026-05-20 02:08:03.924705
1046	1263	4903	3	Credito	698.56	Paga	Receita de venda - Pedido #1263	2026-05-20 02:08:03.924705
1047	189	4831	3	Credito	5959.62	Paga	Receita de venda - Pedido #189	2026-05-20 02:08:03.924705
1048	1682	4721	3	Credito	3549.37	Paga	Receita de venda - Pedido #1682	2026-05-20 02:08:03.924705
1049	1431	4878	3	Credito	3911.22	Paga	Receita de venda - Pedido #1431	2026-05-20 02:08:03.924705
1050	120	4518	3	Credito	6524.84	Paga	Receita de venda - Pedido #120	2026-05-20 02:08:03.924705
1051	1289	4518	3	Credito	0.01	Paga	Receita de venda - Pedido #1289	2026-05-20 02:08:03.924705
1052	802	4694	3	Credito	1864.48	Paga	Receita de venda - Pedido #802	2026-05-20 02:08:03.924705
1053	578	4590	3	Credito	24857.51	Paga	Receita de venda - Pedido #578	2026-05-20 02:08:03.924705
1054	695	4888	3	Credito	0.01	Paga	Receita de venda - Pedido #695	2026-05-20 02:08:03.924705
1055	1415	4856	3	Credito	3327.34	Paga	Receita de venda - Pedido #1415	2026-05-20 02:08:03.924705
1056	794	4815	3	Credito	0.85	Paga	Receita de venda - Pedido #794	2026-05-20 02:08:03.924705
1057	1510	4436	3	Credito	1586.21	Paga	Receita de venda - Pedido #1510	2026-05-20 02:08:03.924705
1058	1749	4425	3	Credito	2321.63	Paga	Receita de venda - Pedido #1749	2026-05-20 02:08:03.924705
1059	1368	4818	3	Credito	4559.11	Paga	Receita de venda - Pedido #1368	2026-05-20 02:08:03.924705
1060	508	4884	3	Credito	7975.08	Paga	Receita de venda - Pedido #508	2026-05-20 02:08:03.924705
1061	1692	4905	3	Credito	1423.23	Paga	Receita de venda - Pedido #1692	2026-05-20 02:08:03.924705
1062	1194	4795	3	Credito	742.78	Paga	Receita de venda - Pedido #1194	2026-05-20 02:08:03.924705
1063	1705	4914	3	Credito	2389.70	Paga	Receita de venda - Pedido #1705	2026-05-20 02:08:03.924705
1064	1463	4722	3	Credito	5847.87	Paga	Receita de venda - Pedido #1463	2026-05-20 02:08:03.924705
1065	1829	4479	3	Credito	1304.39	Paga	Receita de venda - Pedido #1829	2026-05-20 02:08:03.924705
1066	315	4666	3	Credito	1103.98	Paga	Receita de venda - Pedido #315	2026-05-20 02:08:03.924705
1067	1162	4913	3	Credito	384.90	Paga	Receita de venda - Pedido #1162	2026-05-20 02:08:03.924705
1068	1841	4797	3	Credito	1527.14	Paga	Receita de venda - Pedido #1841	2026-05-20 02:08:03.924705
1069	841	4638	3	Credito	5532.88	Paga	Receita de venda - Pedido #841	2026-05-20 02:08:03.924705
1070	1030	4394	3	Credito	1266.38	Paga	Receita de venda - Pedido #1030	2026-05-20 02:08:03.924705
1071	1694	4527	3	Credito	408.11	Paga	Receita de venda - Pedido #1694	2026-05-20 02:08:03.924705
1072	1614	4474	3	Credito	1581.54	Paga	Receita de venda - Pedido #1614	2026-05-20 02:08:03.924705
1073	1239	4530	3	Credito	8676.46	Paga	Receita de venda - Pedido #1239	2026-05-20 02:08:03.924705
1074	803	4488	3	Credito	6687.24	Paga	Receita de venda - Pedido #803	2026-05-20 02:08:03.924705
1075	54	4698	3	Credito	0.01	Paga	Receita de venda - Pedido #54	2026-05-20 02:08:03.924705
1076	181	4624	3	Credito	58.84	Paga	Receita de venda - Pedido #181	2026-05-20 02:08:03.924705
1077	35	4537	3	Credito	1988.09	Paga	Receita de venda - Pedido #35	2026-05-20 02:08:03.924705
1078	1755	4647	3	Credito	9681.13	Paga	Receita de venda - Pedido #1755	2026-05-20 02:08:03.924705
1079	963	4677	3	Credito	0.01	Paga	Receita de venda - Pedido #963	2026-05-20 02:08:03.924705
1080	220	4762	3	Credito	456.63	Paga	Receita de venda - Pedido #220	2026-05-20 02:08:03.924705
1081	1913	4504	3	Credito	607.22	Paga	Receita de venda - Pedido #1913	2026-05-20 02:08:03.924705
1082	1278	4819	3	Credito	145.63	Paga	Receita de venda - Pedido #1278	2026-05-20 02:08:03.924705
1083	400	4681	3	Credito	339.55	Paga	Receita de venda - Pedido #400	2026-05-20 02:08:03.924705
1084	1007	4761	3	Credito	13309.04	Paga	Receita de venda - Pedido #1007	2026-05-20 02:08:03.924705
1085	285	4772	3	Credito	5832.46	Paga	Receita de venda - Pedido #285	2026-05-20 02:08:03.924705
1086	1880	4568	3	Credito	0.01	Paga	Receita de venda - Pedido #1880	2026-05-20 02:08:03.924705
1087	1266	4779	3	Credito	201.04	Paga	Receita de venda - Pedido #1266	2026-05-20 02:08:03.924705
1088	391	4570	3	Credito	970.19	Paga	Receita de venda - Pedido #391	2026-05-20 02:08:03.924705
1089	1922	4708	3	Credito	0.01	Paga	Receita de venda - Pedido #1922	2026-05-20 02:08:03.924705
1090	487	4646	3	Credito	1059.87	Paga	Receita de venda - Pedido #487	2026-05-20 02:08:03.924705
1091	1718	4545	3	Credito	2254.85	Paga	Receita de venda - Pedido #1718	2026-05-20 02:08:03.924705
1092	1664	4456	3	Credito	2685.14	Paga	Receita de venda - Pedido #1664	2026-05-20 02:08:03.924705
1093	1190	4708	3	Credito	2773.98	Paga	Receita de venda - Pedido #1190	2026-05-20 02:08:03.924705
1094	714	4654	3	Credito	8013.08	Paga	Receita de venda - Pedido #714	2026-05-20 02:08:03.924705
1095	1920	4621	3	Credito	0.01	Paga	Receita de venda - Pedido #1920	2026-05-20 02:08:03.924705
1096	906	4394	3	Credito	760.12	Paga	Receita de venda - Pedido #906	2026-05-20 02:08:03.924705
1097	1321	4518	3	Credito	2920.73	Paga	Receita de venda - Pedido #1321	2026-05-20 02:08:03.924705
1098	909	4590	3	Credito	2726.23	Paga	Receita de venda - Pedido #909	2026-05-20 02:08:03.924705
1099	745	4466	3	Credito	556.26	Paga	Receita de venda - Pedido #745	2026-05-20 02:08:03.924705
1100	152	4834	3	Credito	4684.47	Paga	Receita de venda - Pedido #152	2026-05-20 02:08:03.924705
1101	1216	4455	3	Credito	495.62	Paga	Receita de venda - Pedido #1216	2026-05-20 02:08:03.924705
1102	1685	4625	3	Credito	0.01	Paga	Receita de venda - Pedido #1685	2026-05-20 02:08:03.924705
1103	1049	4797	3	Credito	15135.09	Paga	Receita de venda - Pedido #1049	2026-05-20 02:08:03.924705
1104	428	4520	3	Credito	3714.70	Paga	Receita de venda - Pedido #428	2026-05-20 02:08:03.924705
1105	1786	4537	3	Credito	487.93	Paga	Receita de venda - Pedido #1786	2026-05-20 02:08:03.924705
1106	747	4854	3	Credito	399.42	Paga	Receita de venda - Pedido #747	2026-05-20 02:08:03.924705
1107	1324	4629	3	Credito	0.01	Paga	Receita de venda - Pedido #1324	2026-05-20 02:08:03.924705
1108	1008	4849	3	Credito	0.01	Paga	Receita de venda - Pedido #1008	2026-05-20 02:08:03.924705
1109	777	4479	3	Credito	6773.78	Paga	Receita de venda - Pedido #777	2026-05-20 02:08:03.924705
1110	164	4760	3	Credito	4317.19	Paga	Receita de venda - Pedido #164	2026-05-20 02:08:03.924705
1111	1098	4816	3	Credito	271.77	Paga	Receita de venda - Pedido #1098	2026-05-20 02:08:03.924705
1112	1325	4829	3	Credito	1462.82	Paga	Receita de venda - Pedido #1325	2026-05-20 02:08:03.924705
1113	186	4573	3	Credito	1062.80	Paga	Receita de venda - Pedido #186	2026-05-20 02:08:03.924705
1114	1929	4665	3	Credito	108.26	Paga	Receita de venda - Pedido #1929	2026-05-20 02:08:03.924705
1115	1548	4774	3	Credito	826.23	Paga	Receita de venda - Pedido #1548	2026-05-20 02:08:03.924705
1116	501	4876	3	Credito	528.63	Paga	Receita de venda - Pedido #501	2026-05-20 02:08:03.924705
1117	750	4534	3	Credito	65.57	Paga	Receita de venda - Pedido #750	2026-05-20 02:08:03.924705
1118	1952	4851	3	Credito	271.00	Paga	Receita de venda - Pedido #1952	2026-05-20 02:08:03.924705
1119	1679	4623	3	Credito	98.44	Paga	Receita de venda - Pedido #1679	2026-05-20 02:08:03.924705
1120	545	4675	3	Credito	2220.31	Paga	Receita de venda - Pedido #545	2026-05-20 02:08:03.924705
1121	977	4587	3	Credito	665.09	Paga	Receita de venda - Pedido #977	2026-05-20 02:08:03.924705
1122	18	4408	3	Credito	1792.63	Paga	Receita de venda - Pedido #18	2026-05-20 02:08:03.924705
1123	1507	4737	3	Credito	226.80	Paga	Receita de venda - Pedido #1507	2026-05-20 02:08:03.924705
1124	1900	4560	3	Credito	4310.94	Paga	Receita de venda - Pedido #1900	2026-05-20 02:08:03.924705
1125	27	4768	3	Credito	161.35	Paga	Receita de venda - Pedido #27	2026-05-20 02:08:03.924705
1126	1959	4546	3	Credito	7327.99	Paga	Receita de venda - Pedido #1959	2026-05-20 02:08:03.924705
1127	143	4706	3	Credito	250.58	Paga	Receita de venda - Pedido #143	2026-05-20 02:08:03.924705
1128	1907	4791	3	Credito	238.05	Paga	Receita de venda - Pedido #1907	2026-05-20 02:08:03.924705
1129	496	4632	3	Credito	2162.72	Paga	Receita de venda - Pedido #496	2026-05-20 02:08:03.924705
1130	1762	4892	3	Credito	874.00	Paga	Receita de venda - Pedido #1762	2026-05-20 02:08:03.924705
1131	58	4771	3	Credito	484.29	Paga	Receita de venda - Pedido #58	2026-05-20 02:08:03.924705
1132	228	4678	3	Credito	103.63	Paga	Receita de venda - Pedido #228	2026-05-20 02:08:03.924705
1133	1845	4899	3	Credito	0.01	Paga	Receita de venda - Pedido #1845	2026-05-20 02:08:03.924705
1134	814	4573	3	Credito	387.80	Paga	Receita de venda - Pedido #814	2026-05-20 02:08:03.924705
1135	668	4865	3	Credito	869.43	Paga	Receita de venda - Pedido #668	2026-05-20 02:08:03.924705
1136	850	4891	3	Credito	652.04	Paga	Receita de venda - Pedido #850	2026-05-20 02:08:03.924705
1137	294	4425	3	Credito	27.44	Paga	Receita de venda - Pedido #294	2026-05-20 02:08:03.924705
1138	1800	4564	3	Credito	3411.35	Paga	Receita de venda - Pedido #1800	2026-05-20 02:08:03.924705
1139	1629	4658	3	Credito	2378.99	Paga	Receita de venda - Pedido #1629	2026-05-20 02:08:03.924705
1140	926	4740	3	Credito	297.54	Paga	Receita de venda - Pedido #926	2026-05-20 02:08:03.924705
1141	645	4531	3	Credito	0.01	Paga	Receita de venda - Pedido #645	2026-05-20 02:08:03.924705
1142	1009	4618	3	Credito	767.61	Paga	Receita de venda - Pedido #1009	2026-05-20 02:08:03.924705
1143	1460	4640	3	Credito	236.49	Paga	Receita de venda - Pedido #1460	2026-05-20 02:08:03.924705
1144	607	4795	3	Credito	105.30	Paga	Receita de venda - Pedido #607	2026-05-20 02:08:03.924705
1145	258	4744	3	Credito	2413.29	Paga	Receita de venda - Pedido #258	2026-05-20 02:08:03.924705
1146	1546	4859	3	Credito	65.27	Paga	Receita de venda - Pedido #1546	2026-05-20 02:08:03.924705
1147	483	4772	3	Credito	742.73	Paga	Receita de venda - Pedido #483	2026-05-20 02:08:03.924705
1148	1816	4398	3	Credito	0.01	Paga	Receita de venda - Pedido #1816	2026-05-20 02:08:03.924705
1149	1708	4886	3	Credito	2850.03	Paga	Receita de venda - Pedido #1708	2026-05-20 02:08:03.924705
1150	1619	4837	3	Credito	6525.91	Paga	Receita de venda - Pedido #1619	2026-05-20 02:08:03.924705
1151	84	4489	3	Credito	2720.18	Paga	Receita de venda - Pedido #84	2026-05-20 02:08:03.924705
1152	1836	4429	3	Credito	8653.88	Paga	Receita de venda - Pedido #1836	2026-05-20 02:08:03.924705
1153	1877	4498	3	Credito	3131.58	Paga	Receita de venda - Pedido #1877	2026-05-20 02:08:03.924705
1154	646	4459	3	Credito	319.65	Paga	Receita de venda - Pedido #646	2026-05-20 02:08:03.924705
1155	1815	4794	3	Credito	1682.24	Paga	Receita de venda - Pedido #1815	2026-05-20 02:08:03.924705
1156	1259	4411	3	Credito	182.85	Paga	Receita de venda - Pedido #1259	2026-05-20 02:08:03.924705
1157	379	4886	3	Credito	467.68	Paga	Receita de venda - Pedido #379	2026-05-20 02:08:03.924705
1158	320	4832	3	Credito	1683.49	Paga	Receita de venda - Pedido #320	2026-05-20 02:08:03.924705
1159	1062	4546	3	Credito	751.85	Paga	Receita de venda - Pedido #1062	2026-05-20 02:08:03.924705
1160	942	4498	3	Credito	1816.78	Paga	Receita de venda - Pedido #942	2026-05-20 02:08:03.924705
1161	115	4721	3	Credito	1339.37	Paga	Receita de venda - Pedido #115	2026-05-20 02:08:03.924705
1162	1458	4545	3	Credito	234.95	Paga	Receita de venda - Pedido #1458	2026-05-20 02:08:03.924705
1163	108	4867	3	Credito	0.01	Paga	Receita de venda - Pedido #108	2026-05-20 02:08:03.924705
1164	59	4515	3	Credito	1755.09	Paga	Receita de venda - Pedido #59	2026-05-20 02:08:03.924705
1165	1862	4385	3	Credito	6794.02	Paga	Receita de venda - Pedido #1862	2026-05-20 02:08:03.924705
1166	1535	4577	3	Credito	363.09	Paga	Receita de venda - Pedido #1535	2026-05-20 02:08:03.924705
1167	127	4501	3	Credito	0.01	Paga	Receita de venda - Pedido #127	2026-05-20 02:08:03.924705
1168	1697	4773	3	Credito	18664.69	Paga	Receita de venda - Pedido #1697	2026-05-20 02:08:03.924705
1169	1285	4620	3	Credito	1879.32	Paga	Receita de venda - Pedido #1285	2026-05-20 02:08:03.924705
1170	1924	4460	3	Credito	2869.91	Paga	Receita de venda - Pedido #1924	2026-05-20 02:08:03.924705
1171	1447	4699	3	Credito	92.12	Paga	Receita de venda - Pedido #1447	2026-05-20 02:08:03.924705
1172	1866	4708	3	Credito	1272.13	Paga	Receita de venda - Pedido #1866	2026-05-20 02:08:03.924705
1173	676	4849	3	Credito	0.01	Paga	Receita de venda - Pedido #676	2026-05-20 02:08:03.924705
1174	153	4457	3	Credito	1146.49	Paga	Receita de venda - Pedido #153	2026-05-20 02:08:03.924705
1175	778	4743	3	Credito	3506.60	Paga	Receita de venda - Pedido #778	2026-05-20 02:08:03.924705
1176	214	4412	3	Credito	227.38	Paga	Receita de venda - Pedido #214	2026-05-20 02:08:03.924705
1177	1753	4915	3	Credito	5655.01	Paga	Receita de venda - Pedido #1753	2026-05-20 02:08:03.924705
1178	1170	4609	3	Credito	0.01	Paga	Receita de venda - Pedido #1170	2026-05-20 02:08:03.924705
1179	532	4466	3	Credito	2710.97	Paga	Receita de venda - Pedido #532	2026-05-20 02:08:03.924705
1180	945	4859	3	Credito	4219.51	Paga	Receita de venda - Pedido #945	2026-05-20 02:08:03.924705
1181	1371	4616	3	Credito	691.28	Paga	Receita de venda - Pedido #1371	2026-05-20 02:08:03.924705
1182	1951	4437	3	Credito	597.11	Paga	Receita de venda - Pedido #1951	2026-05-20 02:08:03.924705
1183	259	4826	3	Credito	1819.69	Paga	Receita de venda - Pedido #259	2026-05-20 02:08:03.924705
1184	1203	4877	3	Credito	11265.14	Paga	Receita de venda - Pedido #1203	2026-05-20 02:08:03.924705
1185	1915	4760	3	Credito	34.66	Paga	Receita de venda - Pedido #1915	2026-05-20 02:08:03.924705
1186	840	4772	3	Credito	0.01	Paga	Receita de venda - Pedido #840	2026-05-20 02:08:03.924705
1187	1378	4410	3	Credito	1580.98	Paga	Receita de venda - Pedido #1378	2026-05-20 02:08:03.924705
1188	1038	4428	3	Credito	5748.86	Paga	Receita de venda - Pedido #1038	2026-05-20 02:08:03.924705
1189	3	4686	3	Credito	385.64	Paga	Receita de venda - Pedido #3	2026-05-20 02:08:03.924705
1190	324	4412	3	Credito	4816.84	Paga	Receita de venda - Pedido #324	2026-05-20 02:08:03.924705
1191	921	4646	3	Credito	89.33	Paga	Receita de venda - Pedido #921	2026-05-20 02:08:03.924705
1192	1227	4677	3	Credito	207.94	Paga	Receita de venda - Pedido #1227	2026-05-20 02:08:03.924705
1193	1923	4896	3	Credito	329.45	Paga	Receita de venda - Pedido #1923	2026-05-20 02:08:03.924705
1194	1780	4512	3	Credito	1208.95	Paga	Receita de venda - Pedido #1780	2026-05-20 02:08:03.924705
1195	1295	4458	3	Credito	101.07	Paga	Receita de venda - Pedido #1295	2026-05-20 02:08:03.924705
1196	1126	4697	3	Credito	3959.79	Paga	Receita de venda - Pedido #1126	2026-05-20 02:08:03.924705
1197	1217	4425	3	Credito	1546.08	Paga	Receita de venda - Pedido #1217	2026-05-20 02:08:03.924705
1198	984	4724	3	Credito	1252.29	Paga	Receita de venda - Pedido #984	2026-05-20 02:08:03.924705
1199	1249	4607	3	Credito	120.92	Paga	Receita de venda - Pedido #1249	2026-05-20 02:08:03.924705
1200	868	4845	3	Credito	284.00	Paga	Receita de venda - Pedido #868	2026-05-20 02:08:03.924705
1201	418	4531	3	Credito	631.42	Paga	Receita de venda - Pedido #418	2026-05-20 02:08:03.924705
1202	1870	4699	3	Credito	215.94	Paga	Receita de venda - Pedido #1870	2026-05-20 02:08:03.924705
1203	1524	4831	3	Credito	1186.74	Paga	Receita de venda - Pedido #1524	2026-05-20 02:08:03.924705
1204	1229	4679	3	Credito	1961.72	Paga	Receita de venda - Pedido #1229	2026-05-20 02:08:03.924705
1205	978	4518	3	Credito	621.64	Paga	Receita de venda - Pedido #978	2026-05-20 02:08:03.924705
1206	407	4895	3	Credito	2749.01	Paga	Receita de venda - Pedido #407	2026-05-20 02:08:03.924705
1207	387	4616	3	Credito	0.01	Paga	Receita de venda - Pedido #387	2026-05-20 02:08:03.924705
1208	1337	4481	3	Credito	142.60	Paga	Receita de venda - Pedido #1337	2026-05-20 02:08:03.924705
1209	39	4408	3	Credito	819.11	Paga	Receita de venda - Pedido #39	2026-05-20 02:08:03.924705
1210	690	4422	3	Credito	183.59	Paga	Receita de venda - Pedido #690	2026-05-20 02:08:03.924705
1211	1477	4684	3	Credito	4514.99	Paga	Receita de venda - Pedido #1477	2026-05-20 02:08:03.924705
1212	1209	4738	3	Credito	19847.51	Paga	Receita de venda - Pedido #1209	2026-05-20 02:08:03.924705
1213	1837	4916	3	Credito	3068.03	Paga	Receita de venda - Pedido #1837	2026-05-20 02:08:03.924705
1214	1569	4813	3	Credito	2523.17	Paga	Receita de venda - Pedido #1569	2026-05-20 02:08:03.924705
1215	1674	4912	3	Credito	4143.38	Paga	Receita de venda - Pedido #1674	2026-05-20 02:08:03.924705
1216	683	4589	3	Credito	2848.53	Paga	Receita de venda - Pedido #683	2026-05-20 02:08:03.924705
1217	793	4582	3	Credito	600.72	Paga	Receita de venda - Pedido #793	2026-05-20 02:08:03.924705
1218	608	4589	3	Credito	6971.26	Paga	Receita de venda - Pedido #608	2026-05-20 02:08:03.924705
1219	317	4558	3	Credito	402.49	Paga	Receita de venda - Pedido #317	2026-05-20 02:08:03.924705
1220	702	4569	3	Credito	398.31	Paga	Receita de venda - Pedido #702	2026-05-20 02:08:03.924705
1221	126	4685	3	Credito	2602.78	Paga	Receita de venda - Pedido #126	2026-05-20 02:08:03.924705
1222	194	4466	3	Credito	3436.48	Paga	Receita de venda - Pedido #194	2026-05-20 02:08:03.924705
1223	1620	4819	3	Credito	276.53	Paga	Receita de venda - Pedido #1620	2026-05-20 02:08:03.924705
1224	463	4623	3	Credito	3500.15	Paga	Receita de venda - Pedido #463	2026-05-20 02:08:03.924705
1225	1570	4427	3	Credito	11742.59	Paga	Receita de venda - Pedido #1570	2026-05-20 02:08:03.924705
1226	476	4838	3	Credito	13459.92	Paga	Receita de venda - Pedido #476	2026-05-20 02:08:03.924705
1227	883	4643	3	Credito	0.01	Paga	Receita de venda - Pedido #883	2026-05-20 02:08:03.924705
1228	1887	4821	3	Credito	2366.79	Paga	Receita de venda - Pedido #1887	2026-05-20 02:08:03.924705
1229	374	4491	3	Credito	7193.85	Paga	Receita de venda - Pedido #374	2026-05-20 02:08:03.924705
1230	1146	4391	3	Credito	5252.45	Paga	Receita de venda - Pedido #1146	2026-05-20 02:08:03.924705
1231	1544	4661	3	Credito	1436.28	Paga	Receita de venda - Pedido #1544	2026-05-20 02:08:03.924705
1232	1632	4620	3	Credito	232.40	Paga	Receita de venda - Pedido #1632	2026-05-20 02:08:03.924705
1233	1210	4633	3	Credito	4527.61	Paga	Receita de venda - Pedido #1210	2026-05-20 02:08:03.924705
1234	224	4607	3	Credito	2442.49	Paga	Receita de venda - Pedido #224	2026-05-20 02:08:03.924705
1235	719	4396	3	Credito	251.33	Paga	Receita de venda - Pedido #719	2026-05-20 02:08:03.924705
1236	756	4916	3	Credito	8333.12	Paga	Receita de venda - Pedido #756	2026-05-20 02:08:03.924705
1237	318	4888	3	Credito	14906.20	Paga	Receita de venda - Pedido #318	2026-05-20 02:08:03.924705
1238	1665	4791	3	Credito	9254.38	Paga	Receita de venda - Pedido #1665	2026-05-20 02:08:03.924705
1239	933	4457	3	Credito	237.23	Paga	Receita de venda - Pedido #933	2026-05-20 02:08:03.924705
1240	647	4740	3	Credito	155.18	Paga	Receita de venda - Pedido #647	2026-05-20 02:08:03.924705
1241	1296	4792	3	Credito	33.91	Paga	Receita de venda - Pedido #1296	2026-05-20 02:08:03.924705
1242	593	4895	3	Credito	154.47	Paga	Receita de venda - Pedido #593	2026-05-20 02:08:03.924705
1243	293	4846	3	Credito	305.15	Paga	Receita de venda - Pedido #293	2026-05-20 02:08:03.924705
1244	1808	4811	3	Credito	7303.44	Paga	Receita de venda - Pedido #1808	2026-05-20 02:08:03.924705
1245	1120	4578	3	Credito	11607.12	Paga	Receita de venda - Pedido #1120	2026-05-20 02:08:03.924705
1246	495	4524	3	Credito	0.01	Paga	Receita de venda - Pedido #495	2026-05-20 02:08:03.924705
1247	1257	4784	3	Credito	5982.52	Paga	Receita de venda - Pedido #1257	2026-05-20 02:08:03.924705
1248	154	4837	3	Credito	0.01	Paga	Receita de venda - Pedido #154	2026-05-20 02:08:03.924705
1249	657	4691	3	Credito	176.09	Paga	Receita de venda - Pedido #657	2026-05-20 02:08:03.924705
1250	234	4624	3	Credito	161.95	Paga	Receita de venda - Pedido #234	2026-05-20 02:08:03.924705
1251	1645	4792	3	Credito	2241.09	Paga	Receita de venda - Pedido #1645	2026-05-20 02:08:03.924705
1252	1306	4476	3	Credito	3854.48	Paga	Receita de venda - Pedido #1306	2026-05-20 02:08:03.924705
1253	474	4563	3	Credito	3774.84	Paga	Receita de venda - Pedido #474	2026-05-20 02:08:03.924705
1254	1961	4608	3	Credito	1554.35	Paga	Receita de venda - Pedido #1961	2026-05-20 02:08:03.924705
1255	748	4385	3	Credito	3743.36	Paga	Receita de venda - Pedido #748	2026-05-20 02:08:03.924705
1256	1666	4579	3	Credito	5653.78	Paga	Receita de venda - Pedido #1666	2026-05-20 02:08:03.924705
1257	1910	4495	3	Credito	5600.88	Paga	Receita de venda - Pedido #1910	2026-05-20 02:08:03.924705
1258	1179	4573	3	Credito	763.44	Paga	Receita de venda - Pedido #1179	2026-05-20 02:08:03.924705
1259	1847	4584	3	Credito	1159.62	Paga	Receita de venda - Pedido #1847	2026-05-20 02:08:03.924705
1260	1700	4672	3	Credito	104.72	Paga	Receita de venda - Pedido #1700	2026-05-20 02:08:03.924705
1261	351	4535	3	Credito	137.83	Paga	Receita de venda - Pedido #351	2026-05-20 02:08:03.924705
1262	116	4460	3	Credito	2564.97	Paga	Receita de venda - Pedido #116	2026-05-20 02:08:03.924705
1263	1791	4853	3	Credito	819.43	Paga	Receita de venda - Pedido #1791	2026-05-20 02:08:03.924705
1264	1810	4555	3	Credito	8.97	Paga	Receita de venda - Pedido #1810	2026-05-20 02:08:03.924705
1265	1733	4684	3	Credito	0.01	Paga	Receita de venda - Pedido #1733	2026-05-20 02:08:03.924705
1266	970	4697	3	Credito	200.85	Paga	Receita de venda - Pedido #970	2026-05-20 02:08:03.924705
1267	1974	4615	3	Credito	2722.55	Paga	Receita de venda - Pedido #1974	2026-05-20 02:08:03.924705
1268	1977	4811	3	Credito	382.60	Paga	Receita de venda - Pedido #1977	2026-05-20 02:08:03.924705
1269	732	4675	3	Credito	0.01	Paga	Receita de venda - Pedido #732	2026-05-20 02:08:03.924705
1270	1711	4451	3	Credito	368.94	Paga	Receita de venda - Pedido #1711	2026-05-20 02:08:03.924705
1271	1856	4550	3	Credito	0.01	Paga	Receita de venda - Pedido #1856	2026-05-20 02:08:03.924705
1272	1627	4897	3	Credito	182.90	Paga	Receita de venda - Pedido #1627	2026-05-20 02:08:03.924705
1273	734	4614	3	Credito	1932.50	Paga	Receita de venda - Pedido #734	2026-05-20 02:08:03.924705
1274	1767	4850	3	Credito	75.99	Paga	Receita de venda - Pedido #1767	2026-05-20 02:08:03.924705
1275	1272	4625	3	Credito	7.90	Paga	Receita de venda - Pedido #1272	2026-05-20 02:08:03.924705
1276	1563	4826	3	Credito	65.23	Paga	Receita de venda - Pedido #1563	2026-05-20 02:08:03.924705
1277	1567	4510	3	Credito	5.58	Paga	Receita de venda - Pedido #1567	2026-05-20 02:08:03.924705
1278	180	4800	3	Credito	0.01	Paga	Receita de venda - Pedido #180	2026-05-20 02:08:03.924705
1279	1219	4900	3	Credito	41.86	Paga	Receita de venda - Pedido #1219	2026-05-20 02:08:03.924705
1280	967	4421	3	Credito	11162.36	Paga	Receita de venda - Pedido #967	2026-05-20 02:08:03.924705
1281	1827	4678	3	Credito	1759.41	Paga	Receita de venda - Pedido #1827	2026-05-20 02:08:03.924705
1282	626	4843	3	Credito	1174.56	Paga	Receita de venda - Pedido #626	2026-05-20 02:08:03.924705
1283	263	4521	3	Credito	0.01	Paga	Receita de venda - Pedido #263	2026-05-20 02:08:03.924705
1284	836	4775	3	Credito	168.13	Paga	Receita de venda - Pedido #836	2026-05-20 02:08:03.924705
1285	784	4681	3	Credito	915.43	Paga	Receita de venda - Pedido #784	2026-05-20 02:08:03.924705
1286	1571	4648	3	Credito	0.01	Paga	Receita de venda - Pedido #1571	2026-05-20 02:08:03.924705
1287	470	4515	3	Credito	1138.54	Paga	Receita de venda - Pedido #470	2026-05-20 02:08:03.924705
1288	1565	4800	3	Credito	12373.42	Paga	Receita de venda - Pedido #1565	2026-05-20 02:08:03.924705
1289	780	4825	3	Credito	43.01	Paga	Receita de venda - Pedido #780	2026-05-20 02:08:03.924705
1290	1668	4833	3	Credito	562.63	Paga	Receita de venda - Pedido #1668	2026-05-20 02:08:03.924705
1291	478	4651	3	Credito	12954.76	Paga	Receita de venda - Pedido #478	2026-05-20 02:08:03.924705
1292	1301	4888	3	Credito	5816.83	Paga	Receita de venda - Pedido #1301	2026-05-20 02:08:03.924705
1293	577	4636	3	Credito	0.01	Paga	Receita de venda - Pedido #577	2026-05-20 02:08:03.924705
1294	505	4659	3	Credito	0.01	Paga	Receita de venda - Pedido #505	2026-05-20 02:08:03.924705
1295	1057	4397	3	Credito	0.01	Paga	Receita de venda - Pedido #1057	2026-05-20 02:08:03.924705
1296	328	4724	3	Credito	114.77	Paga	Receita de venda - Pedido #328	2026-05-20 02:08:03.924705
1297	717	4518	3	Credito	1187.35	Paga	Receita de venda - Pedido #717	2026-05-20 02:08:03.924705
1298	525	4669	3	Credito	0.01	Paga	Receita de venda - Pedido #525	2026-05-20 02:08:03.924705
1299	634	4689	3	Credito	3093.80	Paga	Receita de venda - Pedido #634	2026-05-20 02:08:03.924705
1300	1771	4722	3	Credito	0.01	Paga	Receita de venda - Pedido #1771	2026-05-20 02:08:03.924705
1301	1938	4605	3	Credito	1375.21	Paga	Receita de venda - Pedido #1938	2026-05-20 02:08:03.924705
1302	210	4668	3	Credito	10154.53	Paga	Receita de venda - Pedido #210	2026-05-20 02:08:03.924705
1303	710	4589	3	Credito	662.52	Paga	Receita de venda - Pedido #710	2026-05-20 02:08:03.924705
1304	48	4531	3	Credito	16720.63	Paga	Receita de venda - Pedido #48	2026-05-20 02:08:03.924705
1305	1016	4841	3	Credito	2595.28	Paga	Receita de venda - Pedido #1016	2026-05-20 02:08:03.924705
1306	1015	4391	3	Credito	13893.07	Paga	Receita de venda - Pedido #1015	2026-05-20 02:08:03.924705
1307	1661	4554	3	Credito	2006.27	Paga	Receita de venda - Pedido #1661	2026-05-20 02:08:03.924705
1308	954	4914	3	Credito	1349.72	Paga	Receita de venda - Pedido #954	2026-05-20 02:08:03.924705
1309	1218	4774	3	Credito	597.79	Paga	Receita de venda - Pedido #1218	2026-05-20 02:08:03.924705
1310	1077	4592	3	Credito	0.01	Paga	Receita de venda - Pedido #1077	2026-05-20 02:08:03.924705
1311	456	4821	3	Credito	12946.15	Paga	Receita de venda - Pedido #456	2026-05-20 02:08:03.924705
1312	796	4915	3	Credito	10.42	Paga	Receita de venda - Pedido #796	2026-05-20 02:08:03.924705
1313	1896	4445	3	Credito	62.73	Paga	Receita de venda - Pedido #1896	2026-05-20 02:08:03.924705
1314	1281	4433	3	Credito	787.47	Paga	Receita de venda - Pedido #1281	2026-05-20 02:08:03.924705
1315	1247	4654	3	Credito	153.68	Paga	Receita de venda - Pedido #1247	2026-05-20 02:08:03.924705
1316	531	4796	3	Credito	14684.32	Paga	Receita de venda - Pedido #531	2026-05-20 02:08:03.924705
1317	1409	4541	3	Credito	0.01	Paga	Receita de venda - Pedido #1409	2026-05-20 02:08:03.924705
1318	546	4578	3	Credito	4745.16	Paga	Receita de venda - Pedido #546	2026-05-20 02:08:03.924705
1319	1427	4576	3	Credito	2448.05	Paga	Receita de venda - Pedido #1427	2026-05-20 02:08:03.924705
1320	686	4643	3	Credito	408.99	Paga	Receita de venda - Pedido #686	2026-05-20 02:08:03.924705
1321	297	4713	3	Credito	2027.13	Paga	Receita de venda - Pedido #297	2026-05-20 02:08:03.924705
1322	1658	4537	3	Credito	24706.69	Paga	Receita de venda - Pedido #1658	2026-05-20 02:08:03.924705
1323	1622	4391	3	Credito	19668.54	Paga	Receita de venda - Pedido #1622	2026-05-20 02:08:03.924705
1324	303	4453	3	Credito	3324.84	Paga	Receita de venda - Pedido #303	2026-05-20 02:08:03.924705
1325	1261	4662	3	Credito	1249.44	Paga	Receita de venda - Pedido #1261	2026-05-20 02:08:03.924705
1326	974	4536	3	Credito	536.14	Paga	Receita de venda - Pedido #974	2026-05-20 02:08:03.924705
1327	1406	4586	3	Credito	0.01	Paga	Receita de venda - Pedido #1406	2026-05-20 02:08:03.924705
1328	1741	4753	3	Credito	11800.44	Paga	Receita de venda - Pedido #1741	2026-05-20 02:08:03.924705
1329	1849	4734	3	Credito	1001.02	Paga	Receita de venda - Pedido #1849	2026-05-20 02:08:03.924705
1330	233	4516	3	Credito	331.14	Paga	Receita de venda - Pedido #233	2026-05-20 02:08:03.924705
1331	1149	4441	3	Credito	1197.24	Paga	Receita de venda - Pedido #1149	2026-05-20 02:08:03.924705
1332	1370	4772	3	Credito	2513.60	Paga	Receita de venda - Pedido #1370	2026-05-20 02:08:03.924705
1333	1115	4672	3	Credito	5071.15	Paga	Receita de venda - Pedido #1115	2026-05-20 02:08:03.924705
1334	1993	4540	3	Credito	18.57	Paga	Receita de venda - Pedido #1993	2026-05-20 02:08:03.924705
1335	93	4653	3	Credito	93.45	Paga	Receita de venda - Pedido #93	2026-05-20 02:08:03.924705
1336	89	4607	3	Credito	10231.32	Paga	Receita de venda - Pedido #89	2026-05-20 02:08:03.924705
1337	1383	4577	3	Credito	102.04	Paga	Receita de venda - Pedido #1383	2026-05-20 02:08:03.924705
1338	1345	4456	3	Credito	27.06	Paga	Receita de venda - Pedido #1345	2026-05-20 02:08:03.924705
1339	723	4831	3	Credito	33.10	Paga	Receita de venda - Pedido #723	2026-05-20 02:08:03.924705
1340	497	4518	3	Credito	2724.67	Paga	Receita de venda - Pedido #497	2026-05-20 02:08:03.924705
1341	1513	4814	3	Credito	108.07	Paga	Receita de venda - Pedido #1513	2026-05-20 02:08:03.924705
1342	884	4819	3	Credito	1253.49	Paga	Receita de venda - Pedido #884	2026-05-20 02:08:03.924705
1343	155	4518	3	Credito	8376.89	Paga	Receita de venda - Pedido #155	2026-05-20 02:08:03.924705
1344	1871	4800	3	Credito	1053.78	Paga	Receita de venda - Pedido #1871	2026-05-20 02:08:03.924705
1345	953	4880	3	Credito	12.57	Paga	Receita de venda - Pedido #953	2026-05-20 02:08:03.924705
1346	609	4434	3	Credito	59.40	Paga	Receita de venda - Pedido #609	2026-05-20 02:08:03.924705
1347	416	4837	3	Credito	336.28	Paga	Receita de venda - Pedido #416	2026-05-20 02:08:03.924705
1348	1286	4681	3	Credito	4133.79	Paga	Receita de venda - Pedido #1286	2026-05-20 02:08:03.924705
1349	195	4459	3	Credito	4267.95	Paga	Receita de venda - Pedido #195	2026-05-20 02:08:03.924705
1350	1529	4796	3	Credito	1828.01	Paga	Receita de venda - Pedido #1529	2026-05-20 02:08:03.924705
1351	1153	4537	3	Credito	13210.51	Paga	Receita de venda - Pedido #1153	2026-05-20 02:08:03.924705
1352	1137	4686	3	Credito	1278.91	Paga	Receita de venda - Pedido #1137	2026-05-20 02:08:03.924705
1353	441	4853	3	Credito	2084.51	Paga	Receita de venda - Pedido #441	2026-05-20 02:08:03.924705
1354	1744	4824	3	Credito	0.01	Paga	Receita de venda - Pedido #1744	2026-05-20 02:08:03.924705
1355	1047	4539	3	Credito	219.40	Paga	Receita de venda - Pedido #1047	2026-05-20 02:08:03.924705
1356	892	4517	3	Credito	1153.47	Paga	Receita de venda - Pedido #892	2026-05-20 02:08:03.924705
1357	1083	4516	3	Credito	0.01	Paga	Receita de venda - Pedido #1083	2026-05-20 02:08:03.924705
1358	1949	4420	3	Credito	0.01	Paga	Receita de venda - Pedido #1949	2026-05-20 02:08:03.924705
1359	1675	4633	3	Credito	1871.94	Paga	Receita de venda - Pedido #1675	2026-05-20 02:08:03.924705
1360	503	4711	3	Credito	2499.33	Paga	Receita de venda - Pedido #503	2026-05-20 02:08:03.924705
1361	1154	4760	3	Credito	0.01	Paga	Receita de venda - Pedido #1154	2026-05-20 02:08:03.924705
1362	1888	4533	3	Credito	22.51	Paga	Receita de venda - Pedido #1888	2026-05-20 02:08:03.924705
1363	1356	4549	3	Credito	226.44	Paga	Receita de venda - Pedido #1356	2026-05-20 02:08:03.924705
1364	994	4551	3	Credito	483.64	Paga	Receita de venda - Pedido #994	2026-05-20 02:08:03.924705
1365	1099	4507	3	Credito	3202.30	Paga	Receita de venda - Pedido #1099	2026-05-20 02:08:03.924705
1366	865	4906	3	Credito	3247.68	Paga	Receita de venda - Pedido #865	2026-05-20 02:08:03.924705
1367	1893	4547	3	Credito	221.59	Paga	Receita de venda - Pedido #1893	2026-05-20 02:08:03.924705
1368	962	4394	3	Credito	0.01	Paga	Receita de venda - Pedido #962	2026-05-20 02:08:03.924705
1369	106	4697	3	Credito	138.37	Paga	Receita de venda - Pedido #106	2026-05-20 02:08:03.924705
1370	1200	4791	3	Credito	1419.46	Paga	Receita de venda - Pedido #1200	2026-05-20 02:08:03.924705
1371	1010	4491	3	Credito	169.02	Paga	Receita de venda - Pedido #1010	2026-05-20 02:08:03.924705
1372	178	4832	3	Credito	11833.56	Paga	Receita de venda - Pedido #178	2026-05-20 02:08:03.924705
1373	795	4740	3	Credito	544.52	Paga	Receita de venda - Pedido #795	2026-05-20 02:08:03.924705
1374	809	4827	3	Credito	173.48	Paga	Receita de venda - Pedido #809	2026-05-20 02:08:03.924705
1375	8	4863	3	Credito	3736.98	Paga	Receita de venda - Pedido #8	2026-05-20 02:08:03.924705
1376	934	4488	3	Credito	8965.79	Paga	Receita de venda - Pedido #934	2026-05-20 02:08:03.924705
1377	1690	4608	3	Credito	2903.94	Paga	Receita de venda - Pedido #1690	2026-05-20 02:08:03.924705
1378	908	4428	3	Credito	24748.56	Paga	Receita de venda - Pedido #908	2026-05-20 02:08:03.924705
1379	1556	4536	3	Credito	518.69	Paga	Receita de venda - Pedido #1556	2026-05-20 02:08:03.924705
1380	370	4830	3	Credito	1065.26	Paga	Receita de venda - Pedido #370	2026-05-20 02:08:03.924705
1381	684	4698	3	Credito	3503.38	Paga	Receita de venda - Pedido #684	2026-05-20 02:08:03.924705
1382	1135	4701	3	Credito	4760.53	Paga	Receita de venda - Pedido #1135	2026-05-20 02:08:03.924705
1383	1156	4416	3	Credito	68.09	Paga	Receita de venda - Pedido #1156	2026-05-20 02:08:03.924705
1384	1935	4684	3	Credito	3384.05	Paga	Receita de venda - Pedido #1935	2026-05-20 02:08:03.924705
1385	396	4899	3	Credito	47.50	Paga	Receita de venda - Pedido #396	2026-05-20 02:08:03.924705
1386	1395	4488	3	Credito	396.56	Paga	Receita de venda - Pedido #1395	2026-05-20 02:08:03.924705
1387	1472	4625	3	Credito	17336.43	Paga	Receita de venda - Pedido #1472	2026-05-20 02:08:03.924705
1388	514	4915	3	Credito	9876.33	Paga	Receita de venda - Pedido #514	2026-05-20 02:08:03.924705
1389	1234	4599	3	Credito	13318.89	Paga	Receita de venda - Pedido #1234	2026-05-20 02:08:03.924705
1390	854	4759	3	Credito	539.18	Paga	Receita de venda - Pedido #854	2026-05-20 02:08:03.924705
1391	389	4560	3	Credito	909.81	Paga	Receita de venda - Pedido #389	2026-05-20 02:08:03.924705
1392	1056	4564	3	Credito	7.92	Paga	Receita de venda - Pedido #1056	2026-05-20 02:08:03.924705
1393	916	4886	3	Credito	4427.17	Paga	Receita de venda - Pedido #916	2026-05-20 02:08:03.924705
1394	1471	4814	3	Credito	1119.96	Paga	Receita de venda - Pedido #1471	2026-05-20 02:08:03.924705
1395	114	4854	3	Credito	3995.68	Paga	Receita de venda - Pedido #114	2026-05-20 02:08:03.924705
1396	60	4458	3	Credito	717.13	Paga	Receita de venda - Pedido #60	2026-05-20 02:08:03.924705
1397	754	4785	3	Credito	212.67	Paga	Receita de venda - Pedido #754	2026-05-20 02:08:03.924705
1398	518	4427	3	Credito	0.01	Paga	Receita de venda - Pedido #518	2026-05-20 02:08:03.924705
1399	1299	4456	3	Credito	0.01	Paga	Receita de venda - Pedido #1299	2026-05-20 02:08:03.924705
1400	98	4518	3	Credito	1127.10	Paga	Receita de venda - Pedido #98	2026-05-20 02:08:03.924705
1401	1488	4735	3	Credito	18669.99	Paga	Receita de venda - Pedido #1488	2026-05-20 02:08:03.924705
1402	715	4517	3	Credito	273.48	Paga	Receita de venda - Pedido #715	2026-05-20 02:08:03.924705
1403	235	4582	3	Credito	5225.85	Paga	Receita de venda - Pedido #235	2026-05-20 02:08:03.924705
1404	1132	4391	3	Credito	699.08	Paga	Receita de venda - Pedido #1132	2026-05-20 02:08:03.924705
1405	763	4513	3	Credito	1851.11	Paga	Receita de venda - Pedido #763	2026-05-20 02:08:03.924705
1406	306	4462	3	Credito	742.40	Paga	Receita de venda - Pedido #306	2026-05-20 02:08:03.924705
1407	1809	4646	3	Credito	0.01	Paga	Receita de venda - Pedido #1809	2026-05-20 02:08:03.924705
1408	338	4699	3	Credito	901.93	Paga	Receita de venda - Pedido #338	2026-05-20 02:08:03.924705
1409	1066	4558	3	Credito	896.80	Paga	Receita de venda - Pedido #1066	2026-05-20 02:08:03.924705
1410	358	4558	3	Credito	501.02	Paga	Receita de venda - Pedido #358	2026-05-20 02:08:03.924705
1411	412	4773	3	Credito	0.01	Paga	Receita de venda - Pedido #412	2026-05-20 02:08:03.924705
1412	26	4389	3	Credito	1469.18	Paga	Receita de venda - Pedido #26	2026-05-20 02:08:03.924705
1413	950	4672	3	Credito	5843.63	Paga	Receita de venda - Pedido #950	2026-05-20 02:08:03.924705
1414	564	4913	3	Credito	399.70	Paga	Receita de venda - Pedido #564	2026-05-20 02:08:03.924705
1415	72	4568	3	Credito	0.01	Paga	Receita de venda - Pedido #72	2026-05-20 02:08:03.924705
1416	1168	4915	3	Credito	5808.62	Paga	Receita de venda - Pedido #1168	2026-05-20 02:08:03.924705
1417	1960	4750	3	Credito	16919.57	Paga	Receita de venda - Pedido #1960	2026-05-20 02:08:03.924705
1418	1527	4456	3	Credito	1519.07	Paga	Receita de venda - Pedido #1527	2026-05-20 02:08:03.924705
1419	1260	4897	3	Credito	889.89	Paga	Receita de venda - Pedido #1260	2026-05-20 02:08:03.924705
1420	232	4762	3	Credito	2104.19	Paga	Receita de venda - Pedido #232	2026-05-20 02:08:03.924705
1421	77	4531	3	Credito	24.14	Paga	Receita de venda - Pedido #77	2026-05-20 02:08:03.924705
1422	1916	4408	3	Credito	0.01	Paga	Receita de venda - Pedido #1916	2026-05-20 02:08:03.924705
1423	131	4595	3	Credito	0.01	Paga	Receita de venda - Pedido #131	2026-05-20 02:08:03.924705
1424	310	4854	3	Credito	305.92	Paga	Receita de venda - Pedido #310	2026-05-20 02:08:03.924705
1425	37	4421	3	Credito	42.29	Paga	Receita de venda - Pedido #37	2026-05-20 02:08:03.924705
1426	1962	4441	3	Credito	2106.38	Paga	Receita de venda - Pedido #1962	2026-05-20 02:08:03.924705
1427	1624	4724	3	Credito	2105.61	Paga	Receita de venda - Pedido #1624	2026-05-20 02:08:03.924705
1428	584	4840	3	Credito	0.01	Paga	Receita de venda - Pedido #584	2026-05-20 02:08:03.924705
1429	1821	4903	3	Credito	325.63	Paga	Receita de venda - Pedido #1821	2026-05-20 02:08:03.924705
1430	1609	4646	3	Credito	0.01	Paga	Receita de venda - Pedido #1609	2026-05-20 02:08:03.924705
1431	806	4848	3	Credito	3419.84	Paga	Receita de venda - Pedido #806	2026-05-20 02:08:03.924705
1432	353	4586	3	Credito	1797.88	Paga	Receita de venda - Pedido #353	2026-05-20 02:08:03.924705
1433	939	4466	3	Credito	324.59	Paga	Receita de venda - Pedido #939	2026-05-20 02:08:03.924705
1434	834	4534	3	Credito	0.01	Paga	Receita de venda - Pedido #834	2026-05-20 02:08:03.924705
1435	831	4626	3	Credito	3708.82	Paga	Receita de venda - Pedido #831	2026-05-20 02:08:03.924705
1436	813	4725	3	Credito	4256.71	Paga	Receita de venda - Pedido #813	2026-05-20 02:08:03.924705
1437	1164	4747	3	Credito	832.96	Paga	Receita de venda - Pedido #1164	2026-05-20 02:08:03.924705
1438	1298	4481	3	Credito	3417.89	Paga	Receita de venda - Pedido #1298	2026-05-20 02:08:03.924705
1439	574	4681	3	Credito	3187.16	Paga	Receita de venda - Pedido #574	2026-05-20 02:08:03.924705
1440	1443	4863	3	Credito	0.01	Paga	Receita de venda - Pedido #1443	2026-05-20 02:08:03.924705
1441	225	4906	3	Credito	2303.07	Paga	Receita de venda - Pedido #225	2026-05-20 02:08:03.924705
1442	1344	4743	3	Credito	2594.76	Paga	Receita de venda - Pedido #1344	2026-05-20 02:08:03.924705
1443	333	4892	3	Credito	832.55	Paga	Receita de venda - Pedido #333	2026-05-20 02:08:03.924705
1444	1496	4820	3	Credito	3367.23	Paga	Receita de venda - Pedido #1496	2026-05-20 02:08:03.924705
1445	1446	4507	3	Credito	2973.15	Paga	Receita de venda - Pedido #1446	2026-05-20 02:08:03.924705
1446	174	4635	3	Credito	502.00	Paga	Receita de venda - Pedido #174	2026-05-20 02:08:03.924705
1447	45	4914	3	Credito	3035.39	Paga	Receita de venda - Pedido #45	2026-05-20 02:08:03.924705
1448	1375	4606	3	Credito	25.39	Paga	Receita de venda - Pedido #1375	2026-05-20 02:08:03.924705
1449	891	4531	3	Credito	2372.13	Paga	Receita de venda - Pedido #891	2026-05-20 02:08:03.924705
1450	134	4437	3	Credito	13650.26	Paga	Receita de venda - Pedido #134	2026-05-20 02:08:03.924705
1451	1430	4812	3	Credito	120.60	Paga	Receita de venda - Pedido #1430	2026-05-20 02:08:03.924705
1452	1419	4798	3	Credito	1774.74	Paga	Receita de venda - Pedido #1419	2026-05-20 02:08:03.924705
1453	1241	4412	3	Credito	136.49	Paga	Receita de venda - Pedido #1241	2026-05-20 02:08:03.924705
1454	1790	4811	3	Credito	392.35	Paga	Receita de venda - Pedido #1790	2026-05-20 02:08:03.924705
1455	1577	4913	3	Credito	2528.40	Paga	Receita de venda - Pedido #1577	2026-05-20 02:08:03.924705
1456	975	4584	3	Credito	760.61	Paga	Receita de venda - Pedido #975	2026-05-20 02:08:03.924705
1457	36	4558	3	Credito	146.66	Paga	Receita de venda - Pedido #36	2026-05-20 02:08:03.924705
1458	1802	4512	3	Credito	3793.71	Paga	Receita de venda - Pedido #1802	2026-05-20 02:08:03.924705
1459	102	4711	3	Credito	2680.12	Paga	Receita de venda - Pedido #102	2026-05-20 02:08:03.924705
1460	1292	4684	3	Credito	44.87	Paga	Receita de venda - Pedido #1292	2026-05-20 02:08:03.924705
1461	533	4730	3	Credito	0.01	Paga	Receita de venda - Pedido #533	2026-05-20 02:08:03.924705
1462	915	4535	3	Credito	105.61	Paga	Receita de venda - Pedido #915	2026-05-20 02:08:03.924705
1463	1677	4738	3	Credito	13.88	Paga	Receita de venda - Pedido #1677	2026-05-20 02:08:03.924705
1464	207	4748	3	Credito	4872.96	Paga	Receita de venda - Pedido #207	2026-05-20 02:08:03.924705
1465	979	4632	3	Credito	621.90	Paga	Receita de venda - Pedido #979	2026-05-20 02:08:03.924705
1466	1901	4490	3	Credito	0.01	Paga	Receita de venda - Pedido #1901	2026-05-20 02:08:03.924705
1467	1884	4831	3	Credito	96.36	Paga	Receita de venda - Pedido #1884	2026-05-20 02:08:03.924705
1468	871	4455	3	Credito	2087.47	Paga	Receita de venda - Pedido #871	2026-05-20 02:08:03.924705
1469	1410	4867	3	Credito	2950.67	Paga	Receita de venda - Pedido #1410	2026-05-20 02:08:03.924705
1470	1758	4785	3	Credito	34.91	Paga	Receita de venda - Pedido #1758	2026-05-20 02:08:03.924705
1471	1996	4466	3	Credito	150.55	Paga	Receita de venda - Pedido #1996	2026-05-20 02:08:03.924705
1472	1442	4483	3	Credito	197.48	Paga	Receita de venda - Pedido #1442	2026-05-20 02:08:03.924705
1473	365	4437	3	Credito	42.78	Paga	Receita de venda - Pedido #365	2026-05-20 02:08:03.924705
1474	704	4554	3	Credito	3495.90	Paga	Receita de venda - Pedido #704	2026-05-20 02:08:03.924705
1475	157	4716	3	Credito	445.40	Paga	Receita de venda - Pedido #157	2026-05-20 02:08:03.924705
1476	1559	4480	3	Credito	8320.23	Paga	Receita de venda - Pedido #1559	2026-05-20 02:08:03.924705
1477	1909	4629	3	Credito	1730.47	Paga	Receita de venda - Pedido #1909	2026-05-20 02:08:03.924705
1478	618	4626	3	Credito	30.19	Paga	Receita de venda - Pedido #618	2026-05-20 02:08:03.924705
1479	1851	4742	3	Credito	7387.58	Paga	Receita de venda - Pedido #1851	2026-05-20 02:08:03.924705
1480	313	4738	3	Credito	14932.78	Paga	Receita de venda - Pedido #313	2026-05-20 02:08:03.924705
1481	1080	4445	3	Credito	2301.89	Paga	Receita de venda - Pedido #1080	2026-05-20 02:08:03.924705
1482	140	4553	3	Credito	0.01	Paga	Receita de venda - Pedido #140	2026-05-20 02:08:03.924705
1483	137	4384	3	Credito	6942.24	Paga	Receita de venda - Pedido #137	2026-05-20 02:08:03.924705
1484	392	4855	3	Credito	6775.05	Paga	Receita de venda - Pedido #392	2026-05-20 02:08:03.924705
1485	191	4802	3	Credito	10066.94	Paga	Receita de venda - Pedido #191	2026-05-20 02:08:03.924705
1486	1972	4545	3	Credito	1643.40	Paga	Receita de venda - Pedido #1972	2026-05-20 02:08:03.924705
1487	760	4593	3	Credito	0.01	Paga	Receita de venda - Pedido #760	2026-05-20 02:08:03.924705
1488	1539	4442	3	Credito	18829.75	Paga	Receita de venda - Pedido #1539	2026-05-20 02:08:03.924705
1489	218	4608	3	Credito	420.91	Paga	Receita de venda - Pedido #218	2026-05-20 02:08:03.924705
1490	1515	4696	3	Credito	90.21	Paga	Receita de venda - Pedido #1515	2026-05-20 02:08:03.924705
1491	1500	4384	3	Credito	2093.06	Paga	Receita de venda - Pedido #1500	2026-05-20 02:08:03.924705
1492	1736	4641	3	Credito	9886.01	Paga	Receita de venda - Pedido #1736	2026-05-20 02:08:03.924705
1493	671	4813	3	Credito	2440.38	Paga	Receita de venda - Pedido #671	2026-05-20 02:08:03.924705
1494	580	4823	3	Credito	0.01	Paga	Receita de venda - Pedido #580	2026-05-20 02:08:03.924705
1495	1131	4643	3	Credito	2321.58	Paga	Receita de venda - Pedido #1131	2026-05-20 02:08:03.924705
1496	1625	4722	3	Credito	878.78	Paga	Receita de venda - Pedido #1625	2026-05-20 02:08:03.924705
1497	742	4757	3	Credito	0.01	Paga	Receita de venda - Pedido #742	2026-05-20 02:08:03.924705
1498	912	4507	3	Credito	109.50	Paga	Receita de venda - Pedido #912	2026-05-20 02:08:03.924705
1499	1478	4427	3	Credito	3064.46	Paga	Receita de venda - Pedido #1478	2026-05-20 02:08:03.924705
1500	1964	4625	3	Credito	4867.48	Paga	Receita de venda - Pedido #1964	2026-05-20 02:08:03.924705
1501	938	4778	3	Credito	433.10	Paga	Receita de venda - Pedido #938	2026-05-20 02:08:03.924705
1502	1158	4385	3	Credito	488.33	Paga	Receita de venda - Pedido #1158	2026-05-20 02:08:03.924705
1503	1037	4660	3	Credito	18.42	Paga	Receita de venda - Pedido #1037	2026-05-20 02:08:03.924705
1504	184	4546	3	Credito	2438.75	Paga	Receita de venda - Pedido #184	2026-05-20 02:08:03.924705
1505	87	4859	3	Credito	705.07	Paga	Receita de venda - Pedido #87	2026-05-20 02:08:03.924705
1506	753	4553	3	Credito	6566.29	Paga	Receita de venda - Pedido #753	2026-05-20 02:08:03.924705
1507	1300	4878	3	Credito	2444.11	Paga	Receita de venda - Pedido #1300	2026-05-20 02:08:03.924705
1508	550	4743	3	Credito	1563.02	Paga	Receita de venda - Pedido #550	2026-05-20 02:08:03.924705
1509	394	4624	3	Credito	10937.87	Paga	Receita de venda - Pedido #394	2026-05-20 02:08:03.924705
1510	272	4676	3	Credito	1980.47	Paga	Receita de venda - Pedido #272	2026-05-20 02:08:03.924705
1511	1437	4829	3	Credito	14918.15	Paga	Receita de venda - Pedido #1437	2026-05-20 02:08:03.924705
1512	867	4811	3	Credito	1204.44	Paga	Receita de venda - Pedido #867	2026-05-20 02:08:03.924705
1513	190	4569	3	Credito	125.39	Paga	Receita de venda - Pedido #190	2026-05-20 02:08:03.924705
1514	554	4874	3	Credito	1035.50	Paga	Receita de venda - Pedido #554	2026-05-20 02:08:03.924705
1515	424	4698	3	Credito	603.95	Paga	Receita de venda - Pedido #424	2026-05-20 02:08:03.924705
1516	670	4892	3	Credito	4197.98	Paga	Receita de venda - Pedido #670	2026-05-20 02:08:03.924705
1517	1933	4514	3	Credito	0.01	Paga	Receita de venda - Pedido #1933	2026-05-20 02:08:03.924705
1518	309	4459	3	Credito	38.52	Paga	Receita de venda - Pedido #309	2026-05-20 02:08:03.924705
1519	1612	4541	3	Credito	10342.30	Paga	Receita de venda - Pedido #1612	2026-05-20 02:08:03.924705
1520	1854	4489	3	Credito	32.07	Paga	Receita de venda - Pedido #1854	2026-05-20 02:08:03.924705
1521	509	4546	3	Credito	3846.08	Paga	Receita de venda - Pedido #509	2026-05-20 02:08:03.924705
1522	1366	4711	3	Credito	1218.87	Paga	Receita de venda - Pedido #1366	2026-05-20 02:08:03.924705
1523	1067	4474	3	Credito	11897.50	Paga	Receita de venda - Pedido #1067	2026-05-20 02:08:03.924705
1524	156	4418	3	Credito	3412.42	Paga	Receita de venda - Pedido #156	2026-05-20 02:08:03.924705
1525	1599	4559	3	Credito	502.90	Paga	Receita de venda - Pedido #1599	2026-05-20 02:08:03.924705
1526	1408	4682	3	Credito	792.19	Paga	Receita de venda - Pedido #1408	2026-05-20 02:08:03.924705
1527	641	4849	3	Credito	80.84	Paga	Receita de venda - Pedido #641	2026-05-20 02:08:03.924705
1528	475	4404	3	Credito	349.59	Paga	Receita de venda - Pedido #475	2026-05-20 02:08:03.924705
1529	1475	4654	3	Credito	163.39	Paga	Receita de venda - Pedido #1475	2026-05-20 02:08:03.924705
1530	888	4480	3	Credito	0.01	Paga	Receita de venda - Pedido #888	2026-05-20 02:08:03.924705
1531	1235	4768	3	Credito	539.37	Paga	Receita de venda - Pedido #1235	2026-05-20 02:08:03.924705
1532	282	4668	3	Credito	250.73	Paga	Receita de venda - Pedido #282	2026-05-20 02:08:03.924705
1533	1604	4462	3	Credito	1029.32	Paga	Receita de venda - Pedido #1604	2026-05-20 02:08:03.924705
1534	502	4560	3	Credito	223.52	Paga	Receita de venda - Pedido #502	2026-05-20 02:08:03.924705
1535	1872	4857	3	Credito	66.18	Paga	Receita de venda - Pedido #1872	2026-05-20 02:08:03.924705
1536	117	4479	3	Credito	2478.75	Paga	Receita de venda - Pedido #117	2026-05-20 02:08:03.924705
1537	257	4545	3	Credito	0.01	Paga	Receita de venda - Pedido #257	2026-05-20 02:08:03.924705
1538	40	4564	3	Credito	10139.58	Paga	Receita de venda - Pedido #40	2026-05-20 02:08:03.924705
1539	1122	4451	3	Credito	86.14	Paga	Receita de venda - Pedido #1122	2026-05-20 02:08:03.924705
1540	1485	4851	3	Credito	0.01	Paga	Receita de venda - Pedido #1485	2026-05-20 02:08:03.924705
1541	1258	4854	3	Credito	458.25	Paga	Receita de venda - Pedido #1258	2026-05-20 02:08:03.924705
1542	1166	4554	3	Credito	387.20	Paga	Receita de venda - Pedido #1166	2026-05-20 02:08:03.924705
1543	1637	4639	3	Credito	5624.36	Paga	Receita de venda - Pedido #1637	2026-05-20 02:08:03.924705
1544	1519	4647	3	Credito	4869.32	Paga	Receita de venda - Pedido #1519	2026-05-20 02:08:03.924705
1545	914	4564	3	Credito	2176.15	Paga	Receita de venda - Pedido #914	2026-05-20 02:08:03.924705
1546	728	4413	3	Credito	1595.18	Paga	Receita de venda - Pedido #728	2026-05-20 02:08:03.924705
1547	1150	4880	3	Credito	8444.94	Paga	Receita de venda - Pedido #1150	2026-05-20 02:08:03.924705
1548	1119	4476	3	Credito	6643.81	Paga	Receita de venda - Pedido #1119	2026-05-20 02:08:03.924705
1549	506	4708	3	Credito	24684.29	Paga	Receita de venda - Pedido #506	2026-05-20 02:08:03.924705
1550	1501	4507	3	Credito	401.83	Paga	Receita de venda - Pedido #1501	2026-05-20 02:08:03.924705
1551	331	4716	3	Credito	632.25	Paga	Receita de venda - Pedido #331	2026-05-20 02:08:03.924705
1552	1578	4784	3	Credito	0.01	Paga	Receita de venda - Pedido #1578	2026-05-20 02:08:03.924705
1553	913	4679	3	Credito	11911.68	Paga	Receita de venda - Pedido #913	2026-05-20 02:08:03.924705
1554	599	4450	3	Credito	236.02	Paga	Receita de venda - Pedido #599	2026-05-20 02:08:03.924705
1555	1468	4641	3	Credito	2796.83	Paga	Receita de venda - Pedido #1468	2026-05-20 02:08:03.924705
1556	1464	4880	3	Credito	0.01	Paga	Receita de venda - Pedido #1464	2026-05-20 02:08:03.924705
1557	1486	4915	3	Credito	8.00	Paga	Receita de venda - Pedido #1486	2026-05-20 02:08:03.924705
1558	1461	4427	3	Credito	2910.32	Paga	Receita de venda - Pedido #1461	2026-05-20 02:08:03.924705
1559	1525	4522	3	Credito	4812.94	Paga	Receita de venda - Pedido #1525	2026-05-20 02:08:03.924705
1560	698	4672	3	Credito	173.05	Paga	Receita de venda - Pedido #698	2026-05-20 02:08:03.924705
1561	466	4457	3	Credito	2260.73	Paga	Receita de venda - Pedido #466	2026-05-20 02:08:03.924705
1562	201	4750	3	Credito	1598.79	Paga	Receita de venda - Pedido #201	2026-05-20 02:08:03.924705
1563	1617	4699	3	Credito	0.01	Paga	Receita de venda - Pedido #1617	2026-05-20 02:08:03.924705
1564	1201	4540	3	Credito	895.19	Paga	Receita de venda - Pedido #1201	2026-05-20 02:08:03.924705
1565	1778	4725	3	Credito	8318.35	Paga	Receita de venda - Pedido #1778	2026-05-20 02:08:03.924705
1566	1314	4391	3	Credito	14961.98	Paga	Receita de venda - Pedido #1314	2026-05-20 02:08:03.924705
1567	1196	4761	3	Credito	0.01	Paga	Receita de venda - Pedido #1196	2026-05-20 02:08:03.924705
1568	446	4723	3	Credito	162.08	Paga	Receita de venda - Pedido #446	2026-05-20 02:08:03.924705
1569	749	4553	3	Credito	2715.46	Paga	Receita de venda - Pedido #749	2026-05-20 02:08:03.924705
1570	86	4645	3	Credito	14650.69	Paga	Receita de venda - Pedido #86	2026-05-20 02:08:03.924705
1571	920	4627	3	Credito	3825.98	Paga	Receita de venda - Pedido #920	2026-05-20 02:08:03.924705
1572	1843	4830	3	Credito	443.61	Paga	Receita de venda - Pedido #1843	2026-05-20 02:08:03.924705
1573	1058	4586	3	Credito	4296.94	Paga	Receita de venda - Pedido #1058	2026-05-20 02:08:03.924705
1574	219	4422	3	Credito	3368.14	Paga	Receita de venda - Pedido #219	2026-05-20 02:08:03.924705
1575	231	4856	3	Credito	0.01	Paga	Receita de venda - Pedido #231	2026-05-20 02:08:03.924705
1576	1213	4687	3	Credito	2740.72	Paga	Receita de venda - Pedido #1213	2026-05-20 02:08:03.924705
1577	873	4709	3	Credito	233.31	Paga	Receita de venda - Pedido #873	2026-05-20 02:08:03.924705
1578	1803	4751	3	Credito	57.43	Paga	Receita de venda - Pedido #1803	2026-05-20 02:08:03.924705
1579	1505	4672	3	Credito	2219.34	Paga	Receita de venda - Pedido #1505	2026-05-20 02:08:03.924705
1580	1311	4614	3	Credito	4122.89	Paga	Receita de venda - Pedido #1311	2026-05-20 02:08:03.924705
1581	414	4549	3	Credito	100.76	Paga	Receita de venda - Pedido #414	2026-05-20 02:08:03.924705
1582	640	4606	3	Credito	1307.36	Paga	Receita de venda - Pedido #640	2026-05-20 02:08:03.924705
1583	1053	4743	3	Credito	3861.31	Paga	Receita de venda - Pedido #1053	2026-05-20 02:08:03.924705
1584	1452	4504	3	Credito	75.35	Paga	Receita de venda - Pedido #1452	2026-05-20 02:08:03.924705
1585	735	4607	3	Credito	371.47	Paga	Receita de venda - Pedido #735	2026-05-20 02:08:03.924705
1586	1813	4494	3	Credito	739.85	Paga	Receita de venda - Pedido #1813	2026-05-20 02:08:03.924705
1587	166	4554	3	Credito	384.12	Paga	Receita de venda - Pedido #166	2026-05-20 02:08:03.924705
1588	1846	4791	3	Credito	1506.34	Paga	Receita de venda - Pedido #1846	2026-05-20 02:08:03.924705
1589	1648	4662	3	Credito	34.16	Paga	Receita de venda - Pedido #1648	2026-05-20 02:08:03.924705
1590	410	4396	3	Credito	24620.22	Paga	Receita de venda - Pedido #410	2026-05-20 02:08:03.924705
1591	1381	4781	3	Credito	3991.24	Paga	Receita de venda - Pedido #1381	2026-05-20 02:08:03.924705
1592	381	4433	3	Credito	3030.96	Paga	Receita de venda - Pedido #381	2026-05-20 02:08:03.924705
1593	597	4405	3	Credito	434.89	Paga	Receita de venda - Pedido #597	2026-05-20 02:08:03.924705
1594	1291	4474	3	Credito	0.01	Paga	Receita de venda - Pedido #1291	2026-05-20 02:08:03.924705
1595	193	4507	3	Credito	3247.57	Paga	Receita de venda - Pedido #193	2026-05-20 02:08:03.924705
1596	1435	4466	3	Credito	538.12	Paga	Receita de venda - Pedido #1435	2026-05-20 02:08:03.924705
1597	1012	4680	3	Credito	308.30	Paga	Receita de venda - Pedido #1012	2026-05-20 02:08:03.924705
1598	730	4867	3	Credito	0.01	Paga	Receita de venda - Pedido #730	2026-05-20 02:08:03.924705
1599	548	4775	3	Credito	2128.29	Paga	Receita de venda - Pedido #548	2026-05-20 02:08:03.924705
1600	1087	4843	3	Credito	1604.24	Paga	Receita de venda - Pedido #1087	2026-05-20 02:08:03.924705
1601	1769	4743	3	Credito	150.98	Paga	Receita de venda - Pedido #1769	2026-05-20 02:08:03.924705
1602	1457	4532	3	Credito	0.01	Paga	Receita de venda - Pedido #1457	2026-05-20 02:08:03.924705
1603	1902	4580	3	Credito	2301.00	Paga	Receita de venda - Pedido #1902	2026-05-20 02:08:03.924705
1604	1635	4612	3	Credito	4002.03	Paga	Receita de venda - Pedido #1635	2026-05-20 02:08:03.924705
1605	709	4824	3	Credito	8471.23	Paga	Receita de venda - Pedido #709	2026-05-20 02:08:03.924705
1606	47	4722	3	Credito	1464.40	Paga	Receita de venda - Pedido #47	2026-05-20 02:08:03.924705
1607	1105	4553	3	Credito	0.01	Paga	Receita de venda - Pedido #1105	2026-05-20 02:08:03.924705
1608	886	4459	3	Credito	75.22	Paga	Receita de venda - Pedido #886	2026-05-20 02:08:03.924705
1609	177	4891	3	Credito	275.18	Paga	Receita de venda - Pedido #177	2026-05-20 02:08:03.924705
1610	727	4639	3	Credito	2626.41	Paga	Receita de venda - Pedido #727	2026-05-20 02:08:03.924705
1611	1405	4883	3	Credito	0.01	Paga	Receita de venda - Pedido #1405	2026-05-20 02:08:03.924705
1612	810	4608	3	Credito	7.72	Paga	Receita de venda - Pedido #810	2026-05-20 02:08:03.924705
1613	1231	4527	3	Credito	57.88	Paga	Receita de venda - Pedido #1231	2026-05-20 02:08:03.924705
1614	1276	4730	3	Credito	178.34	Paga	Receita de venda - Pedido #1276	2026-05-20 02:08:03.924705
1615	1117	4495	3	Credito	2922.43	Paga	Receita de venda - Pedido #1117	2026-05-20 02:08:03.924705
1616	110	4875	3	Credito	796.60	Paga	Receita de venda - Pedido #110	2026-05-20 02:08:03.924705
1617	1710	4888	3	Credito	1954.10	Paga	Receita de venda - Pedido #1710	2026-05-20 02:08:03.924705
1618	145	4679	3	Credito	312.17	Paga	Receita de venda - Pedido #145	2026-05-20 02:08:03.924705
1619	557	4451	3	Credito	82.69	Paga	Receita de venda - Pedido #557	2026-05-20 02:08:03.924705
1620	485	4545	3	Credito	12231.18	Paga	Receita de venda - Pedido #485	2026-05-20 02:08:03.924705
1621	1439	4694	3	Credito	2356.56	Paga	Receita de venda - Pedido #1439	2026-05-20 02:08:03.924705
1622	1388	4680	3	Credito	1451.03	Paga	Receita de venda - Pedido #1388	2026-05-20 02:08:03.924705
1623	1081	4668	3	Credito	4683.28	Paga	Receita de venda - Pedido #1081	2026-05-20 02:08:03.924705
1624	1315	4605	3	Credito	1213.20	Paga	Receita de venda - Pedido #1315	2026-05-20 02:08:03.924705
1625	1102	4829	3	Credito	11734.07	Paga	Receita de venda - Pedido #1102	2026-05-20 02:08:03.924705
1626	1453	4590	3	Credito	512.98	Paga	Receita de venda - Pedido #1453	2026-05-20 02:08:03.924705
1627	1198	4721	3	Credito	2748.17	Paga	Receita de venda - Pedido #1198	2026-05-20 02:08:03.924705
1628	341	4809	3	Credito	2740.21	Paga	Receita de venda - Pedido #341	2026-05-20 02:08:03.924705
1629	1506	4636	3	Credito	47.14	Paga	Receita de venda - Pedido #1506	2026-05-20 02:08:03.924705
1630	1195	4513	3	Credito	533.93	Paga	Receita de venda - Pedido #1195	2026-05-20 02:08:03.924705
1631	170	4514	3	Credito	1454.38	Paga	Receita de venda - Pedido #170	2026-05-20 02:08:03.924705
1632	712	4546	3	Credito	2725.17	Paga	Receita de venda - Pedido #712	2026-05-20 02:08:03.924705
1633	192	4609	3	Credito	2625.14	Paga	Receita de venda - Pedido #192	2026-05-20 02:08:03.924705
1634	1696	4611	3	Credito	413.27	Paga	Receita de venda - Pedido #1696	2026-05-20 02:08:03.924705
1635	1174	4578	3	Credito	824.72	Paga	Receita de venda - Pedido #1174	2026-05-20 02:08:03.924705
1636	1740	4645	3	Credito	239.33	Paga	Receita de venda - Pedido #1740	2026-05-20 02:08:03.924705
1637	513	4875	3	Credito	74.36	Paga	Receita de venda - Pedido #513	2026-05-20 02:08:03.924705
1638	101	4694	3	Credito	0.01	Paga	Receita de venda - Pedido #101	2026-05-20 02:08:03.924705
1639	473	4411	3	Credito	27.85	Paga	Receita de venda - Pedido #473	2026-05-20 02:08:03.924705
1640	1824	4550	3	Credito	6003.10	Paga	Receita de venda - Pedido #1824	2026-05-20 02:08:03.924705
1641	1575	4587	3	Credito	1979.11	Paga	Receita de venda - Pedido #1575	2026-05-20 02:08:03.924705
1642	415	4738	3	Credito	0.01	Paga	Receita de venda - Pedido #415	2026-05-20 02:08:03.924705
1643	1835	4466	3	Credito	1772.87	Paga	Receita de venda - Pedido #1835	2026-05-20 02:08:03.924705
1644	1376	4859	3	Credito	117.89	Paga	Receita de venda - Pedido #1376	2026-05-20 02:08:03.924705
1645	1365	4552	3	Credito	0.01	Paga	Receita de venda - Pedido #1365	2026-05-20 02:08:03.924705
1646	1897	4686	3	Credito	0.01	Paga	Receita de venda - Pedido #1897	2026-05-20 02:08:03.924705
1647	689	4638	3	Credito	3995.22	Paga	Receita de venda - Pedido #689	2026-05-20 02:08:03.924705
1648	522	4420	3	Credito	1948.76	Paga	Receita de venda - Pedido #522	2026-05-20 02:08:03.924705
1649	1806	4593	3	Credito	0.01	Paga	Receita de venda - Pedido #1806	2026-05-20 02:08:03.924705
1650	674	4682	3	Credito	0.01	Paga	Receita de venda - Pedido #674	2026-05-20 02:08:03.924705
1651	630	4394	3	Credito	1560.39	Paga	Receita de venda - Pedido #630	2026-05-20 02:08:03.924705
1652	1723	4671	3	Credito	788.24	Paga	Receita de venda - Pedido #1723	2026-05-20 02:08:03.924705
1653	1704	4680	3	Credito	1696.10	Paga	Receita de venda - Pedido #1704	2026-05-20 02:08:03.924705
1654	575	4878	3	Credito	254.76	Paga	Receita de venda - Pedido #575	2026-05-20 02:08:03.924705
1655	1492	4877	3	Credito	559.53	Paga	Receita de venda - Pedido #1492	2026-05-20 02:08:03.924705
1656	401	4398	3	Credito	2141.36	Paga	Receita de venda - Pedido #401	2026-05-20 02:08:03.924705
1657	1701	4684	3	Credito	322.54	Paga	Receita de venda - Pedido #1701	2026-05-20 02:08:03.924705
1658	1456	4751	3	Credito	667.08	Paga	Receita de venda - Pedido #1456	2026-05-20 02:08:03.924705
1659	1483	4631	3	Credito	320.71	Paga	Receita de venda - Pedido #1483	2026-05-20 02:08:03.924705
1660	739	4813	3	Credito	1280.44	Paga	Receita de venda - Pedido #739	2026-05-20 02:08:03.924705
1661	1094	4618	3	Credito	24.69	Paga	Receita de venda - Pedido #1094	2026-05-20 02:08:03.924705
1662	1948	4761	3	Credito	0.01	Paga	Receita de venda - Pedido #1948	2026-05-20 02:08:03.924705
1663	1110	4428	3	Credito	1528.44	Paga	Receita de venda - Pedido #1110	2026-05-20 02:08:03.924705
1664	1743	4510	3	Credito	8408.92	Paga	Receita de venda - Pedido #1743	2026-05-20 02:08:03.924705
1665	741	4858	3	Credito	0.01	Paga	Receita de venda - Pedido #741	2026-05-20 02:08:03.924705
1666	716	4856	3	Credito	661.97	Paga	Receita de venda - Pedido #716	2026-05-20 02:08:03.924705
1667	897	4509	3	Credito	433.11	Paga	Receita de venda - Pedido #897	2026-05-20 02:08:03.924705
1668	543	4425	3	Credito	3090.49	Paga	Receita de venda - Pedido #543	2026-05-20 02:08:03.924705
1669	1562	4428	3	Credito	101.40	Paga	Receita de venda - Pedido #1562	2026-05-20 02:08:03.924705
1670	1473	4774	3	Credito	231.09	Paga	Receita de venda - Pedido #1473	2026-05-20 02:08:03.924705
1671	1130	4504	3	Credito	2745.39	Paga	Receita de venda - Pedido #1130	2026-05-20 02:08:03.924705
1672	85	4511	3	Credito	0.01	Paga	Receita de venda - Pedido #85	2026-05-20 02:08:03.924705
1673	1440	4436	3	Credito	0.01	Paga	Receita de venda - Pedido #1440	2026-05-20 02:08:03.924705
1674	281	4585	3	Credito	13520.12	Paga	Receita de venda - Pedido #281	2026-05-20 02:08:03.924705
1675	687	4590	3	Credito	4834.96	Paga	Receita de venda - Pedido #687	2026-05-20 02:08:03.924705
1676	288	4818	3	Credito	2800.46	Paga	Receita de venda - Pedido #288	2026-05-20 02:08:03.924705
1677	21	4648	3	Credito	304.58	Paga	Receita de venda - Pedido #21	2026-05-20 02:08:03.924705
1678	1814	4722	3	Credito	5579.47	Paga	Receita de venda - Pedido #1814	2026-05-20 02:08:03.924705
1679	622	4442	3	Credito	2146.63	Paga	Receita de venda - Pedido #622	2026-05-20 02:08:03.924705
1680	1765	4639	3	Credito	995.66	Paga	Receita de venda - Pedido #1765	2026-05-20 02:08:03.924705
1681	1027	4512	3	Credito	3124.76	Paga	Receita de venda - Pedido #1027	2026-05-20 02:08:03.924705
1682	1479	4785	3	Credito	2116.14	Paga	Receita de venda - Pedido #1479	2026-05-20 02:08:03.924705
1683	1593	4776	3	Credito	5215.23	Paga	Receita de venda - Pedido #1593	2026-05-20 02:08:03.924705
1684	1926	4886	3	Credito	91.07	Paga	Receita de venda - Pedido #1926	2026-05-20 02:08:03.924705
1685	1832	4708	3	Credito	5165.27	Paga	Receita de venda - Pedido #1832	2026-05-20 02:08:03.924705
1686	635	4522	3	Credito	2381.92	Paga	Receita de venda - Pedido #635	2026-05-20 02:08:03.924705
1687	1672	4569	3	Credito	724.78	Paga	Receita de venda - Pedido #1672	2026-05-20 02:08:03.924705
1688	388	4459	3	Credito	15069.54	Paga	Receita de venda - Pedido #388	2026-05-20 02:08:03.924705
1689	151	4631	3	Credito	87.96	Paga	Receita de venda - Pedido #151	2026-05-20 02:08:03.924705
1690	1346	4646	3	Credito	1563.66	Paga	Receita de venda - Pedido #1346	2026-05-20 02:08:03.924705
1691	620	4576	3	Credito	1968.24	Paga	Receita de venda - Pedido #620	2026-05-20 02:08:03.924705
1692	205	4570	3	Credito	97.19	Paga	Receita de venda - Pedido #205	2026-05-20 02:08:03.924705
1693	67	4874	3	Credito	1146.48	Paga	Receita de venda - Pedido #67	2026-05-20 02:08:03.924705
1694	325	4784	3	Credito	5254.20	Paga	Receita de venda - Pedido #325	2026-05-20 02:08:03.924705
1695	895	4600	3	Credito	780.29	Paga	Receita de venda - Pedido #895	2026-05-20 02:08:03.924705
1696	673	4559	3	Credito	3529.51	Paga	Receita de venda - Pedido #673	2026-05-20 02:08:03.924705
1697	1377	4830	3	Credito	375.72	Paga	Receita de venda - Pedido #1377	2026-05-20 02:08:03.924705
1698	1638	4458	3	Credito	14.71	Paga	Receita de venda - Pedido #1638	2026-05-20 02:08:03.924705
1699	783	4428	3	Credito	228.26	Paga	Receita de venda - Pedido #783	2026-05-20 02:08:03.924705
1700	1794	4539	3	Credito	11101.80	Paga	Receita de venda - Pedido #1794	2026-05-20 02:08:03.924705
1701	334	4743	3	Credito	924.27	Paga	Receita de venda - Pedido #334	2026-05-20 02:08:03.924705
1702	1071	4411	3	Credito	14742.36	Paga	Receita de venda - Pedido #1071	2026-05-20 02:08:03.924705
1703	540	4774	3	Credito	204.67	Paga	Receita de venda - Pedido #540	2026-05-20 02:08:03.924705
1704	1739	4796	3	Credito	695.20	Paga	Receita de venda - Pedido #1739	2026-05-20 02:08:03.924705
1705	464	4793	3	Credito	154.81	Paga	Receita de venda - Pedido #464	2026-05-20 02:08:03.924705
1706	1109	4625	3	Credito	130.04	Paga	Receita de venda - Pedido #1109	2026-05-20 02:08:03.924705
1707	277	4876	3	Credito	4441.51	Paga	Receita de venda - Pedido #277	2026-05-20 02:08:03.924705
1708	1777	4520	3	Credito	814.92	Paga	Receita de venda - Pedido #1777	2026-05-20 02:08:03.924705
1709	1980	4736	3	Credito	0.01	Paga	Receita de venda - Pedido #1980	2026-05-20 02:08:03.924705
1710	1842	4845	3	Credito	671.95	Paga	Receita de venda - Pedido #1842	2026-05-20 02:08:03.924705
1711	300	4394	3	Credito	421.47	Paga	Receita de venda - Pedido #300	2026-05-20 02:08:03.924705
1712	662	4651	3	Credito	54.26	Paga	Receita de venda - Pedido #662	2026-05-20 02:08:03.924705
1713	284	4884	3	Credito	7368.47	Paga	Receita de venda - Pedido #284	2026-05-20 02:08:03.924705
1714	1254	4696	3	Credito	141.56	Paga	Receita de venda - Pedido #1254	2026-05-20 02:08:03.924705
1715	342	4697	3	Credito	0.01	Paga	Receita de venda - Pedido #342	2026-05-20 02:08:03.924705
1716	1133	4647	3	Credito	7418.38	Paga	Receita de venda - Pedido #1133	2026-05-20 02:08:03.924705
1717	1271	4532	3	Credito	22238.37	Paga	Receita de venda - Pedido #1271	2026-05-20 02:08:03.924705
1718	1073	4905	3	Credito	0.01	Paga	Receita de venda - Pedido #1073	2026-05-20 02:08:03.924705
1719	588	4794	3	Credito	1856.40	Paga	Receita de venda - Pedido #588	2026-05-20 02:08:03.924705
1720	1019	4625	3	Credito	4110.36	Paga	Receita de venda - Pedido #1019	2026-05-20 02:08:03.924705
1721	439	4445	3	Credito	524.24	Paga	Receita de venda - Pedido #439	2026-05-20 02:08:03.924705
1722	206	4482	3	Credito	105.48	Paga	Receita de venda - Pedido #206	2026-05-20 02:08:03.924705
1723	46	4592	3	Credito	2423.99	Paga	Receita de venda - Pedido #46	2026-05-20 02:08:03.924705
1724	1773	4515	3	Credito	380.57	Paga	Receita de venda - Pedido #1773	2026-05-20 02:08:03.924705
1725	586	4716	3	Credito	4718.02	Paga	Receita de venda - Pedido #586	2026-05-20 02:08:03.924705
1726	53	4838	3	Credito	167.14	Paga	Receita de venda - Pedido #53	2026-05-20 02:08:03.924705
1727	336	4609	3	Credito	650.75	Paga	Receita de venda - Pedido #336	2026-05-20 02:08:03.924705
1728	275	4386	3	Credito	176.11	Paga	Receita de venda - Pedido #275	2026-05-20 02:08:03.924705
1729	1801	4698	3	Credito	2931.20	Paga	Receita de venda - Pedido #1801	2026-05-20 02:08:03.924705
1730	1412	4408	3	Credito	52.04	Paga	Receita de venda - Pedido #1412	2026-05-20 02:08:03.924705
1731	260	4656	3	Credito	3.24	Paga	Receita de venda - Pedido #260	2026-05-20 02:08:03.924705
1732	136	4845	3	Credito	5260.04	Paga	Receita de venda - Pedido #136	2026-05-20 02:08:03.924705
1733	139	4521	3	Credito	0.01	Paga	Receita de venda - Pedido #139	2026-05-20 02:08:03.924705
1734	1459	4596	3	Credito	3863.66	Paga	Receita de venda - Pedido #1459	2026-05-20 02:08:03.924705
1735	1537	4857	3	Credito	549.29	Paga	Receita de venda - Pedido #1537	2026-05-20 02:08:03.924705
1736	1033	4561	3	Credito	160.37	Paga	Receita de venda - Pedido #1033	2026-05-20 02:08:03.924705
1737	1868	4466	3	Credito	1949.48	Paga	Receita de venda - Pedido #1868	2026-05-20 02:08:03.924705
1738	425	4772	3	Credito	4313.88	Paga	Receita de venda - Pedido #425	2026-05-20 02:08:03.924705
1739	1499	4533	3	Credito	348.60	Paga	Receita de venda - Pedido #1499	2026-05-20 02:08:03.924705
1740	1734	4852	3	Credito	231.65	Paga	Receita de venda - Pedido #1734	2026-05-20 02:08:03.924705
1741	825	4818	3	Credito	292.44	Paga	Receita de venda - Pedido #825	2026-05-20 02:08:03.924705
1742	1040	4643	3	Credito	4848.88	Paga	Receita de venda - Pedido #1040	2026-05-20 02:08:03.924705
1743	731	4759	3	Credito	213.96	Paga	Receita de venda - Pedido #731	2026-05-20 02:08:03.924705
1744	403	4593	3	Credito	423.30	Paga	Receita de venda - Pedido #403	2026-05-20 02:08:03.924705
1745	1597	4448	3	Credito	674.73	Paga	Receita de venda - Pedido #1597	2026-05-20 02:08:03.924705
1746	1350	4396	3	Credito	1450.57	Paga	Receita de venda - Pedido #1350	2026-05-20 02:08:03.924705
1747	654	4582	3	Credito	1623.74	Paga	Receita de venda - Pedido #654	2026-05-20 02:08:03.924705
1748	33	4648	3	Credito	86.02	Paga	Receita de venda - Pedido #33	2026-05-20 02:08:03.924705
1749	1643	4476	3	Credito	773.52	Paga	Receita de venda - Pedido #1643	2026-05-20 02:08:03.924705
1750	549	4852	3	Credito	0.01	Paga	Receita de venda - Pedido #549	2026-05-20 02:08:03.924705
1751	1858	4604	3	Credito	0.01	Paga	Receita de venda - Pedido #1858	2026-05-20 02:08:03.924705
1752	653	4530	3	Credito	3223.54	Paga	Receita de venda - Pedido #653	2026-05-20 02:08:03.924705
1753	380	4865	3	Credito	183.37	Paga	Receita de venda - Pedido #380	2026-05-20 02:08:03.924705
1754	1339	4476	3	Credito	0.01	Paga	Receita de venda - Pedido #1339	2026-05-20 02:08:03.924705
1755	130	4517	3	Credito	0.01	Paga	Receita de venda - Pedido #130	2026-05-20 02:08:03.924705
1756	23	4609	3	Credito	972.49	Paga	Receita de venda - Pedido #23	2026-05-20 02:08:03.924705
1757	612	4675	3	Credito	2709.83	Paga	Receita de venda - Pedido #612	2026-05-20 02:08:03.924705
1758	486	4511	3	Credito	1626.14	Paga	Receita de venda - Pedido #486	2026-05-20 02:08:03.924705
1759	1521	4774	3	Credito	244.58	Paga	Receita de venda - Pedido #1521	2026-05-20 02:08:03.924705
1760	1528	4751	3	Credito	0.01	Paga	Receita de venda - Pedido #1528	2026-05-20 02:08:03.924705
1761	765	4828	3	Credito	3380.53	Paga	Receita de venda - Pedido #765	2026-05-20 02:08:03.924705
1762	1277	4900	3	Credito	942.82	Paga	Receita de venda - Pedido #1277	2026-05-20 02:08:03.924705
1763	1855	4768	3	Credito	411.69	Paga	Receita de venda - Pedido #1855	2026-05-20 02:08:03.924705
1764	552	4633	3	Credito	7663.43	Paga	Receita de venda - Pedido #552	2026-05-20 02:08:03.924705
1765	887	4854	3	Credito	2646.62	Paga	Receita de venda - Pedido #887	2026-05-20 02:08:03.924705
1766	1772	4914	3	Credito	3728.34	Paga	Receita de venda - Pedido #1772	2026-05-20 02:08:03.924705
1767	1669	4596	3	Credito	2678.85	Paga	Receita de venda - Pedido #1669	2026-05-20 02:08:03.924705
1768	959	4606	3	Credito	115.39	Paga	Receita de venda - Pedido #959	2026-05-20 02:08:03.924705
1769	1983	4616	3	Credito	1487.61	Paga	Receita de venda - Pedido #1983	2026-05-20 02:08:03.924705
1770	386	4495	3	Credito	305.91	Paga	Receita de venda - Pedido #386	2026-05-20 02:08:03.924705
1771	1797	4495	3	Credito	0.01	Paga	Receita de venda - Pedido #1797	2026-05-20 02:08:03.924705
1772	433	4573	3	Credito	249.66	Paga	Receita de venda - Pedido #433	2026-05-20 02:08:03.924705
1773	364	4823	3	Credito	358.58	Paga	Receita de venda - Pedido #364	2026-05-20 02:08:03.924705
1774	1187	4652	3	Credito	10372.26	Paga	Receita de venda - Pedido #1187	2026-05-20 02:08:03.924705
1775	1123	4802	3	Credito	1355.04	Paga	Receita de venda - Pedido #1123	2026-05-20 02:08:03.924705
1776	345	4482	3	Credito	4214.78	Paga	Receita de venda - Pedido #345	2026-05-20 02:08:03.924705
1777	92	4455	3	Credito	3072.53	Paga	Receita de venda - Pedido #92	2026-05-20 02:08:03.924705
1778	541	4611	3	Credito	2711.67	Paga	Receita de venda - Pedido #541	2026-05-20 02:08:03.924705
1779	1517	4833	3	Credito	608.37	Paga	Receita de venda - Pedido #1517	2026-05-20 02:08:03.924705
1780	1598	4524	3	Credito	664.37	Paga	Receita de venda - Pedido #1598	2026-05-20 02:08:03.924705
1781	437	4389	3	Credito	2778.52	Paga	Receita de venda - Pedido #437	2026-05-20 02:08:03.924705
1782	957	4845	3	Credito	2143.29	Paga	Receita de venda - Pedido #957	2026-05-20 02:08:03.924705
1783	1065	4646	3	Credito	0.01	Paga	Receita de venda - Pedido #1065	2026-05-20 02:08:03.924705
1784	998	4644	3	Credito	0.01	Paga	Receita de venda - Pedido #998	2026-05-20 02:08:03.924705
1785	1795	4848	3	Credito	3309.18	Paga	Receita de venda - Pedido #1795	2026-05-20 02:08:03.924705
1786	1719	4568	3	Credito	2093.73	Paga	Receita de venda - Pedido #1719	2026-05-20 02:08:03.924705
1787	197	4633	3	Credito	0.01	Paga	Receita de venda - Pedido #197	2026-05-20 02:08:03.924705
1788	999	4741	3	Credito	744.22	Paga	Receita de venda - Pedido #999	2026-05-20 02:08:03.924705
1789	493	4883	3	Credito	0.01	Paga	Receita de venda - Pedido #493	2026-05-20 02:08:03.924705
1790	1536	4442	3	Credito	0.01	Paga	Receita de venda - Pedido #1536	2026-05-20 02:08:03.924705
1791	707	4388	3	Credito	2098.83	Paga	Receita de venda - Pedido #707	2026-05-20 02:08:03.924705
1792	665	4699	3	Credito	1570.88	Paga	Receita de venda - Pedido #665	2026-05-20 02:08:03.924705
1793	759	4404	3	Credito	99.90	Paga	Receita de venda - Pedido #759	2026-05-20 02:08:03.924705
1794	482	4511	3	Credito	748.52	Paga	Receita de venda - Pedido #482	2026-05-20 02:08:03.924705
1795	1547	4455	3	Credito	544.16	Paga	Receita de venda - Pedido #1547	2026-05-20 02:08:03.924705
1796	311	4464	3	Credito	71.72	Paga	Receita de venda - Pedido #311	2026-05-20 02:08:03.924705
1797	103	4433	3	Credito	405.78	Paga	Receita de venda - Pedido #103	2026-05-20 02:08:03.924705
1798	1252	4559	3	Credito	653.91	Paga	Receita de venda - Pedido #1252	2026-05-20 02:08:03.924705
1799	1236	4708	3	Credito	8.82	Paga	Receita de venda - Pedido #1236	2026-05-20 02:08:03.924705
1800	875	4609	3	Credito	2553.12	Paga	Receita de venda - Pedido #875	2026-05-20 02:08:03.924705
1801	1255	4412	3	Credito	185.46	Paga	Receita de venda - Pedido #1255	2026-05-20 02:08:03.924705
1802	420	4802	3	Credito	120.87	Paga	Receita de venda - Pedido #420	2026-05-20 02:08:03.924705
1803	1651	4623	3	Credito	0.01	Paga	Receita de venda - Pedido #1651	2026-05-20 02:08:03.924705
1804	1722	4778	3	Credito	2259.93	Paga	Receita de venda - Pedido #1722	2026-05-20 02:08:03.924705
1805	1322	4549	3	Credito	15290.05	Paga	Receita de venda - Pedido #1322	2026-05-20 02:08:03.924705
1806	845	4514	3	Credito	586.20	Paga	Receita de venda - Pedido #845	2026-05-20 02:08:03.924705
1807	1985	4479	3	Credito	17.65	Paga	Receita de venda - Pedido #1985	2026-05-20 02:08:03.924705
1808	1761	4636	3	Credito	52.86	Paga	Receita de venda - Pedido #1761	2026-05-20 02:08:03.924705
1809	196	4730	3	Credito	324.39	Paga	Receita de venda - Pedido #196	2026-05-20 02:08:03.924705
1810	291	4874	3	Credito	98.71	Paga	Receita de venda - Pedido #291	2026-05-20 02:08:03.924705
1811	1069	4659	3	Credito	23.21	Paga	Receita de venda - Pedido #1069	2026-05-20 02:08:03.924705
1812	1361	4760	3	Credito	5826.71	Paga	Receita de venda - Pedido #1361	2026-05-20 02:08:03.924705
1813	61	4747	3	Credito	12.99	Paga	Receita de venda - Pedido #61	2026-05-20 02:08:03.924705
1814	1043	4672	3	Credito	1.89	Paga	Receita de venda - Pedido #1043	2026-05-20 02:08:03.924705
1815	602	4711	3	Credito	2583.33	Paga	Receita de venda - Pedido #602	2026-05-20 02:08:03.924705
1816	691	4547	3	Credito	0.01	Paga	Receita de venda - Pedido #691	2026-05-20 02:08:03.924705
1817	697	4427	3	Credito	1723.71	Paga	Receita de venda - Pedido #697	2026-05-20 02:08:03.924705
1818	705	4532	3	Credito	120.03	Paga	Receita de venda - Pedido #705	2026-05-20 02:08:03.924705
1819	104	4504	3	Credito	285.29	Paga	Receita de venda - Pedido #104	2026-05-20 02:08:03.924705
1820	1032	4737	3	Credito	2554.88	Paga	Receita de venda - Pedido #1032	2026-05-20 02:08:03.924705
1821	171	4563	3	Credito	911.67	Paga	Receita de venda - Pedido #171	2026-05-20 02:08:03.924705
1822	1591	4553	3	Credito	1296.84	Paga	Receita de venda - Pedido #1591	2026-05-20 02:08:03.924705
1823	1729	4616	3	Credito	3322.36	Paga	Receita de venda - Pedido #1729	2026-05-20 02:08:03.924705
1824	1988	4662	3	Credito	20.03	Paga	Receita de venda - Pedido #1988	2026-05-20 02:08:03.924705
1825	397	4629	3	Credito	4765.25	Paga	Receita de venda - Pedido #397	2026-05-20 02:08:03.924705
1826	604	4636	3	Credito	1122.68	Paga	Receita de venda - Pedido #604	2026-05-20 02:08:03.924705
1827	427	4668	3	Credito	5001.70	Paga	Receita de venda - Pedido #427	2026-05-20 02:08:03.924705
1828	347	4428	3	Credito	2552.45	Paga	Receita de venda - Pedido #347	2026-05-20 02:08:03.924705
1829	179	4614	3	Credito	529.94	Paga	Receita de venda - Pedido #179	2026-05-20 02:08:03.924705
1830	562	4875	3	Credito	2471.78	Paga	Receita de venda - Pedido #562	2026-05-20 02:08:03.924705
1831	636	4877	3	Credito	140.87	Paga	Receita de venda - Pedido #636	2026-05-20 02:08:03.924705
1832	1228	4504	3	Credito	4389.59	Paga	Receita de venda - Pedido #1228	2026-05-20 02:08:03.924705
1833	1652	4553	3	Credito	1799.63	Paga	Receita de venda - Pedido #1652	2026-05-20 02:08:03.924705
1834	1518	4517	3	Credito	2022.96	Paga	Receita de venda - Pedido #1518	2026-05-20 02:08:03.924705
1835	1387	4658	3	Credito	4998.66	Paga	Receita de venda - Pedido #1387	2026-05-20 02:08:03.924705
1836	1819	4856	3	Credito	3452.95	Paga	Receita de venda - Pedido #1819	2026-05-20 02:08:03.924705
1837	445	4610	3	Credito	124.46	Paga	Receita de venda - Pedido #445	2026-05-20 02:08:03.924705
1838	889	4651	3	Credito	164.63	Paga	Receita de venda - Pedido #889	2026-05-20 02:08:03.924705
1839	1611	4605	3	Credito	121.55	Paga	Receita de venda - Pedido #1611	2026-05-20 02:08:03.924705
1840	1724	4458	3	Credito	3099.99	Paga	Receita de venda - Pedido #1724	2026-05-20 02:08:03.924705
1841	1746	4558	3	Credito	12361.11	Paga	Receita de venda - Pedido #1746	2026-05-20 02:08:03.924705
1842	253	4397	3	Credito	630.48	Paga	Receita de venda - Pedido #253	2026-05-20 02:08:03.924705
1843	1369	4555	3	Credito	1128.77	Paga	Receita de venda - Pedido #1369	2026-05-20 02:08:03.924705
1844	692	4784	3	Credito	94.18	Paga	Receita de venda - Pedido #692	2026-05-20 02:08:03.924705
1845	581	4839	3	Credito	74.06	Paga	Receita de venda - Pedido #581	2026-05-20 02:08:03.924705
1846	14	4686	3	Credito	0.01	Paga	Receita de venda - Pedido #14	2026-05-20 02:08:03.924705
1847	109	4586	3	Credito	29.13	Paga	Receita de venda - Pedido #109	2026-05-20 02:08:03.924705
1848	133	4624	3	Credito	154.61	Paga	Receita de venda - Pedido #133	2026-05-20 02:08:03.924705
1849	1134	4424	3	Credito	0.01	Paga	Receita de venda - Pedido #1134	2026-05-20 02:08:03.924705
1850	1237	4772	3	Credito	69.46	Paga	Receita de venda - Pedido #1237	2026-05-20 02:08:03.924705
1851	1511	4774	3	Credito	735.65	Paga	Receita de venda - Pedido #1511	2026-05-20 02:08:03.924705
1852	1818	4711	3	Credito	265.08	Paga	Receita de venda - Pedido #1818	2026-05-20 02:08:03.924705
1853	603	4800	3	Credito	3887.24	Paga	Receita de venda - Pedido #603	2026-05-20 02:08:03.924705
1854	383	4413	3	Credito	4685.71	Paga	Receita de venda - Pedido #383	2026-05-20 02:08:03.924705
1855	301	4706	3	Credito	11726.62	Paga	Receita de venda - Pedido #301	2026-05-20 02:08:03.924705
1856	7	4539	3	Credito	0.01	Paga	Receita de venda - Pedido #7	2026-05-20 02:08:03.924705
1857	1011	4524	3	Credito	8405.26	Paga	Receita de venda - Pedido #1011	2026-05-20 02:08:03.924705
1858	757	4852	3	Credito	337.77	Paga	Receita de venda - Pedido #757	2026-05-20 02:08:03.924705
1859	1600	4605	3	Credito	293.42	Paga	Receita de venda - Pedido #1600	2026-05-20 02:08:03.924705
1860	771	4682	3	Credito	3101.31	Paga	Receita de venda - Pedido #771	2026-05-20 02:08:03.924705
1861	1497	4648	3	Credito	3954.38	Paga	Receita de venda - Pedido #1497	2026-05-20 02:08:03.924705
1862	1875	4696	3	Credito	3039.32	Paga	Receita de venda - Pedido #1875	2026-05-20 02:08:03.924705
1863	1618	4654	3	Credito	13304.11	Paga	Receita de venda - Pedido #1618	2026-05-20 02:08:03.924705
1864	1402	4762	3	Credito	2651.89	Paga	Receita de venda - Pedido #1402	2026-05-20 02:08:03.924705
1865	432	4848	3	Credito	1156.53	Paga	Receita de venda - Pedido #432	2026-05-20 02:08:03.924705
1866	1582	4462	3	Credito	11798.84	Paga	Receita de venda - Pedido #1582	2026-05-20 02:08:03.924705
1867	1763	4797	3	Credito	397.72	Paga	Receita de venda - Pedido #1763	2026-05-20 02:08:03.924705
1868	1347	4568	3	Credito	12172.16	Paga	Receita de venda - Pedido #1347	2026-05-20 02:08:03.924705
1869	1061	4410	3	Credito	6661.76	Paga	Receita de venda - Pedido #1061	2026-05-20 02:08:03.924705
1870	319	4559	3	Credito	2669.97	Paga	Receita de venda - Pedido #319	2026-05-20 02:08:03.924705
1871	1417	4800	3	Credito	36.66	Paga	Receita de venda - Pedido #1417	2026-05-20 02:08:03.924705
1872	1	4451	3	Credito	3930.09	Paga	Receita de venda - Pedido #1	2026-05-20 02:08:03.924705
1873	76	4456	3	Credito	0.01	Paga	Receita de venda - Pedido #76	2026-05-20 02:08:03.924705
1874	1392	4600	3	Credito	8459.93	Paga	Receita de venda - Pedido #1392	2026-05-20 02:08:03.924705
1875	346	4659	3	Credito	2646.54	Paga	Receita de venda - Pedido #346	2026-05-20 02:08:03.924705
1876	71	4595	3	Credito	761.95	Paga	Receita de venda - Pedido #71	2026-05-20 02:08:03.924705
1877	267	4552	3	Credito	3418.77	Paga	Receita de venda - Pedido #267	2026-05-20 02:08:03.924705
1878	68	4394	3	Credito	14794.93	Paga	Receita de venda - Pedido #68	2026-05-20 02:08:03.924705
1879	1002	4540	3	Credito	4664.51	Paga	Receita de venda - Pedido #1002	2026-05-20 02:08:03.924705
1880	773	4633	3	Credito	784.40	Paga	Receita de venda - Pedido #773	2026-05-20 02:08:03.924705
1881	1817	4654	3	Credito	2086.64	Paga	Receita de venda - Pedido #1817	2026-05-20 02:08:03.924705
1882	146	4709	3	Credito	896.78	Paga	Receita de venda - Pedido #146	2026-05-20 02:08:03.924705
1883	80	4824	3	Credito	476.29	Paga	Receita de venda - Pedido #80	2026-05-20 02:08:03.924705
1884	861	4643	3	Credito	2655.16	Paga	Receita de venda - Pedido #861	2026-05-20 02:08:03.924705
1885	162	4809	3	Credito	2525.93	Paga	Receita de venda - Pedido #162	2026-05-20 02:08:03.924705
1886	738	4474	3	Credito	677.68	Paga	Receita de venda - Pedido #738	2026-05-20 02:08:03.924705
1887	797	4747	3	Credito	2374.89	Paga	Receita de venda - Pedido #797	2026-05-20 02:08:03.924705
1888	1633	4523	3	Credito	0.01	Paga	Receita de venda - Pedido #1633	2026-05-20 02:08:03.924705
1889	582	4398	3	Credito	0.01	Paga	Receita de venda - Pedido #582	2026-05-20 02:08:03.924705
1890	1676	4495	3	Credito	151.62	Paga	Receita de venda - Pedido #1676	2026-05-20 02:08:03.924705
1891	1095	4599	3	Credito	0.01	Paga	Receita de venda - Pedido #1095	2026-05-20 02:08:03.924705
1892	1958	4856	3	Credito	123.93	Paga	Receita de venda - Pedido #1958	2026-05-20 02:08:03.924705
1893	1973	4785	3	Credito	644.17	Paga	Receita de venda - Pedido #1973	2026-05-20 02:08:03.924705
1894	1386	4541	3	Credito	417.93	Paga	Receita de venda - Pedido #1386	2026-05-20 02:08:03.924705
1895	751	4659	3	Credito	0.01	Paga	Receita de venda - Pedido #751	2026-05-20 02:08:03.924705
1896	237	4512	3	Credito	12339.51	Paga	Receita de venda - Pedido #237	2026-05-20 02:08:03.924705
1897	1892	4671	3	Credito	2434.36	Paga	Receita de venda - Pedido #1892	2026-05-20 02:08:03.924705
1898	262	4622	3	Credito	0.01	Paga	Receita de venda - Pedido #262	2026-05-20 02:08:03.924705
1899	337	4684	3	Credito	4843.27	Paga	Receita de venda - Pedido #337	2026-05-20 02:08:03.924705
1900	1997	4865	3	Credito	77.60	Paga	Receita de venda - Pedido #1997	2026-05-20 02:08:03.924705
1901	1689	4640	3	Credito	470.13	Paga	Receita de venda - Pedido #1689	2026-05-20 02:08:03.924705
1902	504	4671	3	Credito	269.27	Paga	Receita de venda - Pedido #504	2026-05-20 02:08:03.924705
1903	1504	4507	3	Credito	0.01	Paga	Receita de venda - Pedido #1504	2026-05-20 02:08:03.924705
1904	399	4605	3	Credito	15115.37	Paga	Receita de venda - Pedido #399	2026-05-20 02:08:03.924705
1905	238	4649	3	Credito	48.27	Paga	Receita de venda - Pedido #238	2026-05-20 02:08:03.924705
1906	1699	4867	3	Credito	464.69	Paga	Receita de venda - Pedido #1699	2026-05-20 02:08:03.924705
1907	547	4547	3	Credito	0.01	Paga	Receita de venda - Pedido #547	2026-05-20 02:08:03.924705
1908	818	4899	3	Credito	1611.50	Paga	Receita de venda - Pedido #818	2026-05-20 02:08:03.924705
1909	737	4913	3	Credito	1415.48	Paga	Receita de venda - Pedido #737	2026-05-20 02:08:03.924705
1910	569	4912	3	Credito	1147.10	Paga	Receita de venda - Pedido #569	2026-05-20 02:08:03.924705
1911	124	4434	3	Credito	0.01	Paga	Receita de venda - Pedido #124	2026-05-20 02:08:03.924705
1912	452	4810	3	Credito	0.01	Paga	Receita de venda - Pedido #452	2026-05-20 02:08:03.924705
1913	798	4510	3	Credito	823.58	Paga	Receita de venda - Pedido #798	2026-05-20 02:08:03.924705
1914	200	4914	3	Credito	3316.01	Paga	Receita de venda - Pedido #200	2026-05-20 02:08:03.924705
1915	1623	4564	3	Credito	1109.95	Paga	Receita de venda - Pedido #1623	2026-05-20 02:08:03.924705
1916	990	4837	3	Credito	8718.50	Paga	Receita de venda - Pedido #990	2026-05-20 02:08:03.924705
1917	685	4412	3	Credito	124.90	Paga	Receita de venda - Pedido #685	2026-05-20 02:08:03.924705
1918	905	4821	3	Credito	290.03	Paga	Receita de venda - Pedido #905	2026-05-20 02:08:03.924705
1919	1379	4568	3	Credito	5532.86	Paga	Receita de venda - Pedido #1379	2026-05-20 02:08:03.924705
1920	973	4606	3	Credito	3482.91	Paga	Receita de venda - Pedido #973	2026-05-20 02:08:03.924705
1921	79	4438	3	Credito	2788.35	Paga	Receita de venda - Pedido #79	2026-05-20 02:08:03.924705
1922	1532	4888	3	Credito	67.24	Paga	Receita de venda - Pedido #1532	2026-05-20 02:08:03.924705
1923	1925	4781	3	Credito	3213.71	Paga	Receita de venda - Pedido #1925	2026-05-20 02:08:03.924705
1924	1895	4604	3	Credito	109.11	Paga	Receita de venda - Pedido #1895	2026-05-20 02:08:03.924705
1925	1448	4873	3	Credito	0.01	Paga	Receita de venda - Pedido #1448	2026-05-20 02:08:03.924705
1926	17	4752	3	Credito	4185.42	Paga	Receita de venda - Pedido #17	2026-05-20 02:08:03.924705
1927	1116	4605	3	Credito	736.08	Paga	Receita de venda - Pedido #1116	2026-05-20 02:08:03.924705
1928	1290	4865	3	Credito	5224.41	Paga	Receita de venda - Pedido #1290	2026-05-20 02:08:03.924705
1929	1070	4546	3	Credito	3326.63	Paga	Receita de venda - Pedido #1070	2026-05-20 02:08:03.924705
1930	404	4388	3	Credito	10826.35	Paga	Receita de venda - Pedido #404	2026-05-20 02:08:03.924705
1931	997	4661	3	Credito	2451.39	Paga	Receita de venda - Pedido #997	2026-05-20 02:08:03.924705
1932	1280	4504	3	Credito	177.70	Paga	Receita de venda - Pedido #1280	2026-05-20 02:08:03.924705
1933	1029	4641	3	Credito	0.01	Paga	Receita de venda - Pedido #1029	2026-05-20 02:08:03.924705
1934	1068	4863	3	Credito	2857.16	Paga	Receita de venda - Pedido #1068	2026-05-20 02:08:03.924705
1935	1245	4608	3	Credito	125.45	Paga	Receita de venda - Pedido #1245	2026-05-20 02:08:03.924705
1936	616	4563	3	Credito	1945.64	Paga	Receita de venda - Pedido #616	2026-05-20 02:08:03.924705
1937	1211	4891	3	Credito	1555.89	Paga	Receita de venda - Pedido #1211	2026-05-20 02:08:03.924705
1938	1393	4705	3	Credito	4180.23	Paga	Receita de venda - Pedido #1393	2026-05-20 02:08:03.924705
1939	83	4775	3	Credito	411.67	Paga	Receita de venda - Pedido #83	2026-05-20 02:08:03.924705
1940	63	4820	3	Credito	182.02	Paga	Receita de venda - Pedido #63	2026-05-20 02:08:03.924705
1941	516	4809	3	Credito	349.20	Paga	Receita de venda - Pedido #516	2026-05-20 02:08:03.924705
1942	542	4744	3	Credito	6666.46	Paga	Receita de venda - Pedido #542	2026-05-20 02:08:03.924705
1943	395	4411	3	Credito	7191.27	Paga	Receita de venda - Pedido #395	2026-05-20 02:08:03.924705
1944	1294	4831	3	Credito	584.38	Paga	Receita de venda - Pedido #1294	2026-05-20 02:08:03.924705
1945	882	4524	3	Credito	0.01	Paga	Receita de venda - Pedido #882	2026-05-20 02:08:03.924705
1946	955	4779	3	Credito	12472.92	Paga	Receita de venda - Pedido #955	2026-05-20 02:08:03.924705
1947	274	4672	3	Credito	0.01	Paga	Receita de venda - Pedido #274	2026-05-20 02:08:03.924705
1948	1876	4669	3	Credito	358.08	Paga	Receita de venda - Pedido #1876	2026-05-20 02:08:03.924705
1949	1304	4483	3	Credito	4441.28	Paga	Receita de venda - Pedido #1304	2026-05-20 02:08:03.924705
1950	1590	4561	3	Credito	4134.46	Paga	Receita de venda - Pedido #1590	2026-05-20 02:08:03.924705
1951	1904	4389	3	Credito	2315.51	Paga	Receita de venda - Pedido #1904	2026-05-20 02:08:03.924705
1952	801	4424	3	Credito	89.50	Paga	Receita de venda - Pedido #801	2026-05-20 02:08:03.924705
1953	163	4892	3	Credito	3039.82	Paga	Receita de venda - Pedido #163	2026-05-20 02:08:03.924705
1954	1302	4692	3	Credito	6564.99	Paga	Receita de venda - Pedido #1302	2026-05-20 02:08:03.924705
1955	1103	4564	3	Credito	4907.03	Paga	Receita de venda - Pedido #1103	2026-05-20 02:08:03.924705
1956	669	4517	3	Credito	13216.11	Paga	Receita de venda - Pedido #669	2026-05-20 02:08:03.924705
1957	223	4736	3	Credito	267.62	Paga	Receita de venda - Pedido #223	2026-05-20 02:08:03.924705
1958	352	4665	3	Credito	1581.72	Paga	Receita de venda - Pedido #352	2026-05-20 02:08:03.924705
1959	1512	4511	3	Credito	239.02	Paga	Receita de venda - Pedido #1512	2026-05-20 02:08:03.924705
1960	362	4396	3	Credito	536.88	Paga	Receita de venda - Pedido #362	2026-05-20 02:08:03.924705
1961	221	4738	3	Credito	4563.44	Paga	Receita de venda - Pedido #221	2026-05-20 02:08:03.924705
1962	688	4899	3	Credito	137.74	Paga	Receita de venda - Pedido #688	2026-05-20 02:08:03.924705
1963	1288	4856	3	Credito	3494.79	Paga	Receita de venda - Pedido #1288	2026-05-20 02:08:03.924705
1964	1207	4563	3	Credito	3358.50	Paga	Receita de venda - Pedido #1207	2026-05-20 02:08:03.924705
1965	111	4413	3	Credito	4021.77	Paga	Receita de venda - Pedido #111	2026-05-20 02:08:03.924705
1966	1093	4796	3	Credito	1058.59	Paga	Receita de venda - Pedido #1093	2026-05-20 02:08:03.924705
1967	1076	4870	3	Credito	0.01	Paga	Receita de venda - Pedido #1076	2026-05-20 02:08:03.924705
1968	1709	4658	3	Credito	680.40	Paga	Receita de venda - Pedido #1709	2026-05-20 02:08:03.924705
1969	968	4662	3	Credito	4707.64	Paga	Receita de venda - Pedido #968	2026-05-20 02:08:03.924705
1970	16	4853	3	Credito	479.30	Paga	Receita de venda - Pedido #16	2026-05-20 02:08:03.924705
1971	1659	4451	3	Credito	0.01	Paga	Receita de venda - Pedido #1659	2026-05-20 02:08:03.924705
1972	326	4795	3	Credito	2074.67	Paga	Receita de venda - Pedido #326	2026-05-20 02:08:03.924705
1973	1879	4615	3	Credito	3251.46	Paga	Receita de venda - Pedido #1879	2026-05-20 02:08:03.924705
1974	371	4455	3	Credito	843.71	Paga	Receita de venda - Pedido #371	2026-05-20 02:08:03.924705
1975	1939	4479	3	Credito	874.58	Paga	Receita de venda - Pedido #1939	2026-05-20 02:08:03.924705
1976	655	4457	3	Credito	44.37	Paga	Receita de venda - Pedido #655	2026-05-20 02:08:03.924705
1977	1327	4394	3	Credito	316.40	Paga	Receita de venda - Pedido #1327	2026-05-20 02:08:03.924705
1978	1450	4722	3	Credito	596.68	Paga	Receita de venda - Pedido #1450	2026-05-20 02:08:03.924705
1979	183	4594	3	Credito	287.85	Paga	Receita de venda - Pedido #183	2026-05-20 02:08:03.924705
1980	1225	4593	3	Credito	4591.04	Paga	Receita de venda - Pedido #1225	2026-05-20 02:08:03.924705
1981	150	4649	3	Credito	402.73	Paga	Receita de venda - Pedido #150	2026-05-20 02:08:03.924705
1982	656	4898	3	Credito	302.17	Paga	Receita de venda - Pedido #656	2026-05-20 02:08:03.924705
1983	1731	4480	3	Credito	8732.86	Paga	Receita de venda - Pedido #1731	2026-05-20 02:08:03.924705
1984	122	4515	3	Credito	91.03	Paga	Receita de venda - Pedido #122	2026-05-20 02:08:03.924705
1985	1355	4880	3	Credito	434.16	Paga	Receita de venda - Pedido #1355	2026-05-20 02:08:03.924705
1986	648	4389	3	Credito	7206.21	Paga	Receita de venda - Pedido #648	2026-05-20 02:08:03.924705
1987	570	4560	3	Credito	443.28	Paga	Receita de venda - Pedido #570	2026-05-20 02:08:03.924705
1988	923	4839	3	Credito	2157.14	Paga	Receita de venda - Pedido #923	2026-05-20 02:08:03.924705
1989	995	4829	3	Credito	0.01	Paga	Receita de venda - Pedido #995	2026-05-20 02:08:03.924705
1990	1867	4831	3	Credito	2310.21	Paga	Receita de venda - Pedido #1867	2026-05-20 02:08:03.924705
1991	1014	4828	3	Credito	853.97	Paga	Receita de venda - Pedido #1014	2026-05-20 02:08:03.924705
1992	1125	4633	3	Credito	280.83	Paga	Receita de venda - Pedido #1125	2026-05-20 02:08:03.924705
1993	530	4413	3	Credito	3357.15	Paga	Receita de venda - Pedido #530	2026-05-20 02:08:03.924705
1994	928	4676	3	Credito	0.01	Paga	Receita de venda - Pedido #928	2026-05-20 02:08:03.924705
1995	536	4797	3	Credito	0.01	Paga	Receita de venda - Pedido #536	2026-05-20 02:08:03.924705
1996	1715	4824	3	Credito	1574.52	Paga	Receita de venda - Pedido #1715	2026-05-20 02:08:03.924705
1997	520	4677	3	Credito	0.01	Paga	Receita de venda - Pedido #520	2026-05-20 02:08:03.924705
1998	55	4621	3	Credito	2637.50	Paga	Receita de venda - Pedido #55	2026-05-20 02:08:03.924705
1999	148	4867	3	Credito	72.89	Paga	Receita de venda - Pedido #148	2026-05-20 02:08:03.924705
2000	790	4774	3	Credito	1473.63	Paga	Receita de venda - Pedido #790	2026-05-20 02:08:03.924705
\.


--
-- Data for Name: fato_venda; Type: TABLE DATA; Schema: financeiro; Owner: postgres
--

COPY financeiro.fato_venda (id_venda, numero_pedido, numero_item, fk_tempo, fk_cliente, fk_produto, fk_canal_venda, fk_forma_pagamento, quantidade, valor_unitario, valor_total, data_hora_venda) FROM stdin;
1	1	1	4451	457	95	1	3	10	420.00	3930.09	2021-03-10 00:00:00
2	2	1	4620	457	95	1	3	3	62.00	0.01	2021-08-26 00:00:00
3	3	1	4686	457	95	1	3	10	41.00	385.64	2021-10-31 00:00:00
4	4	1	4495	457	95	1	3	6	350.00	2070.92	2021-04-23 00:00:00
5	5	1	4649	457	95	1	3	5	93.00	414.77	2021-09-24 00:00:00
6	6	1	4611	457	95	1	3	9	93.00	750.99	2021-08-17 00:00:00
7	7	1	4539	457	95	1	3	3	22.00	0.01	2021-06-06 00:00:00
8	8	1	4863	457	95	1	3	10	400.00	3736.98	2022-04-26 00:00:00
9	9	1	4545	457	95	1	3	8	85.00	657.11	2021-06-12 00:00:00
10	10	1	4741	457	95	1	3	6	550.00	3244.78	2021-12-25 00:00:00
11	11	1	4878	457	95	1	3	6	460.00	2614.37	2022-05-11 00:00:00
12	12	1	4796	457	95	1	3	5	60.00	118.05	2022-02-18 00:00:00
13	13	1	4654	457	95	1	3	3	100.00	112.37	2021-09-29 00:00:00
14	14	1	4686	457	95	1	3	2	41.00	0.01	2021-10-31 00:00:00
15	15	1	4586	457	95	1	3	5	990.00	4762.09	2021-07-23 00:00:00
16	16	1	4853	457	95	1	3	8	90.00	479.30	2022-04-16 00:00:00
17	17	1	4752	457	95	1	3	3	1490.00	4185.42	2022-01-05 00:00:00
18	18	1	4408	457	95	1	3	9	200.00	1792.63	2021-01-26 00:00:00
19	19	1	4796	457	95	1	3	4	390.00	1497.08	2022-02-18 00:00:00
20	20	1	4900	457	95	1	3	3	420.00	993.16	2022-06-02 00:00:00
21	21	1	4648	457	95	1	3	1	390.00	304.58	2021-09-23 00:00:00
22	22	1	4774	457	95	1	3	10	1890.00	18787.20	2022-01-27 00:00:00
23	23	1	4609	457	95	1	3	1	990.00	972.49	2021-08-15 00:00:00
24	24	1	4850	457	95	1	3	2	899.99	1782.88	2022-04-13 00:00:00
25	25	1	4896	457	95	1	3	4	60.00	0.01	2022-05-29 00:00:00
26	26	1	4389	457	95	1	3	5	350.00	1469.18	2021-01-07 00:00:00
27	27	1	4768	457	95	1	3	5	60.00	161.35	2022-01-21 00:00:00
28	28	1	4720	457	95	1	3	3	100.00	4.31	2021-12-04 00:00:00
29	29	1	4818	457	95	1	3	3	60.00	0.01	2022-03-12 00:00:00
30	30	1	4776	457	95	1	3	6	1890.00	11256.93	2022-01-29 00:00:00
31	31	1	4592	457	95	1	3	4	550.00	2177.37	2021-07-29 00:00:00
32	32	1	4802	457	95	1	3	4	490.00	1664.70	2022-02-24 00:00:00
33	33	1	4648	457	95	1	3	4	62.00	86.02	2021-09-23 00:00:00
34	34	1	4697	457	95	1	3	5	350.00	1663.69	2021-11-11 00:00:00
35	35	1	4537	457	95	1	3	9	249.99	1988.09	2021-06-04 00:00:00
36	36	1	4558	457	95	1	3	5	62.00	146.66	2021-06-25 00:00:00
37	37	1	4421	457	95	1	3	6	22.00	42.29	2021-02-08 00:00:00
38	38	1	4445	457	95	1	3	8	460.00	3607.11	2021-03-04 00:00:00
39	39	1	4408	457	95	1	3	2	450.00	819.11	2021-01-26 00:00:00
40	40	1	4564	457	95	1	3	6	1700.00	10139.58	2021-07-01 00:00:00
41	41	1	4816	457	95	1	3	1	510.00	445.08	2022-03-10 00:00:00
42	42	1	4706	457	95	1	3	2	1390.00	2678.58	2021-11-20 00:00:00
43	43	1	4562	457	95	1	3	10	93.00	850.98	2021-06-29 00:00:00
44	44	1	4810	457	95	1	3	7	46.00	63.49	2022-03-04 00:00:00
45	45	1	4914	457	95	1	3	7	460.00	3035.39	2022-06-16 00:00:00
46	46	1	4592	457	95	1	3	5	500.00	2423.99	2021-07-29 00:00:00
47	47	1	4722	457	95	1	3	6	249.99	1464.40	2021-12-06 00:00:00
48	48	1	4531	457	95	1	3	10	1699.99	16720.63	2021-05-29 00:00:00
49	49	1	4813	457	95	1	3	3	460.00	1138.86	2022-03-07 00:00:00
50	50	1	4773	457	95	1	3	3	249.99	540.27	2022-01-26 00:00:00
51	51	1	4741	457	95	1	3	6	46.00	1.68	2021-12-25 00:00:00
52	52	1	4784	457	95	1	3	9	450.00	3945.62	2022-02-06 00:00:00
53	53	1	4838	457	95	1	3	9	50.00	167.14	2022-04-01 00:00:00
54	54	1	4698	457	95	1	3	2	34.00	0.01	2021-11-12 00:00:00
55	55	1	4621	457	95	1	3	10	290.00	2637.50	2021-08-27 00:00:00
56	56	1	4504	457	95	1	3	4	300.00	1095.43	2021-05-02 00:00:00
57	57	1	4725	457	95	1	3	9	249.99	2182.90	2021-12-09 00:00:00
58	58	1	4771	457	95	1	3	1	665.00	484.29	2022-01-24 00:00:00
59	59	1	4515	457	95	1	3	4	510.00	1755.09	2021-05-13 00:00:00
60	60	1	4458	457	95	1	3	10	72.00	717.13	2021-03-17 00:00:00
61	61	1	4747	457	95	1	3	8	20.00	12.99	2021-12-31 00:00:00
62	62	1	4434	457	95	1	3	10	500.00	4962.47	2021-02-21 00:00:00
63	63	1	4820	457	95	1	3	3	62.00	182.02	2022-03-14 00:00:00
64	64	1	4838	457	95	1	3	5	1390.00	6662.80	2022-04-01 00:00:00
65	65	1	4405	457	95	1	3	1	490.00	465.75	2021-01-23 00:00:00
66	66	1	4623	457	95	1	3	8	100.00	513.39	2021-08-29 00:00:00
67	67	1	4874	457	95	1	3	3	450.00	1146.48	2022-05-07 00:00:00
68	68	1	4394	457	95	1	3	6	2490.00	14794.93	2021-01-12 00:00:00
69	69	1	4870	457	95	1	3	3	690.00	1871.03	2022-05-03 00:00:00
70	70	1	4512	457	95	1	3	6	300.00	1609.40	2021-05-10 00:00:00
71	71	1	4595	457	95	1	3	1	899.99	761.95	2021-08-01 00:00:00
72	72	1	4568	457	95	1	3	2	72.00	0.01	2021-07-05 00:00:00
73	73	1	4644	457	95	1	3	3	450.00	1219.17	2021-09-19 00:00:00
74	74	1	4422	457	95	1	3	6	420.00	2248.12	2021-02-09 00:00:00
75	75	1	4389	457	95	1	3	8	100.00	708.87	2021-01-07 00:00:00
76	76	1	4456	457	95	1	3	1	34.00	0.01	2021-03-15 00:00:00
77	77	1	4531	457	95	1	3	3	93.00	24.14	2021-05-29 00:00:00
78	78	1	4802	457	95	1	3	7	350.00	2166.15	2022-02-24 00:00:00
79	79	1	4438	457	95	1	3	7	400.00	2788.35	2021-02-25 00:00:00
80	80	1	4824	457	95	1	3	3	249.99	476.29	2022-03-18 00:00:00
81	81	1	4560	457	95	1	3	3	550.00	1402.59	2021-06-27 00:00:00
82	82	1	4829	457	95	1	3	7	100.00	693.81	2022-03-23 00:00:00
83	83	1	4775	457	95	1	3	6	90.00	411.67	2022-01-28 00:00:00
84	84	1	4489	457	95	1	3	6	490.00	2720.18	2021-04-17 00:00:00
85	85	1	4511	457	95	1	3	8	22.00	0.01	2021-05-09 00:00:00
86	86	1	4645	457	95	1	3	10	1490.00	14650.69	2021-09-20 00:00:00
87	87	1	4859	457	95	1	3	9	93.00	705.07	2022-04-22 00:00:00
88	88	1	4495	457	95	1	3	1	60.00	0.01	2021-04-23 00:00:00
89	89	1	4607	457	95	1	3	7	1490.00	10231.32	2021-08-13 00:00:00
90	90	1	4640	457	95	1	3	1	90.00	0.01	2021-09-15 00:00:00
91	91	1	4863	457	95	1	3	8	100.00	655.13	2022-04-26 00:00:00
92	92	1	4455	457	95	1	3	8	400.00	3072.53	2021-03-14 00:00:00
93	93	1	4653	457	95	1	3	3	100.00	93.45	2021-09-28 00:00:00
94	94	1	4735	457	95	1	3	3	300.00	830.63	2021-12-19 00:00:00
95	95	1	4792	457	95	1	3	9	990.00	8626.64	2022-02-14 00:00:00
96	96	1	4450	457	95	1	3	6	290.00	1540.12	2021-03-09 00:00:00
97	97	1	4711	457	95	1	3	10	93.00	907.17	2021-11-25 00:00:00
98	98	1	4518	457	95	1	3	3	390.00	1127.10	2021-05-16 00:00:00
99	99	1	4916	457	95	1	3	10	46.00	167.42	2022-06-18 00:00:00
100	100	1	4750	457	95	1	3	5	299.99	1440.95	2022-01-03 00:00:00
101	101	1	4694	457	95	1	3	4	10.00	0.01	2021-11-08 00:00:00
102	102	1	4711	457	95	1	3	2	1390.00	2680.12	2021-11-25 00:00:00
103	103	1	4433	457	95	1	3	5	85.00	405.78	2021-02-20 00:00:00
104	104	1	4504	457	95	1	3	8	41.00	285.29	2021-05-02 00:00:00
105	105	1	4643	457	95	1	3	1	46.00	0.01	2021-09-18 00:00:00
106	106	1	4697	457	95	1	3	3	100.00	138.37	2021-11-11 00:00:00
107	107	1	4614	457	95	1	3	6	510.00	2921.46	2021-08-20 00:00:00
108	108	1	4867	457	95	1	3	6	34.00	0.01	2022-04-30 00:00:00
109	109	1	4586	457	95	1	3	8	22.00	29.13	2021-07-23 00:00:00
110	110	1	4875	457	95	1	3	9	100.00	796.60	2022-05-08 00:00:00
111	111	1	4413	457	95	1	3	8	510.00	4021.77	2021-01-31 00:00:00
112	112	1	4442	457	95	1	3	8	1700.00	13353.50	2021-03-01 00:00:00
113	113	1	4849	457	95	1	3	4	420.00	1555.83	2022-04-12 00:00:00
114	114	1	4854	457	95	1	3	6	690.00	3995.68	2022-04-17 00:00:00
115	115	1	4721	457	95	1	3	4	390.00	1339.37	2021-12-05 00:00:00
116	116	1	4460	457	95	1	3	9	300.00	2564.97	2021-03-19 00:00:00
117	117	1	4479	457	95	1	3	10	249.99	2478.75	2021-04-07 00:00:00
118	118	1	4898	457	95	1	3	10	60.00	450.61	2022-05-31 00:00:00
119	119	1	4721	457	95	1	3	5	200.00	747.12	2021-12-05 00:00:00
120	120	1	4518	457	95	1	3	4	1700.00	6524.84	2021-05-16 00:00:00
121	121	1	4891	457	95	1	3	3	420.00	1217.51	2022-05-24 00:00:00
122	122	1	4515	457	95	1	3	5	50.00	91.03	2021-05-13 00:00:00
123	123	1	4385	457	95	1	3	9	1490.00	13154.49	2021-01-03 00:00:00
124	124	1	4434	457	95	1	3	2	62.00	0.01	2021-02-21 00:00:00
125	125	1	4595	457	95	1	3	8	100.00	797.42	2021-08-01 00:00:00
126	126	1	4685	457	95	1	3	5	550.00	2602.78	2021-10-30 00:00:00
127	127	1	4501	457	95	1	3	5	46.00	0.01	2021-04-29 00:00:00
128	128	1	4636	457	95	1	3	6	249.99	1254.26	2021-09-11 00:00:00
129	129	1	4645	457	95	1	3	4	500.00	1834.84	2021-09-20 00:00:00
130	130	1	4517	457	95	1	3	4	22.00	0.01	2021-05-15 00:00:00
131	131	1	4595	457	95	1	3	3	20.00	0.01	2021-08-01 00:00:00
132	132	1	4466	457	95	1	3	10	1390.00	13652.86	2021-03-25 00:00:00
133	133	1	4624	457	95	1	3	6	29.00	154.61	2021-08-30 00:00:00
134	134	1	4437	457	95	1	3	10	1390.00	13650.26	2021-02-24 00:00:00
135	135	1	4412	457	95	1	3	2	490.00	976.41	2021-01-30 00:00:00
136	136	1	4845	457	95	1	3	10	550.00	5260.04	2022-04-08 00:00:00
137	137	1	4384	457	95	1	3	5	1390.00	6942.24	2021-01-02 00:00:00
138	138	1	4753	457	95	1	3	4	100.00	287.81	2022-01-06 00:00:00
139	139	1	4521	457	95	1	3	4	10.00	0.01	2021-05-19 00:00:00
140	140	1	4553	457	95	1	3	1	100.00	0.01	2021-06-20 00:00:00
141	141	1	4537	457	95	1	3	8	34.00	204.32	2021-06-04 00:00:00
142	142	1	4791	457	95	1	3	1	85.00	0.01	2022-02-13 00:00:00
143	143	1	4706	457	95	1	3	9	41.00	250.58	2021-11-20 00:00:00
144	144	1	4691	457	95	1	3	4	850.00	3338.04	2021-11-05 00:00:00
145	145	1	4679	457	95	1	3	6	90.00	312.17	2021-10-24 00:00:00
146	146	1	4709	457	95	1	3	3	350.00	896.78	2021-11-23 00:00:00
147	147	1	4897	457	95	1	3	3	1699.99	4849.68	2022-05-30 00:00:00
148	148	1	4867	457	95	1	3	2	50.00	72.89	2022-04-30 00:00:00
149	149	1	4795	457	95	1	3	8	460.00	3501.96	2022-02-17 00:00:00
150	150	1	4649	457	95	1	3	7	72.00	402.73	2021-09-24 00:00:00
151	151	1	4631	457	95	1	3	2	85.00	87.96	2021-09-06 00:00:00
152	152	1	4834	457	95	1	3	7	690.00	4684.47	2022-03-28 00:00:00
153	153	1	4457	457	95	1	3	7	200.00	1146.49	2021-03-16 00:00:00
154	154	1	4837	457	95	1	3	2	100.00	0.01	2022-03-31 00:00:00
155	155	1	4518	457	95	1	3	5	1699.99	8376.89	2021-05-16 00:00:00
156	156	1	4418	457	95	1	3	7	510.00	3412.42	2021-02-05 00:00:00
157	157	1	4716	457	95	1	3	1	510.00	445.40	2021-11-30 00:00:00
158	158	1	4460	457	95	1	3	5	37.00	0.01	2021-03-19 00:00:00
159	159	1	4550	457	95	1	3	7	85.00	465.00	2021-06-17 00:00:00
160	160	1	4892	457	95	1	3	2	665.00	1296.24	2022-05-25 00:00:00
161	161	1	4562	457	95	1	3	9	490.00	4251.28	2021-06-29 00:00:00
162	162	1	4809	457	95	1	3	6	460.00	2525.93	2022-03-03 00:00:00
163	163	1	4892	457	95	1	3	9	350.00	3039.82	2022-05-25 00:00:00
164	164	1	4760	457	95	1	3	9	490.00	4317.19	2022-01-13 00:00:00
165	165	1	4676	457	95	1	3	8	850.00	6529.46	2021-10-21 00:00:00
166	166	1	4554	457	95	1	3	7	72.00	384.12	2021-06-21 00:00:00
167	167	1	4615	457	95	1	3	8	20.00	142.61	2021-08-21 00:00:00
168	168	1	4420	457	95	1	3	5	990.00	4772.11	2021-02-07 00:00:00
169	169	1	4855	457	95	1	3	9	500.00	4212.16	2022-04-18 00:00:00
170	170	1	4514	457	95	1	3	5	299.99	1454.38	2021-05-12 00:00:00
171	171	1	4563	457	95	1	3	4	290.00	911.67	2021-06-30 00:00:00
172	172	1	4420	457	95	1	3	9	50.00	345.75	2021-02-07 00:00:00
173	173	1	4534	457	95	1	3	9	46.00	216.01	2021-06-01 00:00:00
174	174	1	4635	457	95	1	3	3	249.99	502.00	2021-09-10 00:00:00
175	175	1	4730	457	95	1	3	1	37.00	0.01	2021-12-14 00:00:00
176	176	1	4793	457	95	1	3	5	90.00	258.81	2022-02-15 00:00:00
177	177	1	4891	457	95	1	3	8	60.00	275.18	2022-05-24 00:00:00
178	178	1	4832	457	95	1	3	8	1490.00	11833.56	2022-03-26 00:00:00
179	179	1	4614	457	95	1	3	2	350.00	529.94	2021-08-20 00:00:00
180	180	1	4800	457	95	1	3	5	29.00	0.01	2022-02-22 00:00:00
181	181	1	4624	457	95	1	3	9	22.00	58.84	2021-08-30 00:00:00
182	182	1	4532	457	95	1	3	5	460.00	2285.39	2021-05-30 00:00:00
183	183	1	4594	457	95	1	3	2	200.00	287.85	2021-07-31 00:00:00
184	184	1	4546	457	95	1	3	10	249.99	2438.75	2021-06-13 00:00:00
185	185	1	4606	457	95	1	3	5	100.00	334.81	2021-08-12 00:00:00
186	186	1	4573	457	95	1	3	4	290.00	1062.80	2021-07-10 00:00:00
187	187	1	4605	457	95	1	3	8	1699.99	13449.43	2021-08-11 00:00:00
188	188	1	4900	457	95	1	3	2	390.00	523.77	2022-06-02 00:00:00
189	189	1	4831	457	95	1	3	4	1490.00	5959.62	2022-03-25 00:00:00
190	190	1	4569	457	95	1	3	7	20.00	125.39	2021-07-06 00:00:00
191	191	1	4802	457	95	1	3	6	1700.00	10066.94	2022-02-24 00:00:00
192	192	1	4609	457	95	1	3	7	400.00	2625.14	2021-08-15 00:00:00
193	193	1	4507	457	95	1	3	7	500.00	3247.57	2021-05-05 00:00:00
194	194	1	4466	457	95	1	3	5	690.00	3436.48	2021-03-25 00:00:00
195	195	1	4459	457	95	1	3	3	1490.00	4267.95	2021-03-18 00:00:00
196	196	1	4730	457	95	1	3	4	100.00	324.39	2021-12-14 00:00:00
197	197	1	4633	457	95	1	3	1	22.00	0.01	2021-09-08 00:00:00
198	198	1	4823	457	95	1	3	9	290.00	2407.33	2022-03-17 00:00:00
199	199	1	4747	457	95	1	3	8	460.00	3519.68	2021-12-31 00:00:00
200	200	1	4914	457	95	1	3	9	400.00	3316.01	2022-06-16 00:00:00
201	201	1	4750	457	95	1	3	4	420.00	1598.79	2022-01-03 00:00:00
202	202	1	4615	457	95	1	3	1	50.00	0.01	2021-08-21 00:00:00
203	203	1	4781	457	95	1	3	10	2490.00	24788.86	2022-02-03 00:00:00
204	204	1	4708	457	95	1	3	5	420.00	2078.45	2021-11-22 00:00:00
205	205	1	4570	457	95	1	3	8	46.00	97.19	2021-07-07 00:00:00
206	206	1	4482	457	95	1	3	4	90.00	105.48	2021-04-10 00:00:00
207	207	1	4748	457	95	1	3	3	1700.00	4872.96	2022-01-01 00:00:00
208	208	1	4524	457	95	1	3	9	200.00	1653.51	2021-05-22 00:00:00
209	209	1	4615	457	95	1	3	2	990.00	1794.41	2021-08-21 00:00:00
210	210	1	4668	457	95	1	3	6	1700.00	10154.53	2021-10-13 00:00:00
211	211	1	4636	457	95	1	3	10	22.00	93.61	2021-09-11 00:00:00
212	212	1	4906	457	95	1	3	1	500.00	393.54	2022-06-08 00:00:00
213	213	1	4798	457	95	1	3	3	850.00	2325.17	2022-02-20 00:00:00
214	214	1	4412	457	95	1	3	10	46.00	227.38	2021-01-30 00:00:00
215	215	1	4753	457	95	1	3	4	390.00	1321.17	2022-01-06 00:00:00
216	216	1	4676	457	95	1	3	1	2490.00	2344.30	2021-10-21 00:00:00
217	217	1	4589	457	95	1	3	5	90.00	386.73	2021-07-26 00:00:00
218	218	1	4608	457	95	1	3	8	90.00	420.91	2021-08-14 00:00:00
219	219	1	4422	457	95	1	3	9	390.00	3368.14	2021-02-09 00:00:00
220	220	1	4762	457	95	1	3	7	93.00	456.63	2022-01-15 00:00:00
221	221	1	4738	457	95	1	3	10	460.00	4563.44	2021-12-22 00:00:00
222	222	1	4568	457	95	1	3	10	72.00	423.40	2021-07-05 00:00:00
223	223	1	4736	457	95	1	3	1	390.00	267.62	2021-12-20 00:00:00
224	224	1	4607	457	95	1	3	10	249.99	2442.49	2021-08-13 00:00:00
225	225	1	4906	457	95	1	3	10	249.99	2303.07	2022-06-08 00:00:00
226	226	1	4762	457	95	1	3	1	1890.00	1720.09	2022-01-15 00:00:00
227	227	1	4883	457	95	1	3	9	300.00	2491.97	2022-05-16 00:00:00
228	228	1	4678	457	95	1	3	9	41.00	103.63	2021-10-23 00:00:00
229	229	1	4797	457	95	1	3	8	249.99	1780.20	2022-02-19 00:00:00
230	230	1	4645	457	95	1	3	10	20.00	74.47	2021-09-20 00:00:00
231	231	1	4856	457	95	1	3	3	50.00	0.01	2022-04-19 00:00:00
232	232	1	4762	457	95	1	3	6	400.00	2104.19	2022-01-15 00:00:00
233	233	1	4516	457	95	1	3	8	62.00	331.14	2021-05-14 00:00:00
234	234	1	4624	457	95	1	3	1	420.00	161.95	2021-08-30 00:00:00
235	235	1	4582	457	95	1	3	8	665.00	5225.85	2021-07-19 00:00:00
236	236	1	4398	457	95	1	3	4	300.00	1103.50	2021-01-16 00:00:00
237	237	1	4512	457	95	1	3	9	1390.00	12339.51	2021-05-10 00:00:00
238	238	1	4649	457	95	1	3	1	249.99	48.27	2021-09-24 00:00:00
239	239	1	4480	457	95	1	3	2	93.00	67.77	2021-04-08 00:00:00
240	240	1	4564	457	95	1	3	9	450.00	3968.06	2021-07-01 00:00:00
241	241	1	4384	457	95	1	3	4	22.00	0.01	2021-01-02 00:00:00
242	242	1	4884	457	95	1	3	9	690.00	6016.69	2022-05-17 00:00:00
243	243	1	4792	457	95	1	3	7	249.99	1451.30	2022-02-14 00:00:00
244	244	1	4442	457	95	1	3	1	1700.00	1423.80	2021-03-01 00:00:00
245	245	1	4639	457	95	1	3	2	90.00	0.01	2021-09-14 00:00:00
246	246	1	4798	457	95	1	3	9	29.00	247.03	2022-02-20 00:00:00
247	247	1	4614	457	95	1	3	5	100.00	438.50	2021-08-20 00:00:00
248	248	1	4387	457	95	1	3	8	690.00	5519.94	2021-01-05 00:00:00
249	249	1	4425	457	95	1	3	5	41.00	0.01	2021-02-12 00:00:00
250	250	1	4796	457	95	1	3	4	510.00	1925.50	2022-02-18 00:00:00
251	251	1	4535	457	95	1	3	7	62.00	364.54	2021-06-02 00:00:00
252	252	1	4912	457	95	1	3	2	299.99	351.80	2022-06-14 00:00:00
253	253	1	4397	457	95	1	3	8	100.00	630.48	2021-01-15 00:00:00
254	254	1	4427	457	95	1	3	6	100.00	346.52	2021-02-14 00:00:00
255	255	1	4576	457	95	1	3	2	1490.00	2729.79	2021-07-13 00:00:00
256	256	1	4865	457	95	1	3	8	72.00	397.09	2022-04-28 00:00:00
257	257	1	4545	457	95	1	3	1	41.00	0.01	2021-06-12 00:00:00
258	258	1	4744	457	95	1	3	9	290.00	2413.29	2021-12-28 00:00:00
259	259	1	4826	457	95	1	3	1	1890.00	1819.69	2022-03-20 00:00:00
260	260	1	4656	457	95	1	3	2	93.00	3.24	2021-10-01 00:00:00
261	261	1	4428	457	95	1	3	7	460.00	3149.29	2021-02-15 00:00:00
262	262	1	4622	457	95	1	3	2	100.00	0.01	2021-08-28 00:00:00
263	263	1	4521	457	95	1	3	4	46.00	0.01	2021-05-19 00:00:00
264	264	1	4646	457	95	1	3	9	299.99	2660.91	2021-09-21 00:00:00
265	265	1	4550	457	95	1	3	6	850.00	4813.56	2021-06-17 00:00:00
266	266	1	4892	457	95	1	3	1	300.00	250.03	2022-05-25 00:00:00
267	267	1	4552	457	95	1	3	8	460.00	3418.77	2021-06-19 00:00:00
268	268	1	4705	457	95	1	3	7	62.00	306.82	2021-11-19 00:00:00
269	269	1	4719	457	95	1	3	8	100.00	563.50	2021-12-03 00:00:00
270	270	1	4888	457	95	1	3	4	1390.00	5382.75	2022-05-21 00:00:00
271	271	1	4828	457	95	1	3	6	34.00	73.17	2022-03-22 00:00:00
272	272	1	4676	457	95	1	3	4	550.00	1980.47	2021-10-21 00:00:00
273	273	1	4440	457	95	1	3	5	899.99	4275.35	2021-02-27 00:00:00
274	274	1	4672	457	95	1	3	3	60.00	0.01	2021-10-17 00:00:00
275	275	1	4386	457	95	1	3	9	34.00	176.11	2021-01-04 00:00:00
276	276	1	4695	457	95	1	3	7	450.00	3015.45	2021-11-09 00:00:00
277	277	1	4876	457	95	1	3	3	1490.00	4441.51	2022-05-09 00:00:00
278	278	1	4649	457	95	1	3	2	10.00	0.01	2021-09-24 00:00:00
279	279	1	4548	457	95	1	3	7	500.00	3295.93	2021-06-15 00:00:00
280	280	1	4586	457	95	1	3	6	1490.00	8680.43	2021-07-23 00:00:00
281	281	1	4585	457	95	1	3	8	1699.99	13520.12	2021-07-22 00:00:00
282	282	1	4668	457	95	1	3	7	60.00	250.73	2021-10-13 00:00:00
283	283	1	4436	457	95	1	3	7	20.00	0.01	2021-02-23 00:00:00
284	284	1	4884	457	95	1	3	9	850.00	7368.47	2022-05-17 00:00:00
285	285	1	4772	457	95	1	3	9	665.00	5832.46	2022-01-25 00:00:00
286	286	1	4589	457	95	1	3	8	100.00	582.54	2021-07-26 00:00:00
287	287	1	4761	457	95	1	3	10	400.00	3767.90	2022-01-14 00:00:00
288	288	1	4818	457	95	1	3	10	300.00	2800.46	2022-03-12 00:00:00
289	289	1	4547	457	95	1	3	7	249.99	1538.12	2021-06-14 00:00:00
290	290	1	4595	457	95	1	3	9	34.00	270.26	2021-08-01 00:00:00
291	291	1	4874	457	95	1	3	7	22.00	98.71	2022-05-07 00:00:00
292	292	1	4687	457	95	1	3	4	550.00	2066.98	2021-11-01 00:00:00
293	293	1	4846	457	95	1	3	6	85.00	305.15	2022-04-09 00:00:00
294	294	1	4425	457	95	1	3	2	90.00	27.44	2021-02-12 00:00:00
295	295	1	4886	457	95	1	3	8	41.00	136.98	2022-05-19 00:00:00
296	296	1	4658	457	95	1	3	7	550.00	3829.01	2021-10-03 00:00:00
297	297	1	4713	457	95	1	3	7	290.00	2027.13	2021-11-27 00:00:00
298	298	1	4510	457	95	1	3	6	10.00	0.01	2021-05-08 00:00:00
299	299	1	4855	457	95	1	3	2	420.00	671.04	2022-04-18 00:00:00
300	300	1	4394	457	95	1	3	10	62.00	421.47	2021-01-12 00:00:00
301	301	1	4706	457	95	1	3	8	1490.00	11726.62	2021-11-20 00:00:00
302	302	1	4608	457	95	1	3	6	46.00	185.32	2021-08-14 00:00:00
303	303	1	4453	457	95	1	3	4	899.99	3324.84	2021-03-12 00:00:00
304	304	1	4596	457	95	1	3	5	390.00	1742.45	2021-08-02 00:00:00
305	305	1	4478	457	95	1	3	7	899.99	6203.28	2021-04-06 00:00:00
306	306	1	4462	457	95	1	3	3	300.00	742.40	2021-03-21 00:00:00
307	307	1	4490	457	95	1	3	8	37.00	115.80	2021-04-18 00:00:00
308	308	1	4529	457	95	1	3	1	249.99	79.77	2021-05-27 00:00:00
309	309	1	4459	457	95	1	3	2	72.00	38.52	2021-03-18 00:00:00
310	310	1	4854	457	95	1	3	9	37.00	305.92	2022-04-17 00:00:00
311	311	1	4464	457	95	1	3	4	62.00	71.72	2021-03-23 00:00:00
312	312	1	4511	457	95	1	3	6	100.00	528.29	2021-05-09 00:00:00
313	313	1	4738	457	95	1	3	8	1890.00	14932.78	2021-12-22 00:00:00
314	314	1	4696	457	95	1	3	4	420.00	1551.36	2021-11-10 00:00:00
315	315	1	4666	457	95	1	3	5	249.99	1103.98	2021-10-11 00:00:00
316	316	1	4831	457	95	1	3	5	510.00	2436.96	2022-03-25 00:00:00
317	317	1	4558	457	95	1	3	9	50.00	402.49	2021-06-25 00:00:00
318	318	1	4888	457	95	1	3	8	1890.00	14906.20	2022-05-21 00:00:00
319	319	1	4559	457	95	1	3	6	460.00	2669.97	2021-06-26 00:00:00
320	320	1	4832	457	95	1	3	6	299.99	1683.49	2022-03-26 00:00:00
321	321	1	4464	457	95	1	3	2	90.00	143.94	2021-03-23 00:00:00
322	322	1	4541	457	95	1	3	3	899.99	2588.13	2021-06-08 00:00:00
323	323	1	4820	457	95	1	3	3	420.00	1194.47	2022-03-14 00:00:00
324	324	1	4412	457	95	1	3	10	490.00	4816.84	2021-01-30 00:00:00
325	325	1	4784	457	95	1	3	8	690.00	5254.20	2022-02-06 00:00:00
326	326	1	4795	457	95	1	3	6	350.00	2074.67	2022-02-17 00:00:00
327	327	1	4815	457	95	1	3	10	665.00	6377.97	2022-03-09 00:00:00
328	328	1	4724	457	95	1	3	3	41.00	114.77	2021-12-08 00:00:00
329	329	1	4854	457	95	1	3	8	34.00	221.11	2022-04-17 00:00:00
330	330	1	4876	457	95	1	3	8	690.00	5386.07	2022-05-09 00:00:00
331	331	1	4716	457	95	1	3	8	85.00	632.25	2021-11-30 00:00:00
332	332	1	4569	457	95	1	3	5	62.00	104.24	2021-07-06 00:00:00
333	333	1	4892	457	95	1	3	2	500.00	832.55	2022-05-25 00:00:00
334	334	1	4743	457	95	1	3	1	990.00	924.27	2021-12-27 00:00:00
335	335	1	4724	457	95	1	3	1	1490.00	1237.56	2021-12-08 00:00:00
336	336	1	4609	457	95	1	3	8	100.00	650.75	2021-08-15 00:00:00
337	337	1	4684	457	95	1	3	10	500.00	4843.27	2021-10-29 00:00:00
338	338	1	4699	457	95	1	3	2	510.00	901.93	2021-11-13 00:00:00
339	339	1	4549	457	95	1	3	2	85.00	68.07	2021-06-16 00:00:00
340	340	1	4776	457	95	1	3	2	46.00	0.01	2022-01-29 00:00:00
341	341	1	4809	457	95	1	3	7	420.00	2740.21	2022-03-03 00:00:00
342	342	1	4697	457	95	1	3	1	249.99	0.01	2021-11-11 00:00:00
343	343	1	4737	457	95	1	3	8	299.99	2158.65	2021-12-21 00:00:00
344	344	1	4482	457	95	1	3	4	100.00	115.96	2021-04-10 00:00:00
345	345	1	4482	457	95	1	3	10	450.00	4214.78	2021-04-10 00:00:00
346	346	1	4659	457	95	1	3	7	420.00	2646.54	2021-10-04 00:00:00
347	347	1	4428	457	95	1	3	5	550.00	2552.45	2021-02-15 00:00:00
348	348	1	4582	457	95	1	3	9	22.00	0.01	2021-07-19 00:00:00
349	349	1	4411	457	95	1	3	6	850.00	4938.75	2021-01-29 00:00:00
350	350	1	4520	457	95	1	3	10	420.00	4133.28	2021-05-18 00:00:00
351	351	1	4535	457	95	1	3	9	37.00	137.83	2021-06-02 00:00:00
352	352	1	4665	457	95	1	3	4	450.00	1581.72	2021-10-10 00:00:00
353	353	1	4586	457	95	1	3	3	665.00	1797.88	2021-07-23 00:00:00
354	354	1	4613	457	95	1	3	6	510.00	2877.05	2021-08-19 00:00:00
355	355	1	4517	457	95	1	3	9	2490.00	22321.10	2021-05-15 00:00:00
356	356	1	4761	457	95	1	3	6	550.00	3225.26	2022-01-14 00:00:00
357	357	1	4622	457	95	1	3	1	60.00	0.01	2021-08-28 00:00:00
358	358	1	4558	457	95	1	3	8	90.00	501.02	2021-06-25 00:00:00
359	359	1	4563	457	95	1	3	4	72.00	166.52	2021-06-30 00:00:00
360	360	1	4621	457	95	1	3	10	100.00	916.51	2021-08-27 00:00:00
361	361	1	4546	457	95	1	3	8	37.00	109.24	2021-06-13 00:00:00
362	362	1	4396	457	95	1	3	10	60.00	536.88	2021-01-14 00:00:00
363	363	1	4641	457	95	1	3	1	50.00	0.01	2021-09-16 00:00:00
364	364	1	4823	457	95	1	3	5	100.00	358.58	2022-03-17 00:00:00
365	365	1	4437	457	95	1	3	2	50.00	42.78	2021-02-24 00:00:00
366	366	1	4854	457	95	1	3	7	290.00	1856.95	2022-04-17 00:00:00
367	367	1	4651	457	95	1	3	1	46.00	0.01	2021-09-26 00:00:00
368	368	1	4716	457	95	1	3	9	249.99	2129.06	2021-11-30 00:00:00
369	369	1	4537	457	95	1	3	6	249.99	1228.31	2021-06-04 00:00:00
370	370	1	4830	457	95	1	3	5	249.99	1065.26	2022-03-24 00:00:00
371	371	1	4455	457	95	1	3	2	490.00	843.71	2021-03-14 00:00:00
372	372	1	4798	457	95	1	3	2	899.99	1661.93	2022-02-20 00:00:00
373	373	1	4679	457	95	1	3	4	85.00	126.15	2021-10-24 00:00:00
374	374	1	4491	457	95	1	3	8	899.99	7193.85	2021-04-19 00:00:00
375	375	1	4701	457	95	1	3	9	300.00	2629.99	2021-11-15 00:00:00
376	376	1	4398	457	95	1	3	9	46.00	118.57	2021-01-16 00:00:00
377	377	1	4914	457	95	1	3	3	400.00	1144.15	2022-06-16 00:00:00
378	378	1	4415	457	95	1	3	5	249.99	1147.50	2021-02-02 00:00:00
379	379	1	4886	457	95	1	3	10	60.00	467.68	2022-05-19 00:00:00
380	380	1	4865	457	95	1	3	5	62.00	183.37	2022-04-28 00:00:00
381	381	1	4433	457	95	1	3	7	450.00	3030.96	2021-02-20 00:00:00
382	382	1	4612	457	95	1	3	10	249.99	2371.94	2021-08-18 00:00:00
383	383	1	4413	457	95	1	3	7	690.00	4685.71	2021-01-31 00:00:00
384	384	1	4548	457	95	1	3	2	62.00	98.99	2021-06-15 00:00:00
385	385	1	4544	457	95	1	3	9	300.00	2506.36	2021-06-11 00:00:00
386	386	1	4495	457	95	1	3	9	50.00	305.91	2021-04-23 00:00:00
387	387	1	4616	457	95	1	3	3	29.00	0.01	2021-08-22 00:00:00
388	388	1	4459	457	95	1	3	9	1699.99	15069.54	2021-03-18 00:00:00
389	389	1	4560	457	95	1	3	4	249.99	909.81	2021-06-27 00:00:00
390	390	1	4837	457	95	1	3	1	550.00	343.24	2022-03-31 00:00:00
391	391	1	4570	457	95	1	3	5	249.99	970.19	2021-07-07 00:00:00
392	392	1	4855	457	95	1	3	4	1700.00	6775.05	2022-04-18 00:00:00
393	393	1	4495	457	95	1	3	2	100.00	142.81	2021-04-23 00:00:00
394	394	1	4624	457	95	1	3	8	1390.00	10937.87	2021-08-30 00:00:00
395	395	1	4411	457	95	1	3	3	2490.00	7191.27	2021-01-29 00:00:00
396	396	1	4899	457	95	1	3	9	37.00	47.50	2022-06-01 00:00:00
397	397	1	4629	457	95	1	3	5	990.00	4765.25	2021-09-04 00:00:00
398	398	1	4645	457	95	1	3	6	93.00	421.29	2021-09-20 00:00:00
399	399	1	4605	457	95	1	3	9	1699.99	15115.37	2021-08-11 00:00:00
400	400	1	4681	457	95	1	3	6	93.00	339.55	2021-10-26 00:00:00
401	401	1	4398	457	95	1	3	8	299.99	2141.36	2021-01-16 00:00:00
402	402	1	4411	457	95	1	3	7	34.00	155.86	2021-01-29 00:00:00
403	403	1	4593	457	95	1	3	7	100.00	423.30	2021-07-30 00:00:00
404	404	1	4388	457	95	1	3	8	1390.00	10826.35	2021-01-06 00:00:00
405	405	1	4750	457	95	1	3	1	665.00	485.06	2022-01-03 00:00:00
406	406	1	4545	457	95	1	3	7	1699.99	11782.29	2021-06-12 00:00:00
407	407	1	4895	457	95	1	3	2	1490.00	2749.01	2022-05-28 00:00:00
408	408	1	4585	457	95	1	3	3	62.00	14.54	2021-07-22 00:00:00
409	409	1	4658	457	95	1	3	2	1490.00	2902.78	2021-10-03 00:00:00
410	410	1	4396	457	95	1	3	10	2490.00	24620.22	2021-01-14 00:00:00
411	411	1	4874	457	95	1	3	6	1890.00	11180.57	2022-05-07 00:00:00
412	412	1	4773	457	95	1	3	2	41.00	0.01	2022-01-26 00:00:00
413	413	1	4740	457	95	1	3	4	100.00	261.05	2021-12-24 00:00:00
414	414	1	4549	457	95	1	3	3	34.00	100.76	2021-06-16 00:00:00
415	415	1	4738	457	95	1	3	7	10.00	0.01	2021-12-22 00:00:00
416	416	1	4837	457	95	1	3	8	46.00	336.28	2022-03-31 00:00:00
417	417	1	4478	457	95	1	3	1	1390.00	1106.90	2021-04-06 00:00:00
418	418	1	4531	457	95	1	3	1	850.00	631.42	2021-05-29 00:00:00
419	419	1	4741	457	95	1	3	8	1699.99	13438.60	2021-12-25 00:00:00
420	420	1	4802	457	95	1	3	2	100.00	120.87	2022-02-24 00:00:00
421	421	1	4624	457	95	1	3	1	10.00	0.01	2021-08-30 00:00:00
422	422	1	4466	457	95	1	3	5	60.00	112.11	2021-03-25 00:00:00
423	423	1	4555	457	95	1	3	1	249.99	148.99	2021-06-22 00:00:00
424	424	1	4698	457	95	1	3	9	90.00	603.95	2021-11-12 00:00:00
425	425	1	4772	457	95	1	3	8	550.00	4313.88	2022-01-25 00:00:00
426	426	1	4510	457	95	1	3	4	390.00	1530.22	2021-05-08 00:00:00
427	427	1	4668	457	95	1	3	6	850.00	5001.70	2021-10-13 00:00:00
428	428	1	4520	457	95	1	3	8	490.00	3714.70	2021-05-18 00:00:00
429	429	1	4793	457	95	1	3	5	390.00	1662.34	2022-02-15 00:00:00
430	430	1	4436	457	95	1	3	8	1390.00	10946.26	2021-02-23 00:00:00
431	431	1	4697	457	95	1	3	8	10.00	58.21	2021-11-11 00:00:00
432	432	1	4848	457	95	1	3	3	400.00	1156.53	2022-04-11 00:00:00
433	433	1	4573	457	95	1	3	5	60.00	249.66	2021-07-10 00:00:00
434	434	1	4582	457	95	1	3	5	390.00	1918.15	2021-07-19 00:00:00
435	435	1	4797	457	95	1	3	7	100.00	420.54	2022-02-19 00:00:00
436	436	1	4883	457	95	1	3	4	41.00	147.89	2022-05-16 00:00:00
437	437	1	4389	457	95	1	3	3	990.00	2778.52	2021-01-07 00:00:00
438	438	1	4534	457	95	1	3	3	50.00	140.98	2021-06-01 00:00:00
439	439	1	4445	457	95	1	3	8	90.00	524.24	2021-03-04 00:00:00
440	440	1	4701	457	95	1	3	4	100.00	231.98	2021-11-15 00:00:00
441	441	1	4853	457	95	1	3	8	290.00	2084.51	2022-04-16 00:00:00
442	442	1	4585	457	95	1	3	10	100.00	986.01	2021-07-22 00:00:00
443	443	1	4816	457	95	1	3	3	300.00	825.76	2022-03-10 00:00:00
444	444	1	4682	457	95	1	3	10	1890.00	18865.74	2021-10-27 00:00:00
445	445	1	4610	457	95	1	3	8	22.00	124.46	2021-08-16 00:00:00
446	446	1	4723	457	95	1	3	4	50.00	162.08	2021-12-07 00:00:00
447	447	1	4437	457	95	1	3	6	420.00	2230.99	2021-02-24 00:00:00
448	448	1	4448	457	95	1	3	2	1390.00	2749.28	2021-03-07 00:00:00
449	449	1	4428	457	95	1	3	9	400.00	3544.92	2021-02-15 00:00:00
450	450	1	4550	457	95	1	3	4	100.00	222.25	2021-06-17 00:00:00
451	451	1	4899	457	95	1	3	7	46.00	241.33	2022-06-01 00:00:00
452	452	1	4810	457	95	1	3	2	72.00	0.01	2022-03-04 00:00:00
453	453	1	4775	457	95	1	3	5	100.00	403.25	2022-01-28 00:00:00
454	454	1	4614	457	95	1	3	6	420.00	2260.91	2021-08-20 00:00:00
455	455	1	4724	457	95	1	3	2	1390.00	2763.29	2021-12-08 00:00:00
456	456	1	4821	457	95	1	3	7	1890.00	12946.15	2022-03-15 00:00:00
457	457	1	4645	457	95	1	3	6	90.00	488.69	2021-09-20 00:00:00
458	458	1	4913	457	95	1	3	1	899.99	870.88	2022-06-15 00:00:00
459	459	1	4750	457	95	1	3	6	72.00	319.35	2022-01-03 00:00:00
460	460	1	4580	457	95	1	3	10	665.00	6528.95	2021-07-17 00:00:00
461	461	1	4761	457	95	1	3	2	899.99	1689.26	2022-01-14 00:00:00
462	462	1	4827	457	95	1	3	3	10.00	0.01	2022-03-21 00:00:00
463	463	1	4623	457	95	1	3	9	420.00	3500.15	2021-08-29 00:00:00
464	464	1	4793	457	95	1	3	3	72.00	154.81	2022-02-15 00:00:00
465	465	1	4875	457	95	1	3	1	46.00	0.01	2022-05-08 00:00:00
466	466	1	4457	457	95	1	3	1	2490.00	2260.73	2021-03-16 00:00:00
467	467	1	4411	457	95	1	3	7	41.00	7.29	2021-01-29 00:00:00
468	468	1	4534	457	95	1	3	1	500.00	285.36	2021-06-01 00:00:00
469	469	1	4760	457	95	1	3	1	2490.00	2387.85	2022-01-13 00:00:00
470	470	1	4515	457	95	1	3	5	249.99	1138.54	2021-05-13 00:00:00
471	471	1	4695	457	95	1	3	4	850.00	3271.47	2021-11-09 00:00:00
472	472	1	4888	457	95	1	3	3	10.00	0.01	2022-05-21 00:00:00
473	473	1	4411	457	95	1	3	3	50.00	27.85	2021-01-29 00:00:00
474	474	1	4563	457	95	1	3	10	390.00	3774.84	2021-06-30 00:00:00
475	475	1	4404	457	95	1	3	7	72.00	349.59	2021-01-22 00:00:00
476	476	1	4838	457	95	1	3	8	1699.99	13459.92	2022-04-01 00:00:00
477	477	1	4865	457	95	1	3	4	2490.00	9912.58	2022-04-28 00:00:00
478	478	1	4651	457	95	1	3	7	1890.00	12954.76	2021-09-26 00:00:00
479	479	1	4389	457	95	1	3	1	100.00	0.01	2021-01-07 00:00:00
480	480	1	4408	457	95	1	3	8	510.00	3947.21	2021-01-26 00:00:00
481	481	1	4738	457	95	1	3	10	400.00	3953.67	2021-12-22 00:00:00
482	482	1	4511	457	95	1	3	3	249.99	748.52	2021-05-09 00:00:00
483	483	1	4772	457	95	1	3	2	420.00	742.73	2022-01-25 00:00:00
484	484	1	4751	457	95	1	3	1	350.00	303.72	2022-01-04 00:00:00
485	485	1	4545	457	95	1	3	9	1390.00	12231.18	2021-06-12 00:00:00
486	486	1	4511	457	95	1	3	6	300.00	1626.14	2021-05-09 00:00:00
487	487	1	4646	457	95	1	3	3	390.00	1059.87	2021-09-21 00:00:00
488	488	1	4705	457	95	1	3	2	420.00	629.59	2021-11-19 00:00:00
489	489	1	4679	457	95	1	3	8	460.00	3450.27	2021-10-24 00:00:00
490	490	1	4740	457	95	1	3	10	299.99	2781.94	2021-12-24 00:00:00
491	491	1	4859	457	95	1	3	3	400.00	997.60	2022-04-22 00:00:00
492	492	1	4845	457	95	1	3	6	510.00	2963.15	2022-04-08 00:00:00
493	493	1	4883	457	95	1	3	6	20.00	0.01	2022-05-16 00:00:00
494	494	1	4638	457	95	1	3	3	665.00	1796.65	2021-09-13 00:00:00
495	495	1	4524	457	95	1	3	4	10.00	0.01	2021-05-22 00:00:00
496	496	1	4632	457	95	1	3	5	460.00	2162.72	2021-09-07 00:00:00
497	497	1	4518	457	95	1	3	7	420.00	2724.67	2021-05-16 00:00:00
498	498	1	4640	457	95	1	3	2	46.00	66.85	2021-09-15 00:00:00
499	499	1	4501	457	95	1	3	7	20.00	0.01	2021-04-29 00:00:00
500	500	1	4833	457	95	1	3	4	420.00	1560.48	2022-03-27 00:00:00
501	501	1	4876	457	95	1	3	2	300.00	528.63	2022-05-09 00:00:00
502	502	1	4560	457	95	1	3	2	200.00	223.52	2021-06-27 00:00:00
503	503	1	4711	457	95	1	3	9	290.00	2499.33	2021-11-25 00:00:00
504	504	1	4671	457	95	1	3	7	41.00	269.27	2021-10-16 00:00:00
505	505	1	4659	457	95	1	3	2	90.00	0.01	2021-10-04 00:00:00
506	506	1	4708	457	95	1	3	10	2490.00	24684.29	2021-11-22 00:00:00
507	507	1	4450	457	95	1	3	3	20.00	0.01	2021-03-09 00:00:00
508	508	1	4884	457	95	1	3	9	899.99	7975.08	2022-05-17 00:00:00
509	509	1	4546	457	95	1	3	10	400.00	3846.08	2021-06-13 00:00:00
510	510	1	4721	457	95	1	3	2	899.99	1541.98	2021-12-05 00:00:00
511	511	1	4851	457	95	1	3	9	460.00	3995.32	2022-04-14 00:00:00
512	512	1	4488	457	95	1	3	6	850.00	4976.90	2021-04-16 00:00:00
513	513	1	4875	457	95	1	3	9	20.00	74.36	2022-05-08 00:00:00
514	514	1	4915	457	95	1	3	4	2490.00	9876.33	2022-06-17 00:00:00
515	515	1	4867	457	95	1	3	8	510.00	3890.62	2022-04-30 00:00:00
516	516	1	4809	457	95	1	3	5	85.00	349.20	2022-03-03 00:00:00
517	517	1	4642	457	95	1	3	3	22.00	0.01	2021-09-17 00:00:00
518	518	1	4427	457	95	1	3	8	29.00	0.01	2021-02-14 00:00:00
519	519	1	4709	457	95	1	3	4	300.00	1135.65	2021-11-23 00:00:00
520	520	1	4677	457	95	1	3	3	50.00	0.01	2021-10-22 00:00:00
521	521	1	4466	457	95	1	3	1	10.00	0.01	2021-03-25 00:00:00
522	522	1	4420	457	95	1	3	7	300.00	1948.76	2021-02-07 00:00:00
523	523	1	4462	457	95	1	3	7	100.00	520.76	2021-03-21 00:00:00
524	524	1	4562	457	95	1	3	6	46.00	0.01	2021-06-29 00:00:00
525	525	1	4669	457	95	1	3	9	20.00	0.01	2021-10-14 00:00:00
526	526	1	4843	457	95	1	3	9	400.00	3326.50	2022-04-06 00:00:00
527	527	1	4387	457	95	1	3	10	665.00	6453.15	2021-01-05 00:00:00
528	528	1	4633	457	95	1	3	4	93.00	351.43	2021-09-08 00:00:00
529	529	1	4600	457	95	1	3	6	299.99	1757.97	2021-08-06 00:00:00
530	530	1	4413	457	95	1	3	8	450.00	3357.15	2021-01-31 00:00:00
531	531	1	4796	457	95	1	3	10	1490.00	14684.32	2022-02-18 00:00:00
532	532	1	4466	457	95	1	3	4	690.00	2710.97	2021-03-25 00:00:00
533	533	1	4730	457	95	1	3	4	10.00	0.01	2021-12-14 00:00:00
534	534	1	4688	457	95	1	3	4	1700.00	6670.91	2021-11-02 00:00:00
535	535	1	4386	457	95	1	3	5	249.99	990.87	2021-01-04 00:00:00
536	536	1	4797	457	95	1	3	2	20.00	0.01	2022-02-19 00:00:00
537	537	1	4863	457	95	1	3	6	899.99	5164.57	2022-04-26 00:00:00
538	538	1	4513	457	95	1	3	7	22.00	77.54	2021-05-11 00:00:00
539	539	1	4831	457	95	1	3	2	299.99	337.59	2022-03-25 00:00:00
540	540	1	4774	457	95	1	3	7	41.00	204.67	2022-01-27 00:00:00
541	541	1	4611	457	95	1	3	6	490.00	2711.67	2021-08-17 00:00:00
542	542	1	4744	457	95	1	3	5	1390.00	6666.46	2021-12-28 00:00:00
543	543	1	4425	457	95	1	3	8	420.00	3090.49	2021-02-12 00:00:00
544	544	1	4793	457	95	1	3	4	10.00	0.01	2022-02-15 00:00:00
545	545	1	4675	457	95	1	3	6	420.00	2220.31	2021-10-20 00:00:00
546	546	1	4578	457	95	1	3	10	500.00	4745.16	2021-07-15 00:00:00
547	547	1	4547	457	95	1	3	1	10.00	0.01	2021-06-14 00:00:00
548	548	1	4775	457	95	1	3	9	249.99	2128.29	2022-01-28 00:00:00
549	549	1	4852	457	95	1	3	7	20.00	0.01	2022-04-15 00:00:00
550	550	1	4743	457	95	1	3	6	290.00	1563.02	2021-12-27 00:00:00
551	551	1	4686	457	95	1	3	2	93.00	93.62	2021-10-31 00:00:00
552	552	1	4633	457	95	1	3	8	990.00	7663.43	2021-09-08 00:00:00
553	553	1	4546	457	95	1	3	8	350.00	2652.43	2021-06-13 00:00:00
554	554	1	4874	457	95	1	3	3	420.00	1035.50	2022-05-07 00:00:00
555	555	1	4886	457	95	1	3	4	200.00	599.26	2022-05-19 00:00:00
556	556	1	4883	457	95	1	3	8	299.99	2268.28	2022-05-16 00:00:00
557	557	1	4451	457	95	1	3	2	90.00	82.69	2021-03-10 00:00:00
558	558	1	4522	457	95	1	3	1	300.00	93.52	2021-05-20 00:00:00
559	559	1	4788	457	95	1	3	1	22.00	3.44	2022-02-10 00:00:00
560	560	1	4490	457	95	1	3	9	450.00	3978.58	2021-04-18 00:00:00
561	561	1	4577	457	95	1	3	7	249.99	1729.06	2021-07-14 00:00:00
562	562	1	4875	457	95	1	3	9	300.00	2471.78	2022-05-08 00:00:00
563	563	1	4784	457	95	1	3	7	29.00	111.86	2022-02-06 00:00:00
564	564	1	4913	457	95	1	3	2	290.00	399.70	2022-06-15 00:00:00
565	565	1	4509	457	95	1	3	8	34.00	204.92	2021-05-07 00:00:00
566	566	1	4741	457	95	1	3	10	62.00	515.38	2021-12-25 00:00:00
567	567	1	4584	457	95	1	3	7	34.00	212.66	2021-07-21 00:00:00
568	568	1	4570	457	95	1	3	4	299.99	1016.86	2021-07-07 00:00:00
569	569	1	4912	457	95	1	3	6	200.00	1147.10	2022-06-14 00:00:00
570	570	1	4560	457	95	1	3	2	249.99	443.28	2021-06-27 00:00:00
571	571	1	4823	457	95	1	3	2	46.00	0.01	2022-03-17 00:00:00
572	572	1	4498	457	95	1	3	4	46.00	47.70	2021-04-26 00:00:00
573	573	1	4720	457	95	1	3	6	1890.00	11271.05	2021-12-04 00:00:00
574	574	1	4681	457	95	1	3	2	1700.00	3187.16	2021-10-26 00:00:00
575	575	1	4878	457	95	1	3	1	420.00	254.76	2022-05-11 00:00:00
576	576	1	4577	457	95	1	3	5	420.00	1843.20	2021-07-14 00:00:00
577	577	1	4636	457	95	1	3	2	46.00	0.01	2021-09-11 00:00:00
578	578	1	4590	457	95	1	3	10	2490.00	24857.51	2021-07-27 00:00:00
579	579	1	4451	457	95	1	3	10	390.00	3629.06	2021-03-10 00:00:00
580	580	1	4823	457	95	1	3	1	50.00	0.01	2022-03-17 00:00:00
581	581	1	4839	457	95	1	3	8	46.00	74.06	2022-04-02 00:00:00
582	582	1	4398	457	95	1	3	4	37.00	0.01	2021-01-16 00:00:00
583	583	1	4384	457	95	1	3	10	100.00	984.62	2021-01-02 00:00:00
584	584	1	4840	457	95	1	3	1	37.00	0.01	2022-04-03 00:00:00
585	585	1	4450	457	95	1	3	8	34.00	0.01	2021-03-09 00:00:00
586	586	1	4716	457	95	1	3	2	2490.00	4718.02	2021-11-30 00:00:00
587	587	1	4494	457	95	1	3	9	100.00	766.57	2021-04-22 00:00:00
588	588	1	4794	457	95	1	3	8	249.99	1856.40	2022-02-16 00:00:00
589	589	1	4460	457	95	1	3	8	290.00	2059.68	2021-03-19 00:00:00
590	590	1	4582	457	95	1	3	8	100.00	508.05	2021-07-19 00:00:00
591	591	1	4742	457	95	1	3	10	850.00	8261.92	2021-12-26 00:00:00
592	592	1	4554	457	95	1	3	2	100.00	0.01	2021-06-21 00:00:00
593	593	1	4895	457	95	1	3	9	34.00	154.47	2022-05-28 00:00:00
594	594	1	4878	457	95	1	3	7	1390.00	9496.31	2022-05-11 00:00:00
595	595	1	4892	457	95	1	3	6	90.00	361.56	2022-05-25 00:00:00
596	596	1	4488	457	95	1	3	7	1699.99	11826.00	2021-04-16 00:00:00
597	597	1	4405	457	95	1	3	6	90.00	434.89	2021-01-23 00:00:00
598	598	1	4744	457	95	1	3	10	29.00	287.93	2021-12-28 00:00:00
599	599	1	4450	457	95	1	3	6	60.00	236.02	2021-03-09 00:00:00
600	600	1	4649	457	95	1	3	5	420.00	1973.50	2021-09-24 00:00:00
601	601	1	4876	457	95	1	3	4	460.00	1799.47	2022-05-09 00:00:00
602	602	1	4711	457	95	1	3	9	300.00	2583.33	2021-11-25 00:00:00
603	603	1	4800	457	95	1	3	8	490.00	3887.24	2022-02-22 00:00:00
604	604	1	4636	457	95	1	3	6	200.00	1122.68	2021-09-11 00:00:00
605	605	1	4466	457	95	1	3	3	90.00	170.34	2021-03-25 00:00:00
606	606	1	4627	457	95	1	3	9	550.00	4925.73	2021-09-02 00:00:00
607	607	1	4795	457	95	1	3	3	72.00	105.30	2022-02-17 00:00:00
608	608	1	4589	457	95	1	3	8	899.99	6971.26	2021-07-26 00:00:00
609	609	1	4434	457	95	1	3	10	34.00	59.40	2021-02-21 00:00:00
610	610	1	4873	457	95	1	3	2	249.99	342.61	2022-05-06 00:00:00
611	611	1	4730	457	95	1	3	6	20.00	0.01	2021-12-14 00:00:00
612	612	1	4675	457	95	1	3	7	420.00	2709.83	2021-10-20 00:00:00
613	613	1	4555	457	95	1	3	1	1490.00	1281.31	2021-06-22 00:00:00
614	614	1	4685	457	95	1	3	10	550.00	5486.57	2021-10-30 00:00:00
615	615	1	4676	457	95	1	3	8	1700.00	13464.71	2021-10-21 00:00:00
616	616	1	4563	457	95	1	3	4	510.00	1945.64	2021-06-30 00:00:00
617	617	1	4692	457	95	1	3	8	990.00	7892.93	2021-11-06 00:00:00
618	618	1	4626	457	95	1	3	4	50.00	30.19	2021-09-01 00:00:00
619	619	1	4877	457	95	1	3	5	1890.00	9173.51	2022-05-10 00:00:00
620	620	1	4576	457	95	1	3	7	300.00	1968.24	2021-07-13 00:00:00
621	621	1	4482	457	95	1	3	4	100.00	157.21	2021-04-10 00:00:00
622	622	1	4442	457	95	1	3	5	450.00	2146.63	2021-03-01 00:00:00
623	623	1	4479	457	95	1	3	7	46.00	245.50	2021-04-07 00:00:00
624	624	1	4687	457	95	1	3	1	34.00	0.01	2021-11-01 00:00:00
625	625	1	4605	457	95	1	3	10	390.00	3688.97	2021-08-11 00:00:00
626	626	1	4843	457	95	1	3	6	200.00	1174.56	2022-04-06 00:00:00
627	627	1	4413	457	95	1	3	1	46.00	0.01	2021-01-31 00:00:00
628	628	1	4696	457	95	1	3	6	34.00	124.88	2021-11-10 00:00:00
629	629	1	4553	457	95	1	3	2	34.00	0.01	2021-06-20 00:00:00
630	630	1	4394	457	95	1	3	4	460.00	1560.39	2021-01-12 00:00:00
631	631	1	4686	457	95	1	3	10	100.00	872.66	2021-10-31 00:00:00
632	632	1	4450	457	95	1	3	9	990.00	8817.16	2021-03-09 00:00:00
633	633	1	4594	457	95	1	3	1	34.00	0.01	2021-07-31 00:00:00
634	634	1	4689	457	95	1	3	7	450.00	3093.80	2021-11-03 00:00:00
635	635	1	4522	457	95	1	3	5	510.00	2381.92	2021-05-20 00:00:00
636	636	1	4877	457	95	1	3	10	41.00	140.87	2022-05-10 00:00:00
637	637	1	4668	457	95	1	3	3	34.00	61.94	2021-10-13 00:00:00
638	638	1	4677	457	95	1	3	7	90.00	410.58	2021-10-22 00:00:00
639	639	1	4537	457	95	1	3	8	350.00	2554.42	2021-06-04 00:00:00
640	640	1	4606	457	95	1	3	2	690.00	1307.36	2021-08-12 00:00:00
641	641	1	4849	457	95	1	3	3	34.00	80.84	2022-04-12 00:00:00
642	642	1	4464	457	95	1	3	7	34.00	0.01	2021-03-23 00:00:00
643	643	1	4701	457	95	1	3	3	10.00	0.01	2021-11-15 00:00:00
644	644	1	4824	457	95	1	3	8	299.99	2312.85	2022-03-18 00:00:00
645	645	1	4531	457	95	1	3	4	29.00	0.01	2021-05-29 00:00:00
646	646	1	4459	457	95	1	3	5	93.00	319.65	2021-03-18 00:00:00
647	647	1	4740	457	95	1	3	4	62.00	155.18	2021-12-24 00:00:00
648	648	1	4389	457	95	1	3	3	2490.00	7206.21	2021-01-07 00:00:00
649	649	1	4413	457	95	1	3	5	2490.00	12381.98	2021-01-31 00:00:00
650	650	1	4524	457	95	1	3	6	420.00	2272.60	2021-05-22 00:00:00
651	651	1	4516	457	95	1	3	10	249.99	2409.59	2021-05-14 00:00:00
652	652	1	4418	457	95	1	3	7	100.00	507.88	2021-02-05 00:00:00
653	653	1	4530	457	95	1	3	2	1699.99	3223.54	2021-05-28 00:00:00
654	654	1	4582	457	95	1	3	6	290.00	1623.74	2021-07-19 00:00:00
655	655	1	4457	457	95	1	3	10	34.00	44.37	2021-03-16 00:00:00
656	656	1	4898	457	95	1	3	1	450.00	302.17	2022-05-31 00:00:00
657	657	1	4691	457	95	1	3	1	299.99	176.09	2021-11-05 00:00:00
658	658	1	4873	457	95	1	3	9	1490.00	13160.21	2022-05-06 00:00:00
659	659	1	4610	457	95	1	3	4	50.00	105.75	2021-08-16 00:00:00
660	660	1	4652	457	95	1	3	1	10.00	0.01	2021-09-27 00:00:00
661	661	1	4418	457	95	1	3	6	420.00	2268.45	2021-02-05 00:00:00
662	662	1	4651	457	95	1	3	10	10.00	54.26	2021-09-26 00:00:00
663	663	1	4646	457	95	1	3	7	90.00	490.25	2021-09-21 00:00:00
664	664	1	4843	457	95	1	3	4	93.00	84.73	2022-04-06 00:00:00
665	665	1	4699	457	95	1	3	1	1700.00	1570.88	2021-11-13 00:00:00
666	666	1	4413	457	95	1	3	10	490.00	4760.10	2021-01-31 00:00:00
667	667	1	4408	457	95	1	3	9	249.99	2112.23	2021-01-26 00:00:00
668	668	1	4865	457	95	1	3	4	249.99	869.43	2022-04-28 00:00:00
669	669	1	4517	457	95	1	3	7	1890.00	13216.11	2021-05-15 00:00:00
670	670	1	4892	457	95	1	3	5	850.00	4197.98	2022-05-25 00:00:00
671	671	1	4813	457	95	1	3	4	665.00	2440.38	2022-03-07 00:00:00
672	672	1	4867	457	95	1	3	6	460.00	2606.34	2022-04-30 00:00:00
673	673	1	4559	457	95	1	3	9	420.00	3529.51	2021-06-26 00:00:00
674	674	1	4682	457	95	1	3	1	90.00	0.01	2021-10-27 00:00:00
675	675	1	4530	457	95	1	3	3	90.00	233.97	2021-05-28 00:00:00
676	676	1	4849	457	95	1	3	6	34.00	0.01	2022-04-12 00:00:00
677	677	1	4911	457	95	1	3	8	46.00	218.07	2022-06-13 00:00:00
678	678	1	4427	457	95	1	3	8	29.00	33.07	2021-02-14 00:00:00
679	679	1	4859	457	95	1	3	7	420.00	2829.69	2022-04-22 00:00:00
680	680	1	4544	457	95	1	3	10	46.00	335.07	2021-06-11 00:00:00
681	681	1	4521	457	95	1	3	10	62.00	323.37	2021-05-19 00:00:00
682	682	1	4405	457	95	1	3	2	990.00	1832.60	2021-01-23 00:00:00
683	683	1	4589	457	95	1	3	10	300.00	2848.53	2021-07-26 00:00:00
684	684	1	4698	457	95	1	3	2	1890.00	3503.38	2021-11-12 00:00:00
685	685	1	4412	457	95	1	3	5	50.00	124.90	2021-01-30 00:00:00
686	686	1	4643	457	95	1	3	1	420.00	408.99	2021-09-18 00:00:00
687	687	1	4590	457	95	1	3	10	510.00	4834.96	2021-07-27 00:00:00
688	688	1	4899	457	95	1	3	4	100.00	137.74	2022-06-01 00:00:00
689	689	1	4638	457	95	1	3	8	500.00	3995.22	2021-09-13 00:00:00
690	690	1	4422	457	95	1	3	10	20.00	183.59	2021-02-09 00:00:00
691	691	1	4547	457	95	1	3	10	20.00	0.01	2021-06-14 00:00:00
692	692	1	4784	457	95	1	3	3	62.00	94.18	2022-02-06 00:00:00
693	693	1	4709	457	95	1	3	1	899.99	645.11	2021-11-23 00:00:00
694	694	1	4442	457	95	1	3	4	490.00	1836.13	2021-03-01 00:00:00
695	695	1	4888	457	95	1	3	2	50.00	0.01	2022-05-21 00:00:00
696	696	1	4826	457	95	1	3	4	22.00	61.68	2022-03-20 00:00:00
697	697	1	4427	457	95	1	3	3	665.00	1723.71	2021-02-14 00:00:00
698	698	1	4672	457	95	1	3	9	34.00	173.05	2021-10-17 00:00:00
699	699	1	4606	457	95	1	3	5	62.00	164.26	2021-08-12 00:00:00
700	700	1	4545	457	95	1	3	2	72.00	30.81	2021-06-12 00:00:00
701	701	1	4737	457	95	1	3	3	1699.99	4902.26	2021-12-21 00:00:00
702	702	1	4569	457	95	1	3	5	85.00	398.31	2021-07-06 00:00:00
703	703	1	4397	457	95	1	3	6	22.00	36.81	2021-01-15 00:00:00
704	704	1	4554	457	95	1	3	9	420.00	3495.90	2021-06-21 00:00:00
705	705	1	4532	457	95	1	3	8	34.00	120.03	2021-05-30 00:00:00
706	706	1	4759	457	95	1	3	5	500.00	2244.87	2022-01-12 00:00:00
707	707	1	4388	457	95	1	3	9	249.99	2098.83	2021-01-06 00:00:00
708	708	1	4748	457	95	1	3	4	1699.99	6693.85	2022-01-01 00:00:00
709	709	1	4824	457	95	1	3	5	1700.00	8471.23	2022-03-18 00:00:00
710	710	1	4589	457	95	1	3	10	90.00	662.52	2021-07-26 00:00:00
711	711	1	4437	457	95	1	3	6	665.00	3910.37	2021-02-24 00:00:00
712	712	1	4546	457	95	1	3	7	420.00	2725.17	2021-06-13 00:00:00
713	713	1	4534	457	95	1	3	2	46.00	0.01	2021-06-01 00:00:00
714	714	1	4654	457	95	1	3	9	899.99	8013.08	2021-09-29 00:00:00
715	715	1	4517	457	95	1	3	7	62.00	273.48	2021-05-15 00:00:00
716	716	1	4856	457	95	1	3	7	100.00	661.97	2022-04-19 00:00:00
717	717	1	4518	457	95	1	3	3	460.00	1187.35	2021-05-16 00:00:00
718	718	1	4623	457	95	1	3	6	420.00	2385.57	2021-08-29 00:00:00
719	719	1	4396	457	95	1	3	1	300.00	251.33	2021-01-14 00:00:00
720	720	1	4896	457	95	1	3	7	100.00	563.36	2022-05-29 00:00:00
721	721	1	4820	457	95	1	3	1	90.00	78.61	2022-03-14 00:00:00
722	722	1	4384	457	95	1	3	6	200.00	1056.36	2021-01-02 00:00:00
723	723	1	4831	457	95	1	3	1	290.00	33.10	2022-03-25 00:00:00
724	724	1	4709	457	95	1	3	5	290.00	1361.98	2021-11-23 00:00:00
725	725	1	4861	457	95	1	3	4	249.99	927.56	2022-04-24 00:00:00
726	726	1	4809	457	95	1	3	7	62.00	246.74	2022-03-03 00:00:00
727	727	1	4639	457	95	1	3	9	300.00	2626.41	2021-09-14 00:00:00
728	728	1	4413	457	95	1	3	4	460.00	1595.18	2021-01-31 00:00:00
729	729	1	4551	457	95	1	3	4	29.00	97.75	2021-06-18 00:00:00
730	730	1	4867	457	95	1	3	2	100.00	0.01	2022-04-30 00:00:00
731	731	1	4759	457	95	1	3	5	100.00	213.96	2022-01-12 00:00:00
732	732	1	4675	457	95	1	3	1	85.00	0.01	2021-10-20 00:00:00
733	733	1	4411	457	95	1	3	9	50.00	193.42	2021-01-29 00:00:00
734	734	1	4614	457	95	1	3	10	200.00	1932.50	2021-08-20 00:00:00
735	735	1	4607	457	95	1	3	7	85.00	371.47	2021-08-13 00:00:00
736	736	1	4742	457	95	1	3	7	665.00	4438.36	2021-12-26 00:00:00
737	737	1	4913	457	95	1	3	8	200.00	1415.48	2022-06-15 00:00:00
738	738	1	4474	457	95	1	3	8	100.00	677.68	2021-04-02 00:00:00
739	739	1	4813	457	95	1	3	3	490.00	1280.44	2022-03-07 00:00:00
740	740	1	4478	457	95	1	3	6	46.00	136.55	2021-04-06 00:00:00
741	741	1	4858	457	95	1	3	5	20.00	0.01	2022-04-21 00:00:00
742	742	1	4757	457	95	1	3	2	60.00	0.01	2022-01-10 00:00:00
743	743	1	4520	457	95	1	3	6	37.00	0.01	2021-05-18 00:00:00
744	744	1	4587	457	95	1	3	7	200.00	1392.57	2021-07-24 00:00:00
745	745	1	4466	457	95	1	3	2	299.99	556.26	2021-03-25 00:00:00
746	746	1	4912	457	95	1	3	7	450.00	2956.41	2022-06-14 00:00:00
747	747	1	4854	457	95	1	3	8	50.00	399.42	2022-04-17 00:00:00
748	748	1	4385	457	95	1	3	6	665.00	3743.36	2021-01-03 00:00:00
749	749	1	4553	457	95	1	3	7	390.00	2715.46	2021-06-20 00:00:00
750	750	1	4534	457	95	1	3	9	34.00	65.57	2021-06-01 00:00:00
751	751	1	4659	457	95	1	3	1	90.00	0.01	2021-10-04 00:00:00
752	752	1	4551	457	95	1	3	5	1490.00	7208.63	2021-06-18 00:00:00
753	753	1	4553	457	95	1	3	10	665.00	6566.29	2021-06-20 00:00:00
754	754	1	4785	457	95	1	3	2	200.00	212.67	2022-02-07 00:00:00
755	755	1	4776	457	95	1	3	4	34.00	0.01	2022-01-29 00:00:00
756	756	1	4916	457	95	1	3	5	1700.00	8333.12	2022-06-18 00:00:00
757	757	1	4852	457	95	1	3	5	100.00	337.77	2022-04-15 00:00:00
758	758	1	4522	457	95	1	3	9	50.00	375.17	2021-05-20 00:00:00
759	759	1	4404	457	95	1	3	4	41.00	99.90	2021-01-22 00:00:00
760	760	1	4593	457	95	1	3	1	37.00	0.01	2021-07-30 00:00:00
761	761	1	4584	457	95	1	3	6	41.00	21.09	2021-07-21 00:00:00
762	762	1	4680	457	95	1	3	1	665.00	615.35	2021-10-25 00:00:00
763	763	1	4513	457	95	1	3	5	400.00	1851.11	2021-05-11 00:00:00
764	764	1	4514	457	95	1	3	1	62.00	47.00	2021-05-12 00:00:00
765	765	1	4828	457	95	1	3	9	400.00	3380.53	2022-03-22 00:00:00
766	766	1	4410	457	95	1	3	2	350.00	559.88	2021-01-28 00:00:00
767	767	1	4853	457	95	1	3	6	41.00	154.08	2022-04-16 00:00:00
768	768	1	4757	457	95	1	3	6	299.99	1578.30	2022-01-10 00:00:00
769	769	1	4812	457	95	1	3	8	72.00	562.15	2022-03-06 00:00:00
770	770	1	4595	457	95	1	3	7	899.99	6156.98	2021-08-01 00:00:00
771	771	1	4682	457	95	1	3	4	850.00	3101.31	2021-10-27 00:00:00
772	772	1	4689	457	95	1	3	2	85.00	35.88	2021-11-03 00:00:00
773	773	1	4633	457	95	1	3	8	100.00	784.40	2021-09-08 00:00:00
774	774	1	4641	457	95	1	3	5	29.00	86.76	2021-09-16 00:00:00
775	775	1	4839	457	95	1	3	2	50.00	52.60	2022-04-02 00:00:00
776	776	1	4568	457	95	1	3	10	450.00	4264.92	2021-07-05 00:00:00
777	777	1	4479	457	95	1	3	4	1700.00	6773.78	2021-04-07 00:00:00
778	778	1	4743	457	95	1	3	8	460.00	3506.60	2021-12-27 00:00:00
779	779	1	4412	457	95	1	3	6	450.00	2496.86	2021-01-30 00:00:00
780	780	1	4825	457	95	1	3	7	10.00	43.01	2022-03-19 00:00:00
781	781	1	4627	457	95	1	3	9	550.00	4794.48	2021-09-02 00:00:00
782	782	1	4857	457	95	1	3	3	510.00	1287.40	2022-04-20 00:00:00
783	783	1	4428	457	95	1	3	8	41.00	228.26	2021-02-15 00:00:00
784	784	1	4681	457	95	1	3	4	300.00	915.43	2021-10-26 00:00:00
785	785	1	4544	457	95	1	3	6	100.00	402.69	2021-06-11 00:00:00
786	786	1	4487	457	95	1	3	7	249.99	1513.60	2021-04-15 00:00:00
787	787	1	4595	457	95	1	3	7	29.00	20.78	2021-08-01 00:00:00
788	788	1	4522	457	95	1	3	7	200.00	1133.09	2021-05-20 00:00:00
789	789	1	4740	457	95	1	3	8	22.00	69.11	2021-12-24 00:00:00
790	790	1	4774	457	95	1	3	3	510.00	1473.63	2022-01-27 00:00:00
791	791	1	4858	457	95	1	3	3	29.00	20.07	2022-04-21 00:00:00
792	792	1	4384	457	95	1	3	3	460.00	1379.06	2021-01-02 00:00:00
793	793	1	4582	457	95	1	3	2	400.00	600.72	2021-07-19 00:00:00
794	794	1	4815	457	95	1	3	9	29.00	0.85	2022-03-09 00:00:00
795	795	1	4740	457	95	1	3	7	100.00	544.52	2021-12-24 00:00:00
796	796	1	4915	457	95	1	3	3	72.00	10.42	2022-06-17 00:00:00
797	797	1	4747	457	95	1	3	7	350.00	2374.89	2021-12-31 00:00:00
798	798	1	4510	457	95	1	3	9	100.00	823.58	2021-05-08 00:00:00
799	799	1	4644	457	95	1	3	5	100.00	468.67	2021-09-19 00:00:00
800	800	1	4648	457	95	1	3	9	1390.00	12249.65	2021-09-23 00:00:00
801	801	1	4424	457	95	1	3	2	46.00	89.50	2021-02-11 00:00:00
802	802	1	4694	457	95	1	3	5	420.00	1864.48	2021-11-08 00:00:00
803	803	1	4488	457	95	1	3	7	990.00	6687.24	2021-04-16 00:00:00
804	804	1	4404	457	95	1	3	8	510.00	3871.25	2021-01-22 00:00:00
805	805	1	4752	457	95	1	3	2	29.00	0.01	2022-01-05 00:00:00
806	806	1	4848	457	95	1	3	8	450.00	3419.84	2022-04-11 00:00:00
807	807	1	4662	457	95	1	3	3	62.00	171.66	2021-10-07 00:00:00
808	808	1	4539	457	95	1	3	4	899.99	3450.86	2021-06-06 00:00:00
809	809	1	4827	457	95	1	3	7	37.00	173.48	2022-03-21 00:00:00
810	810	1	4608	457	95	1	3	1	37.00	7.72	2021-08-14 00:00:00
811	811	1	4697	457	95	1	3	7	100.00	667.89	2021-11-11 00:00:00
812	812	1	4497	457	95	1	3	3	90.00	234.44	2021-04-25 00:00:00
813	813	1	4725	457	95	1	3	3	1490.00	4256.71	2021-12-09 00:00:00
814	814	1	4573	457	95	1	3	10	41.00	387.80	2021-07-10 00:00:00
815	815	1	4459	457	95	1	3	3	2490.00	7363.72	2021-03-18 00:00:00
816	816	1	4555	457	95	1	3	9	510.00	4466.62	2021-06-22 00:00:00
817	817	1	4686	457	95	1	3	5	550.00	2715.11	2021-10-31 00:00:00
818	818	1	4899	457	95	1	3	1	1890.00	1611.50	2022-06-01 00:00:00
819	819	1	4427	457	95	1	3	2	300.00	386.37	2021-02-14 00:00:00
820	820	1	4549	457	95	1	3	5	90.00	214.11	2021-06-16 00:00:00
821	821	1	4554	457	95	1	3	3	60.00	117.57	2021-06-21 00:00:00
822	822	1	4616	457	95	1	3	4	400.00	1406.59	2021-08-22 00:00:00
823	823	1	4743	457	95	1	3	1	400.00	132.40	2021-12-27 00:00:00
824	824	1	4578	457	95	1	3	8	1699.99	13321.12	2021-07-15 00:00:00
825	825	1	4818	457	95	1	3	10	50.00	292.44	2022-03-12 00:00:00
826	826	1	4665	457	95	1	3	9	850.00	7569.69	2021-10-10 00:00:00
827	827	1	4599	457	95	1	3	2	41.00	0.01	2021-08-05 00:00:00
828	828	1	4883	457	95	1	3	1	41.00	16.23	2022-05-16 00:00:00
829	829	1	4413	457	95	1	3	9	460.00	3871.69	2021-01-31 00:00:00
830	830	1	4415	457	95	1	3	2	34.00	0.01	2021-02-02 00:00:00
831	831	1	4626	457	95	1	3	10	400.00	3708.82	2021-09-01 00:00:00
832	832	1	4665	457	95	1	3	10	490.00	4875.94	2021-10-10 00:00:00
833	833	1	4668	457	95	1	3	10	100.00	722.44	2021-10-13 00:00:00
834	834	1	4534	457	95	1	3	5	50.00	0.01	2021-06-01 00:00:00
835	835	1	4676	457	95	1	3	4	500.00	1737.61	2021-10-21 00:00:00
836	836	1	4775	457	95	1	3	7	62.00	168.13	2022-01-28 00:00:00
837	837	1	4830	457	95	1	3	6	510.00	2976.04	2022-03-24 00:00:00
838	838	1	4692	457	95	1	3	3	34.00	0.01	2021-11-06 00:00:00
839	839	1	4830	457	95	1	3	9	420.00	3722.06	2022-03-24 00:00:00
840	840	1	4772	457	95	1	3	6	41.00	0.01	2022-01-25 00:00:00
841	841	1	4638	457	95	1	3	4	1390.00	5532.88	2021-09-13 00:00:00
842	842	1	4422	457	95	1	3	8	1390.00	11001.63	2021-02-09 00:00:00
843	843	1	4421	457	95	1	3	6	690.00	3931.11	2021-02-08 00:00:00
844	844	1	4632	457	95	1	3	7	1390.00	9728.30	2021-09-07 00:00:00
845	845	1	4514	457	95	1	3	7	100.00	586.20	2021-05-12 00:00:00
846	846	1	4688	457	95	1	3	7	850.00	5848.36	2021-11-02 00:00:00
847	847	1	4627	457	95	1	3	3	350.00	1017.42	2021-09-02 00:00:00
848	848	1	4385	457	95	1	3	6	20.00	0.01	2021-01-03 00:00:00
849	849	1	4564	457	95	1	3	2	90.00	165.32	2021-07-01 00:00:00
850	850	1	4891	457	95	1	3	8	100.00	652.04	2022-05-24 00:00:00
851	851	1	4846	457	95	1	3	10	10.00	0.01	2022-04-09 00:00:00
852	852	1	4398	457	95	1	3	4	990.00	3765.06	2021-01-16 00:00:00
853	853	1	4478	457	95	1	3	10	400.00	3895.20	2021-04-06 00:00:00
854	854	1	4759	457	95	1	3	9	60.00	539.18	2022-01-12 00:00:00
855	855	1	4440	457	95	1	3	4	20.00	0.01	2021-02-27 00:00:00
856	856	1	4678	457	95	1	3	7	100.00	527.50	2021-10-23 00:00:00
857	857	1	4852	457	95	1	3	7	34.00	46.78	2022-04-15 00:00:00
858	858	1	4858	457	95	1	3	7	100.00	560.15	2022-04-21 00:00:00
859	859	1	4491	457	95	1	3	3	299.99	637.86	2021-04-19 00:00:00
860	860	1	4877	457	95	1	3	10	100.00	763.29	2022-05-10 00:00:00
861	861	1	4643	457	95	1	3	5	550.00	2655.16	2021-09-18 00:00:00
862	862	1	4398	457	95	1	3	3	300.00	768.94	2021-01-16 00:00:00
863	863	1	4678	457	95	1	3	2	550.00	1003.59	2021-10-23 00:00:00
864	864	1	4886	457	95	1	3	6	300.00	1622.92	2022-05-19 00:00:00
865	865	1	4906	457	95	1	3	7	490.00	3247.68	2022-06-08 00:00:00
866	866	1	4647	457	95	1	3	9	1890.00	16756.18	2021-09-22 00:00:00
867	867	1	4811	457	95	1	3	3	420.00	1204.44	2022-03-05 00:00:00
868	868	1	4845	457	95	1	3	1	420.00	284.00	2022-04-08 00:00:00
869	869	1	4845	457	95	1	3	5	100.00	415.74	2022-04-08 00:00:00
870	870	1	4562	457	95	1	3	6	41.00	225.59	2021-06-29 00:00:00
871	871	1	4455	457	95	1	3	7	300.00	2087.47	2021-03-14 00:00:00
872	872	1	4421	457	95	1	3	2	72.00	0.01	2021-02-08 00:00:00
873	873	1	4709	457	95	1	3	5	85.00	233.31	2021-11-23 00:00:00
874	874	1	4620	457	95	1	3	6	200.00	1157.73	2021-08-26 00:00:00
875	875	1	4609	457	95	1	3	3	899.99	2553.12	2021-08-15 00:00:00
876	876	1	4870	457	95	1	3	3	46.00	0.01	2022-05-03 00:00:00
877	877	1	4533	457	95	1	3	4	50.00	0.01	2021-05-31 00:00:00
878	878	1	4497	457	95	1	3	5	85.00	218.50	2021-04-25 00:00:00
879	879	1	4385	457	95	1	3	7	2490.00	17371.07	2021-01-03 00:00:00
880	880	1	4892	457	95	1	3	10	249.99	2295.01	2022-05-25 00:00:00
881	881	1	4384	457	95	1	3	8	420.00	3359.71	2021-01-02 00:00:00
882	882	1	4524	457	95	1	3	8	22.00	0.01	2021-05-22 00:00:00
883	883	1	4643	457	95	1	3	1	22.00	0.01	2021-09-18 00:00:00
884	884	1	4819	457	95	1	3	5	300.00	1253.49	2022-03-13 00:00:00
885	885	1	4659	457	95	1	3	9	10.00	0.01	2021-10-04 00:00:00
886	886	1	4459	457	95	1	3	2	72.00	75.22	2021-03-18 00:00:00
887	887	1	4854	457	95	1	3	6	460.00	2646.62	2022-04-17 00:00:00
888	888	1	4480	457	95	1	3	2	37.00	0.01	2021-04-08 00:00:00
889	889	1	4651	457	95	1	3	3	93.00	164.63	2021-09-26 00:00:00
890	890	1	4684	457	95	1	3	4	62.00	13.51	2021-10-29 00:00:00
891	891	1	4531	457	95	1	3	5	490.00	2372.13	2021-05-29 00:00:00
892	892	1	4517	457	95	1	3	4	350.00	1153.47	2021-05-15 00:00:00
893	893	1	4688	457	95	1	3	7	34.00	137.31	2021-11-02 00:00:00
894	894	1	4863	457	95	1	3	9	85.00	651.49	2022-04-26 00:00:00
895	895	1	4600	457	95	1	3	1	899.99	780.29	2021-08-06 00:00:00
896	896	1	4890	457	95	1	3	9	100.00	720.06	2022-05-23 00:00:00
897	897	1	4509	457	95	1	3	6	100.00	433.11	2021-05-07 00:00:00
898	898	1	4507	457	95	1	3	2	850.00	1434.62	2021-05-05 00:00:00
899	899	1	4829	457	95	1	3	10	72.00	554.20	2022-03-23 00:00:00
900	900	1	4698	457	95	1	3	3	690.00	2014.48	2021-11-12 00:00:00
901	901	1	4691	457	95	1	3	4	1390.00	5533.31	2021-11-05 00:00:00
902	902	1	4647	457	95	1	3	2	85.00	54.58	2021-09-22 00:00:00
903	903	1	4709	457	95	1	3	6	72.00	273.21	2021-11-23 00:00:00
904	904	1	4903	457	95	1	3	3	60.00	15.71	2022-06-05 00:00:00
905	905	1	4821	457	95	1	3	10	50.00	290.03	2022-03-15 00:00:00
906	906	1	4394	457	95	1	3	8	100.00	760.12	2021-01-12 00:00:00
907	907	1	4912	457	95	1	3	10	990.00	9829.57	2022-06-14 00:00:00
908	908	1	4428	457	95	1	3	10	2490.00	24748.56	2021-02-15 00:00:00
909	909	1	4590	457	95	1	3	7	420.00	2726.23	2021-07-27 00:00:00
910	910	1	4564	457	95	1	3	7	200.00	1300.57	2021-07-01 00:00:00
911	911	1	4752	457	95	1	3	8	990.00	7807.99	2022-01-05 00:00:00
912	912	1	4507	457	95	1	3	4	50.00	109.50	2021-05-05 00:00:00
913	913	1	4679	457	95	1	3	8	1490.00	11911.68	2021-10-24 00:00:00
914	914	1	4564	457	95	1	3	9	249.99	2176.15	2021-07-01 00:00:00
915	915	1	4535	457	95	1	3	7	37.00	105.61	2021-06-02 00:00:00
916	916	1	4886	457	95	1	3	10	460.00	4427.17	2022-05-19 00:00:00
917	917	1	4821	457	95	1	3	3	100.00	62.00	2022-03-15 00:00:00
918	918	1	4773	457	95	1	3	1	10.00	0.01	2022-01-26 00:00:00
919	919	1	4735	457	95	1	3	8	1890.00	15119.89	2021-12-19 00:00:00
920	920	1	4627	457	95	1	3	6	665.00	3825.98	2021-09-02 00:00:00
921	921	1	4646	457	95	1	3	4	50.00	89.33	2021-09-21 00:00:00
922	922	1	4497	457	95	1	3	3	10.00	0.01	2021-04-25 00:00:00
923	923	1	4839	457	95	1	3	7	350.00	2157.14	2022-04-02 00:00:00
924	924	1	4734	457	95	1	3	7	2490.00	17227.26	2021-12-18 00:00:00
925	925	1	4785	457	95	1	3	6	37.00	179.78	2022-02-07 00:00:00
926	926	1	4740	457	95	1	3	1	550.00	297.54	2021-12-24 00:00:00
927	927	1	4515	457	95	1	3	2	350.00	616.52	2021-05-13 00:00:00
928	928	1	4676	457	95	1	3	6	22.00	0.01	2021-10-21 00:00:00
929	929	1	4884	457	95	1	3	8	420.00	3249.64	2022-05-17 00:00:00
930	930	1	4691	457	95	1	3	10	420.00	4183.46	2021-11-05 00:00:00
931	931	1	4586	457	95	1	3	4	100.00	103.01	2021-07-23 00:00:00
932	932	1	4906	457	95	1	3	2	249.99	362.48	2022-06-08 00:00:00
933	933	1	4457	457	95	1	3	5	100.00	237.23	2021-03-16 00:00:00
934	934	1	4488	457	95	1	3	10	899.99	8965.79	2021-04-16 00:00:00
935	935	1	4744	457	95	1	3	3	460.00	1278.55	2021-12-28 00:00:00
936	936	1	4748	457	95	1	3	7	1699.99	11620.33	2022-01-01 00:00:00
937	937	1	4450	457	95	1	3	3	34.00	2.07	2021-03-09 00:00:00
938	938	1	4778	457	95	1	3	10	50.00	433.10	2022-01-31 00:00:00
939	939	1	4466	457	95	1	3	2	300.00	324.59	2021-03-25 00:00:00
940	940	1	4491	457	95	1	3	8	2490.00	19672.77	2021-04-19 00:00:00
941	941	1	4589	457	95	1	3	1	100.00	0.01	2021-07-26 00:00:00
942	942	1	4498	457	95	1	3	6	350.00	1816.78	2021-04-26 00:00:00
943	943	1	4875	457	95	1	3	4	62.00	239.08	2022-05-08 00:00:00
944	944	1	4515	457	95	1	3	5	300.00	1399.07	2021-05-13 00:00:00
945	945	1	4859	457	95	1	3	9	490.00	4219.51	2022-04-22 00:00:00
946	946	1	4888	457	95	1	3	4	93.00	183.17	2022-05-21 00:00:00
947	947	1	4531	457	95	1	3	3	100.00	81.45	2021-05-29 00:00:00
948	948	1	4504	457	95	1	3	6	400.00	2178.23	2021-05-02 00:00:00
949	949	1	4812	457	95	1	3	1	72.00	0.01	2022-03-06 00:00:00
950	950	1	4672	457	95	1	3	7	850.00	5843.63	2021-10-17 00:00:00
951	951	1	4485	457	95	1	3	9	20.00	16.50	2021-04-13 00:00:00
952	952	1	4510	457	95	1	3	6	90.00	285.34	2021-05-08 00:00:00
953	953	1	4880	457	95	1	3	2	34.00	12.57	2022-05-13 00:00:00
954	954	1	4914	457	95	1	3	1	1390.00	1349.72	2022-06-16 00:00:00
955	955	1	4779	457	95	1	3	9	1390.00	12472.92	2022-02-01 00:00:00
956	956	1	4629	457	95	1	3	8	37.00	251.66	2021-09-04 00:00:00
957	957	1	4845	457	95	1	3	6	390.00	2143.29	2022-04-08 00:00:00
958	958	1	4850	457	95	1	3	4	249.99	801.65	2022-04-13 00:00:00
959	959	1	4606	457	95	1	3	7	46.00	115.39	2021-08-12 00:00:00
960	960	1	4494	457	95	1	3	5	249.99	1132.99	2021-04-22 00:00:00
961	961	1	4464	457	95	1	3	7	350.00	2388.05	2021-03-23 00:00:00
962	962	1	4394	457	95	1	3	6	46.00	0.01	2021-01-12 00:00:00
963	963	1	4677	457	95	1	3	1	46.00	0.01	2021-10-22 00:00:00
964	964	1	4632	457	95	1	3	6	100.00	325.20	2021-09-07 00:00:00
965	965	1	4660	457	95	1	3	9	37.00	152.72	2021-10-05 00:00:00
966	966	1	4532	457	95	1	3	3	420.00	1039.82	2021-05-30 00:00:00
967	967	1	4421	457	95	1	3	6	1890.00	11162.36	2021-02-08 00:00:00
968	968	1	4662	457	95	1	3	10	490.00	4707.64	2021-10-07 00:00:00
969	969	1	4649	457	95	1	3	4	490.00	1784.73	2021-09-24 00:00:00
970	970	1	4697	457	95	1	3	10	22.00	200.85	2021-11-11 00:00:00
971	971	1	4408	457	95	1	3	5	72.00	84.92	2021-01-26 00:00:00
972	972	1	4873	457	95	1	3	2	34.00	0.01	2022-05-06 00:00:00
973	973	1	4606	457	95	1	3	2	1890.00	3482.91	2021-08-12 00:00:00
974	974	1	4536	457	95	1	3	6	100.00	536.14	2021-06-03 00:00:00
975	975	1	4584	457	95	1	3	9	85.00	760.61	2021-07-21 00:00:00
976	976	1	4905	457	95	1	3	10	299.99	2842.73	2022-06-07 00:00:00
977	977	1	4587	457	95	1	3	8	85.00	665.09	2021-07-24 00:00:00
978	978	1	4518	457	95	1	3	3	249.99	621.64	2021-05-16 00:00:00
979	979	1	4632	457	95	1	3	2	420.00	621.90	2021-09-07 00:00:00
980	980	1	4883	457	95	1	3	9	300.00	2667.38	2022-05-16 00:00:00
981	981	1	4421	457	95	1	3	9	420.00	3580.78	2021-02-08 00:00:00
982	982	1	4792	457	95	1	3	4	299.99	1035.26	2022-02-14 00:00:00
983	983	1	4794	457	95	1	3	7	41.00	76.55	2022-02-16 00:00:00
984	984	1	4724	457	95	1	3	7	200.00	1252.29	2021-12-08 00:00:00
985	985	1	4857	457	95	1	3	1	510.00	445.85	2022-04-20 00:00:00
986	986	1	4896	457	95	1	3	1	85.00	0.01	2022-05-29 00:00:00
987	987	1	4665	457	95	1	3	6	100.00	528.76	2021-10-10 00:00:00
988	988	1	4794	457	95	1	3	2	249.99	498.72	2022-02-16 00:00:00
989	989	1	4533	457	95	1	3	3	1490.00	4420.81	2021-05-31 00:00:00
990	990	1	4837	457	95	1	3	10	899.99	8718.50	2022-03-31 00:00:00
991	991	1	4779	457	95	1	3	9	249.99	1976.77	2022-02-01 00:00:00
992	992	1	4544	457	95	1	3	5	460.00	2151.17	2021-06-11 00:00:00
993	993	1	4428	457	95	1	3	8	249.99	1965.94	2021-02-15 00:00:00
994	994	1	4551	457	95	1	3	6	90.00	483.64	2021-06-18 00:00:00
995	995	1	4829	457	95	1	3	4	50.00	0.01	2022-03-23 00:00:00
996	996	1	4485	457	95	1	3	9	20.00	0.01	2021-04-13 00:00:00
997	997	1	4661	457	95	1	3	6	420.00	2451.39	2021-10-06 00:00:00
998	998	1	4644	457	95	1	3	2	29.00	0.01	2021-09-19 00:00:00
999	999	1	4741	457	95	1	3	2	460.00	744.22	2021-12-25 00:00:00
1000	1000	1	4645	457	95	1	3	1	460.00	347.84	2021-09-20 00:00:00
1001	1001	1	4833	457	95	1	3	4	550.00	2069.36	2022-03-27 00:00:00
1002	1002	1	4540	457	95	1	3	7	690.00	4664.51	2021-06-07 00:00:00
1003	1003	1	4537	457	95	1	3	3	50.00	20.02	2021-06-04 00:00:00
1004	1004	1	4559	457	95	1	3	8	46.00	287.13	2021-06-26 00:00:00
1005	1005	1	4568	457	95	1	3	6	34.00	112.77	2021-07-05 00:00:00
1006	1006	1	4884	457	95	1	3	3	34.00	0.01	2022-05-17 00:00:00
1007	1007	1	4761	457	95	1	3	9	1490.00	13309.04	2022-01-14 00:00:00
1008	1008	1	4849	457	95	1	3	4	22.00	0.01	2022-04-12 00:00:00
1009	1009	1	4618	457	95	1	3	3	299.99	767.61	2021-08-24 00:00:00
1010	1010	1	4491	457	95	1	3	3	90.00	169.02	2021-04-19 00:00:00
1011	1011	1	4524	457	95	1	3	10	850.00	8405.26	2021-05-22 00:00:00
1012	1012	1	4680	457	95	1	3	2	300.00	308.30	2021-10-25 00:00:00
1013	1013	1	4792	457	95	1	3	6	200.00	1096.75	2022-02-14 00:00:00
1014	1014	1	4828	457	95	1	3	10	93.00	853.97	2022-03-22 00:00:00
1015	1015	1	4391	457	95	1	3	10	1390.00	13893.07	2021-01-09 00:00:00
1016	1016	1	4841	457	95	1	3	7	400.00	2595.28	2022-04-04 00:00:00
1017	1017	1	4859	457	95	1	3	5	34.00	31.43	2022-04-22 00:00:00
1018	1018	1	4503	457	95	1	3	5	46.00	191.14	2021-05-01 00:00:00
1019	1019	1	4625	457	95	1	3	10	420.00	4110.36	2021-08-31 00:00:00
1020	1020	1	4550	457	95	1	3	5	420.00	1996.08	2021-06-17 00:00:00
1021	1021	1	4875	457	95	1	3	10	299.99	2786.48	2022-05-08 00:00:00
1022	1022	1	4478	457	95	1	3	5	990.00	4687.80	2021-04-06 00:00:00
1023	1023	1	4520	457	95	1	3	4	100.00	189.79	2021-05-18 00:00:00
1024	1024	1	4768	457	95	1	3	8	290.00	2022.41	2022-01-21 00:00:00
1025	1025	1	4513	457	95	1	3	4	34.00	5.85	2021-05-11 00:00:00
1026	1026	1	4635	457	95	1	3	2	46.00	0.01	2021-09-10 00:00:00
1027	1027	1	4512	457	95	1	3	4	850.00	3124.76	2021-05-10 00:00:00
1028	1028	1	4837	457	95	1	3	2	450.00	824.65	2022-03-31 00:00:00
1029	1029	1	4641	457	95	1	3	7	22.00	0.01	2021-09-16 00:00:00
1030	1030	1	4394	457	95	1	3	1	1490.00	1266.38	2021-01-12 00:00:00
1031	1031	1	4772	457	95	1	3	8	100.00	756.74	2022-01-25 00:00:00
1032	1032	1	4737	457	95	1	3	6	450.00	2554.88	2021-12-21 00:00:00
1033	1033	1	4561	457	95	1	3	6	46.00	160.37	2021-06-28 00:00:00
1034	1034	1	4455	457	95	1	3	5	100.00	262.99	2021-03-14 00:00:00
1035	1035	1	4553	457	95	1	3	3	665.00	1818.98	2021-06-20 00:00:00
1036	1036	1	4820	457	95	1	3	1	100.00	56.56	2022-03-14 00:00:00
1037	1037	1	4660	457	95	1	3	4	29.00	18.42	2021-10-05 00:00:00
1038	1038	1	4428	457	95	1	3	9	665.00	5748.86	2021-02-15 00:00:00
1039	1039	1	4462	457	95	1	3	7	20.00	56.22	2021-03-21 00:00:00
1040	1040	1	4643	457	95	1	3	9	550.00	4848.88	2021-09-18 00:00:00
1041	1041	1	4759	457	95	1	3	3	72.00	0.01	2022-01-12 00:00:00
1042	1042	1	4649	457	95	1	3	1	93.00	83.89	2021-09-24 00:00:00
1043	1043	1	4672	457	95	1	3	1	200.00	1.89	2021-10-17 00:00:00
1044	1044	1	4510	457	95	1	3	8	990.00	7860.01	2021-05-08 00:00:00
1045	1045	1	4413	457	95	1	3	8	510.00	3980.51	2021-01-31 00:00:00
1046	1046	1	4618	457	95	1	3	9	899.99	7883.27	2021-08-24 00:00:00
1047	1047	1	4539	457	95	1	3	9	34.00	219.40	2021-06-06 00:00:00
1048	1048	1	4510	457	95	1	3	10	690.00	6700.17	2021-05-08 00:00:00
1049	1049	1	4797	457	95	1	3	9	1699.99	15135.09	2022-02-19 00:00:00
1050	1050	1	4851	457	95	1	3	7	34.00	89.83	2022-04-14 00:00:00
1051	1051	1	4875	457	95	1	3	6	29.00	0.01	2022-05-08 00:00:00
1052	1052	1	4652	457	95	1	3	1	300.00	183.95	2021-09-27 00:00:00
1053	1053	1	4743	457	95	1	3	9	450.00	3861.31	2021-12-27 00:00:00
1054	1054	1	4840	457	95	1	3	7	249.99	1652.43	2022-04-03 00:00:00
1055	1055	1	4410	457	95	1	3	4	90.00	322.40	2021-01-28 00:00:00
1056	1056	1	4564	457	95	1	3	3	41.00	7.92	2021-07-01 00:00:00
1057	1057	1	4397	457	95	1	3	2	50.00	0.01	2021-01-15 00:00:00
1058	1058	1	4586	457	95	1	3	8	550.00	4296.94	2021-07-23 00:00:00
1059	1059	1	4624	457	95	1	3	3	100.00	30.19	2021-08-30 00:00:00
1060	1060	1	4549	457	95	1	3	7	350.00	2220.70	2021-06-16 00:00:00
1061	1061	1	4410	457	95	1	3	5	1390.00	6661.76	2021-01-28 00:00:00
1062	1062	1	4546	457	95	1	3	8	100.00	751.85	2021-06-13 00:00:00
1063	1063	1	4513	457	95	1	3	4	34.00	0.01	2021-05-11 00:00:00
1064	1064	1	4541	457	95	1	3	3	1890.00	5430.47	2021-06-08 00:00:00
1065	1065	1	4646	457	95	1	3	2	22.00	0.01	2021-09-21 00:00:00
1066	1066	1	4558	457	95	1	3	2	460.00	896.80	2021-06-25 00:00:00
1067	1067	1	4474	457	95	1	3	7	1700.00	11897.50	2021-04-02 00:00:00
1068	1068	1	4863	457	95	1	3	10	290.00	2857.16	2022-04-26 00:00:00
1069	1069	1	4659	457	95	1	3	8	29.00	23.21	2021-10-04 00:00:00
1070	1070	1	4546	457	95	1	3	7	500.00	3326.63	2021-06-13 00:00:00
1071	1071	1	4411	457	95	1	3	10	1490.00	14742.36	2021-01-29 00:00:00
1072	1072	1	4695	457	95	1	3	7	1700.00	11735.28	2021-11-09 00:00:00
1073	1073	1	4905	457	95	1	3	9	22.00	0.01	2022-06-07 00:00:00
1074	1074	1	4896	457	95	1	3	7	550.00	3823.28	2022-05-29 00:00:00
1075	1075	1	4862	457	95	1	3	9	249.99	2211.12	2022-04-25 00:00:00
1076	1076	1	4870	457	95	1	3	2	100.00	0.01	2022-05-03 00:00:00
1077	1077	1	4592	457	95	1	3	4	20.00	0.01	2021-07-29 00:00:00
1078	1078	1	4524	457	95	1	3	6	34.00	145.27	2021-05-22 00:00:00
1079	1079	1	4800	457	95	1	3	6	34.00	0.01	2022-02-22 00:00:00
1080	1080	1	4445	457	95	1	3	6	400.00	2301.89	2021-03-04 00:00:00
1081	1081	1	4668	457	95	1	3	2	2490.00	4683.28	2021-10-13 00:00:00
1082	1082	1	4824	457	95	1	3	6	2490.00	14852.58	2022-03-18 00:00:00
1083	1083	1	4516	457	95	1	3	2	100.00	0.01	2021-05-14 00:00:00
1084	1084	1	4855	457	95	1	3	10	90.00	661.29	2022-04-18 00:00:00
1085	1085	1	4490	457	95	1	3	9	350.00	2947.68	2021-04-18 00:00:00
1086	1086	1	4642	457	95	1	3	9	2490.00	22327.43	2021-09-17 00:00:00
1087	1087	1	4843	457	95	1	3	6	300.00	1604.24	2022-04-06 00:00:00
1088	1088	1	4432	457	95	1	3	7	60.00	262.11	2021-02-19 00:00:00
1089	1089	1	4398	457	95	1	3	1	22.00	0.01	2021-01-16 00:00:00
1090	1090	1	4781	457	95	1	3	8	100.00	609.33	2022-02-03 00:00:00
1091	1091	1	4577	457	95	1	3	4	350.00	1229.09	2021-07-14 00:00:00
1092	1092	1	4762	457	95	1	3	2	100.00	0.01	2022-01-15 00:00:00
1093	1093	1	4796	457	95	1	3	3	450.00	1058.59	2022-02-18 00:00:00
1094	1094	1	4618	457	95	1	3	1	50.00	24.69	2021-08-24 00:00:00
1095	1095	1	4599	457	95	1	3	1	60.00	0.01	2021-08-05 00:00:00
1096	1096	1	4676	457	95	1	3	8	350.00	2641.15	2021-10-21 00:00:00
1097	1097	1	4649	457	95	1	3	1	1700.00	1436.60	2021-09-24 00:00:00
1098	1098	1	4816	457	95	1	3	4	100.00	271.77	2022-03-10 00:00:00
1099	1099	1	4507	457	95	1	3	5	690.00	3202.30	2021-05-05 00:00:00
1100	1100	1	4623	457	95	1	3	1	249.99	35.66	2021-08-29 00:00:00
1101	1101	1	4438	457	95	1	3	8	20.00	0.01	2021-02-25 00:00:00
1102	1102	1	4829	457	95	1	3	7	1700.00	11734.07	2022-03-23 00:00:00
1103	1103	1	4564	457	95	1	3	3	1699.99	4907.03	2021-07-01 00:00:00
1104	1104	1	4392	457	95	1	3	7	200.00	1237.74	2021-01-10 00:00:00
1105	1105	1	4553	457	95	1	3	6	20.00	0.01	2021-06-20 00:00:00
1106	1106	1	4748	457	95	1	3	3	20.00	0.01	2022-01-01 00:00:00
1107	1107	1	4645	457	95	1	3	3	50.00	0.01	2021-09-20 00:00:00
1108	1108	1	4437	457	95	1	3	5	249.99	1066.03	2021-02-24 00:00:00
1109	1109	1	4625	457	95	1	3	2	100.00	130.04	2021-08-31 00:00:00
1110	1110	1	4428	457	95	1	3	4	420.00	1528.44	2021-02-15 00:00:00
1111	1111	1	4916	457	95	1	3	3	1699.99	5016.53	2022-06-18 00:00:00
1112	1112	1	4884	457	95	1	3	10	665.00	6488.61	2022-05-17 00:00:00
1113	1113	1	4448	457	95	1	3	2	10.00	0.01	2021-03-07 00:00:00
1114	1114	1	4428	457	95	1	3	3	899.99	2606.90	2021-02-15 00:00:00
1115	1115	1	4672	457	95	1	3	8	665.00	5071.15	2021-10-17 00:00:00
1116	1116	1	4605	457	95	1	3	2	510.00	736.08	2021-08-11 00:00:00
1117	1117	1	4495	457	95	1	3	7	420.00	2922.43	2021-04-23 00:00:00
1118	1118	1	4662	457	95	1	3	5	500.00	2265.16	2021-10-07 00:00:00
1119	1119	1	4476	457	95	1	3	4	1699.99	6643.81	2021-04-04 00:00:00
1120	1120	1	4578	457	95	1	3	7	1699.99	11607.12	2021-07-15 00:00:00
1121	1121	1	4900	457	95	1	3	4	450.00	1517.04	2022-06-02 00:00:00
1122	1122	1	4451	457	95	1	3	9	34.00	86.14	2021-03-10 00:00:00
1123	1123	1	4802	457	95	1	3	7	200.00	1355.04	2022-02-24 00:00:00
1124	1124	1	4629	457	95	1	3	1	420.00	266.56	2021-09-04 00:00:00
1125	1125	1	4633	457	95	1	3	10	29.00	280.83	2021-09-08 00:00:00
1126	1126	1	4697	457	95	1	3	6	665.00	3959.79	2021-11-11 00:00:00
1127	1127	1	4843	457	95	1	3	1	50.00	24.65	2022-04-06 00:00:00
1128	1128	1	4758	457	95	1	3	5	46.00	123.63	2022-01-11 00:00:00
1129	1129	1	4656	457	95	1	3	4	100.00	359.90	2021-10-01 00:00:00
1130	1130	1	4504	457	95	1	3	2	1390.00	2745.39	2021-05-02 00:00:00
1131	1131	1	4643	457	95	1	3	7	350.00	2321.58	2021-09-18 00:00:00
1132	1132	1	4391	457	95	1	3	2	450.00	699.08	2021-01-09 00:00:00
1133	1133	1	4647	457	95	1	3	4	1890.00	7418.38	2021-09-22 00:00:00
1134	1134	1	4424	457	95	1	3	8	10.00	0.01	2021-02-11 00:00:00
1135	1135	1	4701	457	95	1	3	5	990.00	4760.53	2021-11-15 00:00:00
1136	1136	1	4654	457	95	1	3	4	72.00	138.69	2021-09-29 00:00:00
1137	1137	1	4686	457	95	1	3	2	665.00	1278.91	2021-10-31 00:00:00
1138	1138	1	4709	457	95	1	3	4	1390.00	5307.42	2021-11-23 00:00:00
1139	1139	1	4405	457	95	1	3	2	420.00	794.61	2021-01-23 00:00:00
1140	1140	1	4413	457	95	1	3	3	450.00	1149.23	2021-01-31 00:00:00
1141	1141	1	4397	457	95	1	3	1	400.00	385.67	2021-01-15 00:00:00
1142	1142	1	4736	457	95	1	3	8	29.00	0.01	2021-12-20 00:00:00
1143	1143	1	4483	457	95	1	3	2	850.00	1431.16	2021-04-11 00:00:00
1144	1144	1	4446	457	95	1	3	1	290.00	274.40	2021-03-05 00:00:00
1145	1145	1	4568	457	95	1	3	9	299.99	2497.86	2021-07-05 00:00:00
1146	1146	1	4391	457	95	1	3	10	550.00	5252.45	2021-01-09 00:00:00
1147	1147	1	4660	457	95	1	3	1	300.00	265.03	2021-10-05 00:00:00
1148	1148	1	4534	457	95	1	3	4	990.00	3704.64	2021-06-01 00:00:00
1149	1149	1	4441	457	95	1	3	7	200.00	1197.24	2021-02-28 00:00:00
1150	1150	1	4880	457	95	1	3	10	850.00	8444.94	2022-05-13 00:00:00
1151	1151	1	4647	457	95	1	3	3	200.00	504.44	2021-09-22 00:00:00
1152	1152	1	4438	457	95	1	3	10	100.00	845.14	2021-02-25 00:00:00
1153	1153	1	4537	457	95	1	3	7	1890.00	13210.51	2021-06-04 00:00:00
1154	1154	1	4760	457	95	1	3	3	34.00	0.01	2022-01-13 00:00:00
1155	1155	1	4856	457	95	1	3	10	1890.00	18809.15	2022-04-19 00:00:00
1156	1156	1	4416	457	95	1	3	5	50.00	68.09	2021-02-03 00:00:00
1157	1157	1	4539	457	95	1	3	2	60.00	0.01	2021-06-06 00:00:00
1158	1158	1	4385	457	95	1	3	1	510.00	488.33	2021-01-03 00:00:00
1159	1159	1	4611	457	95	1	3	4	850.00	3343.69	2021-08-17 00:00:00
1160	1160	1	4841	457	95	1	3	7	200.00	1265.11	2022-04-04 00:00:00
1161	1161	1	4791	457	95	1	3	4	290.00	939.67	2022-02-13 00:00:00
1162	1162	1	4913	457	95	1	3	2	300.00	384.90	2022-06-15 00:00:00
1163	1163	1	4757	457	95	1	3	6	90.00	297.68	2022-01-10 00:00:00
1164	1164	1	4747	457	95	1	3	10	90.00	832.96	2021-12-31 00:00:00
1165	1165	1	4713	457	95	1	3	2	249.99	482.50	2021-11-27 00:00:00
1166	1166	1	4554	457	95	1	3	2	249.99	387.20	2021-06-21 00:00:00
1167	1167	1	4524	457	95	1	3	6	665.00	3744.06	2021-05-22 00:00:00
1168	1168	1	4915	457	95	1	3	4	1490.00	5808.62	2022-06-17 00:00:00
1169	1169	1	4429	457	95	1	3	7	550.00	3836.27	2021-02-16 00:00:00
1170	1170	1	4609	457	95	1	3	1	46.00	0.01	2021-08-15 00:00:00
1171	1171	1	4612	457	95	1	3	9	2490.00	22284.08	2021-08-18 00:00:00
1172	1172	1	4504	457	95	1	3	3	37.00	0.01	2021-05-02 00:00:00
1173	1173	1	4466	457	95	1	3	7	500.00	3329.50	2021-03-25 00:00:00
1174	1174	1	4578	457	95	1	3	9	93.00	824.72	2021-07-15 00:00:00
1175	1175	1	4738	457	95	1	3	7	290.00	2010.95	2021-12-22 00:00:00
1176	1176	1	4481	457	95	1	3	8	550.00	4295.96	2021-04-09 00:00:00
1177	1177	1	4385	457	95	1	3	1	100.00	68.83	2021-01-03 00:00:00
1178	1178	1	4398	457	95	1	3	6	1490.00	8702.17	2021-01-16 00:00:00
1179	1179	1	4573	457	95	1	3	8	100.00	763.44	2021-07-10 00:00:00
1180	1180	1	4771	457	95	1	3	9	550.00	4683.44	2022-01-24 00:00:00
1181	1181	1	4558	457	95	1	3	7	1700.00	11722.03	2021-06-25 00:00:00
1182	1182	1	4815	457	95	1	3	5	200.00	806.88	2022-03-09 00:00:00
1183	1183	1	4388	457	95	1	3	1	2490.00	2232.22	2021-01-06 00:00:00
1184	1184	1	4599	457	95	1	3	5	300.00	1389.05	2021-08-05 00:00:00
1185	1185	1	4607	457	95	1	3	10	41.00	167.04	2021-08-13 00:00:00
1186	1186	1	4573	457	95	1	3	7	490.00	3161.22	2021-07-10 00:00:00
1187	1187	1	4652	457	95	1	3	7	1490.00	10372.26	2021-09-27 00:00:00
1188	1188	1	4846	457	95	1	3	8	1890.00	14892.80	2022-04-09 00:00:00
1189	1189	1	4833	457	95	1	3	10	100.00	946.45	2022-03-27 00:00:00
1190	1190	1	4708	457	95	1	3	6	490.00	2773.98	2021-11-22 00:00:00
1191	1191	1	4631	457	95	1	3	10	1390.00	13685.57	2021-09-06 00:00:00
1192	1192	1	4633	457	95	1	3	3	85.00	35.34	2021-09-08 00:00:00
1193	1193	1	4853	457	95	1	3	3	1390.00	4164.35	2022-04-16 00:00:00
1194	1194	1	4795	457	95	1	3	2	450.00	742.78	2022-02-17 00:00:00
1195	1195	1	4513	457	95	1	3	9	60.00	533.93	2021-05-11 00:00:00
1196	1196	1	4761	457	95	1	3	1	29.00	0.01	2022-01-14 00:00:00
1197	1197	1	4456	457	95	1	3	7	72.00	237.52	2021-03-15 00:00:00
1198	1198	1	4721	457	95	1	3	6	490.00	2748.17	2021-12-05 00:00:00
1199	1199	1	4561	457	95	1	3	10	100.00	905.06	2021-06-28 00:00:00
1200	1200	1	4791	457	95	1	3	3	510.00	1419.46	2022-02-13 00:00:00
1201	1201	1	4540	457	95	1	3	9	100.00	895.19	2021-06-07 00:00:00
1202	1202	1	4464	457	95	1	3	10	490.00	4680.90	2021-03-23 00:00:00
1203	1203	1	4877	457	95	1	3	6	1890.00	11265.14	2022-05-10 00:00:00
1204	1204	1	4552	457	95	1	3	7	400.00	2771.76	2021-06-19 00:00:00
1205	1205	1	4547	457	95	1	3	7	290.00	2019.57	2021-06-14 00:00:00
1206	1206	1	4854	457	95	1	3	9	100.00	815.96	2022-04-17 00:00:00
1207	1207	1	4563	457	95	1	3	9	390.00	3358.50	2021-06-30 00:00:00
1208	1208	1	4832	457	95	1	3	6	899.99	5309.04	2022-03-26 00:00:00
1209	1209	1	4738	457	95	1	3	8	2490.00	19847.51	2021-12-22 00:00:00
1210	1210	1	4633	457	95	1	3	10	460.00	4527.61	2021-09-08 00:00:00
1211	1211	1	4891	457	95	1	3	6	300.00	1555.89	2022-05-24 00:00:00
1212	1212	1	4517	457	95	1	3	2	90.00	120.31	2021-05-15 00:00:00
1213	1213	1	4687	457	95	1	3	7	400.00	2740.72	2021-11-01 00:00:00
1214	1214	1	4824	457	95	1	3	10	420.00	4013.75	2022-03-18 00:00:00
1215	1215	1	4722	457	95	1	3	4	400.00	1390.71	2021-12-06 00:00:00
1216	1216	1	4455	457	95	1	3	5	100.00	495.62	2021-03-14 00:00:00
1217	1217	1	4425	457	95	1	3	4	390.00	1546.08	2021-02-12 00:00:00
1218	1218	1	4774	457	95	1	3	8	90.00	597.79	2022-01-27 00:00:00
1219	1219	1	4900	457	95	1	3	2	34.00	41.86	2022-06-02 00:00:00
1220	1220	1	4897	457	95	1	3	8	100.00	793.67	2022-05-30 00:00:00
1221	1221	1	4855	457	95	1	3	5	41.00	0.01	2022-04-18 00:00:00
1222	1222	1	4861	457	95	1	3	3	1890.00	5464.76	2022-04-24 00:00:00
1223	1223	1	4640	457	95	1	3	8	899.99	7163.13	2021-09-15 00:00:00
1224	1224	1	4389	457	95	1	3	7	390.00	2623.86	2021-01-07 00:00:00
1225	1225	1	4593	457	95	1	3	7	665.00	4591.04	2021-07-30 00:00:00
1226	1226	1	4559	457	95	1	3	4	1700.00	6615.28	2021-06-26 00:00:00
1227	1227	1	4677	457	95	1	3	7	46.00	207.94	2021-10-22 00:00:00
1228	1228	1	4504	457	95	1	3	10	460.00	4389.59	2021-05-02 00:00:00
1229	1229	1	4679	457	95	1	3	8	249.99	1961.72	2021-10-24 00:00:00
1230	1230	1	4823	457	95	1	3	8	100.00	633.51	2022-03-17 00:00:00
1231	1231	1	4527	457	95	1	3	7	37.00	57.88	2021-05-25 00:00:00
1232	1232	1	4504	457	95	1	3	8	500.00	3850.23	2021-05-02 00:00:00
1233	1233	1	4458	457	95	1	3	2	93.00	0.01	2021-03-17 00:00:00
1234	1234	1	4599	457	95	1	3	9	1490.00	13318.89	2021-08-05 00:00:00
1235	1235	1	4768	457	95	1	3	7	90.00	539.37	2022-01-21 00:00:00
1236	1236	1	4708	457	95	1	3	6	37.00	8.82	2021-11-22 00:00:00
1237	1237	1	4772	457	95	1	3	3	41.00	69.46	2022-01-25 00:00:00
1238	1238	1	4682	457	95	1	3	4	690.00	2563.71	2021-10-27 00:00:00
1239	1239	1	4530	457	95	1	3	6	1490.00	8676.46	2021-05-28 00:00:00
1240	1240	1	4391	457	95	1	3	5	90.00	383.86	2021-01-09 00:00:00
1241	1241	1	4412	457	95	1	3	5	62.00	136.49	2021-01-30 00:00:00
1242	1242	1	4831	457	95	1	3	8	290.00	2216.73	2022-03-25 00:00:00
1243	1243	1	4888	457	95	1	3	4	20.00	0.01	2022-05-21 00:00:00
1244	1244	1	4781	457	95	1	3	10	1700.00	16744.67	2022-02-03 00:00:00
1245	1245	1	4608	457	95	1	3	2	200.00	125.45	2021-08-14 00:00:00
1246	1246	1	4412	457	95	1	3	1	899.99	604.81	2021-01-30 00:00:00
1247	1247	1	4654	457	95	1	3	1	300.00	153.68	2021-09-29 00:00:00
1248	1248	1	4621	457	95	1	3	10	690.00	6802.99	2021-08-27 00:00:00
1249	1249	1	4607	457	95	1	3	8	46.00	120.92	2021-08-13 00:00:00
1250	1250	1	4410	457	95	1	3	4	299.99	1092.64	2021-01-28 00:00:00
1251	1251	1	4490	457	95	1	3	6	420.00	2242.40	2021-04-18 00:00:00
1252	1252	1	4559	457	95	1	3	1	850.00	653.91	2021-06-26 00:00:00
1253	1253	1	4856	457	95	1	3	9	50.00	168.00	2022-04-19 00:00:00
1254	1254	1	4696	457	95	1	3	5	85.00	141.56	2021-11-10 00:00:00
1255	1255	1	4412	457	95	1	3	7	37.00	185.46	2021-01-30 00:00:00
1256	1256	1	4522	457	95	1	3	6	1890.00	11296.84	2021-05-20 00:00:00
1257	1257	1	4784	457	95	1	3	9	665.00	5982.52	2022-02-06 00:00:00
1258	1258	1	4854	457	95	1	3	7	100.00	458.25	2022-04-17 00:00:00
1259	1259	1	4411	457	95	1	3	9	34.00	182.85	2021-01-29 00:00:00
1260	1260	1	4897	457	95	1	3	10	90.00	889.89	2022-05-30 00:00:00
1261	1261	1	4662	457	95	1	3	1	1390.00	1249.44	2021-10-07 00:00:00
1262	1262	1	4850	457	95	1	3	9	899.99	8042.54	2022-04-13 00:00:00
1263	1263	1	4903	457	95	1	3	8	90.00	698.56	2022-06-05 00:00:00
1264	1264	1	4857	457	95	1	3	1	62.00	0.01	2022-04-20 00:00:00
1265	1265	1	4867	457	95	1	3	8	300.00	2383.43	2022-04-30 00:00:00
1266	1266	1	4779	457	95	1	3	10	34.00	201.04	2022-02-01 00:00:00
1267	1267	1	4768	457	95	1	3	9	10.00	0.01	2022-01-21 00:00:00
1268	1268	1	4854	457	95	1	3	1	85.00	0.01	2022-04-17 00:00:00
1269	1269	1	4677	457	95	1	3	1	20.00	0.01	2021-10-22 00:00:00
1270	1270	1	4653	457	95	1	3	5	1890.00	9329.88	2021-09-28 00:00:00
1271	1271	1	4532	457	95	1	3	9	2490.00	22238.37	2021-05-30 00:00:00
1272	1272	1	4625	457	95	1	3	1	60.00	7.90	2021-08-31 00:00:00
1273	1273	1	4594	457	95	1	3	9	10.00	13.97	2021-07-31 00:00:00
1274	1274	1	4891	457	95	1	3	9	290.00	2336.35	2022-05-24 00:00:00
1275	1275	1	4815	457	95	1	3	5	300.00	1455.75	2022-03-09 00:00:00
1276	1276	1	4730	457	95	1	3	6	46.00	178.34	2021-12-14 00:00:00
1277	1277	1	4900	457	95	1	3	2	550.00	942.82	2022-06-02 00:00:00
1278	1278	1	4819	457	95	1	3	3	72.00	145.63	2022-03-13 00:00:00
1279	1279	1	4424	457	95	1	3	8	420.00	3239.98	2021-02-11 00:00:00
1280	1280	1	4504	457	95	1	3	4	93.00	177.70	2021-05-02 00:00:00
1281	1281	1	4433	457	95	1	3	2	420.00	787.47	2021-02-20 00:00:00
1282	1282	1	4554	457	95	1	3	7	29.00	0.01	2021-06-21 00:00:00
1283	1283	1	4485	457	95	1	3	9	50.00	226.82	2021-04-13 00:00:00
1284	1284	1	4489	457	95	1	3	10	46.00	200.96	2021-04-17 00:00:00
1285	1285	1	4620	457	95	1	3	5	400.00	1879.32	2021-08-26 00:00:00
1286	1286	1	4681	457	95	1	3	6	690.00	4133.79	2021-10-26 00:00:00
1287	1287	1	4861	457	95	1	3	2	400.00	612.83	2022-04-24 00:00:00
1288	1288	1	4856	457	95	1	3	8	450.00	3494.79	2022-04-19 00:00:00
1289	1289	1	4518	457	95	1	3	8	20.00	0.01	2021-05-16 00:00:00
1290	1290	1	4865	457	95	1	3	10	550.00	5224.41	2022-04-28 00:00:00
1291	1291	1	4474	457	95	1	3	2	10.00	0.01	2021-04-02 00:00:00
1292	1292	1	4684	457	95	1	3	1	60.00	44.87	2021-10-29 00:00:00
1293	1293	1	4722	457	95	1	3	5	299.99	1361.75	2021-12-06 00:00:00
1294	1294	1	4831	457	95	1	3	9	72.00	584.38	2022-03-25 00:00:00
1295	1295	1	4458	457	95	1	3	5	29.00	101.07	2021-03-17 00:00:00
1296	1296	1	4792	457	95	1	3	1	300.00	33.91	2022-02-14 00:00:00
1297	1297	1	4384	457	95	1	3	9	350.00	3087.52	2021-01-02 00:00:00
1298	1298	1	4481	457	95	1	3	9	390.00	3417.89	2021-04-09 00:00:00
1299	1299	1	4456	457	95	1	3	5	37.00	0.01	2021-03-15 00:00:00
1300	1300	1	4878	457	95	1	3	10	249.99	2444.11	2022-05-11 00:00:00
1301	1301	1	4888	457	95	1	3	4	1490.00	5816.83	2022-05-21 00:00:00
1302	1302	1	4692	457	95	1	3	8	850.00	6564.99	2021-11-06 00:00:00
1303	1303	1	4694	457	95	1	3	10	50.00	290.09	2021-11-08 00:00:00
1304	1304	1	4483	457	95	1	3	10	460.00	4441.28	2021-04-11 00:00:00
1305	1305	1	4459	457	95	1	3	9	100.00	738.95	2021-03-18 00:00:00
1306	1306	1	4476	457	95	1	3	9	450.00	3854.48	2021-04-04 00:00:00
1307	1307	1	4720	457	95	1	3	5	290.00	1208.34	2021-12-04 00:00:00
1308	1308	1	4915	457	95	1	3	3	1700.00	4922.68	2022-06-17 00:00:00
1309	1309	1	4515	457	95	1	3	4	450.00	1692.00	2021-05-13 00:00:00
1310	1310	1	4587	457	95	1	3	2	1699.99	3340.91	2021-07-24 00:00:00
1311	1311	1	4614	457	95	1	3	10	420.00	4122.89	2021-08-20 00:00:00
1312	1312	1	4462	457	95	1	3	3	2490.00	7407.86	2021-03-21 00:00:00
1313	1313	1	4552	457	95	1	3	1	1890.00	1591.83	2021-06-19 00:00:00
1314	1314	1	4391	457	95	1	3	8	1890.00	14961.98	2021-01-09 00:00:00
1315	1315	1	4605	457	95	1	3	3	420.00	1213.20	2021-08-11 00:00:00
1316	1316	1	4483	457	95	1	3	6	460.00	2556.25	2021-04-11 00:00:00
1317	1317	1	4665	457	95	1	3	1	400.00	100.70	2021-10-10 00:00:00
1318	1318	1	4660	457	95	1	3	2	400.00	735.31	2021-10-05 00:00:00
1319	1319	1	4448	457	95	1	3	5	100.00	228.19	2021-03-07 00:00:00
1320	1320	1	4551	457	95	1	3	8	50.00	259.07	2021-06-18 00:00:00
1321	1321	1	4518	457	95	1	3	10	299.99	2920.73	2021-05-16 00:00:00
1322	1322	1	4549	457	95	1	3	9	1699.99	15290.05	2021-06-16 00:00:00
1323	1323	1	4640	457	95	1	3	1	60.00	0.01	2021-09-15 00:00:00
1324	1324	1	4629	457	95	1	3	1	46.00	0.01	2021-09-04 00:00:00
1325	1325	1	4829	457	95	1	3	3	500.00	1462.82	2022-03-23 00:00:00
1326	1326	1	4915	457	95	1	3	2	1700.00	3178.62	2022-06-17 00:00:00
1327	1327	1	4394	457	95	1	3	10	60.00	316.40	2021-01-12 00:00:00
1328	1328	1	4610	457	95	1	3	9	299.99	2664.23	2021-08-16 00:00:00
1329	1329	1	4534	457	95	1	3	9	350.00	3000.42	2021-06-01 00:00:00
1330	1330	1	4457	457	95	1	3	10	420.00	4090.42	2021-03-16 00:00:00
1331	1331	1	4874	457	95	1	3	6	850.00	4941.16	2022-05-07 00:00:00
1332	1332	1	4867	457	95	1	3	4	350.00	1341.79	2022-04-30 00:00:00
1333	1333	1	4748	457	95	1	3	10	85.00	762.60	2022-01-01 00:00:00
1334	1334	1	4912	457	95	1	3	10	490.00	4747.14	2022-06-14 00:00:00
1335	1335	1	4391	457	95	1	3	6	37.00	69.39	2021-01-09 00:00:00
1336	1336	1	4883	457	95	1	3	7	1890.00	13114.77	2022-05-16 00:00:00
1337	1337	1	4481	457	95	1	3	9	46.00	142.60	2021-04-09 00:00:00
1338	1338	1	4897	457	95	1	3	1	450.00	221.06	2022-05-30 00:00:00
1339	1339	1	4476	457	95	1	3	4	37.00	0.01	2021-04-04 00:00:00
1340	1340	1	4855	457	95	1	3	7	899.99	6225.14	2022-04-18 00:00:00
1341	1341	1	4512	457	95	1	3	4	460.00	1556.43	2021-05-10 00:00:00
1342	1342	1	4592	457	95	1	3	2	460.00	911.22	2021-07-29 00:00:00
1343	1343	1	4577	457	95	1	3	3	490.00	1183.06	2021-07-14 00:00:00
1344	1344	1	4743	457	95	1	3	5	550.00	2594.76	2021-12-27 00:00:00
1345	1345	1	4456	457	95	1	3	5	10.00	27.06	2021-03-15 00:00:00
1346	1346	1	4646	457	95	1	3	4	420.00	1563.66	2021-09-21 00:00:00
1347	1347	1	4568	457	95	1	3	5	2490.00	12172.16	2021-07-05 00:00:00
1348	1348	1	4595	457	95	1	3	5	420.00	1937.46	2021-08-01 00:00:00
1349	1349	1	4824	457	95	1	3	3	10.00	0.01	2022-03-18 00:00:00
1350	1350	1	4396	457	95	1	3	6	290.00	1450.57	2021-01-14 00:00:00
1351	1351	1	4785	457	95	1	3	1	37.00	0.01	2022-02-07 00:00:00
1352	1352	1	4516	457	95	1	3	10	90.00	802.78	2021-05-14 00:00:00
1353	1353	1	4544	457	95	1	3	2	41.00	0.01	2021-06-11 00:00:00
1354	1354	1	4697	457	95	1	3	5	46.00	161.56	2021-11-11 00:00:00
1355	1355	1	4880	457	95	1	3	6	93.00	434.16	2022-05-13 00:00:00
1356	1356	1	4549	457	95	1	3	1	400.00	226.44	2021-06-16 00:00:00
1357	1357	1	4848	457	95	1	3	1	46.00	0.01	2022-04-11 00:00:00
1358	1358	1	4798	457	95	1	3	7	420.00	2656.81	2022-02-20 00:00:00
1359	1359	1	4828	457	95	1	3	3	1490.00	4198.66	2022-03-22 00:00:00
1360	1360	1	4858	457	95	1	3	9	62.00	528.18	2022-04-21 00:00:00
1361	1361	1	4760	457	95	1	3	4	1490.00	5826.71	2022-01-13 00:00:00
1362	1362	1	4798	457	95	1	3	5	350.00	1606.66	2022-02-20 00:00:00
1363	1363	1	4876	457	95	1	3	10	249.99	2222.93	2022-05-09 00:00:00
1364	1364	1	4903	457	95	1	3	5	400.00	1763.65	2022-06-05 00:00:00
1365	1365	1	4552	457	95	1	3	5	34.00	0.01	2021-06-19 00:00:00
1366	1366	1	4711	457	95	1	3	1	1390.00	1218.87	2021-11-25 00:00:00
1367	1367	1	4516	457	95	1	3	9	390.00	3378.93	2021-05-14 00:00:00
1368	1368	1	4818	457	95	1	3	7	690.00	4559.11	2022-03-12 00:00:00
1369	1369	1	4555	457	95	1	3	3	460.00	1128.77	2021-06-22 00:00:00
1370	1370	1	4772	457	95	1	3	9	290.00	2513.60	2022-01-25 00:00:00
1371	1371	1	4616	457	95	1	3	9	90.00	691.28	2021-08-22 00:00:00
1372	1372	1	4898	457	95	1	3	10	2490.00	24815.75	2022-05-31 00:00:00
1373	1373	1	4668	457	95	1	3	4	100.00	334.68	2021-10-13 00:00:00
1374	1374	1	4877	457	95	1	3	9	1490.00	13220.26	2022-05-10 00:00:00
1375	1375	1	4606	457	95	1	3	6	22.00	25.39	2021-08-12 00:00:00
1376	1376	1	4859	457	95	1	3	3	100.00	117.89	2022-04-22 00:00:00
1377	1377	1	4830	457	95	1	3	1	550.00	375.72	2022-03-24 00:00:00
1378	1378	1	4410	457	95	1	3	4	400.00	1580.98	2021-01-28 00:00:00
1379	1379	1	4568	457	95	1	3	4	1390.00	5532.86	2021-07-05 00:00:00
1380	1380	1	4735	457	95	1	3	2	100.00	46.26	2021-12-19 00:00:00
1381	1381	1	4781	457	95	1	3	5	850.00	3991.24	2022-02-03 00:00:00
1382	1382	1	4446	457	95	1	3	9	490.00	4151.07	2021-03-05 00:00:00
1383	1383	1	4577	457	95	1	3	9	41.00	102.04	2021-07-14 00:00:00
1384	1384	1	4544	457	95	1	3	6	90.00	453.58	2021-06-11 00:00:00
1385	1385	1	4510	457	95	1	3	6	85.00	502.17	2021-05-08 00:00:00
1386	1386	1	4541	457	95	1	3	7	62.00	417.93	2021-06-08 00:00:00
1387	1387	1	4658	457	95	1	3	3	1699.99	4998.66	2021-10-03 00:00:00
1388	1388	1	4680	457	95	1	3	6	290.00	1451.03	2021-10-25 00:00:00
1389	1389	1	4699	457	95	1	3	2	10.00	0.01	2021-11-13 00:00:00
1390	1390	1	4713	457	95	1	3	5	29.00	75.73	2021-11-27 00:00:00
1391	1391	1	4645	457	95	1	3	4	249.99	961.12	2021-09-20 00:00:00
1392	1392	1	4600	457	95	1	3	5	1699.99	8459.93	2021-08-06 00:00:00
1393	1393	1	4705	457	95	1	3	3	1490.00	4180.23	2021-11-19 00:00:00
1394	1394	1	4896	457	95	1	3	4	29.00	56.37	2022-05-29 00:00:00
1395	1395	1	4488	457	95	1	3	1	550.00	396.56	2021-04-16 00:00:00
1396	1396	1	4495	457	95	1	3	8	390.00	3035.31	2021-04-23 00:00:00
1397	1397	1	4689	457	95	1	3	10	34.00	305.17	2021-11-03 00:00:00
1398	1398	1	4865	457	95	1	3	6	300.00	1721.64	2022-04-28 00:00:00
1399	1399	1	4778	457	95	1	3	8	20.00	0.01	2022-01-31 00:00:00
1400	1400	1	4455	457	95	1	3	2	350.00	670.73	2021-03-14 00:00:00
1401	1401	1	4850	457	95	1	3	7	90.00	463.94	2022-04-13 00:00:00
1402	1402	1	4762	457	95	1	3	7	400.00	2651.89	2022-01-15 00:00:00
1403	1403	1	4503	457	95	1	3	10	34.00	148.87	2021-05-01 00:00:00
1404	1404	1	4478	457	95	1	3	10	899.99	8799.81	2021-04-06 00:00:00
1405	1405	1	4883	457	95	1	3	5	34.00	0.01	2022-05-16 00:00:00
1406	1406	1	4586	457	95	1	3	8	20.00	0.01	2021-07-23 00:00:00
1407	1407	1	4839	457	95	1	3	2	34.00	26.53	2022-04-02 00:00:00
1408	1408	1	4682	457	95	1	3	3	300.00	792.19	2021-10-27 00:00:00
1409	1409	1	4541	457	95	1	3	1	100.00	0.01	2021-06-08 00:00:00
1410	1410	1	4867	457	95	1	3	10	300.00	2950.67	2022-04-30 00:00:00
1411	1411	1	4397	457	95	1	3	4	93.00	89.16	2021-01-15 00:00:00
1412	1412	1	4408	457	95	1	3	5	37.00	52.04	2021-01-26 00:00:00
1413	1413	1	4441	457	95	1	3	3	665.00	1978.27	2021-02-28 00:00:00
1414	1414	1	4590	457	95	1	3	9	299.99	2607.48	2021-07-27 00:00:00
1415	1415	1	4856	457	95	1	3	9	390.00	3327.34	2022-04-19 00:00:00
1416	1416	1	4705	457	95	1	3	9	460.00	3935.33	2021-11-19 00:00:00
1417	1417	1	4800	457	95	1	3	3	72.00	36.66	2022-02-22 00:00:00
1418	1418	1	4476	457	95	1	3	5	450.00	2113.22	2021-04-04 00:00:00
1419	1419	1	4798	457	95	1	3	4	450.00	1774.74	2022-02-20 00:00:00
1420	1420	1	4495	457	95	1	3	9	500.00	4341.86	2021-04-23 00:00:00
1421	1421	1	4829	457	95	1	3	4	29.00	0.01	2022-03-23 00:00:00
1422	1422	1	4685	457	95	1	3	6	300.00	1725.35	2021-10-30 00:00:00
1423	1423	1	4552	457	95	1	3	2	46.00	0.01	2021-06-19 00:00:00
1424	1424	1	4711	457	95	1	3	5	290.00	1281.84	2021-11-25 00:00:00
1425	1425	1	4411	457	95	1	3	2	665.00	1041.27	2021-01-29 00:00:00
1426	1426	1	4875	457	95	1	3	6	500.00	2983.34	2022-05-08 00:00:00
1427	1427	1	4576	457	95	1	3	6	420.00	2448.05	2021-07-13 00:00:00
1428	1428	1	4810	457	95	1	3	7	1700.00	11808.94	2022-03-04 00:00:00
1429	1429	1	4708	457	95	1	3	6	29.00	98.98	2021-11-22 00:00:00
1430	1430	1	4812	457	95	1	3	10	34.00	120.60	2022-03-06 00:00:00
1431	1431	1	4878	457	95	1	3	3	1390.00	3911.22	2022-05-11 00:00:00
1432	1432	1	4897	457	95	1	3	2	550.00	1071.91	2022-05-30 00:00:00
1433	1433	1	4861	457	95	1	3	9	290.00	2446.40	2022-04-24 00:00:00
1434	1434	1	4631	457	95	1	3	8	46.00	228.51	2021-09-06 00:00:00
1435	1435	1	4466	457	95	1	3	9	62.00	538.12	2021-03-25 00:00:00
1436	1436	1	4639	457	95	1	3	10	34.00	52.32	2021-09-14 00:00:00
1437	1437	1	4829	457	95	1	3	8	1890.00	14918.15	2022-03-23 00:00:00
1438	1438	1	4743	457	95	1	3	2	350.00	473.00	2021-12-27 00:00:00
1439	1439	1	4694	457	95	1	3	1	2490.00	2356.56	2021-11-08 00:00:00
1440	1440	1	4436	457	95	1	3	8	22.00	0.01	2021-02-23 00:00:00
1441	1441	1	4397	457	95	1	3	4	1890.00	7529.02	2021-01-15 00:00:00
1442	1442	1	4483	457	95	1	3	1	300.00	197.48	2021-04-11 00:00:00
1443	1443	1	4863	457	95	1	3	3	60.00	0.01	2022-04-26 00:00:00
1444	1444	1	4641	457	95	1	3	5	1490.00	7227.96	2021-09-16 00:00:00
1445	1445	1	4711	457	95	1	3	10	46.00	375.24	2021-11-25 00:00:00
1446	1446	1	4507	457	95	1	3	7	450.00	2973.15	2021-05-05 00:00:00
1447	1447	1	4699	457	95	1	3	3	41.00	92.12	2021-11-13 00:00:00
1448	1448	1	4873	457	95	1	3	1	90.00	0.01	2022-05-06 00:00:00
1449	1449	1	4697	457	95	1	3	1	400.00	228.94	2021-11-11 00:00:00
1450	1450	1	4722	457	95	1	3	2	420.00	596.68	2021-12-06 00:00:00
1451	1451	1	4747	457	95	1	3	2	1490.00	2863.50	2021-12-31 00:00:00
1452	1452	1	4504	457	95	1	3	8	46.00	75.35	2021-05-02 00:00:00
1453	1453	1	4590	457	95	1	3	8	100.00	512.98	2021-07-27 00:00:00
1454	1454	1	4517	457	95	1	3	7	1890.00	12935.37	2021-05-15 00:00:00
1455	1455	1	4391	457	95	1	3	8	100.00	525.15	2021-01-09 00:00:00
1456	1456	1	4751	457	95	1	3	9	100.00	667.08	2022-01-04 00:00:00
1457	1457	1	4532	457	95	1	3	1	100.00	0.01	2021-05-30 00:00:00
1458	1458	1	4545	457	95	1	3	3	90.00	234.95	2021-06-12 00:00:00
1459	1459	1	4596	457	95	1	3	4	990.00	3863.66	2021-08-02 00:00:00
1460	1460	1	4640	457	95	1	3	5	62.00	236.49	2021-09-15 00:00:00
1461	1461	1	4427	457	95	1	3	6	490.00	2910.32	2021-02-14 00:00:00
1462	1462	1	4586	457	95	1	3	5	50.00	11.66	2021-07-23 00:00:00
1463	1463	1	4722	457	95	1	3	9	665.00	5847.87	2021-12-06 00:00:00
1464	1464	1	4880	457	95	1	3	2	29.00	0.01	2022-05-13 00:00:00
1465	1465	1	4396	457	95	1	3	1	29.00	0.01	2021-01-14 00:00:00
1466	1466	1	4759	457	95	1	3	10	2490.00	24804.70	2022-01-12 00:00:00
1467	1467	1	4478	457	95	1	3	4	500.00	1903.63	2021-04-06 00:00:00
1468	1468	1	4641	457	95	1	3	7	420.00	2796.83	2021-09-16 00:00:00
1469	1469	1	4462	457	95	1	3	10	100.00	856.15	2021-03-21 00:00:00
1470	1470	1	4568	457	95	1	3	9	34.00	296.79	2021-07-05 00:00:00
1471	1471	1	4814	457	95	1	3	7	200.00	1119.96	2022-03-08 00:00:00
1472	1472	1	4625	457	95	1	3	7	2490.00	17336.43	2021-08-31 00:00:00
1473	1473	1	4774	457	95	1	3	5	90.00	231.09	2022-01-27 00:00:00
1474	1474	1	4706	457	95	1	3	9	90.00	711.44	2021-11-20 00:00:00
1475	1475	1	4654	457	95	1	3	4	60.00	163.39	2021-09-29 00:00:00
1476	1476	1	4580	457	95	1	3	8	420.00	3199.81	2021-07-17 00:00:00
1477	1477	1	4684	457	95	1	3	9	510.00	4514.99	2021-10-29 00:00:00
1478	1478	1	4427	457	95	1	3	8	400.00	3064.46	2021-02-14 00:00:00
1479	1479	1	4785	457	95	1	3	6	400.00	2116.14	2022-02-07 00:00:00
1480	1480	1	4665	457	95	1	3	3	62.00	153.79	2021-10-10 00:00:00
1481	1481	1	4596	457	95	1	3	8	20.00	0.01	2021-08-02 00:00:00
1482	1482	1	4873	457	95	1	3	10	37.00	320.94	2022-05-06 00:00:00
1483	1483	1	4631	457	95	1	3	9	62.00	320.71	2021-09-06 00:00:00
1484	1484	1	4748	457	95	1	3	10	899.99	8712.20	2022-01-01 00:00:00
1485	1485	1	4851	457	95	1	3	1	90.00	0.01	2022-04-14 00:00:00
1486	1486	1	4915	457	95	1	3	3	46.00	8.00	2022-06-17 00:00:00
1487	1487	1	4651	457	95	1	3	5	1890.00	9319.71	2021-09-26 00:00:00
1488	1488	1	4735	457	95	1	3	10	1890.00	18669.99	2021-12-19 00:00:00
1489	1489	1	4503	457	95	1	3	10	60.00	309.10	2021-05-01 00:00:00
1490	1490	1	4862	457	95	1	3	10	450.00	4271.92	2022-04-25 00:00:00
1491	1491	1	4747	457	95	1	3	9	690.00	6179.81	2021-12-31 00:00:00
1492	1492	1	4877	457	95	1	3	8	100.00	559.53	2022-05-10 00:00:00
1493	1493	1	4626	457	95	1	3	9	1890.00	16827.73	2021-09-01 00:00:00
1494	1494	1	4800	457	95	1	3	10	390.00	3715.05	2022-02-22 00:00:00
1495	1495	1	4832	457	95	1	3	10	550.00	5281.75	2022-03-26 00:00:00
1496	1496	1	4820	457	95	1	3	10	350.00	3367.23	2022-03-14 00:00:00
1497	1497	1	4648	457	95	1	3	4	990.00	3954.38	2021-09-23 00:00:00
1498	1498	1	4433	457	95	1	3	6	93.00	298.01	2021-02-20 00:00:00
1499	1499	1	4533	457	95	1	3	1	510.00	348.60	2021-05-31 00:00:00
1500	1500	1	4384	457	95	1	3	7	300.00	2093.06	2021-01-02 00:00:00
1501	1501	1	4507	457	95	1	3	1	510.00	401.83	2021-05-05 00:00:00
1502	1502	1	4870	457	95	1	3	6	62.00	305.05	2022-05-03 00:00:00
1503	1503	1	4778	457	95	1	3	4	1490.00	5782.10	2022-01-31 00:00:00
1504	1504	1	4507	457	95	1	3	1	46.00	0.01	2021-05-05 00:00:00
1505	1505	1	4672	457	95	1	3	5	450.00	2219.34	2021-10-17 00:00:00
1506	1506	1	4636	457	95	1	3	1	300.00	47.14	2021-09-11 00:00:00
1507	1507	1	4737	457	95	1	3	7	34.00	226.80	2021-12-21 00:00:00
1508	1508	1	4735	457	95	1	3	8	299.99	2296.96	2021-12-19 00:00:00
1509	1509	1	4455	457	95	1	3	9	420.00	3669.52	2021-03-14 00:00:00
1510	1510	1	4436	457	95	1	3	6	290.00	1586.21	2021-02-23 00:00:00
1511	1511	1	4774	457	95	1	3	9	100.00	735.65	2022-01-27 00:00:00
1512	1512	1	4511	457	95	1	3	6	60.00	239.02	2021-05-09 00:00:00
1513	1513	1	4814	457	95	1	3	6	62.00	108.07	2022-03-08 00:00:00
1514	1514	1	4531	457	95	1	3	7	90.00	457.51	2021-05-29 00:00:00
1515	1515	1	4696	457	95	1	3	10	34.00	90.21	2021-11-10 00:00:00
1516	1516	1	4501	457	95	1	3	4	22.00	5.27	2021-04-29 00:00:00
1517	1517	1	4833	457	95	1	3	9	100.00	608.37	2022-03-27 00:00:00
1518	1518	1	4517	457	95	1	3	6	350.00	2022.96	2021-05-15 00:00:00
1519	1519	1	4647	457	95	1	3	5	990.00	4869.32	2021-09-22 00:00:00
1520	1520	1	4520	457	95	1	3	6	100.00	577.32	2021-05-18 00:00:00
1521	1521	1	4774	457	95	1	3	4	72.00	244.58	2022-01-27 00:00:00
1522	1522	1	4416	457	95	1	3	4	665.00	2509.64	2021-02-03 00:00:00
1523	1523	1	4530	457	95	1	3	2	1699.99	3328.25	2021-05-28 00:00:00
1524	1524	1	4831	457	95	1	3	4	300.00	1186.74	2022-03-25 00:00:00
1525	1525	1	4522	457	95	1	3	7	690.00	4812.94	2021-05-20 00:00:00
1526	1526	1	4456	457	95	1	3	4	200.00	666.74	2021-03-15 00:00:00
1527	1527	1	4456	457	95	1	3	5	350.00	1519.07	2021-03-15 00:00:00
1528	1528	1	4751	457	95	1	3	1	249.99	0.01	2022-01-04 00:00:00
1529	1529	1	4796	457	95	1	3	7	300.00	1828.01	2022-02-18 00:00:00
1530	1530	1	4878	457	95	1	3	3	249.99	529.66	2022-05-11 00:00:00
1531	1531	1	4482	457	95	1	3	3	1890.00	5612.17	2021-04-10 00:00:00
1532	1532	1	4888	457	95	1	3	2	60.00	67.24	2022-05-21 00:00:00
1533	1533	1	4488	457	95	1	3	3	34.00	0.01	2021-04-16 00:00:00
1534	1534	1	4744	457	95	1	3	8	299.99	2147.34	2021-12-28 00:00:00
1535	1535	1	4577	457	95	1	3	3	200.00	363.09	2021-07-14 00:00:00
1536	1536	1	4442	457	95	1	3	4	46.00	0.01	2021-03-01 00:00:00
1537	1537	1	4857	457	95	1	3	1	690.00	549.29	2022-04-20 00:00:00
1538	1538	1	4563	457	95	1	3	9	420.00	3706.46	2021-06-30 00:00:00
1539	1539	1	4442	457	95	1	3	10	1890.00	18829.75	2021-03-01 00:00:00
1540	1540	1	4830	457	95	1	3	8	899.99	7148.72	2022-03-24 00:00:00
1541	1541	1	4579	457	95	1	3	8	62.00	215.64	2021-07-16 00:00:00
1542	1542	1	4577	457	95	1	3	1	10.00	0.01	2021-07-14 00:00:00
1543	1543	1	4912	457	95	1	3	8	85.00	576.32	2022-06-14 00:00:00
1544	1544	1	4661	457	95	1	3	3	510.00	1436.28	2021-10-06 00:00:00
1545	1545	1	4498	457	95	1	3	6	850.00	4808.09	2021-04-26 00:00:00
1546	1546	1	4859	457	95	1	3	4	46.00	65.27	2022-04-22 00:00:00
1547	1547	1	4455	457	95	1	3	7	90.00	544.16	2021-03-14 00:00:00
1548	1548	1	4774	457	95	1	3	3	350.00	826.23	2022-01-27 00:00:00
1549	1549	1	4839	457	95	1	3	7	450.00	2935.98	2022-04-02 00:00:00
1550	1550	1	4434	457	95	1	3	8	1490.00	11844.71	2021-02-21 00:00:00
1551	1551	1	4495	457	95	1	3	7	290.00	1867.36	2021-04-23 00:00:00
1552	1552	1	4740	457	95	1	3	10	34.00	336.93	2021-12-24 00:00:00
1553	1553	1	4658	457	95	1	3	3	50.00	3.42	2021-10-03 00:00:00
1554	1554	1	4753	457	95	1	3	9	1699.99	15196.36	2022-01-06 00:00:00
1555	1555	1	4605	457	95	1	3	7	46.00	41.17	2021-08-11 00:00:00
1556	1556	1	4536	457	95	1	3	3	200.00	518.69	2021-06-03 00:00:00
1557	1557	1	4837	457	95	1	3	2	299.99	344.17	2022-03-31 00:00:00
1558	1558	1	4595	457	95	1	3	5	85.00	370.24	2021-08-01 00:00:00
1559	1559	1	4480	457	95	1	3	6	1390.00	8320.23	2021-04-08 00:00:00
1560	1560	1	4442	457	95	1	3	10	60.00	332.15	2021-03-01 00:00:00
1561	1561	1	4480	457	95	1	3	8	1890.00	14844.82	2021-04-08 00:00:00
1562	1562	1	4428	457	95	1	3	4	90.00	101.40	2021-02-15 00:00:00
1563	1563	1	4826	457	95	1	3	3	85.00	65.23	2022-03-20 00:00:00
1564	1564	1	4537	457	95	1	3	7	85.00	374.17	2021-06-04 00:00:00
1565	1565	1	4800	457	95	1	3	9	1390.00	12373.42	2022-02-22 00:00:00
1566	1566	1	4660	457	95	1	3	6	899.99	5254.57	2021-10-05 00:00:00
1567	1567	1	4510	457	95	1	3	4	34.00	5.58	2021-05-08 00:00:00
1568	1568	1	4460	457	95	1	3	3	22.00	0.01	2021-03-19 00:00:00
1569	1569	1	4813	457	95	1	3	5	510.00	2523.17	2022-03-07 00:00:00
1570	1570	1	4427	457	95	1	3	8	1490.00	11742.59	2021-02-14 00:00:00
1571	1571	1	4648	457	95	1	3	3	50.00	0.01	2021-09-23 00:00:00
1572	1572	1	4563	457	95	1	3	5	390.00	1903.84	2021-06-30 00:00:00
1573	1573	1	4408	457	95	1	3	1	400.00	323.98	2021-01-26 00:00:00
1574	1574	1	4497	457	95	1	3	5	450.00	1973.81	2021-04-25 00:00:00
1575	1575	1	4587	457	95	1	3	4	500.00	1979.11	2021-07-24 00:00:00
1576	1576	1	4388	457	95	1	3	7	62.00	211.87	2021-01-06 00:00:00
1577	1577	1	4913	457	95	1	3	9	299.99	2528.40	2022-06-15 00:00:00
1578	1578	1	4784	457	95	1	3	1	90.00	0.01	2022-02-06 00:00:00
1579	1579	1	4504	457	95	1	3	7	34.00	0.01	2021-05-02 00:00:00
1580	1580	1	4679	457	95	1	3	2	85.00	0.01	2021-10-24 00:00:00
1581	1581	1	4816	457	95	1	3	8	22.00	0.01	2022-03-10 00:00:00
1582	1582	1	4462	457	95	1	3	7	1700.00	11798.84	2021-03-21 00:00:00
1583	1583	1	4825	457	95	1	3	5	20.00	0.01	2022-03-19 00:00:00
1584	1584	1	4794	457	95	1	3	5	29.00	0.01	2022-02-16 00:00:00
1585	1585	1	4852	457	95	1	3	3	41.00	0.01	2022-04-15 00:00:00
1586	1586	1	4647	457	95	1	3	5	390.00	1856.41	2021-09-22 00:00:00
1587	1587	1	4747	457	95	1	3	6	850.00	4902.32	2021-12-31 00:00:00
1588	1588	1	4809	457	95	1	3	8	550.00	4381.21	2022-03-03 00:00:00
1589	1589	1	4446	457	95	1	3	8	500.00	3867.36	2021-03-05 00:00:00
1590	1590	1	4561	457	95	1	3	3	1390.00	4134.46	2021-06-28 00:00:00
1591	1591	1	4553	457	95	1	3	5	299.99	1296.84	2021-06-20 00:00:00
1592	1592	1	4811	457	95	1	3	1	46.00	0.01	2022-03-05 00:00:00
1593	1593	1	4776	457	95	1	3	6	899.99	5215.23	2022-01-29 00:00:00
1594	1594	1	4413	457	95	1	3	8	299.99	2311.11	2021-01-31 00:00:00
1595	1595	1	4549	457	95	1	3	7	460.00	2983.47	2021-06-16 00:00:00
1596	1596	1	4533	457	95	1	3	2	90.00	0.01	2021-05-31 00:00:00
1597	1597	1	4448	457	95	1	3	2	420.00	674.73	2021-03-07 00:00:00
1598	1598	1	4524	457	95	1	3	7	100.00	664.37	2021-05-22 00:00:00
1599	1599	1	4559	457	95	1	3	7	100.00	502.90	2021-06-26 00:00:00
1600	1600	1	4605	457	95	1	3	2	249.99	293.42	2021-08-11 00:00:00
1601	1601	1	4705	457	95	1	3	2	41.00	68.76	2021-11-19 00:00:00
1602	1602	1	4802	457	95	1	3	4	665.00	2412.40	2022-02-24 00:00:00
1603	1603	1	4774	457	95	1	3	7	20.00	0.01	2022-01-27 00:00:00
1604	1604	1	4462	457	95	1	3	3	420.00	1029.32	2021-03-21 00:00:00
1605	1605	1	4722	457	95	1	3	2	1390.00	2552.13	2021-12-06 00:00:00
1606	1606	1	4579	457	95	1	3	1	420.00	277.01	2021-07-16 00:00:00
1607	1607	1	4563	457	95	1	3	8	29.00	0.01	2021-06-30 00:00:00
1608	1608	1	4734	457	95	1	3	3	20.00	0.01	2021-12-18 00:00:00
1609	1609	1	4646	457	95	1	3	1	62.00	0.01	2021-09-21 00:00:00
1610	1610	1	4742	457	95	1	3	3	200.00	399.08	2021-12-26 00:00:00
1611	1611	1	4605	457	95	1	3	1	300.00	121.55	2021-08-11 00:00:00
1612	1612	1	4541	457	95	1	3	7	1490.00	10342.30	2021-06-08 00:00:00
1613	1613	1	4713	457	95	1	3	4	90.00	138.80	2021-11-27 00:00:00
1614	1614	1	4474	457	95	1	3	6	299.99	1581.54	2021-04-02 00:00:00
1615	1615	1	4706	457	95	1	3	10	510.00	5000.55	2021-11-20 00:00:00
1616	1616	1	4725	457	95	1	3	9	34.00	90.60	2021-12-09 00:00:00
1617	1617	1	4699	457	95	1	3	4	34.00	0.01	2021-11-13 00:00:00
1618	1618	1	4654	457	95	1	3	8	1699.99	13304.11	2021-09-29 00:00:00
1619	1619	1	4837	457	95	1	3	4	1699.99	6525.91	2022-03-31 00:00:00
1620	1620	1	4819	457	95	1	3	7	62.00	276.53	2022-03-13 00:00:00
1621	1621	1	4440	457	95	1	3	3	299.99	865.84	2021-02-27 00:00:00
1622	1622	1	4391	457	95	1	3	8	2490.00	19668.54	2021-01-09 00:00:00
1623	1623	1	4564	457	95	1	3	3	450.00	1109.95	2021-07-01 00:00:00
1624	1624	1	4724	457	95	1	3	9	249.99	2105.61	2021-12-08 00:00:00
1625	1625	1	4722	457	95	1	3	1	990.00	878.78	2021-12-06 00:00:00
1626	1626	1	4771	457	95	1	3	9	29.00	209.09	2022-01-24 00:00:00
1627	1627	1	4897	457	95	1	3	5	72.00	182.90	2022-05-30 00:00:00
1628	1628	1	4797	457	95	1	3	2	1490.00	2745.53	2022-02-19 00:00:00
1629	1629	1	4658	457	95	1	3	8	300.00	2378.99	2021-10-03 00:00:00
1630	1630	1	4576	457	95	1	3	1	899.99	757.40	2021-07-13 00:00:00
1631	1631	1	4425	457	95	1	3	8	249.99	1961.94	2021-02-12 00:00:00
1632	1632	1	4620	457	95	1	3	9	37.00	232.40	2021-08-26 00:00:00
1633	1633	1	4523	457	95	1	3	2	29.00	0.01	2021-05-21 00:00:00
1634	1634	1	4870	457	95	1	3	5	85.00	164.55	2022-05-03 00:00:00
1635	1635	1	4612	457	95	1	3	9	450.00	4002.03	2021-08-18 00:00:00
1636	1636	1	4534	457	95	1	3	2	10.00	0.01	2021-06-01 00:00:00
1637	1637	1	4639	457	95	1	3	3	1890.00	5624.36	2021-09-14 00:00:00
1638	1638	1	4458	457	95	1	3	9	22.00	14.71	2021-03-17 00:00:00
1639	1639	1	4560	457	95	1	3	7	90.00	477.49	2021-06-27 00:00:00
1640	1640	1	4840	457	95	1	3	10	420.00	3948.84	2022-04-03 00:00:00
1641	1641	1	4638	457	95	1	3	8	510.00	3827.81	2021-09-13 00:00:00
1642	1642	1	4593	457	95	1	3	1	1390.00	1121.60	2021-07-30 00:00:00
1643	1643	1	4476	457	95	1	3	10	100.00	773.52	2021-04-04 00:00:00
1644	1644	1	4751	457	95	1	3	4	290.00	1046.85	2022-01-04 00:00:00
1645	1645	1	4792	457	95	1	3	9	249.99	2241.09	2022-02-14 00:00:00
1646	1646	1	4464	457	95	1	3	4	990.00	3692.72	2021-03-23 00:00:00
1647	1647	1	4820	457	95	1	3	4	249.99	855.35	2022-03-14 00:00:00
1648	1648	1	4662	457	95	1	3	2	90.00	34.16	2021-10-07 00:00:00
1649	1649	1	4539	457	95	1	3	6	100.00	379.29	2021-06-06 00:00:00
1650	1650	1	4859	457	95	1	3	9	20.00	47.44	2022-04-22 00:00:00
1651	1651	1	4623	457	95	1	3	1	85.00	0.01	2021-08-29 00:00:00
1652	1652	1	4553	457	95	1	3	2	990.00	1799.63	2021-06-20 00:00:00
1653	1653	1	4479	457	95	1	3	8	22.00	95.21	2021-04-07 00:00:00
1654	1654	1	4815	457	95	1	3	5	90.00	379.16	2022-03-09 00:00:00
1655	1655	1	4660	457	95	1	3	10	510.00	4977.11	2021-10-05 00:00:00
1656	1656	1	4747	457	95	1	3	6	1699.99	10073.56	2021-12-31 00:00:00
1657	1657	1	4568	457	95	1	3	9	490.00	4225.63	2021-07-05 00:00:00
1658	1658	1	4537	457	95	1	3	10	2490.00	24706.69	2021-06-04 00:00:00
1659	1659	1	4451	457	95	1	3	2	34.00	0.01	2021-03-10 00:00:00
1660	1660	1	4849	457	95	1	3	10	46.00	165.02	2022-04-12 00:00:00
1661	1661	1	4554	457	95	1	3	4	510.00	2006.27	2021-06-21 00:00:00
1662	1662	1	4386	457	95	1	3	1	50.00	3.80	2021-01-04 00:00:00
1663	1663	1	4760	457	95	1	3	4	200.00	519.48	2022-01-13 00:00:00
1664	1664	1	4456	457	95	1	3	6	490.00	2685.14	2021-03-15 00:00:00
1665	1665	1	4791	457	95	1	3	5	1890.00	9254.38	2022-02-13 00:00:00
1666	1666	1	4579	457	95	1	3	7	850.00	5653.78	2021-07-16 00:00:00
1667	1667	1	4512	457	95	1	3	5	690.00	3178.88	2021-05-10 00:00:00
1668	1668	1	4833	457	95	1	3	10	72.00	562.63	2022-03-27 00:00:00
1669	1669	1	4596	457	95	1	3	9	300.00	2678.85	2021-08-02 00:00:00
1670	1670	1	4812	457	95	1	3	10	50.00	337.72	2022-03-06 00:00:00
1671	1671	1	4385	457	95	1	3	8	2490.00	19716.49	2021-01-03 00:00:00
1672	1672	1	4569	457	95	1	3	9	93.00	724.78	2021-07-06 00:00:00
1673	1673	1	4497	457	95	1	3	10	990.00	9890.55	2021-04-25 00:00:00
1674	1674	1	4912	457	95	1	3	10	420.00	4143.38	2022-06-14 00:00:00
1675	1675	1	4633	457	95	1	3	8	249.99	1871.94	2021-09-08 00:00:00
1676	1676	1	4495	457	95	1	3	3	100.00	151.62	2021-04-23 00:00:00
1677	1677	1	4738	457	95	1	3	6	20.00	13.88	2021-12-22 00:00:00
1678	1678	1	4613	457	95	1	3	3	1700.00	5069.58	2021-08-19 00:00:00
1679	1679	1	4623	457	95	1	3	5	72.00	98.44	2021-08-29 00:00:00
1680	1680	1	4686	457	95	1	3	6	350.00	2041.37	2021-10-31 00:00:00
1681	1681	1	4890	457	95	1	3	6	390.00	2048.25	2022-05-23 00:00:00
1682	1682	1	4721	457	95	1	3	9	420.00	3549.37	2021-12-05 00:00:00
1683	1683	1	4870	457	95	1	3	1	2490.00	2304.15	2022-05-03 00:00:00
1684	1684	1	4412	457	95	1	3	3	22.00	0.01	2021-01-30 00:00:00
1685	1685	1	4625	457	95	1	3	4	20.00	0.01	2021-08-31 00:00:00
1686	1686	1	4589	457	95	1	3	6	850.00	4961.56	2021-07-26 00:00:00
1687	1687	1	4870	457	95	1	3	2	299.99	470.27	2022-05-03 00:00:00
1688	1688	1	4445	457	95	1	3	10	20.00	6.87	2021-03-04 00:00:00
1689	1689	1	4640	457	95	1	3	10	60.00	470.13	2021-09-15 00:00:00
1690	1690	1	4608	457	95	1	3	8	400.00	2903.94	2021-08-14 00:00:00
1691	1691	1	4685	457	95	1	3	10	249.99	2442.01	2021-10-30 00:00:00
1692	1692	1	4905	457	95	1	3	4	400.00	1423.23	2022-06-07 00:00:00
1693	1693	1	4862	457	95	1	3	8	60.00	196.07	2022-04-25 00:00:00
1694	1694	1	4527	457	95	1	3	10	41.00	408.11	2021-05-25 00:00:00
1695	1695	1	4814	457	95	1	3	3	200.00	563.26	2022-03-08 00:00:00
1696	1696	1	4611	457	95	1	3	5	93.00	413.27	2021-08-17 00:00:00
1697	1697	1	4773	457	95	1	3	10	1890.00	18664.69	2022-01-26 00:00:00
1698	1698	1	4725	457	95	1	3	10	85.00	744.61	2021-12-09 00:00:00
1699	1699	1	4867	457	95	1	3	7	90.00	464.69	2022-04-30 00:00:00
1700	1700	1	4672	457	95	1	3	2	90.00	104.72	2021-10-17 00:00:00
1701	1701	1	4684	457	95	1	3	1	390.00	322.54	2021-10-29 00:00:00
1702	1702	1	4870	457	95	1	3	1	100.00	95.49	2022-05-03 00:00:00
1703	1703	1	4721	457	95	1	3	1	420.00	373.30	2021-12-05 00:00:00
1704	1704	1	4680	457	95	1	3	2	899.99	1696.10	2021-10-25 00:00:00
1705	1705	1	4914	457	95	1	3	8	299.99	2389.70	2022-06-16 00:00:00
1706	1706	1	4863	457	95	1	3	9	90.00	772.25	2022-04-26 00:00:00
1707	1707	1	4626	457	95	1	3	10	500.00	4809.86	2021-09-01 00:00:00
1708	1708	1	4886	457	95	1	3	8	390.00	2850.03	2022-05-19 00:00:00
1709	1709	1	4658	457	95	1	3	9	100.00	680.40	2021-10-03 00:00:00
1710	1710	1	4888	457	95	1	3	7	300.00	1954.10	2022-05-21 00:00:00
1711	1711	1	4451	457	95	1	3	4	93.00	368.94	2021-03-10 00:00:00
1712	1712	1	4839	457	95	1	3	6	93.00	301.03	2022-04-02 00:00:00
1713	1713	1	4684	457	95	1	3	4	460.00	1827.10	2021-10-29 00:00:00
1714	1714	1	4541	457	95	1	3	7	62.00	230.65	2021-06-08 00:00:00
1715	1715	1	4824	457	95	1	3	9	200.00	1574.52	2022-03-18 00:00:00
1716	1716	1	4906	457	95	1	3	3	1890.00	5669.90	2022-06-08 00:00:00
1717	1717	1	4647	457	95	1	3	10	290.00	2825.64	2021-09-22 00:00:00
1718	1718	1	4545	457	95	1	3	6	420.00	2254.85	2021-06-12 00:00:00
1719	1719	1	4568	457	95	1	3	8	290.00	2093.73	2021-07-05 00:00:00
1720	1720	1	4635	457	95	1	3	2	20.00	0.01	2021-09-10 00:00:00
1721	1721	1	4750	457	95	1	3	8	50.00	296.09	2022-01-03 00:00:00
1722	1722	1	4778	457	95	1	3	6	390.00	2259.93	2022-01-31 00:00:00
1723	1723	1	4671	457	95	1	3	2	500.00	788.24	2021-10-16 00:00:00
1724	1724	1	4458	457	95	1	3	8	420.00	3099.99	2021-03-17 00:00:00
1725	1725	1	4446	457	95	1	3	6	60.00	349.53	2021-03-05 00:00:00
1726	1726	1	4747	457	95	1	3	2	420.00	692.28	2021-12-31 00:00:00
1727	1727	1	4622	457	95	1	3	10	290.00	2824.87	2021-08-28 00:00:00
1728	1728	1	4696	457	95	1	3	1	1700.00	1528.98	2021-11-10 00:00:00
1729	1729	1	4616	457	95	1	3	9	400.00	3322.36	2021-08-22 00:00:00
1730	1730	1	4740	457	95	1	3	5	500.00	2488.23	2021-12-24 00:00:00
1731	1731	1	4480	457	95	1	3	6	1490.00	8732.86	2021-04-08 00:00:00
1732	1732	1	4607	457	95	1	3	4	100.00	273.62	2021-08-13 00:00:00
1733	1733	1	4684	457	95	1	3	1	37.00	0.01	2021-10-29 00:00:00
1734	1734	1	4852	457	95	1	3	8	46.00	231.65	2022-04-15 00:00:00
1735	1735	1	4899	457	95	1	3	6	41.00	85.74	2022-06-01 00:00:00
1736	1736	1	4641	457	95	1	3	4	2490.00	9886.01	2021-09-16 00:00:00
1737	1737	1	4886	457	95	1	3	2	550.00	991.04	2022-05-19 00:00:00
1738	1738	1	4648	457	95	1	3	4	34.00	7.14	2021-09-23 00:00:00
1739	1739	1	4796	457	95	1	3	2	460.00	695.20	2022-02-18 00:00:00
1740	1740	1	4645	457	95	1	3	8	37.00	239.33	2021-09-20 00:00:00
1741	1741	1	4753	457	95	1	3	7	1699.99	11800.44	2022-01-06 00:00:00
1742	1742	1	4420	457	95	1	3	7	450.00	2950.00	2021-02-07 00:00:00
1743	1743	1	4510	457	95	1	3	5	1700.00	8408.92	2021-05-08 00:00:00
1744	1744	1	4824	457	95	1	3	2	72.00	0.01	2022-03-18 00:00:00
1745	1745	1	4706	457	95	1	3	2	300.00	428.22	2021-11-20 00:00:00
1746	1746	1	4558	457	95	1	3	5	2490.00	12361.11	2021-06-25 00:00:00
1747	1747	1	4775	457	95	1	3	2	46.00	0.01	2022-01-28 00:00:00
1748	1748	1	4510	457	95	1	3	3	22.00	0.01	2021-05-08 00:00:00
1749	1749	1	4425	457	95	1	3	8	300.00	2321.63	2021-02-12 00:00:00
1750	1750	1	4600	457	95	1	3	7	665.00	4525.28	2021-08-06 00:00:00
1751	1751	1	4818	457	95	1	3	3	93.00	178.73	2022-03-12 00:00:00
1752	1752	1	4662	457	95	1	3	8	46.00	357.80	2021-10-07 00:00:00
1753	1753	1	4915	457	95	1	3	6	990.00	5655.01	2022-06-17 00:00:00
1754	1754	1	4491	457	95	1	3	6	249.99	1377.22	2021-04-19 00:00:00
1755	1755	1	4647	457	95	1	3	10	990.00	9681.13	2021-09-22 00:00:00
1756	1756	1	4455	457	95	1	3	5	850.00	4169.72	2021-03-14 00:00:00
1757	1757	1	4633	457	95	1	3	6	1890.00	11253.13	2021-09-08 00:00:00
1758	1758	1	4785	457	95	1	3	1	299.99	34.91	2022-02-07 00:00:00
1759	1759	1	4579	457	95	1	3	1	300.00	291.14	2021-07-16 00:00:00
1760	1760	1	4432	457	95	1	3	10	100.00	792.74	2021-02-19 00:00:00
1761	1761	1	4636	457	95	1	3	6	50.00	52.86	2021-09-11 00:00:00
1762	1762	1	4892	457	95	1	3	10	90.00	874.00	2022-05-25 00:00:00
1763	1763	1	4797	457	95	1	3	8	85.00	397.72	2022-02-19 00:00:00
1764	1764	1	4649	457	95	1	3	8	850.00	6573.15	2021-09-24 00:00:00
1765	1765	1	4639	457	95	1	3	3	390.00	995.66	2021-09-14 00:00:00
1766	1766	1	4831	457	95	1	3	4	460.00	1648.88	2022-03-25 00:00:00
1767	1767	1	4850	457	95	1	3	5	60.00	75.99	2022-04-13 00:00:00
1768	1768	1	4611	457	95	1	3	7	93.00	499.78	2021-08-17 00:00:00
1769	1769	1	4743	457	95	1	3	8	20.00	150.98	2021-12-27 00:00:00
1770	1770	1	4880	457	95	1	3	10	550.00	5322.20	2022-05-13 00:00:00
1771	1771	1	4722	457	95	1	3	3	72.00	0.01	2021-12-06 00:00:00
1772	1772	1	4914	457	95	1	3	10	400.00	3728.34	2022-06-16 00:00:00
1773	1773	1	4515	457	95	1	3	1	460.00	380.57	2021-05-13 00:00:00
1774	1774	1	4434	457	95	1	3	3	62.00	0.01	2021-02-21 00:00:00
1775	1775	1	4858	457	95	1	3	10	46.00	248.00	2022-04-21 00:00:00
1776	1776	1	4823	457	95	1	3	1	390.00	318.32	2022-03-17 00:00:00
1777	1777	1	4520	457	95	1	3	2	510.00	814.92	2021-05-18 00:00:00
1778	1778	1	4725	457	95	1	3	10	850.00	8318.35	2021-12-09 00:00:00
1779	1779	1	4478	457	95	1	3	1	249.99	99.78	2021-04-06 00:00:00
1780	1780	1	4512	457	95	1	3	5	290.00	1208.95	2021-05-10 00:00:00
1781	1781	1	4494	457	95	1	3	10	290.00	2892.33	2021-04-22 00:00:00
1782	1782	1	4896	457	95	1	3	10	100.00	979.88	2022-05-29 00:00:00
1783	1783	1	4490	457	95	1	3	7	1699.99	11623.83	2021-04-18 00:00:00
1784	1784	1	4680	457	95	1	3	4	500.00	1902.54	2021-10-25 00:00:00
1785	1785	1	4689	457	95	1	3	8	550.00	4330.84	2021-11-03 00:00:00
1786	1786	1	4537	457	95	1	3	5	100.00	487.93	2021-06-04 00:00:00
1787	1787	1	4540	457	95	1	3	1	400.00	300.92	2021-06-07 00:00:00
1788	1788	1	4644	457	95	1	3	6	420.00	2279.63	2021-09-19 00:00:00
1789	1789	1	4884	457	95	1	3	2	400.00	571.41	2022-05-17 00:00:00
1790	1790	1	4811	457	95	1	3	10	46.00	392.35	2022-03-05 00:00:00
1791	1791	1	4853	457	95	1	3	10	100.00	819.43	2022-04-16 00:00:00
1792	1792	1	4682	457	95	1	3	2	29.00	0.01	2021-10-27 00:00:00
1793	1793	1	4626	457	95	1	3	1	665.00	492.47	2021-09-01 00:00:00
1794	1794	1	4539	457	95	1	3	6	1890.00	11101.80	2021-06-06 00:00:00
1795	1795	1	4848	457	95	1	3	2	1699.99	3309.18	2022-04-11 00:00:00
1796	1796	1	4678	457	95	1	3	1	1390.00	1321.35	2021-10-23 00:00:00
1797	1797	1	4495	457	95	1	3	4	41.00	0.01	2021-04-23 00:00:00
1798	1798	1	4853	457	95	1	3	6	510.00	2815.73	2022-04-16 00:00:00
1799	1799	1	4854	457	95	1	3	3	510.00	1400.23	2022-04-17 00:00:00
1800	1800	1	4564	457	95	1	3	5	690.00	3411.35	2021-07-01 00:00:00
1801	1801	1	4698	457	95	1	3	7	450.00	2931.20	2021-11-12 00:00:00
1802	1802	1	4512	457	95	1	3	10	390.00	3793.71	2021-05-10 00:00:00
1803	1803	1	4751	457	95	1	3	4	72.00	57.43	2022-01-04 00:00:00
1804	1804	1	4818	457	95	1	3	3	1890.00	5389.32	2022-03-12 00:00:00
1805	1805	1	4592	457	95	1	3	3	490.00	1334.30	2021-07-29 00:00:00
1806	1806	1	4593	457	95	1	3	1	100.00	0.01	2021-07-30 00:00:00
1807	1807	1	4578	457	95	1	3	1	10.00	0.01	2021-07-15 00:00:00
1808	1808	1	4811	457	95	1	3	4	1890.00	7303.44	2022-03-05 00:00:00
1809	1809	1	4646	457	95	1	3	2	62.00	0.01	2021-09-21 00:00:00
1810	1810	1	4555	457	95	1	3	2	93.00	8.97	2021-06-22 00:00:00
1811	1811	1	4734	457	95	1	3	7	29.00	151.16	2021-12-18 00:00:00
1812	1812	1	4797	457	95	1	3	5	990.00	4734.24	2022-02-19 00:00:00
1813	1813	1	4494	457	95	1	3	8	93.00	739.85	2021-04-22 00:00:00
1814	1814	1	4722	457	95	1	3	3	1890.00	5579.47	2021-12-06 00:00:00
1815	1815	1	4794	457	95	1	3	1	1890.00	1682.24	2022-02-16 00:00:00
1816	1816	1	4398	457	95	1	3	8	22.00	0.01	2021-01-16 00:00:00
1817	1817	1	4654	457	95	1	3	4	550.00	2086.64	2021-09-29 00:00:00
1818	1818	1	4711	457	95	1	3	6	90.00	265.08	2021-11-25 00:00:00
1819	1819	1	4856	457	95	1	3	7	500.00	3452.95	2022-04-19 00:00:00
1820	1820	1	4490	457	95	1	3	7	20.00	93.51	2021-04-18 00:00:00
1821	1821	1	4903	457	95	1	3	6	85.00	325.63	2022-06-05 00:00:00
1822	1822	1	4537	457	95	1	3	7	400.00	2792.26	2021-06-04 00:00:00
1823	1823	1	4550	457	95	1	3	5	490.00	2284.22	2021-06-17 00:00:00
1824	1824	1	4550	457	95	1	3	9	690.00	6003.10	2021-06-17 00:00:00
1825	1825	1	4855	457	95	1	3	4	510.00	1992.92	2022-04-18 00:00:00
1826	1826	1	4649	457	95	1	3	1	420.00	160.28	2021-09-24 00:00:00
1827	1827	1	4678	457	95	1	3	9	200.00	1759.41	2021-10-23 00:00:00
1828	1828	1	4665	457	95	1	3	9	299.99	2435.95	2021-10-10 00:00:00
1829	1829	1	4479	457	95	1	3	2	690.00	1304.39	2021-04-07 00:00:00
1830	1830	1	4544	457	95	1	3	7	1699.99	11605.58	2021-06-11 00:00:00
1831	1831	1	4631	457	95	1	3	3	34.00	0.01	2021-09-06 00:00:00
1832	1832	1	4708	457	95	1	3	6	899.99	5165.27	2021-11-22 00:00:00
1833	1833	1	4518	457	95	1	3	8	29.00	197.91	2021-05-16 00:00:00
1834	1834	1	4916	457	95	1	3	10	400.00	3852.62	2022-06-18 00:00:00
1835	1835	1	4466	457	95	1	3	7	290.00	1772.87	2021-03-25 00:00:00
1836	1836	1	4429	457	95	1	3	6	1490.00	8653.88	2021-02-16 00:00:00
1837	1837	1	4916	457	95	1	3	7	460.00	3068.03	2022-06-18 00:00:00
1838	1838	1	4411	457	95	1	3	1	1890.00	1829.35	2021-01-29 00:00:00
1839	1839	1	4696	457	95	1	3	1	37.00	0.01	2021-11-10 00:00:00
1840	1840	1	4504	457	95	1	3	1	200.00	0.01	2021-05-02 00:00:00
1841	1841	1	4797	457	95	1	3	4	400.00	1527.14	2022-02-19 00:00:00
1842	1842	1	4845	457	95	1	3	8	100.00	671.95	2022-04-08 00:00:00
1843	1843	1	4830	457	95	1	3	6	100.00	443.61	2022-03-24 00:00:00
1844	1844	1	4720	457	95	1	3	5	10.00	0.01	2021-12-04 00:00:00
1845	1845	1	4899	457	95	1	3	2	34.00	0.01	2022-06-01 00:00:00
1846	1846	1	4791	457	95	1	3	7	249.99	1506.34	2022-02-13 00:00:00
1847	1847	1	4584	457	95	1	3	1	1390.00	1159.62	2021-07-21 00:00:00
1848	1848	1	4752	457	95	1	3	6	420.00	2304.83	2022-01-05 00:00:00
1849	1849	1	4734	457	95	1	3	3	390.00	1001.02	2021-12-18 00:00:00
1850	1850	1	4671	457	95	1	3	7	93.00	503.06	2021-10-16 00:00:00
1851	1851	1	4742	457	95	1	3	5	1490.00	7387.58	2021-12-26 00:00:00
1852	1852	1	4507	457	95	1	3	6	899.99	5244.16	2021-05-05 00:00:00
1853	1853	1	4485	457	95	1	3	9	665.00	5809.37	2021-04-13 00:00:00
1854	1854	1	4489	457	95	1	3	10	22.00	32.07	2021-04-17 00:00:00
1855	1855	1	4768	457	95	1	3	5	100.00	411.69	2022-01-21 00:00:00
1856	1856	1	4550	457	95	1	3	2	90.00	0.01	2021-06-17 00:00:00
1857	1857	1	4416	457	95	1	3	3	62.00	140.11	2021-02-03 00:00:00
1858	1858	1	4604	457	95	1	3	1	200.00	0.01	2021-08-10 00:00:00
1859	1859	1	4716	457	95	1	3	7	72.00	259.84	2021-11-30 00:00:00
1860	1860	1	4661	457	95	1	3	1	41.00	0.01	2021-10-06 00:00:00
1861	1861	1	4759	457	95	1	3	10	62.00	578.33	2022-01-12 00:00:00
1862	1862	1	4385	457	95	1	3	8	850.00	6794.02	2021-01-03 00:00:00
1863	1863	1	4612	457	95	1	3	9	2490.00	22165.60	2021-08-18 00:00:00
1864	1864	1	4831	457	95	1	3	5	665.00	3151.91	2022-03-25 00:00:00
1865	1865	1	4622	457	95	1	3	1	34.00	0.01	2021-08-28 00:00:00
1866	1866	1	4708	457	95	1	3	2	690.00	1272.13	2021-11-22 00:00:00
1867	1867	1	4831	457	95	1	3	6	390.00	2310.21	2022-03-25 00:00:00
1868	1868	1	4466	457	95	1	3	10	200.00	1949.48	2021-03-25 00:00:00
1869	1869	1	4624	457	95	1	3	7	34.00	234.07	2021-08-30 00:00:00
1870	1870	1	4699	457	95	1	3	5	50.00	215.94	2021-11-13 00:00:00
1871	1871	1	4800	457	95	1	3	4	300.00	1053.78	2022-02-22 00:00:00
1872	1872	1	4857	457	95	1	3	3	46.00	66.18	2022-04-20 00:00:00
1873	1873	1	4516	457	95	1	3	10	46.00	161.33	2021-05-14 00:00:00
1874	1874	1	4850	457	95	1	3	2	1390.00	2777.97	2022-04-13 00:00:00
1875	1875	1	4696	457	95	1	3	8	390.00	3039.32	2021-11-10 00:00:00
1876	1876	1	4669	457	95	1	3	7	60.00	358.08	2021-10-14 00:00:00
1877	1877	1	4498	457	95	1	3	8	420.00	3131.58	2021-04-26 00:00:00
1878	1878	1	4779	457	95	1	3	2	500.00	862.14	2022-02-01 00:00:00
1879	1879	1	4615	457	95	1	3	2	1700.00	3251.46	2021-08-21 00:00:00
1880	1880	1	4568	457	95	1	3	2	34.00	0.01	2021-07-05 00:00:00
1881	1881	1	4495	457	95	1	3	4	2490.00	9926.91	2021-04-23 00:00:00
1882	1882	1	4762	457	95	1	3	8	450.00	3541.47	2022-01-15 00:00:00
1883	1883	1	4809	457	95	1	3	8	850.00	6715.05	2022-03-03 00:00:00
1884	1884	1	4831	457	95	1	3	4	50.00	96.36	2022-03-25 00:00:00
1885	1885	1	4577	457	95	1	3	4	34.00	0.01	2021-07-14 00:00:00
1886	1886	1	4815	457	95	1	3	1	850.00	841.98	2022-03-09 00:00:00
1887	1887	1	4821	457	95	1	3	8	300.00	2366.79	2022-03-15 00:00:00
1888	1888	1	4533	457	95	1	3	1	72.00	22.51	2021-05-31 00:00:00
1889	1889	1	4480	457	95	1	3	4	390.00	1337.32	2021-04-08 00:00:00
1890	1890	1	4785	457	95	1	3	1	490.00	333.14	2022-02-07 00:00:00
1891	1891	1	4594	457	95	1	3	1	46.00	0.01	2021-07-31 00:00:00
1892	1892	1	4671	457	95	1	3	6	420.00	2434.36	2021-10-16 00:00:00
1893	1893	1	4547	457	95	1	3	4	100.00	221.59	2021-06-14 00:00:00
1894	1894	1	4669	457	95	1	3	10	420.00	3908.30	2021-10-14 00:00:00
1895	1895	1	4604	457	95	1	3	4	41.00	109.11	2021-08-10 00:00:00
1896	1896	1	4445	457	95	1	3	1	350.00	62.73	2021-03-04 00:00:00
1897	1897	1	4686	457	95	1	3	5	41.00	0.01	2021-10-31 00:00:00
1898	1898	1	4629	457	95	1	3	9	2490.00	22161.35	2021-09-04 00:00:00
1899	1899	1	4509	457	95	1	3	7	34.00	197.92	2021-05-07 00:00:00
1900	1900	1	4560	457	95	1	3	9	490.00	4310.94	2021-06-27 00:00:00
1901	1901	1	4490	457	95	1	3	7	29.00	0.01	2021-04-18 00:00:00
1902	1902	1	4580	457	95	1	3	6	420.00	2301.00	2021-07-17 00:00:00
1903	1903	1	4744	457	95	1	3	3	550.00	1549.01	2021-12-28 00:00:00
1904	1904	1	4389	457	95	1	3	6	420.00	2315.51	2021-01-07 00:00:00
1905	1905	1	4671	457	95	1	3	8	420.00	3222.33	2021-10-16 00:00:00
1906	1906	1	4640	457	95	1	3	8	34.00	244.01	2021-09-15 00:00:00
1907	1907	1	4791	457	95	1	3	1	249.99	238.05	2022-02-13 00:00:00
1908	1908	1	4641	457	95	1	3	5	290.00	1301.26	2021-09-16 00:00:00
1909	1909	1	4629	457	95	1	3	3	665.00	1730.47	2021-09-04 00:00:00
1910	1910	1	4495	457	95	1	3	3	1890.00	5600.88	2021-04-23 00:00:00
1911	1911	1	4523	457	95	1	3	3	1700.00	4997.02	2021-05-21 00:00:00
1912	1912	1	4529	457	95	1	3	5	50.00	0.01	2021-05-27 00:00:00
1913	1913	1	4504	457	95	1	3	10	72.00	607.22	2021-05-02 00:00:00
1914	1914	1	4633	457	95	1	3	6	100.00	599.50	2021-09-08 00:00:00
1915	1915	1	4760	457	95	1	3	3	29.00	34.66	2022-01-13 00:00:00
1916	1916	1	4408	457	95	1	3	6	10.00	0.01	2021-01-26 00:00:00
1917	1917	1	4897	457	95	1	3	7	510.00	3403.98	2022-05-30 00:00:00
1918	1918	1	4570	457	95	1	3	6	550.00	3073.23	2021-07-07 00:00:00
1919	1919	1	4843	457	95	1	3	5	990.00	4790.34	2022-04-06 00:00:00
1920	1920	1	4621	457	95	1	3	3	46.00	0.01	2021-08-27 00:00:00
1921	1921	1	4824	457	95	1	3	9	29.00	241.36	2022-03-18 00:00:00
1922	1922	1	4708	457	95	1	3	2	22.00	0.01	2021-11-22 00:00:00
1923	1923	1	4896	457	95	1	3	10	50.00	329.45	2022-05-29 00:00:00
1924	1924	1	4460	457	95	1	3	7	420.00	2869.91	2021-03-19 00:00:00
1925	1925	1	4781	457	95	1	3	8	420.00	3213.71	2022-02-03 00:00:00
1926	1926	1	4886	457	95	1	3	5	60.00	91.07	2022-05-19 00:00:00
1927	1927	1	4772	457	95	1	3	8	990.00	7709.60	2022-01-25 00:00:00
1928	1928	1	4659	457	95	1	3	10	90.00	624.98	2021-10-04 00:00:00
1929	1929	1	4665	457	95	1	3	5	22.00	108.26	2021-10-10 00:00:00
1930	1930	1	4652	457	95	1	3	10	420.00	3999.12	2021-09-27 00:00:00
1931	1931	1	4589	457	95	1	3	9	249.99	2028.87	2021-07-26 00:00:00
1932	1932	1	4823	457	95	1	3	8	490.00	3768.41	2022-03-17 00:00:00
1933	1933	1	4514	457	95	1	3	2	34.00	0.01	2021-05-12 00:00:00
1934	1934	1	4737	457	95	1	3	4	90.00	203.19	2021-12-21 00:00:00
1935	1935	1	4684	457	95	1	3	9	390.00	3384.05	2021-10-29 00:00:00
1936	1936	1	4911	457	95	1	3	9	510.00	4567.18	2022-06-13 00:00:00
1937	1937	1	4897	457	95	1	3	3	490.00	1332.86	2022-05-30 00:00:00
1938	1938	1	4605	457	95	1	3	3	510.00	1375.21	2021-08-11 00:00:00
1939	1939	1	4479	457	95	1	3	2	500.00	874.58	2021-04-07 00:00:00
1940	1940	1	4845	457	95	1	3	6	20.00	0.01	2022-04-08 00:00:00
1941	1941	1	4413	457	95	1	3	10	34.00	159.91	2021-01-31 00:00:00
1942	1942	1	4645	457	95	1	3	1	299.99	267.96	2021-09-20 00:00:00
1943	1943	1	4424	457	95	1	3	9	29.00	236.07	2021-02-11 00:00:00
1944	1944	1	4609	457	95	1	3	6	1700.00	9998.87	2021-08-15 00:00:00
1945	1945	1	4795	457	95	1	3	1	249.99	128.36	2022-02-17 00:00:00
1946	1946	1	4474	457	95	1	3	8	1890.00	15044.80	2021-04-02 00:00:00
1947	1947	1	4774	457	95	1	3	1	550.00	360.05	2022-01-27 00:00:00
1948	1948	1	4761	457	95	1	3	3	22.00	0.01	2022-01-14 00:00:00
1949	1949	1	4420	457	95	1	3	4	62.00	0.01	2021-02-07 00:00:00
1950	1950	1	4688	457	95	1	3	8	2490.00	19742.06	2021-11-02 00:00:00
1951	1951	1	4437	457	95	1	3	7	100.00	597.11	2021-02-24 00:00:00
1952	1952	1	4851	457	95	1	3	8	34.00	271.00	2022-04-14 00:00:00
1953	1953	1	4626	457	95	1	3	6	200.00	1147.15	2021-09-01 00:00:00
1954	1954	1	4706	457	95	1	3	10	62.00	564.56	2021-11-20 00:00:00
1955	1955	1	4892	457	95	1	3	9	1490.00	13249.80	2022-05-25 00:00:00
1956	1956	1	4416	457	95	1	3	6	10.00	0.01	2021-02-03 00:00:00
1957	1957	1	4915	457	95	1	3	2	46.00	63.90	2022-06-17 00:00:00
1958	1958	1	4856	457	95	1	3	4	50.00	123.93	2022-04-19 00:00:00
1959	1959	1	4546	457	95	1	3	5	1490.00	7327.99	2021-06-13 00:00:00
1960	1960	1	4750	457	95	1	3	10	1700.00	16919.57	2022-01-03 00:00:00
1961	1961	1	4608	457	95	1	3	7	249.99	1554.35	2021-08-14 00:00:00
1962	1962	1	4441	457	95	1	3	8	290.00	2106.38	2021-02-28 00:00:00
1963	1963	1	4697	457	95	1	3	3	1890.00	5643.76	2021-11-11 00:00:00
1964	1964	1	4625	457	95	1	3	3	1700.00	4867.48	2021-08-31 00:00:00
1965	1965	1	4687	457	95	1	3	7	29.00	147.31	2021-11-01 00:00:00
1966	1966	1	4654	457	95	1	3	7	93.00	574.45	2021-09-29 00:00:00
1967	1967	1	4797	457	95	1	3	7	990.00	6891.08	2022-02-19 00:00:00
1968	1968	1	4595	457	95	1	3	1	85.00	0.01	2021-08-01 00:00:00
1969	1969	1	4662	457	95	1	3	2	300.00	551.37	2021-10-07 00:00:00
1970	1970	1	4810	457	95	1	3	3	300.00	644.58	2022-03-04 00:00:00
1971	1971	1	4896	457	95	1	3	7	300.00	1845.30	2022-05-29 00:00:00
1972	1972	1	4545	457	95	1	3	4	460.00	1643.40	2021-06-12 00:00:00
1973	1973	1	4785	457	95	1	3	9	100.00	644.17	2022-02-07 00:00:00
1974	1974	1	4615	457	95	1	3	4	690.00	2722.55	2021-08-21 00:00:00
1975	1975	1	4504	457	95	1	3	9	300.00	2436.96	2021-05-02 00:00:00
1976	1976	1	4751	457	95	1	3	5	100.00	375.36	2022-01-04 00:00:00
1977	1977	1	4811	457	95	1	3	5	100.00	382.60	2022-03-05 00:00:00
1978	1978	1	4585	457	95	1	3	7	90.00	500.14	2021-07-22 00:00:00
1979	1979	1	4611	457	95	1	3	3	62.00	174.11	2021-08-17 00:00:00
1980	1980	1	4736	457	95	1	3	2	20.00	0.01	2021-12-20 00:00:00
1981	1981	1	4761	457	95	1	3	3	34.00	0.01	2022-01-14 00:00:00
1982	1982	1	4599	457	95	1	3	2	460.00	871.85	2021-08-05 00:00:00
1983	1983	1	4616	457	95	1	3	7	249.99	1487.61	2021-08-22 00:00:00
1984	1984	1	4568	457	95	1	3	2	510.00	778.38	2021-07-05 00:00:00
1985	1985	1	4479	457	95	1	3	1	50.00	17.65	2021-04-07 00:00:00
1986	1986	1	4832	457	95	1	3	10	690.00	6875.66	2022-03-26 00:00:00
1987	1987	1	4564	457	95	1	3	4	420.00	1500.70	2021-07-01 00:00:00
1988	1988	1	4662	457	95	1	3	3	90.00	20.03	2021-10-07 00:00:00
1989	1989	1	4795	457	95	1	3	6	460.00	2503.08	2022-02-17 00:00:00
1990	1990	1	4568	457	95	1	3	1	85.00	0.01	2021-07-05 00:00:00
1991	1991	1	4676	457	95	1	3	1	1490.00	1230.48	2021-10-21 00:00:00
1992	1992	1	4411	457	95	1	3	3	100.00	17.57	2021-01-29 00:00:00
1993	1993	1	4540	457	95	1	3	6	34.00	18.57	2021-06-07 00:00:00
1994	1994	1	4695	457	95	1	3	4	20.00	0.01	2021-11-09 00:00:00
1995	1995	1	4590	457	95	1	3	1	899.99	782.21	2021-07-27 00:00:00
1996	1996	1	4466	457	95	1	3	7	46.00	150.55	2021-03-25 00:00:00
1997	1997	1	4865	457	95	1	3	8	29.00	77.60	2022-04-28 00:00:00
1998	1998	1	4698	457	95	1	3	6	2490.00	14877.02	2021-11-12 00:00:00
1999	1999	1	4606	457	95	1	3	2	400.00	716.71	2021-08-12 00:00:00
2000	2000	1	4680	457	95	1	3	10	400.00	3759.41	2021-10-25 00:00:00
\.


--
-- Data for Name: dim_localizacao; Type: TABLE DATA; Schema: geral; Owner: postgres
--

COPY geral.dim_localizacao (id_localizacao, cidade, estado, regiao, valor_frete) FROM stdin;
3	S├úo Paulo	SP	Sudeste	25.00
4	S├úo Mateus	SP	Sudeste	30.00
5	Guarulhos	SP	Sudeste	35.00
6	Santo Andr├®	SP	Sudeste	32.00
7	Mau├í	SP	Sudeste	33.00
8	Mooca	SP	Sudeste	28.00
9	Tiradentes	SP	Sudeste	29.00
10	Embu das Artes	SP	Sudeste	40.00
11	Tucuruvi	SP	Sudeste	27.00
12	Vila Formosa	SP	Sudeste	28.00
13	Aricanduva	SP	Sudeste	29.00
14	Vila Ema	SP	Sudeste	30.00
15	Ipiranga	SP	Sudeste	26.00
16	Itaquera	SP	Sudeste	31.00
17	Sapopemba	SP	Sudeste	30.00
18	Tatuap├®	SP	Sudeste	27.00
19	Centro	SP	Sudeste	25.00
20	Jd. Santo Andr├®	SP	Sudeste	32.00
21	Jd. Limoeiro	SP	Sudeste	31.00
22	Jd. Santa Ad├®lia	SP	Sudeste	31.00
23	Jd. Sapopemba	SP	Sudeste	30.00
24	Jd. Adutora	SP	Sudeste	31.00
25	S├úo Jos├® do Rio Preto	SP	Sudeste	55.00
26	Indaiatuba	SP	Sudeste	50.00
27	S├úo Bernardo	SP	Sudeste	35.00
28	Avar├®	SP	Sudeste	48.00
29	Campinas	SP	Sudeste	48.00
30	Osasco	SP	Sudeste	30.00
31	Santos	SP	Sudeste	60.00
32	Sorocaba	SP	Sudeste	52.00
33	Ribeir├úo Preto	SP	Sudeste	58.00
34	Bauru	SP	Sudeste	56.00
35	Ara├ºatuba	SP	Sudeste	60.00
36	Rio de Janeiro	RJ	Sudeste	45.00
37	Belo Horizonte	MG	Sudeste	50.00
38	Curitiba	PR	Sul	70.00
39	Porto Alegre	RS	Sul	85.00
40	Salvador	BA	Nordeste	95.00
41	Bras├¡lia	DF	Centro-Oeste	75.00
\.


--
-- Data for Name: dim_tempo; Type: TABLE DATA; Schema: geral; Owner: postgres
--

COPY geral.dim_tempo (id_tempo, data, dia, mes, nome_mes, trimestre, ano, dia_semana) FROM stdin;
4383	2021-01-01	1	1	Janeiro	1	2021	Sexta-feira
4384	2021-01-02	2	1	Janeiro	1	2021	S├íbado
4385	2021-01-03	3	1	Janeiro	1	2021	Domingo
4386	2021-01-04	4	1	Janeiro	1	2021	Segunda-feira
4387	2021-01-05	5	1	Janeiro	1	2021	Ter├ºa-feira
4388	2021-01-06	6	1	Janeiro	1	2021	Quarta-feira
4389	2021-01-07	7	1	Janeiro	1	2021	Quinta-feira
4390	2021-01-08	8	1	Janeiro	1	2021	Sexta-feira
4391	2021-01-09	9	1	Janeiro	1	2021	S├íbado
4392	2021-01-10	10	1	Janeiro	1	2021	Domingo
4393	2021-01-11	11	1	Janeiro	1	2021	Segunda-feira
4394	2021-01-12	12	1	Janeiro	1	2021	Ter├ºa-feira
4395	2021-01-13	13	1	Janeiro	1	2021	Quarta-feira
4396	2021-01-14	14	1	Janeiro	1	2021	Quinta-feira
4397	2021-01-15	15	1	Janeiro	1	2021	Sexta-feira
4398	2021-01-16	16	1	Janeiro	1	2021	S├íbado
4399	2021-01-17	17	1	Janeiro	1	2021	Domingo
4400	2021-01-18	18	1	Janeiro	1	2021	Segunda-feira
4401	2021-01-19	19	1	Janeiro	1	2021	Ter├ºa-feira
4402	2021-01-20	20	1	Janeiro	1	2021	Quarta-feira
4403	2021-01-21	21	1	Janeiro	1	2021	Quinta-feira
4404	2021-01-22	22	1	Janeiro	1	2021	Sexta-feira
4405	2021-01-23	23	1	Janeiro	1	2021	S├íbado
4406	2021-01-24	24	1	Janeiro	1	2021	Domingo
4407	2021-01-25	25	1	Janeiro	1	2021	Segunda-feira
4408	2021-01-26	26	1	Janeiro	1	2021	Ter├ºa-feira
4409	2021-01-27	27	1	Janeiro	1	2021	Quarta-feira
4410	2021-01-28	28	1	Janeiro	1	2021	Quinta-feira
4411	2021-01-29	29	1	Janeiro	1	2021	Sexta-feira
4412	2021-01-30	30	1	Janeiro	1	2021	S├íbado
4413	2021-01-31	31	1	Janeiro	1	2021	Domingo
4414	2021-02-01	1	2	Fevereiro	1	2021	Segunda-feira
4415	2021-02-02	2	2	Fevereiro	1	2021	Ter├ºa-feira
4416	2021-02-03	3	2	Fevereiro	1	2021	Quarta-feira
4417	2021-02-04	4	2	Fevereiro	1	2021	Quinta-feira
4418	2021-02-05	5	2	Fevereiro	1	2021	Sexta-feira
4419	2021-02-06	6	2	Fevereiro	1	2021	S├íbado
4420	2021-02-07	7	2	Fevereiro	1	2021	Domingo
4421	2021-02-08	8	2	Fevereiro	1	2021	Segunda-feira
4422	2021-02-09	9	2	Fevereiro	1	2021	Ter├ºa-feira
4423	2021-02-10	10	2	Fevereiro	1	2021	Quarta-feira
4424	2021-02-11	11	2	Fevereiro	1	2021	Quinta-feira
4425	2021-02-12	12	2	Fevereiro	1	2021	Sexta-feira
4426	2021-02-13	13	2	Fevereiro	1	2021	S├íbado
4427	2021-02-14	14	2	Fevereiro	1	2021	Domingo
4428	2021-02-15	15	2	Fevereiro	1	2021	Segunda-feira
4429	2021-02-16	16	2	Fevereiro	1	2021	Ter├ºa-feira
4430	2021-02-17	17	2	Fevereiro	1	2021	Quarta-feira
4431	2021-02-18	18	2	Fevereiro	1	2021	Quinta-feira
4432	2021-02-19	19	2	Fevereiro	1	2021	Sexta-feira
4433	2021-02-20	20	2	Fevereiro	1	2021	S├íbado
4434	2021-02-21	21	2	Fevereiro	1	2021	Domingo
4435	2021-02-22	22	2	Fevereiro	1	2021	Segunda-feira
4436	2021-02-23	23	2	Fevereiro	1	2021	Ter├ºa-feira
4437	2021-02-24	24	2	Fevereiro	1	2021	Quarta-feira
4438	2021-02-25	25	2	Fevereiro	1	2021	Quinta-feira
4439	2021-02-26	26	2	Fevereiro	1	2021	Sexta-feira
4440	2021-02-27	27	2	Fevereiro	1	2021	S├íbado
4441	2021-02-28	28	2	Fevereiro	1	2021	Domingo
4442	2021-03-01	1	3	Mar├ºo	1	2021	Segunda-feira
4443	2021-03-02	2	3	Mar├ºo	1	2021	Ter├ºa-feira
4444	2021-03-03	3	3	Mar├ºo	1	2021	Quarta-feira
4445	2021-03-04	4	3	Mar├ºo	1	2021	Quinta-feira
4446	2021-03-05	5	3	Mar├ºo	1	2021	Sexta-feira
4447	2021-03-06	6	3	Mar├ºo	1	2021	S├íbado
4448	2021-03-07	7	3	Mar├ºo	1	2021	Domingo
4449	2021-03-08	8	3	Mar├ºo	1	2021	Segunda-feira
4450	2021-03-09	9	3	Mar├ºo	1	2021	Ter├ºa-feira
4451	2021-03-10	10	3	Mar├ºo	1	2021	Quarta-feira
4452	2021-03-11	11	3	Mar├ºo	1	2021	Quinta-feira
4453	2021-03-12	12	3	Mar├ºo	1	2021	Sexta-feira
4454	2021-03-13	13	3	Mar├ºo	1	2021	S├íbado
4455	2021-03-14	14	3	Mar├ºo	1	2021	Domingo
4456	2021-03-15	15	3	Mar├ºo	1	2021	Segunda-feira
4457	2021-03-16	16	3	Mar├ºo	1	2021	Ter├ºa-feira
4458	2021-03-17	17	3	Mar├ºo	1	2021	Quarta-feira
4459	2021-03-18	18	3	Mar├ºo	1	2021	Quinta-feira
4460	2021-03-19	19	3	Mar├ºo	1	2021	Sexta-feira
4461	2021-03-20	20	3	Mar├ºo	1	2021	S├íbado
4462	2021-03-21	21	3	Mar├ºo	1	2021	Domingo
4463	2021-03-22	22	3	Mar├ºo	1	2021	Segunda-feira
4464	2021-03-23	23	3	Mar├ºo	1	2021	Ter├ºa-feira
4465	2021-03-24	24	3	Mar├ºo	1	2021	Quarta-feira
4466	2021-03-25	25	3	Mar├ºo	1	2021	Quinta-feira
4467	2021-03-26	26	3	Mar├ºo	1	2021	Sexta-feira
4468	2021-03-27	27	3	Mar├ºo	1	2021	S├íbado
4469	2021-03-28	28	3	Mar├ºo	1	2021	Domingo
4470	2021-03-29	29	3	Mar├ºo	1	2021	Segunda-feira
4471	2021-03-30	30	3	Mar├ºo	1	2021	Ter├ºa-feira
4472	2021-03-31	31	3	Mar├ºo	1	2021	Quarta-feira
4473	2021-04-01	1	4	Abril	2	2021	Quinta-feira
4474	2021-04-02	2	4	Abril	2	2021	Sexta-feira
4475	2021-04-03	3	4	Abril	2	2021	S├íbado
4476	2021-04-04	4	4	Abril	2	2021	Domingo
4477	2021-04-05	5	4	Abril	2	2021	Segunda-feira
4478	2021-04-06	6	4	Abril	2	2021	Ter├ºa-feira
4479	2021-04-07	7	4	Abril	2	2021	Quarta-feira
4480	2021-04-08	8	4	Abril	2	2021	Quinta-feira
4481	2021-04-09	9	4	Abril	2	2021	Sexta-feira
4482	2021-04-10	10	4	Abril	2	2021	S├íbado
4483	2021-04-11	11	4	Abril	2	2021	Domingo
4484	2021-04-12	12	4	Abril	2	2021	Segunda-feira
4485	2021-04-13	13	4	Abril	2	2021	Ter├ºa-feira
4486	2021-04-14	14	4	Abril	2	2021	Quarta-feira
4487	2021-04-15	15	4	Abril	2	2021	Quinta-feira
4488	2021-04-16	16	4	Abril	2	2021	Sexta-feira
4489	2021-04-17	17	4	Abril	2	2021	S├íbado
4490	2021-04-18	18	4	Abril	2	2021	Domingo
4491	2021-04-19	19	4	Abril	2	2021	Segunda-feira
4492	2021-04-20	20	4	Abril	2	2021	Ter├ºa-feira
4493	2021-04-21	21	4	Abril	2	2021	Quarta-feira
4494	2021-04-22	22	4	Abril	2	2021	Quinta-feira
4495	2021-04-23	23	4	Abril	2	2021	Sexta-feira
4496	2021-04-24	24	4	Abril	2	2021	S├íbado
4497	2021-04-25	25	4	Abril	2	2021	Domingo
4498	2021-04-26	26	4	Abril	2	2021	Segunda-feira
4499	2021-04-27	27	4	Abril	2	2021	Ter├ºa-feira
4500	2021-04-28	28	4	Abril	2	2021	Quarta-feira
4501	2021-04-29	29	4	Abril	2	2021	Quinta-feira
4502	2021-04-30	30	4	Abril	2	2021	Sexta-feira
4503	2021-05-01	1	5	Maio	2	2021	S├íbado
4504	2021-05-02	2	5	Maio	2	2021	Domingo
4505	2021-05-03	3	5	Maio	2	2021	Segunda-feira
4506	2021-05-04	4	5	Maio	2	2021	Ter├ºa-feira
4507	2021-05-05	5	5	Maio	2	2021	Quarta-feira
4508	2021-05-06	6	5	Maio	2	2021	Quinta-feira
4509	2021-05-07	7	5	Maio	2	2021	Sexta-feira
4510	2021-05-08	8	5	Maio	2	2021	S├íbado
4511	2021-05-09	9	5	Maio	2	2021	Domingo
4512	2021-05-10	10	5	Maio	2	2021	Segunda-feira
4513	2021-05-11	11	5	Maio	2	2021	Ter├ºa-feira
4514	2021-05-12	12	5	Maio	2	2021	Quarta-feira
4515	2021-05-13	13	5	Maio	2	2021	Quinta-feira
4516	2021-05-14	14	5	Maio	2	2021	Sexta-feira
4517	2021-05-15	15	5	Maio	2	2021	S├íbado
4518	2021-05-16	16	5	Maio	2	2021	Domingo
4519	2021-05-17	17	5	Maio	2	2021	Segunda-feira
4520	2021-05-18	18	5	Maio	2	2021	Ter├ºa-feira
4521	2021-05-19	19	5	Maio	2	2021	Quarta-feira
4522	2021-05-20	20	5	Maio	2	2021	Quinta-feira
4523	2021-05-21	21	5	Maio	2	2021	Sexta-feira
4524	2021-05-22	22	5	Maio	2	2021	S├íbado
4525	2021-05-23	23	5	Maio	2	2021	Domingo
4526	2021-05-24	24	5	Maio	2	2021	Segunda-feira
4527	2021-05-25	25	5	Maio	2	2021	Ter├ºa-feira
4528	2021-05-26	26	5	Maio	2	2021	Quarta-feira
4529	2021-05-27	27	5	Maio	2	2021	Quinta-feira
4530	2021-05-28	28	5	Maio	2	2021	Sexta-feira
4531	2021-05-29	29	5	Maio	2	2021	S├íbado
4532	2021-05-30	30	5	Maio	2	2021	Domingo
4533	2021-05-31	31	5	Maio	2	2021	Segunda-feira
4534	2021-06-01	1	6	Junho	2	2021	Ter├ºa-feira
4535	2021-06-02	2	6	Junho	2	2021	Quarta-feira
4536	2021-06-03	3	6	Junho	2	2021	Quinta-feira
4537	2021-06-04	4	6	Junho	2	2021	Sexta-feira
4538	2021-06-05	5	6	Junho	2	2021	S├íbado
4539	2021-06-06	6	6	Junho	2	2021	Domingo
4540	2021-06-07	7	6	Junho	2	2021	Segunda-feira
4541	2021-06-08	8	6	Junho	2	2021	Ter├ºa-feira
4542	2021-06-09	9	6	Junho	2	2021	Quarta-feira
4543	2021-06-10	10	6	Junho	2	2021	Quinta-feira
4544	2021-06-11	11	6	Junho	2	2021	Sexta-feira
4545	2021-06-12	12	6	Junho	2	2021	S├íbado
4546	2021-06-13	13	6	Junho	2	2021	Domingo
4547	2021-06-14	14	6	Junho	2	2021	Segunda-feira
4548	2021-06-15	15	6	Junho	2	2021	Ter├ºa-feira
4549	2021-06-16	16	6	Junho	2	2021	Quarta-feira
4550	2021-06-17	17	6	Junho	2	2021	Quinta-feira
4551	2021-06-18	18	6	Junho	2	2021	Sexta-feira
4552	2021-06-19	19	6	Junho	2	2021	S├íbado
4553	2021-06-20	20	6	Junho	2	2021	Domingo
4554	2021-06-21	21	6	Junho	2	2021	Segunda-feira
4555	2021-06-22	22	6	Junho	2	2021	Ter├ºa-feira
4556	2021-06-23	23	6	Junho	2	2021	Quarta-feira
4557	2021-06-24	24	6	Junho	2	2021	Quinta-feira
4558	2021-06-25	25	6	Junho	2	2021	Sexta-feira
4559	2021-06-26	26	6	Junho	2	2021	S├íbado
4560	2021-06-27	27	6	Junho	2	2021	Domingo
4561	2021-06-28	28	6	Junho	2	2021	Segunda-feira
4562	2021-06-29	29	6	Junho	2	2021	Ter├ºa-feira
4563	2021-06-30	30	6	Junho	2	2021	Quarta-feira
4564	2021-07-01	1	7	Julho	3	2021	Quinta-feira
4565	2021-07-02	2	7	Julho	3	2021	Sexta-feira
4566	2021-07-03	3	7	Julho	3	2021	S├íbado
4567	2021-07-04	4	7	Julho	3	2021	Domingo
4568	2021-07-05	5	7	Julho	3	2021	Segunda-feira
4569	2021-07-06	6	7	Julho	3	2021	Ter├ºa-feira
4570	2021-07-07	7	7	Julho	3	2021	Quarta-feira
4571	2021-07-08	8	7	Julho	3	2021	Quinta-feira
4572	2021-07-09	9	7	Julho	3	2021	Sexta-feira
4573	2021-07-10	10	7	Julho	3	2021	S├íbado
4574	2021-07-11	11	7	Julho	3	2021	Domingo
4575	2021-07-12	12	7	Julho	3	2021	Segunda-feira
4576	2021-07-13	13	7	Julho	3	2021	Ter├ºa-feira
4577	2021-07-14	14	7	Julho	3	2021	Quarta-feira
4578	2021-07-15	15	7	Julho	3	2021	Quinta-feira
4579	2021-07-16	16	7	Julho	3	2021	Sexta-feira
4580	2021-07-17	17	7	Julho	3	2021	S├íbado
4581	2021-07-18	18	7	Julho	3	2021	Domingo
4582	2021-07-19	19	7	Julho	3	2021	Segunda-feira
4583	2021-07-20	20	7	Julho	3	2021	Ter├ºa-feira
4584	2021-07-21	21	7	Julho	3	2021	Quarta-feira
4585	2021-07-22	22	7	Julho	3	2021	Quinta-feira
4586	2021-07-23	23	7	Julho	3	2021	Sexta-feira
4587	2021-07-24	24	7	Julho	3	2021	S├íbado
4588	2021-07-25	25	7	Julho	3	2021	Domingo
4589	2021-07-26	26	7	Julho	3	2021	Segunda-feira
4590	2021-07-27	27	7	Julho	3	2021	Ter├ºa-feira
4591	2021-07-28	28	7	Julho	3	2021	Quarta-feira
4592	2021-07-29	29	7	Julho	3	2021	Quinta-feira
4593	2021-07-30	30	7	Julho	3	2021	Sexta-feira
4594	2021-07-31	31	7	Julho	3	2021	S├íbado
4595	2021-08-01	1	8	Agosto	3	2021	Domingo
4596	2021-08-02	2	8	Agosto	3	2021	Segunda-feira
4597	2021-08-03	3	8	Agosto	3	2021	Ter├ºa-feira
4598	2021-08-04	4	8	Agosto	3	2021	Quarta-feira
4599	2021-08-05	5	8	Agosto	3	2021	Quinta-feira
4600	2021-08-06	6	8	Agosto	3	2021	Sexta-feira
4601	2021-08-07	7	8	Agosto	3	2021	S├íbado
4602	2021-08-08	8	8	Agosto	3	2021	Domingo
4603	2021-08-09	9	8	Agosto	3	2021	Segunda-feira
4604	2021-08-10	10	8	Agosto	3	2021	Ter├ºa-feira
4605	2021-08-11	11	8	Agosto	3	2021	Quarta-feira
4606	2021-08-12	12	8	Agosto	3	2021	Quinta-feira
4607	2021-08-13	13	8	Agosto	3	2021	Sexta-feira
4608	2021-08-14	14	8	Agosto	3	2021	S├íbado
4609	2021-08-15	15	8	Agosto	3	2021	Domingo
4610	2021-08-16	16	8	Agosto	3	2021	Segunda-feira
4611	2021-08-17	17	8	Agosto	3	2021	Ter├ºa-feira
4612	2021-08-18	18	8	Agosto	3	2021	Quarta-feira
4613	2021-08-19	19	8	Agosto	3	2021	Quinta-feira
4614	2021-08-20	20	8	Agosto	3	2021	Sexta-feira
4615	2021-08-21	21	8	Agosto	3	2021	S├íbado
4616	2021-08-22	22	8	Agosto	3	2021	Domingo
4617	2021-08-23	23	8	Agosto	3	2021	Segunda-feira
4618	2021-08-24	24	8	Agosto	3	2021	Ter├ºa-feira
4619	2021-08-25	25	8	Agosto	3	2021	Quarta-feira
4620	2021-08-26	26	8	Agosto	3	2021	Quinta-feira
4621	2021-08-27	27	8	Agosto	3	2021	Sexta-feira
4622	2021-08-28	28	8	Agosto	3	2021	S├íbado
4623	2021-08-29	29	8	Agosto	3	2021	Domingo
4624	2021-08-30	30	8	Agosto	3	2021	Segunda-feira
4625	2021-08-31	31	8	Agosto	3	2021	Ter├ºa-feira
4626	2021-09-01	1	9	Setembro	3	2021	Quarta-feira
4627	2021-09-02	2	9	Setembro	3	2021	Quinta-feira
4628	2021-09-03	3	9	Setembro	3	2021	Sexta-feira
4629	2021-09-04	4	9	Setembro	3	2021	S├íbado
4630	2021-09-05	5	9	Setembro	3	2021	Domingo
4631	2021-09-06	6	9	Setembro	3	2021	Segunda-feira
4632	2021-09-07	7	9	Setembro	3	2021	Ter├ºa-feira
4633	2021-09-08	8	9	Setembro	3	2021	Quarta-feira
4634	2021-09-09	9	9	Setembro	3	2021	Quinta-feira
4635	2021-09-10	10	9	Setembro	3	2021	Sexta-feira
4636	2021-09-11	11	9	Setembro	3	2021	S├íbado
4637	2021-09-12	12	9	Setembro	3	2021	Domingo
4638	2021-09-13	13	9	Setembro	3	2021	Segunda-feira
4639	2021-09-14	14	9	Setembro	3	2021	Ter├ºa-feira
4640	2021-09-15	15	9	Setembro	3	2021	Quarta-feira
4641	2021-09-16	16	9	Setembro	3	2021	Quinta-feira
4642	2021-09-17	17	9	Setembro	3	2021	Sexta-feira
4643	2021-09-18	18	9	Setembro	3	2021	S├íbado
4644	2021-09-19	19	9	Setembro	3	2021	Domingo
4645	2021-09-20	20	9	Setembro	3	2021	Segunda-feira
4646	2021-09-21	21	9	Setembro	3	2021	Ter├ºa-feira
4647	2021-09-22	22	9	Setembro	3	2021	Quarta-feira
4648	2021-09-23	23	9	Setembro	3	2021	Quinta-feira
4649	2021-09-24	24	9	Setembro	3	2021	Sexta-feira
4650	2021-09-25	25	9	Setembro	3	2021	S├íbado
4651	2021-09-26	26	9	Setembro	3	2021	Domingo
4652	2021-09-27	27	9	Setembro	3	2021	Segunda-feira
4653	2021-09-28	28	9	Setembro	3	2021	Ter├ºa-feira
4654	2021-09-29	29	9	Setembro	3	2021	Quarta-feira
4655	2021-09-30	30	9	Setembro	3	2021	Quinta-feira
4656	2021-10-01	1	10	Outubro	4	2021	Sexta-feira
4657	2021-10-02	2	10	Outubro	4	2021	S├íbado
4658	2021-10-03	3	10	Outubro	4	2021	Domingo
4659	2021-10-04	4	10	Outubro	4	2021	Segunda-feira
4660	2021-10-05	5	10	Outubro	4	2021	Ter├ºa-feira
4661	2021-10-06	6	10	Outubro	4	2021	Quarta-feira
4662	2021-10-07	7	10	Outubro	4	2021	Quinta-feira
4663	2021-10-08	8	10	Outubro	4	2021	Sexta-feira
4664	2021-10-09	9	10	Outubro	4	2021	S├íbado
4665	2021-10-10	10	10	Outubro	4	2021	Domingo
4666	2021-10-11	11	10	Outubro	4	2021	Segunda-feira
4667	2021-10-12	12	10	Outubro	4	2021	Ter├ºa-feira
4668	2021-10-13	13	10	Outubro	4	2021	Quarta-feira
4669	2021-10-14	14	10	Outubro	4	2021	Quinta-feira
4670	2021-10-15	15	10	Outubro	4	2021	Sexta-feira
4671	2021-10-16	16	10	Outubro	4	2021	S├íbado
4672	2021-10-17	17	10	Outubro	4	2021	Domingo
4673	2021-10-18	18	10	Outubro	4	2021	Segunda-feira
4674	2021-10-19	19	10	Outubro	4	2021	Ter├ºa-feira
4675	2021-10-20	20	10	Outubro	4	2021	Quarta-feira
4676	2021-10-21	21	10	Outubro	4	2021	Quinta-feira
4677	2021-10-22	22	10	Outubro	4	2021	Sexta-feira
4678	2021-10-23	23	10	Outubro	4	2021	S├íbado
4679	2021-10-24	24	10	Outubro	4	2021	Domingo
4680	2021-10-25	25	10	Outubro	4	2021	Segunda-feira
4681	2021-10-26	26	10	Outubro	4	2021	Ter├ºa-feira
4682	2021-10-27	27	10	Outubro	4	2021	Quarta-feira
4683	2021-10-28	28	10	Outubro	4	2021	Quinta-feira
4684	2021-10-29	29	10	Outubro	4	2021	Sexta-feira
4685	2021-10-30	30	10	Outubro	4	2021	S├íbado
4686	2021-10-31	31	10	Outubro	4	2021	Domingo
4687	2021-11-01	1	11	Novembro	4	2021	Segunda-feira
4688	2021-11-02	2	11	Novembro	4	2021	Ter├ºa-feira
4689	2021-11-03	3	11	Novembro	4	2021	Quarta-feira
4690	2021-11-04	4	11	Novembro	4	2021	Quinta-feira
4691	2021-11-05	5	11	Novembro	4	2021	Sexta-feira
4692	2021-11-06	6	11	Novembro	4	2021	S├íbado
4693	2021-11-07	7	11	Novembro	4	2021	Domingo
4694	2021-11-08	8	11	Novembro	4	2021	Segunda-feira
4695	2021-11-09	9	11	Novembro	4	2021	Ter├ºa-feira
4696	2021-11-10	10	11	Novembro	4	2021	Quarta-feira
4697	2021-11-11	11	11	Novembro	4	2021	Quinta-feira
4698	2021-11-12	12	11	Novembro	4	2021	Sexta-feira
4699	2021-11-13	13	11	Novembro	4	2021	S├íbado
4700	2021-11-14	14	11	Novembro	4	2021	Domingo
4701	2021-11-15	15	11	Novembro	4	2021	Segunda-feira
4702	2021-11-16	16	11	Novembro	4	2021	Ter├ºa-feira
4703	2021-11-17	17	11	Novembro	4	2021	Quarta-feira
4704	2021-11-18	18	11	Novembro	4	2021	Quinta-feira
4705	2021-11-19	19	11	Novembro	4	2021	Sexta-feira
4706	2021-11-20	20	11	Novembro	4	2021	S├íbado
4707	2021-11-21	21	11	Novembro	4	2021	Domingo
4708	2021-11-22	22	11	Novembro	4	2021	Segunda-feira
4709	2021-11-23	23	11	Novembro	4	2021	Ter├ºa-feira
4710	2021-11-24	24	11	Novembro	4	2021	Quarta-feira
4711	2021-11-25	25	11	Novembro	4	2021	Quinta-feira
4712	2021-11-26	26	11	Novembro	4	2021	Sexta-feira
4713	2021-11-27	27	11	Novembro	4	2021	S├íbado
4714	2021-11-28	28	11	Novembro	4	2021	Domingo
4715	2021-11-29	29	11	Novembro	4	2021	Segunda-feira
4716	2021-11-30	30	11	Novembro	4	2021	Ter├ºa-feira
4717	2021-12-01	1	12	Dezembro	4	2021	Quarta-feira
4718	2021-12-02	2	12	Dezembro	4	2021	Quinta-feira
4719	2021-12-03	3	12	Dezembro	4	2021	Sexta-feira
4720	2021-12-04	4	12	Dezembro	4	2021	S├íbado
4721	2021-12-05	5	12	Dezembro	4	2021	Domingo
4722	2021-12-06	6	12	Dezembro	4	2021	Segunda-feira
4723	2021-12-07	7	12	Dezembro	4	2021	Ter├ºa-feira
4724	2021-12-08	8	12	Dezembro	4	2021	Quarta-feira
4725	2021-12-09	9	12	Dezembro	4	2021	Quinta-feira
4726	2021-12-10	10	12	Dezembro	4	2021	Sexta-feira
4727	2021-12-11	11	12	Dezembro	4	2021	S├íbado
4728	2021-12-12	12	12	Dezembro	4	2021	Domingo
4729	2021-12-13	13	12	Dezembro	4	2021	Segunda-feira
4730	2021-12-14	14	12	Dezembro	4	2021	Ter├ºa-feira
4731	2021-12-15	15	12	Dezembro	4	2021	Quarta-feira
4732	2021-12-16	16	12	Dezembro	4	2021	Quinta-feira
4733	2021-12-17	17	12	Dezembro	4	2021	Sexta-feira
4734	2021-12-18	18	12	Dezembro	4	2021	S├íbado
4735	2021-12-19	19	12	Dezembro	4	2021	Domingo
4736	2021-12-20	20	12	Dezembro	4	2021	Segunda-feira
4737	2021-12-21	21	12	Dezembro	4	2021	Ter├ºa-feira
4738	2021-12-22	22	12	Dezembro	4	2021	Quarta-feira
4739	2021-12-23	23	12	Dezembro	4	2021	Quinta-feira
4740	2021-12-24	24	12	Dezembro	4	2021	Sexta-feira
4741	2021-12-25	25	12	Dezembro	4	2021	S├íbado
4742	2021-12-26	26	12	Dezembro	4	2021	Domingo
4743	2021-12-27	27	12	Dezembro	4	2021	Segunda-feira
4744	2021-12-28	28	12	Dezembro	4	2021	Ter├ºa-feira
4745	2021-12-29	29	12	Dezembro	4	2021	Quarta-feira
4746	2021-12-30	30	12	Dezembro	4	2021	Quinta-feira
4747	2021-12-31	31	12	Dezembro	4	2021	Sexta-feira
4748	2022-01-01	1	1	Janeiro	1	2022	S├íbado
4749	2022-01-02	2	1	Janeiro	1	2022	Domingo
4750	2022-01-03	3	1	Janeiro	1	2022	Segunda-feira
4751	2022-01-04	4	1	Janeiro	1	2022	Ter├ºa-feira
4752	2022-01-05	5	1	Janeiro	1	2022	Quarta-feira
4753	2022-01-06	6	1	Janeiro	1	2022	Quinta-feira
4754	2022-01-07	7	1	Janeiro	1	2022	Sexta-feira
4755	2022-01-08	8	1	Janeiro	1	2022	S├íbado
4756	2022-01-09	9	1	Janeiro	1	2022	Domingo
4757	2022-01-10	10	1	Janeiro	1	2022	Segunda-feira
4758	2022-01-11	11	1	Janeiro	1	2022	Ter├ºa-feira
4759	2022-01-12	12	1	Janeiro	1	2022	Quarta-feira
4760	2022-01-13	13	1	Janeiro	1	2022	Quinta-feira
4761	2022-01-14	14	1	Janeiro	1	2022	Sexta-feira
4762	2022-01-15	15	1	Janeiro	1	2022	S├íbado
4763	2022-01-16	16	1	Janeiro	1	2022	Domingo
4764	2022-01-17	17	1	Janeiro	1	2022	Segunda-feira
4765	2022-01-18	18	1	Janeiro	1	2022	Ter├ºa-feira
4766	2022-01-19	19	1	Janeiro	1	2022	Quarta-feira
4767	2022-01-20	20	1	Janeiro	1	2022	Quinta-feira
4768	2022-01-21	21	1	Janeiro	1	2022	Sexta-feira
4769	2022-01-22	22	1	Janeiro	1	2022	S├íbado
4770	2022-01-23	23	1	Janeiro	1	2022	Domingo
4771	2022-01-24	24	1	Janeiro	1	2022	Segunda-feira
4772	2022-01-25	25	1	Janeiro	1	2022	Ter├ºa-feira
4773	2022-01-26	26	1	Janeiro	1	2022	Quarta-feira
4774	2022-01-27	27	1	Janeiro	1	2022	Quinta-feira
4775	2022-01-28	28	1	Janeiro	1	2022	Sexta-feira
4776	2022-01-29	29	1	Janeiro	1	2022	S├íbado
4777	2022-01-30	30	1	Janeiro	1	2022	Domingo
4778	2022-01-31	31	1	Janeiro	1	2022	Segunda-feira
4779	2022-02-01	1	2	Fevereiro	1	2022	Ter├ºa-feira
4780	2022-02-02	2	2	Fevereiro	1	2022	Quarta-feira
4781	2022-02-03	3	2	Fevereiro	1	2022	Quinta-feira
4782	2022-02-04	4	2	Fevereiro	1	2022	Sexta-feira
4783	2022-02-05	5	2	Fevereiro	1	2022	S├íbado
4784	2022-02-06	6	2	Fevereiro	1	2022	Domingo
4785	2022-02-07	7	2	Fevereiro	1	2022	Segunda-feira
4786	2022-02-08	8	2	Fevereiro	1	2022	Ter├ºa-feira
4787	2022-02-09	9	2	Fevereiro	1	2022	Quarta-feira
4788	2022-02-10	10	2	Fevereiro	1	2022	Quinta-feira
4789	2022-02-11	11	2	Fevereiro	1	2022	Sexta-feira
4790	2022-02-12	12	2	Fevereiro	1	2022	S├íbado
4791	2022-02-13	13	2	Fevereiro	1	2022	Domingo
4792	2022-02-14	14	2	Fevereiro	1	2022	Segunda-feira
4793	2022-02-15	15	2	Fevereiro	1	2022	Ter├ºa-feira
4794	2022-02-16	16	2	Fevereiro	1	2022	Quarta-feira
4795	2022-02-17	17	2	Fevereiro	1	2022	Quinta-feira
4796	2022-02-18	18	2	Fevereiro	1	2022	Sexta-feira
4797	2022-02-19	19	2	Fevereiro	1	2022	S├íbado
4798	2022-02-20	20	2	Fevereiro	1	2022	Domingo
4799	2022-02-21	21	2	Fevereiro	1	2022	Segunda-feira
4800	2022-02-22	22	2	Fevereiro	1	2022	Ter├ºa-feira
4801	2022-02-23	23	2	Fevereiro	1	2022	Quarta-feira
4802	2022-02-24	24	2	Fevereiro	1	2022	Quinta-feira
4803	2022-02-25	25	2	Fevereiro	1	2022	Sexta-feira
4804	2022-02-26	26	2	Fevereiro	1	2022	S├íbado
4805	2022-02-27	27	2	Fevereiro	1	2022	Domingo
4806	2022-02-28	28	2	Fevereiro	1	2022	Segunda-feira
4807	2022-03-01	1	3	Mar├ºo	1	2022	Ter├ºa-feira
4808	2022-03-02	2	3	Mar├ºo	1	2022	Quarta-feira
4809	2022-03-03	3	3	Mar├ºo	1	2022	Quinta-feira
4810	2022-03-04	4	3	Mar├ºo	1	2022	Sexta-feira
4811	2022-03-05	5	3	Mar├ºo	1	2022	S├íbado
4812	2022-03-06	6	3	Mar├ºo	1	2022	Domingo
4813	2022-03-07	7	3	Mar├ºo	1	2022	Segunda-feira
4814	2022-03-08	8	3	Mar├ºo	1	2022	Ter├ºa-feira
4815	2022-03-09	9	3	Mar├ºo	1	2022	Quarta-feira
4816	2022-03-10	10	3	Mar├ºo	1	2022	Quinta-feira
4817	2022-03-11	11	3	Mar├ºo	1	2022	Sexta-feira
4818	2022-03-12	12	3	Mar├ºo	1	2022	S├íbado
4819	2022-03-13	13	3	Mar├ºo	1	2022	Domingo
4820	2022-03-14	14	3	Mar├ºo	1	2022	Segunda-feira
4821	2022-03-15	15	3	Mar├ºo	1	2022	Ter├ºa-feira
4822	2022-03-16	16	3	Mar├ºo	1	2022	Quarta-feira
4823	2022-03-17	17	3	Mar├ºo	1	2022	Quinta-feira
4824	2022-03-18	18	3	Mar├ºo	1	2022	Sexta-feira
4825	2022-03-19	19	3	Mar├ºo	1	2022	S├íbado
4826	2022-03-20	20	3	Mar├ºo	1	2022	Domingo
4827	2022-03-21	21	3	Mar├ºo	1	2022	Segunda-feira
4828	2022-03-22	22	3	Mar├ºo	1	2022	Ter├ºa-feira
4829	2022-03-23	23	3	Mar├ºo	1	2022	Quarta-feira
4830	2022-03-24	24	3	Mar├ºo	1	2022	Quinta-feira
4831	2022-03-25	25	3	Mar├ºo	1	2022	Sexta-feira
4832	2022-03-26	26	3	Mar├ºo	1	2022	S├íbado
4833	2022-03-27	27	3	Mar├ºo	1	2022	Domingo
4834	2022-03-28	28	3	Mar├ºo	1	2022	Segunda-feira
4835	2022-03-29	29	3	Mar├ºo	1	2022	Ter├ºa-feira
4836	2022-03-30	30	3	Mar├ºo	1	2022	Quarta-feira
4837	2022-03-31	31	3	Mar├ºo	1	2022	Quinta-feira
4838	2022-04-01	1	4	Abril	2	2022	Sexta-feira
4839	2022-04-02	2	4	Abril	2	2022	S├íbado
4840	2022-04-03	3	4	Abril	2	2022	Domingo
4841	2022-04-04	4	4	Abril	2	2022	Segunda-feira
4842	2022-04-05	5	4	Abril	2	2022	Ter├ºa-feira
4843	2022-04-06	6	4	Abril	2	2022	Quarta-feira
4844	2022-04-07	7	4	Abril	2	2022	Quinta-feira
4845	2022-04-08	8	4	Abril	2	2022	Sexta-feira
4846	2022-04-09	9	4	Abril	2	2022	S├íbado
4847	2022-04-10	10	4	Abril	2	2022	Domingo
4848	2022-04-11	11	4	Abril	2	2022	Segunda-feira
4849	2022-04-12	12	4	Abril	2	2022	Ter├ºa-feira
4850	2022-04-13	13	4	Abril	2	2022	Quarta-feira
4851	2022-04-14	14	4	Abril	2	2022	Quinta-feira
4852	2022-04-15	15	4	Abril	2	2022	Sexta-feira
4853	2022-04-16	16	4	Abril	2	2022	S├íbado
4854	2022-04-17	17	4	Abril	2	2022	Domingo
4855	2022-04-18	18	4	Abril	2	2022	Segunda-feira
4856	2022-04-19	19	4	Abril	2	2022	Ter├ºa-feira
4857	2022-04-20	20	4	Abril	2	2022	Quarta-feira
4858	2022-04-21	21	4	Abril	2	2022	Quinta-feira
4859	2022-04-22	22	4	Abril	2	2022	Sexta-feira
4860	2022-04-23	23	4	Abril	2	2022	S├íbado
4861	2022-04-24	24	4	Abril	2	2022	Domingo
4862	2022-04-25	25	4	Abril	2	2022	Segunda-feira
4863	2022-04-26	26	4	Abril	2	2022	Ter├ºa-feira
4864	2022-04-27	27	4	Abril	2	2022	Quarta-feira
4865	2022-04-28	28	4	Abril	2	2022	Quinta-feira
4866	2022-04-29	29	4	Abril	2	2022	Sexta-feira
4867	2022-04-30	30	4	Abril	2	2022	S├íbado
4868	2022-05-01	1	5	Maio	2	2022	Domingo
4869	2022-05-02	2	5	Maio	2	2022	Segunda-feira
4870	2022-05-03	3	5	Maio	2	2022	Ter├ºa-feira
4871	2022-05-04	4	5	Maio	2	2022	Quarta-feira
4872	2022-05-05	5	5	Maio	2	2022	Quinta-feira
4873	2022-05-06	6	5	Maio	2	2022	Sexta-feira
4874	2022-05-07	7	5	Maio	2	2022	S├íbado
4875	2022-05-08	8	5	Maio	2	2022	Domingo
4876	2022-05-09	9	5	Maio	2	2022	Segunda-feira
4877	2022-05-10	10	5	Maio	2	2022	Ter├ºa-feira
4878	2022-05-11	11	5	Maio	2	2022	Quarta-feira
4879	2022-05-12	12	5	Maio	2	2022	Quinta-feira
4880	2022-05-13	13	5	Maio	2	2022	Sexta-feira
4881	2022-05-14	14	5	Maio	2	2022	S├íbado
4882	2022-05-15	15	5	Maio	2	2022	Domingo
4883	2022-05-16	16	5	Maio	2	2022	Segunda-feira
4884	2022-05-17	17	5	Maio	2	2022	Ter├ºa-feira
4885	2022-05-18	18	5	Maio	2	2022	Quarta-feira
4886	2022-05-19	19	5	Maio	2	2022	Quinta-feira
4887	2022-05-20	20	5	Maio	2	2022	Sexta-feira
4888	2022-05-21	21	5	Maio	2	2022	S├íbado
4889	2022-05-22	22	5	Maio	2	2022	Domingo
4890	2022-05-23	23	5	Maio	2	2022	Segunda-feira
4891	2022-05-24	24	5	Maio	2	2022	Ter├ºa-feira
4892	2022-05-25	25	5	Maio	2	2022	Quarta-feira
4893	2022-05-26	26	5	Maio	2	2022	Quinta-feira
4894	2022-05-27	27	5	Maio	2	2022	Sexta-feira
4895	2022-05-28	28	5	Maio	2	2022	S├íbado
4896	2022-05-29	29	5	Maio	2	2022	Domingo
4897	2022-05-30	30	5	Maio	2	2022	Segunda-feira
4898	2022-05-31	31	5	Maio	2	2022	Ter├ºa-feira
4899	2022-06-01	1	6	Junho	2	2022	Quarta-feira
4900	2022-06-02	2	6	Junho	2	2022	Quinta-feira
4901	2022-06-03	3	6	Junho	2	2022	Sexta-feira
4902	2022-06-04	4	6	Junho	2	2022	S├íbado
4903	2022-06-05	5	6	Junho	2	2022	Domingo
4904	2022-06-06	6	6	Junho	2	2022	Segunda-feira
4905	2022-06-07	7	6	Junho	2	2022	Ter├ºa-feira
4906	2022-06-08	8	6	Junho	2	2022	Quarta-feira
4907	2022-06-09	9	6	Junho	2	2022	Quinta-feira
4908	2022-06-10	10	6	Junho	2	2022	Sexta-feira
4909	2022-06-11	11	6	Junho	2	2022	S├íbado
4910	2022-06-12	12	6	Junho	2	2022	Domingo
4911	2022-06-13	13	6	Junho	2	2022	Segunda-feira
4912	2022-06-14	14	6	Junho	2	2022	Ter├ºa-feira
4913	2022-06-15	15	6	Junho	2	2022	Quarta-feira
4914	2022-06-16	16	6	Junho	2	2022	Quinta-feira
4915	2022-06-17	17	6	Junho	2	2022	Sexta-feira
4916	2022-06-18	18	6	Junho	2	2022	S├íbado
4917	2022-06-19	19	6	Junho	2	2022	Domingo
4918	2022-06-20	20	6	Junho	2	2022	Segunda-feira
4919	2022-06-21	21	6	Junho	2	2022	Ter├ºa-feira
4920	2022-06-22	22	6	Junho	2	2022	Quarta-feira
4921	2022-06-23	23	6	Junho	2	2022	Quinta-feira
4922	2022-06-24	24	6	Junho	2	2022	Sexta-feira
4923	2022-06-25	25	6	Junho	2	2022	S├íbado
4924	2022-06-26	26	6	Junho	2	2022	Domingo
4925	2022-06-27	27	6	Junho	2	2022	Segunda-feira
4926	2022-06-28	28	6	Junho	2	2022	Ter├ºa-feira
4927	2022-06-29	29	6	Junho	2	2022	Quarta-feira
4928	2022-06-30	30	6	Junho	2	2022	Quinta-feira
4929	2022-07-01	1	7	Julho	3	2022	Sexta-feira
4930	2022-07-02	2	7	Julho	3	2022	S├íbado
4931	2022-07-03	3	7	Julho	3	2022	Domingo
4932	2022-07-04	4	7	Julho	3	2022	Segunda-feira
4933	2022-07-05	5	7	Julho	3	2022	Ter├ºa-feira
4934	2022-07-06	6	7	Julho	3	2022	Quarta-feira
4935	2022-07-07	7	7	Julho	3	2022	Quinta-feira
4936	2022-07-08	8	7	Julho	3	2022	Sexta-feira
4937	2022-07-09	9	7	Julho	3	2022	S├íbado
4938	2022-07-10	10	7	Julho	3	2022	Domingo
4939	2022-07-11	11	7	Julho	3	2022	Segunda-feira
4940	2022-07-12	12	7	Julho	3	2022	Ter├ºa-feira
4941	2022-07-13	13	7	Julho	3	2022	Quarta-feira
4942	2022-07-14	14	7	Julho	3	2022	Quinta-feira
4943	2022-07-15	15	7	Julho	3	2022	Sexta-feira
4944	2022-07-16	16	7	Julho	3	2022	S├íbado
4945	2022-07-17	17	7	Julho	3	2022	Domingo
4946	2022-07-18	18	7	Julho	3	2022	Segunda-feira
4947	2022-07-19	19	7	Julho	3	2022	Ter├ºa-feira
4948	2022-07-20	20	7	Julho	3	2022	Quarta-feira
4949	2022-07-21	21	7	Julho	3	2022	Quinta-feira
4950	2022-07-22	22	7	Julho	3	2022	Sexta-feira
4951	2022-07-23	23	7	Julho	3	2022	S├íbado
4952	2022-07-24	24	7	Julho	3	2022	Domingo
4953	2022-07-25	25	7	Julho	3	2022	Segunda-feira
4954	2022-07-26	26	7	Julho	3	2022	Ter├ºa-feira
4955	2022-07-27	27	7	Julho	3	2022	Quarta-feira
4956	2022-07-28	28	7	Julho	3	2022	Quinta-feira
4957	2022-07-29	29	7	Julho	3	2022	Sexta-feira
4958	2022-07-30	30	7	Julho	3	2022	S├íbado
4959	2022-07-31	31	7	Julho	3	2022	Domingo
4960	2022-08-01	1	8	Agosto	3	2022	Segunda-feira
4961	2022-08-02	2	8	Agosto	3	2022	Ter├ºa-feira
4962	2022-08-03	3	8	Agosto	3	2022	Quarta-feira
4963	2022-08-04	4	8	Agosto	3	2022	Quinta-feira
4964	2022-08-05	5	8	Agosto	3	2022	Sexta-feira
4965	2022-08-06	6	8	Agosto	3	2022	S├íbado
4966	2022-08-07	7	8	Agosto	3	2022	Domingo
4967	2022-08-08	8	8	Agosto	3	2022	Segunda-feira
4968	2022-08-09	9	8	Agosto	3	2022	Ter├ºa-feira
4969	2022-08-10	10	8	Agosto	3	2022	Quarta-feira
4970	2022-08-11	11	8	Agosto	3	2022	Quinta-feira
4971	2022-08-12	12	8	Agosto	3	2022	Sexta-feira
4972	2022-08-13	13	8	Agosto	3	2022	S├íbado
4973	2022-08-14	14	8	Agosto	3	2022	Domingo
4974	2022-08-15	15	8	Agosto	3	2022	Segunda-feira
4975	2022-08-16	16	8	Agosto	3	2022	Ter├ºa-feira
4976	2022-08-17	17	8	Agosto	3	2022	Quarta-feira
4977	2022-08-18	18	8	Agosto	3	2022	Quinta-feira
4978	2022-08-19	19	8	Agosto	3	2022	Sexta-feira
4979	2022-08-20	20	8	Agosto	3	2022	S├íbado
4980	2022-08-21	21	8	Agosto	3	2022	Domingo
4981	2022-08-22	22	8	Agosto	3	2022	Segunda-feira
4982	2022-08-23	23	8	Agosto	3	2022	Ter├ºa-feira
4983	2022-08-24	24	8	Agosto	3	2022	Quarta-feira
4984	2022-08-25	25	8	Agosto	3	2022	Quinta-feira
4985	2022-08-26	26	8	Agosto	3	2022	Sexta-feira
4986	2022-08-27	27	8	Agosto	3	2022	S├íbado
4987	2022-08-28	28	8	Agosto	3	2022	Domingo
4988	2022-08-29	29	8	Agosto	3	2022	Segunda-feira
4989	2022-08-30	30	8	Agosto	3	2022	Ter├ºa-feira
4990	2022-08-31	31	8	Agosto	3	2022	Quarta-feira
4991	2022-09-01	1	9	Setembro	3	2022	Quinta-feira
4992	2022-09-02	2	9	Setembro	3	2022	Sexta-feira
4993	2022-09-03	3	9	Setembro	3	2022	S├íbado
4994	2022-09-04	4	9	Setembro	3	2022	Domingo
4995	2022-09-05	5	9	Setembro	3	2022	Segunda-feira
4996	2022-09-06	6	9	Setembro	3	2022	Ter├ºa-feira
4997	2022-09-07	7	9	Setembro	3	2022	Quarta-feira
4998	2022-09-08	8	9	Setembro	3	2022	Quinta-feira
4999	2022-09-09	9	9	Setembro	3	2022	Sexta-feira
5000	2022-09-10	10	9	Setembro	3	2022	S├íbado
5001	2022-09-11	11	9	Setembro	3	2022	Domingo
5002	2022-09-12	12	9	Setembro	3	2022	Segunda-feira
5003	2022-09-13	13	9	Setembro	3	2022	Ter├ºa-feira
5004	2022-09-14	14	9	Setembro	3	2022	Quarta-feira
5005	2022-09-15	15	9	Setembro	3	2022	Quinta-feira
5006	2022-09-16	16	9	Setembro	3	2022	Sexta-feira
5007	2022-09-17	17	9	Setembro	3	2022	S├íbado
5008	2022-09-18	18	9	Setembro	3	2022	Domingo
5009	2022-09-19	19	9	Setembro	3	2022	Segunda-feira
5010	2022-09-20	20	9	Setembro	3	2022	Ter├ºa-feira
5011	2022-09-21	21	9	Setembro	3	2022	Quarta-feira
5012	2022-09-22	22	9	Setembro	3	2022	Quinta-feira
5013	2022-09-23	23	9	Setembro	3	2022	Sexta-feira
5014	2022-09-24	24	9	Setembro	3	2022	S├íbado
5015	2022-09-25	25	9	Setembro	3	2022	Domingo
5016	2022-09-26	26	9	Setembro	3	2022	Segunda-feira
5017	2022-09-27	27	9	Setembro	3	2022	Ter├ºa-feira
5018	2022-09-28	28	9	Setembro	3	2022	Quarta-feira
5019	2022-09-29	29	9	Setembro	3	2022	Quinta-feira
5020	2022-09-30	30	9	Setembro	3	2022	Sexta-feira
5021	2022-10-01	1	10	Outubro	4	2022	S├íbado
5022	2022-10-02	2	10	Outubro	4	2022	Domingo
5023	2022-10-03	3	10	Outubro	4	2022	Segunda-feira
5024	2022-10-04	4	10	Outubro	4	2022	Ter├ºa-feira
5025	2022-10-05	5	10	Outubro	4	2022	Quarta-feira
5026	2022-10-06	6	10	Outubro	4	2022	Quinta-feira
5027	2022-10-07	7	10	Outubro	4	2022	Sexta-feira
5028	2022-10-08	8	10	Outubro	4	2022	S├íbado
5029	2022-10-09	9	10	Outubro	4	2022	Domingo
5030	2022-10-10	10	10	Outubro	4	2022	Segunda-feira
5031	2022-10-11	11	10	Outubro	4	2022	Ter├ºa-feira
5032	2022-10-12	12	10	Outubro	4	2022	Quarta-feira
5033	2022-10-13	13	10	Outubro	4	2022	Quinta-feira
5034	2022-10-14	14	10	Outubro	4	2022	Sexta-feira
5035	2022-10-15	15	10	Outubro	4	2022	S├íbado
5036	2022-10-16	16	10	Outubro	4	2022	Domingo
5037	2022-10-17	17	10	Outubro	4	2022	Segunda-feira
5038	2022-10-18	18	10	Outubro	4	2022	Ter├ºa-feira
5039	2022-10-19	19	10	Outubro	4	2022	Quarta-feira
5040	2022-10-20	20	10	Outubro	4	2022	Quinta-feira
5041	2022-10-21	21	10	Outubro	4	2022	Sexta-feira
5042	2022-10-22	22	10	Outubro	4	2022	S├íbado
5043	2022-10-23	23	10	Outubro	4	2022	Domingo
5044	2022-10-24	24	10	Outubro	4	2022	Segunda-feira
5045	2022-10-25	25	10	Outubro	4	2022	Ter├ºa-feira
5046	2022-10-26	26	10	Outubro	4	2022	Quarta-feira
5047	2022-10-27	27	10	Outubro	4	2022	Quinta-feira
5048	2022-10-28	28	10	Outubro	4	2022	Sexta-feira
5049	2022-10-29	29	10	Outubro	4	2022	S├íbado
5050	2022-10-30	30	10	Outubro	4	2022	Domingo
5051	2022-10-31	31	10	Outubro	4	2022	Segunda-feira
5052	2022-11-01	1	11	Novembro	4	2022	Ter├ºa-feira
5053	2022-11-02	2	11	Novembro	4	2022	Quarta-feira
5054	2022-11-03	3	11	Novembro	4	2022	Quinta-feira
5055	2022-11-04	4	11	Novembro	4	2022	Sexta-feira
5056	2022-11-05	5	11	Novembro	4	2022	S├íbado
5057	2022-11-06	6	11	Novembro	4	2022	Domingo
5058	2022-11-07	7	11	Novembro	4	2022	Segunda-feira
5059	2022-11-08	8	11	Novembro	4	2022	Ter├ºa-feira
5060	2022-11-09	9	11	Novembro	4	2022	Quarta-feira
5061	2022-11-10	10	11	Novembro	4	2022	Quinta-feira
5062	2022-11-11	11	11	Novembro	4	2022	Sexta-feira
5063	2022-11-12	12	11	Novembro	4	2022	S├íbado
5064	2022-11-13	13	11	Novembro	4	2022	Domingo
5065	2022-11-14	14	11	Novembro	4	2022	Segunda-feira
5066	2022-11-15	15	11	Novembro	4	2022	Ter├ºa-feira
5067	2022-11-16	16	11	Novembro	4	2022	Quarta-feira
5068	2022-11-17	17	11	Novembro	4	2022	Quinta-feira
5069	2022-11-18	18	11	Novembro	4	2022	Sexta-feira
5070	2022-11-19	19	11	Novembro	4	2022	S├íbado
5071	2022-11-20	20	11	Novembro	4	2022	Domingo
5072	2022-11-21	21	11	Novembro	4	2022	Segunda-feira
5073	2022-11-22	22	11	Novembro	4	2022	Ter├ºa-feira
5074	2022-11-23	23	11	Novembro	4	2022	Quarta-feira
5075	2022-11-24	24	11	Novembro	4	2022	Quinta-feira
5076	2022-11-25	25	11	Novembro	4	2022	Sexta-feira
5077	2022-11-26	26	11	Novembro	4	2022	S├íbado
5078	2022-11-27	27	11	Novembro	4	2022	Domingo
5079	2022-11-28	28	11	Novembro	4	2022	Segunda-feira
5080	2022-11-29	29	11	Novembro	4	2022	Ter├ºa-feira
5081	2022-11-30	30	11	Novembro	4	2022	Quarta-feira
5082	2022-12-01	1	12	Dezembro	4	2022	Quinta-feira
5083	2022-12-02	2	12	Dezembro	4	2022	Sexta-feira
5084	2022-12-03	3	12	Dezembro	4	2022	S├íbado
5085	2022-12-04	4	12	Dezembro	4	2022	Domingo
5086	2022-12-05	5	12	Dezembro	4	2022	Segunda-feira
5087	2022-12-06	6	12	Dezembro	4	2022	Ter├ºa-feira
5088	2022-12-07	7	12	Dezembro	4	2022	Quarta-feira
5089	2022-12-08	8	12	Dezembro	4	2022	Quinta-feira
5090	2022-12-09	9	12	Dezembro	4	2022	Sexta-feira
5091	2022-12-10	10	12	Dezembro	4	2022	S├íbado
5092	2022-12-11	11	12	Dezembro	4	2022	Domingo
5093	2022-12-12	12	12	Dezembro	4	2022	Segunda-feira
5094	2022-12-13	13	12	Dezembro	4	2022	Ter├ºa-feira
5095	2022-12-14	14	12	Dezembro	4	2022	Quarta-feira
5096	2022-12-15	15	12	Dezembro	4	2022	Quinta-feira
5097	2022-12-16	16	12	Dezembro	4	2022	Sexta-feira
5098	2022-12-17	17	12	Dezembro	4	2022	S├íbado
5099	2022-12-18	18	12	Dezembro	4	2022	Domingo
5100	2022-12-19	19	12	Dezembro	4	2022	Segunda-feira
5101	2022-12-20	20	12	Dezembro	4	2022	Ter├ºa-feira
5102	2022-12-21	21	12	Dezembro	4	2022	Quarta-feira
5103	2022-12-22	22	12	Dezembro	4	2022	Quinta-feira
5104	2022-12-23	23	12	Dezembro	4	2022	Sexta-feira
5105	2022-12-24	24	12	Dezembro	4	2022	S├íbado
5106	2022-12-25	25	12	Dezembro	4	2022	Domingo
5107	2022-12-26	26	12	Dezembro	4	2022	Segunda-feira
5108	2022-12-27	27	12	Dezembro	4	2022	Ter├ºa-feira
5109	2022-12-28	28	12	Dezembro	4	2022	Quarta-feira
5110	2022-12-29	29	12	Dezembro	4	2022	Quinta-feira
5111	2022-12-30	30	12	Dezembro	4	2022	Sexta-feira
5112	2022-12-31	31	12	Dezembro	4	2022	S├íbado
5113	2023-01-01	1	1	Janeiro	1	2023	Domingo
5114	2023-01-02	2	1	Janeiro	1	2023	Segunda-feira
5115	2023-01-03	3	1	Janeiro	1	2023	Ter├ºa-feira
5116	2023-01-04	4	1	Janeiro	1	2023	Quarta-feira
5117	2023-01-05	5	1	Janeiro	1	2023	Quinta-feira
5118	2023-01-06	6	1	Janeiro	1	2023	Sexta-feira
5119	2023-01-07	7	1	Janeiro	1	2023	S├íbado
5120	2023-01-08	8	1	Janeiro	1	2023	Domingo
5121	2023-01-09	9	1	Janeiro	1	2023	Segunda-feira
5122	2023-01-10	10	1	Janeiro	1	2023	Ter├ºa-feira
5123	2023-01-11	11	1	Janeiro	1	2023	Quarta-feira
5124	2023-01-12	12	1	Janeiro	1	2023	Quinta-feira
5125	2023-01-13	13	1	Janeiro	1	2023	Sexta-feira
5126	2023-01-14	14	1	Janeiro	1	2023	S├íbado
5127	2023-01-15	15	1	Janeiro	1	2023	Domingo
5128	2023-01-16	16	1	Janeiro	1	2023	Segunda-feira
5129	2023-01-17	17	1	Janeiro	1	2023	Ter├ºa-feira
5130	2023-01-18	18	1	Janeiro	1	2023	Quarta-feira
5131	2023-01-19	19	1	Janeiro	1	2023	Quinta-feira
5132	2023-01-20	20	1	Janeiro	1	2023	Sexta-feira
5133	2023-01-21	21	1	Janeiro	1	2023	S├íbado
5134	2023-01-22	22	1	Janeiro	1	2023	Domingo
5135	2023-01-23	23	1	Janeiro	1	2023	Segunda-feira
5136	2023-01-24	24	1	Janeiro	1	2023	Ter├ºa-feira
5137	2023-01-25	25	1	Janeiro	1	2023	Quarta-feira
5138	2023-01-26	26	1	Janeiro	1	2023	Quinta-feira
5139	2023-01-27	27	1	Janeiro	1	2023	Sexta-feira
5140	2023-01-28	28	1	Janeiro	1	2023	S├íbado
5141	2023-01-29	29	1	Janeiro	1	2023	Domingo
5142	2023-01-30	30	1	Janeiro	1	2023	Segunda-feira
5143	2023-01-31	31	1	Janeiro	1	2023	Ter├ºa-feira
5144	2023-02-01	1	2	Fevereiro	1	2023	Quarta-feira
5145	2023-02-02	2	2	Fevereiro	1	2023	Quinta-feira
5146	2023-02-03	3	2	Fevereiro	1	2023	Sexta-feira
5147	2023-02-04	4	2	Fevereiro	1	2023	S├íbado
5148	2023-02-05	5	2	Fevereiro	1	2023	Domingo
5149	2023-02-06	6	2	Fevereiro	1	2023	Segunda-feira
5150	2023-02-07	7	2	Fevereiro	1	2023	Ter├ºa-feira
5151	2023-02-08	8	2	Fevereiro	1	2023	Quarta-feira
5152	2023-02-09	9	2	Fevereiro	1	2023	Quinta-feira
5153	2023-02-10	10	2	Fevereiro	1	2023	Sexta-feira
5154	2023-02-11	11	2	Fevereiro	1	2023	S├íbado
5155	2023-02-12	12	2	Fevereiro	1	2023	Domingo
5156	2023-02-13	13	2	Fevereiro	1	2023	Segunda-feira
5157	2023-02-14	14	2	Fevereiro	1	2023	Ter├ºa-feira
5158	2023-02-15	15	2	Fevereiro	1	2023	Quarta-feira
5159	2023-02-16	16	2	Fevereiro	1	2023	Quinta-feira
5160	2023-02-17	17	2	Fevereiro	1	2023	Sexta-feira
5161	2023-02-18	18	2	Fevereiro	1	2023	S├íbado
5162	2023-02-19	19	2	Fevereiro	1	2023	Domingo
5163	2023-02-20	20	2	Fevereiro	1	2023	Segunda-feira
5164	2023-02-21	21	2	Fevereiro	1	2023	Ter├ºa-feira
5165	2023-02-22	22	2	Fevereiro	1	2023	Quarta-feira
5166	2023-02-23	23	2	Fevereiro	1	2023	Quinta-feira
5167	2023-02-24	24	2	Fevereiro	1	2023	Sexta-feira
5168	2023-02-25	25	2	Fevereiro	1	2023	S├íbado
5169	2023-02-26	26	2	Fevereiro	1	2023	Domingo
5170	2023-02-27	27	2	Fevereiro	1	2023	Segunda-feira
5171	2023-02-28	28	2	Fevereiro	1	2023	Ter├ºa-feira
5172	2023-03-01	1	3	Mar├ºo	1	2023	Quarta-feira
5173	2023-03-02	2	3	Mar├ºo	1	2023	Quinta-feira
5174	2023-03-03	3	3	Mar├ºo	1	2023	Sexta-feira
5175	2023-03-04	4	3	Mar├ºo	1	2023	S├íbado
5176	2023-03-05	5	3	Mar├ºo	1	2023	Domingo
5177	2023-03-06	6	3	Mar├ºo	1	2023	Segunda-feira
5178	2023-03-07	7	3	Mar├ºo	1	2023	Ter├ºa-feira
5179	2023-03-08	8	3	Mar├ºo	1	2023	Quarta-feira
5180	2023-03-09	9	3	Mar├ºo	1	2023	Quinta-feira
5181	2023-03-10	10	3	Mar├ºo	1	2023	Sexta-feira
5182	2023-03-11	11	3	Mar├ºo	1	2023	S├íbado
5183	2023-03-12	12	3	Mar├ºo	1	2023	Domingo
5184	2023-03-13	13	3	Mar├ºo	1	2023	Segunda-feira
5185	2023-03-14	14	3	Mar├ºo	1	2023	Ter├ºa-feira
5186	2023-03-15	15	3	Mar├ºo	1	2023	Quarta-feira
5187	2023-03-16	16	3	Mar├ºo	1	2023	Quinta-feira
5188	2023-03-17	17	3	Mar├ºo	1	2023	Sexta-feira
5189	2023-03-18	18	3	Mar├ºo	1	2023	S├íbado
5190	2023-03-19	19	3	Mar├ºo	1	2023	Domingo
5191	2023-03-20	20	3	Mar├ºo	1	2023	Segunda-feira
5192	2023-03-21	21	3	Mar├ºo	1	2023	Ter├ºa-feira
5193	2023-03-22	22	3	Mar├ºo	1	2023	Quarta-feira
5194	2023-03-23	23	3	Mar├ºo	1	2023	Quinta-feira
5195	2023-03-24	24	3	Mar├ºo	1	2023	Sexta-feira
5196	2023-03-25	25	3	Mar├ºo	1	2023	S├íbado
5197	2023-03-26	26	3	Mar├ºo	1	2023	Domingo
5198	2023-03-27	27	3	Mar├ºo	1	2023	Segunda-feira
5199	2023-03-28	28	3	Mar├ºo	1	2023	Ter├ºa-feira
5200	2023-03-29	29	3	Mar├ºo	1	2023	Quarta-feira
5201	2023-03-30	30	3	Mar├ºo	1	2023	Quinta-feira
5202	2023-03-31	31	3	Mar├ºo	1	2023	Sexta-feira
5203	2023-04-01	1	4	Abril	2	2023	S├íbado
5204	2023-04-02	2	4	Abril	2	2023	Domingo
5205	2023-04-03	3	4	Abril	2	2023	Segunda-feira
5206	2023-04-04	4	4	Abril	2	2023	Ter├ºa-feira
5207	2023-04-05	5	4	Abril	2	2023	Quarta-feira
5208	2023-04-06	6	4	Abril	2	2023	Quinta-feira
5209	2023-04-07	7	4	Abril	2	2023	Sexta-feira
5210	2023-04-08	8	4	Abril	2	2023	S├íbado
5211	2023-04-09	9	4	Abril	2	2023	Domingo
5212	2023-04-10	10	4	Abril	2	2023	Segunda-feira
5213	2023-04-11	11	4	Abril	2	2023	Ter├ºa-feira
5214	2023-04-12	12	4	Abril	2	2023	Quarta-feira
5215	2023-04-13	13	4	Abril	2	2023	Quinta-feira
5216	2023-04-14	14	4	Abril	2	2023	Sexta-feira
5217	2023-04-15	15	4	Abril	2	2023	S├íbado
5218	2023-04-16	16	4	Abril	2	2023	Domingo
5219	2023-04-17	17	4	Abril	2	2023	Segunda-feira
5220	2023-04-18	18	4	Abril	2	2023	Ter├ºa-feira
5221	2023-04-19	19	4	Abril	2	2023	Quarta-feira
5222	2023-04-20	20	4	Abril	2	2023	Quinta-feira
5223	2023-04-21	21	4	Abril	2	2023	Sexta-feira
5224	2023-04-22	22	4	Abril	2	2023	S├íbado
5225	2023-04-23	23	4	Abril	2	2023	Domingo
5226	2023-04-24	24	4	Abril	2	2023	Segunda-feira
5227	2023-04-25	25	4	Abril	2	2023	Ter├ºa-feira
5228	2023-04-26	26	4	Abril	2	2023	Quarta-feira
5229	2023-04-27	27	4	Abril	2	2023	Quinta-feira
5230	2023-04-28	28	4	Abril	2	2023	Sexta-feira
5231	2023-04-29	29	4	Abril	2	2023	S├íbado
5232	2023-04-30	30	4	Abril	2	2023	Domingo
5233	2023-05-01	1	5	Maio	2	2023	Segunda-feira
5234	2023-05-02	2	5	Maio	2	2023	Ter├ºa-feira
5235	2023-05-03	3	5	Maio	2	2023	Quarta-feira
5236	2023-05-04	4	5	Maio	2	2023	Quinta-feira
5237	2023-05-05	5	5	Maio	2	2023	Sexta-feira
5238	2023-05-06	6	5	Maio	2	2023	S├íbado
5239	2023-05-07	7	5	Maio	2	2023	Domingo
5240	2023-05-08	8	5	Maio	2	2023	Segunda-feira
5241	2023-05-09	9	5	Maio	2	2023	Ter├ºa-feira
5242	2023-05-10	10	5	Maio	2	2023	Quarta-feira
5243	2023-05-11	11	5	Maio	2	2023	Quinta-feira
5244	2023-05-12	12	5	Maio	2	2023	Sexta-feira
5245	2023-05-13	13	5	Maio	2	2023	S├íbado
5246	2023-05-14	14	5	Maio	2	2023	Domingo
5247	2023-05-15	15	5	Maio	2	2023	Segunda-feira
5248	2023-05-16	16	5	Maio	2	2023	Ter├ºa-feira
5249	2023-05-17	17	5	Maio	2	2023	Quarta-feira
5250	2023-05-18	18	5	Maio	2	2023	Quinta-feira
5251	2023-05-19	19	5	Maio	2	2023	Sexta-feira
5252	2023-05-20	20	5	Maio	2	2023	S├íbado
5253	2023-05-21	21	5	Maio	2	2023	Domingo
5254	2023-05-22	22	5	Maio	2	2023	Segunda-feira
5255	2023-05-23	23	5	Maio	2	2023	Ter├ºa-feira
5256	2023-05-24	24	5	Maio	2	2023	Quarta-feira
5257	2023-05-25	25	5	Maio	2	2023	Quinta-feira
5258	2023-05-26	26	5	Maio	2	2023	Sexta-feira
5259	2023-05-27	27	5	Maio	2	2023	S├íbado
5260	2023-05-28	28	5	Maio	2	2023	Domingo
5261	2023-05-29	29	5	Maio	2	2023	Segunda-feira
5262	2023-05-30	30	5	Maio	2	2023	Ter├ºa-feira
5263	2023-05-31	31	5	Maio	2	2023	Quarta-feira
5264	2023-06-01	1	6	Junho	2	2023	Quinta-feira
5265	2023-06-02	2	6	Junho	2	2023	Sexta-feira
5266	2023-06-03	3	6	Junho	2	2023	S├íbado
5267	2023-06-04	4	6	Junho	2	2023	Domingo
5268	2023-06-05	5	6	Junho	2	2023	Segunda-feira
5269	2023-06-06	6	6	Junho	2	2023	Ter├ºa-feira
5270	2023-06-07	7	6	Junho	2	2023	Quarta-feira
5271	2023-06-08	8	6	Junho	2	2023	Quinta-feira
5272	2023-06-09	9	6	Junho	2	2023	Sexta-feira
5273	2023-06-10	10	6	Junho	2	2023	S├íbado
5274	2023-06-11	11	6	Junho	2	2023	Domingo
5275	2023-06-12	12	6	Junho	2	2023	Segunda-feira
5276	2023-06-13	13	6	Junho	2	2023	Ter├ºa-feira
5277	2023-06-14	14	6	Junho	2	2023	Quarta-feira
5278	2023-06-15	15	6	Junho	2	2023	Quinta-feira
5279	2023-06-16	16	6	Junho	2	2023	Sexta-feira
5280	2023-06-17	17	6	Junho	2	2023	S├íbado
5281	2023-06-18	18	6	Junho	2	2023	Domingo
5282	2023-06-19	19	6	Junho	2	2023	Segunda-feira
5283	2023-06-20	20	6	Junho	2	2023	Ter├ºa-feira
5284	2023-06-21	21	6	Junho	2	2023	Quarta-feira
5285	2023-06-22	22	6	Junho	2	2023	Quinta-feira
5286	2023-06-23	23	6	Junho	2	2023	Sexta-feira
5287	2023-06-24	24	6	Junho	2	2023	S├íbado
5288	2023-06-25	25	6	Junho	2	2023	Domingo
5289	2023-06-26	26	6	Junho	2	2023	Segunda-feira
5290	2023-06-27	27	6	Junho	2	2023	Ter├ºa-feira
5291	2023-06-28	28	6	Junho	2	2023	Quarta-feira
5292	2023-06-29	29	6	Junho	2	2023	Quinta-feira
5293	2023-06-30	30	6	Junho	2	2023	Sexta-feira
5294	2023-07-01	1	7	Julho	3	2023	S├íbado
5295	2023-07-02	2	7	Julho	3	2023	Domingo
5296	2023-07-03	3	7	Julho	3	2023	Segunda-feira
5297	2023-07-04	4	7	Julho	3	2023	Ter├ºa-feira
5298	2023-07-05	5	7	Julho	3	2023	Quarta-feira
5299	2023-07-06	6	7	Julho	3	2023	Quinta-feira
5300	2023-07-07	7	7	Julho	3	2023	Sexta-feira
5301	2023-07-08	8	7	Julho	3	2023	S├íbado
5302	2023-07-09	9	7	Julho	3	2023	Domingo
5303	2023-07-10	10	7	Julho	3	2023	Segunda-feira
5304	2023-07-11	11	7	Julho	3	2023	Ter├ºa-feira
5305	2023-07-12	12	7	Julho	3	2023	Quarta-feira
5306	2023-07-13	13	7	Julho	3	2023	Quinta-feira
5307	2023-07-14	14	7	Julho	3	2023	Sexta-feira
5308	2023-07-15	15	7	Julho	3	2023	S├íbado
5309	2023-07-16	16	7	Julho	3	2023	Domingo
5310	2023-07-17	17	7	Julho	3	2023	Segunda-feira
5311	2023-07-18	18	7	Julho	3	2023	Ter├ºa-feira
5312	2023-07-19	19	7	Julho	3	2023	Quarta-feira
5313	2023-07-20	20	7	Julho	3	2023	Quinta-feira
5314	2023-07-21	21	7	Julho	3	2023	Sexta-feira
5315	2023-07-22	22	7	Julho	3	2023	S├íbado
5316	2023-07-23	23	7	Julho	3	2023	Domingo
5317	2023-07-24	24	7	Julho	3	2023	Segunda-feira
5318	2023-07-25	25	7	Julho	3	2023	Ter├ºa-feira
5319	2023-07-26	26	7	Julho	3	2023	Quarta-feira
5320	2023-07-27	27	7	Julho	3	2023	Quinta-feira
5321	2023-07-28	28	7	Julho	3	2023	Sexta-feira
5322	2023-07-29	29	7	Julho	3	2023	S├íbado
5323	2023-07-30	30	7	Julho	3	2023	Domingo
5324	2023-07-31	31	7	Julho	3	2023	Segunda-feira
5325	2023-08-01	1	8	Agosto	3	2023	Ter├ºa-feira
5326	2023-08-02	2	8	Agosto	3	2023	Quarta-feira
5327	2023-08-03	3	8	Agosto	3	2023	Quinta-feira
5328	2023-08-04	4	8	Agosto	3	2023	Sexta-feira
5329	2023-08-05	5	8	Agosto	3	2023	S├íbado
5330	2023-08-06	6	8	Agosto	3	2023	Domingo
5331	2023-08-07	7	8	Agosto	3	2023	Segunda-feira
5332	2023-08-08	8	8	Agosto	3	2023	Ter├ºa-feira
5333	2023-08-09	9	8	Agosto	3	2023	Quarta-feira
5334	2023-08-10	10	8	Agosto	3	2023	Quinta-feira
5335	2023-08-11	11	8	Agosto	3	2023	Sexta-feira
5336	2023-08-12	12	8	Agosto	3	2023	S├íbado
5337	2023-08-13	13	8	Agosto	3	2023	Domingo
5338	2023-08-14	14	8	Agosto	3	2023	Segunda-feira
5339	2023-08-15	15	8	Agosto	3	2023	Ter├ºa-feira
5340	2023-08-16	16	8	Agosto	3	2023	Quarta-feira
5341	2023-08-17	17	8	Agosto	3	2023	Quinta-feira
5342	2023-08-18	18	8	Agosto	3	2023	Sexta-feira
5343	2023-08-19	19	8	Agosto	3	2023	S├íbado
5344	2023-08-20	20	8	Agosto	3	2023	Domingo
5345	2023-08-21	21	8	Agosto	3	2023	Segunda-feira
5346	2023-08-22	22	8	Agosto	3	2023	Ter├ºa-feira
5347	2023-08-23	23	8	Agosto	3	2023	Quarta-feira
5348	2023-08-24	24	8	Agosto	3	2023	Quinta-feira
5349	2023-08-25	25	8	Agosto	3	2023	Sexta-feira
5350	2023-08-26	26	8	Agosto	3	2023	S├íbado
5351	2023-08-27	27	8	Agosto	3	2023	Domingo
5352	2023-08-28	28	8	Agosto	3	2023	Segunda-feira
5353	2023-08-29	29	8	Agosto	3	2023	Ter├ºa-feira
5354	2023-08-30	30	8	Agosto	3	2023	Quarta-feira
5355	2023-08-31	31	8	Agosto	3	2023	Quinta-feira
5356	2023-09-01	1	9	Setembro	3	2023	Sexta-feira
5357	2023-09-02	2	9	Setembro	3	2023	S├íbado
5358	2023-09-03	3	9	Setembro	3	2023	Domingo
5359	2023-09-04	4	9	Setembro	3	2023	Segunda-feira
5360	2023-09-05	5	9	Setembro	3	2023	Ter├ºa-feira
5361	2023-09-06	6	9	Setembro	3	2023	Quarta-feira
5362	2023-09-07	7	9	Setembro	3	2023	Quinta-feira
5363	2023-09-08	8	9	Setembro	3	2023	Sexta-feira
5364	2023-09-09	9	9	Setembro	3	2023	S├íbado
5365	2023-09-10	10	9	Setembro	3	2023	Domingo
5366	2023-09-11	11	9	Setembro	3	2023	Segunda-feira
5367	2023-09-12	12	9	Setembro	3	2023	Ter├ºa-feira
5368	2023-09-13	13	9	Setembro	3	2023	Quarta-feira
5369	2023-09-14	14	9	Setembro	3	2023	Quinta-feira
5370	2023-09-15	15	9	Setembro	3	2023	Sexta-feira
5371	2023-09-16	16	9	Setembro	3	2023	S├íbado
5372	2023-09-17	17	9	Setembro	3	2023	Domingo
5373	2023-09-18	18	9	Setembro	3	2023	Segunda-feira
5374	2023-09-19	19	9	Setembro	3	2023	Ter├ºa-feira
5375	2023-09-20	20	9	Setembro	3	2023	Quarta-feira
5376	2023-09-21	21	9	Setembro	3	2023	Quinta-feira
5377	2023-09-22	22	9	Setembro	3	2023	Sexta-feira
5378	2023-09-23	23	9	Setembro	3	2023	S├íbado
5379	2023-09-24	24	9	Setembro	3	2023	Domingo
5380	2023-09-25	25	9	Setembro	3	2023	Segunda-feira
5381	2023-09-26	26	9	Setembro	3	2023	Ter├ºa-feira
5382	2023-09-27	27	9	Setembro	3	2023	Quarta-feira
5383	2023-09-28	28	9	Setembro	3	2023	Quinta-feira
5384	2023-09-29	29	9	Setembro	3	2023	Sexta-feira
5385	2023-09-30	30	9	Setembro	3	2023	S├íbado
5386	2023-10-01	1	10	Outubro	4	2023	Domingo
5387	2023-10-02	2	10	Outubro	4	2023	Segunda-feira
5388	2023-10-03	3	10	Outubro	4	2023	Ter├ºa-feira
5389	2023-10-04	4	10	Outubro	4	2023	Quarta-feira
5390	2023-10-05	5	10	Outubro	4	2023	Quinta-feira
5391	2023-10-06	6	10	Outubro	4	2023	Sexta-feira
5392	2023-10-07	7	10	Outubro	4	2023	S├íbado
5393	2023-10-08	8	10	Outubro	4	2023	Domingo
5394	2023-10-09	9	10	Outubro	4	2023	Segunda-feira
5395	2023-10-10	10	10	Outubro	4	2023	Ter├ºa-feira
5396	2023-10-11	11	10	Outubro	4	2023	Quarta-feira
5397	2023-10-12	12	10	Outubro	4	2023	Quinta-feira
5398	2023-10-13	13	10	Outubro	4	2023	Sexta-feira
5399	2023-10-14	14	10	Outubro	4	2023	S├íbado
5400	2023-10-15	15	10	Outubro	4	2023	Domingo
5401	2023-10-16	16	10	Outubro	4	2023	Segunda-feira
5402	2023-10-17	17	10	Outubro	4	2023	Ter├ºa-feira
5403	2023-10-18	18	10	Outubro	4	2023	Quarta-feira
5404	2023-10-19	19	10	Outubro	4	2023	Quinta-feira
5405	2023-10-20	20	10	Outubro	4	2023	Sexta-feira
5406	2023-10-21	21	10	Outubro	4	2023	S├íbado
5407	2023-10-22	22	10	Outubro	4	2023	Domingo
5408	2023-10-23	23	10	Outubro	4	2023	Segunda-feira
5409	2023-10-24	24	10	Outubro	4	2023	Ter├ºa-feira
5410	2023-10-25	25	10	Outubro	4	2023	Quarta-feira
5411	2023-10-26	26	10	Outubro	4	2023	Quinta-feira
5412	2023-10-27	27	10	Outubro	4	2023	Sexta-feira
5413	2023-10-28	28	10	Outubro	4	2023	S├íbado
5414	2023-10-29	29	10	Outubro	4	2023	Domingo
5415	2023-10-30	30	10	Outubro	4	2023	Segunda-feira
5416	2023-10-31	31	10	Outubro	4	2023	Ter├ºa-feira
5417	2023-11-01	1	11	Novembro	4	2023	Quarta-feira
5418	2023-11-02	2	11	Novembro	4	2023	Quinta-feira
5419	2023-11-03	3	11	Novembro	4	2023	Sexta-feira
5420	2023-11-04	4	11	Novembro	4	2023	S├íbado
5421	2023-11-05	5	11	Novembro	4	2023	Domingo
5422	2023-11-06	6	11	Novembro	4	2023	Segunda-feira
5423	2023-11-07	7	11	Novembro	4	2023	Ter├ºa-feira
5424	2023-11-08	8	11	Novembro	4	2023	Quarta-feira
5425	2023-11-09	9	11	Novembro	4	2023	Quinta-feira
5426	2023-11-10	10	11	Novembro	4	2023	Sexta-feira
5427	2023-11-11	11	11	Novembro	4	2023	S├íbado
5428	2023-11-12	12	11	Novembro	4	2023	Domingo
5429	2023-11-13	13	11	Novembro	4	2023	Segunda-feira
5430	2023-11-14	14	11	Novembro	4	2023	Ter├ºa-feira
5431	2023-11-15	15	11	Novembro	4	2023	Quarta-feira
5432	2023-11-16	16	11	Novembro	4	2023	Quinta-feira
5433	2023-11-17	17	11	Novembro	4	2023	Sexta-feira
5434	2023-11-18	18	11	Novembro	4	2023	S├íbado
5435	2023-11-19	19	11	Novembro	4	2023	Domingo
5436	2023-11-20	20	11	Novembro	4	2023	Segunda-feira
5437	2023-11-21	21	11	Novembro	4	2023	Ter├ºa-feira
5438	2023-11-22	22	11	Novembro	4	2023	Quarta-feira
5439	2023-11-23	23	11	Novembro	4	2023	Quinta-feira
5440	2023-11-24	24	11	Novembro	4	2023	Sexta-feira
5441	2023-11-25	25	11	Novembro	4	2023	S├íbado
5442	2023-11-26	26	11	Novembro	4	2023	Domingo
5443	2023-11-27	27	11	Novembro	4	2023	Segunda-feira
5444	2023-11-28	28	11	Novembro	4	2023	Ter├ºa-feira
5445	2023-11-29	29	11	Novembro	4	2023	Quarta-feira
5446	2023-11-30	30	11	Novembro	4	2023	Quinta-feira
5447	2023-12-01	1	12	Dezembro	4	2023	Sexta-feira
5448	2023-12-02	2	12	Dezembro	4	2023	S├íbado
5449	2023-12-03	3	12	Dezembro	4	2023	Domingo
5450	2023-12-04	4	12	Dezembro	4	2023	Segunda-feira
5451	2023-12-05	5	12	Dezembro	4	2023	Ter├ºa-feira
5452	2023-12-06	6	12	Dezembro	4	2023	Quarta-feira
5453	2023-12-07	7	12	Dezembro	4	2023	Quinta-feira
5454	2023-12-08	8	12	Dezembro	4	2023	Sexta-feira
5455	2023-12-09	9	12	Dezembro	4	2023	S├íbado
5456	2023-12-10	10	12	Dezembro	4	2023	Domingo
5457	2023-12-11	11	12	Dezembro	4	2023	Segunda-feira
5458	2023-12-12	12	12	Dezembro	4	2023	Ter├ºa-feira
5459	2023-12-13	13	12	Dezembro	4	2023	Quarta-feira
5460	2023-12-14	14	12	Dezembro	4	2023	Quinta-feira
5461	2023-12-15	15	12	Dezembro	4	2023	Sexta-feira
5462	2023-12-16	16	12	Dezembro	4	2023	S├íbado
5463	2023-12-17	17	12	Dezembro	4	2023	Domingo
5464	2023-12-18	18	12	Dezembro	4	2023	Segunda-feira
5465	2023-12-19	19	12	Dezembro	4	2023	Ter├ºa-feira
5466	2023-12-20	20	12	Dezembro	4	2023	Quarta-feira
5467	2023-12-21	21	12	Dezembro	4	2023	Quinta-feira
5468	2023-12-22	22	12	Dezembro	4	2023	Sexta-feira
5469	2023-12-23	23	12	Dezembro	4	2023	S├íbado
5470	2023-12-24	24	12	Dezembro	4	2023	Domingo
5471	2023-12-25	25	12	Dezembro	4	2023	Segunda-feira
5472	2023-12-26	26	12	Dezembro	4	2023	Ter├ºa-feira
5473	2023-12-27	27	12	Dezembro	4	2023	Quarta-feira
5474	2023-12-28	28	12	Dezembro	4	2023	Quinta-feira
5475	2023-12-29	29	12	Dezembro	4	2023	Sexta-feira
5476	2023-12-30	30	12	Dezembro	4	2023	S├íbado
5477	2023-12-31	31	12	Dezembro	4	2023	Domingo
5478	2024-01-01	1	1	Janeiro	1	2024	Segunda-feira
5479	2024-01-02	2	1	Janeiro	1	2024	Ter├ºa-feira
5480	2024-01-03	3	1	Janeiro	1	2024	Quarta-feira
5481	2024-01-04	4	1	Janeiro	1	2024	Quinta-feira
5482	2024-01-05	5	1	Janeiro	1	2024	Sexta-feira
5483	2024-01-06	6	1	Janeiro	1	2024	S├íbado
5484	2024-01-07	7	1	Janeiro	1	2024	Domingo
5485	2024-01-08	8	1	Janeiro	1	2024	Segunda-feira
5486	2024-01-09	9	1	Janeiro	1	2024	Ter├ºa-feira
5487	2024-01-10	10	1	Janeiro	1	2024	Quarta-feira
5488	2024-01-11	11	1	Janeiro	1	2024	Quinta-feira
5489	2024-01-12	12	1	Janeiro	1	2024	Sexta-feira
5490	2024-01-13	13	1	Janeiro	1	2024	S├íbado
5491	2024-01-14	14	1	Janeiro	1	2024	Domingo
5492	2024-01-15	15	1	Janeiro	1	2024	Segunda-feira
5493	2024-01-16	16	1	Janeiro	1	2024	Ter├ºa-feira
5494	2024-01-17	17	1	Janeiro	1	2024	Quarta-feira
5495	2024-01-18	18	1	Janeiro	1	2024	Quinta-feira
5496	2024-01-19	19	1	Janeiro	1	2024	Sexta-feira
5497	2024-01-20	20	1	Janeiro	1	2024	S├íbado
5498	2024-01-21	21	1	Janeiro	1	2024	Domingo
5499	2024-01-22	22	1	Janeiro	1	2024	Segunda-feira
5500	2024-01-23	23	1	Janeiro	1	2024	Ter├ºa-feira
5501	2024-01-24	24	1	Janeiro	1	2024	Quarta-feira
5502	2024-01-25	25	1	Janeiro	1	2024	Quinta-feira
5503	2024-01-26	26	1	Janeiro	1	2024	Sexta-feira
5504	2024-01-27	27	1	Janeiro	1	2024	S├íbado
5505	2024-01-28	28	1	Janeiro	1	2024	Domingo
5506	2024-01-29	29	1	Janeiro	1	2024	Segunda-feira
5507	2024-01-30	30	1	Janeiro	1	2024	Ter├ºa-feira
5508	2024-01-31	31	1	Janeiro	1	2024	Quarta-feira
5509	2024-02-01	1	2	Fevereiro	1	2024	Quinta-feira
5510	2024-02-02	2	2	Fevereiro	1	2024	Sexta-feira
5511	2024-02-03	3	2	Fevereiro	1	2024	S├íbado
5512	2024-02-04	4	2	Fevereiro	1	2024	Domingo
5513	2024-02-05	5	2	Fevereiro	1	2024	Segunda-feira
5514	2024-02-06	6	2	Fevereiro	1	2024	Ter├ºa-feira
5515	2024-02-07	7	2	Fevereiro	1	2024	Quarta-feira
5516	2024-02-08	8	2	Fevereiro	1	2024	Quinta-feira
5517	2024-02-09	9	2	Fevereiro	1	2024	Sexta-feira
5518	2024-02-10	10	2	Fevereiro	1	2024	S├íbado
5519	2024-02-11	11	2	Fevereiro	1	2024	Domingo
5520	2024-02-12	12	2	Fevereiro	1	2024	Segunda-feira
5521	2024-02-13	13	2	Fevereiro	1	2024	Ter├ºa-feira
5522	2024-02-14	14	2	Fevereiro	1	2024	Quarta-feira
5523	2024-02-15	15	2	Fevereiro	1	2024	Quinta-feira
5524	2024-02-16	16	2	Fevereiro	1	2024	Sexta-feira
5525	2024-02-17	17	2	Fevereiro	1	2024	S├íbado
5526	2024-02-18	18	2	Fevereiro	1	2024	Domingo
5527	2024-02-19	19	2	Fevereiro	1	2024	Segunda-feira
5528	2024-02-20	20	2	Fevereiro	1	2024	Ter├ºa-feira
5529	2024-02-21	21	2	Fevereiro	1	2024	Quarta-feira
5530	2024-02-22	22	2	Fevereiro	1	2024	Quinta-feira
5531	2024-02-23	23	2	Fevereiro	1	2024	Sexta-feira
5532	2024-02-24	24	2	Fevereiro	1	2024	S├íbado
5533	2024-02-25	25	2	Fevereiro	1	2024	Domingo
5534	2024-02-26	26	2	Fevereiro	1	2024	Segunda-feira
5535	2024-02-27	27	2	Fevereiro	1	2024	Ter├ºa-feira
5536	2024-02-28	28	2	Fevereiro	1	2024	Quarta-feira
5537	2024-02-29	29	2	Fevereiro	1	2024	Quinta-feira
5538	2024-03-01	1	3	Mar├ºo	1	2024	Sexta-feira
5539	2024-03-02	2	3	Mar├ºo	1	2024	S├íbado
5540	2024-03-03	3	3	Mar├ºo	1	2024	Domingo
5541	2024-03-04	4	3	Mar├ºo	1	2024	Segunda-feira
5542	2024-03-05	5	3	Mar├ºo	1	2024	Ter├ºa-feira
5543	2024-03-06	6	3	Mar├ºo	1	2024	Quarta-feira
5544	2024-03-07	7	3	Mar├ºo	1	2024	Quinta-feira
5545	2024-03-08	8	3	Mar├ºo	1	2024	Sexta-feira
5546	2024-03-09	9	3	Mar├ºo	1	2024	S├íbado
5547	2024-03-10	10	3	Mar├ºo	1	2024	Domingo
5548	2024-03-11	11	3	Mar├ºo	1	2024	Segunda-feira
5549	2024-03-12	12	3	Mar├ºo	1	2024	Ter├ºa-feira
5550	2024-03-13	13	3	Mar├ºo	1	2024	Quarta-feira
5551	2024-03-14	14	3	Mar├ºo	1	2024	Quinta-feira
5552	2024-03-15	15	3	Mar├ºo	1	2024	Sexta-feira
5553	2024-03-16	16	3	Mar├ºo	1	2024	S├íbado
5554	2024-03-17	17	3	Mar├ºo	1	2024	Domingo
5555	2024-03-18	18	3	Mar├ºo	1	2024	Segunda-feira
5556	2024-03-19	19	3	Mar├ºo	1	2024	Ter├ºa-feira
5557	2024-03-20	20	3	Mar├ºo	1	2024	Quarta-feira
5558	2024-03-21	21	3	Mar├ºo	1	2024	Quinta-feira
5559	2024-03-22	22	3	Mar├ºo	1	2024	Sexta-feira
5560	2024-03-23	23	3	Mar├ºo	1	2024	S├íbado
5561	2024-03-24	24	3	Mar├ºo	1	2024	Domingo
5562	2024-03-25	25	3	Mar├ºo	1	2024	Segunda-feira
5563	2024-03-26	26	3	Mar├ºo	1	2024	Ter├ºa-feira
5564	2024-03-27	27	3	Mar├ºo	1	2024	Quarta-feira
5565	2024-03-28	28	3	Mar├ºo	1	2024	Quinta-feira
5566	2024-03-29	29	3	Mar├ºo	1	2024	Sexta-feira
5567	2024-03-30	30	3	Mar├ºo	1	2024	S├íbado
5568	2024-03-31	31	3	Mar├ºo	1	2024	Domingo
5569	2024-04-01	1	4	Abril	2	2024	Segunda-feira
5570	2024-04-02	2	4	Abril	2	2024	Ter├ºa-feira
5571	2024-04-03	3	4	Abril	2	2024	Quarta-feira
5572	2024-04-04	4	4	Abril	2	2024	Quinta-feira
5573	2024-04-05	5	4	Abril	2	2024	Sexta-feira
5574	2024-04-06	6	4	Abril	2	2024	S├íbado
5575	2024-04-07	7	4	Abril	2	2024	Domingo
5576	2024-04-08	8	4	Abril	2	2024	Segunda-feira
5577	2024-04-09	9	4	Abril	2	2024	Ter├ºa-feira
5578	2024-04-10	10	4	Abril	2	2024	Quarta-feira
5579	2024-04-11	11	4	Abril	2	2024	Quinta-feira
5580	2024-04-12	12	4	Abril	2	2024	Sexta-feira
5581	2024-04-13	13	4	Abril	2	2024	S├íbado
5582	2024-04-14	14	4	Abril	2	2024	Domingo
5583	2024-04-15	15	4	Abril	2	2024	Segunda-feira
5584	2024-04-16	16	4	Abril	2	2024	Ter├ºa-feira
5585	2024-04-17	17	4	Abril	2	2024	Quarta-feira
5586	2024-04-18	18	4	Abril	2	2024	Quinta-feira
5587	2024-04-19	19	4	Abril	2	2024	Sexta-feira
5588	2024-04-20	20	4	Abril	2	2024	S├íbado
5589	2024-04-21	21	4	Abril	2	2024	Domingo
5590	2024-04-22	22	4	Abril	2	2024	Segunda-feira
5591	2024-04-23	23	4	Abril	2	2024	Ter├ºa-feira
5592	2024-04-24	24	4	Abril	2	2024	Quarta-feira
5593	2024-04-25	25	4	Abril	2	2024	Quinta-feira
5594	2024-04-26	26	4	Abril	2	2024	Sexta-feira
5595	2024-04-27	27	4	Abril	2	2024	S├íbado
5596	2024-04-28	28	4	Abril	2	2024	Domingo
5597	2024-04-29	29	4	Abril	2	2024	Segunda-feira
5598	2024-04-30	30	4	Abril	2	2024	Ter├ºa-feira
5599	2024-05-01	1	5	Maio	2	2024	Quarta-feira
5600	2024-05-02	2	5	Maio	2	2024	Quinta-feira
5601	2024-05-03	3	5	Maio	2	2024	Sexta-feira
5602	2024-05-04	4	5	Maio	2	2024	S├íbado
5603	2024-05-05	5	5	Maio	2	2024	Domingo
5604	2024-05-06	6	5	Maio	2	2024	Segunda-feira
5605	2024-05-07	7	5	Maio	2	2024	Ter├ºa-feira
5606	2024-05-08	8	5	Maio	2	2024	Quarta-feira
5607	2024-05-09	9	5	Maio	2	2024	Quinta-feira
5608	2024-05-10	10	5	Maio	2	2024	Sexta-feira
5609	2024-05-11	11	5	Maio	2	2024	S├íbado
5610	2024-05-12	12	5	Maio	2	2024	Domingo
5611	2024-05-13	13	5	Maio	2	2024	Segunda-feira
5612	2024-05-14	14	5	Maio	2	2024	Ter├ºa-feira
5613	2024-05-15	15	5	Maio	2	2024	Quarta-feira
5614	2024-05-16	16	5	Maio	2	2024	Quinta-feira
5615	2024-05-17	17	5	Maio	2	2024	Sexta-feira
5616	2024-05-18	18	5	Maio	2	2024	S├íbado
5617	2024-05-19	19	5	Maio	2	2024	Domingo
5618	2024-05-20	20	5	Maio	2	2024	Segunda-feira
5619	2024-05-21	21	5	Maio	2	2024	Ter├ºa-feira
5620	2024-05-22	22	5	Maio	2	2024	Quarta-feira
5621	2024-05-23	23	5	Maio	2	2024	Quinta-feira
5622	2024-05-24	24	5	Maio	2	2024	Sexta-feira
5623	2024-05-25	25	5	Maio	2	2024	S├íbado
5624	2024-05-26	26	5	Maio	2	2024	Domingo
5625	2024-05-27	27	5	Maio	2	2024	Segunda-feira
5626	2024-05-28	28	5	Maio	2	2024	Ter├ºa-feira
5627	2024-05-29	29	5	Maio	2	2024	Quarta-feira
5628	2024-05-30	30	5	Maio	2	2024	Quinta-feira
5629	2024-05-31	31	5	Maio	2	2024	Sexta-feira
5630	2024-06-01	1	6	Junho	2	2024	S├íbado
5631	2024-06-02	2	6	Junho	2	2024	Domingo
5632	2024-06-03	3	6	Junho	2	2024	Segunda-feira
5633	2024-06-04	4	6	Junho	2	2024	Ter├ºa-feira
5634	2024-06-05	5	6	Junho	2	2024	Quarta-feira
5635	2024-06-06	6	6	Junho	2	2024	Quinta-feira
5636	2024-06-07	7	6	Junho	2	2024	Sexta-feira
5637	2024-06-08	8	6	Junho	2	2024	S├íbado
5638	2024-06-09	9	6	Junho	2	2024	Domingo
5639	2024-06-10	10	6	Junho	2	2024	Segunda-feira
5640	2024-06-11	11	6	Junho	2	2024	Ter├ºa-feira
5641	2024-06-12	12	6	Junho	2	2024	Quarta-feira
5642	2024-06-13	13	6	Junho	2	2024	Quinta-feira
5643	2024-06-14	14	6	Junho	2	2024	Sexta-feira
5644	2024-06-15	15	6	Junho	2	2024	S├íbado
5645	2024-06-16	16	6	Junho	2	2024	Domingo
5646	2024-06-17	17	6	Junho	2	2024	Segunda-feira
5647	2024-06-18	18	6	Junho	2	2024	Ter├ºa-feira
5648	2024-06-19	19	6	Junho	2	2024	Quarta-feira
5649	2024-06-20	20	6	Junho	2	2024	Quinta-feira
5650	2024-06-21	21	6	Junho	2	2024	Sexta-feira
5651	2024-06-22	22	6	Junho	2	2024	S├íbado
5652	2024-06-23	23	6	Junho	2	2024	Domingo
5653	2024-06-24	24	6	Junho	2	2024	Segunda-feira
5654	2024-06-25	25	6	Junho	2	2024	Ter├ºa-feira
5655	2024-06-26	26	6	Junho	2	2024	Quarta-feira
5656	2024-06-27	27	6	Junho	2	2024	Quinta-feira
5657	2024-06-28	28	6	Junho	2	2024	Sexta-feira
5658	2024-06-29	29	6	Junho	2	2024	S├íbado
5659	2024-06-30	30	6	Junho	2	2024	Domingo
5660	2024-07-01	1	7	Julho	3	2024	Segunda-feira
5661	2024-07-02	2	7	Julho	3	2024	Ter├ºa-feira
5662	2024-07-03	3	7	Julho	3	2024	Quarta-feira
5663	2024-07-04	4	7	Julho	3	2024	Quinta-feira
5664	2024-07-05	5	7	Julho	3	2024	Sexta-feira
5665	2024-07-06	6	7	Julho	3	2024	S├íbado
5666	2024-07-07	7	7	Julho	3	2024	Domingo
5667	2024-07-08	8	7	Julho	3	2024	Segunda-feira
5668	2024-07-09	9	7	Julho	3	2024	Ter├ºa-feira
5669	2024-07-10	10	7	Julho	3	2024	Quarta-feira
5670	2024-07-11	11	7	Julho	3	2024	Quinta-feira
5671	2024-07-12	12	7	Julho	3	2024	Sexta-feira
5672	2024-07-13	13	7	Julho	3	2024	S├íbado
5673	2024-07-14	14	7	Julho	3	2024	Domingo
5674	2024-07-15	15	7	Julho	3	2024	Segunda-feira
5675	2024-07-16	16	7	Julho	3	2024	Ter├ºa-feira
5676	2024-07-17	17	7	Julho	3	2024	Quarta-feira
5677	2024-07-18	18	7	Julho	3	2024	Quinta-feira
5678	2024-07-19	19	7	Julho	3	2024	Sexta-feira
5679	2024-07-20	20	7	Julho	3	2024	S├íbado
5680	2024-07-21	21	7	Julho	3	2024	Domingo
5681	2024-07-22	22	7	Julho	3	2024	Segunda-feira
5682	2024-07-23	23	7	Julho	3	2024	Ter├ºa-feira
5683	2024-07-24	24	7	Julho	3	2024	Quarta-feira
5684	2024-07-25	25	7	Julho	3	2024	Quinta-feira
5685	2024-07-26	26	7	Julho	3	2024	Sexta-feira
5686	2024-07-27	27	7	Julho	3	2024	S├íbado
5687	2024-07-28	28	7	Julho	3	2024	Domingo
5688	2024-07-29	29	7	Julho	3	2024	Segunda-feira
5689	2024-07-30	30	7	Julho	3	2024	Ter├ºa-feira
5690	2024-07-31	31	7	Julho	3	2024	Quarta-feira
5691	2024-08-01	1	8	Agosto	3	2024	Quinta-feira
5692	2024-08-02	2	8	Agosto	3	2024	Sexta-feira
5693	2024-08-03	3	8	Agosto	3	2024	S├íbado
5694	2024-08-04	4	8	Agosto	3	2024	Domingo
5695	2024-08-05	5	8	Agosto	3	2024	Segunda-feira
5696	2024-08-06	6	8	Agosto	3	2024	Ter├ºa-feira
5697	2024-08-07	7	8	Agosto	3	2024	Quarta-feira
5698	2024-08-08	8	8	Agosto	3	2024	Quinta-feira
5699	2024-08-09	9	8	Agosto	3	2024	Sexta-feira
5700	2024-08-10	10	8	Agosto	3	2024	S├íbado
5701	2024-08-11	11	8	Agosto	3	2024	Domingo
5702	2024-08-12	12	8	Agosto	3	2024	Segunda-feira
5703	2024-08-13	13	8	Agosto	3	2024	Ter├ºa-feira
5704	2024-08-14	14	8	Agosto	3	2024	Quarta-feira
5705	2024-08-15	15	8	Agosto	3	2024	Quinta-feira
5706	2024-08-16	16	8	Agosto	3	2024	Sexta-feira
5707	2024-08-17	17	8	Agosto	3	2024	S├íbado
5708	2024-08-18	18	8	Agosto	3	2024	Domingo
5709	2024-08-19	19	8	Agosto	3	2024	Segunda-feira
5710	2024-08-20	20	8	Agosto	3	2024	Ter├ºa-feira
5711	2024-08-21	21	8	Agosto	3	2024	Quarta-feira
5712	2024-08-22	22	8	Agosto	3	2024	Quinta-feira
5713	2024-08-23	23	8	Agosto	3	2024	Sexta-feira
5714	2024-08-24	24	8	Agosto	3	2024	S├íbado
5715	2024-08-25	25	8	Agosto	3	2024	Domingo
5716	2024-08-26	26	8	Agosto	3	2024	Segunda-feira
5717	2024-08-27	27	8	Agosto	3	2024	Ter├ºa-feira
5718	2024-08-28	28	8	Agosto	3	2024	Quarta-feira
5719	2024-08-29	29	8	Agosto	3	2024	Quinta-feira
5720	2024-08-30	30	8	Agosto	3	2024	Sexta-feira
5721	2024-08-31	31	8	Agosto	3	2024	S├íbado
5722	2024-09-01	1	9	Setembro	3	2024	Domingo
5723	2024-09-02	2	9	Setembro	3	2024	Segunda-feira
5724	2024-09-03	3	9	Setembro	3	2024	Ter├ºa-feira
5725	2024-09-04	4	9	Setembro	3	2024	Quarta-feira
5726	2024-09-05	5	9	Setembro	3	2024	Quinta-feira
5727	2024-09-06	6	9	Setembro	3	2024	Sexta-feira
5728	2024-09-07	7	9	Setembro	3	2024	S├íbado
5729	2024-09-08	8	9	Setembro	3	2024	Domingo
5730	2024-09-09	9	9	Setembro	3	2024	Segunda-feira
6372	2026-06-13	13	6	Junho	2	2026	S├íbado
5731	2024-09-10	10	9	Setembro	3	2024	Ter├ºa-feira
5732	2024-09-11	11	9	Setembro	3	2024	Quarta-feira
5733	2024-09-12	12	9	Setembro	3	2024	Quinta-feira
5734	2024-09-13	13	9	Setembro	3	2024	Sexta-feira
5735	2024-09-14	14	9	Setembro	3	2024	S├íbado
5736	2024-09-15	15	9	Setembro	3	2024	Domingo
5737	2024-09-16	16	9	Setembro	3	2024	Segunda-feira
5738	2024-09-17	17	9	Setembro	3	2024	Ter├ºa-feira
5739	2024-09-18	18	9	Setembro	3	2024	Quarta-feira
5740	2024-09-19	19	9	Setembro	3	2024	Quinta-feira
5741	2024-09-20	20	9	Setembro	3	2024	Sexta-feira
5742	2024-09-21	21	9	Setembro	3	2024	S├íbado
5743	2024-09-22	22	9	Setembro	3	2024	Domingo
5744	2024-09-23	23	9	Setembro	3	2024	Segunda-feira
5745	2024-09-24	24	9	Setembro	3	2024	Ter├ºa-feira
5746	2024-09-25	25	9	Setembro	3	2024	Quarta-feira
5747	2024-09-26	26	9	Setembro	3	2024	Quinta-feira
5748	2024-09-27	27	9	Setembro	3	2024	Sexta-feira
5749	2024-09-28	28	9	Setembro	3	2024	S├íbado
5750	2024-09-29	29	9	Setembro	3	2024	Domingo
5751	2024-09-30	30	9	Setembro	3	2024	Segunda-feira
5752	2024-10-01	1	10	Outubro	4	2024	Ter├ºa-feira
5753	2024-10-02	2	10	Outubro	4	2024	Quarta-feira
5754	2024-10-03	3	10	Outubro	4	2024	Quinta-feira
5755	2024-10-04	4	10	Outubro	4	2024	Sexta-feira
5756	2024-10-05	5	10	Outubro	4	2024	S├íbado
5757	2024-10-06	6	10	Outubro	4	2024	Domingo
5758	2024-10-07	7	10	Outubro	4	2024	Segunda-feira
5759	2024-10-08	8	10	Outubro	4	2024	Ter├ºa-feira
5760	2024-10-09	9	10	Outubro	4	2024	Quarta-feira
5761	2024-10-10	10	10	Outubro	4	2024	Quinta-feira
5762	2024-10-11	11	10	Outubro	4	2024	Sexta-feira
5763	2024-10-12	12	10	Outubro	4	2024	S├íbado
5764	2024-10-13	13	10	Outubro	4	2024	Domingo
5765	2024-10-14	14	10	Outubro	4	2024	Segunda-feira
5766	2024-10-15	15	10	Outubro	4	2024	Ter├ºa-feira
5767	2024-10-16	16	10	Outubro	4	2024	Quarta-feira
5768	2024-10-17	17	10	Outubro	4	2024	Quinta-feira
5769	2024-10-18	18	10	Outubro	4	2024	Sexta-feira
5770	2024-10-19	19	10	Outubro	4	2024	S├íbado
5771	2024-10-20	20	10	Outubro	4	2024	Domingo
5772	2024-10-21	21	10	Outubro	4	2024	Segunda-feira
5773	2024-10-22	22	10	Outubro	4	2024	Ter├ºa-feira
5774	2024-10-23	23	10	Outubro	4	2024	Quarta-feira
5775	2024-10-24	24	10	Outubro	4	2024	Quinta-feira
5776	2024-10-25	25	10	Outubro	4	2024	Sexta-feira
5777	2024-10-26	26	10	Outubro	4	2024	S├íbado
5778	2024-10-27	27	10	Outubro	4	2024	Domingo
5779	2024-10-28	28	10	Outubro	4	2024	Segunda-feira
5780	2024-10-29	29	10	Outubro	4	2024	Ter├ºa-feira
5781	2024-10-30	30	10	Outubro	4	2024	Quarta-feira
5782	2024-10-31	31	10	Outubro	4	2024	Quinta-feira
5783	2024-11-01	1	11	Novembro	4	2024	Sexta-feira
5784	2024-11-02	2	11	Novembro	4	2024	S├íbado
5785	2024-11-03	3	11	Novembro	4	2024	Domingo
5786	2024-11-04	4	11	Novembro	4	2024	Segunda-feira
5787	2024-11-05	5	11	Novembro	4	2024	Ter├ºa-feira
5788	2024-11-06	6	11	Novembro	4	2024	Quarta-feira
5789	2024-11-07	7	11	Novembro	4	2024	Quinta-feira
5790	2024-11-08	8	11	Novembro	4	2024	Sexta-feira
5791	2024-11-09	9	11	Novembro	4	2024	S├íbado
5792	2024-11-10	10	11	Novembro	4	2024	Domingo
5793	2024-11-11	11	11	Novembro	4	2024	Segunda-feira
5794	2024-11-12	12	11	Novembro	4	2024	Ter├ºa-feira
5795	2024-11-13	13	11	Novembro	4	2024	Quarta-feira
5796	2024-11-14	14	11	Novembro	4	2024	Quinta-feira
5797	2024-11-15	15	11	Novembro	4	2024	Sexta-feira
5798	2024-11-16	16	11	Novembro	4	2024	S├íbado
5799	2024-11-17	17	11	Novembro	4	2024	Domingo
5800	2024-11-18	18	11	Novembro	4	2024	Segunda-feira
5801	2024-11-19	19	11	Novembro	4	2024	Ter├ºa-feira
5802	2024-11-20	20	11	Novembro	4	2024	Quarta-feira
5803	2024-11-21	21	11	Novembro	4	2024	Quinta-feira
5804	2024-11-22	22	11	Novembro	4	2024	Sexta-feira
5805	2024-11-23	23	11	Novembro	4	2024	S├íbado
5806	2024-11-24	24	11	Novembro	4	2024	Domingo
5807	2024-11-25	25	11	Novembro	4	2024	Segunda-feira
5808	2024-11-26	26	11	Novembro	4	2024	Ter├ºa-feira
5809	2024-11-27	27	11	Novembro	4	2024	Quarta-feira
5810	2024-11-28	28	11	Novembro	4	2024	Quinta-feira
5811	2024-11-29	29	11	Novembro	4	2024	Sexta-feira
5812	2024-11-30	30	11	Novembro	4	2024	S├íbado
5813	2024-12-01	1	12	Dezembro	4	2024	Domingo
5814	2024-12-02	2	12	Dezembro	4	2024	Segunda-feira
5815	2024-12-03	3	12	Dezembro	4	2024	Ter├ºa-feira
5816	2024-12-04	4	12	Dezembro	4	2024	Quarta-feira
5817	2024-12-05	5	12	Dezembro	4	2024	Quinta-feira
5818	2024-12-06	6	12	Dezembro	4	2024	Sexta-feira
5819	2024-12-07	7	12	Dezembro	4	2024	S├íbado
5820	2024-12-08	8	12	Dezembro	4	2024	Domingo
5821	2024-12-09	9	12	Dezembro	4	2024	Segunda-feira
5822	2024-12-10	10	12	Dezembro	4	2024	Ter├ºa-feira
5823	2024-12-11	11	12	Dezembro	4	2024	Quarta-feira
5824	2024-12-12	12	12	Dezembro	4	2024	Quinta-feira
5825	2024-12-13	13	12	Dezembro	4	2024	Sexta-feira
5826	2024-12-14	14	12	Dezembro	4	2024	S├íbado
5827	2024-12-15	15	12	Dezembro	4	2024	Domingo
5828	2024-12-16	16	12	Dezembro	4	2024	Segunda-feira
5829	2024-12-17	17	12	Dezembro	4	2024	Ter├ºa-feira
5830	2024-12-18	18	12	Dezembro	4	2024	Quarta-feira
5831	2024-12-19	19	12	Dezembro	4	2024	Quinta-feira
5832	2024-12-20	20	12	Dezembro	4	2024	Sexta-feira
5833	2024-12-21	21	12	Dezembro	4	2024	S├íbado
5834	2024-12-22	22	12	Dezembro	4	2024	Domingo
5835	2024-12-23	23	12	Dezembro	4	2024	Segunda-feira
5836	2024-12-24	24	12	Dezembro	4	2024	Ter├ºa-feira
5837	2024-12-25	25	12	Dezembro	4	2024	Quarta-feira
5838	2024-12-26	26	12	Dezembro	4	2024	Quinta-feira
5839	2024-12-27	27	12	Dezembro	4	2024	Sexta-feira
5840	2024-12-28	28	12	Dezembro	4	2024	S├íbado
5841	2024-12-29	29	12	Dezembro	4	2024	Domingo
5842	2024-12-30	30	12	Dezembro	4	2024	Segunda-feira
5843	2024-12-31	31	12	Dezembro	4	2024	Ter├ºa-feira
5844	2025-01-01	1	1	Janeiro	1	2025	Quarta-feira
5845	2025-01-02	2	1	Janeiro	1	2025	Quinta-feira
5846	2025-01-03	3	1	Janeiro	1	2025	Sexta-feira
5847	2025-01-04	4	1	Janeiro	1	2025	S├íbado
5848	2025-01-05	5	1	Janeiro	1	2025	Domingo
5849	2025-01-06	6	1	Janeiro	1	2025	Segunda-feira
5850	2025-01-07	7	1	Janeiro	1	2025	Ter├ºa-feira
5851	2025-01-08	8	1	Janeiro	1	2025	Quarta-feira
5852	2025-01-09	9	1	Janeiro	1	2025	Quinta-feira
5853	2025-01-10	10	1	Janeiro	1	2025	Sexta-feira
5854	2025-01-11	11	1	Janeiro	1	2025	S├íbado
5855	2025-01-12	12	1	Janeiro	1	2025	Domingo
5856	2025-01-13	13	1	Janeiro	1	2025	Segunda-feira
5857	2025-01-14	14	1	Janeiro	1	2025	Ter├ºa-feira
5858	2025-01-15	15	1	Janeiro	1	2025	Quarta-feira
5859	2025-01-16	16	1	Janeiro	1	2025	Quinta-feira
5860	2025-01-17	17	1	Janeiro	1	2025	Sexta-feira
5861	2025-01-18	18	1	Janeiro	1	2025	S├íbado
5862	2025-01-19	19	1	Janeiro	1	2025	Domingo
5863	2025-01-20	20	1	Janeiro	1	2025	Segunda-feira
5864	2025-01-21	21	1	Janeiro	1	2025	Ter├ºa-feira
5865	2025-01-22	22	1	Janeiro	1	2025	Quarta-feira
5866	2025-01-23	23	1	Janeiro	1	2025	Quinta-feira
5867	2025-01-24	24	1	Janeiro	1	2025	Sexta-feira
5868	2025-01-25	25	1	Janeiro	1	2025	S├íbado
5869	2025-01-26	26	1	Janeiro	1	2025	Domingo
5870	2025-01-27	27	1	Janeiro	1	2025	Segunda-feira
5871	2025-01-28	28	1	Janeiro	1	2025	Ter├ºa-feira
5872	2025-01-29	29	1	Janeiro	1	2025	Quarta-feira
5873	2025-01-30	30	1	Janeiro	1	2025	Quinta-feira
5874	2025-01-31	31	1	Janeiro	1	2025	Sexta-feira
5875	2025-02-01	1	2	Fevereiro	1	2025	S├íbado
5876	2025-02-02	2	2	Fevereiro	1	2025	Domingo
5877	2025-02-03	3	2	Fevereiro	1	2025	Segunda-feira
5878	2025-02-04	4	2	Fevereiro	1	2025	Ter├ºa-feira
5879	2025-02-05	5	2	Fevereiro	1	2025	Quarta-feira
5880	2025-02-06	6	2	Fevereiro	1	2025	Quinta-feira
5881	2025-02-07	7	2	Fevereiro	1	2025	Sexta-feira
5882	2025-02-08	8	2	Fevereiro	1	2025	S├íbado
5883	2025-02-09	9	2	Fevereiro	1	2025	Domingo
5884	2025-02-10	10	2	Fevereiro	1	2025	Segunda-feira
5885	2025-02-11	11	2	Fevereiro	1	2025	Ter├ºa-feira
5886	2025-02-12	12	2	Fevereiro	1	2025	Quarta-feira
5887	2025-02-13	13	2	Fevereiro	1	2025	Quinta-feira
5888	2025-02-14	14	2	Fevereiro	1	2025	Sexta-feira
5889	2025-02-15	15	2	Fevereiro	1	2025	S├íbado
5890	2025-02-16	16	2	Fevereiro	1	2025	Domingo
5891	2025-02-17	17	2	Fevereiro	1	2025	Segunda-feira
5892	2025-02-18	18	2	Fevereiro	1	2025	Ter├ºa-feira
5893	2025-02-19	19	2	Fevereiro	1	2025	Quarta-feira
5894	2025-02-20	20	2	Fevereiro	1	2025	Quinta-feira
5895	2025-02-21	21	2	Fevereiro	1	2025	Sexta-feira
5896	2025-02-22	22	2	Fevereiro	1	2025	S├íbado
5897	2025-02-23	23	2	Fevereiro	1	2025	Domingo
5898	2025-02-24	24	2	Fevereiro	1	2025	Segunda-feira
5899	2025-02-25	25	2	Fevereiro	1	2025	Ter├ºa-feira
5900	2025-02-26	26	2	Fevereiro	1	2025	Quarta-feira
5901	2025-02-27	27	2	Fevereiro	1	2025	Quinta-feira
5902	2025-02-28	28	2	Fevereiro	1	2025	Sexta-feira
5903	2025-03-01	1	3	Mar├ºo	1	2025	S├íbado
5904	2025-03-02	2	3	Mar├ºo	1	2025	Domingo
5905	2025-03-03	3	3	Mar├ºo	1	2025	Segunda-feira
5906	2025-03-04	4	3	Mar├ºo	1	2025	Ter├ºa-feira
5907	2025-03-05	5	3	Mar├ºo	1	2025	Quarta-feira
5908	2025-03-06	6	3	Mar├ºo	1	2025	Quinta-feira
5909	2025-03-07	7	3	Mar├ºo	1	2025	Sexta-feira
5910	2025-03-08	8	3	Mar├ºo	1	2025	S├íbado
5911	2025-03-09	9	3	Mar├ºo	1	2025	Domingo
5912	2025-03-10	10	3	Mar├ºo	1	2025	Segunda-feira
5913	2025-03-11	11	3	Mar├ºo	1	2025	Ter├ºa-feira
5914	2025-03-12	12	3	Mar├ºo	1	2025	Quarta-feira
5915	2025-03-13	13	3	Mar├ºo	1	2025	Quinta-feira
5916	2025-03-14	14	3	Mar├ºo	1	2025	Sexta-feira
5917	2025-03-15	15	3	Mar├ºo	1	2025	S├íbado
5918	2025-03-16	16	3	Mar├ºo	1	2025	Domingo
5919	2025-03-17	17	3	Mar├ºo	1	2025	Segunda-feira
5920	2025-03-18	18	3	Mar├ºo	1	2025	Ter├ºa-feira
5921	2025-03-19	19	3	Mar├ºo	1	2025	Quarta-feira
5922	2025-03-20	20	3	Mar├ºo	1	2025	Quinta-feira
5923	2025-03-21	21	3	Mar├ºo	1	2025	Sexta-feira
5924	2025-03-22	22	3	Mar├ºo	1	2025	S├íbado
5925	2025-03-23	23	3	Mar├ºo	1	2025	Domingo
5926	2025-03-24	24	3	Mar├ºo	1	2025	Segunda-feira
5927	2025-03-25	25	3	Mar├ºo	1	2025	Ter├ºa-feira
5928	2025-03-26	26	3	Mar├ºo	1	2025	Quarta-feira
5929	2025-03-27	27	3	Mar├ºo	1	2025	Quinta-feira
5930	2025-03-28	28	3	Mar├ºo	1	2025	Sexta-feira
5931	2025-03-29	29	3	Mar├ºo	1	2025	S├íbado
5932	2025-03-30	30	3	Mar├ºo	1	2025	Domingo
5933	2025-03-31	31	3	Mar├ºo	1	2025	Segunda-feira
5934	2025-04-01	1	4	Abril	2	2025	Ter├ºa-feira
5935	2025-04-02	2	4	Abril	2	2025	Quarta-feira
5936	2025-04-03	3	4	Abril	2	2025	Quinta-feira
5937	2025-04-04	4	4	Abril	2	2025	Sexta-feira
5938	2025-04-05	5	4	Abril	2	2025	S├íbado
5939	2025-04-06	6	4	Abril	2	2025	Domingo
5940	2025-04-07	7	4	Abril	2	2025	Segunda-feira
5941	2025-04-08	8	4	Abril	2	2025	Ter├ºa-feira
5942	2025-04-09	9	4	Abril	2	2025	Quarta-feira
5943	2025-04-10	10	4	Abril	2	2025	Quinta-feira
5944	2025-04-11	11	4	Abril	2	2025	Sexta-feira
5945	2025-04-12	12	4	Abril	2	2025	S├íbado
5946	2025-04-13	13	4	Abril	2	2025	Domingo
5947	2025-04-14	14	4	Abril	2	2025	Segunda-feira
5948	2025-04-15	15	4	Abril	2	2025	Ter├ºa-feira
5949	2025-04-16	16	4	Abril	2	2025	Quarta-feira
5950	2025-04-17	17	4	Abril	2	2025	Quinta-feira
5951	2025-04-18	18	4	Abril	2	2025	Sexta-feira
5952	2025-04-19	19	4	Abril	2	2025	S├íbado
5953	2025-04-20	20	4	Abril	2	2025	Domingo
5954	2025-04-21	21	4	Abril	2	2025	Segunda-feira
5955	2025-04-22	22	4	Abril	2	2025	Ter├ºa-feira
5956	2025-04-23	23	4	Abril	2	2025	Quarta-feira
5957	2025-04-24	24	4	Abril	2	2025	Quinta-feira
5958	2025-04-25	25	4	Abril	2	2025	Sexta-feira
5959	2025-04-26	26	4	Abril	2	2025	S├íbado
5960	2025-04-27	27	4	Abril	2	2025	Domingo
5961	2025-04-28	28	4	Abril	2	2025	Segunda-feira
5962	2025-04-29	29	4	Abril	2	2025	Ter├ºa-feira
5963	2025-04-30	30	4	Abril	2	2025	Quarta-feira
5964	2025-05-01	1	5	Maio	2	2025	Quinta-feira
5965	2025-05-02	2	5	Maio	2	2025	Sexta-feira
5966	2025-05-03	3	5	Maio	2	2025	S├íbado
5967	2025-05-04	4	5	Maio	2	2025	Domingo
5968	2025-05-05	5	5	Maio	2	2025	Segunda-feira
5969	2025-05-06	6	5	Maio	2	2025	Ter├ºa-feira
5970	2025-05-07	7	5	Maio	2	2025	Quarta-feira
5971	2025-05-08	8	5	Maio	2	2025	Quinta-feira
5972	2025-05-09	9	5	Maio	2	2025	Sexta-feira
5973	2025-05-10	10	5	Maio	2	2025	S├íbado
5974	2025-05-11	11	5	Maio	2	2025	Domingo
5975	2025-05-12	12	5	Maio	2	2025	Segunda-feira
5976	2025-05-13	13	5	Maio	2	2025	Ter├ºa-feira
5977	2025-05-14	14	5	Maio	2	2025	Quarta-feira
5978	2025-05-15	15	5	Maio	2	2025	Quinta-feira
5979	2025-05-16	16	5	Maio	2	2025	Sexta-feira
5980	2025-05-17	17	5	Maio	2	2025	S├íbado
5981	2025-05-18	18	5	Maio	2	2025	Domingo
5982	2025-05-19	19	5	Maio	2	2025	Segunda-feira
5983	2025-05-20	20	5	Maio	2	2025	Ter├ºa-feira
5984	2025-05-21	21	5	Maio	2	2025	Quarta-feira
5985	2025-05-22	22	5	Maio	2	2025	Quinta-feira
5986	2025-05-23	23	5	Maio	2	2025	Sexta-feira
5987	2025-05-24	24	5	Maio	2	2025	S├íbado
5988	2025-05-25	25	5	Maio	2	2025	Domingo
5989	2025-05-26	26	5	Maio	2	2025	Segunda-feira
5990	2025-05-27	27	5	Maio	2	2025	Ter├ºa-feira
5991	2025-05-28	28	5	Maio	2	2025	Quarta-feira
5992	2025-05-29	29	5	Maio	2	2025	Quinta-feira
5993	2025-05-30	30	5	Maio	2	2025	Sexta-feira
5994	2025-05-31	31	5	Maio	2	2025	S├íbado
5995	2025-06-01	1	6	Junho	2	2025	Domingo
5996	2025-06-02	2	6	Junho	2	2025	Segunda-feira
5997	2025-06-03	3	6	Junho	2	2025	Ter├ºa-feira
5998	2025-06-04	4	6	Junho	2	2025	Quarta-feira
5999	2025-06-05	5	6	Junho	2	2025	Quinta-feira
6000	2025-06-06	6	6	Junho	2	2025	Sexta-feira
6001	2025-06-07	7	6	Junho	2	2025	S├íbado
6002	2025-06-08	8	6	Junho	2	2025	Domingo
6003	2025-06-09	9	6	Junho	2	2025	Segunda-feira
6004	2025-06-10	10	6	Junho	2	2025	Ter├ºa-feira
6005	2025-06-11	11	6	Junho	2	2025	Quarta-feira
6006	2025-06-12	12	6	Junho	2	2025	Quinta-feira
6007	2025-06-13	13	6	Junho	2	2025	Sexta-feira
6008	2025-06-14	14	6	Junho	2	2025	S├íbado
6009	2025-06-15	15	6	Junho	2	2025	Domingo
6010	2025-06-16	16	6	Junho	2	2025	Segunda-feira
6011	2025-06-17	17	6	Junho	2	2025	Ter├ºa-feira
6012	2025-06-18	18	6	Junho	2	2025	Quarta-feira
6013	2025-06-19	19	6	Junho	2	2025	Quinta-feira
6014	2025-06-20	20	6	Junho	2	2025	Sexta-feira
6015	2025-06-21	21	6	Junho	2	2025	S├íbado
6016	2025-06-22	22	6	Junho	2	2025	Domingo
6017	2025-06-23	23	6	Junho	2	2025	Segunda-feira
6018	2025-06-24	24	6	Junho	2	2025	Ter├ºa-feira
6019	2025-06-25	25	6	Junho	2	2025	Quarta-feira
6020	2025-06-26	26	6	Junho	2	2025	Quinta-feira
6021	2025-06-27	27	6	Junho	2	2025	Sexta-feira
6022	2025-06-28	28	6	Junho	2	2025	S├íbado
6023	2025-06-29	29	6	Junho	2	2025	Domingo
6024	2025-06-30	30	6	Junho	2	2025	Segunda-feira
6025	2025-07-01	1	7	Julho	3	2025	Ter├ºa-feira
6026	2025-07-02	2	7	Julho	3	2025	Quarta-feira
6027	2025-07-03	3	7	Julho	3	2025	Quinta-feira
6028	2025-07-04	4	7	Julho	3	2025	Sexta-feira
6029	2025-07-05	5	7	Julho	3	2025	S├íbado
6030	2025-07-06	6	7	Julho	3	2025	Domingo
6031	2025-07-07	7	7	Julho	3	2025	Segunda-feira
6032	2025-07-08	8	7	Julho	3	2025	Ter├ºa-feira
6033	2025-07-09	9	7	Julho	3	2025	Quarta-feira
6034	2025-07-10	10	7	Julho	3	2025	Quinta-feira
6035	2025-07-11	11	7	Julho	3	2025	Sexta-feira
6036	2025-07-12	12	7	Julho	3	2025	S├íbado
6037	2025-07-13	13	7	Julho	3	2025	Domingo
6038	2025-07-14	14	7	Julho	3	2025	Segunda-feira
6039	2025-07-15	15	7	Julho	3	2025	Ter├ºa-feira
6040	2025-07-16	16	7	Julho	3	2025	Quarta-feira
6041	2025-07-17	17	7	Julho	3	2025	Quinta-feira
6042	2025-07-18	18	7	Julho	3	2025	Sexta-feira
6043	2025-07-19	19	7	Julho	3	2025	S├íbado
6044	2025-07-20	20	7	Julho	3	2025	Domingo
6045	2025-07-21	21	7	Julho	3	2025	Segunda-feira
6046	2025-07-22	22	7	Julho	3	2025	Ter├ºa-feira
6047	2025-07-23	23	7	Julho	3	2025	Quarta-feira
6048	2025-07-24	24	7	Julho	3	2025	Quinta-feira
6049	2025-07-25	25	7	Julho	3	2025	Sexta-feira
6050	2025-07-26	26	7	Julho	3	2025	S├íbado
6051	2025-07-27	27	7	Julho	3	2025	Domingo
6052	2025-07-28	28	7	Julho	3	2025	Segunda-feira
6053	2025-07-29	29	7	Julho	3	2025	Ter├ºa-feira
6054	2025-07-30	30	7	Julho	3	2025	Quarta-feira
6055	2025-07-31	31	7	Julho	3	2025	Quinta-feira
6056	2025-08-01	1	8	Agosto	3	2025	Sexta-feira
6057	2025-08-02	2	8	Agosto	3	2025	S├íbado
6058	2025-08-03	3	8	Agosto	3	2025	Domingo
6059	2025-08-04	4	8	Agosto	3	2025	Segunda-feira
6060	2025-08-05	5	8	Agosto	3	2025	Ter├ºa-feira
6061	2025-08-06	6	8	Agosto	3	2025	Quarta-feira
6062	2025-08-07	7	8	Agosto	3	2025	Quinta-feira
6063	2025-08-08	8	8	Agosto	3	2025	Sexta-feira
6064	2025-08-09	9	8	Agosto	3	2025	S├íbado
6065	2025-08-10	10	8	Agosto	3	2025	Domingo
6066	2025-08-11	11	8	Agosto	3	2025	Segunda-feira
6067	2025-08-12	12	8	Agosto	3	2025	Ter├ºa-feira
6068	2025-08-13	13	8	Agosto	3	2025	Quarta-feira
6069	2025-08-14	14	8	Agosto	3	2025	Quinta-feira
6070	2025-08-15	15	8	Agosto	3	2025	Sexta-feira
6071	2025-08-16	16	8	Agosto	3	2025	S├íbado
6072	2025-08-17	17	8	Agosto	3	2025	Domingo
6073	2025-08-18	18	8	Agosto	3	2025	Segunda-feira
6074	2025-08-19	19	8	Agosto	3	2025	Ter├ºa-feira
6075	2025-08-20	20	8	Agosto	3	2025	Quarta-feira
6076	2025-08-21	21	8	Agosto	3	2025	Quinta-feira
6077	2025-08-22	22	8	Agosto	3	2025	Sexta-feira
6078	2025-08-23	23	8	Agosto	3	2025	S├íbado
6079	2025-08-24	24	8	Agosto	3	2025	Domingo
6080	2025-08-25	25	8	Agosto	3	2025	Segunda-feira
6081	2025-08-26	26	8	Agosto	3	2025	Ter├ºa-feira
6082	2025-08-27	27	8	Agosto	3	2025	Quarta-feira
6083	2025-08-28	28	8	Agosto	3	2025	Quinta-feira
6084	2025-08-29	29	8	Agosto	3	2025	Sexta-feira
6085	2025-08-30	30	8	Agosto	3	2025	S├íbado
6086	2025-08-31	31	8	Agosto	3	2025	Domingo
6087	2025-09-01	1	9	Setembro	3	2025	Segunda-feira
6088	2025-09-02	2	9	Setembro	3	2025	Ter├ºa-feira
6089	2025-09-03	3	9	Setembro	3	2025	Quarta-feira
6090	2025-09-04	4	9	Setembro	3	2025	Quinta-feira
6091	2025-09-05	5	9	Setembro	3	2025	Sexta-feira
6092	2025-09-06	6	9	Setembro	3	2025	S├íbado
6093	2025-09-07	7	9	Setembro	3	2025	Domingo
6094	2025-09-08	8	9	Setembro	3	2025	Segunda-feira
6095	2025-09-09	9	9	Setembro	3	2025	Ter├ºa-feira
6096	2025-09-10	10	9	Setembro	3	2025	Quarta-feira
6097	2025-09-11	11	9	Setembro	3	2025	Quinta-feira
6098	2025-09-12	12	9	Setembro	3	2025	Sexta-feira
6099	2025-09-13	13	9	Setembro	3	2025	S├íbado
6100	2025-09-14	14	9	Setembro	3	2025	Domingo
6101	2025-09-15	15	9	Setembro	3	2025	Segunda-feira
6102	2025-09-16	16	9	Setembro	3	2025	Ter├ºa-feira
6103	2025-09-17	17	9	Setembro	3	2025	Quarta-feira
6104	2025-09-18	18	9	Setembro	3	2025	Quinta-feira
6105	2025-09-19	19	9	Setembro	3	2025	Sexta-feira
6106	2025-09-20	20	9	Setembro	3	2025	S├íbado
6107	2025-09-21	21	9	Setembro	3	2025	Domingo
6108	2025-09-22	22	9	Setembro	3	2025	Segunda-feira
6109	2025-09-23	23	9	Setembro	3	2025	Ter├ºa-feira
6110	2025-09-24	24	9	Setembro	3	2025	Quarta-feira
6111	2025-09-25	25	9	Setembro	3	2025	Quinta-feira
6112	2025-09-26	26	9	Setembro	3	2025	Sexta-feira
6113	2025-09-27	27	9	Setembro	3	2025	S├íbado
6114	2025-09-28	28	9	Setembro	3	2025	Domingo
6115	2025-09-29	29	9	Setembro	3	2025	Segunda-feira
6116	2025-09-30	30	9	Setembro	3	2025	Ter├ºa-feira
6117	2025-10-01	1	10	Outubro	4	2025	Quarta-feira
6118	2025-10-02	2	10	Outubro	4	2025	Quinta-feira
6119	2025-10-03	3	10	Outubro	4	2025	Sexta-feira
6120	2025-10-04	4	10	Outubro	4	2025	S├íbado
6121	2025-10-05	5	10	Outubro	4	2025	Domingo
6122	2025-10-06	6	10	Outubro	4	2025	Segunda-feira
6123	2025-10-07	7	10	Outubro	4	2025	Ter├ºa-feira
6124	2025-10-08	8	10	Outubro	4	2025	Quarta-feira
6125	2025-10-09	9	10	Outubro	4	2025	Quinta-feira
6126	2025-10-10	10	10	Outubro	4	2025	Sexta-feira
6127	2025-10-11	11	10	Outubro	4	2025	S├íbado
6128	2025-10-12	12	10	Outubro	4	2025	Domingo
6129	2025-10-13	13	10	Outubro	4	2025	Segunda-feira
6130	2025-10-14	14	10	Outubro	4	2025	Ter├ºa-feira
6131	2025-10-15	15	10	Outubro	4	2025	Quarta-feira
6132	2025-10-16	16	10	Outubro	4	2025	Quinta-feira
6133	2025-10-17	17	10	Outubro	4	2025	Sexta-feira
6134	2025-10-18	18	10	Outubro	4	2025	S├íbado
6135	2025-10-19	19	10	Outubro	4	2025	Domingo
6136	2025-10-20	20	10	Outubro	4	2025	Segunda-feira
6137	2025-10-21	21	10	Outubro	4	2025	Ter├ºa-feira
6138	2025-10-22	22	10	Outubro	4	2025	Quarta-feira
6139	2025-10-23	23	10	Outubro	4	2025	Quinta-feira
6140	2025-10-24	24	10	Outubro	4	2025	Sexta-feira
6141	2025-10-25	25	10	Outubro	4	2025	S├íbado
6142	2025-10-26	26	10	Outubro	4	2025	Domingo
6143	2025-10-27	27	10	Outubro	4	2025	Segunda-feira
6144	2025-10-28	28	10	Outubro	4	2025	Ter├ºa-feira
6145	2025-10-29	29	10	Outubro	4	2025	Quarta-feira
6146	2025-10-30	30	10	Outubro	4	2025	Quinta-feira
6147	2025-10-31	31	10	Outubro	4	2025	Sexta-feira
6148	2025-11-01	1	11	Novembro	4	2025	S├íbado
6149	2025-11-02	2	11	Novembro	4	2025	Domingo
6150	2025-11-03	3	11	Novembro	4	2025	Segunda-feira
6151	2025-11-04	4	11	Novembro	4	2025	Ter├ºa-feira
6152	2025-11-05	5	11	Novembro	4	2025	Quarta-feira
6153	2025-11-06	6	11	Novembro	4	2025	Quinta-feira
6154	2025-11-07	7	11	Novembro	4	2025	Sexta-feira
6155	2025-11-08	8	11	Novembro	4	2025	S├íbado
6156	2025-11-09	9	11	Novembro	4	2025	Domingo
6157	2025-11-10	10	11	Novembro	4	2025	Segunda-feira
6373	2026-06-14	14	6	Junho	2	2026	Domingo
6158	2025-11-11	11	11	Novembro	4	2025	Ter├ºa-feira
6159	2025-11-12	12	11	Novembro	4	2025	Quarta-feira
6160	2025-11-13	13	11	Novembro	4	2025	Quinta-feira
6161	2025-11-14	14	11	Novembro	4	2025	Sexta-feira
6162	2025-11-15	15	11	Novembro	4	2025	S├íbado
6163	2025-11-16	16	11	Novembro	4	2025	Domingo
6164	2025-11-17	17	11	Novembro	4	2025	Segunda-feira
6165	2025-11-18	18	11	Novembro	4	2025	Ter├ºa-feira
6166	2025-11-19	19	11	Novembro	4	2025	Quarta-feira
6167	2025-11-20	20	11	Novembro	4	2025	Quinta-feira
6168	2025-11-21	21	11	Novembro	4	2025	Sexta-feira
6169	2025-11-22	22	11	Novembro	4	2025	S├íbado
6170	2025-11-23	23	11	Novembro	4	2025	Domingo
6171	2025-11-24	24	11	Novembro	4	2025	Segunda-feira
6172	2025-11-25	25	11	Novembro	4	2025	Ter├ºa-feira
6173	2025-11-26	26	11	Novembro	4	2025	Quarta-feira
6174	2025-11-27	27	11	Novembro	4	2025	Quinta-feira
6175	2025-11-28	28	11	Novembro	4	2025	Sexta-feira
6176	2025-11-29	29	11	Novembro	4	2025	S├íbado
6177	2025-11-30	30	11	Novembro	4	2025	Domingo
6178	2025-12-01	1	12	Dezembro	4	2025	Segunda-feira
6179	2025-12-02	2	12	Dezembro	4	2025	Ter├ºa-feira
6180	2025-12-03	3	12	Dezembro	4	2025	Quarta-feira
6181	2025-12-04	4	12	Dezembro	4	2025	Quinta-feira
6182	2025-12-05	5	12	Dezembro	4	2025	Sexta-feira
6183	2025-12-06	6	12	Dezembro	4	2025	S├íbado
6184	2025-12-07	7	12	Dezembro	4	2025	Domingo
6185	2025-12-08	8	12	Dezembro	4	2025	Segunda-feira
6186	2025-12-09	9	12	Dezembro	4	2025	Ter├ºa-feira
6187	2025-12-10	10	12	Dezembro	4	2025	Quarta-feira
6188	2025-12-11	11	12	Dezembro	4	2025	Quinta-feira
6189	2025-12-12	12	12	Dezembro	4	2025	Sexta-feira
6190	2025-12-13	13	12	Dezembro	4	2025	S├íbado
6191	2025-12-14	14	12	Dezembro	4	2025	Domingo
6192	2025-12-15	15	12	Dezembro	4	2025	Segunda-feira
6193	2025-12-16	16	12	Dezembro	4	2025	Ter├ºa-feira
6194	2025-12-17	17	12	Dezembro	4	2025	Quarta-feira
6195	2025-12-18	18	12	Dezembro	4	2025	Quinta-feira
6196	2025-12-19	19	12	Dezembro	4	2025	Sexta-feira
6197	2025-12-20	20	12	Dezembro	4	2025	S├íbado
6198	2025-12-21	21	12	Dezembro	4	2025	Domingo
6199	2025-12-22	22	12	Dezembro	4	2025	Segunda-feira
6200	2025-12-23	23	12	Dezembro	4	2025	Ter├ºa-feira
6201	2025-12-24	24	12	Dezembro	4	2025	Quarta-feira
6202	2025-12-25	25	12	Dezembro	4	2025	Quinta-feira
6203	2025-12-26	26	12	Dezembro	4	2025	Sexta-feira
6204	2025-12-27	27	12	Dezembro	4	2025	S├íbado
6205	2025-12-28	28	12	Dezembro	4	2025	Domingo
6206	2025-12-29	29	12	Dezembro	4	2025	Segunda-feira
6207	2025-12-30	30	12	Dezembro	4	2025	Ter├ºa-feira
6208	2025-12-31	31	12	Dezembro	4	2025	Quarta-feira
6209	2026-01-01	1	1	Janeiro	1	2026	Quinta-feira
6210	2026-01-02	2	1	Janeiro	1	2026	Sexta-feira
6211	2026-01-03	3	1	Janeiro	1	2026	S├íbado
6212	2026-01-04	4	1	Janeiro	1	2026	Domingo
6213	2026-01-05	5	1	Janeiro	1	2026	Segunda-feira
6214	2026-01-06	6	1	Janeiro	1	2026	Ter├ºa-feira
6215	2026-01-07	7	1	Janeiro	1	2026	Quarta-feira
6216	2026-01-08	8	1	Janeiro	1	2026	Quinta-feira
6217	2026-01-09	9	1	Janeiro	1	2026	Sexta-feira
6218	2026-01-10	10	1	Janeiro	1	2026	S├íbado
6219	2026-01-11	11	1	Janeiro	1	2026	Domingo
6220	2026-01-12	12	1	Janeiro	1	2026	Segunda-feira
6221	2026-01-13	13	1	Janeiro	1	2026	Ter├ºa-feira
6222	2026-01-14	14	1	Janeiro	1	2026	Quarta-feira
6223	2026-01-15	15	1	Janeiro	1	2026	Quinta-feira
6224	2026-01-16	16	1	Janeiro	1	2026	Sexta-feira
6225	2026-01-17	17	1	Janeiro	1	2026	S├íbado
6226	2026-01-18	18	1	Janeiro	1	2026	Domingo
6227	2026-01-19	19	1	Janeiro	1	2026	Segunda-feira
6228	2026-01-20	20	1	Janeiro	1	2026	Ter├ºa-feira
6229	2026-01-21	21	1	Janeiro	1	2026	Quarta-feira
6230	2026-01-22	22	1	Janeiro	1	2026	Quinta-feira
6231	2026-01-23	23	1	Janeiro	1	2026	Sexta-feira
6232	2026-01-24	24	1	Janeiro	1	2026	S├íbado
6233	2026-01-25	25	1	Janeiro	1	2026	Domingo
6234	2026-01-26	26	1	Janeiro	1	2026	Segunda-feira
6235	2026-01-27	27	1	Janeiro	1	2026	Ter├ºa-feira
6236	2026-01-28	28	1	Janeiro	1	2026	Quarta-feira
6237	2026-01-29	29	1	Janeiro	1	2026	Quinta-feira
6238	2026-01-30	30	1	Janeiro	1	2026	Sexta-feira
6239	2026-01-31	31	1	Janeiro	1	2026	S├íbado
6240	2026-02-01	1	2	Fevereiro	1	2026	Domingo
6241	2026-02-02	2	2	Fevereiro	1	2026	Segunda-feira
6242	2026-02-03	3	2	Fevereiro	1	2026	Ter├ºa-feira
6243	2026-02-04	4	2	Fevereiro	1	2026	Quarta-feira
6244	2026-02-05	5	2	Fevereiro	1	2026	Quinta-feira
6245	2026-02-06	6	2	Fevereiro	1	2026	Sexta-feira
6246	2026-02-07	7	2	Fevereiro	1	2026	S├íbado
6247	2026-02-08	8	2	Fevereiro	1	2026	Domingo
6248	2026-02-09	9	2	Fevereiro	1	2026	Segunda-feira
6249	2026-02-10	10	2	Fevereiro	1	2026	Ter├ºa-feira
6250	2026-02-11	11	2	Fevereiro	1	2026	Quarta-feira
6251	2026-02-12	12	2	Fevereiro	1	2026	Quinta-feira
6252	2026-02-13	13	2	Fevereiro	1	2026	Sexta-feira
6253	2026-02-14	14	2	Fevereiro	1	2026	S├íbado
6254	2026-02-15	15	2	Fevereiro	1	2026	Domingo
6255	2026-02-16	16	2	Fevereiro	1	2026	Segunda-feira
6256	2026-02-17	17	2	Fevereiro	1	2026	Ter├ºa-feira
6257	2026-02-18	18	2	Fevereiro	1	2026	Quarta-feira
6258	2026-02-19	19	2	Fevereiro	1	2026	Quinta-feira
6259	2026-02-20	20	2	Fevereiro	1	2026	Sexta-feira
6260	2026-02-21	21	2	Fevereiro	1	2026	S├íbado
6261	2026-02-22	22	2	Fevereiro	1	2026	Domingo
6262	2026-02-23	23	2	Fevereiro	1	2026	Segunda-feira
6263	2026-02-24	24	2	Fevereiro	1	2026	Ter├ºa-feira
6264	2026-02-25	25	2	Fevereiro	1	2026	Quarta-feira
6265	2026-02-26	26	2	Fevereiro	1	2026	Quinta-feira
6266	2026-02-27	27	2	Fevereiro	1	2026	Sexta-feira
6267	2026-02-28	28	2	Fevereiro	1	2026	S├íbado
6268	2026-03-01	1	3	Mar├ºo	1	2026	Domingo
6269	2026-03-02	2	3	Mar├ºo	1	2026	Segunda-feira
6270	2026-03-03	3	3	Mar├ºo	1	2026	Ter├ºa-feira
6271	2026-03-04	4	3	Mar├ºo	1	2026	Quarta-feira
6272	2026-03-05	5	3	Mar├ºo	1	2026	Quinta-feira
6273	2026-03-06	6	3	Mar├ºo	1	2026	Sexta-feira
6274	2026-03-07	7	3	Mar├ºo	1	2026	S├íbado
6275	2026-03-08	8	3	Mar├ºo	1	2026	Domingo
6276	2026-03-09	9	3	Mar├ºo	1	2026	Segunda-feira
6277	2026-03-10	10	3	Mar├ºo	1	2026	Ter├ºa-feira
6278	2026-03-11	11	3	Mar├ºo	1	2026	Quarta-feira
6279	2026-03-12	12	3	Mar├ºo	1	2026	Quinta-feira
6280	2026-03-13	13	3	Mar├ºo	1	2026	Sexta-feira
6281	2026-03-14	14	3	Mar├ºo	1	2026	S├íbado
6282	2026-03-15	15	3	Mar├ºo	1	2026	Domingo
6283	2026-03-16	16	3	Mar├ºo	1	2026	Segunda-feira
6284	2026-03-17	17	3	Mar├ºo	1	2026	Ter├ºa-feira
6285	2026-03-18	18	3	Mar├ºo	1	2026	Quarta-feira
6286	2026-03-19	19	3	Mar├ºo	1	2026	Quinta-feira
6287	2026-03-20	20	3	Mar├ºo	1	2026	Sexta-feira
6288	2026-03-21	21	3	Mar├ºo	1	2026	S├íbado
6289	2026-03-22	22	3	Mar├ºo	1	2026	Domingo
6290	2026-03-23	23	3	Mar├ºo	1	2026	Segunda-feira
6291	2026-03-24	24	3	Mar├ºo	1	2026	Ter├ºa-feira
6292	2026-03-25	25	3	Mar├ºo	1	2026	Quarta-feira
6293	2026-03-26	26	3	Mar├ºo	1	2026	Quinta-feira
6294	2026-03-27	27	3	Mar├ºo	1	2026	Sexta-feira
6295	2026-03-28	28	3	Mar├ºo	1	2026	S├íbado
6296	2026-03-29	29	3	Mar├ºo	1	2026	Domingo
6297	2026-03-30	30	3	Mar├ºo	1	2026	Segunda-feira
6298	2026-03-31	31	3	Mar├ºo	1	2026	Ter├ºa-feira
6299	2026-04-01	1	4	Abril	2	2026	Quarta-feira
6300	2026-04-02	2	4	Abril	2	2026	Quinta-feira
6301	2026-04-03	3	4	Abril	2	2026	Sexta-feira
6302	2026-04-04	4	4	Abril	2	2026	S├íbado
6303	2026-04-05	5	4	Abril	2	2026	Domingo
6304	2026-04-06	6	4	Abril	2	2026	Segunda-feira
6305	2026-04-07	7	4	Abril	2	2026	Ter├ºa-feira
6306	2026-04-08	8	4	Abril	2	2026	Quarta-feira
6307	2026-04-09	9	4	Abril	2	2026	Quinta-feira
6308	2026-04-10	10	4	Abril	2	2026	Sexta-feira
6309	2026-04-11	11	4	Abril	2	2026	S├íbado
6310	2026-04-12	12	4	Abril	2	2026	Domingo
6311	2026-04-13	13	4	Abril	2	2026	Segunda-feira
6312	2026-04-14	14	4	Abril	2	2026	Ter├ºa-feira
6313	2026-04-15	15	4	Abril	2	2026	Quarta-feira
6314	2026-04-16	16	4	Abril	2	2026	Quinta-feira
6315	2026-04-17	17	4	Abril	2	2026	Sexta-feira
6316	2026-04-18	18	4	Abril	2	2026	S├íbado
6317	2026-04-19	19	4	Abril	2	2026	Domingo
6318	2026-04-20	20	4	Abril	2	2026	Segunda-feira
6319	2026-04-21	21	4	Abril	2	2026	Ter├ºa-feira
6320	2026-04-22	22	4	Abril	2	2026	Quarta-feira
6321	2026-04-23	23	4	Abril	2	2026	Quinta-feira
6322	2026-04-24	24	4	Abril	2	2026	Sexta-feira
6323	2026-04-25	25	4	Abril	2	2026	S├íbado
6324	2026-04-26	26	4	Abril	2	2026	Domingo
6325	2026-04-27	27	4	Abril	2	2026	Segunda-feira
6326	2026-04-28	28	4	Abril	2	2026	Ter├ºa-feira
6327	2026-04-29	29	4	Abril	2	2026	Quarta-feira
6328	2026-04-30	30	4	Abril	2	2026	Quinta-feira
6329	2026-05-01	1	5	Maio	2	2026	Sexta-feira
6330	2026-05-02	2	5	Maio	2	2026	S├íbado
6331	2026-05-03	3	5	Maio	2	2026	Domingo
6332	2026-05-04	4	5	Maio	2	2026	Segunda-feira
6333	2026-05-05	5	5	Maio	2	2026	Ter├ºa-feira
6334	2026-05-06	6	5	Maio	2	2026	Quarta-feira
6335	2026-05-07	7	5	Maio	2	2026	Quinta-feira
6336	2026-05-08	8	5	Maio	2	2026	Sexta-feira
6337	2026-05-09	9	5	Maio	2	2026	S├íbado
6338	2026-05-10	10	5	Maio	2	2026	Domingo
6339	2026-05-11	11	5	Maio	2	2026	Segunda-feira
6340	2026-05-12	12	5	Maio	2	2026	Ter├ºa-feira
6341	2026-05-13	13	5	Maio	2	2026	Quarta-feira
6342	2026-05-14	14	5	Maio	2	2026	Quinta-feira
6343	2026-05-15	15	5	Maio	2	2026	Sexta-feira
6344	2026-05-16	16	5	Maio	2	2026	S├íbado
6345	2026-05-17	17	5	Maio	2	2026	Domingo
6346	2026-05-18	18	5	Maio	2	2026	Segunda-feira
6347	2026-05-19	19	5	Maio	2	2026	Ter├ºa-feira
6348	2026-05-20	20	5	Maio	2	2026	Quarta-feira
6349	2026-05-21	21	5	Maio	2	2026	Quinta-feira
6350	2026-05-22	22	5	Maio	2	2026	Sexta-feira
6351	2026-05-23	23	5	Maio	2	2026	S├íbado
6352	2026-05-24	24	5	Maio	2	2026	Domingo
6353	2026-05-25	25	5	Maio	2	2026	Segunda-feira
6354	2026-05-26	26	5	Maio	2	2026	Ter├ºa-feira
6355	2026-05-27	27	5	Maio	2	2026	Quarta-feira
6356	2026-05-28	28	5	Maio	2	2026	Quinta-feira
6357	2026-05-29	29	5	Maio	2	2026	Sexta-feira
6358	2026-05-30	30	5	Maio	2	2026	S├íbado
6359	2026-05-31	31	5	Maio	2	2026	Domingo
6360	2026-06-01	1	6	Junho	2	2026	Segunda-feira
6361	2026-06-02	2	6	Junho	2	2026	Ter├ºa-feira
6362	2026-06-03	3	6	Junho	2	2026	Quarta-feira
6363	2026-06-04	4	6	Junho	2	2026	Quinta-feira
6364	2026-06-05	5	6	Junho	2	2026	Sexta-feira
6365	2026-06-06	6	6	Junho	2	2026	S├íbado
6366	2026-06-07	7	6	Junho	2	2026	Domingo
6367	2026-06-08	8	6	Junho	2	2026	Segunda-feira
6368	2026-06-09	9	6	Junho	2	2026	Ter├ºa-feira
6369	2026-06-10	10	6	Junho	2	2026	Quarta-feira
6370	2026-06-11	11	6	Junho	2	2026	Quinta-feira
6371	2026-06-12	12	6	Junho	2	2026	Sexta-feira
6374	2026-06-15	15	6	Junho	2	2026	Segunda-feira
6375	2026-06-16	16	6	Junho	2	2026	Ter├ºa-feira
6376	2026-06-17	17	6	Junho	2	2026	Quarta-feira
6377	2026-06-18	18	6	Junho	2	2026	Quinta-feira
6378	2026-06-19	19	6	Junho	2	2026	Sexta-feira
6379	2026-06-20	20	6	Junho	2	2026	S├íbado
6380	2026-06-21	21	6	Junho	2	2026	Domingo
6381	2026-06-22	22	6	Junho	2	2026	Segunda-feira
6382	2026-06-23	23	6	Junho	2	2026	Ter├ºa-feira
6383	2026-06-24	24	6	Junho	2	2026	Quarta-feira
6384	2026-06-25	25	6	Junho	2	2026	Quinta-feira
6385	2026-06-26	26	6	Junho	2	2026	Sexta-feira
6386	2026-06-27	27	6	Junho	2	2026	S├íbado
6387	2026-06-28	28	6	Junho	2	2026	Domingo
6388	2026-06-29	29	6	Junho	2	2026	Segunda-feira
6389	2026-06-30	30	6	Junho	2	2026	Ter├ºa-feira
6390	2026-07-01	1	7	Julho	3	2026	Quarta-feira
6391	2026-07-02	2	7	Julho	3	2026	Quinta-feira
6392	2026-07-03	3	7	Julho	3	2026	Sexta-feira
6393	2026-07-04	4	7	Julho	3	2026	S├íbado
6394	2026-07-05	5	7	Julho	3	2026	Domingo
6395	2026-07-06	6	7	Julho	3	2026	Segunda-feira
6396	2026-07-07	7	7	Julho	3	2026	Ter├ºa-feira
6397	2026-07-08	8	7	Julho	3	2026	Quarta-feira
6398	2026-07-09	9	7	Julho	3	2026	Quinta-feira
6399	2026-07-10	10	7	Julho	3	2026	Sexta-feira
6400	2026-07-11	11	7	Julho	3	2026	S├íbado
6401	2026-07-12	12	7	Julho	3	2026	Domingo
6402	2026-07-13	13	7	Julho	3	2026	Segunda-feira
6403	2026-07-14	14	7	Julho	3	2026	Ter├ºa-feira
6404	2026-07-15	15	7	Julho	3	2026	Quarta-feira
6405	2026-07-16	16	7	Julho	3	2026	Quinta-feira
6406	2026-07-17	17	7	Julho	3	2026	Sexta-feira
6407	2026-07-18	18	7	Julho	3	2026	S├íbado
6408	2026-07-19	19	7	Julho	3	2026	Domingo
6409	2026-07-20	20	7	Julho	3	2026	Segunda-feira
6410	2026-07-21	21	7	Julho	3	2026	Ter├ºa-feira
6411	2026-07-22	22	7	Julho	3	2026	Quarta-feira
6412	2026-07-23	23	7	Julho	3	2026	Quinta-feira
6413	2026-07-24	24	7	Julho	3	2026	Sexta-feira
6414	2026-07-25	25	7	Julho	3	2026	S├íbado
6415	2026-07-26	26	7	Julho	3	2026	Domingo
6416	2026-07-27	27	7	Julho	3	2026	Segunda-feira
6417	2026-07-28	28	7	Julho	3	2026	Ter├ºa-feira
6418	2026-07-29	29	7	Julho	3	2026	Quarta-feira
6419	2026-07-30	30	7	Julho	3	2026	Quinta-feira
6420	2026-07-31	31	7	Julho	3	2026	Sexta-feira
6421	2026-08-01	1	8	Agosto	3	2026	S├íbado
6422	2026-08-02	2	8	Agosto	3	2026	Domingo
6423	2026-08-03	3	8	Agosto	3	2026	Segunda-feira
6424	2026-08-04	4	8	Agosto	3	2026	Ter├ºa-feira
6425	2026-08-05	5	8	Agosto	3	2026	Quarta-feira
6426	2026-08-06	6	8	Agosto	3	2026	Quinta-feira
6427	2026-08-07	7	8	Agosto	3	2026	Sexta-feira
6428	2026-08-08	8	8	Agosto	3	2026	S├íbado
6429	2026-08-09	9	8	Agosto	3	2026	Domingo
6430	2026-08-10	10	8	Agosto	3	2026	Segunda-feira
6431	2026-08-11	11	8	Agosto	3	2026	Ter├ºa-feira
6432	2026-08-12	12	8	Agosto	3	2026	Quarta-feira
6433	2026-08-13	13	8	Agosto	3	2026	Quinta-feira
6434	2026-08-14	14	8	Agosto	3	2026	Sexta-feira
6435	2026-08-15	15	8	Agosto	3	2026	S├íbado
6436	2026-08-16	16	8	Agosto	3	2026	Domingo
6437	2026-08-17	17	8	Agosto	3	2026	Segunda-feira
6438	2026-08-18	18	8	Agosto	3	2026	Ter├ºa-feira
6439	2026-08-19	19	8	Agosto	3	2026	Quarta-feira
6440	2026-08-20	20	8	Agosto	3	2026	Quinta-feira
6441	2026-08-21	21	8	Agosto	3	2026	Sexta-feira
6442	2026-08-22	22	8	Agosto	3	2026	S├íbado
6443	2026-08-23	23	8	Agosto	3	2026	Domingo
6444	2026-08-24	24	8	Agosto	3	2026	Segunda-feira
6445	2026-08-25	25	8	Agosto	3	2026	Ter├ºa-feira
6446	2026-08-26	26	8	Agosto	3	2026	Quarta-feira
6447	2026-08-27	27	8	Agosto	3	2026	Quinta-feira
6448	2026-08-28	28	8	Agosto	3	2026	Sexta-feira
6449	2026-08-29	29	8	Agosto	3	2026	S├íbado
6450	2026-08-30	30	8	Agosto	3	2026	Domingo
6451	2026-08-31	31	8	Agosto	3	2026	Segunda-feira
6452	2026-09-01	1	9	Setembro	3	2026	Ter├ºa-feira
6453	2026-09-02	2	9	Setembro	3	2026	Quarta-feira
6454	2026-09-03	3	9	Setembro	3	2026	Quinta-feira
6455	2026-09-04	4	9	Setembro	3	2026	Sexta-feira
6456	2026-09-05	5	9	Setembro	3	2026	S├íbado
6457	2026-09-06	6	9	Setembro	3	2026	Domingo
6458	2026-09-07	7	9	Setembro	3	2026	Segunda-feira
6459	2026-09-08	8	9	Setembro	3	2026	Ter├ºa-feira
6460	2026-09-09	9	9	Setembro	3	2026	Quarta-feira
6461	2026-09-10	10	9	Setembro	3	2026	Quinta-feira
6462	2026-09-11	11	9	Setembro	3	2026	Sexta-feira
6463	2026-09-12	12	9	Setembro	3	2026	S├íbado
6464	2026-09-13	13	9	Setembro	3	2026	Domingo
6465	2026-09-14	14	9	Setembro	3	2026	Segunda-feira
6466	2026-09-15	15	9	Setembro	3	2026	Ter├ºa-feira
6467	2026-09-16	16	9	Setembro	3	2026	Quarta-feira
6468	2026-09-17	17	9	Setembro	3	2026	Quinta-feira
6469	2026-09-18	18	9	Setembro	3	2026	Sexta-feira
6470	2026-09-19	19	9	Setembro	3	2026	S├íbado
6471	2026-09-20	20	9	Setembro	3	2026	Domingo
6472	2026-09-21	21	9	Setembro	3	2026	Segunda-feira
6473	2026-09-22	22	9	Setembro	3	2026	Ter├ºa-feira
6474	2026-09-23	23	9	Setembro	3	2026	Quarta-feira
6475	2026-09-24	24	9	Setembro	3	2026	Quinta-feira
6476	2026-09-25	25	9	Setembro	3	2026	Sexta-feira
6477	2026-09-26	26	9	Setembro	3	2026	S├íbado
6478	2026-09-27	27	9	Setembro	3	2026	Domingo
6479	2026-09-28	28	9	Setembro	3	2026	Segunda-feira
6480	2026-09-29	29	9	Setembro	3	2026	Ter├ºa-feira
6481	2026-09-30	30	9	Setembro	3	2026	Quarta-feira
6482	2026-10-01	1	10	Outubro	4	2026	Quinta-feira
6483	2026-10-02	2	10	Outubro	4	2026	Sexta-feira
6484	2026-10-03	3	10	Outubro	4	2026	S├íbado
6485	2026-10-04	4	10	Outubro	4	2026	Domingo
6486	2026-10-05	5	10	Outubro	4	2026	Segunda-feira
6487	2026-10-06	6	10	Outubro	4	2026	Ter├ºa-feira
6488	2026-10-07	7	10	Outubro	4	2026	Quarta-feira
6489	2026-10-08	8	10	Outubro	4	2026	Quinta-feira
6490	2026-10-09	9	10	Outubro	4	2026	Sexta-feira
6491	2026-10-10	10	10	Outubro	4	2026	S├íbado
6492	2026-10-11	11	10	Outubro	4	2026	Domingo
6493	2026-10-12	12	10	Outubro	4	2026	Segunda-feira
6494	2026-10-13	13	10	Outubro	4	2026	Ter├ºa-feira
6495	2026-10-14	14	10	Outubro	4	2026	Quarta-feira
6496	2026-10-15	15	10	Outubro	4	2026	Quinta-feira
6497	2026-10-16	16	10	Outubro	4	2026	Sexta-feira
6498	2026-10-17	17	10	Outubro	4	2026	S├íbado
6499	2026-10-18	18	10	Outubro	4	2026	Domingo
6500	2026-10-19	19	10	Outubro	4	2026	Segunda-feira
6501	2026-10-20	20	10	Outubro	4	2026	Ter├ºa-feira
6502	2026-10-21	21	10	Outubro	4	2026	Quarta-feira
6503	2026-10-22	22	10	Outubro	4	2026	Quinta-feira
6504	2026-10-23	23	10	Outubro	4	2026	Sexta-feira
6505	2026-10-24	24	10	Outubro	4	2026	S├íbado
6506	2026-10-25	25	10	Outubro	4	2026	Domingo
6507	2026-10-26	26	10	Outubro	4	2026	Segunda-feira
6508	2026-10-27	27	10	Outubro	4	2026	Ter├ºa-feira
6509	2026-10-28	28	10	Outubro	4	2026	Quarta-feira
6510	2026-10-29	29	10	Outubro	4	2026	Quinta-feira
6511	2026-10-30	30	10	Outubro	4	2026	Sexta-feira
6512	2026-10-31	31	10	Outubro	4	2026	S├íbado
6513	2026-11-01	1	11	Novembro	4	2026	Domingo
6514	2026-11-02	2	11	Novembro	4	2026	Segunda-feira
6515	2026-11-03	3	11	Novembro	4	2026	Ter├ºa-feira
6516	2026-11-04	4	11	Novembro	4	2026	Quarta-feira
6517	2026-11-05	5	11	Novembro	4	2026	Quinta-feira
6518	2026-11-06	6	11	Novembro	4	2026	Sexta-feira
6519	2026-11-07	7	11	Novembro	4	2026	S├íbado
6520	2026-11-08	8	11	Novembro	4	2026	Domingo
6521	2026-11-09	9	11	Novembro	4	2026	Segunda-feira
6522	2026-11-10	10	11	Novembro	4	2026	Ter├ºa-feira
6523	2026-11-11	11	11	Novembro	4	2026	Quarta-feira
6524	2026-11-12	12	11	Novembro	4	2026	Quinta-feira
6525	2026-11-13	13	11	Novembro	4	2026	Sexta-feira
6526	2026-11-14	14	11	Novembro	4	2026	S├íbado
6527	2026-11-15	15	11	Novembro	4	2026	Domingo
6528	2026-11-16	16	11	Novembro	4	2026	Segunda-feira
6529	2026-11-17	17	11	Novembro	4	2026	Ter├ºa-feira
6530	2026-11-18	18	11	Novembro	4	2026	Quarta-feira
6531	2026-11-19	19	11	Novembro	4	2026	Quinta-feira
6532	2026-11-20	20	11	Novembro	4	2026	Sexta-feira
6533	2026-11-21	21	11	Novembro	4	2026	S├íbado
6534	2026-11-22	22	11	Novembro	4	2026	Domingo
6535	2026-11-23	23	11	Novembro	4	2026	Segunda-feira
6536	2026-11-24	24	11	Novembro	4	2026	Ter├ºa-feira
6537	2026-11-25	25	11	Novembro	4	2026	Quarta-feira
6538	2026-11-26	26	11	Novembro	4	2026	Quinta-feira
6539	2026-11-27	27	11	Novembro	4	2026	Sexta-feira
6540	2026-11-28	28	11	Novembro	4	2026	S├íbado
6541	2026-11-29	29	11	Novembro	4	2026	Domingo
6542	2026-11-30	30	11	Novembro	4	2026	Segunda-feira
6543	2026-12-01	1	12	Dezembro	4	2026	Ter├ºa-feira
6544	2026-12-02	2	12	Dezembro	4	2026	Quarta-feira
6545	2026-12-03	3	12	Dezembro	4	2026	Quinta-feira
6546	2026-12-04	4	12	Dezembro	4	2026	Sexta-feira
6547	2026-12-05	5	12	Dezembro	4	2026	S├íbado
6548	2026-12-06	6	12	Dezembro	4	2026	Domingo
6549	2026-12-07	7	12	Dezembro	4	2026	Segunda-feira
6550	2026-12-08	8	12	Dezembro	4	2026	Ter├ºa-feira
6551	2026-12-09	9	12	Dezembro	4	2026	Quarta-feira
6552	2026-12-10	10	12	Dezembro	4	2026	Quinta-feira
6553	2026-12-11	11	12	Dezembro	4	2026	Sexta-feira
6554	2026-12-12	12	12	Dezembro	4	2026	S├íbado
6555	2026-12-13	13	12	Dezembro	4	2026	Domingo
6556	2026-12-14	14	12	Dezembro	4	2026	Segunda-feira
6557	2026-12-15	15	12	Dezembro	4	2026	Ter├ºa-feira
6558	2026-12-16	16	12	Dezembro	4	2026	Quarta-feira
6559	2026-12-17	17	12	Dezembro	4	2026	Quinta-feira
6560	2026-12-18	18	12	Dezembro	4	2026	Sexta-feira
6561	2026-12-19	19	12	Dezembro	4	2026	S├íbado
6562	2026-12-20	20	12	Dezembro	4	2026	Domingo
6563	2026-12-21	21	12	Dezembro	4	2026	Segunda-feira
6564	2026-12-22	22	12	Dezembro	4	2026	Ter├ºa-feira
6565	2026-12-23	23	12	Dezembro	4	2026	Quarta-feira
6566	2026-12-24	24	12	Dezembro	4	2026	Quinta-feira
6567	2026-12-25	25	12	Dezembro	4	2026	Sexta-feira
6568	2026-12-26	26	12	Dezembro	4	2026	S├íbado
6569	2026-12-27	27	12	Dezembro	4	2026	Domingo
6570	2026-12-28	28	12	Dezembro	4	2026	Segunda-feira
6571	2026-12-29	29	12	Dezembro	4	2026	Ter├ºa-feira
6572	2026-12-30	30	12	Dezembro	4	2026	Quarta-feira
6573	2026-12-31	31	12	Dezembro	4	2026	Quinta-feira
\.


--
-- Name: dim_canal_venda_id_canal_venda_seq; Type: SEQUENCE SET; Schema: administrativo; Owner: postgres
--

SELECT pg_catalog.setval('administrativo.dim_canal_venda_id_canal_venda_seq', 6, true);


--
-- Name: dim_categoria_produto_id_categoria_seq; Type: SEQUENCE SET; Schema: administrativo; Owner: postgres
--

SELECT pg_catalog.setval('administrativo.dim_categoria_produto_id_categoria_seq', 15, true);


--
-- Name: dim_clientes_id_cliente_seq; Type: SEQUENCE SET; Schema: administrativo; Owner: postgres
--

SELECT pg_catalog.setval('administrativo.dim_clientes_id_cliente_seq', 538, true);


--
-- Name: dim_fornecedor_id_fornecedor_seq; Type: SEQUENCE SET; Schema: administrativo; Owner: postgres
--

SELECT pg_catalog.setval('administrativo.dim_fornecedor_id_fornecedor_seq', 21, true);


--
-- Name: dim_produtos_id_produto_seq; Type: SEQUENCE SET; Schema: administrativo; Owner: postgres
--

SELECT pg_catalog.setval('administrativo.dim_produtos_id_produto_seq', 217, true);


--
-- Name: dim_tipo_movimentacao_id_tipo_movimentacao_seq; Type: SEQUENCE SET; Schema: estoque; Owner: postgres
--

SELECT pg_catalog.setval('estoque.dim_tipo_movimentacao_id_tipo_movimentacao_seq', 18, true);


--
-- Name: dim_transportadora_id_transportadora_seq; Type: SEQUENCE SET; Schema: estoque; Owner: postgres
--

SELECT pg_catalog.setval('estoque.dim_transportadora_id_transportadora_seq', 15, true);


--
-- Name: fato_movimentacao_estoque_id_movimentacao_seq; Type: SEQUENCE SET; Schema: estoque; Owner: postgres
--

SELECT pg_catalog.setval('estoque.fato_movimentacao_estoque_id_movimentacao_seq', 500, true);


--
-- Name: fato_pedido_frete_id_frete_seq; Type: SEQUENCE SET; Schema: estoque; Owner: postgres
--

SELECT pg_catalog.setval('estoque.fato_pedido_frete_id_frete_seq', 1, false);


--
-- Name: dim_forma_pagamento_id_forma_pagamento_seq; Type: SEQUENCE SET; Schema: financeiro; Owner: postgres
--

SELECT pg_catalog.setval('financeiro.dim_forma_pagamento_id_forma_pagamento_seq', 6, true);


--
-- Name: fato_pedido_id_pedido_seq; Type: SEQUENCE SET; Schema: financeiro; Owner: postgres
--

SELECT pg_catalog.setval('financeiro.fato_pedido_id_pedido_seq', 2000, true);


--
-- Name: fato_transacao_financeira_id_transacao_seq; Type: SEQUENCE SET; Schema: financeiro; Owner: postgres
--

SELECT pg_catalog.setval('financeiro.fato_transacao_financeira_id_transacao_seq', 2000, true);


--
-- Name: fato_venda_id_venda_seq; Type: SEQUENCE SET; Schema: financeiro; Owner: postgres
--

SELECT pg_catalog.setval('financeiro.fato_venda_id_venda_seq', 2000, true);


--
-- Name: dim_localizacao_id_localizacao_seq; Type: SEQUENCE SET; Schema: geral; Owner: postgres
--

SELECT pg_catalog.setval('geral.dim_localizacao_id_localizacao_seq', 41, true);


--
-- Name: dim_tempo_id_tempo_seq; Type: SEQUENCE SET; Schema: geral; Owner: postgres
--

SELECT pg_catalog.setval('geral.dim_tempo_id_tempo_seq', 6573, true);


--
-- Name: dim_canal_venda dim_canal_venda_canal_venda_key; Type: CONSTRAINT; Schema: administrativo; Owner: postgres
--

ALTER TABLE ONLY administrativo.dim_canal_venda
    ADD CONSTRAINT dim_canal_venda_canal_venda_key UNIQUE (canal_venda);


--
-- Name: dim_canal_venda dim_canal_venda_pkey; Type: CONSTRAINT; Schema: administrativo; Owner: postgres
--

ALTER TABLE ONLY administrativo.dim_canal_venda
    ADD CONSTRAINT dim_canal_venda_pkey PRIMARY KEY (id_canal_venda);


--
-- Name: dim_categoria_produto dim_categoria_produto_pkey; Type: CONSTRAINT; Schema: administrativo; Owner: postgres
--

ALTER TABLE ONLY administrativo.dim_categoria_produto
    ADD CONSTRAINT dim_categoria_produto_pkey PRIMARY KEY (id_categoria);


--
-- Name: dim_clientes dim_clientes_pkey; Type: CONSTRAINT; Schema: administrativo; Owner: postgres
--

ALTER TABLE ONLY administrativo.dim_clientes
    ADD CONSTRAINT dim_clientes_pkey PRIMARY KEY (id_cliente);


--
-- Name: dim_fornecedor dim_fornecedor_cnpj_key; Type: CONSTRAINT; Schema: administrativo; Owner: postgres
--

ALTER TABLE ONLY administrativo.dim_fornecedor
    ADD CONSTRAINT dim_fornecedor_cnpj_key UNIQUE (cnpj);


--
-- Name: dim_fornecedor dim_fornecedor_pkey; Type: CONSTRAINT; Schema: administrativo; Owner: postgres
--

ALTER TABLE ONLY administrativo.dim_fornecedor
    ADD CONSTRAINT dim_fornecedor_pkey PRIMARY KEY (id_fornecedor);


--
-- Name: dim_produtos dim_produtos_pkey; Type: CONSTRAINT; Schema: administrativo; Owner: postgres
--

ALTER TABLE ONLY administrativo.dim_produtos
    ADD CONSTRAINT dim_produtos_pkey PRIMARY KEY (id_produto);


--
-- Name: dim_categoria_produto hierarquia_produto; Type: CONSTRAINT; Schema: administrativo; Owner: postgres
--

ALTER TABLE ONLY administrativo.dim_categoria_produto
    ADD CONSTRAINT hierarquia_produto UNIQUE (categoria, subcategoria, linha_produto);


--
-- Name: dim_tipo_movimentacao dim_tipo_movimentacao_pkey; Type: CONSTRAINT; Schema: estoque; Owner: postgres
--

ALTER TABLE ONLY estoque.dim_tipo_movimentacao
    ADD CONSTRAINT dim_tipo_movimentacao_pkey PRIMARY KEY (id_tipo_movimentacao);


--
-- Name: dim_transportadora dim_transportadora_cnpj_key; Type: CONSTRAINT; Schema: estoque; Owner: postgres
--

ALTER TABLE ONLY estoque.dim_transportadora
    ADD CONSTRAINT dim_transportadora_cnpj_key UNIQUE (cnpj);


--
-- Name: dim_transportadora dim_transportadora_pkey; Type: CONSTRAINT; Schema: estoque; Owner: postgres
--

ALTER TABLE ONLY estoque.dim_transportadora
    ADD CONSTRAINT dim_transportadora_pkey PRIMARY KEY (id_transportadora);


--
-- Name: fato_movimentacao_estoque fato_movimentacao_estoque_pkey; Type: CONSTRAINT; Schema: estoque; Owner: postgres
--

ALTER TABLE ONLY estoque.fato_movimentacao_estoque
    ADD CONSTRAINT fato_movimentacao_estoque_pkey PRIMARY KEY (id_movimentacao);


--
-- Name: fato_pedido_frete fato_pedido_frete_pkey; Type: CONSTRAINT; Schema: estoque; Owner: postgres
--

ALTER TABLE ONLY estoque.fato_pedido_frete
    ADD CONSTRAINT fato_pedido_frete_pkey PRIMARY KEY (id_frete);


--
-- Name: dim_forma_pagamento dim_forma_pagamento_forma_pagamento_key; Type: CONSTRAINT; Schema: financeiro; Owner: postgres
--

ALTER TABLE ONLY financeiro.dim_forma_pagamento
    ADD CONSTRAINT dim_forma_pagamento_forma_pagamento_key UNIQUE (forma_pagamento);


--
-- Name: dim_forma_pagamento dim_forma_pagamento_pkey; Type: CONSTRAINT; Schema: financeiro; Owner: postgres
--

ALTER TABLE ONLY financeiro.dim_forma_pagamento
    ADD CONSTRAINT dim_forma_pagamento_pkey PRIMARY KEY (id_forma_pagamento);


--
-- Name: fato_pedido fato_pedido_numero_pedido_key; Type: CONSTRAINT; Schema: financeiro; Owner: postgres
--

ALTER TABLE ONLY financeiro.fato_pedido
    ADD CONSTRAINT fato_pedido_numero_pedido_key UNIQUE (numero_pedido);


--
-- Name: fato_pedido fato_pedido_pkey; Type: CONSTRAINT; Schema: financeiro; Owner: postgres
--

ALTER TABLE ONLY financeiro.fato_pedido
    ADD CONSTRAINT fato_pedido_pkey PRIMARY KEY (id_pedido);


--
-- Name: fato_transacao_financeira fato_transacao_financeira_pkey; Type: CONSTRAINT; Schema: financeiro; Owner: postgres
--

ALTER TABLE ONLY financeiro.fato_transacao_financeira
    ADD CONSTRAINT fato_transacao_financeira_pkey PRIMARY KEY (id_transacao);


--
-- Name: fato_venda fato_venda_pkey; Type: CONSTRAINT; Schema: financeiro; Owner: postgres
--

ALTER TABLE ONLY financeiro.fato_venda
    ADD CONSTRAINT fato_venda_pkey PRIMARY KEY (id_venda);


--
-- Name: fato_venda venda_pedido_item; Type: CONSTRAINT; Schema: financeiro; Owner: postgres
--

ALTER TABLE ONLY financeiro.fato_venda
    ADD CONSTRAINT venda_pedido_item UNIQUE (numero_pedido, numero_item);


--
-- Name: dim_localizacao cidade_estado; Type: CONSTRAINT; Schema: geral; Owner: postgres
--

ALTER TABLE ONLY geral.dim_localizacao
    ADD CONSTRAINT cidade_estado UNIQUE (cidade, estado);


--
-- Name: dim_localizacao dim_localizacao_pkey; Type: CONSTRAINT; Schema: geral; Owner: postgres
--

ALTER TABLE ONLY geral.dim_localizacao
    ADD CONSTRAINT dim_localizacao_pkey PRIMARY KEY (id_localizacao);


--
-- Name: dim_tempo dim_tempo_data_key; Type: CONSTRAINT; Schema: geral; Owner: postgres
--

ALTER TABLE ONLY geral.dim_tempo
    ADD CONSTRAINT dim_tempo_data_key UNIQUE (data);


--
-- Name: dim_tempo dim_tempo_pkey; Type: CONSTRAINT; Schema: geral; Owner: postgres
--

ALTER TABLE ONLY geral.dim_tempo
    ADD CONSTRAINT dim_tempo_pkey PRIMARY KEY (id_tempo);


--
-- Name: idx_categoria_principal; Type: INDEX; Schema: administrativo; Owner: postgres
--

CREATE INDEX idx_categoria_principal ON administrativo.dim_categoria_produto USING btree (categoria);


--
-- Name: idx_cliente_localizacao; Type: INDEX; Schema: administrativo; Owner: postgres
--

CREATE INDEX idx_cliente_localizacao ON administrativo.dim_clientes USING btree (fk_localizacao);


--
-- Name: idx_produto_categoria; Type: INDEX; Schema: administrativo; Owner: postgres
--

CREATE INDEX idx_produto_categoria ON administrativo.dim_produtos USING btree (id_categoria);


--
-- Name: idx_produto_fornecedor; Type: INDEX; Schema: administrativo; Owner: postgres
--

CREATE INDEX idx_produto_fornecedor ON administrativo.dim_produtos USING btree (id_fornecedor);


--
-- Name: idx_cubo_estoque_ano_mes; Type: INDEX; Schema: estoque; Owner: postgres
--

CREATE INDEX idx_cubo_estoque_ano_mes ON estoque.cubo_estoque USING btree (ano, mes);


--
-- Name: idx_cubo_estoque_categoria; Type: INDEX; Schema: estoque; Owner: postgres
--

CREATE INDEX idx_cubo_estoque_categoria ON estoque.cubo_estoque USING btree (categoria);


--
-- Name: idx_cubo_estoque_natureza; Type: INDEX; Schema: estoque; Owner: postgres
--

CREATE INDEX idx_cubo_estoque_natureza ON estoque.cubo_estoque USING btree (natureza);


--
-- Name: idx_cubo_estoque_produto; Type: INDEX; Schema: estoque; Owner: postgres
--

CREATE INDEX idx_cubo_estoque_produto ON estoque.cubo_estoque USING btree (nome_produto);


--
-- Name: idx_cubo_frete_ano_mes; Type: INDEX; Schema: estoque; Owner: postgres
--

CREATE INDEX idx_cubo_frete_ano_mes ON estoque.cubo_frete USING btree (ano_envio, mes_envio);


--
-- Name: idx_cubo_frete_regiao_destino; Type: INDEX; Schema: estoque; Owner: postgres
--

CREATE INDEX idx_cubo_frete_regiao_destino ON estoque.cubo_frete USING btree (regiao_destino);


--
-- Name: idx_cubo_frete_status; Type: INDEX; Schema: estoque; Owner: postgres
--

CREATE INDEX idx_cubo_frete_status ON estoque.cubo_frete USING btree (status_frete);


--
-- Name: idx_cubo_frete_transportadora; Type: INDEX; Schema: estoque; Owner: postgres
--

CREATE INDEX idx_cubo_frete_transportadora ON estoque.cubo_frete USING btree (nome_transportadora);


--
-- Name: idx_frete_destino; Type: INDEX; Schema: estoque; Owner: postgres
--

CREATE INDEX idx_frete_destino ON estoque.fato_pedido_frete USING btree (fk_localizacao_destino);


--
-- Name: idx_frete_origem; Type: INDEX; Schema: estoque; Owner: postgres
--

CREATE INDEX idx_frete_origem ON estoque.fato_pedido_frete USING btree (fk_localizacao_origem);


--
-- Name: idx_frete_pedido; Type: INDEX; Schema: estoque; Owner: postgres
--

CREATE INDEX idx_frete_pedido ON estoque.fato_pedido_frete USING btree (numero_pedido);


--
-- Name: idx_frete_status; Type: INDEX; Schema: estoque; Owner: postgres
--

CREATE INDEX idx_frete_status ON estoque.fato_pedido_frete USING btree (status_frete);


--
-- Name: idx_frete_transportadora; Type: INDEX; Schema: estoque; Owner: postgres
--

CREATE INDEX idx_frete_transportadora ON estoque.fato_pedido_frete USING btree (fk_transportadora);


--
-- Name: idx_mov_data; Type: INDEX; Schema: estoque; Owner: postgres
--

CREATE INDEX idx_mov_data ON estoque.fato_movimentacao_estoque USING btree (data_hora_movimentacao);


--
-- Name: idx_mov_produto; Type: INDEX; Schema: estoque; Owner: postgres
--

CREATE INDEX idx_mov_produto ON estoque.fato_movimentacao_estoque USING btree (fk_produto);


--
-- Name: idx_mov_tempo; Type: INDEX; Schema: estoque; Owner: postgres
--

CREATE INDEX idx_mov_tempo ON estoque.fato_movimentacao_estoque USING btree (fk_tempo);


--
-- Name: idx_mov_tipo; Type: INDEX; Schema: estoque; Owner: postgres
--

CREATE INDEX idx_mov_tipo ON estoque.fato_movimentacao_estoque USING btree (fk_tipo_movimentacao);


--
-- Name: idx_transp_ativo; Type: INDEX; Schema: estoque; Owner: postgres
--

CREATE INDEX idx_transp_ativo ON estoque.dim_transportadora USING btree (ativo);


--
-- Name: idx_cubo_dre_ano_mes; Type: INDEX; Schema: financeiro; Owner: postgres
--

CREATE INDEX idx_cubo_dre_ano_mes ON financeiro.cubo_dre USING btree (ano, mes);


--
-- Name: idx_cubo_dre_status; Type: INDEX; Schema: financeiro; Owner: postgres
--

CREATE INDEX idx_cubo_dre_status ON financeiro.cubo_dre USING btree (status_transacao);


--
-- Name: idx_cubo_dre_tipo; Type: INDEX; Schema: financeiro; Owner: postgres
--

CREATE INDEX idx_cubo_dre_tipo ON financeiro.cubo_dre USING btree (tipo_transacao);


--
-- Name: idx_cubo_vendas_ano_mes; Type: INDEX; Schema: financeiro; Owner: postgres
--

CREATE INDEX idx_cubo_vendas_ano_mes ON financeiro.cubo_vendas USING btree (ano, mes);


--
-- Name: idx_cubo_vendas_canal; Type: INDEX; Schema: financeiro; Owner: postgres
--

CREATE INDEX idx_cubo_vendas_canal ON financeiro.cubo_vendas USING btree (canal_venda);


--
-- Name: idx_cubo_vendas_categoria; Type: INDEX; Schema: financeiro; Owner: postgres
--

CREATE INDEX idx_cubo_vendas_categoria ON financeiro.cubo_vendas USING btree (categoria);


--
-- Name: idx_cubo_vendas_fornecedor; Type: INDEX; Schema: financeiro; Owner: postgres
--

CREATE INDEX idx_cubo_vendas_fornecedor ON financeiro.cubo_vendas USING btree (nome_fornecedor);


--
-- Name: idx_cubo_vendas_regiao; Type: INDEX; Schema: financeiro; Owner: postgres
--

CREATE INDEX idx_cubo_vendas_regiao ON financeiro.cubo_vendas USING btree (regiao_cliente);


--
-- Name: idx_pedido_cliente; Type: INDEX; Schema: financeiro; Owner: postgres
--

CREATE INDEX idx_pedido_cliente ON financeiro.fato_pedido USING btree (fk_cliente);


--
-- Name: idx_pedido_status; Type: INDEX; Schema: financeiro; Owner: postgres
--

CREATE INDEX idx_pedido_status ON financeiro.fato_pedido USING btree (status_pedido);


--
-- Name: idx_pedido_tempo; Type: INDEX; Schema: financeiro; Owner: postgres
--

CREATE INDEX idx_pedido_tempo ON financeiro.fato_pedido USING btree (fk_tempo);


--
-- Name: idx_trans_status; Type: INDEX; Schema: financeiro; Owner: postgres
--

CREATE INDEX idx_trans_status ON financeiro.fato_transacao_financeira USING btree (status_transacao);


--
-- Name: idx_trans_tipo; Type: INDEX; Schema: financeiro; Owner: postgres
--

CREATE INDEX idx_trans_tipo ON financeiro.fato_transacao_financeira USING btree (tipo_transacao);


--
-- Name: idx_venda_canal; Type: INDEX; Schema: financeiro; Owner: postgres
--

CREATE INDEX idx_venda_canal ON financeiro.fato_venda USING btree (fk_canal_venda);


--
-- Name: idx_venda_cliente; Type: INDEX; Schema: financeiro; Owner: postgres
--

CREATE INDEX idx_venda_cliente ON financeiro.fato_venda USING btree (fk_cliente);


--
-- Name: idx_venda_data; Type: INDEX; Schema: financeiro; Owner: postgres
--

CREATE INDEX idx_venda_data ON financeiro.fato_venda USING btree (data_hora_venda);


--
-- Name: idx_venda_pedido; Type: INDEX; Schema: financeiro; Owner: postgres
--

CREATE INDEX idx_venda_pedido ON financeiro.fato_venda USING btree (numero_pedido);


--
-- Name: idx_venda_produto; Type: INDEX; Schema: financeiro; Owner: postgres
--

CREATE INDEX idx_venda_produto ON financeiro.fato_venda USING btree (fk_produto);


--
-- Name: idx_venda_tempo; Type: INDEX; Schema: financeiro; Owner: postgres
--

CREATE INDEX idx_venda_tempo ON financeiro.fato_venda USING btree (fk_tempo);


--
-- Name: idx_loc_estado; Type: INDEX; Schema: geral; Owner: postgres
--

CREATE INDEX idx_loc_estado ON geral.dim_localizacao USING btree (estado);


--
-- Name: idx_loc_regiao; Type: INDEX; Schema: geral; Owner: postgres
--

CREATE INDEX idx_loc_regiao ON geral.dim_localizacao USING btree (regiao);


--
-- Name: idx_tempo_ano_mes; Type: INDEX; Schema: geral; Owner: postgres
--

CREATE INDEX idx_tempo_ano_mes ON geral.dim_tempo USING btree (ano, mes);


--
-- Name: idx_tempo_data; Type: INDEX; Schema: geral; Owner: postgres
--

CREATE INDEX idx_tempo_data ON geral.dim_tempo USING btree (data);


--
-- Name: idx_tempo_trimestre; Type: INDEX; Schema: geral; Owner: postgres
--

CREATE INDEX idx_tempo_trimestre ON geral.dim_tempo USING btree (ano, trimestre);


--
-- Name: dim_clientes dim_clientes_fk_localizacao_fkey; Type: FK CONSTRAINT; Schema: administrativo; Owner: postgres
--

ALTER TABLE ONLY administrativo.dim_clientes
    ADD CONSTRAINT dim_clientes_fk_localizacao_fkey FOREIGN KEY (fk_localizacao) REFERENCES geral.dim_localizacao(id_localizacao);


--
-- Name: dim_fornecedor dim_fornecedor_id_localizacao_fkey; Type: FK CONSTRAINT; Schema: administrativo; Owner: postgres
--

ALTER TABLE ONLY administrativo.dim_fornecedor
    ADD CONSTRAINT dim_fornecedor_id_localizacao_fkey FOREIGN KEY (id_localizacao) REFERENCES geral.dim_localizacao(id_localizacao);


--
-- Name: dim_produtos dim_produtos_id_categoria_fkey; Type: FK CONSTRAINT; Schema: administrativo; Owner: postgres
--

ALTER TABLE ONLY administrativo.dim_produtos
    ADD CONSTRAINT dim_produtos_id_categoria_fkey FOREIGN KEY (id_categoria) REFERENCES administrativo.dim_categoria_produto(id_categoria);


--
-- Name: dim_produtos dim_produtos_id_fornecedor_fkey; Type: FK CONSTRAINT; Schema: administrativo; Owner: postgres
--

ALTER TABLE ONLY administrativo.dim_produtos
    ADD CONSTRAINT dim_produtos_id_fornecedor_fkey FOREIGN KEY (id_fornecedor) REFERENCES administrativo.dim_fornecedor(id_fornecedor);


--
-- Name: fato_movimentacao_estoque fato_movimentacao_estoque_fk_fornecedor_fkey; Type: FK CONSTRAINT; Schema: estoque; Owner: postgres
--

ALTER TABLE ONLY estoque.fato_movimentacao_estoque
    ADD CONSTRAINT fato_movimentacao_estoque_fk_fornecedor_fkey FOREIGN KEY (fk_fornecedor) REFERENCES administrativo.dim_fornecedor(id_fornecedor);


--
-- Name: fato_movimentacao_estoque fato_movimentacao_estoque_fk_produto_fkey; Type: FK CONSTRAINT; Schema: estoque; Owner: postgres
--

ALTER TABLE ONLY estoque.fato_movimentacao_estoque
    ADD CONSTRAINT fato_movimentacao_estoque_fk_produto_fkey FOREIGN KEY (fk_produto) REFERENCES administrativo.dim_produtos(id_produto);


--
-- Name: fato_movimentacao_estoque fato_movimentacao_estoque_fk_tempo_fkey; Type: FK CONSTRAINT; Schema: estoque; Owner: postgres
--

ALTER TABLE ONLY estoque.fato_movimentacao_estoque
    ADD CONSTRAINT fato_movimentacao_estoque_fk_tempo_fkey FOREIGN KEY (fk_tempo) REFERENCES geral.dim_tempo(id_tempo);


--
-- Name: fato_movimentacao_estoque fato_movimentacao_estoque_fk_tipo_movimentacao_fkey; Type: FK CONSTRAINT; Schema: estoque; Owner: postgres
--

ALTER TABLE ONLY estoque.fato_movimentacao_estoque
    ADD CONSTRAINT fato_movimentacao_estoque_fk_tipo_movimentacao_fkey FOREIGN KEY (fk_tipo_movimentacao) REFERENCES estoque.dim_tipo_movimentacao(id_tipo_movimentacao);


--
-- Name: fato_pedido_frete fato_pedido_frete_fk_localizacao_destino_fkey; Type: FK CONSTRAINT; Schema: estoque; Owner: postgres
--

ALTER TABLE ONLY estoque.fato_pedido_frete
    ADD CONSTRAINT fato_pedido_frete_fk_localizacao_destino_fkey FOREIGN KEY (fk_localizacao_destino) REFERENCES geral.dim_localizacao(id_localizacao);


--
-- Name: fato_pedido_frete fato_pedido_frete_fk_localizacao_origem_fkey; Type: FK CONSTRAINT; Schema: estoque; Owner: postgres
--

ALTER TABLE ONLY estoque.fato_pedido_frete
    ADD CONSTRAINT fato_pedido_frete_fk_localizacao_origem_fkey FOREIGN KEY (fk_localizacao_origem) REFERENCES geral.dim_localizacao(id_localizacao);


--
-- Name: fato_pedido_frete fato_pedido_frete_fk_tempo_entrega_fkey; Type: FK CONSTRAINT; Schema: estoque; Owner: postgres
--

ALTER TABLE ONLY estoque.fato_pedido_frete
    ADD CONSTRAINT fato_pedido_frete_fk_tempo_entrega_fkey FOREIGN KEY (fk_tempo_entrega) REFERENCES geral.dim_tempo(id_tempo);


--
-- Name: fato_pedido_frete fato_pedido_frete_fk_tempo_envio_fkey; Type: FK CONSTRAINT; Schema: estoque; Owner: postgres
--

ALTER TABLE ONLY estoque.fato_pedido_frete
    ADD CONSTRAINT fato_pedido_frete_fk_tempo_envio_fkey FOREIGN KEY (fk_tempo_envio) REFERENCES geral.dim_tempo(id_tempo);


--
-- Name: fato_pedido_frete fato_pedido_frete_fk_transportadora_fkey; Type: FK CONSTRAINT; Schema: estoque; Owner: postgres
--

ALTER TABLE ONLY estoque.fato_pedido_frete
    ADD CONSTRAINT fato_pedido_frete_fk_transportadora_fkey FOREIGN KEY (fk_transportadora) REFERENCES estoque.dim_transportadora(id_transportadora);


--
-- Name: fato_pedido fato_pedido_fk_canal_venda_fkey; Type: FK CONSTRAINT; Schema: financeiro; Owner: postgres
--

ALTER TABLE ONLY financeiro.fato_pedido
    ADD CONSTRAINT fato_pedido_fk_canal_venda_fkey FOREIGN KEY (fk_canal_venda) REFERENCES administrativo.dim_canal_venda(id_canal_venda);


--
-- Name: fato_pedido fato_pedido_fk_cliente_fkey; Type: FK CONSTRAINT; Schema: financeiro; Owner: postgres
--

ALTER TABLE ONLY financeiro.fato_pedido
    ADD CONSTRAINT fato_pedido_fk_cliente_fkey FOREIGN KEY (fk_cliente) REFERENCES administrativo.dim_clientes(id_cliente);


--
-- Name: fato_pedido fato_pedido_fk_forma_pagamento_fkey; Type: FK CONSTRAINT; Schema: financeiro; Owner: postgres
--

ALTER TABLE ONLY financeiro.fato_pedido
    ADD CONSTRAINT fato_pedido_fk_forma_pagamento_fkey FOREIGN KEY (fk_forma_pagamento) REFERENCES financeiro.dim_forma_pagamento(id_forma_pagamento);


--
-- Name: fato_pedido fato_pedido_fk_tempo_fkey; Type: FK CONSTRAINT; Schema: financeiro; Owner: postgres
--

ALTER TABLE ONLY financeiro.fato_pedido
    ADD CONSTRAINT fato_pedido_fk_tempo_fkey FOREIGN KEY (fk_tempo) REFERENCES geral.dim_tempo(id_tempo);


--
-- Name: fato_transacao_financeira fato_transacao_financeira_fk_data_pagamento_fkey; Type: FK CONSTRAINT; Schema: financeiro; Owner: postgres
--

ALTER TABLE ONLY financeiro.fato_transacao_financeira
    ADD CONSTRAINT fato_transacao_financeira_fk_data_pagamento_fkey FOREIGN KEY (fk_data_pagamento) REFERENCES geral.dim_tempo(id_tempo);


--
-- Name: fato_transacao_financeira fato_transacao_financeira_fk_forma_pagamento_fkey; Type: FK CONSTRAINT; Schema: financeiro; Owner: postgres
--

ALTER TABLE ONLY financeiro.fato_transacao_financeira
    ADD CONSTRAINT fato_transacao_financeira_fk_forma_pagamento_fkey FOREIGN KEY (fk_forma_pagamento) REFERENCES financeiro.dim_forma_pagamento(id_forma_pagamento);


--
-- Name: fato_venda fato_venda_fk_canal_venda_fkey; Type: FK CONSTRAINT; Schema: financeiro; Owner: postgres
--

ALTER TABLE ONLY financeiro.fato_venda
    ADD CONSTRAINT fato_venda_fk_canal_venda_fkey FOREIGN KEY (fk_canal_venda) REFERENCES administrativo.dim_canal_venda(id_canal_venda);


--
-- Name: fato_venda fato_venda_fk_cliente_fkey; Type: FK CONSTRAINT; Schema: financeiro; Owner: postgres
--

ALTER TABLE ONLY financeiro.fato_venda
    ADD CONSTRAINT fato_venda_fk_cliente_fkey FOREIGN KEY (fk_cliente) REFERENCES administrativo.dim_clientes(id_cliente);


--
-- Name: fato_venda fato_venda_fk_forma_pagamento_fkey; Type: FK CONSTRAINT; Schema: financeiro; Owner: postgres
--

ALTER TABLE ONLY financeiro.fato_venda
    ADD CONSTRAINT fato_venda_fk_forma_pagamento_fkey FOREIGN KEY (fk_forma_pagamento) REFERENCES financeiro.dim_forma_pagamento(id_forma_pagamento);


--
-- Name: fato_venda fato_venda_fk_produto_fkey; Type: FK CONSTRAINT; Schema: financeiro; Owner: postgres
--

ALTER TABLE ONLY financeiro.fato_venda
    ADD CONSTRAINT fato_venda_fk_produto_fkey FOREIGN KEY (fk_produto) REFERENCES administrativo.dim_produtos(id_produto);


--
-- Name: fato_venda fato_venda_fk_tempo_fkey; Type: FK CONSTRAINT; Schema: financeiro; Owner: postgres
--

ALTER TABLE ONLY financeiro.fato_venda
    ADD CONSTRAINT fato_venda_fk_tempo_fkey FOREIGN KEY (fk_tempo) REFERENCES geral.dim_tempo(id_tempo);


--
-- Name: cubo_estoque; Type: MATERIALIZED VIEW DATA; Schema: estoque; Owner: postgres
--

REFRESH MATERIALIZED VIEW estoque.cubo_estoque;


--
-- Name: cubo_frete; Type: MATERIALIZED VIEW DATA; Schema: estoque; Owner: postgres
--

REFRESH MATERIALIZED VIEW estoque.cubo_frete;


--
-- Name: cubo_dre; Type: MATERIALIZED VIEW DATA; Schema: financeiro; Owner: postgres
--

REFRESH MATERIALIZED VIEW financeiro.cubo_dre;


--
-- Name: cubo_vendas; Type: MATERIALIZED VIEW DATA; Schema: financeiro; Owner: postgres
--

REFRESH MATERIALIZED VIEW financeiro.cubo_vendas;


--
-- PostgreSQL database dump complete
--

\unrestrict Jsl8EVjLF4uDxkfennRkZZ2ZwaG28Yk5hK8UJdUPLcnOedSMR6I7TQysZmKHerJ

