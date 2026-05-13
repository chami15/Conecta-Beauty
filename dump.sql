--
-- PostgreSQL database dump
--

\restrict y1q0SHjWyikbcrQcTN4vXSaDvehusHSaurK4xMXybtwMLJolMgF9hAQZWjUnZri

-- Dumped from database version 18.3
-- Dumped by pg_dump version 18.3

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: dim_cliente; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dim_cliente (
    sk_cliente integer NOT NULL,
    id_cliente integer,
    nome_cliente character varying(150),
    sexo character(1),
    endereco character varying(200),
    estado character(2),
    cidade character varying(100),
    estado_nome_cliente character varying(50),
    telefone character varying(20)
);


ALTER TABLE public.dim_cliente OWNER TO postgres;

--
-- Name: dim_cliente_sk_cliente_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dim_cliente_sk_cliente_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.dim_cliente_sk_cliente_seq OWNER TO postgres;

--
-- Name: dim_cliente_sk_cliente_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dim_cliente_sk_cliente_seq OWNED BY public.dim_cliente.sk_cliente;


--
-- Name: dim_pagamento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dim_pagamento (
    sk_pagamento integer NOT NULL,
    forma_pagamento character varying(50),
    canal_venda character varying(50)
);


ALTER TABLE public.dim_pagamento OWNER TO postgres;

--
-- Name: dim_pagamento_sk_pagamento_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dim_pagamento_sk_pagamento_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.dim_pagamento_sk_pagamento_seq OWNER TO postgres;

--
-- Name: dim_pagamento_sk_pagamento_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dim_pagamento_sk_pagamento_seq OWNED BY public.dim_pagamento.sk_pagamento;


--
-- Name: dim_produto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dim_produto (
    sk_produto integer NOT NULL,
    id_produto integer,
    nome_produto character varying(150),
    categoria character varying(100),
    fornecedor character varying(150),
    valor_unitario numeric(10,2)
);


ALTER TABLE public.dim_produto OWNER TO postgres;

--
-- Name: dim_produto_sk_produto_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dim_produto_sk_produto_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.dim_produto_sk_produto_seq OWNER TO postgres;

--
-- Name: dim_produto_sk_produto_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dim_produto_sk_produto_seq OWNED BY public.dim_produto.sk_produto;


--
-- Name: dim_regiao; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dim_regiao (
    sk_regiao integer NOT NULL,
    id_regiao integer,
    nome_regiao character varying(100),
    valor_frete numeric(10,2)
);


ALTER TABLE public.dim_regiao OWNER TO postgres;

--
-- Name: dim_regiao_sk_regiao_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dim_regiao_sk_regiao_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.dim_regiao_sk_regiao_seq OWNER TO postgres;

--
-- Name: dim_regiao_sk_regiao_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dim_regiao_sk_regiao_seq OWNED BY public.dim_regiao.sk_regiao;


--
-- Name: dim_tempo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dim_tempo (
    sk_tempo integer NOT NULL,
    data_completa date,
    dia integer,
    mes integer,
    nome_mes character varying(20),
    trimestre integer,
    ano integer,
    dia_semana character varying(20)
);


ALTER TABLE public.dim_tempo OWNER TO postgres;

--
-- Name: dim_tempo_sk_tempo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dim_tempo_sk_tempo_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.dim_tempo_sk_tempo_seq OWNER TO postgres;

--
-- Name: dim_tempo_sk_tempo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dim_tempo_sk_tempo_seq OWNED BY public.dim_tempo.sk_tempo;


--
-- Name: dim_transportadora; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dim_transportadora (
    sk_transportadora integer NOT NULL,
    id_transportadora integer,
    nome_transportadora character varying(150),
    cnpj character varying(20),
    id_regiao integer,
    prazo_entrega_dias integer
);


ALTER TABLE public.dim_transportadora OWNER TO postgres;

--
-- Name: dim_transportadora_sk_transportadora_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dim_transportadora_sk_transportadora_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.dim_transportadora_sk_transportadora_seq OWNER TO postgres;

--
-- Name: dim_transportadora_sk_transportadora_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dim_transportadora_sk_transportadora_seq OWNED BY public.dim_transportadora.sk_transportadora;


--
-- Name: fato_estoque; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fato_estoque (
    sk_estoque integer NOT NULL,
    sk_produto integer,
    sk_tempo integer,
    tipo_movimento character varying(20),
    quantidade integer,
    saldo_atual integer
);


ALTER TABLE public.fato_estoque OWNER TO postgres;

--
-- Name: fato_estoque_sk_estoque_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.fato_estoque_sk_estoque_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.fato_estoque_sk_estoque_seq OWNER TO postgres;

--
-- Name: fato_estoque_sk_estoque_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.fato_estoque_sk_estoque_seq OWNED BY public.fato_estoque.sk_estoque;


--
-- Name: fato_financeiro; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fato_financeiro (
    sk_financeiro integer NOT NULL,
    sk_tempo integer,
    tipo_lancamento character varying(30),
    status_pagamento character varying(20),
    valor numeric(12,2)
);


ALTER TABLE public.fato_financeiro OWNER TO postgres;

--
-- Name: fato_financeiro_sk_financeiro_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.fato_financeiro_sk_financeiro_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.fato_financeiro_sk_financeiro_seq OWNER TO postgres;

--
-- Name: fato_financeiro_sk_financeiro_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.fato_financeiro_sk_financeiro_seq OWNED BY public.fato_financeiro.sk_financeiro;


--
-- Name: fato_vendas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fato_vendas (
    sk_venda integer NOT NULL,
    sk_cliente integer,
    sk_produto integer,
    sk_tempo integer,
    sk_regiao integer,
    sk_transportadora integer,
    sk_pagamento integer,
    quantidade integer,
    preco_unitario numeric(10,2),
    desconto numeric(10,2),
    valor_total numeric(12,2)
);


ALTER TABLE public.fato_vendas OWNER TO postgres;

--
-- Name: fato_vendas_sk_venda_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.fato_vendas_sk_venda_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.fato_vendas_sk_venda_seq OWNER TO postgres;

--
-- Name: fato_vendas_sk_venda_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.fato_vendas_sk_venda_seq OWNED BY public.fato_vendas.sk_venda;


--
-- Name: dim_cliente sk_cliente; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_cliente ALTER COLUMN sk_cliente SET DEFAULT nextval('public.dim_cliente_sk_cliente_seq'::regclass);


--
-- Name: dim_pagamento sk_pagamento; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_pagamento ALTER COLUMN sk_pagamento SET DEFAULT nextval('public.dim_pagamento_sk_pagamento_seq'::regclass);


--
-- Name: dim_produto sk_produto; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_produto ALTER COLUMN sk_produto SET DEFAULT nextval('public.dim_produto_sk_produto_seq'::regclass);


--
-- Name: dim_regiao sk_regiao; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_regiao ALTER COLUMN sk_regiao SET DEFAULT nextval('public.dim_regiao_sk_regiao_seq'::regclass);


--
-- Name: dim_tempo sk_tempo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_tempo ALTER COLUMN sk_tempo SET DEFAULT nextval('public.dim_tempo_sk_tempo_seq'::regclass);


--
-- Name: dim_transportadora sk_transportadora; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_transportadora ALTER COLUMN sk_transportadora SET DEFAULT nextval('public.dim_transportadora_sk_transportadora_seq'::regclass);


--
-- Name: fato_estoque sk_estoque; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fato_estoque ALTER COLUMN sk_estoque SET DEFAULT nextval('public.fato_estoque_sk_estoque_seq'::regclass);


--
-- Name: fato_financeiro sk_financeiro; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fato_financeiro ALTER COLUMN sk_financeiro SET DEFAULT nextval('public.fato_financeiro_sk_financeiro_seq'::regclass);


--
-- Name: fato_vendas sk_venda; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fato_vendas ALTER COLUMN sk_venda SET DEFAULT nextval('public.fato_vendas_sk_venda_seq'::regclass);


--
-- Data for Name: dim_cliente; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dim_cliente (sk_cliente, id_cliente, nome_cliente, sexo, endereco, estado, cidade, estado_nome_cliente, telefone) FROM stdin;
1	1	Maria Helena	F	Rua Genaro Olavide Nº 290	SP	São Mateus	São Paulo	(11) 96693-3958
2	2	Maykon Romero	M	Rua Campo Florido Nº 507	SP	São Mateus	São Paulo	(11) 95959-4002
3	3	Anderson Felipe	M	\N	SP	\N	São Paulo	(11) 947144469
4	4	Ricardo Melo Oliveira	M	\N	SP	\N	São Paulo	(11)98519-8141
5	5	Lúcia Cristina	F	\N	SP	São Mateus	São Paulo	\N
6	6	Cida Aparecida	F	\N	SP	São Mateus	São Paulo	\N
7	7	Ivan (Representante)	M	\N	SP	São Mateus	São Paulo	\N
8	8	Barbara Reis	F	\N	SP	São Mateus	São Paulo	\N
9	9	Katia	F	\N	SP	\N	\N	\N
10	10	Erica Rodrigues dos Santos	F	Rua Forte do Triunfo Nº361 Ap 32 Torre 2	SP	São Mateus	São Paulo	(11)95167-6462
11	11	Marilene Neves Dos Santos	F	Avenida Sapopemba Nº 468	SP	\N	São Paulo	(11)93563-8018
12	12	Cliente Loja (Sem identificação)	\N	\N	SP	Mooca	São Paulo	\N
13	13	Fernando Ribeiro	M	Rua Andre Fernandes Nº 138 Vila Florida	SP	Guarulhos	São Paulo	(11) 99513-7213
14	14	Mônica Cristina Da Cruz	F	Rua Cachoreira das 7 quedas Nº 22 Barro Branco	SP	Tiradentes	São Paulo	(11)98560-1790
15	15	Vilma Neves Monteiro	F	Rua Serra de Itabajara Nº 816	SP	Santa Madalena	São Paulo	(11)96017-8366
16	16	Maria de Fatima	F	Avenida Sapopemba Nº 15774	SP	Jd. Adutora	São Paulo	(11) 98260-4336
17	17	Antonio L.	M	Avenida Mateo Bei 3369	SP	São Mateus	São Paulo	\N
18	18	Joice Batista de Brito	F	Avenida Mateo Bei 2635	SP	São Mateus	São Paulo	(11)93801-6917
19	19	Cliente Loja (Sem identificação)	\N	\N	SP	\N	São Paulo	\N
20	20	Ana Carolina Elias Cardoso	F	Rua Aleides Lopes Peres Nº162  Agua Branca	SP	Centro	Avaré	(14)99654-6910
21	21	Luzi A.	F	\N	SP	São Mateus	São Paulo	\N
22	22	Raquel Dos Santos	F	Avenida Mateo bei 1575 Sala 03	SP	São Mateus	São Paulo	\N
23	23	Cliente Loja (Sem identificação)	\N	\N	SP	São Mateus	São Paulo	\N
24	24	Dantas (Representante)	M	\N	SP	Santo André	São Paulo	(11)99933-0442
25	25	Dibi R.	F	Rua Manoel Quirino de Mattos Nº2197	SP	Jd. Sapopemba	São Paulo	\N
26	26	Diego(Representante)	M	\N	SP	São José do Rio Preto	São Paulo	\N
27	25	Mariana G.	M	\N	SP	São Mateus	São Paulo	(11)96909-6757
28	26	Rose Machado	F	Rua Doutor Paulo Queiroz Nº1794	SP	São Mateus	São Paulo	(11)95811-2159
29	27	Raquel Lima	F	Avenida Mateo Bei 5786	SP	São Mateus	São Paulo	(11)987650376
30	28	Roseli Emilia	F	Rua Ilha de Capri Nº225	SP	Mauá	São Paulo	(11)99155-6818
31	29	Ivonete Alves	F	Rua Conego Antonio Dias Pequeno nº51	SP	São Mateus	São Paulo	(11)98726-6055
32	30	Antônia	F	\N	SP	\N	São Paulo	\N
33	31	Thabata Camargo	F	Avenida João Batista Media Nº 302	SP	Embu das Artes	São Paulo	(11)97303-2714
34	32	Cliente Loja (Sem identificação)	M	\N	SP	Tucuruvi	São Paulo	\N
35	33	Amanda Cintia	F	Travessa Paz na Terra Nº77 Jd da Conquista	SP	São Mateus	São Paulo	(11)95219-8895
36	34	Fabiane T.	F	Rua Esquivel Navarro Nº118	SP	São Mateus	São Paulo	(11)99742-1120
37	35	Valeria Rocha	F	Rua Carlos Cossi Nº13	SP	São Mateus	São Paulo	(11)98285-5735
38	36	Geyja L.	F	\N	SP	São Mateus	São Paulo	\N
39	37	Hellen Cristina	F	Rua Francicos dos Santos Coimbra Nº128	SP	São Mateus	São Paulo	(11)9977-5750
40	38	Gabriel Barbearia XV Novembro	M	Rua XV de Novembro 265	SP	Centro	São Paulo	(11) 94526266
41	39	Daniel (Representante)	M	\N	SP	São José do Rio Preto	São Paulo	\N
42	40	Antônio Correia	M	Rua João Gomes Pereira Nº953	SP	São Mateus	São Paulo	(11)94915-1442
43	41	Rosangela A.	F	\N	SP	São Mateus	São Paulo	\N
44	42	Simone Gama da Silva	F	Travessa Henrique Guerrer Nº49 Fazenda da Juta	SP	São Mateus	São Paulo	(11)99374-7123
45	43	Fátima F.	F	\N	SP	Mauá	São Paulo	\N
46	45	Elisangela R.	F	Avenida Ragueb Chofi	SP	São Mateus	São Paulo	\N
47	46	Hellen Almeida	F	Rua Afranio Peixoto Nº224 Jd. Utigna	SP	Santo André	São Paulo	(11)94977-5750
48	47	Claudiana M.	F	\N	SP	\N	São Paulo	\N
49	48	Celeste Silva	F	Rua Conego Antonio Dias Pequeno nº483	SP	São Mateus	São Paulo	\N
50	49	Penha Jardim Marilu	F	\N	SP	São Mateus	São Paulo	(11)94731-9812
51	50	Raquel L.	F	\N	SP	\N	São Paulo	\N
52	51	Natally da Silva	F	Travessa Salassie Nª92 Jd da Conquista	SP	São Mateus	São Paulo	(11)95222-8204
53	52	Luanne Fernandes Leite	F	Rua Domingos Ribeiro Nº 12 Jardim Ester	SP	São Mateus	São Paulo	(11) 96072-5414
54	53	Deja Pereira	F	Rua Doutor Miguel Bombarda Nº251	SP	São Mateus	São Paulo	(11)98739-7509
55	54	Lorraine Pinheiro	F	Jd Sapopemba	SP	São Mateus	São Paulo	\N
56	55	Deca (Representante)	M	\N	SP	Santo André	São Paulo	\N
57	56	Eliane Souza	F	Rua Geronimo Coelho Nº225	SP	Vila Formosa	São Paulo	(11) 99122-2886
58	57	Fabrício A.	M	Jd. Santo André	SP	São Mateus	São Paulo	\N
59	58	Katia N.	F	Jd. São Roberto	SP	São Mateus	São Paulo	\N
60	59	Cristiane Aciolli	F	Avenida Rio das Pedras Nº3522	SP	Aricanduva	São Paulo	(11)9810-54759
61	60	Vera Lucia Alexandre	F	Rua Delmiro Gouveia Nº265	SP	Vila Ema	São Paulo	(11)98844-4272
62	61	Ane Almeida	F	Rua Madagascar Nº12 Sala 04	SP	Santo André	São Paulo	(11)99387-8464
63	62	Fernando	M	\N	SP	Santo André	São Paulo	\N
64	63	Rosangela Marques	F	Rua João Gomes Pereira Nº95	SP	São Mateus	São Paulo	(11)98253-2165
65	64	Graciene Lopes	F	Rua Itamarati Nº44 Heliopolis	SP	Ipiranga	São Paulo	(11)98729-0348
66	65	Gabriela N.	F	Avenida Maria Cursi	SP	São Mateus	São Paulo	\N
67	66	Ana Paula	F	Grimaldi	SP	Grimaldi	São Paulo	\N
68	67	Ana Paula Ferreira	F	Rua Santo Ouvidio Nº208	SP	Itaquera	São Paulo	(11)99571-8383
69	68	Samires Silva	F	Rua Maestro Isaías Savio Nª317	SP	São Mateus	São Paulo	\N
70	69	Charleide Costa	F	Rua Evangelista de Souza Nº1609	SP	Santo André	São Paulo	\N
71	70	Leandro (Barbearia Five Stars)	M	Av. Doutor Guilherme de Abreu Sodre Nº51	SP	Tiradentes	São Paulo	\N
72	71	Jô Novaes	F	Rua Bento Pires Ribeiro Nº4  Jd Santo Andre	SP	Jd. Santo André	São Paulo	\N
73	72	Cleusa A.	F	\N	SP	Jd. Limoeiro	São Paulo	\N
74	73	Nalva	F	\N	SP	Jd. Santa Adélia	São Paulo	\N
75	74	Francisco Rocha	M	Rua Jacarandá Mimoso Nº19	SP	São Mateus	São Paulo	(11)95637-9826
76	75	Solage Rodrigues	F	Avenida Riacho dos Machados Nº417	SP	São Mateus	São Paulo	(11)95045-1206
77	76	Vileuda Ribeiro	F	Rua Ana Popovice Nº130	SP	Sapopemba	São Paulo	(11)99390-6584
78	77	Eliete Acltastel	F	Rua Luiz Botta Nº304	SP	São Mateus	São Paulo	(11)99937-8612
79	78	Katheleen F.	F	Rua Astarté Nº103	SP	São Mateus	São Paulo	(11)98548-9107
80	79	Pele Ferreira	M	\N	SP	Vila Ema	São Paulo	\N
81	80	Bruna Rodrigues	F	\N	SP	São Mateus	São Paulo	\N
82	81	Vitor Lucio	M	Av. Osvaldo Vale Cordeiro	SP	São Mateus	São Paulo	(11)94015-7727
83	82	Suelen V.	F	Rua Suecia Nº16 Parque das Nações	SP	Santo André	São Paulo	\N
84	83	Lilian Regina Alves	F	Rua Duque de Caxias Nº47	SP	Jd. Santo André	São Paulo	(11)99306-8809
85	84	Paulo C.	M	Av. Brigadeira Faria Lima	SP	São Paulo	São Paulo	(11)995137213
86	85	Maria Aparecida N.	F	Rua Francisco Miguinone 905	SP	Teotonio Vilela	São Paulo	(11)95798-7196
87	86	Micheli Souza	F	Rua São Francisco Nº17	SP	São Mateus	São Paulo	(11)98892-6760
88	87	Priscila Soares Dos Santos	F	Rua Solidonio Leite Nº2410 Sala 4	SP	São Mateus	São Paulo	(11)99016-1352
89	88	Bianka Bianchi	F	Rua Cachoeira de Minas Nº355A	SP	São Mateus	São Paulo	(11)98436-9366
90	89	Francisco Rocha	M	Jd. Arantes	SP	Jd. Santo André	São Paulo	\N
91	90	Michele Castro	F	Rua Dias Lemes Nº18	SP	Mooca	São Paulo	(11)98892-6760
92	91	Bruna Ferreira	F	St. Adélia	SP	São Mateus	São Paulo	\N
93	92	Marcos (Representante)	M	\N	SP	São Bernardo	São Paulo	\N
94	93	Silmara A.	F	Avenida Alto Alegre	SP	São Mateus	São Paulo	\N
95	94	Flávio Souza	M	\N	SP	Tiradentes	São Paulo	\N
96	95	Riso Josefa Santos	F	Rua Jacob Santos Nº18A	SP	São Mateus	São Paulo	(11)96659-1084
97	96	Cristiane Vieira Nunes	F	Rua Manoel da Luz Drummond Nº360	SP	São Mateus	São Paulo	(11)94822-8431
98	97	Israel Mendes da Silva	F	Av. Arquiteto Vila Nova Nº229	SP	Sapopemba	São Paulo	(11)94885-1447
99	98	Kayque Fernando	M	Avenida Via de Pedeste Silecia	SP	São Mateus	São Paulo	(11)96437-0863
100	99	Jéssica Pereira	F	Rua Francisco de Melo Palheta Nº706	SP	São Mateus	São Paulo	(11)96348-1525
101	100	Eduardo Cerrades	M	Avenida Nagib Farah Maluf Nº407	SP	Tatuapé	São Paulo	(11)94489-2080
102	101	Jinelson A.	M	Vila Primavera	SP	São Mateus	São Paulo	\N
103	102	Gustavo Mainairt	M	Rua Francisco Lourenço Nº1	SP	Mauá	São Paulo	\N
104	103	Jawila De Paula	F	Rua Antonio Caetinho Nº192	SP	São Mateus	São Paulo	(11)95843-7443
105	104	Tiago Gonçalves Dias	M	Rua James Naris Nº296	SP	São Mateus	São Paulo	(11)98367-1954
106	105	Carlos Allan	M	Rua Maria Luiza Val Penteado Nº616	SP	São Mateus	São Paulo	(11)98544-565
107	106	Edinho(Representante)	M	\N	SP	Mauá	São Paulo	\N
108	107	Roberto	M	\N	SP	Mooca	São Paulo	\N
109	108	Cintia Stoko	F	Rua Abilio Campos Peixe Nº111	SP	São Mateus	São Paulo	(11)98706-1295
110	109	Crislane Dos Santos Alves	F	Rua Mão Rainha Nº62	SP	São Mateus	São Paulo	(11)95244-9477
111	110	Rosilda(Representante)	F	\N	SP	Indaiatuba	São Paulo	\N
112	111	Ivaneide Silva	F	Rua Ingair Nº32	SP	Vila Prudente	São Paulo	(11)96458-4006
113	112	Antônio F. Pereira	M	Rua Noite de Maio Nº315	SP	São Mateus	São Paulo	(11)94914-3787
114	113	Neusa Esteves Samuel	F	Rua Gregório Petondi S/N	SP	São Rafael	São Paulo	(11)94923-7120
115	114	Sandra Moura	F	Rua Rui Deaveiro Nº48	SP	São Mateus	São Paulo	(11)97600-5769
116	115	Andreia Cristina de Souza	F	Rua Soldado Candido da Luz Paiva Nº223	SP	Vila Ema	São Paulo	(11)99549-4115
117	116	Hilario T.	M	Av. Dr Frederico Martins da Costa Carvalo Nº653	SP	Jd. Santo André	São Paulo	(11)95297-2274
118	117	Edson Barbosa	M	Rua Andre de Almeida Nº897	SP	São Mateus	São Paulo	(11)95305-1914
119	118	Tânia Teixeira Brito	F	Av. Ragueb Chofi Nº5097	SP	São Mateus	São Paulo	(11)95439-7295
120	119	Suzi Daiane	F	Rua 15 de Novembro	SP	Ferraz de Vasconcelos	São Paulo	(11)96017-5836
121	120	Caroline S.	F	Sapopemba	SP	São Mateus	São Paulo	\N
122	121	Edson Freire	M	\N	SP	São Mateus	São Paulo	\N
123	122	Mazin R.	M	Rua Giacinto Tognato Nº755	SP	São Bernardo	São Paulo	(11)94821-4152
124	123	Pamela Riveles	F	\N	SP	Itaim Paulista	São Paulo	(11)96307-2605
125	124	Ana Caroline	F	Rua Serra Borborena Nº20	SP	São Mateus	São Paulo	(11)93941-7742
126	125	Luzia Alves	F	Rua Doutor Tostói de Carvalho	SP	Vila Tostói	São Paulo	(11)98869-0143
127	126	Tião Menezes	M	Rua Sebastião Mendonça Nº55	SP	São Mateus	São Paulo	(11)97651-3541
128	127	Rogério Torres	M	Rua Tuiuti Nº2724	SP	Tatuapé	São Paulo	(11)98352-7519
129	128	Wesley F.	M	Rua Manoel Quirino de Mattos Nº1769	SP	São Mateus	São Paulo	(11)95854-3714
130	129	Angelina N.	F	Rua Jerônimo Gonçalves Nº162	SP	Santo André	São Paulo	\N
131	130	Adelma Alves	F	Rua Ilha Trindade Nº578	SP	São Miguel	São Paulo	(11)94893-7253
132	131	Celma Souza	F	\N	SP	São Mateus	São Paulo	\N
133	134	Cida Fernandes	F	\N	SP	São Mateus	São Paulo	(11)96613-2939
134	135	Soraia A.	F	\N	SP	São Mateus	São Paulo	\N
135	136	Edgard L.	M	Rua Orquidea Nº50	SP	Atiabaia	São Paulo	\N
136	137	Cinval Antunes	M	Avenida Oratório Nº5075	SP	Mooca	São Paulo	(11)95489-1324
137	138	Paulo Cesar de Oliveira	M	Rua Miguel Lobo Nº100	SP	São Mateus	São Paulo	(11)95783-1791
138	139	Higor Santana Dos Santos	M	Rua Erechin Nº12 Itamarati	SP	Santo André	São Paulo	(11)97645-9871
139	140	Maycon A,	M	\N	SP	São Mateus	São Paulo	\N
140	141	Lanya Souza	F	Rua Eliisio Ferreira Nº438	SP	São Mateus	São Paulo	\N
141	142	Gilvam (Representante)	M	\N	SP	Carapicuíba	São Paulo	\N
142	143	Adban Vietoc Chaves	M	\N	SP	São Mateus	São Paulo	(11)94977-1842
143	144	Helena Santos	F	Rua Cachoeira de Minas Nº56B	SP	São Mateus	São Paulo	(11)94599-9124
144	145	Nilsa Nunes	F	\N	SP	São Mateus	São Paulo	\N
145	146	Rodrigo Bezerra Joaquim	M	Rua Luiz Bota Nº1249	SP	São Mateus	São Paulo	(11)96798-9242
146	147	Clayton Silva	M	Rua Aldeia Santo Inácio Nº816	SP	Mauá	São Paulo	(11)97969-5863
147	148	Edneide Oliveira	F	Rua Alberto Popovice Nº170	SP	Sapopemba	São Paulo	(11)95990-9213
148	149	Rogério (Representante)	M	\N	SP	Mauá	São Paulo	\N
149	150	Venaldo (Representante)	M	\N	AL	Maceió	Alagoas	\N
150	151	Will Melo	M	Rua Vice Presidente Francisco Alvaro Bueno Nº218	SP	Mauá	São Paulo	(11)93077-8711
151	152	Josefa Da Silva	F	Avenida dos Latinos Nº1554	SP	Aricanduva	São Paulo	(11)98195-9346
152	153	Claudio Nunes	M	Rua Orfanato Nº1071	SP	Vila Prudente	São Paulo	(11)98833-8399
153	154	Andreia Cerrantes	F	Rua Santa Flávia Donatella Nº85	SP	Tiradentes	São Paulo	(11)94230-3068
154	155	Irene Conceição	F	Avenida Custódio de Sá Nº630	SP	Sapopemba	São Paulo	(11)95396-2637
155	156	Gilma Vieira	F	Rua do Gino Nº10	SP	Mauá	São Paulo	(11)95025-6549
156	157	Joelma Dos Santos	F	Rua Dentista Barreto Nº572	SP	Tatuapé	São Paulo	\N
157	158	Ana Caroline Machado	F	Travessa Sabor de Mim Nº532	SP	São Mateus	São Paulo	(11)96367-0812
158	159	Alan Souza	M	Rua Imirim Nº832	SP	Jandira	São Paulo	(11)94013-8985
159	160	Elaine da Silva Souza	F	Rua Miguel Ferreira de Melo Nº01	SP	Jd. Santo André	São Paulo	(11)98995-7815
160	161	Steven Ferreira	M	\N	SP	Aricanduva	São Paulo	\N
161	162	Maria Ivone Campos	F	Rua Baltazar Vidal Nº206	SP	Pq. Do Carmo	São Paulo	(11)95420-6919
162	163	Rosângela Souza	F	Rua João Gomes Pereira Nº953	SP	Jd. Tietê	São Paulo	\N
163	164	Eduardo Teixeira	M	Avenida Israel Fonseca Nº162	SP	Vila Ema	São Paulo	(11)981262983
164	165	João Antônio Freire	M	Rua Marcos Antônio Marques Nº36A	SP	Barueri	São Paulo	\N
165	166	Antônia Sanches	F	Rua Baltazar Vidal Nº220	SP	Pq. Do Carmo	São Paulo	(11095900-2374
166	167	Neves Silva	F	\N	SP	São Caetano	São Paulo	\N
167	168	Amanda Nogueira	F	\N	SP	Mogi das Cruzes	São Paulo	\N
168	169	Alex Silva	M	Avenida Francisco de Santa Maria Nº1219	SP	São Mateus	São Paulo	(11)98302-9588
169	170	Francisco Rocha Brito	M	Rua Jacundá Mimoso Nº19	SP	São Mateus	São Paulo	(11)95637-9826
170	171	Maria Alice Nunes	F	\N	SP	Moema	São Paulo	\N
171	172	Regina Cristina Almeida	F	\N	SP	Santa Figênia	São Paulo	\N
172	173	Daniela Basílio Silva	F	Rua Fernando Dias Paes Nº645	SP	São Mateus	São Paulo	(11)95148-7210
173	174	Danilo Pereira da Silva	M	Rua Forro das Pedras Nº901	SP	São Mateus	São Paulo	(11)9334-29291
174	175	Francisco Souza	F	\N	SP	São Mateus	São Paulo	\N
175	176	Maria Ines Jala	F	Av. Roberto Pires Maciel	SP	Mauá	São Paulo	(11)98426-7746
176	177	Bábara Kellen	F	Rua Santa Rosa Nº212	SP	Mauá	São Paulo	(11)95289-1037
177	178	Joyce Brambillo	F	Av. Sapopemba Nº28509	SP	São Mateus	São Paulo	(11)99733-6905
178	179	Nathalia Porto	F	Rua Felipe Marinete Nª366	SP	São Mateus	São Paulo	(11)96933-4109
179	180	Felicia Manoela Nunes	F	\N	SP	Franco da Roxha	São Paulo	\N
180	181	Adson F.(Representante)	M	\N	SP	Itaquera	São Paulo	\N
181	182	Laiane Fernandes	F	Avenida Dos Sertanista 1175B	SP	Jd. Santo André	São Paulo	(11)93372-6148
182	183	Beatriz Godoy	F	Rua Teresina Dos Santos Nº464	SP	Palmital	São Paulo	\N
183	184	Dinho Gomes	M	Rua Confideração dos Tomôes Nº397	SP	Iguatemi	São Paulo	(11)96236-7890
184	185	Mariele Ferreira	F	Rua Embaixador Ioldefonso Falcão Nº132	SP	São Mateus	São Paulo	(11)93012-5060
185	186	Fernando Soares	M	Av. Vila Ema Nº5621	SP	Vila Ema	São Paulo	(11)94710-3027
186	187	Alex Nery dos Santos	M	Rua Marcos Freire Nº1	SP	São Mateus	São Paulo	(11)95822-4990
187	188	Mayra Barros	F	Av. Dom Pedro I Nº392	SP	Santo André	São Paulo	(11)94011-7350
188	189	Helio Souza	M	Av Mateo Bei Nº7746	SP	São Mateus	São Paulo	\N
189	190	Evellyn Souza	F	Rua Torres Florencio E. Rieli Nº89	SP	São Mateus	São Paulo	(11)98655-8394
190	191	Beatriz Silva	F	Rua Batista Francisco Nº791	SP	Vila Formosa	São Paulo	(11)94016-8892
191	192	Geane Aparecida Garcia	F	Av. José Rodrigues Santarem Nº1135	SP	São Mateus	São Paulo	(11)99580-4858
192	193	Erica Lozano	F	Rua Major Paladino Nº510	SP	Lapa	São Paulo	(11)99995-3040
193	194	Danizete Leite	F	Rua Chantal Nº22	SP	Mauá	São Paulo	(11)95259-9467
194	195	Fernando Antero	M	Rua Benedito Leite Nº29	SP	Suzano	São Paulo	(11)99805-3899
195	196	Irene Silva	F	\N	SP	Santo André	São Paulo	\N
196	197	Larrisa de Paula	F	Rua Flores da Primavera Nº31	SP	São Mateus	São Paulo	(11)98139-7772
197	198	Julia Pedrosa	F	\N	SP	Guarulhos	São Paulo	(11)97479-3520
198	199	Liliane De Jesus	F	Rua Nova Brasília 69A	SP	São Paulo	São Paulo	(11)95299-4018
199	200	Antônio Bezerra	F	Rua Estrada da Adutora Rio Claro Nº3	SP	São Mateus	São Paulo	(11)97738-7054
200	201	Claudinei Gomes de Souza	F	Rua Confederação Dos Tamoios Nº397	SP	São Mateus	São Paulo	\N
201	202	Denise Ferreira	F	Rua Pedro de Castro Velho Nº478	SP	Jd. Santo André	São Paulo	(11)99171-2238
202	201	Janaina Moreira Ferreira	F	Avenida Sapopemba 14B	SP	São Mateus	São Paulo	(11)97984-6343
203	202	Jhony Moraes	F	\N	SP	Tatuapé	São Paulo	\N
204	203	Etevaldo Alexandre	M	\N	SP	\N	São Paulo	\N
205	204	Cristiane Correa	F	\N	SP	São Mateus	São Paulo	\N
206	205	Kleber De Souza Oliveira	M	\N	SP	São Mateus	São Paulo	(11)96070-4177
207	206	Suelen Vasconcelos	F	Rua Triste Berante Nº45	SP	São Mateus	São Paulo	(11)97444-4035
208	207	Letícia Oliveira	F	Travessa Tantos Caminhos Nº212	SP	São Mateus	São Paulo	(11)94903-7922
209	208	Jocelino Santos	F	Rua Passagem Eduardo Ledevim Nº56	SP	São Mateus	São Paulo	(11)98850-0758
210	209	Fábio José Silva	M	Rua Miguel Ferreira de Melo Nº73	SP	Jd. Santo André	São Paulo	(11)98974-0112
211	210	Priscila Ferras	F	Rua Tolstói de Carvalho Nº35	SP	Vila Tostói	São Paulo	(11)99178-8675
212	211	Claudio Martinho	M	\N	SP	Mauá	São Paulo	\N
213	212	Dionete Ferraz	F	\N	SP	São Mateus	São Paulo	\N
214	213	Agenor Alves de Freitas	M	Estrada do Carneiro Nº2923	SP	Mauá	São Paulo	(11)99690-6210
215	214	Shirley Cristina	F	Rua Everton Ressa Nº211	SP	Jd. Sapopemba	São Paulo	(11)97146-0908
216	215	Marcelo Araujo	M	Rua da Mooca Nº2505	SP	Mooca	São Paulo	(11)93302-1150
217	216	Rafael Silva	M	Avenida Rio das Pedras Nº4021	SP	Aricanduva	São Paulo	(11)98638-4853
218	217	Edilene Da Silva Severiano	F	Rua Antônio de Mendonça Nº15	SP	Mauá	São Paulo	(11)97173-7715
219	218	Viviane Oliveira Pereira	F	Rua Raimundo de Oliveira Nº240	SP	Santo André	São Paulo	(11)98620-5941
220	219	Fabrício Ferreira	M	Rua Vitório Azadia Nº547	SP	São Mateis	São Paulo	(11)97711-1512
221	220	Evandro Oliveira	M	Rua Nova Aliança Nº3	SP	Jd. Santo André	São Paulo	(11)99485-0832
222	221	Ingrid Lacerda Santos	F	Rua Roberto Park Nº55	SP	São Mateus	São Paulo	(11)98382-7258
223	222	Simone dos Santos	F	Rua Pedro Corte Real Nº132	SP	Mauá	São Paulo	(11)99689-0401
224	223	André Luiz Farias	M	Rua Flores da Primavera Nº38	SP	São Mateus	São Paulo	(11)94565-0052
225	224	Samey Da Silva	F	Rua Erva Imperial Nº595	SP	São Mateus	São Paulo	(11)96984-6704
226	225	Hugo Tiago Teixeira	F	Av. Sapopemba Nº23011	SP	São Mateus	São Paulo	(11)97391-1705
227	226	Demirio André	M	Rua Flora da Primavera	SP	São Mateus	São Paulo	\N
228	227	Joelma Lima	F	Rua Doutor Dan Nº111	SP	São Mateus	São Paulo	(11)98606-1552
229	228	Patrícia Rodrigues	F	\N	SP	Campinas	São Paulo	\N
230	229	Cleusa Ferreira	F	Rua Miguel Fernandes Nº74	SP	Tucuruvi	São Paulo	(11)944759097
231	230	Fabiana Reis	F	\N	SP	Monte Verde	Minas Gerais	\N
232	231	Nilda Nunes	F	Rua Paulo Sergio Nº14	SP	Vila Formosa	São Paulo	(11)95164-5394
233	232	Nadia Brito	F	Rua Confederação Dos Tamoios Nº342	SP	São Mateus	São Paulo	(69)99279-3343
234	234	Caio Gustavo	M	Rua Céu Azul Nº21	SP	Mauá	São Paulo	(11)98334-5304
235	235	Monaliza A.	F	\N	SP	São Mateus	São Paulo	\N
236	236	Cristiane Sampaio Aciolli	F	Av. Rio das Pedras Nº3524	SP	Aricanduva	São Paulo	(11)98105-4759
237	237	Elaine Cristina de Angela	F	\N	SP	Jaú	São Paulo	(14)99769-2502
238	238	Jeane Rodrigues	F	Rua Carlos Cossi Nº145	SP	São Mateus	São Paulo	(11)96611-4040
239	239	Higor Rocha	M	Rua Damoão Fernandes Nº105	SP	Barueri	São Paulo	(11)95485-8815
240	240	Caio Almeida Freire	M	\N	SP	São Mateus	São Paulo	(11)96870-1103
241	241	Liss Ferreira	F	Travessa Terras do Sul Nº168	SP	São Mateus	São Paulo	\N
242	242	Claudio de Jesus	M	\N	SP	São Mateus	São Paulo	(11)95109-7576
243	243	Juliano Flores Almeida	M	Rua Paulino CursI Nº577	SP	São Mateus	São Paulo	(11)96974-4874
244	244	Marcia Alves	F	Rua Paca Nº665A	SP	São Mateus	São Paulo	(11)95142-3615
245	245	Orlando Silva Souza	M	Avenida Luiz Pires de Minas Nº31	SP	Mauá	São Paulo	(11)94940-0878
246	246	Ronaldo Dias	M	Avenida Sapopemba Nº9044	SP	São Mateus	São Paulo	(11)94467-3637
247	247	Bianca Gomes	F	Rua Morro das Pedras Nº310	SP	São Mateus	São Paulo	(11)95434-8184
248	248	Daniela Santos Silva	F	Rua Frank Domingos Bochia Nº46	SP	Itaquera	São Paulo	(11)96016-8618
249	249	Crislene Vieira Nunes	F	Rua Manoel da Luz Drummond Nº630	SP	São Mateus	São Paulo	(11)93146-3425
250	250	Damabiah Lana Moraes	F	Rua Doutor José Higino Nº729	SP	Mooca	São Paulo	(11)99964-7112
251	251	Viviane Alves	F	Rua Jequitiba Branco Nº10	SP	Jd. Santo André	São Paulo	(11)93295-2325
252	252	Bruna Fagundes	F	Rua Boa Família Nº678	SP	São Mateus	São Paulo	(11)98897-3181
253	253	Luciana Alves	F	Rua Sargento Osvaldo Conceição Nº78	SP	Itaquera	São Paulo	(11)94886-9713
254	254	Marianilda de Andrade	F	Rua Vargas Nova Nº31	SP	Tiradentes	São Paulo	(11)95447-4435
255	255	Arinne Cavalcante da Silva	F	Rua Armada Cabralina Nº61	SP	Guaianases	São Paulo	(11)95015-3046
256	256	Lucas Alexandre	M	Rua Anny Nº1262	SP	Sacomã	São Paulo	(11)4059-4446
257	257	Fernando Martins	M	\N	SP	Barueri	São Paulo	\N
258	258	Nice Ferreira	F	Rua João Batista Conti Nº498	SP	São Mateus	São Paulo	(11)95912-0468
259	259	Luziane da Silva	F	Avenida Jasmine Nº29	SP	Guarulhos	São Paulo	(11)99420-4505
260	260	Caio Gonçalves	M	Travessa Sabor de Mim Nº19A	SP	São Mateus	São Paulo	(11)95216-5369
261	261	Ana Paula Santos	F	\N	SP	Ipiranga	São Paulo	\N
262	262	João Pedro Silva	F	Avenida Dos Sertanista 1176B	SP	Jd. Santo André	São Paulo	(11)98748-6593
263	263	Juliana Monteiro	F	Rua Touro Nº170	SP	São Mateus	São Paulo	(11)99105-8309
264	264	Danubia Silva Araujo	F	Rua 06 Quadra17 Lote07	GO	Portelânida	Góias	\N
265	265	Adriana Marreiros Alves	F	Rua Coronel Raul Costa Nº335	RJ	Itaperuna	Ro de Janeiro	(21)98839-8685
266	266	Eduardo Santos	M	Rua Francisco Matias Nº117A	SP	São Mateus	São Paulo	(11)94886-5039
267	267	José Maria Dos Santos	M	Rua do Campo Nº71	PB	Pitimbu	Paraíba	(85)98944-4484
268	268	Eliete Fernandes	F	Rua Agostinho de Magalhães Nº280	SP	São Mateus	São Paulo	(11)2015-8891
269	269	Betoldo Nunes	F	\N	\N	Mooca	São Paulo	\N
270	270	Luana Almeida	F	\N	SP	Tiradentes	São Paulo	\N
271	271	Sergio Ferreira	M	\N	SP	Vila Prudente	São Paulo	\N
272	272	Mônica Janaina dos Santos	F	Rua Calixto Fernandes das Neves Nº648	RJ	Barra de Macaé	Rio de Janeiro	(21)99847-9514
273	273	Fabiana Gomes Leal	F	Rua Iamante Júnior Nº513	MA	Açailândia	Maranhão	(99)99180-5473
274	274	Davi Souza	M	Rua Elísio Ferreira Nº88	SP	São Mateus	São Paulo	(11)93380-7526
275	275	Orlando(Representante)	M	\N	\N	Guarulhos	São Paulo	\N
276	276	Cícera Romano	F	Rua Pedro Ramazani Nº2000	SP	São Mateus	São Paulo	(11)94542-9006
277	277	Reinaldo Fernandes	M	Avenida Doutor Guilherme de Abreu Sodre Nº1492	SP	São Mateus	São Paulo	(11)91357-5173
278	278	Cristina Beltrano	F	\N	SP	Aricanduva	São Paulo	\N
279	279	Janilson F.	M	Rua Alcelmo Almeida Monteiro	SP	São Mateus	São Paulo	(11)95984-3444
280	280	Rodrigo Ferreira da Silva	M	Rua Rodolfo Corsi Nº234	SP	Rancharia	São Paulo	\N
281	281	Renan Souza	M	\N	SP	Guarulhos	São Paulo	\N
282	282	Sheila Cristina dos Santos da Costa	F	Rua Passagem de São Pedro Nº326	PA	Belém	Pará	\N
283	283	Juliana Cristina da Silva	F	Avenida José Velho Barreto Nº142	SP	São Mateus	São Paulo	(11)94008-0631
284	284	Jane Malveira Bianco	F	Rua Ettore Ximenes Nº350 Sl 04	SP	Vila Prudente	São Paulo	(11)97309-3112
285	285	Vanusa Santos	F	Rua Aldeia Maria Nº193	SP	Guaianases	São Paulo	(11)96398-4192
286	286	Geisa Cristina	F	Travessa Edith Evans Nº45	SP	Jd. Santo André	São Paulo	(11)95811-6617
287	287	Mônica Ferreira Silva	F	Rua Radical Norte Qd24 Lote15	MA	Açailândia	Maranhão	(99)99118-2997
288	288	Celi Patrício Lins	F	Av. Carioca Nº813	SP	Ipiranga	São Paulo	(11)98107-1980
289	289	Eduardo Nunes	M	Av. Nagib Farah Maluf Nº408	SP	Itaquera	São Paulo	(11)94489-2080
290	290	Joyce Santos	F	Av. Mateo Bei Nº2635	SP	São Mateus	São Paulo	(11)93801-6917
291	291	Lurdes Alves	F	Rua Felipe Castrin Nº251	SP	São Mateus	São Paulo	(11)98637-5994
292	292	Juliana Dos Anjos	F	Alameda Benfort Nº50	SP	Atibaia	São Paulo	(11)94594-8839
293	293	Barbara Aline Diogo da Silva	F	Rua Manoel Gervásio Nº158	MG	Pequeri	Minas Gerais	\N
294	294	Gil Raimundo	M	Rua Padre Luiz de Birquina Nº444	SP	São Mateus	São Paulo	(11)99847-2274
295	295	Manoel Souza	M	\N	SP	São Mateus	São Paulo	\N
296	296	Ornilda de Abreu	F	\N	SP	Tatuapé	São Paulo	\N
297	297	Betânia	F	Rua Delta Nº381	SP	Santana do Parnaíba	São Paulo	(11)97532-7002
298	298	Cássia Pelose	F	\N	SP	Jd. Santo André	São Paulo	\N
299	299	João Gabriel	M	Av. Alberto Lupo Nª2c	SP	Guarulhos	São Paulo	(11)98768-0921
300	300	Luzinete Rodrigues	F	Travessa São Sebastião Nº11	SP	Jd. Santo André	São Paulo	(11)99297-4620
301	301	Pâmela Lima	F	\N	SP	Moema	São Paulo	(11)96307-2605
302	302	Anderson de Andrade	M	Rua Sírios Nº49	SP	São Mateus	São Paulo	(11)95901-4184
303	303	Edvaldo Moraes	M	Rua Estrada dos Fidelis Nº97	SP	Jd. Santo André	São Paulo	\N
304	304	Geisa Paulino de Melo	F	Rua Amalia Cordelli Cardenoto Nº31	SP	São Mateus	São Paulo	(11)98559-4062
305	305	Felipe Santos da Silva	M	\N	SP	São Mateus	São Paulo	(11)96837-6650
306	306	Angélica Ferreira	F	Rua Manoel de Abreu Nº26	SP	Ferraz de Vasconcelos	São Paulo	(11)91025-6560
307	307	Geraldo Carlos Prestes	M	\N	SP	São Mateus	São Paulo	\N
308	308	Wesley Bittencourt	F	\N	SP	\N	São Paulo	(11)99940-0893
309	309	Angela Maria de Fátima	F	Av. Moraes Costa Nº108 Sala 5	SP	Santo André	São Paulo	(11)95757-5421
310	310	Cilene Ribeiro Alves	F	Av. Vila Ema Nº2349	SP	Vila Ema	São Paulo	(11)96522-5888
311	311	Rafael Moreira	M	\N	SP	Tiradentes	São Paulo	\N
312	312	José Leandro Bueno	M	Rua Domisiano Rossi Nº630	SP	São Mateus	São Paulo	(11)99194-9639
313	313	Douglas Campos	M	Rua Doutor Felice Buscaglia 397	SP	São Mateus	São Paulo	\N
314	314	Larissa Conceição dos Santos	F	Rua Doutor José Higino Nº890	SP	Mooca	São Paulo	(11)98501-5809
315	315	Silvana Simplicio	F	Av. Cláudio Augusto Fernandes Nº754	SP	São Mateus	São Paulo	(11)98440-7406
316	316	Maria das Graças dos Santos	F	Rua Tomé da Rocha Nº67	SP	Santo André	São Paulo	(11)99517-2348
317	317	Alana Cristina	F	\N	SP	São Mateus	São Paulo	(11)96197-3030
318	318	Mary Barbosa	F	Rua Manoel Rebelo Nº126	SP	São Mateus	São Paulo	(11)95199-9520
319	319	Lucas De Oliveira Almeida	M	Rua Cacapava Nº07	ES	Piúma	Espirito Santo	(28)99914-7036
320	320	Natalia Nazar da Silva	F	Rua Bnadeira de Aracambi Nº430	SP	São Mateus	São Paulo	(11)98436-8091
321	321	Jurandir Freitas (Representante)	M	\N	SP	Itaquera	São Paulo	\N
322	322	Thiago Barbosa	M	Rua Felipe Marinete Nª324	SP	São Mateus	São Paulo	(11)98226-8063
323	323	Isabel M.	M	\N	SP	Santo André	São Paulo	\N
324	324	Jhonatas Freire	M	Rua Maria Luiza Val Penteado Nº495	SP	São Mateus	São Paulo	\N
325	325	Joana Dark	F	Av. Sapopemba Nº 7841	SP	Tatuapé	São Paulo	(11)97982-4055
326	326	Cida Oliveira	F	Rua Alexandre Albriv Nxº121	SP	Sapopemba	São Paulo	(11)96835-5829
327	327	Anderson Nunes	M	Av. Sapopemba Nº14519	SP	Sapopemba	São Paulo	(11)96543-4452
328	328	Tiago Queiroz	M	Av. Celso Garcia Nº3474	SP	Tatuapé	São Paulo	(11)985422762
329	329	Marcia Ferreira	F	\N	SP	Suzano	São Paulo	\N
330	330	Mayara Fernandes	F	Avenida Ettore Nº790	SP	Ribeirão Pires	São Paulo	\N
331	331	Ana Paula Almeida	F	Rua dos Santana Nª35	SP	Jd. Santo André	São Paulo	(11)98288-6490
332	332	Lais Siqueira	F	Travessa Maria Padilha Nº12	SP	São Mateus	São Paulo	\N
333	333	Mikaela F.	F	Rua Getulina Nº66	SP	Guianases	São Paulo	(11)95937-2139
334	334	Renan Lima	M	\N	SP	São Mateus	São Paulo	\N
335	335	Aline de Aguiar	F	Rua das Figueiras Nº2780	SP	Santo André	São Paulo	(11)98455-7182
336	336	Claudia Menezes	F	Rua Doutor Felice Buscaglia 608	SP	São Mateus	São Paulo	\N
337	337	Raquel Moreira de Alcantra	F	Rua Dr. Edmur Whitaker Nº670	SP	São Mateus	São Paulo	(11)95609-5155
338	338	Patrícia Branger	F	Rua Eurico Eloi Marcelino Nº225	PR	Santa Tereza do Oeste	Paraná	(45)99906-1728
339	339	Kleber de Souza	M	\N	SP	São Mateus	São Paulo	(11)96070-4177
340	340	Claudia Mota Paixão	F	Rua Joaquim Abreu luz Nª338	SP	Pq. São Lucas	São Paulo	(11)99271-5771
341	341	Rogério Carvalho	M	Rua Padre Gabriel Malagrida Nº19	SP	Mauá	São Paulo	(11)96548-5605
342	342	Adriana Santana	F	Rua André Fernandes Nº138	SP	Guarulhos	São Paulo	(11)94240-1318
343	343	Lizandra Souza	F	\N	SP	São Mateus	São Paulo	\N
344	344	Jessica Rodrigues	F	Rua Bartolomeu Correia Bueno Nº134	SP	Pq. São Lucas	São Paulo	\N
345	345	Jessica Gonçalves da Silva	F	Rua Antão Leme da Silva Nº202	SP	Itaquera	São Paulo	(11)97992-6765
346	346	Denilson Manoel de Lima	M	Rua Venturosa Nº381	PE	Paulista	Pernambuco	(81)98524-4935
347	347	Janete ( Representante)	F	\N	SP	Itaquera	São Paulo	\N
348	348	Andreia L.	F	Rua Liberato Barroso Nº162	SP	São Mateus	São Paulo	(11)97588-6073
349	349	Glecia Vieira	F	Av. Roney Clube Nª1211	SP	São Bernardo do Campo	São Paulo	\N
350	350	João Almeida de Freitas	M	\N	SP	Cotia	São Paulo	\N
351	351	Nilson Vieira	M	Rua Itinga Nº48	SP	São Mateus	São Paulo	(11)98216-5715
352	352	Rosineide Alves	F	Rua Guido Frederica Nº10	SP	São Paulo	São Mateus	(11)95335-5852
353	353	Daniele Ferreira	F	\N	SP	São Paulo	Santo André	\N
354	354	Bruno Almeida de Melo	M	\N	SP	São Paulo	São Mateus	\N
355	355	Maria Cleciane Queiroz dos Santos	F	Av. Dos Sertanistas Nº1967	SP	São Paulo	São Mateus	(11)97083-1504
356	356	Marcelo Paixão	M	Rua Luiz de Oliveira Bulhões Nº518	SP	São Paulo	São Paulo	(11)94545-1176
357	357	Graziela Cristina	F	Rua Ascabuz Nº206	SP	São Paulo	\N	\N
358	358	Marli A.	F	\N	SP	São Paulo	São Mateus	\N
359	359	Norma Ferreira	F	Rua Itacoatiara Nº231	SP	São Paulo	Santo André	\N
360	360	Roney Ferreira da Proença	F	Rua Major Sertório Nº561	SP	São Paulo	Faria Lima	(11)96355-8854
361	361	Damiana Lourenço	F	Rua Dom Diogo Furtado Nº180	SP	São Paulo	São Mateus	(11)95457-2678
362	362	Verônica (Representante)	F	Av. Maria Cursi Nº985	SP	São Paulo	São Mateus	(11)95457-2679
363	363	Walne(Representatnet)	M	\N	SP	São Paulo	São Mateus	\N
364	364	Andreia M.	F	Rua Oronzo Mastrokosa Nº71	SP	Vila Ema	São Paulo	(11)98374-5138
365	365	Alzira Nunes	F	\N	SP	São Paulo	São Mateus	\N
366	366	Lucas Henrique	M	Rua Guido Frederica Nº20	SP	Itaquera	São Paulo	(11)96440-4139
367	367	Dário Pereira de Souza Junior	M	Rua Sorocaba Nº08 Loja 2	RJ	Rio de Janeiro	Rio de Janeiro	\N
368	368	Cleber Fernandes	M	Rua Beira Rio Nº64	SP	Jd. Santo André	São Paulo	(11)96070-4177
369	369	Alex Santana Carvalho	M	Rua Adelar Maria de Andrade Nº231	BA	Porto Seguro	Bahia	(73)99975-4758
370	370	Kelly Andradae	F	Rua Eldorado Nº473	SP	São Caetano do Sul	São Paulo	(11)95798-4585
371	371	Inael(Representante)	M	\N	SP	São Paulo	São Paulo	\N
372	372	Fábio José de Carvalho	M	Rua Raimundo Fernandes da Silva Nº735	PI	Esperantina	Piauí	(86)98117-6382
373	373	Neci Almeida	F	Rua Luiz Guidiei Nº694	SP	São Mateus	São Paulo	(11)95131-3811
374	374	Lorena Prado	F	Rua Netuno Nº113	SP	São Mateus	São Paulo	(11)99703-806
375	375	Lucas Gabriel S. Costa	M	Rua Domenico Alberti Nº121	SP	São Mateus	São Paulo	(11)95236-5155
376	376	Paulo André Siqueira Mendes	M	Estrada Embaixador São Vicente Nº284	RJ	Rio de Janeiro	Rio de Janeiro	(22)98801-6001
377	377	Marluce Silva	F	Avenida Bassamo Del Grappa Nº220	SP	Aricanduva	São Paulo	(11)94119-8948
378	378	Talita Paraiso	F	Rua Dona Carmela Nº245	SP	Jd. Grimaldi	São Paulo	(11)96462-5839
379	379	Micaele Santos Maria	F	Rua Carlos Coccia Nº106	SP	São Mateus	São Paulo	(11)95354-8871
380	380	Roque Martins	M	\N	SP	Santo André	São Paulo	(11)96712-7112
381	381	Leda Maria de Souza	F	Rua Pastor Agenor Diniz Nº178	SP	São Mateus	São Paulo	(11)95869-2375
382	382	Rosângela Martins	F	\N	SP	São Mateus	São Paulo	\N
383	383	Phillipe Ferreira (Representante)	M	\N	PA	Altamira	Pará	\N
384	384	Roberta Ferreira	F	\N	SP	São Mateus	São Paulo	\N
385	385	Miqueias Pinheiro	F	Rua Ettore Andreazza Nº363	SP	São Mateus	São Paulo	(11)99563-5264
386	386	Noelle Cristini Dourado	F	Rua Lirio do Vale Nº385	SP	Sapopemba	São Paulo	(11)98703-3902
387	387	Neusa Stevem	F	Rua Gedge Beckeby Nº7	SP	São Mateus	São Paulo	\N
388	388	Zulmira Lima	F	\N	SP	São Mateus	São Paulo	\N
389	389	Ana Cláudia Freitas	F	Av. Sapopemba	SP	Jd. Santo André	São Paulo	(11)95988-0890
390	390	Graziele Da Silva Brandão	F	Rua Orlando Teles Nº45	SP	Itapevi	São Paulo	(11)99517-1076
391	391	Derik F.	M	Rua Francisco de Paula Nº42	SP	Vila Formosa	São Paulo	(11)93957-5094
392	392	Vieto Costa Gomes	F	Rua Tavares Nª46	SP	Lauzane Paulista	São Paulo	(11)93012-9128
393	393	Elisangela Alves Selaris	F	Av. Sapopemba Nº5570	SP	Sapopemba	São Paulo	(11)95127-5106
394	394	Lucas Nascimento	M	Rua Antônio Carllas Dalla Nº435	SP	São Carlos	São Paulo	\N
395	395	Shirley da Silva	F	Rua Campo de Piratininga Nº336	SP	Jd. Santo André	São Paulo	(11)98873-2887
396	396	Elen Regina de Oliveira	F	Rua Travessa Augusto Baron Nº161	RS	Rio Claro	Rio de Grande do Sul	\N
397	397	Larissa Yara Gomes	F	Rua Domingos Rubino Nº359	SP	Itaquera	São Paulo	(11)97634-8424
398	398	Rose R.	F	Rua Tenente Lauro Sodré Nº1398	SP	São Mateus	São Paulo	(11)94863-1253
399	399	Adenilda N.	F	Rua Serra Navio Nº785	SP	São Mateus	São Paulo	(11)93602-0161
400	400	Rose Machado	F	Rua José Francisco Dos Santos	SP	São Mateus	São Paulo	(11)95811-2159
401	401	Karen Fernanda Mendes	F	Rua José Ricardo Pagionotto Nº215	SP	Quatá	São Paulo	(19)99802-7401
402	402	Ednalva Carneiro	M	Estrada Santa Marinha Nº59	RJ	Rio de Janeiro	Rio de Janeiro	\N
403	403	Ulivandia Moreira Silva	F	Rua Serra do Mar Nº865	MG	Ipatinga	Minas Gerais	(31)98604-3951
404	404	Vera Lúcia Ferras	F	Rua Ipiranga Nº80	SP	Santo André	São Paulo	(11)97689-0508
405	405	Josy De Jesus Nascimento	F	Rua Henrique Mazalte Nº530	SP	São Mateus	São Paulo	(11)94774-4502
406	406	Dineia Maria Ribeiro Soares	F	Rua Arlindo Neves Nº346	MG	Muriaé	Minas Gerais	\N
407	407	Jorge Nunes	M	Travessa Zasueira Nº68	SP	São Mateus	São Paulo	(11)98527-4827
408	408	Suzane Lacerda Dantas	F	Rua Sul Nº206	TO	Araguaiana	Tocantis	(63)99209-2012
409	409	Ellen Kellen Virginia da Silva	F	Rua Joaquim de Queiroz Nº233	RJ	Rio de Janeiro	Rio de Janeiro	(27)98577-8561
410	410	Roberta Nascimento	F	Travessa Nogueria Nº68	SP	São Mateus	São Paulo	(11)94880-8768
411	411	Josuel Rodrigues da Silva Junior	M	Rua Vitoriano Pereira Nº105	SP	Mooca	São Paulo	(11)96429-1976
412	412	Bianca Costa	F	Rua Soldado Teonilio de Souza Nº110	SP	Vila Ema	São Paulo	(11)95877-9066
413	413	Lúcia Araujo do Nascimento	F	Rua Prof. Brazílio Barni Nº160	SP	São Mateus	São Paulo	(11)96717-5501
414	414	Jussara de Souza Campos	F	Rua das Palmeiras Nº168	PB	Cabedelo	Paraíba	(65)99244-6557
415	415	Anides Bispo de Oliveira	F	Travessa Sol do Girassol Nº131	SP	São Mateus	São Paulo	(11)99747-1182
416	416	Gildania Leonilda Souza	F	Travessa Benedito Costa Gomes Nº42b	SP	Sapopemba	São Paulo	(11)97012-8681
417	417	Júlio Cesar Sabioni	M	Rua Serra de Botucatu	SP	Tatuapé	São Paulo	(11)97616-2189
418	418	Mariana Pessoa da Silva	F	Rua Teodora Oliveira Nº346	SP	Itaquera	São Paulo	(11)95956-9950
419	419	Solange Da Silva Dias	F	Rua Abner de Souza e Silva Nº27	SP	São Mateus	São Paulo	(11)99943-8548
420	420	Karolen Kamila Mendes da Rocha	F	Av do Açai Nº704	AP	Morada dos Palmeiras	Macapá	(96)99166-6443
421	421	Paula Bianca de Souza Resende	F	Ria Moreira da Rocha Nº45	MG	Resende da Costa	Minas Gerais	(32)99939-4024
422	422	Cleideana Leão	F	Av. Brigadeiro Faria Lima Nº1257 Loja 4	SP	São Paulo	São Paulo	(11)98589-9450
423	423	Liu Tmashiro	F	Rua Cristovão de Oliveira Nº75a	SP	São Mateus	São Paulo	\N
424	424	Carla de Souza	F	Rua Pangava Nº43	SP	São Paulo	São Paulo	(11)99116-7882
425	425	Sidney Ferreira	M	Rua Amazonas Nº22	SP	São Mateus	São Paulo	(11)95360-8567
426	426	José Carlos Freitas	M	\N	SP	São Mateus	São Paulo	(11)95899-0456
427	427	Marilia Antunes	F	\N	SP	São Mateus	São Paulo	\N
428	428	José Carlos Almeida Henrique	M	\N	AL	Maceió	Alagoas	\N
429	429	Fabiana Gomes dos Santos	F	Rua Aristides Milton Nº453	BA	Itapuã	Bahia	\N
430	430	Vanessa Ferreira de Almeida	F	Rua Luiz Barbalho Nº255	BA	Olinda	Bahia	(81)98340-5274
431	431	Angelina Da Silva Cordeiro	F	Rua Giovanni Da Coegliano Nº426	SP	Guarulhos	São Paulo	\N
432	432	Laudete Rocha	F	Rua José Joaquim Nº31	SP	São Mateus	São Paulo	(11)96754-7240
433	433	Leonardo (Estação 011)	M	\N	SP	São Mateus	São Paulo	(11)94034-5592
434	434	Tatiana Lourenço	F	Rua Nova Bahia Nº69	SP	São Mateus	São Paulo	(11)96702-6689
435	435	Karen Figuereido	F	Rua Bandeira do Sul Nº307	SP	São Mateus	São Paulo	(11)98688-0838
436	436	Nicolas Perrini	M	Rua Principal Nº26a	SP	Perus	São Paulo	(11)94002-3079
437	437	Neila Cruz de Castro	F	Rua Goiás Nº307	BA	Araci	Bahia	(75)99240-3500
438	438	Tayna Nunes	F	\N	SP	Diadema	São Paulo	\N
439	439	Evelyn Silva	F	Av. Manoel Velho Moreira Nº1178A	SP	São Mateus	São Paulo	(11)96181-9783
440	440	Dinho Nunes	M	Rua Corrego Dias Pequeno Nº403	SP	São Mateus	São Paulo	\N
441	441	Ana Carolina de Lima Souza	F	Rua dos Geografo Nº80A	SP	Embu das Artes	São Paulo	(11)98618-1068
442	442	Maria do Carmo Silva	F	Rua Takaominari N º18	SP	Jardim Santo André	São Paulo	(11)99712-5377
443	443	Natalia de Lima e Silva	F	Rua Domingos Rosália Nº289	SP	São Paulo	São Paulo	(11)96628-3160
444	444	Maria Aparecida de Almeida	F	Av. Getúlio Vargas Nº801	SP	São Bernardo do Campo	São Paulo	(11)96275-0613
445	445	Nathally Cristiny Silva	F	Travessa Selassie Nº92	SP	São Mateus	São Paulo	(11)98872-9042
446	446	Malba Delian Assis Belfort	F	Rua Tinoco Valente Nº155	RO	Boa Vista	Roraima	\N
447	447	Tanylia Josélia Almeida dos Santos	F	Rua Guianazes Nº880	SP	Lençois Paulista	São Paulo	\N
448	448	Cleuza Maria de Almeida Santos	F	Rua Tomas Beneviete Nº9A	SP	Palheireiros	São Paulo	(11)97362-9567
449	449	Luciane Maria Alves Martins	F	Rua São Geraldo Nº37	SP	São Mateus	São Paulo	(11)95456-6966
450	450	Juliana Gomes Vieira	F	Rua Pedro Ramazani Nº123	SP	Jardim Santo André	São Paulo	(11)98915-2439
451	451	Maria Eulina Almeida Vieira	F	Rua Diomedes Lobo Nº732	PB	Catolé da Rocha	Paraíba	\N
452	452	Janete Fidelis da Costa	F	Rua Siqueira Bueno Nº2271	SP	Mooca	São Paulo	(11)98906-8285
453	453	Lucas Veraneio	M	Rua Campos do Jordão Nº15	SP	Sapopemba	São Paulo	(11)96414-7361
454	454	Narjara de Andrade	F	Rua Helio Farias de Mendonça	RS	Rio Bonito	Rio de Janeiro	\N
455	455	Jéssica Santos	F	Rua Salvia Nº21	SP	Guarulhos	São Paulo	(11)93435-1331
456	456	Valdemir de Souza Rufino	M	Rua Babilônia Nº10	SP	Ribeirão Pires	São Paulo	(11)97582-1427
457	457	Pelé Almeida Martins	M	Rua Padre João Nº41	SP	Penha	São Paulo	\N
458	458	Juliete Pereira Ribeiro	F	Rua Principal Nº28a	SP	Perus	São Paulo	\N
459	459	Gisele Ferreira Samavilla	F	Rua Flavio Boanowski Nº487	RS	Capão da Canoa	Rio Grande do Sul	(55)98457-9504
460	460	Aline Candido da Silva	F	Rua Gonçalo Nunes dos Santos	MS	Bela Vista Pontes e Lacerda	Mato Grosso do Sul	(55)99349-1001
461	461	Adriana Rose Pereira	F	Rua Angelo de Candia Nº1127	SP	São Mateus	São Paulo	(11)96036-2281
462	462	Mayza Monteiro	F	Rua Takaominari N º61	SP	São Mateus	São Paulo	(11)90145-4073
463	463	Maycon Cicero Amaral	M	Rua Tânia Nº61	SP	Jardim Santo André	São Paulo	(11)98253-4333
464	464	Nadya Albuquerque	F	Rua Abner Ribeiro Borges Nº211	SP	São Mateus	São Paulo	(11)95464-0604
465	465	Fabiana Aparecida Maria de Oliveira	F	Rua Manoel Ferreira Festas Nº188	SP	São Vicente	São Paulo	(13)99161-9530
466	466	Milca Vieira da Silva	F	Rua Simão Nunes	SP	Sapopemba	São Paulo	(11)97743-2422
467	467	Márcia Andrea da Silva	F	Rua General Synzeno Sarmento Nº1214	SP	Osasco	São Paulo	(11)98647-9906
468	468	Leandro Nunes	M	Av. das Nações nº641	SP	Santo André	São Paulo	(11)99649-4873
469	469	Luzia Patrícia Silva Nogueira	F	Rua Barão do Rio Branco Nº1307	PA	Xinguará	Pará	\N
470	470	Suziana Mendes	F	Av. Marginal do Oratório Nº18	SP	Santo André	São Paulo	(11)94921-4890
471	471	Rosineide Machado Mariano	F	Rua Jim Baku Nº1	SP	São Mateus	São Paulo	(11)97962-3600
472	472	Jéssica de Mendonça Lima	F	Rua João de Barros Nº5	RJ	Rio de Janeiro	Rio de Janeiro	(21)99115-8008
473	473	Dayane Cristine de Souza	F	Av. Caititu Nº1320	SP	Itaquera	São Paulo	(11)94590-5413
474	474	Ramon Alves	M	Rua Felipe Angeli Nº44	SP	Mauá	São Paulo	(11)97115-7607
475	475	Matheus Lucas Nunes da Silva	M	Rua Benício Oliveira Lima	PB	João Pessoa	Paraíba	\N
476	476	Andreia L.	F	Rua Cláudio Augusto Fernandes	SP	São Mateus	São Paulo	\N
477	477	Salatiel Figueireido	M	Rua João Antunes Maciel Nº227	SP	São Mateus	São Paulo	(11)99162-5712
478	478	Genilda Teixeira	F	Rua Redução de Guaranbaré N182	SP	Mauá	São Paulo	(11)98575-2281
479	479	Tatiane Aparecida de Lima	F	Rua Leopoldo Felix Nº437	SP	São Mateus	São Paulo	(11)98120-4240
480	480	Ediane Silva	F	Rua Violeta Nº103	SP	Jardim Santo André	São Paulo	\N
481	481	Jade de Almeida	F	Rua Lagoa da Prata Nº242	SP	Itaquera	São Paulo	(11)97734-4534
482	482	Douglas Richard de Jesus Pereira	M	Rua Ofelina Chaves de Meireles Nº562	SP	São Vicente	São Paulo	(13)97409-5940
483	483	Adalgisa Pereira	F	Rua Itapark Nº1590	SP	Mauá	São Paulo	(11)97672-4120
484	484	Rodolfo Santos	M	Rua Bandeira de Aracabina Nº323	SP	São Mateus	São Paulo	(11)98230-9037
485	485	Yvan Sanon	M	Rua Flore da Primavera Nº253	SP	São Mateus	São Paulo	(11)9806-8167
486	486	Ramon Hiat Magalhães	M	Rua Rafael Cazzotino Nº116	RJ	Magé	Rio de Janeiro	\N
487	487	Maria Helena Godoy Machado	F	Rua Boa Vista Nº3056	MS	Aparecida do Taboado	Mato Grosso do Sul	\N
488	488	Laís Marília de Almeida	F	Rua Ursula Paulino Nº1804	MG	Belo Horizonte	Minas Gerais	\N
489	489	Maria Ivonete	F	Rua Redução de Guaranbaré N395	SP	Mauá	São Paulo	(11)99403-6556
490	490	Eduardo dos Santos	M	Rua Francisco Matias Nº117A	SP	Sapopemba	São Paulo	(11)94886-5039
491	491	Andreia Caroline de Mattos Silva	F	Rua José Alencar Nº84	SP	Marília	São Paulo	(14)99690-5039
492	492	Lucas Alexandre	M	Rua Anny Nº1262	SP	Sacomã	São Paulo	(11)94059-4456
493	493	Lúcia Maria de Teodoro de Jesus	F	Rua Mundo Novo Nº34B	BA	Camaçari	Bahia	(71)98879-3279
494	494	Brenda Cardoso	F	Rua Adiles Peixoto Nº283	RS	Tapés	Rio Grande do Sul	\N
495	495	Beatriz Ribeiro	F	Rua dos Bibliotecários Nº257	SP	Itaim Paulista	São Paulo	\N
496	496	Izildinha de Souza Crivano Sales	F	Rua Benidito Nº527b	SP	Guarulhos	São Paulo	(11)9255-9189
497	497	Jéssica da Silva Rodrigues de Fraga	F	Avenida Placido Mattin Nº2301	RS	Viamão	Rio Grande do Sul	(51)9789-3559
498	498	Andreia Silva Costa	F	Rua Alagoas Nova Nº1321	MA	Imperatiz	Maranhão	\N
499	499	Alessandra Bourguignon Costa	F	Rua Simão Bassuil Nº222	ES	Piúna	Espirito Santo	\N
500	500	Lucicleide Oliveira	F	Rua Candecia Nº97	SP	São Mateus	São Paulo	(11)95494-0188
501	501	Thiago Monteiro	M	Rua James Naves Nº351	SP	São Mateus	São Paulo	(11)98367-1959
502	502	Daniela Silveira Guimarães	F	Rua Sival Hoff Pereira Nº330	RS	Barra do Ribeiro	Rio Grande do Sul	(51)99215-0093
503	503	Anderson Arias de Souza	M	Rua Leonardo Cerveira	SP	Morumbi	São Paulo	(11)99497-5825
504	504	Cristina Minelavina	F	Rua José Vidal Nº110	SP	Itaquera	São Paulo	(11)98728-0736
505	505	Iasmim Milena Martins da Silva	F	Rua Juscelino Kubitschek Nº50	PE	Vitória de Santo Antão	Pernambuco	(81)98667-6066
506	506	Ronise de Lima	F	Rua 20 de Setembro Nº2010	RS	Soledade	Rio Grande do Sul	(55)99672-7963
507	507	Gabriela Carvalho da Conceição	F	Rua dos Trabalhadores Nº643	MA	Imperatiz	Maranhão	\N
508	508	Camila de Macedo	F	Rua Morumbiaba Nº1016	SP	Itaquera	São Paulo	(11)95531-5358
509	509	Marcelo(Representante)	M	\N	SP	Aricanduva	São Paulo	\N
510	510	Lady Daiane	F	Rua José Francisco Dos Santos Nº771	SP	São Mateus	São Paulo	(11)94821-7266
511	511	Margarete Fidelis	F	Rua Fernando Falcão Nº872	SP	Mooca	São Paulo	(11)94815-1555
512	512	Talita Melo	F	Rua Joaquim Meira Siqueira Nº807	SP	Itaquera	São Paulo	(11)98641-0955
513	513	Raimundo Freitas	F	Rua Barros Peteado Nº361	SP	São Mateus	São Paulo	(11)99178-9031
514	514	Israel Martins	M	Rua Joaquim Pinheiro Nº14	SP	Vila Ema	São Paulo	(11)91031-8977
515	515	Hélio Freitas( Representante)	M	\N	SP	São Mateus	São Paulo	\N
516	516	Maria Lucia Martina	F	Rua Curumartins Nº76	SP	São Mateus	São Paulo	(11)95278-8021
517	517	Diessica Jocasta Toebe	F	Rua Dom Guilherme Muller Nº1153	RS	Arroio do Tigre	Rio Grande do Sul	(11)99752-4747
518	518	Bianka Bianche	F	Rua Alberto de Macedo Nº240	SP	Aricanduva	São Paulo	(11)98436-9366
519	519	Jennifer Coelho Carmago	F	Rua Iguarapé das Missões Nº29	SP	Tiradentes	São Paulo	(11)98076-9933
520	520	Rita Maria	M	Rua Alexandre Crapolli Nº125	SP	São Mateus	São Paulo	(11)96323-8815
521	521	Silmara Lopes	F	Rua Doutor Felice Buscaglia Nº467	SP	São Mateus	São Paulo	(11)97068-4460
522	522	Juliana Aparecida dos Reis Rufino	F	Rua Natalino Pena Nº347	SP	Araçatuba	São Paulo	(18)99121-4936
523	523	Jucilene C. Da Silva	F	\N	SP	São Mateus	São Paulo	\N
524	524	Feliciana Rute Silva de Mascena	F	Rua Frei Miguel Nº24	BA	São Francisco do Conde	Bahia	(71)98240-9966
525	525	Naiara Gonçalves Carmargo	F	Rua São Nicolau Nº776	RS	Novo Hamburgo	Rio Grande do Sul	(48)99834-7316
526	526	Tatiana Cimas Mendes	F	Rua Lavineiro de Arruda Falcão Nº1071	SP	Araraquara	São Paulo	(16)99707-4042
527	527	Katia Janaina Marques Mota	F	Av. Doutor Carlos Gueiros Leite Nº4328	PE	Paulista	Pernambuco	(81)98606-3120
528	528	Luana Santos Fernandes	F	Av. Julio Bueno Nº1588	SP	Guarulhos	São Paulo	(11)95208-2780
529	529	Ana Caroline Alves de Carvalho	F	Rua Inhamã Nº5585	PI	Teresina	Piauí	(86)99573-5755
530	530	Jéssica Pinto Silva	F	Rua Edgar Pinto César Nº23	SP	São Mateus	São Paulo	(11)98577-6452
531	531	Williane Pinto	F	\N	SP	Grajaú	São Paulo	\N
532	532	Lucas Vinicíuis de Morais	M	Av. Rio Tocantis Nº52	MG	São Gotardo	Minas Gerais	\N
533	533	Erik Flávio Santos	M	Rua Dores de Campos Nº456	SP	Guarulhos	São Paulo	\N
534	534	Igor Orneles	M	Rua Coleta Saaf Nª86	SP	Cotia	São Paulo	(11)94392-5992
535	535	Beatriz Eduarda Ribeiro	F	Rua Resedes Nº60	SP	Socrro	São Paulo	(19)99394-5301
536	536	Juliana Pereira Gonçalves	F	Av. Estrada dos Alvarengas Nº7862	SP	São Bernardo do Campo	São Paulo	(11)95924-9364
537	537	Gessica Caroline Dos Santos Leite	F	Rua Duzentos e Vinte e dois Nº166	SE	Nossa Senhora do Socorro	Sergipe	(79)99921-3442
538	538	Meire Ferreira	F	Rua Roberto Park Nº705	SP	São Mateus	São Paulo	(11)98171-8328
\.


--
-- Data for Name: dim_pagamento; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dim_pagamento (sk_pagamento, forma_pagamento, canal_venda) FROM stdin;
1	PIX	Online
2	Cartão Crédito	Marketplace
3	Boleto	Loja Física
4	Débito	Site
\.


--
-- Data for Name: dim_produto; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dim_produto (sk_produto, id_produto, nome_produto, categoria, fornecedor, valor_unitario) FROM stdin;
1	2	Oxidante 30	Cosméticos	Itallian Collor	46.00
2	3	Coloração	Cosméticos	Itallian Collor	22.00
3	4	Oxidante 20	Cosméticos	Itallian Collor	46.00
4	5	Shampoo 1L Trivitt	Cosméticos	Itallian Collor	90.00
5	6	Lavatório Compacto Cuba Fibra	Lavatório	Vandão	1700.00
6	7	Console Plus	Móveis MDF	Edgar	550.00
7	8	Nicho Expositor 4 Vãos	Móveis MDF	Edgar	300.00
8	9	Carrinho Auxiliar 4 Gavetas	Móveis MDF	Edgar	500.00
9	10	Aquecedor 220v	Acessórios	Enok	100.00
10	11	Mesa Simples Manicure	Móveis MDF	Edgar	200.00
11	12	Ciranda Manicure Scarlet	Manicure	Ivair	400.00
12	13	Mesa Star Manciure	Móveis MDF	Edgar	450.00
13	14	Cadeira Elegance Rec. Base Quadrada	Cadeiras	Val	1490.00
14	15	Cuba de Fibra	Acessórios	Enok	300.00
15	16	Reparador de Pontas	Cosméticos	Itallian Collor	29.00
16	17	Hidratação Triviit 250g	Cosméticos	Itallian Collor	37.00
17	18	Pó Descolorante 300g	Cosméticos	Itallian Collor	50.00
18	19	Hidratação Itallian 2kg	Cosméticos	Itallian Collor	100.00
19	20	Cadeira Elegance Arredonda Rec. Base Quadrada	Cadeiras	Val	1890.00
20	21	Console Retty 1.35m	Móveis MDF	Edgar	490.00
21	22	Toalheiro Vertical 	Móveis MDF	Edgar	665.00
22	23	Lavatório Elegance Cuba de Louça Branca	Lavatório	Val	2490.00
23	24	Carrinho Auxiliar 3 Gavetas	Móveis MDF	Edgar	420.00
24	25	Máquina de Corte Galletz	Acessórios	Rei da Máquinas(Rogério)	290.00
25	26	Carrinho Auxiliar 2 Gavetas 1 Porta	Móveis MDF	Edgar	350.00
26	27	Lavatório Italiano	Lavatório	Enok	690.00
27	28	Sofá Confort	Manicure	Ivair	390.00
28	29	Cadeira Futurama	Cadeiras	Ivair	850.00
29	30	Cadeira Elegance Fixa Base Quadrada	Cadeiras	Val	1390.00
30	31	Toalhas	Acessórios	Deca	10.00
31	32	Tesoura de Corte	Acessórios	Mofashi	100.00
32	33	Capa de Corte 	Acessórios	Mofashi	20.00
33	34	Cadeira Elegance Rec. Base Pentapé	Cadeiras	Val	1699.99
34	35	Segredo Cabeleireiro Trivitt	Cosméticos	Itallian Collor	72.00
35	36	Base Inovattor	Cosméticos	Itallian Collor	34.00
36	37	Cauterização Trivitt	Cosméticos	Itallian Collor	62.00
37	38	Balcão Recepção 70cm	Móveis MDF	Edgar	420.00
38	39	Lavatório Neon	Lavatório	Bullon	899.99
39	40	Expositor 5 Nichos	Móveis MDF	Edgar	299.99
40	41	Resistência 220V	Acessórios	Enok	60.00
41	42	Balcão Recepção 100 cm	Móveis MDF	Edgar	510.00
42	43	Mesa Elegance Tampo de Vidro	Móveis MDF	Edgar	990.00
43	44	Esmalteiro Grande	Móveis MDF	Edgar	249.99
44	45	Leav-in	Cosméticos	Itallian Collor	249.99
45	46	Ativador Inovattor	Cosméticos	Itallian Collor	34.00
46	47	Kit Manutenção Trivitt	Cosméticos	Itallian Collor	90.00
47	48	Armário Utilitário 2 Portas	Móveis MDF	Edgar	460.00
48	49	Fluído Trivitt	Cosméticos	Itallian Collor	41.00
49	50	Shampoo 2L Itallian	Cosméticos	Itallian Collor	93.00
50	51	Estrutura Lavatório Elegance	Lavatório	Val	1490.00
51	52	Suporte de Pé Colorido	Acessórios	Enok	79.00
52	53	Cadeira TS	Cadeiras	Skylire	169.99
53	54	Hidratação Trivitt  1KG	Cosméticos	Itallian Collor	90.00
54	55	Oxidante 40	Cosméticos	Itallian Collor	46.00
55	56	Console Barber	Móveis MDF	Edgar	420.00
56	57	Bancada Plus	Móveis MDF	Edgar	300.00
57	58	Lavatório Confort Cuba de Louça Branca	Lavatório	Ivair	2490.00
58	59	Baby Puff	Acessórios	Ivair	69.00
59	60	Toalheiro c/ Porta 	Móveis MDF	Edgar	500.00
60	61	Lavatório Confort Cuba de Fibra	Lavatório	Bullon	1699.90
61	62	Cadeira Elegance Arredonda Rec. Base Redonda	Cadeiras	Val	2100.00
62	63	Carrinho Auxiliar 3 Bandejas	Móveis MDF	Edgar	250.00
63	64	Shampoo 5L	Cosméticos	Verônica	59.99
64	65	Condicionador 5L	Cosméticos	Verônica	59.99
65	66	Condicionador Inovattor 250g	Cosméticos	Itallian Collor	44.00
66	67	Bancada Person	Móveis MDF	Edgar	298.00
67	68	Carrinho de Esmaltes	Móveis MDF	Edgar	220.00
68	69	Amortecedor de Cadeira	Acessórios	Enok	120.00
69	70	Console Person	Móveis MDF	Edgar	550.00
70	71	Pó Platinum	Cosméticos	Itallian Collor	108.00
71	72	Shampoo Matizante Pequeno	Cosméticos	Itallian Collor	42.00
72	73	Cadeira Elegance Fixa Base Pentapé	Cadeiras	Val	1390.00
73	74	Protetor Cuba de Louça	Acessórios	Enok	40.00
74	75	Toalheiro Mini	Móveis MDF	Edgar	249.99
75	76	Modelador em Pó	Cosméticos	Itallian Collor	46.00
76	77	Pomada Alta Fixação	Cosméticos	Itallian Collor	42.00
77	78	Brilho Intensivo	Cosméticos	Itallian Collor	50.00
78	79	Spray Lacca	Cosméticos	Itallian Collor	63.00
79	80	Balcão Person	Móveis MDF	Edgar	530.00
80	81	Mocho Estética	Cadeiras	Enok	490.00
81	82	Cadeira Simples Manicure	Cadeiras	Enok	100.00
82	83	Maca 3 posições	Estética	Arlete	649.99
83	84	Maca Fixa	Estética	Arlete	765.00
84	85	Escada Para Maca	Estética	Arlete	99.00
85	86	Esmalteiro Médio	Móveis MDF	Edgar	219.00
86	87	Bancada 1 Gaveta	Móveis MDF	Edgar	400.00
87	88	Oxidante 6	Cosméticos	Itallian Collor	52.00
88	89	Carrinho 4 Gavetas com Tampo de Vidro	Móveis MDF	Edgar	735.00
89	90	Cadeira Pratic Base Pentapé	Cadeiras	Michelle	990.00
90	91	Kit Escovas	Acessórios	Mofashi	129.99
91	92	Carrinho Auxiliar CF1	Móveis MDF	Dompel	190.00
92	93	Kit Guanidina	Cosméticos	Itallian Collor	149.00
93	94	Cadeira Pratic Luxo Rec. Base Quadrada	Cadeiras	Enok	1650.00
94	95	Cadeira Elegance Rec. Redonda Pentapé	Cadeiras	Val	1800.00
95	96	Hidratação Pequena Inovattor	Cosméticos	Itallian Collor	44.00
96	97	Cadeira Dubai	Cadeiras	Darus	2890.00
97	98	Lavatório Champ	Lavatório	Dompel	860.00
98	99	Hidratação Inovattor 1kg	Cosméticos	Itallian Collor	103.00
99	100	Balcão Recepção L	Móveis MDF	Edgar	899.00
100	101	Console Camarim Fascinio	Móveis MDF	Edgar	300.00
101	102	Ármario Expositor 	Móveis MDF	Edgar	550.00
102	103	Registro Metal	Móveis MDF	Edgar	179.00
103	104	Esmalteiro Pequeno	Acessórios	Thiago Registros Ltda	79.00
104	105	Ciranda Manicure Simples	Manicures	Ivair	250.00
105	106	Suporte para Secador 	Móveis MDF	Edgar	500.00
106	107	Carrinho Auxiliar Barbeiro	Móveis MDF	Edgar	299.00
107	108	Nicho de Bancada	Móveis MDF	Edgar	60.00
108	109	Monocomando Cuba	Lavatórios	Val	2000.00
109	110	Poltrona Elegance com Pezeira	Manicures	Ivair	800.00
110	111	Longarina 2 Lugares	Estética	Arlete	1900.00
111	112	Kit Mangueira e Chuveiro de Luxo	Cadeiras	Ivair	590.00
112	113	Assento Cadeira	Acessórios	Ivair	480.00
113	114	Escova 	Acessórios	Enok	10.00
114	115	Maca Total Confort	Cadeiras	Skylire	380.00
115	116	Shampoo Triviit 250g	Móveis MDF	Edgar	690.00
116	117	Kit Manicure	Cadeiras	Val	2140.00
117	118	Poltrona Espera 2 Lugares	Acessórios	Enok	95.00
118	119	Lavatório Elegance Cuba de Fibra	Acessórios	Enok	300.00
119	120	Aquecedor Com Mangueira	Acessórios	Enok	150.00
120	121	Cadeira Elegance Reclinável Base Redonda	Cadeiras	Val	1900.00
121	122	Bancada Barber	Móveis MDF	Edgar	265.00
122	123	Progressiva Trivitt Liss	Acessórios	Enok	590.00
123	124	Bancada Led Camarim	Móveis MDF	Edgar	350.00
124	125	Bancada 2 gavetas	Móveis MDF	Edgar	250.00
125	126	Shampoo Inovattor 250g	Móveis MDF	Edgar	375.00
126	127	Hidraulico Quadradado	Cosméticos	Itallian Collor	118.00
127	128	Rodinha Para Ciranda	Acessórios	Mofashi	40.00
128	129	Console Simples	Cosméticos	Itallian Collor	45.00
129	130	Console Fascínio	Acessórios	Enok	69.00
130	131	Chapinha Nano Lins	Acessórios	Paulo Dias 	499.99
131	132	Kit Matizante Trivitt	Móveis MDF	Edgar	400.00
132	133	Cadeira Elegance Reclinável Base Inox	Cadeiras	Val	1700.00
133	134	Console Barber	Móveis MDF	Edgar	300.00
134	135	Hidratação Matizante 2kg	Cosméticos	Itallian Collor	37.00
135	136	Console Retty Big 1.80	Cosméticos	Itallian Collor	41.00
136	137	Toalheiro 4 Vãos	Móveis MDF	Edgar	950.00
137	138	Nicho de Bancada	Lavatórios	Dompel	650.00
138	139	Longarina 3 Lugares	Cadeiras	Skylire	500.00
139	140	Carrinho Auxiliar Vegas	Móveis Plástico	Dompel	270.00
140	141	Cadeira Topázio	Cadeiras	Sandro	1499.99
141	142	Painel Fascínio 1.70	Cosméticos	Itallian Collor	99.00
142	143	Toalheiro Comeia	Móveis MDF	Edgar	500.00
143	144	Protetor Térmico	Cosméticos	Itallian Collor	103.00
144	145	Condicionador 2.5L	Cosméticos	Itallian Collor	105.00
145	146	Poltrona Braço Cromado	Cadeiras	Ivair	435.00
146	147	Painel Fascínio 1.35	Móveis MDF	Edgar	370.00
147	148	Kit Home Care Inovattor	Cosméticos	Itallian Collor	83.00
148	149	Kit Home Care Extreme-up	Cosméticos	Itallian Collor	92.00
149	150	Cadeira Captonê Reclinável Braço Madeira	Cadeiras	Val	1790.00
150	151	Cadeira Captonê Fixa Braço Madeira	Cadeiras	Val	1490.00
151	152	Lavatório Captonê Braço Madeira Cuba de Louça Branca	Lavatórios	Val	2490.00
152	153	Avental Barbeiro	Acessórios	Mofashi	50.00
153	154	Lavatório Captonê Cuba de Louça Branca	Lavatórios	Ivair	2490.00
154	155	Suporte de Pé Dompel	Móveis Plástico	Dompel	85.00
155	156	Cadeira Elegance Fixa Base Inox	Cadeiras	Val	1690.00
156	157	Kit Extreme UP	Cósmeticos	Itallian Collor	519.00
157	158	Ciranda Spyder Manicure	Manicures	Darus	699.00
158	159	Ciranda Big Scarlet 	Manicures	Ivair	599.00
159	160	Cadeira Arizona	Cadeiras	Darus	2500.00
160	161	Cadeira Captonê Fixa Base Quadrada	Cadeiras	Ivair	1350.00
161	162	Cadeira Captonê Reclinável Base Quadrada	Cadeiras	Ivair	1550.00
162	163	Ciranda Big Captonê	Manicures	Ivair	600.00
163	164	Cadeira Captonê Fixa Base Pentapé	Cadeiras	Ivair	1350.00
164	165	Kit Extreme UP Manutenção	Cosméticos	Itallian Collor	102.00
165	166	Kit Pentes de Máquina	Acessórios	Mofashi	49.00
166	167	Maca Maleta	Estética	Arlete	690.00
167	168	 iação de Tesoura 	Serviço	Leo  iações	45.00
168	169	Lavatório Elegance Cuba de Louça Preta	Lavatórios	Val	2600.00
169	170	Condicionador Trivitt Pequeno	Cosméticos	Itallian Collor	41.00
170	171	Ciranda Scarlet Big	Manicures	Ivair	590.00
171	172	Pézinho de Cadeira	Acessórios	Enok	10.00
172	173	Ducha Sais Minerais	Acessórios	Enok	100.00
173	174	Suporte de Ciranda	Acessórios	Ivair	10.00
174	175	Ciranda Elegance 	Manicures	Val	490.00
175	176	Mangueira Cromada	Acessórios	Enok	120.00
176	177	Ciranda Captonê	Manicures	Ivair	500.00
177	178	Mangueira Simples	Acessórios	Enok	50.00
178	179	Parapé de Cadeira	Acessórios	Enok	60.00
179	180	Bancada Fascinio 3 Gavetas	Móveis MDF	Edgar	380.00
180	181	Ciranda Elegance Big	Manicures	Val	600.00
181	182	Mesa Manicure Havanna	Manicures	Darus	1400.00
182	183	Console Havanna	Móveis MDF	Darus	1000.00
183	185	Assento Elegance	Cadeiras	Val	800.00
184	186	Máscara 2kg	Cosméticos	Verônica	258.00
185	187	Hidratação Matizante 250g	Cosméticos	Itallian Collor	42.00
186	188	Power Oil	Cosméticos	Itallian Collor	42.00
187	189	Borracha de Lavatório	Acessórios	Enok	130.00
188	190	Bancada Fascinio 3 Gavetas 2m	Móveis MDF	Edgar	600.00
189	191	Aparador de C é	Móveis MDF	-	500.00
190	192	Kit Lavatório	Cosméticos	Itallian Collor	360.00
191	193	Hidratação Matizante Pequena	Cosméticos	Itallian Collor	42.00
192	194	Toalheiro 6 Vãos	Móveis MDF	Edgar	450.00
193	195	Cabeçote de Cadeira	Acessórios	Enok	30.00
194	196	Bico Secador	Acessórios	Mofashi	20.00
195	197	Mesa rm L	Móveis MDF	Edgar	450.00
196	198	Blinda Fios	Cosméticos	Itallian Collor	95.00
197	199	Poltrona Maquiagem com Pezeira	Cadeiras	Sandro	1999.00
198	200	Carrinho Mônaco 	Móveis MDF	Darus	600.00
199	201	Chuveiro Iônico 	Acessórios	Enok	50.00
200	202	Mesa L 	Móveis MDF	Edgar	399.00
201	203	Selagem	Cosméticos	Itallian Collor	100.00
202	204	Kit Elegance (2 cad Fixa/ 1 Lav)	Cadeiras	Val	6100.00
203	205	Kit Suporte Manicure	Acessórios	Ivair	300.00
204	206	Kit Triviit Salão	Cosméticos	Itallian Collor	320.00
205	207	NutriLípidca	Cosméticos	Itallian Collor	155.00
206	205	Kit Elegance (1 cad Fixa/ 1 Lav)	Cadeiras	Val	4000.00
207	206	Mousse Penteado	Cosméticos	Itallian Collor	70.00
208	207	Chuveiro Simples	Acessórios	Enok	50.00
209	208	Lavatório Elegance com Pezeira	Lavatórios	Val	3390.00
210	209	Sérum Inovattor	Cosméticos	Itallian Collor	100.00
211	210	Ácido Hialurônico	Cósmeticos	Itallian Collor	19.00
212	211	Poltrona Elegance Braço Arrendondado Fixa Base Quadrada	Cadeiras	Val	1799.99
213	212	Apoio de Lavatório	Cadeiras	Val	350.00
214	204	Kit Elegance (2 cad Recl/ 1 Lav)	Cadeiras	Val	6460.00
215	205	Kit CaptonÊ (1 Cad Fixa / 1 Lav)	Cadeiras	Ivair	4180.00
216	206	Pezinho de Apoi Base Hidraulico	Acessórios	Enok	7.00
217	207	Sofá Elegance	Cadeiras	Val	830.00
\.


--
-- Data for Name: dim_regiao; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dim_regiao (sk_regiao, id_regiao, nome_regiao, valor_frete) FROM stdin;
1	1	Sudeste	345.90
2	2	Norte	798.50
3	3	Sul	420.75
4	4	Nordeste	612.30
5	5	Centro Oeste	655.80
\.


--
-- Data for Name: dim_tempo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dim_tempo (sk_tempo, data_completa, dia, mes, nome_mes, trimestre, ano, dia_semana) FROM stdin;
1	2021-01-02	2	1	Janeiro	1	2021	Sábado
2	2021-01-03	3	1	Janeiro	1	2021	Domingo
3	2021-01-04	4	1	Janeiro	1	2021	Segunda-feira
4	2021-01-05	5	1	Janeiro	1	2021	Terça-feira
5	2021-01-06	6	1	Janeiro	1	2021	Quarta-feira
6	2021-01-07	7	1	Janeiro	1	2021	Quinta-feira
7	2021-01-09	9	1	Janeiro	1	2021	Sábado
8	2021-01-10	10	1	Janeiro	1	2021	Domingo
9	2021-01-12	12	1	Janeiro	1	2021	Terça-feira
10	2021-01-14	14	1	Janeiro	1	2021	Quinta-feira
11	2021-01-15	15	1	Janeiro	1	2021	Sexta-feira
12	2021-01-16	16	1	Janeiro	1	2021	Sábado
13	2021-01-22	22	1	Janeiro	1	2021	Sexta-feira
14	2021-01-23	23	1	Janeiro	1	2021	Sábado
15	2021-01-26	26	1	Janeiro	1	2021	Terça-feira
16	2021-01-28	28	1	Janeiro	1	2021	Quinta-feira
17	2021-01-29	29	1	Janeiro	1	2021	Sexta-feira
18	2021-01-30	30	1	Janeiro	1	2021	Sábado
19	2021-01-31	31	1	Janeiro	1	2021	Domingo
20	2021-02-02	2	2	Fevereiro	1	2021	Terça-feira
21	2021-02-03	3	2	Fevereiro	1	2021	Quarta-feira
22	2021-02-05	5	2	Fevereiro	1	2021	Sexta-feira
23	2021-02-07	7	2	Fevereiro	1	2021	Domingo
24	2021-02-08	8	2	Fevereiro	1	2021	Segunda-feira
25	2021-02-09	9	2	Fevereiro	1	2021	Terça-feira
26	2021-02-11	11	2	Fevereiro	1	2021	Quinta-feira
27	2021-02-12	12	2	Fevereiro	1	2021	Sexta-feira
28	2021-02-14	14	2	Fevereiro	1	2021	Domingo
29	2021-02-15	15	2	Fevereiro	1	2021	Segunda-feira
30	2021-02-16	16	2	Fevereiro	1	2021	Terça-feira
31	2021-02-19	19	2	Fevereiro	1	2021	Sexta-feira
32	2021-02-20	20	2	Fevereiro	1	2021	Sábado
33	2021-02-21	21	2	Fevereiro	1	2021	Domingo
34	2021-02-23	23	2	Fevereiro	1	2021	Terça-feira
35	2021-02-24	24	2	Fevereiro	1	2021	Quarta-feira
36	2021-02-25	25	2	Fevereiro	1	2021	Quinta-feira
37	2021-02-27	27	2	Fevereiro	1	2021	Sábado
38	2021-02-28	28	2	Fevereiro	1	2021	Domingo
39	2021-03-01	1	3	Março	1	2021	Segunda-feira
40	2021-03-04	4	3	Março	1	2021	Quinta-feira
41	2021-03-05	5	3	Março	1	2021	Sexta-feira
42	2021-03-07	7	3	Março	1	2021	Domingo
43	2021-03-09	9	3	Março	1	2021	Terça-feira
44	2021-03-10	10	3	Março	1	2021	Quarta-feira
45	2021-03-12	12	3	Março	1	2021	Sexta-feira
46	2021-03-14	14	3	Março	1	2021	Domingo
47	2021-03-15	15	3	Março	1	2021	Segunda-feira
48	2021-03-16	16	3	Março	1	2021	Terça-feira
49	2021-03-17	17	3	Março	1	2021	Quarta-feira
50	2021-03-18	18	3	Março	1	2021	Quinta-feira
51	2021-03-19	19	3	Março	1	2021	Sexta-feira
52	2021-03-21	21	3	Março	1	2021	Domingo
53	2021-03-23	23	3	Março	1	2021	Terça-feira
54	2021-03-25	25	3	Março	1	2021	Quinta-feira
55	2021-04-02	2	4	Abril	2	2021	Sexta-feira
56	2021-04-04	4	4	Abril	2	2021	Domingo
57	2021-04-06	6	4	Abril	2	2021	Terça-feira
58	2021-04-07	7	4	Abril	2	2021	Quarta-feira
59	2021-04-08	8	4	Abril	2	2021	Quinta-feira
60	2021-04-09	9	4	Abril	2	2021	Sexta-feira
61	2021-04-10	10	4	Abril	2	2021	Sábado
62	2021-04-11	11	4	Abril	2	2021	Domingo
63	2021-04-13	13	4	Abril	2	2021	Terça-feira
64	2021-04-15	15	4	Abril	2	2021	Quinta-feira
65	2021-04-16	16	4	Abril	2	2021	Sexta-feira
66	2021-04-17	17	4	Abril	2	2021	Sábado
67	2021-04-18	18	4	Abril	2	2021	Domingo
68	2021-04-19	19	4	Abril	2	2021	Segunda-feira
69	2021-04-22	22	4	Abril	2	2021	Quinta-feira
70	2021-04-23	23	4	Abril	2	2021	Sexta-feira
71	2021-04-25	25	4	Abril	2	2021	Domingo
72	2021-04-26	26	4	Abril	2	2021	Segunda-feira
73	2021-04-29	29	4	Abril	2	2021	Quinta-feira
74	2021-05-01	1	5	Maio	2	2021	Sábado
75	2021-05-02	2	5	Maio	2	2021	Domingo
76	2021-05-05	5	5	Maio	2	2021	Quarta-feira
77	2021-05-07	7	5	Maio	2	2021	Sexta-feira
78	2021-05-08	8	5	Maio	2	2021	Sábado
79	2021-05-09	9	5	Maio	2	2021	Domingo
80	2021-05-10	10	5	Maio	2	2021	Segunda-feira
81	2021-05-11	11	5	Maio	2	2021	Terça-feira
82	2021-05-12	12	5	Maio	2	2021	Quarta-feira
83	2021-05-13	13	5	Maio	2	2021	Quinta-feira
84	2021-05-14	14	5	Maio	2	2021	Sexta-feira
85	2021-05-15	15	5	Maio	2	2021	Sábado
86	2021-05-16	16	5	Maio	2	2021	Domingo
87	2021-05-18	18	5	Maio	2	2021	Terça-feira
88	2021-05-19	19	5	Maio	2	2021	Quarta-feira
89	2021-05-20	20	5	Maio	2	2021	Quinta-feira
90	2021-05-21	21	5	Maio	2	2021	Sexta-feira
91	2021-05-22	22	5	Maio	2	2021	Sábado
92	2021-05-25	25	5	Maio	2	2021	Terça-feira
93	2021-05-27	27	5	Maio	2	2021	Quinta-feira
94	2021-05-28	28	5	Maio	2	2021	Sexta-feira
95	2021-05-29	29	5	Maio	2	2021	Sábado
96	2021-05-30	30	5	Maio	2	2021	Domingo
97	2021-05-31	31	5	Maio	2	2021	Segunda-feira
98	2021-06-01	1	6	Junho	2	2021	Terça-feira
99	2021-06-02	2	6	Junho	2	2021	Quarta-feira
100	2021-06-03	3	6	Junho	2	2021	Quinta-feira
101	2021-06-04	4	6	Junho	2	2021	Sexta-feira
102	2021-06-06	6	6	Junho	2	2021	Domingo
103	2021-06-07	7	6	Junho	2	2021	Segunda-feira
104	2021-06-08	8	6	Junho	2	2021	Terça-feira
105	2021-06-11	11	6	Junho	2	2021	Sexta-feira
106	2021-06-12	12	6	Junho	2	2021	Sábado
107	2021-06-13	13	6	Junho	2	2021	Domingo
108	2021-06-14	14	6	Junho	2	2021	Segunda-feira
109	2021-06-15	15	6	Junho	2	2021	Terça-feira
110	2021-06-16	16	6	Junho	2	2021	Quarta-feira
111	2021-06-17	17	6	Junho	2	2021	Quinta-feira
112	2021-06-18	18	6	Junho	2	2021	Sexta-feira
113	2021-06-19	19	6	Junho	2	2021	Sábado
114	2021-06-20	20	6	Junho	2	2021	Domingo
115	2021-06-21	21	6	Junho	2	2021	Segunda-feira
116	2021-06-22	22	6	Junho	2	2021	Terça-feira
117	2021-06-25	25	6	Junho	2	2021	Sexta-feira
118	2021-06-26	26	6	Junho	2	2021	Sábado
119	2021-06-27	27	6	Junho	2	2021	Domingo
120	2021-06-28	28	6	Junho	2	2021	Segunda-feira
121	2021-06-29	29	6	Junho	2	2021	Terça-feira
122	2021-06-30	30	6	Junho	2	2021	Quarta-feira
123	2021-07-01	1	7	Julho	3	2021	Quinta-feira
124	2021-07-05	5	7	Julho	3	2021	Segunda-feira
125	2021-07-06	6	7	Julho	3	2021	Terça-feira
126	2021-07-07	7	7	Julho	3	2021	Quarta-feira
127	2021-07-10	10	7	Julho	3	2021	Sábado
128	2021-07-13	13	7	Julho	3	2021	Terça-feira
129	2021-07-14	14	7	Julho	3	2021	Quarta-feira
130	2021-07-15	15	7	Julho	3	2021	Quinta-feira
131	2021-07-16	16	7	Julho	3	2021	Sexta-feira
132	2021-07-17	17	7	Julho	3	2021	Sábado
133	2021-07-19	19	7	Julho	3	2021	Segunda-feira
134	2021-07-21	21	7	Julho	3	2021	Quarta-feira
135	2021-07-22	22	7	Julho	3	2021	Quinta-feira
136	2021-07-23	23	7	Julho	3	2021	Sexta-feira
137	2021-07-24	24	7	Julho	3	2021	Sábado
138	2021-07-26	26	7	Julho	3	2021	Segunda-feira
139	2021-07-27	27	7	Julho	3	2021	Terça-feira
140	2021-07-29	29	7	Julho	3	2021	Quinta-feira
141	2021-07-30	30	7	Julho	3	2021	Sexta-feira
142	2021-07-31	31	7	Julho	3	2021	Sábado
143	2021-08-01	1	8	Agosto	3	2021	Domingo
144	2021-08-02	2	8	Agosto	3	2021	Segunda-feira
145	2021-08-05	5	8	Agosto	3	2021	Quinta-feira
146	2021-08-06	6	8	Agosto	3	2021	Sexta-feira
147	2021-08-10	10	8	Agosto	3	2021	Terça-feira
148	2021-08-11	11	8	Agosto	3	2021	Quarta-feira
149	2021-08-12	12	8	Agosto	3	2021	Quinta-feira
150	2021-08-13	13	8	Agosto	3	2021	Sexta-feira
151	2021-08-14	14	8	Agosto	3	2021	Sábado
152	2021-08-15	15	8	Agosto	3	2021	Domingo
153	2021-08-16	16	8	Agosto	3	2021	Segunda-feira
154	2021-08-17	17	8	Agosto	3	2021	Terça-feira
155	2021-08-18	18	8	Agosto	3	2021	Quarta-feira
156	2021-08-19	19	8	Agosto	3	2021	Quinta-feira
157	2021-08-20	20	8	Agosto	3	2021	Sexta-feira
158	2021-08-21	21	8	Agosto	3	2021	Sábado
159	2021-08-22	22	8	Agosto	3	2021	Domingo
160	2021-08-24	24	8	Agosto	3	2021	Terça-feira
161	2021-08-26	26	8	Agosto	3	2021	Quinta-feira
162	2021-08-27	27	8	Agosto	3	2021	Sexta-feira
163	2021-08-28	28	8	Agosto	3	2021	Sábado
164	2021-08-29	29	8	Agosto	3	2021	Domingo
165	2021-08-30	30	8	Agosto	3	2021	Segunda-feira
166	2021-08-31	31	8	Agosto	3	2021	Terça-feira
167	2021-09-01	1	9	Setembro	3	2021	Quarta-feira
168	2021-09-02	2	9	Setembro	3	2021	Quinta-feira
169	2021-09-04	4	9	Setembro	3	2021	Sábado
170	2021-09-06	6	9	Setembro	3	2021	Segunda-feira
171	2021-09-07	7	9	Setembro	3	2021	Terça-feira
172	2021-09-08	8	9	Setembro	3	2021	Quarta-feira
173	2021-09-10	10	9	Setembro	3	2021	Sexta-feira
174	2021-09-11	11	9	Setembro	3	2021	Sábado
175	2021-09-13	13	9	Setembro	3	2021	Segunda-feira
176	2021-09-14	14	9	Setembro	3	2021	Terça-feira
177	2021-09-15	15	9	Setembro	3	2021	Quarta-feira
178	2021-09-16	16	9	Setembro	3	2021	Quinta-feira
179	2021-09-17	17	9	Setembro	3	2021	Sexta-feira
180	2021-09-18	18	9	Setembro	3	2021	Sábado
181	2021-09-19	19	9	Setembro	3	2021	Domingo
182	2021-09-20	20	9	Setembro	3	2021	Segunda-feira
183	2021-09-21	21	9	Setembro	3	2021	Terça-feira
184	2021-09-22	22	9	Setembro	3	2021	Quarta-feira
185	2021-09-23	23	9	Setembro	3	2021	Quinta-feira
186	2021-09-24	24	9	Setembro	3	2021	Sexta-feira
187	2021-09-26	26	9	Setembro	3	2021	Domingo
188	2021-09-27	27	9	Setembro	3	2021	Segunda-feira
189	2021-09-28	28	9	Setembro	3	2021	Terça-feira
190	2021-09-29	29	9	Setembro	3	2021	Quarta-feira
191	2021-10-01	1	10	Outubro	4	2021	Sexta-feira
192	2021-10-03	3	10	Outubro	4	2021	Domingo
193	2021-10-04	4	10	Outubro	4	2021	Segunda-feira
194	2021-10-05	5	10	Outubro	4	2021	Terça-feira
195	2021-10-06	6	10	Outubro	4	2021	Quarta-feira
196	2021-10-07	7	10	Outubro	4	2021	Quinta-feira
197	2021-10-10	10	10	Outubro	4	2021	Domingo
198	2021-10-11	11	10	Outubro	4	2021	Segunda-feira
199	2021-10-13	13	10	Outubro	4	2021	Quarta-feira
200	2021-10-14	14	10	Outubro	4	2021	Quinta-feira
201	2021-10-16	16	10	Outubro	4	2021	Sábado
202	2021-10-17	17	10	Outubro	4	2021	Domingo
203	2021-10-20	20	10	Outubro	4	2021	Quarta-feira
204	2021-10-21	21	10	Outubro	4	2021	Quinta-feira
205	2021-10-22	22	10	Outubro	4	2021	Sexta-feira
206	2021-10-23	23	10	Outubro	4	2021	Sábado
207	2021-10-24	24	10	Outubro	4	2021	Domingo
208	2021-10-25	25	10	Outubro	4	2021	Segunda-feira
209	2021-10-26	26	10	Outubro	4	2021	Terça-feira
210	2021-10-27	27	10	Outubro	4	2021	Quarta-feira
211	2021-10-29	29	10	Outubro	4	2021	Sexta-feira
212	2021-10-30	30	10	Outubro	4	2021	Sábado
213	2021-10-31	31	10	Outubro	4	2021	Domingo
214	2021-11-01	1	11	Novembro	4	2021	Segunda-feira
215	2021-11-02	2	11	Novembro	4	2021	Terça-feira
216	2021-11-03	3	11	Novembro	4	2021	Quarta-feira
646	2023-08-27	27	8	Agosto	3	2023	Domingo
217	2021-11-05	5	11	Novembro	4	2021	Sexta-feira
218	2021-11-06	6	11	Novembro	4	2021	Sábado
219	2021-11-08	8	11	Novembro	4	2021	Segunda-feira
220	2021-11-09	9	11	Novembro	4	2021	Terça-feira
221	2021-11-10	10	11	Novembro	4	2021	Quarta-feira
222	2021-11-11	11	11	Novembro	4	2021	Quinta-feira
223	2021-11-12	12	11	Novembro	4	2021	Sexta-feira
224	2021-11-13	13	11	Novembro	4	2021	Sábado
225	2021-11-15	15	11	Novembro	4	2021	Segunda-feira
226	2021-11-19	19	11	Novembro	4	2021	Sexta-feira
227	2021-11-20	20	11	Novembro	4	2021	Sábado
228	2021-11-22	22	11	Novembro	4	2021	Segunda-feira
229	2021-11-23	23	11	Novembro	4	2021	Terça-feira
230	2021-11-25	25	11	Novembro	4	2021	Quinta-feira
231	2021-11-27	27	11	Novembro	4	2021	Sábado
232	2021-11-30	30	11	Novembro	4	2021	Terça-feira
233	2021-12-03	3	12	Dezembro	4	2021	Sexta-feira
234	2021-12-04	4	12	Dezembro	4	2021	Sábado
235	2021-12-05	5	12	Dezembro	4	2021	Domingo
236	2021-12-06	6	12	Dezembro	4	2021	Segunda-feira
237	2021-12-07	7	12	Dezembro	4	2021	Terça-feira
238	2021-12-08	8	12	Dezembro	4	2021	Quarta-feira
239	2021-12-09	9	12	Dezembro	4	2021	Quinta-feira
240	2021-12-14	14	12	Dezembro	4	2021	Terça-feira
241	2021-12-18	18	12	Dezembro	4	2021	Sábado
242	2021-12-19	19	12	Dezembro	4	2021	Domingo
243	2021-12-20	20	12	Dezembro	4	2021	Segunda-feira
244	2021-12-21	21	12	Dezembro	4	2021	Terça-feira
245	2021-12-22	22	12	Dezembro	4	2021	Quarta-feira
246	2021-12-24	24	12	Dezembro	4	2021	Sexta-feira
247	2021-12-25	25	12	Dezembro	4	2021	Sábado
248	2021-12-26	26	12	Dezembro	4	2021	Domingo
249	2021-12-27	27	12	Dezembro	4	2021	Segunda-feira
250	2021-12-28	28	12	Dezembro	4	2021	Terça-feira
251	2021-12-31	31	12	Dezembro	4	2021	Sexta-feira
252	2022-01-01	1	1	Janeiro	1	2022	Sábado
253	2022-01-03	3	1	Janeiro	1	2022	Segunda-feira
254	2022-01-04	4	1	Janeiro	1	2022	Terça-feira
255	2022-01-05	5	1	Janeiro	1	2022	Quarta-feira
256	2022-01-06	6	1	Janeiro	1	2022	Quinta-feira
257	2022-01-10	10	1	Janeiro	1	2022	Segunda-feira
258	2022-01-11	11	1	Janeiro	1	2022	Terça-feira
259	2022-01-12	12	1	Janeiro	1	2022	Quarta-feira
260	2022-01-13	13	1	Janeiro	1	2022	Quinta-feira
261	2022-01-14	14	1	Janeiro	1	2022	Sexta-feira
262	2022-01-15	15	1	Janeiro	1	2022	Sábado
263	2022-01-21	21	1	Janeiro	1	2022	Sexta-feira
264	2022-01-24	24	1	Janeiro	1	2022	Segunda-feira
265	2022-01-25	25	1	Janeiro	1	2022	Terça-feira
266	2022-01-26	26	1	Janeiro	1	2022	Quarta-feira
267	2022-01-27	27	1	Janeiro	1	2022	Quinta-feira
268	2022-01-28	28	1	Janeiro	1	2022	Sexta-feira
269	2022-01-29	29	1	Janeiro	1	2022	Sábado
270	2022-01-31	31	1	Janeiro	1	2022	Segunda-feira
271	2022-02-01	1	2	Fevereiro	1	2022	Terça-feira
272	2022-02-03	3	2	Fevereiro	1	2022	Quinta-feira
273	2022-02-06	6	2	Fevereiro	1	2022	Domingo
274	2022-02-07	7	2	Fevereiro	1	2022	Segunda-feira
275	2022-02-10	10	2	Fevereiro	1	2022	Quinta-feira
276	2022-02-13	13	2	Fevereiro	1	2022	Domingo
277	2022-02-14	14	2	Fevereiro	1	2022	Segunda-feira
278	2022-02-15	15	2	Fevereiro	1	2022	Terça-feira
279	2022-02-16	16	2	Fevereiro	1	2022	Quarta-feira
280	2022-02-17	17	2	Fevereiro	1	2022	Quinta-feira
281	2022-02-18	18	2	Fevereiro	1	2022	Sexta-feira
282	2022-02-19	19	2	Fevereiro	1	2022	Sábado
283	2022-02-20	20	2	Fevereiro	1	2022	Domingo
284	2022-02-22	22	2	Fevereiro	1	2022	Terça-feira
285	2022-02-24	24	2	Fevereiro	1	2022	Quinta-feira
286	2022-03-03	3	3	Março	1	2022	Quinta-feira
287	2022-03-04	4	3	Março	1	2022	Sexta-feira
288	2022-03-05	5	3	Março	1	2022	Sábado
289	2022-03-06	6	3	Março	1	2022	Domingo
290	2022-03-07	7	3	Março	1	2022	Segunda-feira
291	2022-03-08	8	3	Março	1	2022	Terça-feira
292	2022-03-09	9	3	Março	1	2022	Quarta-feira
293	2022-03-10	10	3	Março	1	2022	Quinta-feira
294	2022-03-12	12	3	Março	1	2022	Sábado
295	2022-03-13	13	3	Março	1	2022	Domingo
296	2022-03-14	14	3	Março	1	2022	Segunda-feira
297	2022-03-15	15	3	Março	1	2022	Terça-feira
298	2022-03-17	17	3	Março	1	2022	Quinta-feira
299	2022-03-18	18	3	Março	1	2022	Sexta-feira
300	2022-03-19	19	3	Março	1	2022	Sábado
301	2022-03-20	20	3	Março	1	2022	Domingo
302	2022-03-21	21	3	Março	1	2022	Segunda-feira
303	2022-03-22	22	3	Março	1	2022	Terça-feira
304	2022-03-23	23	3	Março	1	2022	Quarta-feira
305	2022-03-24	24	3	Março	1	2022	Quinta-feira
306	2022-03-25	25	3	Março	1	2022	Sexta-feira
307	2022-03-26	26	3	Março	1	2022	Sábado
308	2022-03-27	27	3	Março	1	2022	Domingo
309	2022-03-28	28	3	Março	1	2022	Segunda-feira
310	2022-03-31	31	3	Março	1	2022	Quinta-feira
311	2022-04-01	1	4	Abril	2	2022	Sexta-feira
312	2022-04-02	2	4	Abril	2	2022	Sábado
313	2022-04-03	3	4	Abril	2	2022	Domingo
314	2022-04-04	4	4	Abril	2	2022	Segunda-feira
315	2022-04-06	6	4	Abril	2	2022	Quarta-feira
316	2022-04-08	8	4	Abril	2	2022	Sexta-feira
317	2022-04-09	9	4	Abril	2	2022	Sábado
318	2022-04-11	11	4	Abril	2	2022	Segunda-feira
319	2022-04-12	12	4	Abril	2	2022	Terça-feira
320	2022-04-13	13	4	Abril	2	2022	Quarta-feira
321	2022-04-14	14	4	Abril	2	2022	Quinta-feira
861	2024-07-21	21	7	Julho	3	2024	Domingo
322	2022-04-15	15	4	Abril	2	2022	Sexta-feira
323	2022-04-16	16	4	Abril	2	2022	Sábado
324	2022-04-17	17	4	Abril	2	2022	Domingo
325	2022-04-18	18	4	Abril	2	2022	Segunda-feira
326	2022-04-19	19	4	Abril	2	2022	Terça-feira
327	2022-04-20	20	4	Abril	2	2022	Quarta-feira
328	2022-04-21	21	4	Abril	2	2022	Quinta-feira
329	2022-04-22	22	4	Abril	2	2022	Sexta-feira
330	2022-04-24	24	4	Abril	2	2022	Domingo
331	2022-04-25	25	4	Abril	2	2022	Segunda-feira
332	2022-04-26	26	4	Abril	2	2022	Terça-feira
333	2022-04-28	28	4	Abril	2	2022	Quinta-feira
334	2022-04-30	30	4	Abril	2	2022	Sábado
335	2022-05-03	3	5	Maio	2	2022	Terça-feira
336	2022-05-06	6	5	Maio	2	2022	Sexta-feira
337	2022-05-07	7	5	Maio	2	2022	Sábado
338	2022-05-08	8	5	Maio	2	2022	Domingo
339	2022-05-09	9	5	Maio	2	2022	Segunda-feira
340	2022-05-10	10	5	Maio	2	2022	Terça-feira
341	2022-05-11	11	5	Maio	2	2022	Quarta-feira
342	2022-05-13	13	5	Maio	2	2022	Sexta-feira
343	2022-05-16	16	5	Maio	2	2022	Segunda-feira
344	2022-05-17	17	5	Maio	2	2022	Terça-feira
345	2022-05-19	19	5	Maio	2	2022	Quinta-feira
346	2022-05-21	21	5	Maio	2	2022	Sábado
347	2022-05-23	23	5	Maio	2	2022	Segunda-feira
348	2022-05-24	24	5	Maio	2	2022	Terça-feira
349	2022-05-25	25	5	Maio	2	2022	Quarta-feira
350	2022-05-28	28	5	Maio	2	2022	Sábado
351	2022-05-29	29	5	Maio	2	2022	Domingo
352	2022-05-30	30	5	Maio	2	2022	Segunda-feira
353	2022-05-31	31	5	Maio	2	2022	Terça-feira
354	2022-06-01	1	6	Junho	2	2022	Quarta-feira
355	2022-06-02	2	6	Junho	2	2022	Quinta-feira
356	2022-06-05	5	6	Junho	2	2022	Domingo
357	2022-06-07	7	6	Junho	2	2022	Terça-feira
358	2022-06-08	8	6	Junho	2	2022	Quarta-feira
359	2022-06-13	13	6	Junho	2	2022	Segunda-feira
360	2022-06-14	14	6	Junho	2	2022	Terça-feira
361	2022-06-15	15	6	Junho	2	2022	Quarta-feira
362	2022-06-16	16	6	Junho	2	2022	Quinta-feira
363	2022-06-17	17	6	Junho	2	2022	Sexta-feira
364	2022-06-18	18	6	Junho	2	2022	Sábado
365	2022-06-21	21	6	Junho	2	2022	Terça-feira
366	2022-06-23	23	6	Junho	2	2022	Quinta-feira
367	2022-06-24	24	6	Junho	2	2022	Sexta-feira
368	2022-06-25	25	6	Junho	2	2022	Sábado
369	2022-06-27	27	6	Junho	2	2022	Segunda-feira
370	2022-06-28	28	6	Junho	2	2022	Terça-feira
371	2022-06-29	29	6	Junho	2	2022	Quarta-feira
372	2022-07-01	1	7	Julho	3	2022	Sexta-feira
373	2022-07-02	2	7	Julho	3	2022	Sábado
374	2022-07-05	5	7	Julho	3	2022	Terça-feira
375	2022-07-06	6	7	Julho	3	2022	Quarta-feira
376	2022-07-07	7	7	Julho	3	2022	Quinta-feira
377	2022-07-08	8	7	Julho	3	2022	Sexta-feira
378	2022-07-10	10	7	Julho	3	2022	Domingo
379	2022-07-11	11	7	Julho	3	2022	Segunda-feira
380	2022-07-12	12	7	Julho	3	2022	Terça-feira
381	2022-07-13	13	7	Julho	3	2022	Quarta-feira
382	2022-07-14	14	7	Julho	3	2022	Quinta-feira
383	2022-07-19	19	7	Julho	3	2022	Terça-feira
384	2022-07-20	20	7	Julho	3	2022	Quarta-feira
385	2022-07-23	23	7	Julho	3	2022	Sábado
386	2022-07-25	25	7	Julho	3	2022	Segunda-feira
387	2022-07-26	26	7	Julho	3	2022	Terça-feira
388	2022-07-28	28	7	Julho	3	2022	Quinta-feira
389	2022-07-29	29	7	Julho	3	2022	Sexta-feira
390	2022-07-31	31	7	Julho	3	2022	Domingo
391	2022-08-01	1	8	Agosto	3	2022	Segunda-feira
392	2022-08-03	3	8	Agosto	3	2022	Quarta-feira
393	2022-08-04	4	8	Agosto	3	2022	Quinta-feira
394	2022-08-06	6	8	Agosto	3	2022	Sábado
395	2022-08-07	7	8	Agosto	3	2022	Domingo
396	2022-08-08	8	8	Agosto	3	2022	Segunda-feira
397	2022-08-10	10	8	Agosto	3	2022	Quarta-feira
398	2022-08-11	11	8	Agosto	3	2022	Quinta-feira
399	2022-08-13	13	8	Agosto	3	2022	Sábado
400	2022-08-15	15	8	Agosto	3	2022	Segunda-feira
401	2022-08-16	16	8	Agosto	3	2022	Terça-feira
402	2022-08-17	17	8	Agosto	3	2022	Quarta-feira
403	2022-08-18	18	8	Agosto	3	2022	Quinta-feira
404	2022-08-20	20	8	Agosto	3	2022	Sábado
405	2022-08-23	23	8	Agosto	3	2022	Terça-feira
406	2022-08-24	24	8	Agosto	3	2022	Quarta-feira
407	2022-08-26	26	8	Agosto	3	2022	Sexta-feira
408	2022-08-27	27	8	Agosto	3	2022	Sábado
409	2022-08-28	28	8	Agosto	3	2022	Domingo
410	2022-08-29	29	8	Agosto	3	2022	Segunda-feira
411	2022-09-01	1	9	Setembro	3	2022	Quinta-feira
412	2022-09-02	2	9	Setembro	3	2022	Sexta-feira
413	2022-09-03	3	9	Setembro	3	2022	Sábado
414	2022-09-05	5	9	Setembro	3	2022	Segunda-feira
415	2022-09-06	6	9	Setembro	3	2022	Terça-feira
416	2022-09-07	7	9	Setembro	3	2022	Quarta-feira
417	2022-09-08	8	9	Setembro	3	2022	Quinta-feira
418	2022-09-10	10	9	Setembro	3	2022	Sábado
419	2022-09-11	11	9	Setembro	3	2022	Domingo
420	2022-09-12	12	9	Setembro	3	2022	Segunda-feira
421	2022-09-13	13	9	Setembro	3	2022	Terça-feira
422	2022-09-14	14	9	Setembro	3	2022	Quarta-feira
423	2022-09-15	15	9	Setembro	3	2022	Quinta-feira
424	2022-09-19	19	9	Setembro	3	2022	Segunda-feira
425	2022-09-20	20	9	Setembro	3	2022	Terça-feira
426	2022-09-23	23	9	Setembro	3	2022	Sexta-feira
427	2022-09-24	24	9	Setembro	3	2022	Sábado
428	2022-09-25	25	9	Setembro	3	2022	Domingo
429	2022-09-26	26	9	Setembro	3	2022	Segunda-feira
430	2022-09-27	27	9	Setembro	3	2022	Terça-feira
431	2022-09-28	28	9	Setembro	3	2022	Quarta-feira
432	2022-09-30	30	9	Setembro	3	2022	Sexta-feira
433	2022-10-01	1	10	Outubro	4	2022	Sábado
434	2022-10-03	3	10	Outubro	4	2022	Segunda-feira
435	2022-10-04	4	10	Outubro	4	2022	Terça-feira
436	2022-10-05	5	10	Outubro	4	2022	Quarta-feira
437	2022-10-06	6	10	Outubro	4	2022	Quinta-feira
438	2022-10-07	7	10	Outubro	4	2022	Sexta-feira
439	2022-10-08	8	10	Outubro	4	2022	Sábado
440	2022-10-09	9	10	Outubro	4	2022	Domingo
441	2022-10-10	10	10	Outubro	4	2022	Segunda-feira
442	2022-10-12	12	10	Outubro	4	2022	Quarta-feira
443	2022-10-13	13	10	Outubro	4	2022	Quinta-feira
444	2022-10-14	14	10	Outubro	4	2022	Sexta-feira
445	2022-10-17	17	10	Outubro	4	2022	Segunda-feira
446	2022-10-18	18	10	Outubro	4	2022	Terça-feira
447	2022-10-23	23	10	Outubro	4	2022	Domingo
448	2022-10-24	24	10	Outubro	4	2022	Segunda-feira
449	2022-10-25	25	10	Outubro	4	2022	Terça-feira
450	2022-10-28	28	10	Outubro	4	2022	Sexta-feira
451	2022-10-29	29	10	Outubro	4	2022	Sábado
452	2022-10-31	31	10	Outubro	4	2022	Segunda-feira
453	2022-11-02	2	11	Novembro	4	2022	Quarta-feira
454	2022-11-05	5	11	Novembro	4	2022	Sábado
455	2022-11-06	6	11	Novembro	4	2022	Domingo
456	2022-11-09	9	11	Novembro	4	2022	Quarta-feira
457	2022-11-10	10	11	Novembro	4	2022	Quinta-feira
458	2022-11-11	11	11	Novembro	4	2022	Sexta-feira
459	2022-11-14	14	11	Novembro	4	2022	Segunda-feira
460	2022-11-15	15	11	Novembro	4	2022	Terça-feira
461	2022-11-16	16	11	Novembro	4	2022	Quarta-feira
462	2022-11-17	17	11	Novembro	4	2022	Quinta-feira
463	2022-11-19	19	11	Novembro	4	2022	Sábado
464	2022-11-21	21	11	Novembro	4	2022	Segunda-feira
465	2022-11-22	22	11	Novembro	4	2022	Terça-feira
466	2022-11-24	24	11	Novembro	4	2022	Quinta-feira
467	2022-11-25	25	11	Novembro	4	2022	Sexta-feira
468	2022-11-29	29	11	Novembro	4	2022	Terça-feira
469	2022-11-30	30	11	Novembro	4	2022	Quarta-feira
470	2022-12-01	1	12	Dezembro	4	2022	Quinta-feira
471	2022-12-03	3	12	Dezembro	4	2022	Sábado
472	2022-12-04	4	12	Dezembro	4	2022	Domingo
473	2022-12-05	5	12	Dezembro	4	2022	Segunda-feira
474	2022-12-06	6	12	Dezembro	4	2022	Terça-feira
475	2022-12-08	8	12	Dezembro	4	2022	Quinta-feira
476	2022-12-09	9	12	Dezembro	4	2022	Sexta-feira
477	2022-12-10	10	12	Dezembro	4	2022	Sábado
478	2022-12-14	14	12	Dezembro	4	2022	Quarta-feira
479	2022-12-15	15	12	Dezembro	4	2022	Quinta-feira
480	2022-12-17	17	12	Dezembro	4	2022	Sábado
481	2022-12-18	18	12	Dezembro	4	2022	Domingo
482	2022-12-19	19	12	Dezembro	4	2022	Segunda-feira
483	2022-12-20	20	12	Dezembro	4	2022	Terça-feira
484	2022-12-23	23	12	Dezembro	4	2022	Sexta-feira
485	2022-12-24	24	12	Dezembro	4	2022	Sábado
486	2022-12-26	26	12	Dezembro	4	2022	Segunda-feira
487	2022-12-27	27	12	Dezembro	4	2022	Terça-feira
488	2022-12-29	29	12	Dezembro	4	2022	Quinta-feira
489	2023-01-03	3	1	Janeiro	1	2023	Terça-feira
490	2023-01-04	4	1	Janeiro	1	2023	Quarta-feira
491	2023-01-07	7	1	Janeiro	1	2023	Sábado
492	2023-01-09	9	1	Janeiro	1	2023	Segunda-feira
493	2023-01-10	10	1	Janeiro	1	2023	Terça-feira
494	2023-01-14	14	1	Janeiro	1	2023	Sábado
495	2023-01-15	15	1	Janeiro	1	2023	Domingo
496	2023-01-19	19	1	Janeiro	1	2023	Quinta-feira
497	2023-01-24	24	1	Janeiro	1	2023	Terça-feira
498	2023-01-25	25	1	Janeiro	1	2023	Quarta-feira
499	2023-01-26	26	1	Janeiro	1	2023	Quinta-feira
500	2023-01-29	29	1	Janeiro	1	2023	Domingo
501	2023-01-30	30	1	Janeiro	1	2023	Segunda-feira
502	2023-01-31	31	1	Janeiro	1	2023	Terça-feira
503	2023-02-01	1	2	Fevereiro	1	2023	Quarta-feira
504	2023-02-02	2	2	Fevereiro	1	2023	Quinta-feira
505	2023-02-04	4	2	Fevereiro	1	2023	Sábado
506	2023-02-06	6	2	Fevereiro	1	2023	Segunda-feira
507	2023-02-07	7	2	Fevereiro	1	2023	Terça-feira
508	2023-02-08	8	2	Fevereiro	1	2023	Quarta-feira
509	2023-02-09	9	2	Fevereiro	1	2023	Quinta-feira
510	2023-02-11	11	2	Fevereiro	1	2023	Sábado
511	2023-02-12	12	2	Fevereiro	1	2023	Domingo
512	2023-02-13	13	2	Fevereiro	1	2023	Segunda-feira
513	2023-02-14	14	2	Fevereiro	1	2023	Terça-feira
514	2023-02-17	17	2	Fevereiro	1	2023	Sexta-feira
515	2023-02-20	20	2	Fevereiro	1	2023	Segunda-feira
516	2023-02-24	24	2	Fevereiro	1	2023	Sexta-feira
517	2023-02-25	25	2	Fevereiro	1	2023	Sábado
518	2023-02-28	28	2	Fevereiro	1	2023	Terça-feira
519	2023-03-01	1	3	Março	1	2023	Quarta-feira
520	2023-03-04	4	3	Março	1	2023	Sábado
521	2023-03-05	5	3	Março	1	2023	Domingo
522	2023-03-09	9	3	Março	1	2023	Quinta-feira
523	2023-03-13	13	3	Março	1	2023	Segunda-feira
524	2023-03-15	15	3	Março	1	2023	Quarta-feira
525	2023-03-16	16	3	Março	1	2023	Quinta-feira
526	2023-03-17	17	3	Março	1	2023	Sexta-feira
527	2023-03-19	19	3	Março	1	2023	Domingo
528	2023-03-20	20	3	Março	1	2023	Segunda-feira
529	2023-03-21	21	3	Março	1	2023	Terça-feira
530	2023-03-23	23	3	Março	1	2023	Quinta-feira
531	2023-03-24	24	3	Março	1	2023	Sexta-feira
532	2023-03-25	25	3	Março	1	2023	Sábado
533	2023-03-26	26	3	Março	1	2023	Domingo
534	2023-03-27	27	3	Março	1	2023	Segunda-feira
535	2023-03-31	31	3	Março	1	2023	Sexta-feira
536	2023-04-01	1	4	Abril	2	2023	Sábado
537	2023-04-02	2	4	Abril	2	2023	Domingo
538	2023-04-03	3	4	Abril	2	2023	Segunda-feira
539	2023-04-04	4	4	Abril	2	2023	Terça-feira
540	2023-04-05	5	4	Abril	2	2023	Quarta-feira
541	2023-04-09	9	4	Abril	2	2023	Domingo
542	2023-04-10	10	4	Abril	2	2023	Segunda-feira
543	2023-04-11	11	4	Abril	2	2023	Terça-feira
544	2023-04-15	15	4	Abril	2	2023	Sábado
545	2023-04-16	16	4	Abril	2	2023	Domingo
546	2023-04-17	17	4	Abril	2	2023	Segunda-feira
547	2023-04-19	19	4	Abril	2	2023	Quarta-feira
548	2023-04-20	20	4	Abril	2	2023	Quinta-feira
549	2023-04-21	21	4	Abril	2	2023	Sexta-feira
550	2023-04-22	22	4	Abril	2	2023	Sábado
551	2023-04-23	23	4	Abril	2	2023	Domingo
552	2023-04-25	25	4	Abril	2	2023	Terça-feira
553	2023-04-26	26	4	Abril	2	2023	Quarta-feira
554	2023-04-27	27	4	Abril	2	2023	Quinta-feira
555	2023-04-28	28	4	Abril	2	2023	Sexta-feira
556	2023-04-29	29	4	Abril	2	2023	Sábado
557	2023-04-30	30	4	Abril	2	2023	Domingo
558	2023-05-01	1	5	Maio	2	2023	Segunda-feira
559	2023-05-03	3	5	Maio	2	2023	Quarta-feira
560	2023-05-05	5	5	Maio	2	2023	Sexta-feira
561	2023-05-06	6	5	Maio	2	2023	Sábado
562	2023-05-07	7	5	Maio	2	2023	Domingo
563	2023-05-08	8	5	Maio	2	2023	Segunda-feira
564	2023-05-09	9	5	Maio	2	2023	Terça-feira
565	2023-05-10	10	5	Maio	2	2023	Quarta-feira
566	2023-05-11	11	5	Maio	2	2023	Quinta-feira
567	2023-05-12	12	5	Maio	2	2023	Sexta-feira
568	2023-05-13	13	5	Maio	2	2023	Sábado
569	2023-05-14	14	5	Maio	2	2023	Domingo
570	2023-05-15	15	5	Maio	2	2023	Segunda-feira
571	2023-05-16	16	5	Maio	2	2023	Terça-feira
572	2023-05-18	18	5	Maio	2	2023	Quinta-feira
573	2023-05-19	19	5	Maio	2	2023	Sexta-feira
574	2023-05-20	20	5	Maio	2	2023	Sábado
575	2023-05-21	21	5	Maio	2	2023	Domingo
576	2023-05-23	23	5	Maio	2	2023	Terça-feira
577	2023-05-24	24	5	Maio	2	2023	Quarta-feira
578	2023-05-26	26	5	Maio	2	2023	Sexta-feira
579	2023-05-27	27	5	Maio	2	2023	Sábado
580	2023-05-30	30	5	Maio	2	2023	Terça-feira
581	2023-06-02	2	6	Junho	2	2023	Sexta-feira
582	2023-06-06	6	6	Junho	2	2023	Terça-feira
583	2023-06-07	7	6	Junho	2	2023	Quarta-feira
584	2023-06-08	8	6	Junho	2	2023	Quinta-feira
585	2023-06-09	9	6	Junho	2	2023	Sexta-feira
586	2023-06-10	10	6	Junho	2	2023	Sábado
587	2023-06-11	11	6	Junho	2	2023	Domingo
588	2023-06-12	12	6	Junho	2	2023	Segunda-feira
589	2023-06-13	13	6	Junho	2	2023	Terça-feira
590	2023-06-14	14	6	Junho	2	2023	Quarta-feira
591	2023-06-15	15	6	Junho	2	2023	Quinta-feira
592	2023-06-16	16	6	Junho	2	2023	Sexta-feira
593	2023-06-17	17	6	Junho	2	2023	Sábado
594	2023-06-18	18	6	Junho	2	2023	Domingo
595	2023-06-19	19	6	Junho	2	2023	Segunda-feira
596	2023-06-20	20	6	Junho	2	2023	Terça-feira
597	2023-06-21	21	6	Junho	2	2023	Quarta-feira
598	2023-06-22	22	6	Junho	2	2023	Quinta-feira
599	2023-06-23	23	6	Junho	2	2023	Sexta-feira
600	2023-06-24	24	6	Junho	2	2023	Sábado
601	2023-06-25	25	6	Junho	2	2023	Domingo
602	2023-06-26	26	6	Junho	2	2023	Segunda-feira
603	2023-06-30	30	6	Junho	2	2023	Sexta-feira
604	2023-07-02	2	7	Julho	3	2023	Domingo
605	2023-07-03	3	7	Julho	3	2023	Segunda-feira
606	2023-07-04	4	7	Julho	3	2023	Terça-feira
607	2023-07-05	5	7	Julho	3	2023	Quarta-feira
608	2023-07-06	6	7	Julho	3	2023	Quinta-feira
609	2023-07-07	7	7	Julho	3	2023	Sexta-feira
610	2023-07-09	9	7	Julho	3	2023	Domingo
611	2023-07-10	10	7	Julho	3	2023	Segunda-feira
612	2023-07-11	11	7	Julho	3	2023	Terça-feira
613	2023-07-12	12	7	Julho	3	2023	Quarta-feira
614	2023-07-13	13	7	Julho	3	2023	Quinta-feira
615	2023-07-14	14	7	Julho	3	2023	Sexta-feira
616	2023-07-15	15	7	Julho	3	2023	Sábado
617	2023-07-19	19	7	Julho	3	2023	Quarta-feira
618	2023-07-21	21	7	Julho	3	2023	Sexta-feira
619	2023-07-23	23	7	Julho	3	2023	Domingo
620	2023-07-24	24	7	Julho	3	2023	Segunda-feira
621	2023-07-26	26	7	Julho	3	2023	Quarta-feira
622	2023-07-27	27	7	Julho	3	2023	Quinta-feira
623	2023-07-28	28	7	Julho	3	2023	Sexta-feira
624	2023-07-29	29	7	Julho	3	2023	Sábado
625	2023-08-01	1	8	Agosto	3	2023	Terça-feira
626	2023-08-05	5	8	Agosto	3	2023	Sábado
627	2023-08-06	6	8	Agosto	3	2023	Domingo
628	2023-08-07	7	8	Agosto	3	2023	Segunda-feira
629	2023-08-08	8	8	Agosto	3	2023	Terça-feira
630	2023-08-09	9	8	Agosto	3	2023	Quarta-feira
631	2023-08-10	10	8	Agosto	3	2023	Quinta-feira
632	2023-08-11	11	8	Agosto	3	2023	Sexta-feira
633	2023-08-12	12	8	Agosto	3	2023	Sábado
634	2023-08-13	13	8	Agosto	3	2023	Domingo
635	2023-08-14	14	8	Agosto	3	2023	Segunda-feira
636	2023-08-15	15	8	Agosto	3	2023	Terça-feira
637	2023-08-16	16	8	Agosto	3	2023	Quarta-feira
638	2023-08-19	19	8	Agosto	3	2023	Sábado
639	2023-08-20	20	8	Agosto	3	2023	Domingo
640	2023-08-21	21	8	Agosto	3	2023	Segunda-feira
641	2023-08-22	22	8	Agosto	3	2023	Terça-feira
642	2023-08-23	23	8	Agosto	3	2023	Quarta-feira
643	2023-08-24	24	8	Agosto	3	2023	Quinta-feira
644	2023-08-25	25	8	Agosto	3	2023	Sexta-feira
645	2023-08-26	26	8	Agosto	3	2023	Sábado
647	2023-08-28	28	8	Agosto	3	2023	Segunda-feira
648	2023-09-01	1	9	Setembro	3	2023	Sexta-feira
649	2023-09-04	4	9	Setembro	3	2023	Segunda-feira
650	2023-09-06	6	9	Setembro	3	2023	Quarta-feira
651	2023-09-07	7	9	Setembro	3	2023	Quinta-feira
652	2023-09-12	12	9	Setembro	3	2023	Terça-feira
653	2023-09-13	13	9	Setembro	3	2023	Quarta-feira
654	2023-09-14	14	9	Setembro	3	2023	Quinta-feira
655	2023-09-15	15	9	Setembro	3	2023	Sexta-feira
656	2023-09-16	16	9	Setembro	3	2023	Sábado
657	2023-09-17	17	9	Setembro	3	2023	Domingo
658	2023-09-21	21	9	Setembro	3	2023	Quinta-feira
659	2023-09-24	24	9	Setembro	3	2023	Domingo
660	2023-09-26	26	9	Setembro	3	2023	Terça-feira
661	2023-09-27	27	9	Setembro	3	2023	Quarta-feira
662	2023-09-29	29	9	Setembro	3	2023	Sexta-feira
663	2023-09-30	30	9	Setembro	3	2023	Sábado
664	2023-10-01	1	10	Outubro	4	2023	Domingo
665	2023-10-02	2	10	Outubro	4	2023	Segunda-feira
666	2023-10-03	3	10	Outubro	4	2023	Terça-feira
667	2023-10-04	4	10	Outubro	4	2023	Quarta-feira
668	2023-10-06	6	10	Outubro	4	2023	Sexta-feira
669	2023-10-07	7	10	Outubro	4	2023	Sábado
670	2023-10-08	8	10	Outubro	4	2023	Domingo
671	2023-10-09	9	10	Outubro	4	2023	Segunda-feira
672	2023-10-12	12	10	Outubro	4	2023	Quinta-feira
673	2023-10-14	14	10	Outubro	4	2023	Sábado
674	2023-10-15	15	10	Outubro	4	2023	Domingo
675	2023-10-17	17	10	Outubro	4	2023	Terça-feira
676	2023-10-18	18	10	Outubro	4	2023	Quarta-feira
677	2023-10-19	19	10	Outubro	4	2023	Quinta-feira
678	2023-10-22	22	10	Outubro	4	2023	Domingo
679	2023-10-24	24	10	Outubro	4	2023	Terça-feira
680	2023-10-25	25	10	Outubro	4	2023	Quarta-feira
681	2023-10-26	26	10	Outubro	4	2023	Quinta-feira
682	2023-10-27	27	10	Outubro	4	2023	Sexta-feira
683	2023-10-28	28	10	Outubro	4	2023	Sábado
684	2023-10-30	30	10	Outubro	4	2023	Segunda-feira
685	2023-10-31	31	10	Outubro	4	2023	Terça-feira
686	2023-11-02	2	11	Novembro	4	2023	Quinta-feira
687	2023-11-04	4	11	Novembro	4	2023	Sábado
688	2023-11-05	5	11	Novembro	4	2023	Domingo
689	2023-11-07	7	11	Novembro	4	2023	Terça-feira
690	2023-11-09	9	11	Novembro	4	2023	Quinta-feira
691	2023-11-10	10	11	Novembro	4	2023	Sexta-feira
692	2023-11-11	11	11	Novembro	4	2023	Sábado
693	2023-11-13	13	11	Novembro	4	2023	Segunda-feira
694	2023-11-14	14	11	Novembro	4	2023	Terça-feira
695	2023-11-15	15	11	Novembro	4	2023	Quarta-feira
696	2023-11-16	16	11	Novembro	4	2023	Quinta-feira
697	2023-11-18	18	11	Novembro	4	2023	Sábado
698	2023-11-19	19	11	Novembro	4	2023	Domingo
699	2023-11-22	22	11	Novembro	4	2023	Quarta-feira
700	2023-11-24	24	11	Novembro	4	2023	Sexta-feira
701	2023-11-25	25	11	Novembro	4	2023	Sábado
702	2023-11-26	26	11	Novembro	4	2023	Domingo
703	2023-11-28	28	11	Novembro	4	2023	Terça-feira
704	2023-11-29	29	11	Novembro	4	2023	Quarta-feira
705	2023-11-30	30	11	Novembro	4	2023	Quinta-feira
706	2023-12-01	1	12	Dezembro	4	2023	Sexta-feira
707	2023-12-03	3	12	Dezembro	4	2023	Domingo
708	2023-12-04	4	12	Dezembro	4	2023	Segunda-feira
709	2023-12-05	5	12	Dezembro	4	2023	Terça-feira
710	2023-12-06	6	12	Dezembro	4	2023	Quarta-feira
711	2023-12-08	8	12	Dezembro	4	2023	Sexta-feira
712	2023-12-09	9	12	Dezembro	4	2023	Sábado
713	2023-12-11	11	12	Dezembro	4	2023	Segunda-feira
714	2023-12-12	12	12	Dezembro	4	2023	Terça-feira
715	2023-12-13	13	12	Dezembro	4	2023	Quarta-feira
716	2023-12-16	16	12	Dezembro	4	2023	Sábado
717	2023-12-17	17	12	Dezembro	4	2023	Domingo
718	2023-12-18	18	12	Dezembro	4	2023	Segunda-feira
719	2023-12-20	20	12	Dezembro	4	2023	Quarta-feira
720	2023-12-21	21	12	Dezembro	4	2023	Quinta-feira
721	2023-12-23	23	12	Dezembro	4	2023	Sábado
722	2023-12-24	24	12	Dezembro	4	2023	Domingo
723	2023-12-25	25	12	Dezembro	4	2023	Segunda-feira
724	2023-12-26	26	12	Dezembro	4	2023	Terça-feira
725	2023-12-27	27	12	Dezembro	4	2023	Quarta-feira
726	2023-12-28	28	12	Dezembro	4	2023	Quinta-feira
727	2023-12-29	29	12	Dezembro	4	2023	Sexta-feira
728	2023-12-30	30	12	Dezembro	4	2023	Sábado
729	2023-12-31	31	12	Dezembro	4	2023	Domingo
730	2024-01-04	4	1	Janeiro	1	2024	Quinta-feira
731	2024-01-05	5	1	Janeiro	1	2024	Sexta-feira
732	2024-01-06	6	1	Janeiro	1	2024	Sábado
733	2024-01-07	7	1	Janeiro	1	2024	Domingo
734	2024-01-08	8	1	Janeiro	1	2024	Segunda-feira
735	2024-01-09	9	1	Janeiro	1	2024	Terça-feira
736	2024-01-10	10	1	Janeiro	1	2024	Quarta-feira
737	2024-01-11	11	1	Janeiro	1	2024	Quinta-feira
738	2024-01-12	12	1	Janeiro	1	2024	Sexta-feira
739	2024-01-13	13	1	Janeiro	1	2024	Sábado
740	2024-01-14	14	1	Janeiro	1	2024	Domingo
741	2024-01-15	15	1	Janeiro	1	2024	Segunda-feira
742	2024-01-16	16	1	Janeiro	1	2024	Terça-feira
743	2024-01-19	19	1	Janeiro	1	2024	Sexta-feira
744	2024-01-20	20	1	Janeiro	1	2024	Sábado
745	2024-01-24	24	1	Janeiro	1	2024	Quarta-feira
746	2024-01-25	25	1	Janeiro	1	2024	Quinta-feira
747	2024-01-26	26	1	Janeiro	1	2024	Sexta-feira
748	2024-01-27	27	1	Janeiro	1	2024	Sábado
749	2024-01-31	31	1	Janeiro	1	2024	Quarta-feira
750	2024-02-01	1	2	Fevereiro	1	2024	Quinta-feira
751	2024-02-04	4	2	Fevereiro	1	2024	Domingo
752	2024-02-05	5	2	Fevereiro	1	2024	Segunda-feira
753	2024-02-07	7	2	Fevereiro	1	2024	Quarta-feira
754	2024-02-09	9	2	Fevereiro	1	2024	Sexta-feira
755	2024-02-10	10	2	Fevereiro	1	2024	Sábado
756	2024-02-12	12	2	Fevereiro	1	2024	Segunda-feira
757	2024-02-13	13	2	Fevereiro	1	2024	Terça-feira
758	2024-02-15	15	2	Fevereiro	1	2024	Quinta-feira
759	2024-02-16	16	2	Fevereiro	1	2024	Sexta-feira
760	2024-02-17	17	2	Fevereiro	1	2024	Sábado
761	2024-02-18	18	2	Fevereiro	1	2024	Domingo
762	2024-02-19	19	2	Fevereiro	1	2024	Segunda-feira
763	2024-02-23	23	2	Fevereiro	1	2024	Sexta-feira
764	2024-02-26	26	2	Fevereiro	1	2024	Segunda-feira
765	2024-02-27	27	2	Fevereiro	1	2024	Terça-feira
766	2024-02-28	28	2	Fevereiro	1	2024	Quarta-feira
767	2024-02-29	29	2	Fevereiro	1	2024	Quinta-feira
768	2024-03-01	1	3	Março	1	2024	Sexta-feira
769	2024-03-02	2	3	Março	1	2024	Sábado
770	2024-03-03	3	3	Março	1	2024	Domingo
771	2024-03-04	4	3	Março	1	2024	Segunda-feira
772	2024-03-06	6	3	Março	1	2024	Quarta-feira
773	2024-03-07	7	3	Março	1	2024	Quinta-feira
774	2024-03-08	8	3	Março	1	2024	Sexta-feira
775	2024-03-11	11	3	Março	1	2024	Segunda-feira
776	2024-03-12	12	3	Março	1	2024	Terça-feira
777	2024-03-15	15	3	Março	1	2024	Sexta-feira
778	2024-03-17	17	3	Março	1	2024	Domingo
779	2024-03-18	18	3	Março	1	2024	Segunda-feira
780	2024-03-19	19	3	Março	1	2024	Terça-feira
781	2024-03-21	21	3	Março	1	2024	Quinta-feira
782	2024-03-22	22	3	Março	1	2024	Sexta-feira
783	2024-03-25	25	3	Março	1	2024	Segunda-feira
784	2024-03-26	26	3	Março	1	2024	Terça-feira
785	2024-03-27	27	3	Março	1	2024	Quarta-feira
786	2024-03-28	28	3	Março	1	2024	Quinta-feira
787	2024-03-29	29	3	Março	1	2024	Sexta-feira
788	2024-04-01	1	4	Abril	2	2024	Segunda-feira
789	2024-04-02	2	4	Abril	2	2024	Terça-feira
790	2024-04-03	3	4	Abril	2	2024	Quarta-feira
791	2024-04-04	4	4	Abril	2	2024	Quinta-feira
792	2024-04-05	5	4	Abril	2	2024	Sexta-feira
793	2024-04-06	6	4	Abril	2	2024	Sábado
794	2024-04-07	7	4	Abril	2	2024	Domingo
795	2024-04-08	8	4	Abril	2	2024	Segunda-feira
796	2024-04-09	9	4	Abril	2	2024	Terça-feira
797	2024-04-13	13	4	Abril	2	2024	Sábado
798	2024-04-16	16	4	Abril	2	2024	Terça-feira
799	2024-04-18	18	4	Abril	2	2024	Quinta-feira
800	2024-04-19	19	4	Abril	2	2024	Sexta-feira
801	2024-04-20	20	4	Abril	2	2024	Sábado
802	2024-04-23	23	4	Abril	2	2024	Terça-feira
803	2024-04-24	24	4	Abril	2	2024	Quarta-feira
804	2024-04-26	26	4	Abril	2	2024	Sexta-feira
805	2024-04-27	27	4	Abril	2	2024	Sábado
806	2024-04-28	28	4	Abril	2	2024	Domingo
807	2024-04-29	29	4	Abril	2	2024	Segunda-feira
808	2024-05-01	1	5	Maio	2	2024	Quarta-feira
809	2024-05-02	2	5	Maio	2	2024	Quinta-feira
810	2024-05-03	3	5	Maio	2	2024	Sexta-feira
811	2024-05-04	4	5	Maio	2	2024	Sábado
812	2024-05-08	8	5	Maio	2	2024	Quarta-feira
813	2024-05-09	9	5	Maio	2	2024	Quinta-feira
814	2024-05-10	10	5	Maio	2	2024	Sexta-feira
815	2024-05-11	11	5	Maio	2	2024	Sábado
816	2024-05-12	12	5	Maio	2	2024	Domingo
817	2024-05-17	17	5	Maio	2	2024	Sexta-feira
818	2024-05-18	18	5	Maio	2	2024	Sábado
819	2024-05-20	20	5	Maio	2	2024	Segunda-feira
820	2024-05-21	21	5	Maio	2	2024	Terça-feira
821	2024-05-22	22	5	Maio	2	2024	Quarta-feira
822	2024-05-25	25	5	Maio	2	2024	Sábado
823	2024-05-26	26	5	Maio	2	2024	Domingo
824	2024-05-27	27	5	Maio	2	2024	Segunda-feira
825	2024-05-29	29	5	Maio	2	2024	Quarta-feira
826	2024-05-30	30	5	Maio	2	2024	Quinta-feira
827	2024-05-31	31	5	Maio	2	2024	Sexta-feira
828	2024-06-01	1	6	Junho	2	2024	Sábado
829	2024-06-02	2	6	Junho	2	2024	Domingo
830	2024-06-03	3	6	Junho	2	2024	Segunda-feira
831	2024-06-04	4	6	Junho	2	2024	Terça-feira
832	2024-06-05	5	6	Junho	2	2024	Quarta-feira
833	2024-06-07	7	6	Junho	2	2024	Sexta-feira
834	2024-06-08	8	6	Junho	2	2024	Sábado
835	2024-06-09	9	6	Junho	2	2024	Domingo
836	2024-06-11	11	6	Junho	2	2024	Terça-feira
837	2024-06-15	15	6	Junho	2	2024	Sábado
838	2024-06-16	16	6	Junho	2	2024	Domingo
839	2024-06-17	17	6	Junho	2	2024	Segunda-feira
840	2024-06-18	18	6	Junho	2	2024	Terça-feira
841	2024-06-19	19	6	Junho	2	2024	Quarta-feira
842	2024-06-20	20	6	Junho	2	2024	Quinta-feira
843	2024-06-23	23	6	Junho	2	2024	Domingo
844	2024-06-24	24	6	Junho	2	2024	Segunda-feira
845	2024-06-25	25	6	Junho	2	2024	Terça-feira
846	2024-06-26	26	6	Junho	2	2024	Quarta-feira
847	2024-06-27	27	6	Junho	2	2024	Quinta-feira
848	2024-06-28	28	6	Junho	2	2024	Sexta-feira
849	2024-06-29	29	6	Junho	2	2024	Sábado
850	2024-06-30	30	6	Junho	2	2024	Domingo
851	2024-07-02	2	7	Julho	3	2024	Terça-feira
852	2024-07-04	4	7	Julho	3	2024	Quinta-feira
853	2024-07-05	5	7	Julho	3	2024	Sexta-feira
854	2024-07-06	6	7	Julho	3	2024	Sábado
855	2024-07-07	7	7	Julho	3	2024	Domingo
856	2024-07-08	8	7	Julho	3	2024	Segunda-feira
857	2024-07-12	12	7	Julho	3	2024	Sexta-feira
858	2024-07-15	15	7	Julho	3	2024	Segunda-feira
859	2024-07-18	18	7	Julho	3	2024	Quinta-feira
860	2024-07-20	20	7	Julho	3	2024	Sábado
862	2024-07-23	23	7	Julho	3	2024	Terça-feira
863	2024-07-25	25	7	Julho	3	2024	Quinta-feira
864	2024-07-28	28	7	Julho	3	2024	Domingo
865	2024-07-30	30	7	Julho	3	2024	Terça-feira
866	2024-08-01	1	8	Agosto	3	2024	Quinta-feira
867	2024-08-03	3	8	Agosto	3	2024	Sábado
868	2024-08-05	5	8	Agosto	3	2024	Segunda-feira
869	2024-08-06	6	8	Agosto	3	2024	Terça-feira
870	2024-08-08	8	8	Agosto	3	2024	Quinta-feira
871	2024-08-09	9	8	Agosto	3	2024	Sexta-feira
872	2024-08-11	11	8	Agosto	3	2024	Domingo
873	2024-08-12	12	8	Agosto	3	2024	Segunda-feira
874	2024-08-13	13	8	Agosto	3	2024	Terça-feira
875	2024-08-14	14	8	Agosto	3	2024	Quarta-feira
876	2024-08-15	15	8	Agosto	3	2024	Quinta-feira
877	2024-08-16	16	8	Agosto	3	2024	Sexta-feira
878	2024-08-17	17	8	Agosto	3	2024	Sábado
879	2024-08-21	21	8	Agosto	3	2024	Quarta-feira
880	2024-08-23	23	8	Agosto	3	2024	Sexta-feira
881	2024-08-24	24	8	Agosto	3	2024	Sábado
882	2024-08-27	27	8	Agosto	3	2024	Terça-feira
883	2024-08-28	28	8	Agosto	3	2024	Quarta-feira
884	2024-08-30	30	8	Agosto	3	2024	Sexta-feira
885	2024-08-31	31	8	Agosto	3	2024	Sábado
886	2024-09-02	2	9	Setembro	3	2024	Segunda-feira
887	2024-09-03	3	9	Setembro	3	2024	Terça-feira
888	2024-09-05	5	9	Setembro	3	2024	Quinta-feira
889	2024-09-06	6	9	Setembro	3	2024	Sexta-feira
890	2024-09-07	7	9	Setembro	3	2024	Sábado
891	2024-09-08	8	9	Setembro	3	2024	Domingo
892	2024-09-09	9	9	Setembro	3	2024	Segunda-feira
893	2024-09-10	10	9	Setembro	3	2024	Terça-feira
894	2024-09-11	11	9	Setembro	3	2024	Quarta-feira
895	2024-09-12	12	9	Setembro	3	2024	Quinta-feira
896	2024-09-13	13	9	Setembro	3	2024	Sexta-feira
897	2024-09-16	16	9	Setembro	3	2024	Segunda-feira
898	2024-09-17	17	9	Setembro	3	2024	Terça-feira
899	2024-09-19	19	9	Setembro	3	2024	Quinta-feira
900	2024-09-20	20	9	Setembro	3	2024	Sexta-feira
901	2024-09-22	22	9	Setembro	3	2024	Domingo
902	2024-09-23	23	9	Setembro	3	2024	Segunda-feira
903	2024-09-26	26	9	Setembro	3	2024	Quinta-feira
904	2024-09-27	27	9	Setembro	3	2024	Sexta-feira
905	2024-09-30	30	9	Setembro	3	2024	Segunda-feira
906	2024-10-01	1	10	Outubro	4	2024	Terça-feira
907	2024-10-02	2	10	Outubro	4	2024	Quarta-feira
908	2024-10-03	3	10	Outubro	4	2024	Quinta-feira
909	2024-10-05	5	10	Outubro	4	2024	Sábado
910	2024-10-06	6	10	Outubro	4	2024	Domingo
911	2024-10-07	7	10	Outubro	4	2024	Segunda-feira
912	2024-10-10	10	10	Outubro	4	2024	Quinta-feira
913	2024-10-11	11	10	Outubro	4	2024	Sexta-feira
914	2024-10-12	12	10	Outubro	4	2024	Sábado
915	2024-10-14	14	10	Outubro	4	2024	Segunda-feira
916	2024-10-15	15	10	Outubro	4	2024	Terça-feira
917	2024-10-17	17	10	Outubro	4	2024	Quinta-feira
918	2024-10-18	18	10	Outubro	4	2024	Sexta-feira
919	2024-10-19	19	10	Outubro	4	2024	Sábado
920	2024-10-20	20	10	Outubro	4	2024	Domingo
921	2024-10-21	21	10	Outubro	4	2024	Segunda-feira
922	2024-10-22	22	10	Outubro	4	2024	Terça-feira
923	2024-10-24	24	10	Outubro	4	2024	Quinta-feira
924	2024-10-25	25	10	Outubro	4	2024	Sexta-feira
925	2024-10-27	27	10	Outubro	4	2024	Domingo
926	2024-10-28	28	10	Outubro	4	2024	Segunda-feira
927	2024-10-29	29	10	Outubro	4	2024	Terça-feira
928	2024-10-31	31	10	Outubro	4	2024	Quinta-feira
929	2024-11-02	2	11	Novembro	4	2024	Sábado
930	2024-11-03	3	11	Novembro	4	2024	Domingo
931	2024-11-04	4	11	Novembro	4	2024	Segunda-feira
932	2024-11-05	5	11	Novembro	4	2024	Terça-feira
933	2024-11-06	6	11	Novembro	4	2024	Quarta-feira
934	2024-11-07	7	11	Novembro	4	2024	Quinta-feira
935	2024-11-09	9	11	Novembro	4	2024	Sábado
936	2024-11-10	10	11	Novembro	4	2024	Domingo
937	2024-11-11	11	11	Novembro	4	2024	Segunda-feira
938	2024-11-14	14	11	Novembro	4	2024	Quinta-feira
939	2024-11-15	15	11	Novembro	4	2024	Sexta-feira
940	2024-11-16	16	11	Novembro	4	2024	Sábado
941	2024-11-17	17	11	Novembro	4	2024	Domingo
942	2024-11-18	18	11	Novembro	4	2024	Segunda-feira
943	2024-11-19	19	11	Novembro	4	2024	Terça-feira
944	2024-11-20	20	11	Novembro	4	2024	Quarta-feira
945	2024-11-21	21	11	Novembro	4	2024	Quinta-feira
946	2024-11-22	22	11	Novembro	4	2024	Sexta-feira
947	2024-11-25	25	11	Novembro	4	2024	Segunda-feira
948	2024-11-28	28	11	Novembro	4	2024	Quinta-feira
949	2024-11-29	29	11	Novembro	4	2024	Sexta-feira
950	2024-12-01	1	12	Dezembro	4	2024	Domingo
951	2024-12-03	3	12	Dezembro	4	2024	Terça-feira
952	2024-12-05	5	12	Dezembro	4	2024	Quinta-feira
953	2024-12-07	7	12	Dezembro	4	2024	Sábado
954	2024-12-08	8	12	Dezembro	4	2024	Domingo
955	2024-12-16	16	12	Dezembro	4	2024	Segunda-feira
956	2024-12-19	19	12	Dezembro	4	2024	Quinta-feira
957	2024-12-20	20	12	Dezembro	4	2024	Sexta-feira
958	2024-12-21	21	12	Dezembro	4	2024	Sábado
959	2024-12-22	22	12	Dezembro	4	2024	Domingo
960	2024-12-23	23	12	Dezembro	4	2024	Segunda-feira
961	2024-12-24	24	12	Dezembro	4	2024	Terça-feira
962	2024-12-26	26	12	Dezembro	4	2024	Quinta-feira
963	2024-12-27	27	12	Dezembro	4	2024	Sexta-feira
964	2024-12-28	28	12	Dezembro	4	2024	Sábado
965	2024-12-29	29	12	Dezembro	4	2024	Domingo
966	2025-01-01	1	1	Janeiro	1	2025	Quarta-feira
967	2025-01-02	2	1	Janeiro	1	2025	Quinta-feira
968	2025-01-05	5	1	Janeiro	1	2025	Domingo
969	2025-01-07	7	1	Janeiro	1	2025	Terça-feira
970	2025-01-08	8	1	Janeiro	1	2025	Quarta-feira
971	2025-01-09	9	1	Janeiro	1	2025	Quinta-feira
972	2025-01-12	12	1	Janeiro	1	2025	Domingo
973	2025-01-16	16	1	Janeiro	1	2025	Quinta-feira
974	2025-01-17	17	1	Janeiro	1	2025	Sexta-feira
975	2025-01-19	19	1	Janeiro	1	2025	Domingo
976	2025-01-21	21	1	Janeiro	1	2025	Terça-feira
977	2025-01-22	22	1	Janeiro	1	2025	Quarta-feira
978	2025-01-23	23	1	Janeiro	1	2025	Quinta-feira
979	2025-01-24	24	1	Janeiro	1	2025	Sexta-feira
980	2025-01-25	25	1	Janeiro	1	2025	Sábado
981	2025-01-27	27	1	Janeiro	1	2025	Segunda-feira
982	2025-02-01	1	2	Fevereiro	1	2025	Sábado
983	2025-02-03	3	2	Fevereiro	1	2025	Segunda-feira
984	2025-02-04	4	2	Fevereiro	1	2025	Terça-feira
985	2025-02-05	5	2	Fevereiro	1	2025	Quarta-feira
986	2025-02-07	7	2	Fevereiro	1	2025	Sexta-feira
987	2025-02-08	8	2	Fevereiro	1	2025	Sábado
988	2025-02-11	11	2	Fevereiro	1	2025	Terça-feira
989	2025-02-12	12	2	Fevereiro	1	2025	Quarta-feira
990	2025-02-14	14	2	Fevereiro	1	2025	Sexta-feira
991	2025-02-17	17	2	Fevereiro	1	2025	Segunda-feira
992	2025-02-19	19	2	Fevereiro	1	2025	Quarta-feira
993	2025-02-20	20	2	Fevereiro	1	2025	Quinta-feira
994	2025-02-21	21	2	Fevereiro	1	2025	Sexta-feira
995	2025-02-22	22	2	Fevereiro	1	2025	Sábado
996	2025-02-24	24	2	Fevereiro	1	2025	Segunda-feira
997	2025-02-26	26	2	Fevereiro	1	2025	Quarta-feira
998	2025-02-27	27	2	Fevereiro	1	2025	Quinta-feira
999	2025-02-28	28	2	Fevereiro	1	2025	Sexta-feira
1000	2025-03-01	1	3	Março	1	2025	Sábado
1001	2025-03-03	3	3	Março	1	2025	Segunda-feira
1002	2025-03-04	4	3	Março	1	2025	Terça-feira
1003	2025-03-06	6	3	Março	1	2025	Quinta-feira
1004	2025-03-08	8	3	Março	1	2025	Sábado
1005	2025-03-10	10	3	Março	1	2025	Segunda-feira
1006	2025-03-11	11	3	Março	1	2025	Terça-feira
1007	2025-03-13	13	3	Março	1	2025	Quinta-feira
1008	2025-03-18	18	3	Março	1	2025	Terça-feira
1009	2025-03-19	19	3	Março	1	2025	Quarta-feira
1010	2025-03-20	20	3	Março	1	2025	Quinta-feira
1011	2025-03-21	21	3	Março	1	2025	Sexta-feira
1012	2025-03-23	23	3	Março	1	2025	Domingo
1013	2025-03-25	25	3	Março	1	2025	Terça-feira
1014	2025-03-26	26	3	Março	1	2025	Quarta-feira
1015	2025-03-27	27	3	Março	1	2025	Quinta-feira
1016	2025-03-28	28	3	Março	1	2025	Sexta-feira
1017	2025-03-29	29	3	Março	1	2025	Sábado
1018	2025-03-31	31	3	Março	1	2025	Segunda-feira
1019	2025-04-01	1	4	Abril	2	2025	Terça-feira
1020	2025-04-02	2	4	Abril	2	2025	Quarta-feira
1021	2025-04-03	3	4	Abril	2	2025	Quinta-feira
1022	2025-04-04	4	4	Abril	2	2025	Sexta-feira
1023	2025-04-06	6	4	Abril	2	2025	Domingo
1024	2025-04-07	7	4	Abril	2	2025	Segunda-feira
1025	2025-04-09	9	4	Abril	2	2025	Quarta-feira
1026	2025-04-10	10	4	Abril	2	2025	Quinta-feira
1027	2025-04-11	11	4	Abril	2	2025	Sexta-feira
1028	2025-04-12	12	4	Abril	2	2025	Sábado
1029	2025-04-13	13	4	Abril	2	2025	Domingo
1030	2025-04-17	17	4	Abril	2	2025	Quinta-feira
1031	2025-04-18	18	4	Abril	2	2025	Sexta-feira
1032	2025-04-21	21	4	Abril	2	2025	Segunda-feira
1033	2025-04-22	22	4	Abril	2	2025	Terça-feira
1034	2025-04-23	23	4	Abril	2	2025	Quarta-feira
1035	2025-04-24	24	4	Abril	2	2025	Quinta-feira
1036	2025-04-25	25	4	Abril	2	2025	Sexta-feira
1037	2025-04-26	26	4	Abril	2	2025	Sábado
1038	2025-04-27	27	4	Abril	2	2025	Domingo
1039	2025-04-28	28	4	Abril	2	2025	Segunda-feira
1040	2025-04-30	30	4	Abril	2	2025	Quarta-feira
1041	2025-05-01	1	5	Maio	2	2025	Quinta-feira
1042	2025-05-02	2	5	Maio	2	2025	Sexta-feira
1043	2025-05-03	3	5	Maio	2	2025	Sábado
1044	2025-05-07	7	5	Maio	2	2025	Quarta-feira
1045	2025-05-08	8	5	Maio	2	2025	Quinta-feira
1046	2025-05-11	11	5	Maio	2	2025	Domingo
1047	2025-05-12	12	5	Maio	2	2025	Segunda-feira
1048	2025-05-13	13	5	Maio	2	2025	Terça-feira
1049	2025-05-14	14	5	Maio	2	2025	Quarta-feira
1050	2025-05-15	15	5	Maio	2	2025	Quinta-feira
1051	2025-05-16	16	5	Maio	2	2025	Sexta-feira
1052	2025-05-19	19	5	Maio	2	2025	Segunda-feira
1053	2025-05-20	20	5	Maio	2	2025	Terça-feira
1054	2025-05-21	21	5	Maio	2	2025	Quarta-feira
1055	2025-05-22	22	5	Maio	2	2025	Quinta-feira
1056	2025-05-23	23	5	Maio	2	2025	Sexta-feira
1057	2025-05-27	27	5	Maio	2	2025	Terça-feira
1058	2025-05-28	28	5	Maio	2	2025	Quarta-feira
1059	2025-05-31	31	5	Maio	2	2025	Sábado
1060	2025-06-01	1	6	Junho	2	2025	Domingo
1061	2025-06-02	2	6	Junho	2	2025	Segunda-feira
1062	2025-06-03	3	6	Junho	2	2025	Terça-feira
1063	2025-06-04	4	6	Junho	2	2025	Quarta-feira
1064	2025-06-07	7	6	Junho	2	2025	Sábado
1065	2025-06-09	9	6	Junho	2	2025	Segunda-feira
1066	2025-06-10	10	6	Junho	2	2025	Terça-feira
1067	2025-06-12	12	6	Junho	2	2025	Quinta-feira
1068	2025-06-13	13	6	Junho	2	2025	Sexta-feira
1069	2025-06-14	14	6	Junho	2	2025	Sábado
1070	2025-06-15	15	6	Junho	2	2025	Domingo
1071	2025-06-17	17	6	Junho	2	2025	Terça-feira
1072	2025-06-20	20	6	Junho	2	2025	Sexta-feira
1073	2025-06-21	21	6	Junho	2	2025	Sábado
1074	2025-06-23	23	6	Junho	2	2025	Segunda-feira
1075	2025-06-24	24	6	Junho	2	2025	Terça-feira
1076	2025-06-25	25	6	Junho	2	2025	Quarta-feira
1077	2025-06-27	27	6	Junho	2	2025	Sexta-feira
1078	2025-07-01	1	7	Julho	3	2025	Terça-feira
1079	2025-07-06	6	7	Julho	3	2025	Domingo
1080	2025-07-07	7	7	Julho	3	2025	Segunda-feira
1081	2025-07-09	9	7	Julho	3	2025	Quarta-feira
1082	2025-07-10	10	7	Julho	3	2025	Quinta-feira
1083	2025-07-11	11	7	Julho	3	2025	Sexta-feira
1084	2025-07-12	12	7	Julho	3	2025	Sábado
1085	2025-07-14	14	7	Julho	3	2025	Segunda-feira
1086	2025-07-16	16	7	Julho	3	2025	Quarta-feira
1087	2025-07-17	17	7	Julho	3	2025	Quinta-feira
1088	2025-07-18	18	7	Julho	3	2025	Sexta-feira
1089	2025-07-19	19	7	Julho	3	2025	Sábado
1090	2025-07-21	21	7	Julho	3	2025	Segunda-feira
1091	2025-07-22	22	7	Julho	3	2025	Terça-feira
1092	2025-07-23	23	7	Julho	3	2025	Quarta-feira
1093	2025-07-24	24	7	Julho	3	2025	Quinta-feira
1094	2025-07-25	25	7	Julho	3	2025	Sexta-feira
1095	2025-07-26	26	7	Julho	3	2025	Sábado
1096	2025-07-29	29	7	Julho	3	2025	Terça-feira
1097	2025-07-30	30	7	Julho	3	2025	Quarta-feira
1098	2025-08-01	1	8	Agosto	3	2025	Sexta-feira
1099	2025-08-02	2	8	Agosto	3	2025	Sábado
1100	2025-08-03	3	8	Agosto	3	2025	Domingo
1101	2025-08-04	4	8	Agosto	3	2025	Segunda-feira
1102	2025-08-05	5	8	Agosto	3	2025	Terça-feira
1103	2025-08-06	6	8	Agosto	3	2025	Quarta-feira
1104	2025-08-08	8	8	Agosto	3	2025	Sexta-feira
1105	2025-08-09	9	8	Agosto	3	2025	Sábado
1106	2025-08-10	10	8	Agosto	3	2025	Domingo
1107	2025-08-11	11	8	Agosto	3	2025	Segunda-feira
1108	2025-08-15	15	8	Agosto	3	2025	Sexta-feira
1109	2025-08-17	17	8	Agosto	3	2025	Domingo
1110	2025-08-18	18	8	Agosto	3	2025	Segunda-feira
1111	2025-08-19	19	8	Agosto	3	2025	Terça-feira
1112	2025-08-20	20	8	Agosto	3	2025	Quarta-feira
1113	2025-08-22	22	8	Agosto	3	2025	Sexta-feira
1114	2025-08-23	23	8	Agosto	3	2025	Sábado
1115	2025-08-24	24	8	Agosto	3	2025	Domingo
1116	2025-08-25	25	8	Agosto	3	2025	Segunda-feira
1117	2025-08-26	26	8	Agosto	3	2025	Terça-feira
1118	2025-08-27	27	8	Agosto	3	2025	Quarta-feira
1119	2025-08-28	28	8	Agosto	3	2025	Quinta-feira
1120	2025-08-30	30	8	Agosto	3	2025	Sábado
1121	2025-08-31	31	8	Agosto	3	2025	Domingo
1122	2025-09-02	2	9	Setembro	3	2025	Terça-feira
1123	2025-09-03	3	9	Setembro	3	2025	Quarta-feira
1124	2025-09-05	5	9	Setembro	3	2025	Sexta-feira
1125	2025-09-06	6	9	Setembro	3	2025	Sábado
1126	2025-09-07	7	9	Setembro	3	2025	Domingo
1127	2025-09-08	8	9	Setembro	3	2025	Segunda-feira
1128	2025-09-09	9	9	Setembro	3	2025	Terça-feira
1129	2025-09-10	10	9	Setembro	3	2025	Quarta-feira
1130	2025-09-11	11	9	Setembro	3	2025	Quinta-feira
1131	2025-09-12	12	9	Setembro	3	2025	Sexta-feira
1132	2025-09-13	13	9	Setembro	3	2025	Sábado
1133	2025-09-14	14	9	Setembro	3	2025	Domingo
1134	2025-09-15	15	9	Setembro	3	2025	Segunda-feira
1135	2025-09-17	17	9	Setembro	3	2025	Quarta-feira
1136	2025-09-18	18	9	Setembro	3	2025	Quinta-feira
1137	2025-09-19	19	9	Setembro	3	2025	Sexta-feira
1138	2025-09-20	20	9	Setembro	3	2025	Sábado
1139	2025-09-22	22	9	Setembro	3	2025	Segunda-feira
1140	2025-09-23	23	9	Setembro	3	2025	Terça-feira
1141	2025-09-24	24	9	Setembro	3	2025	Quarta-feira
1142	2025-09-25	25	9	Setembro	3	2025	Quinta-feira
1143	2025-09-26	26	9	Setembro	3	2025	Sexta-feira
1144	2025-09-27	27	9	Setembro	3	2025	Sábado
1145	2025-09-28	28	9	Setembro	3	2025	Domingo
1146	2025-10-02	2	10	Outubro	4	2025	Quinta-feira
1147	2025-10-04	4	10	Outubro	4	2025	Sábado
1148	2025-10-05	5	10	Outubro	4	2025	Domingo
1149	2025-10-07	7	10	Outubro	4	2025	Terça-feira
1150	2025-10-08	8	10	Outubro	4	2025	Quarta-feira
1151	2025-10-10	10	10	Outubro	4	2025	Sexta-feira
1152	2025-10-11	11	10	Outubro	4	2025	Sábado
1153	2025-10-12	12	10	Outubro	4	2025	Domingo
1154	2025-10-13	13	10	Outubro	4	2025	Segunda-feira
1155	2025-10-14	14	10	Outubro	4	2025	Terça-feira
1156	2025-10-16	16	10	Outubro	4	2025	Quinta-feira
1157	2025-10-17	17	10	Outubro	4	2025	Sexta-feira
1158	2025-10-19	19	10	Outubro	4	2025	Domingo
1159	2025-10-21	21	10	Outubro	4	2025	Terça-feira
1160	2025-10-23	23	10	Outubro	4	2025	Quinta-feira
1161	2025-10-24	24	10	Outubro	4	2025	Sexta-feira
1162	2025-10-25	25	10	Outubro	4	2025	Sábado
1163	2025-10-26	26	10	Outubro	4	2025	Domingo
1164	2025-10-29	29	10	Outubro	4	2025	Quarta-feira
1165	2025-10-30	30	10	Outubro	4	2025	Quinta-feira
1166	2025-10-31	31	10	Outubro	4	2025	Sexta-feira
1167	2025-11-01	1	11	Novembro	4	2025	Sábado
1168	2025-11-03	3	11	Novembro	4	2025	Segunda-feira
1169	2025-11-05	5	11	Novembro	4	2025	Quarta-feira
1170	2025-11-07	7	11	Novembro	4	2025	Sexta-feira
1171	2025-11-11	11	11	Novembro	4	2025	Terça-feira
1172	2025-11-12	12	11	Novembro	4	2025	Quarta-feira
1173	2025-11-14	14	11	Novembro	4	2025	Sexta-feira
1174	2025-11-15	15	11	Novembro	4	2025	Sábado
1175	2025-11-16	16	11	Novembro	4	2025	Domingo
1176	2025-11-18	18	11	Novembro	4	2025	Terça-feira
1177	2025-11-19	19	11	Novembro	4	2025	Quarta-feira
1178	2025-11-20	20	11	Novembro	4	2025	Quinta-feira
1179	2025-11-21	21	11	Novembro	4	2025	Sexta-feira
1180	2025-11-22	22	11	Novembro	4	2025	Sábado
1181	2025-11-24	24	11	Novembro	4	2025	Segunda-feira
1182	2025-11-27	27	11	Novembro	4	2025	Quinta-feira
1183	2025-11-29	29	11	Novembro	4	2025	Sábado
1184	2025-12-01	1	12	Dezembro	4	2025	Segunda-feira
1185	2025-12-03	3	12	Dezembro	4	2025	Quarta-feira
1186	2025-12-04	4	12	Dezembro	4	2025	Quinta-feira
1187	2025-12-05	5	12	Dezembro	4	2025	Sexta-feira
1188	2025-12-06	6	12	Dezembro	4	2025	Sábado
1189	2025-12-07	7	12	Dezembro	4	2025	Domingo
1190	2025-12-11	11	12	Dezembro	4	2025	Quinta-feira
1191	2025-12-12	12	12	Dezembro	4	2025	Sexta-feira
1192	2025-12-15	15	12	Dezembro	4	2025	Segunda-feira
1193	2025-12-17	17	12	Dezembro	4	2025	Quarta-feira
1194	2025-12-21	21	12	Dezembro	4	2025	Domingo
1195	2025-12-22	22	12	Dezembro	4	2025	Segunda-feira
1196	2025-12-24	24	12	Dezembro	4	2025	Quarta-feira
1197	2025-12-25	25	12	Dezembro	4	2025	Quinta-feira
1198	2025-12-29	29	12	Dezembro	4	2025	Segunda-feira
1199	2025-12-30	30	12	Dezembro	4	2025	Terça-feira
1200	2025-12-31	31	12	Dezembro	4	2025	Quarta-feira
\.


--
-- Data for Name: dim_transportadora; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dim_transportadora (sk_transportadora, id_transportadora, nome_transportadora, cnpj, id_regiao, prazo_entrega_dias) FROM stdin;
1	1	RodoMax Log	13.206.664/0001-53	1	6
2	2	JadLog	04.884.082/0001-35	1	4
3	3	Group X	41.541.486/0001-52	1	7
4	4	Tadex Transportes	60.652.120/0002-86	1	8
5	5	Trasnorte Transportes	18.650.773/0001-89	2	24
6	6	Speed Transportes	18.226.648/0001-46	2	20
7	7	Amazon Transportes	01.661.770/0018-96	2	26
8	8	Aceville Transportes	81.560.047/0001-01	3	9
9	9	Trânsito Brasil	92.528.538/0001-91	3	12
10	10	Alfa Transportes	82.110.818/0001-21	3	10
11	11	Pássaro Transportes	20.287.188/0006-12	4	15
12	12	Luz Transportes	17.344.049/0002-45	4	15
13	13	TPN - Transportadora Primeiro do Nordeste	15.129.315/0001-00	4	18
14	14	Expresso Rio Vermelho	07.655.407/0002-87	5	14
15	15	Manda-lá Transportes	03.298.420/0001-94	5	12
\.


--
-- Data for Name: fato_estoque; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fato_estoque (sk_estoque, sk_produto, sk_tempo, tipo_movimento, quantidade, saldo_atual) FROM stdin;
1	43	158	SAIDA	65	555
2	31	168	ENTRADA	87	213
3	35	240	SAIDA	19	306
4	48	328	ENTRADA	59	144
5	17	239	ENTRADA	80	705
6	3	73	ENTRADA	57	521
7	18	135	SAIDA	33	481
8	24	329	SAIDA	99	893
9	28	126	ENTRADA	9	54
10	32	57	SAIDA	35	881
11	47	209	SAIDA	92	462
12	21	197	ENTRADA	100	427
13	9	189	ENTRADA	59	792
14	29	17	SAIDA	100	917
15	35	336	SAIDA	4	249
16	9	218	SAIDA	30	611
17	19	266	ENTRADA	34	529
18	5	244	SAIDA	81	966
19	32	345	ENTRADA	88	643
20	10	27	SAIDA	78	594
21	4	54	ENTRADA	78	349
22	28	173	SAIDA	69	168
23	16	72	ENTRADA	32	334
24	9	139	ENTRADA	96	350
25	5	289	ENTRADA	94	115
26	41	87	SAIDA	78	294
27	47	214	ENTRADA	46	444
28	23	237	ENTRADA	43	643
29	42	266	ENTRADA	44	979
30	41	355	ENTRADA	65	801
31	12	11	ENTRADA	30	657
32	39	76	ENTRADA	36	706
33	45	269	SAIDA	32	759
34	20	225	ENTRADA	24	902
35	46	55	ENTRADA	74	417
36	48	241	ENTRADA	47	842
37	21	69	SAIDA	66	798
38	6	142	SAIDA	88	511
39	28	255	SAIDA	78	55
40	14	170	SAIDA	28	844
41	26	137	ENTRADA	47	296
42	12	322	ENTRADA	83	261
43	39	99	ENTRADA	85	802
44	41	229	SAIDA	2	401
45	10	315	SAIDA	69	356
46	39	304	SAIDA	52	466
47	33	354	SAIDA	33	306
48	19	54	SAIDA	71	692
49	19	239	ENTRADA	59	209
50	37	158	ENTRADA	11	354
51	14	276	ENTRADA	90	759
52	31	155	ENTRADA	51	66
53	10	360	ENTRADA	87	626
54	27	291	ENTRADA	13	176
55	43	42	ENTRADA	97	790
56	32	77	ENTRADA	81	170
57	5	2	SAIDA	33	463
58	42	253	SAIDA	18	810
59	15	74	SAIDA	82	599
60	25	149	ENTRADA	2	746
61	35	55	ENTRADA	10	134
62	34	299	ENTRADA	55	264
63	33	236	SAIDA	4	66
64	4	16	ENTRADA	86	76
65	27	54	ENTRADA	33	389
66	49	86	ENTRADA	3	558
67	27	232	SAIDA	95	492
68	41	65	SAIDA	64	374
69	21	44	ENTRADA	70	974
70	13	35	SAIDA	18	961
71	50	64	SAIDA	8	115
72	11	193	SAIDA	51	880
73	40	187	SAIDA	2	640
74	50	172	ENTRADA	82	147
75	7	203	ENTRADA	21	662
76	32	99	ENTRADA	62	976
77	33	33	ENTRADA	24	979
78	42	315	ENTRADA	79	651
79	34	113	ENTRADA	83	961
80	40	305	SAIDA	4	518
81	36	339	ENTRADA	8	236
82	5	22	SAIDA	51	764
83	34	255	SAIDA	23	486
84	18	115	ENTRADA	84	841
85	39	330	SAIDA	39	920
86	26	317	SAIDA	19	226
87	5	132	ENTRADA	92	241
88	19	239	ENTRADA	20	451
89	10	51	ENTRADA	4	65
90	12	317	ENTRADA	43	736
91	22	105	SAIDA	26	364
92	6	266	ENTRADA	4	774
93	8	346	SAIDA	33	728
94	12	277	SAIDA	85	988
95	38	16	ENTRADA	68	82
96	47	177	ENTRADA	5	62
97	36	183	ENTRADA	82	139
98	16	281	SAIDA	45	962
99	1	238	SAIDA	47	341
100	41	297	ENTRADA	22	305
101	36	56	SAIDA	33	164
102	45	154	SAIDA	54	344
103	20	74	ENTRADA	2	288
104	24	100	SAIDA	19	930
105	32	344	SAIDA	70	252
106	34	326	ENTRADA	85	180
107	19	85	SAIDA	100	666
108	8	232	ENTRADA	14	871
109	38	124	SAIDA	28	946
110	46	165	ENTRADA	99	698
111	2	22	ENTRADA	41	553
112	46	219	SAIDA	30	102
113	44	136	SAIDA	89	156
114	9	43	ENTRADA	42	786
115	5	298	SAIDA	28	526
116	38	5	ENTRADA	50	879
117	6	200	SAIDA	98	90
118	19	47	SAIDA	50	922
119	17	234	ENTRADA	13	318
120	35	123	ENTRADA	10	115
121	16	91	ENTRADA	54	659
122	23	218	ENTRADA	14	468
123	2	273	ENTRADA	37	272
124	27	353	SAIDA	94	817
125	13	42	ENTRADA	29	305
126	41	50	ENTRADA	60	364
127	42	192	ENTRADA	15	780
128	13	299	SAIDA	53	422
129	21	305	ENTRADA	6	596
130	49	119	ENTRADA	67	139
131	6	198	SAIDA	93	204
132	18	54	ENTRADA	56	550
133	10	296	ENTRADA	82	577
134	28	131	SAIDA	52	544
135	6	194	ENTRADA	2	141
136	28	73	ENTRADA	41	697
137	13	10	SAIDA	3	318
138	41	213	ENTRADA	89	659
139	33	235	SAIDA	19	310
140	4	201	ENTRADA	14	733
141	26	163	ENTRADA	6	941
142	26	154	ENTRADA	95	65
143	8	362	ENTRADA	56	653
144	16	299	SAIDA	28	517
145	23	28	SAIDA	28	326
146	4	317	SAIDA	64	354
147	13	43	ENTRADA	72	187
148	32	243	ENTRADA	5	934
149	13	309	SAIDA	76	231
150	16	254	SAIDA	64	714
151	1	105	ENTRADA	76	664
152	8	336	ENTRADA	12	587
153	24	179	ENTRADA	34	804
154	24	323	SAIDA	49	747
155	4	223	ENTRADA	6	509
156	35	351	ENTRADA	8	852
157	2	305	SAIDA	100	277
158	42	125	ENTRADA	96	455
159	24	128	SAIDA	94	971
160	1	362	ENTRADA	5	829
161	2	184	SAIDA	77	343
162	16	213	ENTRADA	7	333
163	44	31	ENTRADA	74	68
164	15	119	SAIDA	38	430
165	12	271	ENTRADA	12	208
166	25	319	ENTRADA	53	572
167	14	264	ENTRADA	37	232
168	2	122	SAIDA	90	620
169	4	54	SAIDA	59	191
170	9	104	ENTRADA	89	58
171	8	252	SAIDA	22	815
172	10	163	SAIDA	1	872
173	8	346	ENTRADA	4	530
174	2	126	SAIDA	84	492
175	32	188	ENTRADA	61	271
176	41	145	SAIDA	95	586
177	35	16	ENTRADA	9	547
178	21	107	SAIDA	83	783
179	44	112	SAIDA	73	764
180	5	92	ENTRADA	18	760
181	12	94	ENTRADA	74	792
182	47	177	ENTRADA	76	119
183	25	60	SAIDA	61	280
184	22	242	SAIDA	56	911
185	17	47	SAIDA	62	546
186	20	294	ENTRADA	92	73
187	3	19	ENTRADA	93	711
188	18	123	ENTRADA	11	438
189	9	184	SAIDA	41	248
190	34	297	ENTRADA	75	804
191	12	186	SAIDA	97	230
192	15	157	ENTRADA	91	163
193	33	290	ENTRADA	59	170
194	12	246	SAIDA	14	908
195	42	197	ENTRADA	63	448
196	26	49	ENTRADA	74	968
197	26	327	SAIDA	17	761
198	15	37	SAIDA	72	128
199	41	272	SAIDA	20	906
200	15	242	SAIDA	68	153
201	20	75	SAIDA	10	639
202	36	297	SAIDA	34	676
203	40	244	ENTRADA	56	997
204	26	343	SAIDA	6	288
205	5	5	SAIDA	28	782
206	46	7	ENTRADA	15	108
207	35	154	ENTRADA	50	807
208	23	121	SAIDA	75	865
209	27	24	ENTRADA	96	363
210	8	232	ENTRADA	8	304
211	9	98	SAIDA	75	312
212	2	137	SAIDA	78	839
213	48	162	ENTRADA	99	172
214	40	255	ENTRADA	94	378
215	10	153	SAIDA	97	674
216	43	36	SAIDA	74	728
217	33	363	SAIDA	97	571
218	28	29	SAIDA	69	566
219	43	144	ENTRADA	77	356
220	17	28	SAIDA	7	375
221	26	89	ENTRADA	72	174
222	1	297	ENTRADA	81	129
223	35	321	ENTRADA	28	119
224	6	173	SAIDA	50	474
225	12	215	ENTRADA	84	748
226	37	360	ENTRADA	93	906
227	42	207	SAIDA	75	593
228	46	332	ENTRADA	42	126
229	29	45	SAIDA	78	789
230	44	10	ENTRADA	56	571
231	18	52	ENTRADA	93	326
232	8	69	SAIDA	13	444
233	38	304	SAIDA	37	548
234	23	76	SAIDA	68	75
235	21	8	ENTRADA	28	447
236	16	26	SAIDA	62	713
237	15	305	ENTRADA	4	739
238	4	160	ENTRADA	69	941
239	21	173	ENTRADA	59	472
240	36	339	SAIDA	50	438
241	18	268	SAIDA	28	798
242	41	102	ENTRADA	97	747
243	14	277	ENTRADA	40	688
244	32	287	ENTRADA	33	190
245	19	330	ENTRADA	55	521
246	25	320	SAIDA	45	620
247	37	268	SAIDA	36	620
248	3	89	SAIDA	8	607
249	26	176	SAIDA	44	359
250	45	158	SAIDA	95	560
251	16	230	ENTRADA	64	273
252	50	42	SAIDA	39	381
253	21	99	ENTRADA	32	863
254	19	244	ENTRADA	98	397
255	16	284	SAIDA	87	518
256	35	151	ENTRADA	31	899
257	41	4	SAIDA	73	677
258	29	111	ENTRADA	19	320
259	22	135	ENTRADA	46	290
260	41	246	ENTRADA	40	788
261	31	201	ENTRADA	27	169
262	49	198	SAIDA	40	413
263	17	117	ENTRADA	71	172
264	26	348	ENTRADA	57	443
265	26	247	SAIDA	58	934
266	49	28	SAIDA	67	500
267	6	199	ENTRADA	50	681
268	46	43	ENTRADA	30	974
269	8	254	ENTRADA	78	988
270	36	11	SAIDA	10	199
271	3	339	SAIDA	64	328
272	43	229	ENTRADA	31	374
273	44	211	ENTRADA	3	888
274	46	304	SAIDA	30	189
275	8	193	SAIDA	23	175
276	4	311	ENTRADA	30	707
277	42	253	ENTRADA	13	325
278	18	348	SAIDA	80	948
279	21	286	SAIDA	79	151
280	48	42	SAIDA	10	893
281	46	46	ENTRADA	94	703
282	25	180	ENTRADA	19	135
283	28	313	ENTRADA	10	90
284	21	241	ENTRADA	60	246
285	45	326	SAIDA	80	872
286	32	101	ENTRADA	90	256
287	25	288	ENTRADA	31	162
288	50	45	SAIDA	94	131
289	7	275	SAIDA	53	761
290	10	252	ENTRADA	82	430
291	23	281	ENTRADA	9	850
292	27	2	SAIDA	46	194
293	21	62	SAIDA	49	748
294	36	239	SAIDA	23	86
295	9	253	ENTRADA	91	371
296	29	275	SAIDA	46	835
297	49	287	ENTRADA	89	816
298	22	339	SAIDA	26	542
299	19	106	ENTRADA	74	345
300	10	185	ENTRADA	71	642
301	40	8	ENTRADA	44	715
302	2	152	SAIDA	76	666
303	23	189	ENTRADA	99	398
304	5	179	ENTRADA	52	543
305	14	244	ENTRADA	42	291
306	50	361	SAIDA	90	149
307	4	72	SAIDA	64	990
308	31	122	ENTRADA	5	988
309	46	65	ENTRADA	55	619
310	2	103	SAIDA	3	937
311	14	304	SAIDA	11	913
312	3	191	SAIDA	45	391
313	21	131	ENTRADA	58	98
314	50	169	ENTRADA	71	143
315	34	238	ENTRADA	32	332
316	48	256	SAIDA	88	892
317	20	190	SAIDA	7	518
318	34	188	ENTRADA	73	57
319	48	188	ENTRADA	99	604
320	24	61	ENTRADA	51	614
321	16	33	ENTRADA	8	378
322	17	289	SAIDA	1	721
323	14	19	ENTRADA	61	186
324	37	50	ENTRADA	79	842
325	30	102	ENTRADA	25	145
326	24	77	SAIDA	56	825
327	11	61	SAIDA	99	805
328	28	76	SAIDA	53	500
329	7	171	ENTRADA	63	629
330	35	193	ENTRADA	80	575
331	11	346	SAIDA	81	974
332	5	100	SAIDA	14	340
333	46	275	SAIDA	67	563
334	24	351	ENTRADA	37	892
335	40	105	ENTRADA	39	318
336	6	201	SAIDA	37	871
337	23	227	SAIDA	34	618
338	50	268	SAIDA	90	95
339	9	133	SAIDA	59	449
340	42	221	ENTRADA	22	269
341	27	314	SAIDA	91	244
342	17	172	SAIDA	2	232
343	1	31	SAIDA	10	334
344	46	290	SAIDA	77	744
345	2	225	SAIDA	4	151
346	45	144	SAIDA	59	970
347	34	351	SAIDA	81	463
348	34	85	ENTRADA	39	259
349	19	12	SAIDA	34	849
350	10	141	SAIDA	90	173
351	1	280	SAIDA	76	743
352	27	14	ENTRADA	21	273
353	25	245	SAIDA	63	281
354	45	337	ENTRADA	100	170
355	40	308	SAIDA	45	713
356	2	59	SAIDA	11	838
357	33	144	ENTRADA	31	641
358	37	173	SAIDA	46	150
359	22	168	SAIDA	85	67
360	40	64	SAIDA	76	413
361	27	364	ENTRADA	36	568
362	2	22	ENTRADA	54	770
363	19	7	ENTRADA	75	492
364	19	126	SAIDA	46	890
365	26	29	ENTRADA	6	476
366	50	232	ENTRADA	88	961
367	13	170	SAIDA	41	633
368	40	105	SAIDA	62	455
369	36	180	SAIDA	89	830
370	50	104	SAIDA	56	60
371	38	182	ENTRADA	11	871
372	36	184	SAIDA	88	734
373	28	48	ENTRADA	93	613
374	16	304	ENTRADA	8	259
375	30	99	ENTRADA	32	466
376	10	110	ENTRADA	45	579
377	17	356	ENTRADA	35	650
378	1	55	ENTRADA	35	886
379	10	305	SAIDA	96	564
380	49	14	ENTRADA	56	656
381	38	308	SAIDA	63	173
382	42	154	SAIDA	40	948
383	46	179	SAIDA	25	370
384	16	139	SAIDA	81	744
385	46	79	SAIDA	70	844
386	42	343	SAIDA	41	907
387	13	318	ENTRADA	70	905
388	10	326	ENTRADA	29	172
389	45	94	ENTRADA	81	400
390	8	79	ENTRADA	52	837
391	4	340	ENTRADA	96	275
392	16	86	ENTRADA	80	799
393	15	72	ENTRADA	100	703
394	30	283	SAIDA	38	747
395	31	113	ENTRADA	32	843
396	47	274	ENTRADA	51	117
397	11	26	SAIDA	1	115
398	10	289	SAIDA	53	576
399	15	27	ENTRADA	50	962
400	36	357	SAIDA	58	641
401	48	67	ENTRADA	89	876
402	46	238	ENTRADA	69	167
403	33	88	SAIDA	31	857
404	3	271	ENTRADA	17	879
405	25	174	ENTRADA	22	949
406	6	63	ENTRADA	39	161
407	48	99	ENTRADA	88	358
408	23	170	ENTRADA	21	210
409	4	58	SAIDA	8	189
410	19	76	ENTRADA	97	760
411	17	336	SAIDA	14	138
412	35	286	SAIDA	34	934
413	7	253	SAIDA	26	918
414	25	26	SAIDA	47	390
415	34	111	ENTRADA	47	332
416	44	277	SAIDA	19	451
417	13	108	ENTRADA	61	399
418	33	17	ENTRADA	2	206
419	28	292	ENTRADA	29	90
420	24	293	SAIDA	19	863
421	45	341	SAIDA	40	763
422	28	17	ENTRADA	31	122
423	9	136	ENTRADA	31	439
424	22	303	ENTRADA	62	617
425	15	244	SAIDA	76	631
426	28	326	SAIDA	74	810
427	46	55	ENTRADA	72	469
428	8	83	ENTRADA	77	223
429	23	365	SAIDA	14	136
430	20	155	ENTRADA	61	666
431	9	99	ENTRADA	20	796
432	28	316	ENTRADA	50	299
433	46	251	SAIDA	86	292
434	33	207	ENTRADA	78	962
435	37	61	ENTRADA	15	233
436	24	344	ENTRADA	43	475
437	34	98	ENTRADA	47	505
438	9	232	SAIDA	90	510
439	22	67	ENTRADA	91	958
440	11	160	SAIDA	14	414
441	24	353	SAIDA	7	882
442	47	120	SAIDA	4	628
443	34	254	ENTRADA	66	868
444	14	155	SAIDA	14	318
445	23	259	ENTRADA	51	549
446	32	204	ENTRADA	88	168
447	36	87	SAIDA	98	733
448	42	70	SAIDA	36	656
449	27	342	SAIDA	4	127
450	50	79	ENTRADA	2	731
451	26	170	SAIDA	73	780
452	45	68	SAIDA	50	876
453	34	231	ENTRADA	9	860
454	1	122	SAIDA	34	683
455	16	138	ENTRADA	32	778
456	47	256	ENTRADA	93	859
457	37	324	ENTRADA	12	760
458	32	270	ENTRADA	5	587
459	37	261	SAIDA	15	431
460	33	230	ENTRADA	50	767
461	45	50	ENTRADA	59	415
462	9	163	SAIDA	93	841
463	47	331	SAIDA	87	698
464	22	348	SAIDA	18	694
465	19	322	ENTRADA	9	980
466	13	180	SAIDA	54	743
467	2	91	SAIDA	49	809
468	28	263	SAIDA	29	189
469	19	253	ENTRADA	99	104
470	24	50	ENTRADA	38	255
471	43	31	ENTRADA	60	426
472	10	79	SAIDA	9	243
473	35	206	ENTRADA	85	856
474	8	255	ENTRADA	22	385
475	13	211	ENTRADA	40	905
476	4	111	SAIDA	32	768
477	41	123	ENTRADA	81	374
478	7	55	ENTRADA	59	877
479	27	42	ENTRADA	18	183
480	7	18	SAIDA	24	367
481	39	288	SAIDA	4	360
482	32	245	ENTRADA	89	446
483	1	299	SAIDA	98	569
484	11	152	SAIDA	40	490
485	3	116	ENTRADA	82	587
486	22	85	SAIDA	68	53
487	20	113	SAIDA	72	196
488	12	365	ENTRADA	50	235
489	31	202	SAIDA	62	507
490	5	61	SAIDA	4	268
491	46	332	SAIDA	39	717
492	13	363	ENTRADA	10	910
493	28	197	ENTRADA	89	139
494	16	82	SAIDA	80	568
495	31	35	SAIDA	97	268
496	43	124	ENTRADA	94	982
497	25	271	ENTRADA	70	987
498	27	301	ENTRADA	29	153
499	38	121	SAIDA	24	527
500	10	84	SAIDA	50	192
\.


--
-- Data for Name: fato_financeiro; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fato_financeiro (sk_financeiro, sk_tempo, tipo_lancamento, status_pagamento, valor) FROM stdin;
42	154	CONTAS_RECEBER	ATRASADO	92.70
44	244	CONTAS_RECEBER	PAGO	3393.17
57	176	CONTAS_PAGAR	PAGO	7491.13
58	314	CONTAS_PAGAR	PAGO	5014.22
63	215	CONTAS_RECEBER	ATRASADO	5664.25
80	243	CONTAS_PAGAR	PAGO	7029.93
81	65	CONTAS_RECEBER	ATRASADO	95.90
84	117	CONTAS_RECEBER	PAGO	156.24
86	73	CONTAS_PAGAR	PAGO	3097.81
91	332	CONTAS_RECEBER	PAGO	3254.21
92	96	CONTAS_RECEBER	ATRASADO	2949.35
100	3	CONTAS_PAGAR	PAGO	1437.98
107	72	CONTAS_PAGAR	ATRASADO	1378.33
118	177	CONTAS_PAGAR	ATRASADO	2666.57
120	344	CONTAS_PAGAR	PAGO	1739.03
132	211	CONTAS_PAGAR	PAGO	786.95
143	67	CONTAS_PAGAR	PAGO	162.39
150	203	CONTAS_PAGAR	PAGO	2072.59
151	228	CONTAS_PAGAR	ATRASADO	1051.58
159	254	CONTAS_RECEBER	PAGO	2047.90
78	285	CONTAS_PAGAR	PAGO	176.02
47	77	CONTAS_PAGAR	PAGO	6121.74
236	133	CONTAS_PAGAR	PAGO	52.25
584	82	CONTAS_RECEBER	ATRASADO	3042.47
258	82	CONTAS_RECEBER	PAGO	164.93
759	306	CONTAS_RECEBER	PAGO	1811.09
237	326	CONTAS_PAGAR	PENDENTE	2630.49
351	326	CONTAS_PAGAR	PENDENTE	466.69
62	328	CONTAS_PAGAR	PENDENTE	1142.31
123	141	CONTAS_RECEBER	PENDENTE	5991.09
224	70	CONTAS_RECEBER	PENDENTE	57.39
748	70	CONTAS_RECEBER	PENDENTE	1488.14
155	262	CONTAS_PAGAR	ATRASADO	3151.41
156	157	CONTAS_PAGAR	ATRASADO	3834.95
136	181	CONTAS_PAGAR	ATRASADO	548.99
113	239	CONTAS_PAGAR	ATRASADO	93.96
53	351	CONTAS_PAGAR	ATRASADO	1400.20
117	256	CONTAS_PAGAR	ATRASADO	360.48
70	110	CONTAS_RECEBER	ATRASADO	621.96
56	175	CONTAS_PAGAR	ATRASADO	5083.23
137	120	CONTAS_PAGAR	ATRASADO	1255.77
489	103	CONTAS_RECEBER	ATRASADO	159.57
222	261	CONTAS_RECEBER	ATRASADO	1241.58
497	261	CONTAS_RECEBER	ATRASADO	2518.86
161	283	CONTAS_RECEBER	PAGO	7979.21
162	59	CONTAS_PAGAR	PAGO	726.95
164	139	CONTAS_PAGAR	PAGO	7223.29
165	36	CONTAS_PAGAR	PAGO	61.72
166	10	CONTAS_RECEBER	PAGO	104.60
171	229	CONTAS_RECEBER	PAGO	408.37
175	134	CONTAS_PAGAR	PAGO	6561.74
177	25	CONTAS_PAGAR	ATRASADO	7878.48
180	14	CONTAS_PAGAR	PAGO	121.29
181	172	CONTAS_RECEBER	PAGO	1825.01
187	20	CONTAS_RECEBER	PAGO	973.18
193	61	CONTAS_PAGAR	ATRASADO	2657.58
202	253	CONTAS_RECEBER	ATRASADO	6659.22
211	122	CONTAS_RECEBER	PAGO	834.73
213	301	CONTAS_PAGAR	PAGO	877.40
214	40	CONTAS_RECEBER	PAGO	1762.75
221	62	CONTAS_PAGAR	PAGO	3392.61
225	304	CONTAS_RECEBER	ATRASADO	1153.52
226	127	CONTAS_RECEBER	ATRASADO	764.05
232	202	CONTAS_RECEBER	ATRASADO	1163.15
241	217	CONTAS_PAGAR	ATRASADO	908.74
251	346	CONTAS_RECEBER	ATRASADO	460.30
253	284	CONTAS_RECEBER	PAGO	116.22
269	324	CONTAS_PAGAR	PAGO	3356.82
279	117	CONTAS_RECEBER	ATRASADO	1337.86
280	5	CONTAS_RECEBER	PAGO	856.64
190	19	CONTAS_PAGAR	ATRASADO	5326.77
235	130	CONTAS_RECEBER	PENDENTE	616.11
249	166	CONTAS_RECEBER	PENDENTE	2811.81
247	347	CONTAS_PAGAR	PENDENTE	1802.29
204	138	CONTAS_PAGAR	PENDENTE	1135.27
215	262	CONTAS_PAGAR	ATRASADO	700.31
272	364	CONTAS_RECEBER	ATRASADO	126.71
284	95	CONTAS_RECEBER	PAGO	3326.96
286	321	CONTAS_PAGAR	ATRASADO	2030.63
290	334	CONTAS_PAGAR	ATRASADO	4377.34
291	45	CONTAS_PAGAR	PAGO	145.95
293	32	CONTAS_RECEBER	PAGO	1961.59
296	124	CONTAS_PAGAR	PAGO	226.32
297	268	CONTAS_RECEBER	PAGO	3433.00
301	292	CONTAS_PAGAR	ATRASADO	813.67
302	35	CONTAS_RECEBER	ATRASADO	700.73
307	216	CONTAS_PAGAR	PAGO	558.11
314	113	CONTAS_RECEBER	ATRASADO	60.51
320	17	CONTAS_RECEBER	ATRASADO	155.89
322	308	CONTAS_RECEBER	PAGO	544.69
326	346	CONTAS_PAGAR	PAGO	184.41
328	270	CONTAS_RECEBER	ATRASADO	1486.44
330	66	CONTAS_PAGAR	ATRASADO	117.00
331	321	CONTAS_RECEBER	PAGO	2523.43
340	312	CONTAS_PAGAR	PAGO	149.99
342	7	CONTAS_PAGAR	ATRASADO	2649.62
343	279	CONTAS_PAGAR	ATRASADO	2943.35
364	199	CONTAS_RECEBER	PAGO	7048.13
367	325	CONTAS_RECEBER	PAGO	230.95
379	351	CONTAS_RECEBER	PAGO	188.69
380	361	CONTAS_PAGAR	PAGO	5380.13
381	268	CONTAS_RECEBER	PAGO	3137.76
385	228	CONTAS_RECEBER	PAGO	2019.04
389	159	CONTAS_PAGAR	PAGO	122.22
396	136	CONTAS_PAGAR	PAGO	762.33
399	147	CONTAS_RECEBER	PAGO	461.61
292	296	CONTAS_RECEBER	PENDENTE	3365.37
376	318	CONTAS_PAGAR	PENDENTE	3896.57
349	328	CONTAS_PAGAR	PENDENTE	1174.16
356	35	CONTAS_PAGAR	PENDENTE	318.43
390	271	CONTAS_RECEBER	PENDENTE	762.55
306	92	CONTAS_RECEBER	PENDENTE	1287.44
298	92	CONTAS_RECEBER	PENDENTE	1842.69
361	74	CONTAS_PAGAR	ATRASADO	6488.11
327	351	CONTAS_PAGAR	ATRASADO	56.62
392	342	CONTAS_RECEBER	ATRASADO	411.81
387	148	CONTAS_RECEBER	ATRASADO	137.82
336	175	CONTAS_PAGAR	ATRASADO	496.44
408	322	CONTAS_PAGAR	PAGO	245.62
413	314	CONTAS_PAGAR	PAGO	2585.39
421	206	CONTAS_RECEBER	PAGO	2968.67
424	301	CONTAS_RECEBER	ATRASADO	815.71
439	64	CONTAS_RECEBER	PAGO	88.79
443	63	CONTAS_RECEBER	PAGO	1241.48
446	316	CONTAS_RECEBER	ATRASADO	2609.82
452	300	CONTAS_RECEBER	PAGO	3345.35
464	239	CONTAS_RECEBER	PAGO	328.40
466	272	CONTAS_PAGAR	PAGO	1425.05
467	194	CONTAS_PAGAR	PAGO	59.11
472	270	CONTAS_PAGAR	PAGO	1423.07
479	229	CONTAS_PAGAR	ATRASADO	115.97
483	94	CONTAS_RECEBER	PAGO	109.01
484	286	CONTAS_RECEBER	PAGO	2135.58
486	114	CONTAS_PAGAR	ATRASADO	1099.38
487	172	CONTAS_RECEBER	PAGO	7694.80
488	58	CONTAS_RECEBER	PAGO	53.94
494	293	CONTAS_RECEBER	PAGO	59.62
507	246	CONTAS_RECEBER	PAGO	7438.29
510	38	CONTAS_PAGAR	PAGO	189.81
513	122	CONTAS_PAGAR	PAGO	1074.38
514	128	CONTAS_PAGAR	ATRASADO	1993.27
518	162	CONTAS_PAGAR	ATRASADO	830.73
519	99	CONTAS_PAGAR	PAGO	3009.84
428	305	CONTAS_PAGAR	PAGO	2796.55
440	127	CONTAS_PAGAR	PAGO	2419.39
455	190	CONTAS_PAGAR	PENDENTE	2119.03
470	87	CONTAS_RECEBER	PENDENTE	3376.64
412	87	CONTAS_RECEBER	PENDENTE	770.66
465	150	CONTAS_PAGAR	PENDENTE	814.84
449	83	CONTAS_PAGAR	ATRASADO	2120.21
473	13	CONTAS_PAGAR	ATRASADO	1239.94
433	157	CONTAS_PAGAR	ATRASADO	2380.33
414	181	CONTAS_PAGAR	ATRASADO	1884.26
506	89	CONTAS_RECEBER	ATRASADO	917.32
454	156	CONTAS_RECEBER	ATRASADO	3649.10
524	91	CONTAS_PAGAR	ATRASADO	122.43
526	104	CONTAS_PAGAR	ATRASADO	1422.49
531	188	CONTAS_PAGAR	ATRASADO	2872.45
535	287	CONTAS_PAGAR	ATRASADO	1433.41
537	1	CONTAS_PAGAR	PAGO	3330.01
544	144	CONTAS_PAGAR	PAGO	2781.63
546	265	CONTAS_PAGAR	PAGO	180.67
549	17	CONTAS_RECEBER	ATRASADO	2628.05
551	114	CONTAS_RECEBER	PAGO	1410.06
556	323	CONTAS_RECEBER	PAGO	540.11
569	283	CONTAS_RECEBER	PAGO	223.57
575	228	CONTAS_RECEBER	PAGO	1474.48
579	152	CONTAS_RECEBER	ATRASADO	1943.15
582	179	CONTAS_RECEBER	ATRASADO	66.06
586	75	CONTAS_PAGAR	PAGO	1345.31
588	185	CONTAS_PAGAR	PAGO	932.97
590	238	CONTAS_RECEBER	PAGO	4879.36
591	358	CONTAS_RECEBER	PAGO	2427.30
599	122	CONTAS_RECEBER	PAGO	2189.53
608	18	CONTAS_RECEBER	ATRASADO	192.59
623	296	CONTAS_PAGAR	ATRASADO	2814.08
627	132	CONTAS_PAGAR	PAGO	1372.68
554	328	CONTAS_RECEBER	PAGO	1918.19
558	16	CONTAS_PAGAR	PAGO	470.54
629	71	CONTAS_RECEBER	PENDENTE	496.08
570	70	CONTAS_RECEBER	PENDENTE	72.06
605	70	CONTAS_RECEBER	PENDENTE	152.03
634	140	CONTAS_PAGAR	PENDENTE	339.91
548	17	CONTAS_PAGAR	PENDENTE	824.54
539	262	CONTAS_PAGAR	ATRASADO	2771.69
618	13	CONTAS_PAGAR	ATRASADO	194.67
529	71	CONTAS_PAGAR	ATRASADO	329.10
606	195	CONTAS_PAGAR	ATRASADO	642.22
571	165	CONTAS_PAGAR	ATRASADO	1369.78
650	172	CONTAS_RECEBER	PAGO	265.01
651	25	CONTAS_RECEBER	PAGO	1016.68
667	322	CONTAS_RECEBER	PAGO	1034.71
671	25	CONTAS_RECEBER	PAGO	636.45
673	339	CONTAS_PAGAR	PAGO	729.60
677	137	CONTAS_RECEBER	ATRASADO	83.82
678	29	CONTAS_PAGAR	ATRASADO	652.55
683	159	CONTAS_PAGAR	PAGO	1959.22
686	322	CONTAS_PAGAR	PAGO	1186.89
687	74	CONTAS_RECEBER	PAGO	557.06
689	8	CONTAS_PAGAR	PAGO	1091.77
692	202	CONTAS_RECEBER	ATRASADO	1082.87
698	192	CONTAS_PAGAR	ATRASADO	1239.54
702	97	CONTAS_RECEBER	PAGO	5385.39
712	52	CONTAS_RECEBER	PAGO	475.46
719	118	CONTAS_RECEBER	PAGO	1025.36
724	356	CONTAS_PAGAR	PAGO	3016.35
728	123	CONTAS_RECEBER	PAGO	1085.60
732	361	CONTAS_PAGAR	PAGO	170.11
733	340	CONTAS_PAGAR	PAGO	1019.79
734	289	CONTAS_PAGAR	PAGO	701.98
736	282	CONTAS_RECEBER	ATRASADO	893.09
738	344	CONTAS_PAGAR	PAGO	2780.05
742	89	CONTAS_PAGAR	ATRASADO	3070.82
743	323	CONTAS_RECEBER	ATRASADO	545.54
745	343	CONTAS_PAGAR	PAGO	932.11
747	5	CONTAS_RECEBER	PAGO	50.45
749	36	CONTAS_RECEBER	ATRASADO	4812.88
760	252	CONTAS_RECEBER	ATRASADO	1369.65
726	133	CONTAS_PAGAR	ATRASADO	3444.23
729	259	CONTAS_RECEBER	PENDENTE	646.42
670	338	CONTAS_PAGAR	PENDENTE	601.39
688	350	CONTAS_RECEBER	PENDENTE	3270.69
694	296	CONTAS_RECEBER	PENDENTE	3128.38
680	71	CONTAS_RECEBER	PENDENTE	5838.26
654	360	CONTAS_PAGAR	PENDENTE	1031.83
681	271	CONTAS_RECEBER	PENDENTE	960.26
756	92	CONTAS_RECEBER	PENDENTE	843.18
652	150	CONTAS_PAGAR	PENDENTE	1233.62
705	294	CONTAS_PAGAR	PENDENTE	2598.46
701	157	CONTAS_PAGAR	ATRASADO	3123.13
119	28	CONTAS_PAGAR	PENDENTE	1780.69
39	112	CONTAS_RECEBER	PENDENTE	7429.83
138	21	CONTAS_RECEBER	PENDENTE	1368.15
71	21	CONTAS_RECEBER	PENDENTE	812.25
32	59	CONTAS_RECEBER	PENDENTE	1468.32
112	347	CONTAS_PAGAR	PENDENTE	898.81
77	111	CONTAS_RECEBER	PENDENTE	2266.20
85	138	CONTAS_PAGAR	PENDENTE	82.60
97	336	CONTAS_PAGAR	PENDENTE	5271.68
5	336	CONTAS_PAGAR	PENDENTE	416.34
110	11	CONTAS_PAGAR	PENDENTE	2942.14
124	320	CONTAS_PAGAR	ATRASADO	54.22
12	303	CONTAS_RECEBER	ATRASADO	1527.24
41	339	CONTAS_RECEBER	PAGO	406.05
54	285	CONTAS_RECEBER	ATRASADO	54.76
66	144	CONTAS_RECEBER	ATRASADO	1621.67
6	201	CONTAS_RECEBER	ATRASADO	878.74
116	291	CONTAS_PAGAR	ATRASADO	1183.95
130	306	CONTAS_RECEBER	PAGO	157.02
46	285	CONTAS_PAGAR	ATRASADO	1254.74
64	13	CONTAS_RECEBER	PAGO	1659.27
50	156	CONTAS_RECEBER	ATRASADO	2371.31
60	354	CONTAS_PAGAR	PAGO	3038.40
145	103	CONTAS_PAGAR	PAGO	1367.56
17	140	CONTAS_RECEBER	ATRASADO	1332.05
21	113	CONTAS_PAGAR	PAGO	4484.40
25	309	CONTAS_RECEBER	PAGO	207.81
29	344	CONTAS_PAGAR	PAGO	116.45
40	176	CONTAS_PAGAR	PAGO	306.63
43	264	CONTAS_PAGAR	PAGO	1989.67
45	223	CONTAS_RECEBER	PAGO	1604.31
48	343	CONTAS_RECEBER	PAGO	346.48
49	172	CONTAS_PAGAR	PAGO	6796.20
51	236	CONTAS_RECEBER	PAGO	199.71
52	68	CONTAS_PAGAR	ATRASADO	853.28
55	163	CONTAS_RECEBER	PAGO	1610.87
59	146	CONTAS_RECEBER	PAGO	2704.03
61	167	CONTAS_PAGAR	PAGO	1509.55
65	31	CONTAS_RECEBER	PAGO	1430.76
67	2	CONTAS_PAGAR	ATRASADO	1394.97
68	206	CONTAS_RECEBER	PAGO	2171.28
69	259	CONTAS_PAGAR	PAGO	188.97
72	288	CONTAS_PAGAR	PAGO	1658.53
73	101	CONTAS_RECEBER	PAGO	2739.76
74	325	CONTAS_PAGAR	ATRASADO	1565.78
75	91	CONTAS_RECEBER	PAGO	1092.57
76	198	CONTAS_PAGAR	PAGO	4717.10
79	64	CONTAS_RECEBER	PAGO	6196.80
82	41	CONTAS_RECEBER	PAGO	923.40
83	346	CONTAS_RECEBER	PAGO	805.35
87	169	CONTAS_RECEBER	PAGO	2687.61
88	236	CONTAS_RECEBER	PAGO	148.67
89	38	CONTAS_PAGAR	PAGO	2349.92
90	335	CONTAS_RECEBER	PAGO	404.15
93	357	CONTAS_PAGAR	ATRASADO	2937.20
94	216	CONTAS_RECEBER	PAGO	2921.11
95	91	CONTAS_PAGAR	ATRASADO	3422.72
96	170	CONTAS_PAGAR	PAGO	701.99
98	116	CONTAS_RECEBER	PAGO	5947.16
99	153	CONTAS_PAGAR	PAGO	3145.99
101	252	CONTAS_PAGAR	ATRASADO	155.68
102	295	CONTAS_RECEBER	PAGO	190.58
103	289	CONTAS_RECEBER	PAGO	82.18
104	270	CONTAS_PAGAR	ATRASADO	1934.50
105	231	CONTAS_RECEBER	PAGO	1317.74
106	49	CONTAS_RECEBER	PAGO	2089.87
108	327	CONTAS_RECEBER	PAGO	188.67
109	129	CONTAS_PAGAR	PAGO	2725.73
111	66	CONTAS_PAGAR	ATRASADO	2084.57
114	42	CONTAS_PAGAR	ATRASADO	879.87
115	322	CONTAS_PAGAR	PAGO	3373.32
121	292	CONTAS_PAGAR	ATRASADO	157.28
122	171	CONTAS_RECEBER	PAGO	158.29
125	123	CONTAS_RECEBER	PAGO	3497.58
126	175	CONTAS_RECEBER	PAGO	1383.08
127	169	CONTAS_RECEBER	PAGO	7509.97
128	86	CONTAS_RECEBER	PAGO	1446.38
129	2	CONTAS_RECEBER	PAGO	2003.93
131	5	CONTAS_RECEBER	PAGO	195.79
133	7	CONTAS_RECEBER	PAGO	320.56
134	31	CONTAS_RECEBER	ATRASADO	804.44
135	52	CONTAS_PAGAR	PAGO	876.95
139	234	CONTAS_PAGAR	PAGO	2087.86
140	231	CONTAS_RECEBER	PAGO	5631.26
141	255	CONTAS_PAGAR	PAGO	2580.19
142	150	CONTAS_RECEBER	ATRASADO	3465.51
144	272	CONTAS_RECEBER	PAGO	575.97
146	242	CONTAS_PAGAR	PAGO	1387.63
147	240	CONTAS_RECEBER	PAGO	7353.72
299	197	CONTAS_RECEBER	PENDENTE	2998.61
149	362	CONTAS_RECEBER	PAGO	2770.49
153	198	CONTAS_PAGAR	ATRASADO	2809.70
154	136	CONTAS_PAGAR	ATRASADO	3083.15
158	8	CONTAS_RECEBER	ATRASADO	2372.87
160	3	CONTAS_PAGAR	ATRASADO	671.91
163	9	CONTAS_RECEBER	PAGO	1086.80
168	226	CONTAS_PAGAR	PAGO	1053.55
170	293	CONTAS_PAGAR	PAGO	1801.70
172	147	CONTAS_PAGAR	PAGO	2861.78
173	111	CONTAS_PAGAR	ATRASADO	2835.15
174	45	CONTAS_PAGAR	ATRASADO	3163.16
176	300	CONTAS_RECEBER	PAGO	2442.49
178	1	CONTAS_PAGAR	PAGO	115.25
169	54	CONTAS_PAGAR	PENDENTE	1602.64
185	269	CONTAS_PAGAR	PAGO	1680.25
186	331	CONTAS_RECEBER	PAGO	1179.90
191	215	CONTAS_RECEBER	PAGO	69.90
192	31	CONTAS_RECEBER	ATRASADO	2016.98
194	23	CONTAS_PAGAR	PAGO	1186.26
195	264	CONTAS_RECEBER	ATRASADO	1013.32
197	187	CONTAS_PAGAR	PAGO	636.41
198	274	CONTAS_PAGAR	PAGO	1487.90
199	323	CONTAS_RECEBER	PAGO	2525.94
200	113	CONTAS_RECEBER	ATRASADO	177.28
201	272	CONTAS_RECEBER	ATRASADO	3120.46
203	360	CONTAS_RECEBER	PAGO	1302.00
205	258	CONTAS_PAGAR	PAGO	244.64
206	48	CONTAS_PAGAR	PAGO	301.30
207	30	CONTAS_RECEBER	PAGO	2415.59
208	90	CONTAS_PAGAR	PAGO	126.45
209	257	CONTAS_RECEBER	PAGO	406.89
210	79	CONTAS_PAGAR	PAGO	4511.11
189	357	CONTAS_RECEBER	PENDENTE	1633.57
217	123	CONTAS_RECEBER	ATRASADO	137.81
188	112	CONTAS_RECEBER	PENDENTE	2939.88
219	199	CONTAS_RECEBER	PAGO	5726.95
220	224	CONTAS_PAGAR	ATRASADO	2606.88
271	141	CONTAS_RECEBER	PENDENTE	3140.42
283	134	CONTAS_RECEBER	PENDENTE	941.45
227	270	CONTAS_PAGAR	ATRASADO	1189.67
228	273	CONTAS_RECEBER	PAGO	1562.24
229	289	CONTAS_RECEBER	PAGO	290.96
230	8	CONTAS_PAGAR	ATRASADO	1448.09
231	229	CONTAS_PAGAR	PAGO	2348.29
234	348	CONTAS_PAGAR	PAGO	4843.22
233	59	CONTAS_RECEBER	PENDENTE	7712.79
254	71	CONTAS_RECEBER	PENDENTE	3207.97
238	61	CONTAS_PAGAR	ATRASADO	76.45
239	315	CONTAS_RECEBER	PAGO	7941.72
242	302	CONTAS_RECEBER	PAGO	6839.18
243	216	CONTAS_RECEBER	PAGO	1383.04
244	234	CONTAS_PAGAR	PAGO	746.75
179	140	CONTAS_PAGAR	PENDENTE	5004.90
223	92	CONTAS_RECEBER	PENDENTE	55.01
248	288	CONTAS_PAGAR	PAGO	6285.30
250	185	CONTAS_RECEBER	PENDENTE	1186.42
255	231	CONTAS_PAGAR	ATRASADO	1058.98
256	173	CONTAS_PAGAR	PAGO	122.98
257	125	CONTAS_PAGAR	PAGO	5719.17
316	273	CONTAS_PAGAR	PENDENTE	1267.16
259	101	CONTAS_PAGAR	PAGO	158.49
260	224	CONTAS_RECEBER	ATRASADO	68.89
216	308	CONTAS_PAGAR	ATRASADO	7890.91
263	221	CONTAS_PAGAR	ATRASADO	1596.34
264	230	CONTAS_PAGAR	PAGO	1273.40
265	114	CONTAS_RECEBER	PAGO	1961.92
266	226	CONTAS_PAGAR	ATRASADO	796.56
167	364	CONTAS_RECEBER	ATRASADO	3174.41
268	48	CONTAS_PAGAR	PAGO	2483.00
270	357	CONTAS_PAGAR	PAGO	1151.09
273	231	CONTAS_PAGAR	PAGO	1982.72
274	131	CONTAS_RECEBER	ATRASADO	1075.40
275	14	CONTAS_PAGAR	ATRASADO	632.89
182	168	CONTAS_PAGAR	ATRASADO	291.83
277	42	CONTAS_PAGAR	PAGO	1213.89
278	202	CONTAS_RECEBER	PAGO	3477.95
183	181	CONTAS_PAGAR	ATRASADO	937.29
282	104	CONTAS_PAGAR	PAGO	5072.46
285	14	CONTAS_PAGAR	PAGO	326.25
287	154	CONTAS_RECEBER	PAGO	3443.73
196	227	CONTAS_RECEBER	ATRASADO	115.47
310	65	CONTAS_PAGAR	ATRASADO	1056.24
294	123	CONTAS_RECEBER	PAGO	3170.28
295	129	CONTAS_RECEBER	PAGO	1198.88
300	299	CONTAS_PAGAR	PAGO	324.05
303	67	CONTAS_PAGAR	PAGO	1855.20
261	256	CONTAS_PAGAR	ATRASADO	2616.12
305	278	CONTAS_PAGAR	PAGO	1602.65
308	52	CONTAS_RECEBER	PAGO	2542.30
309	124	CONTAS_RECEBER	PAGO	185.58
311	113	CONTAS_PAGAR	PAGO	6828.34
312	144	CONTAS_PAGAR	ATRASADO	2294.04
313	342	CONTAS_PAGAR	PAGO	3156.75
315	343	CONTAS_PAGAR	PAGO	1280.29
317	329	CONTAS_PAGAR	PAGO	82.17
240	275	CONTAS_PAGAR	ATRASADO	411.72
152	110	CONTAS_RECEBER	ATRASADO	2896.84
157	89	CONTAS_RECEBER	ATRASADO	134.38
318	8	CONTAS_PAGAR	PAGO	663.96
319	137	CONTAS_PAGAR	PAGO	114.40
321	184	CONTAS_PAGAR	PAGO	212.74
475	259	CONTAS_RECEBER	PENDENTE	717.87
324	233	CONTAS_RECEBER	PAGO	90.70
329	124	CONTAS_RECEBER	PAGO	1626.75
332	324	CONTAS_PAGAR	PAGO	2436.74
444	259	CONTAS_RECEBER	PENDENTE	1580.11
334	170	CONTAS_RECEBER	ATRASADO	576.93
339	348	CONTAS_RECEBER	PAGO	180.61
344	188	CONTAS_PAGAR	ATRASADO	1818.84
345	322	CONTAS_PAGAR	PAGO	951.79
384	338	CONTAS_PAGAR	PENDENTE	3324.85
347	59	CONTAS_PAGAR	ATRASADO	2045.40
348	350	CONTAS_RECEBER	PENDENTE	1399.32
335	112	CONTAS_RECEBER	PENDENTE	2580.65
353	297	CONTAS_PAGAR	PAGO	1580.43
355	115	CONTAS_PAGAR	PAGO	780.15
357	273	CONTAS_RECEBER	PAGO	84.33
358	66	CONTAS_RECEBER	PAGO	7900.11
359	73	CONTAS_PAGAR	PAGO	1417.34
360	115	CONTAS_RECEBER	ATRASADO	816.87
362	140	CONTAS_RECEBER	PAGO	2717.11
363	147	CONTAS_RECEBER	ATRASADO	98.76
365	122	CONTAS_PAGAR	PAGO	2928.58
366	148	CONTAS_PAGAR	PAGO	1743.58
368	95	CONTAS_RECEBER	PAGO	478.54
398	63	CONTAS_PAGAR	PENDENTE	1374.54
338	87	CONTAS_RECEBER	PENDENTE	2544.39
371	104	CONTAS_PAGAR	PAGO	2197.97
411	312	CONTAS_RECEBER	PENDENTE	3347.28
373	298	CONTAS_PAGAR	PAGO	6209.66
337	336	CONTAS_PAGAR	PENDENTE	2236.68
375	277	CONTAS_PAGAR	PAGO	1052.96
377	290	CONTAS_RECEBER	PAGO	1100.65
378	201	CONTAS_RECEBER	PAGO	525.13
383	236	CONTAS_RECEBER	ATRASADO	1168.05
386	277	CONTAS_PAGAR	ATRASADO	306.42
388	272	CONTAS_RECEBER	ATRASADO	435.74
391	72	CONTAS_PAGAR	PAGO	135.57
393	140	CONTAS_RECEBER	PAGO	3387.81
394	141	CONTAS_PAGAR	PAGO	283.80
395	161	CONTAS_RECEBER	PAGO	171.97
397	31	CONTAS_PAGAR	PAGO	730.68
401	114	CONTAS_RECEBER	PAGO	1298.07
402	125	CONTAS_PAGAR	PAGO	1271.89
403	108	CONTAS_RECEBER	ATRASADO	5874.19
404	158	CONTAS_RECEBER	ATRASADO	1836.82
405	57	CONTAS_PAGAR	PAGO	2853.84
406	253	CONTAS_PAGAR	ATRASADO	2999.35
352	273	CONTAS_PAGAR	PENDENTE	394.30
325	262	CONTAS_PAGAR	ATRASADO	1273.29
416	60	CONTAS_RECEBER	PAGO	730.14
459	83	CONTAS_PAGAR	ATRASADO	3389.96
400	222	CONTAS_RECEBER	ATRASADO	2750.33
422	245	CONTAS_PAGAR	PAGO	1232.13
423	5	CONTAS_PAGAR	PAGO	2298.68
425	163	CONTAS_RECEBER	PAGO	435.87
420	200	CONTAS_PAGAR	ATRASADO	592.18
427	119	CONTAS_PAGAR	PAGO	2410.62
415	12	CONTAS_RECEBER	ATRASADO	1187.46
430	20	CONTAS_PAGAR	PAGO	723.94
431	136	CONTAS_RECEBER	PAGO	999.70
432	140	CONTAS_RECEBER	PAGO	163.43
434	329	CONTAS_PAGAR	PAGO	1305.00
435	242	CONTAS_PAGAR	PAGO	805.50
436	350	CONTAS_PAGAR	PAGO	3209.81
437	142	CONTAS_PAGAR	PAGO	1490.03
493	310	CONTAS_PAGAR	ATRASADO	2680.74
441	6	CONTAS_RECEBER	PAGO	2676.47
442	325	CONTAS_RECEBER	PAGO	1439.13
445	286	CONTAS_RECEBER	PAGO	670.25
447	193	CONTAS_RECEBER	ATRASADO	465.97
448	18	CONTAS_PAGAR	PAGO	4418.81
450	240	CONTAS_PAGAR	PAGO	3185.78
354	42	CONTAS_RECEBER	ATRASADO	52.65
469	275	CONTAS_PAGAR	ATRASADO	159.86
457	50	CONTAS_RECEBER	PAGO	1969.97
458	349	CONTAS_PAGAR	PAGO	805.80
460	157	CONTAS_RECEBER	PAGO	1163.08
341	110	CONTAS_RECEBER	ATRASADO	777.36
410	89	CONTAS_RECEBER	ATRASADO	77.74
417	148	CONTAS_RECEBER	ATRASADO	2510.15
468	249	CONTAS_PAGAR	PAGO	964.46
382	175	CONTAS_PAGAR	ATRASADO	2807.60
474	247	CONTAS_RECEBER	PAGO	148.64
476	138	CONTAS_RECEBER	ATRASADO	126.38
477	337	CONTAS_PAGAR	PAGO	108.13
478	222	CONTAS_PAGAR	PAGO	1371.66
480	84	CONTAS_PAGAR	PAGO	75.13
481	176	CONTAS_PAGAR	PAGO	116.60
482	266	CONTAS_PAGAR	PAGO	882.43
485	146	CONTAS_RECEBER	PAGO	6231.84
490	209	CONTAS_RECEBER	PAGO	953.56
491	356	CONTAS_PAGAR	ATRASADO	275.60
453	344	CONTAS_RECEBER	ATRASADO	1814.24
495	129	CONTAS_RECEBER	PAGO	149.04
496	96	CONTAS_RECEBER	PAGO	2619.45
656	28	CONTAS_PAGAR	PENDENTE	5791.30
498	10	CONTAS_RECEBER	PAGO	1407.79
499	97	CONTAS_PAGAR	PAGO	638.27
501	116	CONTAS_PAGAR	PAGO	323.93
503	143	CONTAS_PAGAR	PAGO	1498.00
504	80	CONTAS_PAGAR	ATRASADO	777.11
515	197	CONTAS_RECEBER	PENDENTE	5268.62
583	235	CONTAS_RECEBER	PENDENTE	118.36
509	101	CONTAS_PAGAR	PAGO	2853.84
567	219	CONTAS_PAGAR	PENDENTE	1350.98
512	76	CONTAS_PAGAR	ATRASADO	334.35
517	116	CONTAS_RECEBER	ATRASADO	926.00
520	124	CONTAS_PAGAR	PAGO	999.66
522	143	CONTAS_PAGAR	PAGO	1016.98
523	278	CONTAS_PAGAR	ATRASADO	757.74
640	112	CONTAS_RECEBER	PENDENTE	98.67
659	63	CONTAS_PAGAR	PENDENTE	150.95
580	315	CONTAS_PAGAR	PENDENTE	190.55
530	58	CONTAS_PAGAR	PAGO	156.83
533	224	CONTAS_PAGAR	PAGO	117.13
534	194	CONTAS_RECEBER	ATRASADO	78.31
536	363	CONTAS_RECEBER	PAGO	166.25
538	203	CONTAS_PAGAR	PAGO	212.01
540	14	CONTAS_PAGAR	PAGO	3112.16
541	198	CONTAS_RECEBER	PAGO	231.69
542	225	CONTAS_RECEBER	PAGO	6123.66
532	35	CONTAS_PAGAR	PENDENTE	1051.26
550	168	CONTAS_RECEBER	PAGO	2796.52
552	197	CONTAS_PAGAR	ATRASADO	145.14
553	99	CONTAS_RECEBER	ATRASADO	203.00
555	272	CONTAS_RECEBER	PAGO	2032.05
557	356	CONTAS_PAGAR	PAGO	2299.96
559	278	CONTAS_PAGAR	PAGO	112.95
560	124	CONTAS_RECEBER	PAGO	1014.04
561	327	CONTAS_RECEBER	PAGO	3037.51
562	153	CONTAS_RECEBER	PAGO	196.65
563	229	CONTAS_PAGAR	ATRASADO	1782.22
564	150	CONTAS_RECEBER	PAGO	181.22
610	166	CONTAS_RECEBER	PENDENTE	2778.56
568	166	CONTAS_RECEBER	PENDENTE	953.51
573	109	CONTAS_RECEBER	PAGO	1164.97
576	95	CONTAS_RECEBER	ATRASADO	1836.35
578	280	CONTAS_PAGAR	PAGO	777.33
502	312	CONTAS_RECEBER	PENDENTE	1142.40
566	140	CONTAS_PAGAR	PENDENTE	2692.92
587	109	CONTAS_PAGAR	ATRASADO	175.68
593	313	CONTAS_PAGAR	PAGO	2235.21
589	92	CONTAS_RECEBER	PENDENTE	85.35
596	78	CONTAS_PAGAR	PAGO	2405.75
597	258	CONTAS_PAGAR	ATRASADO	1399.70
598	248	CONTAS_PAGAR	PAGO	641.54
600	27	CONTAS_RECEBER	PAGO	2763.71
601	57	CONTAS_RECEBER	PAGO	1674.27
602	23	CONTAS_PAGAR	PAGO	3260.38
604	321	CONTAS_RECEBER	PAGO	2205.08
521	92	CONTAS_RECEBER	PENDENTE	724.26
609	16	CONTAS_RECEBER	PAGO	3447.15
611	289	CONTAS_RECEBER	PAGO	1384.23
574	262	CONTAS_PAGAR	ATRASADO	2968.50
613	254	CONTAS_RECEBER	PAGO	1163.72
614	52	CONTAS_PAGAR	ATRASADO	538.71
615	68	CONTAS_PAGAR	PAGO	729.23
616	313	CONTAS_RECEBER	PAGO	956.89
617	187	CONTAS_RECEBER	PAGO	5047.49
620	63	CONTAS_RECEBER	PAGO	1201.83
621	327	CONTAS_RECEBER	ATRASADO	3233.53
622	146	CONTAS_PAGAR	PAGO	160.43
625	159	CONTAS_PAGAR	ATRASADO	121.95
626	159	CONTAS_RECEBER	PAGO	1044.20
630	287	CONTAS_PAGAR	PAGO	639.63
631	191	CONTAS_PAGAR	ATRASADO	877.89
633	93	CONTAS_RECEBER	ATRASADO	99.56
635	41	CONTAS_PAGAR	PAGO	1335.28
636	268	CONTAS_RECEBER	PAGO	121.97
637	139	CONTAS_PAGAR	PAGO	61.67
638	146	CONTAS_RECEBER	ATRASADO	1862.36
639	246	CONTAS_RECEBER	PAGO	162.20
595	364	CONTAS_RECEBER	ATRASADO	943.77
632	195	CONTAS_RECEBER	ATRASADO	642.96
643	332	CONTAS_PAGAR	PAGO	1200.42
644	224	CONTAS_RECEBER	ATRASADO	1020.82
645	249	CONTAS_PAGAR	PAGO	2718.80
646	30	CONTAS_RECEBER	ATRASADO	1245.08
577	13	CONTAS_PAGAR	ATRASADO	1167.46
648	22	CONTAS_RECEBER	PAGO	1822.63
649	309	CONTAS_RECEBER	PAGO	272.53
655	324	CONTAS_PAGAR	PAGO	1470.06
657	185	CONTAS_PAGAR	PAGO	6043.33
545	22	CONTAS_PAGAR	ATRASADO	2355.19
592	107	CONTAS_PAGAR	ATRASADO	498.49
628	342	CONTAS_RECEBER	ATRASADO	150.42
624	68	CONTAS_RECEBER	ATRASADO	3964.96
603	195	CONTAS_PAGAR	ATRASADO	786.80
585	275	CONTAS_PAGAR	ATRASADO	3141.21
516	275	CONTAS_PAGAR	ATRASADO	714.58
543	27	CONTAS_PAGAR	ATRASADO	2199.49
500	156	CONTAS_RECEBER	ATRASADO	456.26
619	227	CONTAS_PAGAR	ATRASADO	1845.82
653	120	CONTAS_PAGAR	ATRASADO	1219.24
660	37	CONTAS_RECEBER	PAGO	697.56
661	362	CONTAS_PAGAR	PAGO	166.81
663	148	CONTAS_PAGAR	PAGO	5682.14
664	196	CONTAS_PAGAR	PAGO	2907.91
665	284	CONTAS_RECEBER	PAGO	159.85
666	155	CONTAS_RECEBER	PAGO	1174.70
668	340	CONTAS_RECEBER	ATRASADO	1004.01
669	319	CONTAS_PAGAR	ATRASADO	1364.54
672	39	CONTAS_PAGAR	PAGO	1130.56
674	314	CONTAS_PAGAR	PAGO	1259.45
675	232	CONTAS_RECEBER	PAGO	101.62
676	252	CONTAS_RECEBER	ATRASADO	5445.56
679	171	CONTAS_PAGAR	PAGO	607.81
684	263	CONTAS_PAGAR	PAGO	505.85
690	352	CONTAS_RECEBER	ATRASADO	80.25
691	289	CONTAS_PAGAR	ATRASADO	1440.61
693	317	CONTAS_PAGAR	PAGO	2094.86
696	349	CONTAS_PAGAR	PAGO	927.76
697	247	CONTAS_PAGAR	ATRASADO	3352.18
699	196	CONTAS_RECEBER	PAGO	3470.79
737	67	CONTAS_RECEBER	ATRASADO	1205.79
463	67	CONTAS_RECEBER	PAGO	71.88
707	355	CONTAS_RECEBER	PAGO	5035.97
709	220	CONTAS_RECEBER	ATRASADO	187.06
710	223	CONTAS_PAGAR	PAGO	638.14
148	339	CONTAS_RECEBER	ATRASADO	5189.05
714	87	CONTAS_PAGAR	ATRASADO	52.36
717	232	CONTAS_RECEBER	ATRASADO	581.11
718	355	CONTAS_PAGAR	ATRASADO	4505.14
720	299	CONTAS_PAGAR	PAGO	991.40
721	240	CONTAS_RECEBER	PAGO	3779.57
727	274	CONTAS_RECEBER	PAGO	102.62
731	162	CONTAS_PAGAR	PAGO	51.14
735	265	CONTAS_RECEBER	ATRASADO	620.42
739	173	CONTAS_RECEBER	ATRASADO	1707.60
642	274	CONTAS_RECEBER	PAGO	188.00
641	335	CONTAS_PAGAR	PAGO	126.96
744	237	CONTAS_RECEBER	PAGO	982.11
746	62	CONTAS_PAGAR	PAGO	3252.61
716	112	CONTAS_RECEBER	PENDENTE	416.28
750	96	CONTAS_RECEBER	ATRASADO	1672.29
751	25	CONTAS_RECEBER	ATRASADO	6723.88
752	355	CONTAS_RECEBER	PAGO	72.84
753	30	CONTAS_RECEBER	PAGO	333.85
754	216	CONTAS_RECEBER	ATRASADO	1227.93
755	167	CONTAS_RECEBER	PAGO	643.44
757	96	CONTAS_PAGAR	PAGO	161.73
758	207	CONTAS_PAGAR	PAGO	1771.93
38	85	CONTAS_RECEBER	PENDENTE	1738.16
1	91	CONTAS_PAGAR	ATRASADO	2518.02
3	62	CONTAS_PAGAR	ATRASADO	821.53
4	290	CONTAS_RECEBER	ATRASADO	1744.17
451	44	CONTAS_PAGAR	ATRASADO	2791.87
8	361	CONTAS_PAGAR	ATRASADO	3344.70
9	257	CONTAS_PAGAR	PAGO	1857.86
11	20	CONTAS_PAGAR	PAGO	180.94
15	221	CONTAS_RECEBER	PAGO	6357.57
16	284	CONTAS_RECEBER	ATRASADO	490.49
18	307	CONTAS_RECEBER	PAGO	397.27
19	297	CONTAS_RECEBER	PAGO	396.70
22	146	CONTAS_PAGAR	PAGO	2210.08
23	23	CONTAS_RECEBER	ATRASADO	1594.34
24	92	CONTAS_PAGAR	ATRASADO	101.56
26	232	CONTAS_PAGAR	PAGO	1798.67
27	136	CONTAS_RECEBER	PAGO	343.24
28	163	CONTAS_RECEBER	PAGO	130.38
30	356	CONTAS_RECEBER	PAGO	1174.21
31	81	CONTAS_RECEBER	PAGO	3293.04
34	187	CONTAS_RECEBER	PAGO	2555.33
2	183	CONTAS_RECEBER	ATRASADO	7218.58
36	319	CONTAS_PAGAR	PAGO	2535.07
706	85	CONTAS_RECEBER	PENDENTE	959.32
20	286	CONTAS_PAGAR	PENDENTE	2628.56
725	282	CONTAS_PAGAR	PENDENTE	852.10
662	317	CONTAS_RECEBER	PENDENTE	1413.29
429	111	CONTAS_RECEBER	PENDENTE	543.94
350	138	CONTAS_PAGAR	PENDENTE	108.73
10	294	CONTAS_PAGAR	PENDENTE	1665.48
704	364	CONTAS_RECEBER	ATRASADO	3637.80
715	195	CONTAS_RECEBER	ATRASADO	3406.77
333	239	CONTAS_PAGAR	ATRASADO	912.56
713	112	CONTAS_PAGAR	ATRASADO	1237.65
695	195	CONTAS_PAGAR	ATRASADO	549.37
708	181	CONTAS_RECEBER	ATRASADO	2231.79
722	184	CONTAS_RECEBER	ATRASADO	2581.74
723	27	CONTAS_PAGAR	ATRASADO	1398.56
471	38	CONTAS_RECEBER	PAGO	935.36
685	144	CONTAS_RECEBER	ATRASADO	2842.80
505	144	CONTAS_RECEBER	PAGO	2033.36
374	144	CONTAS_RECEBER	PAGO	1302.30
14	250	CONTAS_RECEBER	PAGO	5013.86
682	148	CONTAS_RECEBER	ATRASADO	225.97
37	175	CONTAS_PAGAR	ATRASADO	1228.36
33	186	CONTAS_RECEBER	PAGO	3593.37
703	186	CONTAS_RECEBER	PAGO	1149.71
594	328	CONTAS_RECEBER	PAGO	3274.97
35	305	CONTAS_RECEBER	ATRASADO	1425.80
741	305	CONTAS_RECEBER	PAGO	1914.21
281	305	CONTAS_PAGAR	PAGO	1498.74
419	4	CONTAS_RECEBER	PAGO	3815.70
212	4	CONTAS_RECEBER	PAGO	1548.94
492	86	CONTAS_PAGAR	PAGO	2745.12
407	86	CONTAS_PAGAR	PAGO	106.93
276	86	CONTAS_PAGAR	ATRASADO	3432.91
184	86	CONTAS_PAGAR	PAGO	817.34
511	285	CONTAS_PAGAR	ATRASADO	168.31
426	77	CONTAS_PAGAR	PAGO	395.80
267	77	CONTAS_PAGAR	ATRASADO	89.38
647	90	CONTAS_RECEBER	PAGO	780.59
565	243	CONTAS_RECEBER	ATRASADO	657.80
658	154	CONTAS_PAGAR	PAGO	2764.60
572	154	CONTAS_PAGAR	ATRASADO	7056.64
461	154	CONTAS_PAGAR	PAGO	351.51
700	13	CONTAS_RECEBER	PAGO	5531.19
370	19	CONTAS_PAGAR	PAGO	184.80
456	354	CONTAS_PAGAR	PAGO	518.96
13	98	CONTAS_RECEBER	ATRASADO	766.00
711	98	CONTAS_RECEBER	PAGO	747.16
369	98	CONTAS_RECEBER	ATRASADO	2026.70
612	69	CONTAS_PAGAR	ATRASADO	2070.63
418	69	CONTAS_PAGAR	ATRASADO	521.95
289	69	CONTAS_PAGAR	ATRASADO	3334.06
607	46	CONTAS_PAGAR	ATRASADO	5064.36
581	304	CONTAS_PAGAR	ATRASADO	7057.69
508	304	CONTAS_PAGAR	PAGO	712.83
525	127	CONTAS_PAGAR	PAGO	2510.17
438	16	CONTAS_PAGAR	PAGO	900.07
245	337	CONTAS_RECEBER	PAGO	2286.65
304	135	CONTAS_RECEBER	PAGO	1193.63
262	135	CONTAS_RECEBER	ATRASADO	1127.89
528	76	CONTAS_RECEBER	ATRASADO	1734.15
372	76	CONTAS_RECEBER	PAGO	1017.00
323	174	CONTAS_PAGAR	PAGO	410.24
218	177	CONTAS_RECEBER	PAGO	1519.54
288	206	CONTAS_PAGAR	PENDENTE	973.95
547	206	CONTAS_PAGAR	PENDENTE	1711.37
730	190	CONTAS_PAGAR	PENDENTE	500.99
7	190	CONTAS_PAGAR	PENDENTE	421.03
409	318	CONTAS_PAGAR	PENDENTE	233.67
527	318	CONTAS_PAGAR	PENDENTE	2462.72
252	347	CONTAS_PAGAR	PENDENTE	2351.23
346	347	CONTAS_PAGAR	PENDENTE	2139.28
740	347	CONTAS_PAGAR	PENDENTE	155.37
246	351	CONTAS_PAGAR	ATRASADO	339.55
462	351	CONTAS_PAGAR	ATRASADO	1955.02
769	205	CONTAS_RECEBER	ATRASADO	1049.00
773	320	CONTAS_RECEBER	PAGO	3282.95
775	281	CONTAS_RECEBER	ATRASADO	381.06
788	240	CONTAS_PAGAR	PAGO	1659.54
789	28	CONTAS_RECEBER	ATRASADO	3211.84
790	4	CONTAS_PAGAR	ATRASADO	685.90
791	231	CONTAS_PAGAR	ATRASADO	2669.85
798	259	CONTAS_RECEBER	PENDENTE	2162.18
793	296	CONTAS_PAGAR	PAGO	3843.93
796	206	CONTAS_PAGAR	PENDENTE	799.00
800	77	CONTAS_PAGAR	PAGO	779.00
776	235	CONTAS_RECEBER	PENDENTE	123.45
774	19	CONTAS_PAGAR	PAGO	1616.23
765	141	CONTAS_RECEBER	PENDENTE	7045.29
781	59	CONTAS_RECEBER	PENDENTE	194.63
772	70	CONTAS_RECEBER	PENDENTE	7704.75
792	83	CONTAS_PAGAR	ATRASADO	7943.68
779	107	CONTAS_PAGAR	ATRASADO	741.40
795	351	CONTAS_PAGAR	ATRASADO	2120.96
787	227	CONTAS_PAGAR	ATRASADO	1849.25
761	158	CONTAS_PAGAR	PAGO	354.35
762	184	CONTAS_PAGAR	PAGO	1626.05
763	41	CONTAS_PAGAR	PAGO	864.41
764	95	CONTAS_PAGAR	PAGO	1387.00
766	84	CONTAS_RECEBER	PAGO	281.28
767	18	CONTAS_PAGAR	PAGO	1316.16
768	88	CONTAS_PAGAR	PAGO	114.55
770	211	CONTAS_PAGAR	ATRASADO	499.31
771	319	CONTAS_RECEBER	PAGO	585.93
777	135	CONTAS_PAGAR	PAGO	1371.42
778	230	CONTAS_PAGAR	PAGO	1331.35
780	43	CONTAS_PAGAR	PAGO	70.19
782	80	CONTAS_RECEBER	ATRASADO	2514.79
783	2	CONTAS_RECEBER	PAGO	55.02
784	59	CONTAS_PAGAR	ATRASADO	512.84
785	27	CONTAS_RECEBER	PAGO	87.70
786	95	CONTAS_RECEBER	ATRASADO	1317.85
794	139	CONTAS_PAGAR	ATRASADO	97.69
797	24	CONTAS_PAGAR	ATRASADO	468.62
799	309	CONTAS_PAGAR	ATRASADO	1904.61
\.


--
-- Data for Name: fato_vendas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fato_vendas (sk_venda, sk_cliente, sk_produto, sk_tempo, sk_regiao, sk_transportadora, sk_pagamento, quantidade, preco_unitario, desconto, valor_total) FROM stdin;
1821	69	1	356	1	3	2	6	85.00	184.37	325.63
1763	65	1	282	4	1	3	8	85.00	282.28	397.72
1698	52	1	239	5	1	1	10	85.00	105.39	744.61
1634	93	1	335	1	3	3	5	85.00	260.45	164.55
1564	64	1	101	4	1	1	7	85.00	220.83	374.17
1563	84	1	301	5	1	1	3	85.00	189.77	65.23
1558	63	1	143	4	3	2	5	85.00	54.76	370.24
1543	89	1	360	2	4	3	8	85.00	103.68	576.32
1385	86	1	78	3	4	2	6	85.00	7.83	502.17
1333	45	1	252	4	4	3	10	85.00	87.40	762.60
1254	63	1	221	4	1	1	5	85.00	283.44	141.56
1192	24	1	172	1	4	2	3	85.00	219.66	35.34
977	31	1	137	3	2	2	8	85.00	14.91	665.09
975	88	1	134	4	1	3	9	85.00	4.39	760.61
902	23	1	184	4	3	1	2	85.00	115.42	54.58
894	70	1	332	5	4	4	9	85.00	113.51	651.49
878	15	1	71	1	3	3	5	85.00	206.50	218.50
873	62	1	229	3	2	2	5	85.00	191.69	233.31
772	95	1	216	1	3	1	2	85.00	134.12	35.88
735	8	1	150	3	2	3	7	85.00	223.53	371.47
702	6	1	125	1	4	4	5	85.00	26.69	398.31
516	66	1	286	3	3	2	5	85.00	75.80	349.20
373	73	1	207	5	3	1	4	85.00	213.85	126.15
339	60	1	110	3	4	3	2	85.00	101.93	68.07
331	100	1	232	3	2	4	8	85.00	47.75	632.25
293	56	1	317	4	1	3	6	85.00	204.85	305.15
159	36	1	111	3	1	3	7	85.00	130.00	465.00
151	70	1	170	1	2	3	2	85.00	82.04	87.96
103	4	1	32	5	3	3	5	85.00	19.22	405.78
142	32	1	276	1	2	3	1	85.00	84.99	0.01
732	84	1	203	1	4	3	1	85.00	84.99	0.01
986	98	1	351	3	1	4	1	85.00	84.99	0.01
1268	92	1	324	5	3	4	1	85.00	84.99	0.01
1580	43	1	207	2	4	4	2	85.00	169.99	0.01
1651	67	1	164	2	2	4	1	85.00	84.99	0.01
1968	79	1	143	3	1	4	1	85.00	84.99	0.01
1990	42	1	124	4	3	3	1	85.00	84.99	0.01
9	27	1	106	3	2	3	8	85.00	22.89	657.11
1957	12	2	363	5	2	4	2	46.00	28.10	63.90
1873	53	2	84	5	3	4	10	46.00	298.67	161.33
1790	100	2	288	5	1	2	10	46.00	67.65	392.35
1775	81	2	328	3	4	1	10	46.00	212.00	248.00
1752	22	2	196	2	4	2	8	46.00	10.20	357.80
1660	28	2	319	3	4	4	10	46.00	294.98	165.02
1555	51	2	148	2	4	3	7	46.00	280.83	41.17
1445	75	2	230	1	2	1	10	46.00	84.76	375.24
1284	95	2	66	1	1	4	10	46.00	259.04	200.96
1276	9	2	240	2	1	1	6	46.00	97.66	178.34
1249	20	2	150	4	1	1	8	46.00	247.08	120.92
1128	91	2	258	5	3	4	5	46.00	106.37	123.63
1033	77	2	120	3	3	3	6	46.00	115.63	160.37
1018	73	2	74	2	4	4	5	46.00	38.86	191.14
1004	11	2	118	5	3	2	8	46.00	80.87	287.13
959	25	2	149	3	4	1	7	46.00	206.61	115.39
680	17	2	105	3	1	3	10	46.00	124.93	335.07
581	71	2	312	5	4	1	8	46.00	293.94	74.06
572	40	2	72	1	2	4	4	46.00	136.30	47.70
498	78	2	177	5	2	2	2	46.00	25.15	66.85
416	21	2	310	5	4	2	8	46.00	31.72	336.28
214	15	2	18	2	3	3	10	46.00	232.62	227.38
205	20	2	126	3	2	4	8	46.00	270.81	97.19
51	51	2	247	5	2	3	6	46.00	274.32	1.68
1929	15	3	197	4	1	1	5	22.00	1.74	108.26
1854	89	3	66	2	1	4	10	22.00	187.93	32.07
1653	10	3	58	4	3	2	8	22.00	80.79	95.21
1638	68	3	49	5	1	4	9	22.00	183.29	14.71
1516	51	3	73	1	2	4	4	22.00	82.73	5.27
1375	77	3	149	5	2	4	6	22.00	106.61	25.39
970	88	3	222	4	1	4	10	22.00	19.15	200.85
789	70	3	246	1	1	2	8	22.00	106.89	69.11
703	7	3	11	1	4	4	6	22.00	95.19	36.81
696	88	3	301	5	2	3	4	22.00	26.32	61.68
559	58	3	275	3	4	4	1	22.00	18.56	3.44
538	26	3	81	1	3	4	7	22.00	76.46	77.54
445	36	3	153	2	3	4	8	22.00	51.54	124.46
291	36	3	337	2	3	2	7	22.00	55.29	98.71
211	8	3	174	2	3	2	10	22.00	126.39	93.61
181	21	3	165	4	3	3	9	22.00	139.16	58.84
109	88	3	136	4	3	3	8	22.00	146.87	29.13
37	55	3	24	1	3	2	6	22.00	89.71	42.29
1996	31	4	54	1	3	3	7	46.00	171.45	150.55
1872	73	4	327	5	3	3	3	46.00	71.82	66.18
1734	97	4	322	2	1	3	8	46.00	136.35	231.65
1546	3	4	329	3	1	3	4	46.00	118.73	65.27
1486	36	4	363	3	4	4	3	46.00	130.00	8.00
1452	67	4	75	1	4	4	8	46.00	292.65	75.35
1434	76	4	170	1	3	1	8	46.00	139.49	228.51
1354	35	4	222	1	3	1	5	46.00	68.44	161.56
1337	41	4	60	5	1	1	9	46.00	271.40	142.60
1227	57	4	205	1	2	1	7	46.00	114.06	207.94
801	17	4	26	5	4	3	2	46.00	2.50	89.50
740	19	4	57	2	2	4	6	46.00	139.45	136.55
677	12	4	359	2	3	3	8	46.00	149.93	218.07
623	26	4	58	3	4	2	7	46.00	76.50	245.50
451	28	4	354	4	3	2	7	46.00	80.67	241.33
376	98	4	12	4	1	2	9	46.00	295.43	118.57
302	37	4	151	4	3	1	6	46.00	90.68	185.32
173	13	4	98	2	1	2	9	46.00	197.99	216.01
99	96	4	364	3	2	4	10	46.00	292.58	167.42
44	20	4	287	5	3	2	7	46.00	258.51	63.49
1928	5	5	193	5	2	1	10	90.00	275.02	624.98
1818	35	5	230	3	3	2	6	90.00	274.92	265.08
1762	48	5	349	2	4	3	10	90.00	26.00	874.00
1706	64	5	332	1	3	4	9	90.00	37.75	772.25
1700	56	5	202	4	4	1	2	90.00	75.28	104.72
1648	94	5	196	3	3	1	2	90.00	145.84	34.16
1639	35	5	119	4	3	4	7	90.00	152.51	477.49
1562	30	5	29	4	3	4	4	90.00	258.60	101.40
1547	24	5	46	4	2	3	7	90.00	85.84	544.16
1514	81	5	95	1	4	3	7	90.00	172.49	457.51
1474	28	5	227	5	1	4	9	90.00	98.56	711.44
1458	54	5	106	3	2	3	3	90.00	35.05	234.95
1384	17	5	105	5	4	4	6	90.00	86.42	453.58
1263	17	5	356	1	3	1	8	90.00	21.44	698.56
1260	81	5	352	2	4	1	10	90.00	10.11	889.89
1218	89	5	267	5	4	3	8	90.00	122.21	597.79
1212	77	5	85	3	2	1	2	90.00	59.69	120.31
1055	50	5	16	4	1	2	4	90.00	37.60	322.40
1010	38	5	68	5	3	2	3	90.00	100.98	169.02
994	68	5	112	1	3	1	6	90.00	56.36	483.64
952	65	5	78	4	2	1	6	90.00	254.66	285.34
849	99	5	123	5	1	3	2	90.00	14.68	165.32
812	29	5	71	5	1	3	3	90.00	35.56	234.44
710	95	5	138	3	3	2	10	90.00	237.48	662.52
675	42	5	94	2	3	3	3	90.00	36.03	233.97
638	75	5	205	2	2	3	7	90.00	219.42	410.58
605	34	5	54	2	4	2	3	90.00	99.66	170.34
597	97	5	14	4	2	1	6	90.00	105.11	434.89
557	80	5	44	3	3	3	2	90.00	97.31	82.69
457	64	5	182	5	3	1	6	90.00	51.31	488.69
439	97	5	40	1	4	3	8	90.00	195.76	524.24
424	95	5	223	1	3	4	9	90.00	206.05	603.95
321	5	5	53	4	3	4	2	90.00	36.06	143.94
294	53	5	27	2	1	2	2	90.00	152.56	27.44
218	77	5	151	5	2	4	8	90.00	299.09	420.91
176	47	5	278	4	3	4	5	90.00	191.19	258.81
83	12	5	268	2	4	2	6	90.00	128.33	411.67
1964	8	6	166	3	1	3	3	1700.00	232.52	4867.48
1960	81	6	253	4	1	4	10	1700.00	80.43	16919.57
1944	57	6	152	4	3	4	6	1700.00	201.13	9998.87
1911	34	6	90	1	3	2	3	1700.00	102.98	4997.02
1879	19	6	158	3	1	3	2	1700.00	148.54	3251.46
1743	33	6	78	4	4	1	5	1700.00	91.08	8408.92
1728	90	6	221	1	1	3	1	1700.00	171.02	1528.98
1678	44	6	156	5	2	1	3	1700.00	30.42	5069.58
1582	1	6	52	5	1	2	7	1700.00	101.16	11798.84
1428	82	6	287	3	3	2	7	1700.00	91.06	11808.94
1326	7	6	363	4	3	3	2	1700.00	221.38	3178.62
1308	24	6	363	1	1	2	3	1700.00	177.32	4922.68
1244	92	6	272	2	1	3	10	1700.00	255.33	16744.67
1226	2	6	118	4	2	1	4	1700.00	184.72	6615.28
1181	73	6	117	3	3	4	7	1700.00	177.97	11722.03
1102	16	6	304	1	3	4	7	1700.00	165.93	11734.07
1097	97	6	186	3	1	4	1	1700.00	263.40	1436.60
1072	14	6	220	4	1	2	7	1700.00	164.72	11735.28
1067	29	6	55	3	1	2	7	1700.00	2.50	11897.50
777	3	6	58	5	3	2	4	1700.00	26.22	6773.78
756	87	6	364	3	4	4	5	1700.00	166.88	8333.12
709	38	6	299	3	3	3	5	1700.00	28.77	8471.23
665	13	6	224	2	2	3	1	1700.00	129.12	1570.88
615	33	6	204	4	3	4	8	1700.00	135.29	13464.71
574	40	6	209	5	3	3	2	1700.00	212.84	3187.16
534	27	6	215	3	4	3	4	1700.00	129.09	6670.91
392	58	6	325	1	3	3	4	1700.00	24.95	6775.05
244	17	6	39	3	1	4	1	1700.00	276.20	1423.80
210	52	6	199	1	4	3	6	1700.00	45.47	10154.53
207	94	6	252	1	2	3	3	1700.00	227.04	4872.96
191	31	6	285	5	2	3	6	1700.00	133.06	10066.94
120	11	6	86	5	3	1	4	1700.00	275.16	6524.84
112	16	6	39	5	1	2	8	1700.00	246.50	13353.50
40	83	6	123	1	2	3	6	1700.00	60.42	10139.58
1947	86	7	267	2	4	1	1	550.00	189.95	360.05
1918	17	7	126	1	2	4	6	550.00	226.77	3073.23
1903	98	7	250	1	4	4	3	550.00	100.99	1549.01
1817	48	7	190	2	2	4	4	550.00	113.36	2086.64
1785	12	7	216	5	2	1	8	550.00	69.16	4330.84
1770	78	7	342	2	4	2	10	550.00	177.80	5322.20
1737	33	7	345	1	1	3	2	550.00	108.96	991.04
1588	15	7	286	3	4	4	8	550.00	18.79	4381.21
1495	15	7	307	1	2	1	10	550.00	218.25	5281.75
1432	84	7	352	2	2	4	2	550.00	28.09	1071.91
1395	29	7	65	3	4	3	1	550.00	153.44	396.56
1377	30	7	305	2	4	3	1	550.00	174.28	375.72
1344	92	7	249	5	1	3	5	550.00	155.24	2594.76
1290	7	7	333	4	2	3	10	550.00	275.59	5224.41
1277	67	7	355	4	1	3	2	550.00	157.18	942.82
1180	65	7	264	4	3	4	9	550.00	266.56	4683.44
1176	99	7	60	4	2	1	8	550.00	104.04	4295.96
1169	17	7	30	5	1	3	7	550.00	13.73	3836.27
1146	37	7	7	3	2	2	10	550.00	247.55	5252.45
1074	98	7	351	2	3	2	7	550.00	26.72	3823.28
1058	73	7	136	2	3	4	8	550.00	103.06	4296.94
1040	40	7	180	2	4	3	9	550.00	101.12	4848.88
1001	59	7	308	4	1	1	4	550.00	130.64	2069.36
926	14	7	246	4	1	2	1	550.00	252.46	297.54
863	57	7	206	3	1	4	2	550.00	96.41	1003.59
861	100	7	180	4	2	2	5	550.00	94.84	2655.16
817	27	7	213	2	4	4	5	550.00	34.89	2715.11
781	46	7	168	2	2	3	9	550.00	155.52	4794.48
614	3	7	212	4	1	4	10	550.00	13.43	5486.57
606	46	7	168	1	4	3	9	550.00	24.27	4925.73
425	14	7	265	4	2	3	8	550.00	86.12	4313.88
390	92	7	310	5	4	3	1	550.00	206.76	343.24
356	11	7	261	3	2	3	6	550.00	74.74	3225.26
347	84	7	29	1	3	1	5	550.00	197.55	2552.45
296	46	7	192	1	4	4	7	550.00	20.99	3829.01
292	83	7	214	1	4	2	4	550.00	133.02	2066.98
272	4	7	204	5	2	3	4	550.00	219.53	1980.47
136	71	7	316	5	3	2	10	550.00	239.96	5260.04
126	72	7	212	5	3	3	5	550.00	147.22	2602.78
81	80	7	119	2	4	2	3	550.00	247.41	1402.59
31	27	7	140	2	1	1	4	550.00	22.63	2177.37
10	84	7	247	3	2	3	6	550.00	55.22	3244.78
1975	35	8	75	2	1	4	9	300.00	263.04	2436.96
1759	72	8	131	2	2	1	1	300.00	8.86	291.14
1749	85	8	27	2	1	1	8	300.00	78.37	2321.63
1710	15	8	346	4	4	1	7	300.00	145.90	1954.10
1669	21	8	144	2	2	2	9	300.00	21.15	2678.85
1629	11	8	192	4	1	1	8	300.00	21.01	2378.99
1524	83	8	306	3	1	4	4	300.00	13.26	1186.74
1500	37	8	1	2	3	2	7	300.00	6.94	2093.06
1442	100	8	62	5	3	3	1	300.00	102.52	197.48
1422	20	8	212	4	2	3	6	300.00	74.65	1725.35
1410	10	8	334	5	1	1	10	300.00	49.33	2950.67
1408	27	8	210	1	1	4	3	300.00	107.81	792.19
1398	31	8	333	1	3	4	6	300.00	78.36	1721.64
1296	27	8	277	5	1	4	1	300.00	266.09	33.91
1247	65	8	190	2	1	3	1	300.00	146.32	153.68
1211	60	8	348	5	1	1	6	300.00	244.11	1555.89
1052	62	8	188	3	3	1	1	300.00	116.05	183.95
1012	79	8	208	3	1	1	2	300.00	291.70	308.30
980	44	8	343	2	2	2	9	300.00	32.62	2667.38
944	90	8	83	5	3	4	5	300.00	100.93	1399.07
871	9	8	46	3	3	3	7	300.00	12.53	2087.47
862	72	8	12	2	4	2	3	300.00	131.06	768.94
819	41	8	28	3	4	3	2	300.00	213.63	386.37
784	50	8	209	1	2	3	4	300.00	284.57	915.43
727	39	8	176	2	3	2	9	300.00	73.59	2626.41
719	93	8	10	2	4	1	1	300.00	48.67	251.33
620	73	8	128	2	1	1	7	300.00	131.76	1968.24
602	87	8	230	5	1	4	9	300.00	116.67	2583.33
562	85	8	338	2	4	4	9	300.00	228.22	2471.78
522	87	8	23	1	3	1	7	300.00	151.24	1948.76
519	36	8	229	4	3	1	4	300.00	64.35	1135.65
375	95	8	225	2	3	3	9	300.00	70.01	2629.99
288	48	8	294	4	4	4	10	300.00	199.54	2800.46
266	84	8	349	3	3	2	1	300.00	49.97	250.03
70	50	8	80	2	3	1	6	300.00	190.60	1609.40
56	3	8	75	1	4	3	4	300.00	104.57	1095.43
1939	71	9	58	4	2	4	2	500.00	125.42	874.58
1878	9	9	271	4	2	3	2	500.00	137.86	862.14
1819	15	9	326	3	3	4	7	500.00	47.05	3452.95
1784	76	9	208	3	2	4	4	500.00	97.46	1902.54
1730	36	9	246	3	1	3	5	500.00	11.77	2488.23
1723	98	9	201	3	2	1	2	500.00	211.76	788.24
1707	3	9	167	5	1	2	10	500.00	190.14	4809.86
1589	86	9	41	5	3	2	8	500.00	132.64	3867.36
1575	12	9	137	5	2	2	4	500.00	20.89	1979.11
1467	44	9	57	5	1	2	4	500.00	96.37	1903.63
1426	74	9	338	1	4	1	6	500.00	16.66	2983.34
1420	52	9	70	3	2	4	9	500.00	158.14	4341.86
1325	30	9	304	3	4	1	3	500.00	37.18	1462.82
1232	17	9	75	2	1	3	8	500.00	149.77	3850.23
1173	53	9	54	1	1	4	7	500.00	170.50	3329.50
1118	20	9	196	1	4	3	5	500.00	234.84	2265.16
1070	74	9	107	4	3	3	7	500.00	173.37	3326.63
835	39	9	204	2	2	4	4	500.00	262.39	1737.61
706	18	9	259	1	1	3	5	500.00	255.13	2244.87
689	57	9	175	2	4	3	8	500.00	4.78	3995.22
546	33	9	130	1	1	1	10	500.00	254.84	4745.16
468	53	9	98	5	3	3	1	500.00	214.64	285.36
337	24	9	211	1	4	1	10	500.00	156.73	4843.27
333	30	9	349	3	4	1	2	500.00	167.45	832.55
279	18	9	109	3	1	2	7	500.00	204.07	3295.93
212	38	9	358	4	3	1	1	500.00	106.46	393.54
193	7	9	76	4	4	4	7	500.00	252.43	3247.57
169	49	9	325	5	3	3	9	500.00	287.84	4212.16
129	29	9	182	1	3	1	4	500.00	165.16	1834.84
62	45	9	33	1	2	3	10	500.00	37.53	4962.47
46	20	9	140	2	3	1	5	500.00	76.01	2423.99
1951	83	10	35	5	4	1	7	100.00	102.89	597.11
1855	43	10	263	2	4	4	5	100.00	88.31	411.69
1842	71	10	316	3	4	2	8	100.00	128.05	671.95
1791	29	10	323	5	4	3	10	100.00	180.57	819.43
1709	85	10	192	4	1	2	9	100.00	219.60	680.40
1702	34	10	335	3	4	4	1	100.00	4.51	95.49
1676	17	10	70	5	2	1	3	100.00	148.38	151.62
1649	53	10	102	1	1	1	6	100.00	220.71	379.29
1643	37	10	56	1	3	1	10	100.00	226.48	773.52
1517	77	10	308	1	1	3	9	100.00	291.63	608.37
1456	41	10	254	1	2	1	9	100.00	232.92	667.08
1455	19	10	7	1	1	4	8	100.00	274.85	525.15
1453	44	10	139	4	2	4	8	100.00	287.02	512.98
1376	93	10	329	4	3	4	3	100.00	182.11	117.89
1373	32	10	199	3	3	3	4	100.00	65.32	334.68
1305	59	10	50	5	1	1	9	100.00	161.05	738.95
1206	86	10	324	2	1	4	9	100.00	84.04	815.96
1189	52	10	308	1	2	3	10	100.00	53.55	946.45
1152	54	10	36	4	1	1	10	100.00	154.86	845.14
1090	85	10	272	4	1	1	8	100.00	190.67	609.33
1059	44	10	165	4	3	1	3	100.00	269.81	30.19
1023	9	10	87	3	1	1	4	100.00	210.21	189.79
974	3	10	100	5	4	4	6	100.00	63.86	536.14
933	95	10	48	2	2	2	5	100.00	262.77	237.23
906	92	10	9	5	4	2	8	100.00	39.88	760.12
858	5	10	328	1	1	2	7	100.00	139.85	560.15
845	3	10	82	4	3	4	7	100.00	113.80	586.20
811	96	10	222	1	1	3	7	100.00	32.11	667.89
799	20	10	181	4	1	4	5	100.00	31.33	468.67
785	18	10	105	1	1	1	6	100.00	197.31	402.69
773	2	10	172	4	4	2	8	100.00	15.60	784.40
757	55	10	322	5	3	3	5	100.00	162.23	337.77
738	52	10	55	4	1	4	8	100.00	122.32	677.68
731	33	10	259	4	3	2	5	100.00	286.04	213.96
716	46	10	326	4	2	3	7	100.00	38.03	661.97
652	88	10	22	5	4	1	7	100.00	192.12	507.88
621	63	10	61	4	4	1	4	100.00	242.79	157.21
587	35	10	69	5	4	1	9	100.00	133.43	766.57
450	39	10	111	3	4	4	4	100.00	177.75	222.25
440	57	10	225	2	2	3	4	100.00	168.02	231.98
420	28	10	285	4	3	4	2	100.00	79.13	120.87
247	80	10	157	1	3	1	5	100.00	61.50	438.50
196	41	10	240	5	3	1	4	100.00	75.61	324.39
185	25	10	149	5	1	4	5	100.00	165.19	334.81
138	90	10	256	4	2	2	4	100.00	112.19	287.81
125	60	10	143	1	4	2	8	100.00	2.58	797.42
93	15	10	189	3	1	2	3	100.00	206.55	93.45
66	36	10	164	1	3	2	8	100.00	286.61	513.39
13	21	10	190	2	3	4	3	100.00	187.63	112.37
1953	30	11	167	2	1	2	6	200.00	52.85	1147.15
1868	74	11	54	5	1	1	10	200.00	50.52	1949.48
1827	69	11	206	5	4	3	9	200.00	40.59	1759.41
1715	30	11	299	5	4	3	9	200.00	225.48	1574.52
1695	57	11	291	1	2	1	3	200.00	36.74	563.26
1663	67	11	260	5	3	3	4	200.00	280.52	519.48
1610	95	11	248	3	4	1	3	200.00	200.92	399.08
1556	7	11	100	3	3	4	3	200.00	81.31	518.69
1535	77	11	129	4	4	2	3	200.00	236.91	363.09
1526	73	11	47	2	2	2	4	200.00	133.26	666.74
1471	59	11	291	4	3	4	7	200.00	280.04	1119.96
1245	89	11	151	1	1	3	2	200.00	274.55	125.45
1182	11	11	292	4	2	4	5	200.00	193.12	806.88
1160	19	11	314	1	1	2	7	200.00	134.89	1265.11
1151	83	11	184	1	4	1	3	200.00	95.56	504.44
1149	5	11	38	3	3	4	7	200.00	202.76	1197.24
1123	55	11	285	4	4	3	7	200.00	44.96	1355.04
1104	11	11	8	5	1	3	7	200.00	162.26	1237.74
1043	31	11	202	5	2	2	1	200.00	198.11	1.89
1013	69	11	277	1	3	1	6	200.00	103.25	1096.75
984	38	11	238	4	3	1	7	200.00	147.71	1252.29
910	48	11	123	5	1	1	7	200.00	99.43	1300.57
874	74	11	161	1	4	2	6	200.00	42.27	1157.73
788	11	11	89	1	4	1	7	200.00	266.91	1133.09
754	10	11	274	3	3	1	2	200.00	187.33	212.67
744	85	11	137	5	1	3	7	200.00	7.43	1392.57
737	47	11	361	1	1	3	8	200.00	184.52	1415.48
734	82	11	157	1	1	1	10	200.00	67.50	1932.50
722	77	11	1	5	1	2	6	200.00	143.64	1056.36
626	84	11	315	5	2	2	6	200.00	25.44	1174.56
604	70	11	174	3	4	2	6	200.00	77.32	1122.68
569	60	11	360	2	2	2	6	200.00	52.90	1147.10
555	71	11	345	4	4	4	4	200.00	200.74	599.26
502	38	11	119	3	4	2	2	200.00	176.48	223.52
208	31	11	91	4	1	3	9	200.00	146.49	1653.51
183	79	11	142	4	3	1	2	200.00	112.15	287.85
153	17	11	48	3	1	4	7	200.00	253.51	1146.49
119	77	11	235	1	4	1	5	200.00	252.88	747.12
18	11	11	15	1	1	4	9	200.00	7.37	1792.63
2000	22	12	208	4	3	2	10	400.00	240.59	3759.41
1999	35	12	149	2	2	4	2	400.00	83.29	716.71
1841	39	12	282	2	1	2	4	400.00	72.86	1527.14
1834	42	12	364	3	3	2	10	400.00	147.38	3852.62
1822	53	12	101	3	1	4	7	400.00	7.74	2792.26
1789	86	12	344	2	2	4	2	400.00	228.59	571.41
1787	49	12	103	5	1	1	1	400.00	99.08	300.92
1772	6	12	362	4	1	4	10	400.00	271.66	3728.34
1729	79	12	159	5	1	3	9	400.00	277.64	3322.36
1692	88	12	357	4	4	3	4	400.00	176.77	1423.23
1690	16	12	151	2	3	3	8	400.00	296.06	2903.94
1573	79	12	15	1	2	4	1	400.00	76.02	323.98
1479	14	12	274	5	1	2	6	400.00	283.86	2116.14
1478	99	12	28	2	1	3	8	400.00	135.54	3064.46
1449	23	12	222	5	2	3	1	400.00	171.06	228.94
1402	18	12	262	4	2	2	7	400.00	148.11	2651.89
1378	79	12	16	5	1	2	4	400.00	19.02	1580.98
1364	67	12	356	4	2	3	5	400.00	236.35	1763.65
1356	92	12	110	1	2	1	1	400.00	173.56	226.44
1318	95	12	194	2	1	2	2	400.00	64.69	735.31
1317	7	12	197	5	1	3	1	400.00	299.30	100.70
1287	19	12	330	5	4	3	2	400.00	187.17	612.83
1285	71	12	161	4	3	1	5	400.00	120.68	1879.32
1215	41	12	236	4	3	1	4	400.00	209.29	1390.71
1213	86	12	214	4	2	4	7	400.00	59.28	2740.72
1204	53	12	113	4	2	2	7	400.00	28.24	2771.76
1141	89	12	11	2	4	2	1	400.00	14.33	385.67
1080	15	12	40	5	4	4	6	400.00	98.11	2301.89
1016	72	12	314	1	3	1	7	400.00	204.72	2595.28
948	70	12	75	1	2	3	6	400.00	221.77	2178.23
853	60	12	57	1	3	4	10	400.00	104.80	3895.20
831	39	12	167	4	3	4	10	400.00	291.18	3708.82
823	5	12	249	5	2	4	1	400.00	267.60	132.40
822	41	12	159	5	1	4	4	400.00	193.41	1406.59
793	92	12	133	4	3	4	2	400.00	199.28	600.72
765	36	12	303	2	4	1	9	400.00	219.47	3380.53
763	66	12	81	1	3	4	5	400.00	148.89	1851.11
526	56	12	315	1	4	2	9	400.00	273.50	3326.50
509	11	12	107	4	3	2	10	400.00	153.92	3846.08
491	65	12	329	4	2	1	3	400.00	202.40	997.60
481	20	12	245	1	3	3	10	400.00	46.33	3953.67
449	25	12	29	3	1	4	9	400.00	55.08	3544.92
432	49	12	318	1	4	2	3	400.00	43.47	1156.53
377	90	12	362	4	2	4	3	400.00	55.85	1144.15
287	75	12	261	2	1	3	10	400.00	232.10	3767.90
232	49	12	262	3	2	3	6	400.00	295.81	2104.19
200	47	12	362	5	1	1	9	400.00	283.99	3316.01
192	24	12	152	5	4	3	7	400.00	174.86	2625.14
92	33	12	46	1	1	3	8	400.00	127.47	3072.53
79	5	12	36	2	2	1	7	400.00	11.65	2788.35
8	84	12	332	1	3	2	10	400.00	263.02	3736.98
1882	80	13	262	5	4	2	8	450.00	58.53	3541.47
1801	74	13	223	5	2	4	7	450.00	218.80	2931.20
1742	49	13	23	4	1	4	7	450.00	200.00	2950.00
1635	89	13	155	5	3	2	9	450.00	47.97	4002.03
1623	91	13	123	4	3	3	3	450.00	240.05	1109.95
1574	95	13	71	2	2	4	5	450.00	276.19	1973.81
1549	91	13	312	3	2	2	7	450.00	214.02	2935.98
1505	65	13	202	4	2	4	5	450.00	30.66	2219.34
1490	49	13	331	2	2	1	10	450.00	228.08	4271.92
1446	32	13	76	2	4	1	7	450.00	176.85	2973.15
1419	14	13	283	3	4	3	4	450.00	25.26	1774.74
1418	35	13	56	4	2	3	5	450.00	136.78	2113.22
1338	86	13	352	2	1	1	1	450.00	228.94	221.06
1309	21	13	83	4	3	2	4	450.00	108.00	1692.00
1306	42	13	56	2	2	2	9	450.00	195.52	3854.48
1288	69	13	326	1	4	4	8	450.00	105.21	3494.79
1194	51	13	280	1	4	1	2	450.00	157.22	742.78
1140	91	13	19	5	3	3	3	450.00	200.77	1149.23
1132	44	13	7	1	2	3	2	450.00	200.92	699.08
1121	44	13	355	1	4	4	4	450.00	282.96	1517.04
1093	89	13	281	1	1	3	3	450.00	291.41	1058.59
1053	74	13	249	4	4	2	9	450.00	188.69	3861.31
1032	15	13	244	3	3	4	6	450.00	145.12	2554.88
1028	2	13	310	1	1	2	2	450.00	75.35	824.65
806	68	13	318	5	1	3	8	450.00	180.16	3419.84
779	1	13	18	4	2	4	6	450.00	203.14	2496.86
776	46	13	124	1	4	3	10	450.00	235.08	4264.92
746	41	13	360	2	2	3	7	450.00	193.59	2956.41
656	34	13	353	5	2	1	1	450.00	147.83	302.17
634	92	13	216	3	1	3	7	450.00	56.20	3093.80
622	46	13	39	3	4	1	5	450.00	103.37	2146.63
560	40	13	67	1	2	1	9	450.00	71.42	3978.58
530	15	13	19	4	2	4	8	450.00	242.85	3357.15
381	57	13	32	4	1	3	7	450.00	119.04	3030.96
352	90	13	197	3	2	3	4	450.00	218.28	1581.72
345	39	13	61	2	4	4	10	450.00	285.22	4214.78
276	60	13	220	2	3	2	7	450.00	134.55	3015.45
240	47	13	123	5	4	4	9	450.00	81.94	3968.06
73	71	13	181	1	2	1	3	450.00	130.83	1219.17
67	70	13	337	1	3	2	3	450.00	203.52	1146.48
52	34	13	273	2	1	2	9	450.00	104.38	3945.62
39	14	13	15	3	1	3	2	450.00	80.89	819.11
1991	40	14	204	2	4	2	1	1490.00	259.52	1230.48
1959	89	14	107	5	4	4	5	1490.00	122.01	7327.99
1955	86	14	349	4	3	3	9	1490.00	160.20	13249.80
1851	73	14	248	3	3	4	5	1490.00	62.42	7387.58
1836	82	14	30	3	2	4	6	1490.00	286.12	8653.88
1731	91	14	59	3	1	4	6	1490.00	207.14	8732.86
1628	39	14	282	3	2	1	2	1490.00	234.47	2745.53
1612	2	14	104	4	2	4	7	1490.00	87.70	10342.30
1570	23	14	28	1	3	4	8	1490.00	177.41	11742.59
1550	11	14	33	1	4	3	8	1490.00	75.29	11844.71
1503	41	14	270	3	1	3	4	1490.00	177.90	5782.10
1451	36	14	251	2	3	2	2	1490.00	116.50	2863.50
1444	62	14	178	3	2	3	5	1490.00	222.04	7227.96
1393	9	14	226	5	3	1	3	1490.00	289.77	4180.23
1374	92	14	340	5	1	4	9	1490.00	189.74	13220.26
1361	42	14	260	3	1	2	4	1490.00	133.29	5826.71
1359	67	14	303	1	2	1	3	1490.00	271.34	4198.66
1301	85	14	346	2	1	4	4	1490.00	143.17	5816.83
1239	46	14	94	4	4	3	6	1490.00	263.54	8676.46
1234	22	14	145	1	1	2	9	1490.00	91.11	13318.89
1187	29	14	188	5	4	4	7	1490.00	57.74	10372.26
1178	98	14	12	2	3	4	6	1490.00	237.83	8702.17
1168	67	14	363	4	2	1	4	1490.00	151.38	5808.62
1071	92	14	17	4	4	1	10	1490.00	157.64	14742.36
1030	83	14	9	5	1	1	1	1490.00	223.62	1266.38
1007	47	14	261	3	1	3	9	1490.00	100.96	13309.04
989	77	14	97	4	3	3	3	1490.00	49.19	4420.81
913	43	14	207	4	1	3	8	1490.00	8.32	11911.68
813	28	14	239	4	2	1	3	1490.00	213.29	4256.71
752	92	14	112	4	4	2	5	1490.00	241.37	7208.63
658	37	14	336	1	1	4	9	1490.00	249.79	13160.21
613	54	14	116	4	2	4	1	1490.00	208.69	1281.31
531	50	14	281	5	4	4	10	1490.00	215.68	14684.32
409	72	14	192	1	1	3	2	1490.00	77.22	2902.78
407	62	14	350	2	3	3	2	1490.00	230.99	2749.01
335	47	14	238	3	3	3	1	1490.00	252.44	1237.56
301	38	14	227	4	3	3	8	1490.00	193.38	11726.62
280	76	14	136	2	3	3	6	1490.00	259.57	8680.43
277	57	14	339	1	2	2	3	1490.00	28.49	4441.51
255	79	14	128	4	2	1	2	1490.00	250.21	2729.79
195	46	14	50	4	2	3	3	1490.00	202.05	4267.95
189	60	14	306	1	4	3	4	1490.00	0.38	5959.62
178	2	14	307	3	1	1	8	1490.00	86.44	11833.56
123	41	14	2	5	2	4	9	1490.00	255.51	13154.49
89	55	14	150	3	4	2	7	1490.00	198.68	10231.32
86	7	14	182	2	1	1	10	1490.00	249.31	14650.69
17	81	14	255	1	2	1	3	1490.00	284.58	4185.42
1971	73	15	351	5	4	1	7	300.00	254.70	1845.30
1970	76	15	287	5	1	2	3	300.00	255.42	644.58
1969	62	15	196	2	1	4	2	300.00	48.63	551.37
1887	87	15	297	1	3	4	8	300.00	33.21	2366.79
1871	70	15	284	5	4	3	4	300.00	146.22	1053.78
1745	18	15	227	4	2	2	2	300.00	171.78	428.22
1611	33	15	148	3	1	3	1	300.00	178.45	121.55
1529	75	15	281	2	3	4	7	300.00	271.99	1828.01
1506	93	15	174	3	3	4	1	300.00	252.86	47.14
1275	59	15	292	5	3	1	5	300.00	44.25	1455.75
1265	84	15	334	2	1	4	8	300.00	16.57	2383.43
1184	9	15	145	1	4	3	5	300.00	110.95	1389.05
1162	1	15	361	4	1	1	2	300.00	215.10	384.90
1147	44	15	194	2	3	3	1	300.00	34.97	265.03
1087	5	15	315	1	1	1	6	300.00	195.76	1604.24
939	31	15	54	1	2	2	2	300.00	275.41	324.59
884	17	15	295	1	1	4	5	300.00	246.51	1253.49
864	51	15	345	4	1	2	6	300.00	177.08	1622.92
683	20	15	138	4	1	3	10	300.00	151.47	2848.53
558	57	15	89	4	4	3	1	300.00	206.48	93.52
501	28	15	339	2	1	4	2	300.00	71.37	528.63
486	97	15	79	4	2	3	6	300.00	173.86	1626.14
443	73	15	293	2	4	4	3	300.00	74.24	825.76
385	86	15	105	2	2	2	9	300.00	193.64	2506.36
306	56	15	52	3	2	4	3	300.00	157.60	742.40
236	3	15	12	5	2	1	4	300.00	96.50	1103.50
227	99	15	343	4	4	1	9	300.00	208.03	2491.97
116	14	15	51	2	1	4	9	300.00	135.03	2564.97
94	61	15	242	4	1	3	3	300.00	69.37	830.63
1997	79	16	333	5	3	4	8	29.00	154.40	77.60
1965	62	16	214	5	1	3	7	29.00	55.69	147.31
1943	16	16	26	4	2	2	9	29.00	24.93	236.07
1921	84	16	299	2	3	1	9	29.00	19.64	241.36
1915	13	16	260	3	2	1	3	29.00	52.34	34.66
1833	40	16	86	1	3	2	8	29.00	34.09	197.91
1811	53	16	241	5	3	4	7	29.00	51.84	151.16
1626	97	16	264	4	4	3	9	29.00	51.91	209.09
1429	93	16	228	4	3	1	6	29.00	75.02	98.98
1394	55	16	351	4	2	1	4	29.00	59.63	56.37
1390	98	16	231	1	3	2	5	29.00	69.27	75.73
1295	42	16	49	2	2	3	5	29.00	43.93	101.07
1125	83	16	172	2	3	1	10	29.00	9.17	280.83
1069	52	16	193	3	1	2	8	29.00	208.79	23.21
1037	3	16	194	3	4	4	4	29.00	97.58	18.42
794	45	16	292	2	3	3	9	29.00	260.15	0.85
791	84	16	328	5	4	3	3	29.00	66.93	20.07
787	18	16	143	5	4	2	7	29.00	182.22	20.78
774	18	16	178	2	4	3	5	29.00	58.24	86.76
729	82	16	112	3	1	3	4	29.00	18.25	97.75
678	43	16	28	2	4	4	8	29.00	198.93	33.07
598	11	16	250	2	4	3	10	29.00	2.07	287.93
563	94	16	273	2	1	4	7	29.00	91.14	111.86
246	47	16	283	2	3	1	9	29.00	13.97	247.03
133	61	16	165	5	1	4	6	29.00	19.39	154.61
1740	53	17	182	1	3	2	8	37.00	56.67	239.33
1632	53	17	161	1	3	2	9	37.00	100.60	232.40
1482	18	17	336	2	3	3	10	37.00	49.06	320.94
1412	98	17	15	3	4	3	5	37.00	132.96	52.04
1335	85	17	7	4	1	1	6	37.00	152.61	69.39
1255	10	17	18	4	2	3	7	37.00	73.54	185.46
1236	29	17	228	2	1	3	6	37.00	213.18	8.82
1231	30	17	92	2	1	1	7	37.00	201.12	57.88
965	38	17	194	1	2	3	9	37.00	180.28	152.72
956	24	17	169	1	2	2	8	37.00	44.34	251.66
925	9	17	274	1	4	4	6	37.00	42.22	179.78
915	58	17	99	2	4	2	7	37.00	153.39	105.61
810	68	17	151	1	2	2	1	37.00	29.28	7.72
809	60	17	302	1	4	1	7	37.00	85.52	173.48
396	58	17	354	2	1	1	9	37.00	285.50	47.50
361	85	17	107	2	3	1	8	37.00	186.76	109.24
351	53	17	99	1	4	1	9	37.00	195.17	137.83
310	87	17	324	1	2	3	9	37.00	27.08	305.92
307	80	17	67	4	3	4	8	37.00	180.20	115.80
1985	9	18	58	5	3	3	1	50.00	32.35	17.65
1958	14	18	326	3	1	3	4	50.00	76.07	123.93
1923	5	18	351	4	2	1	10	50.00	170.55	329.45
1884	15	18	306	4	4	1	4	50.00	103.64	96.36
1870	100	18	224	3	2	1	5	50.00	34.06	215.94
1761	87	18	174	3	2	4	6	50.00	247.14	52.86
1721	43	18	253	3	4	4	8	50.00	103.91	296.09
1670	18	18	289	3	1	2	10	50.00	162.28	337.72
1662	91	18	3	2	3	3	1	50.00	46.20	3.80
1553	70	18	192	5	4	1	3	50.00	146.58	3.42
1462	49	18	136	3	3	2	5	50.00	238.34	11.66
1320	76	18	112	3	2	1	8	50.00	140.93	259.07
1303	87	18	219	1	3	3	10	50.00	209.91	290.09
1283	97	18	63	5	3	1	9	50.00	223.18	226.82
1253	29	18	326	3	4	4	9	50.00	282.00	168.00
1156	40	18	21	2	1	1	5	50.00	181.91	68.09
1127	65	18	315	4	2	2	1	50.00	25.35	24.65
1094	31	18	160	4	3	1	1	50.00	25.31	24.69
1003	66	18	101	2	3	2	3	50.00	129.98	20.02
938	52	18	270	5	4	1	10	50.00	66.90	433.10
921	34	18	183	5	1	4	4	50.00	110.67	89.33
912	1	18	76	3	3	4	4	50.00	90.50	109.50
905	39	18	297	4	3	4	10	50.00	209.97	290.03
825	43	18	294	3	4	3	10	50.00	207.56	292.44
775	98	18	312	2	3	2	2	50.00	47.40	52.60
758	64	18	89	2	2	1	9	50.00	74.83	375.17
747	69	18	324	1	4	2	8	50.00	0.58	399.42
733	34	18	17	1	2	2	9	50.00	256.58	193.42
685	91	18	18	4	4	1	5	50.00	125.10	124.90
659	8	18	153	2	1	1	4	50.00	94.25	105.75
618	50	18	167	5	2	2	4	50.00	169.81	30.19
473	40	18	17	1	4	4	3	50.00	122.15	27.85
446	45	18	237	1	3	3	4	50.00	37.92	162.08
438	29	18	98	5	2	3	3	50.00	9.02	140.98
386	69	18	70	3	2	2	9	50.00	144.09	305.91
365	44	18	35	4	4	3	2	50.00	57.22	42.78
317	97	18	117	3	4	3	9	50.00	47.51	402.49
172	57	18	23	5	1	1	9	50.00	104.25	345.75
148	98	18	334	2	3	3	2	50.00	27.11	72.89
122	21	18	83	2	3	3	5	50.00	158.97	91.03
53	42	18	311	1	3	2	9	50.00	282.86	167.14
1977	27	19	288	1	2	3	5	100.00	117.40	382.60
1914	84	19	172	4	2	4	6	100.00	0.50	599.50
1843	63	19	305	4	2	2	6	100.00	156.39	443.61
1786	60	19	101	3	4	1	5	100.00	12.07	487.93
1782	37	19	351	3	3	3	10	100.00	20.12	979.88
1732	52	19	150	5	3	4	4	100.00	126.38	273.62
1511	93	19	267	2	1	4	9	100.00	164.35	735.65
1492	79	19	340	2	4	3	8	100.00	240.47	559.53
1469	82	19	52	5	3	2	10	100.00	143.85	856.15
1258	43	19	324	5	4	2	7	100.00	241.75	458.25
1230	68	19	298	4	1	4	8	100.00	166.49	633.51
1220	14	19	352	5	1	3	8	100.00	6.33	793.67
1216	59	19	46	2	4	3	5	100.00	4.38	495.62
1199	36	19	120	4	2	3	10	100.00	94.94	905.06
1129	3	19	191	4	1	4	4	100.00	40.10	359.90
1109	67	19	166	1	1	1	2	100.00	69.96	130.04
1062	45	19	107	2	3	3	8	100.00	48.15	751.85
1036	13	19	296	2	1	4	1	100.00	43.44	56.56
1031	13	19	265	3	2	1	8	100.00	43.26	756.74
987	30	19	197	3	2	2	6	100.00	71.24	528.76
964	18	19	171	4	1	3	6	100.00	274.80	325.20
917	83	19	297	1	3	4	3	100.00	238.00	62.00
897	48	19	77	2	1	1	6	100.00	166.89	433.11
896	97	19	347	1	1	2	9	100.00	179.94	720.06
869	59	19	316	5	4	3	5	100.00	84.26	415.74
856	94	19	206	2	2	1	7	100.00	172.50	527.50
850	14	19	348	1	2	4	8	100.00	147.96	652.04
833	79	19	199	5	1	1	10	100.00	277.56	722.44
798	22	19	78	1	4	3	9	100.00	76.42	823.58
795	49	19	246	2	3	1	7	100.00	155.48	544.52
720	99	19	351	4	1	2	7	100.00	136.64	563.36
688	11	19	354	3	1	4	4	100.00	262.26	137.74
583	49	19	1	4	4	1	10	100.00	15.38	984.62
523	88	19	52	2	3	4	7	100.00	179.24	520.76
453	67	19	268	4	2	1	5	100.00	96.75	403.25
413	76	19	246	1	1	2	4	100.00	138.95	261.05
403	47	19	141	3	1	1	7	100.00	276.70	423.30
364	61	19	298	3	1	4	5	100.00	141.42	358.58
344	96	19	61	4	1	3	4	100.00	284.04	115.96
312	95	19	79	1	2	3	6	100.00	71.71	528.29
286	51	19	138	4	4	3	8	100.00	217.46	582.54
254	17	19	28	2	1	3	6	100.00	253.48	346.52
253	27	19	11	2	3	3	8	100.00	169.52	630.48
110	83	19	338	5	2	3	9	100.00	103.40	796.60
106	100	19	222	4	1	3	3	100.00	161.63	138.37
82	35	19	304	1	1	2	7	100.00	6.19	693.81
75	27	19	6	4	3	2	8	100.00	91.13	708.87
28	86	19	234	2	4	4	3	100.00	295.69	4.31
1963	25	20	222	1	1	3	3	1890.00	26.24	5643.76
1946	9	20	55	5	4	2	8	1890.00	75.20	15044.80
1910	74	20	70	5	2	3	3	1890.00	69.12	5600.88
1838	56	20	17	5	4	3	1	1890.00	60.65	1829.35
1815	87	20	279	2	4	3	1	1890.00	207.76	1682.24
1814	36	20	236	5	1	2	3	1890.00	90.53	5579.47
1808	86	20	288	3	4	4	4	1890.00	256.56	7303.44
1804	20	20	294	1	3	4	3	1890.00	280.68	5389.32
1794	14	20	102	3	2	2	6	1890.00	238.20	11101.80
1757	27	20	172	1	2	3	6	1890.00	86.87	11253.13
1716	70	20	358	2	4	3	3	1890.00	0.10	5669.90
1697	78	20	266	1	3	2	10	1890.00	235.31	18664.69
1665	68	20	276	3	2	2	5	1890.00	195.62	9254.38
1637	19	20	176	1	1	4	3	1890.00	45.64	5624.36
1561	18	20	59	2	1	4	8	1890.00	275.18	14844.82
1539	16	20	39	2	4	2	10	1890.00	70.25	18829.75
1531	56	20	61	1	4	2	3	1890.00	57.83	5612.17
1493	52	20	167	3	2	1	9	1890.00	182.27	16827.73
1488	26	20	242	1	3	3	10	1890.00	230.01	18669.99
1487	11	20	187	1	3	2	5	1890.00	130.29	9319.71
1454	44	20	85	1	2	4	7	1890.00	294.63	12935.37
1441	11	20	11	4	4	4	4	1890.00	30.98	7529.02
1437	74	20	304	4	4	1	8	1890.00	201.85	14918.15
1336	14	20	343	1	1	1	7	1890.00	115.23	13114.77
1314	96	20	7	1	4	2	8	1890.00	158.02	14961.98
1313	17	20	113	5	1	2	1	1890.00	298.17	1591.83
1270	13	20	189	5	2	2	5	1890.00	120.12	9329.88
1256	22	20	89	2	2	1	6	1890.00	43.16	11296.84
1222	67	20	330	4	1	3	3	1890.00	205.24	5464.76
1203	69	20	340	3	2	4	6	1890.00	74.86	11265.14
1188	49	20	317	1	3	2	8	1890.00	227.20	14892.80
1155	43	20	326	4	3	3	10	1890.00	90.85	18809.15
1153	48	20	101	4	1	3	7	1890.00	19.49	13210.51
1133	27	20	184	5	3	3	4	1890.00	141.62	7418.38
1064	4	20	104	2	1	3	3	1890.00	239.53	5430.47
973	95	20	149	2	4	2	2	1890.00	297.09	3482.91
967	80	20	24	1	3	4	6	1890.00	177.64	11162.36
919	36	20	242	4	2	2	8	1890.00	0.11	15119.89
866	52	20	184	2	1	4	9	1890.00	253.82	16756.18
818	64	20	354	4	2	1	1	1890.00	278.50	1611.50
684	82	20	223	4	3	2	2	1890.00	276.62	3503.38
669	47	20	85	4	1	2	7	1890.00	13.89	13216.11
619	97	20	340	2	3	4	5	1890.00	276.49	9173.51
573	76	20	234	1	3	3	6	1890.00	68.95	11271.05
478	21	20	187	5	1	2	7	1890.00	275.24	12954.76
456	84	20	297	4	3	3	7	1890.00	283.85	12946.15
444	25	20	210	5	2	2	10	1890.00	34.26	18865.74
411	81	20	337	2	2	2	6	1890.00	159.43	11180.57
318	100	20	346	3	1	3	8	1890.00	213.80	14906.20
313	15	20	245	2	3	1	8	1890.00	187.22	14932.78
259	15	20	301	3	2	1	1	1890.00	70.31	1819.69
226	95	20	262	2	2	4	1	1890.00	169.91	1720.09
30	81	20	269	3	4	2	6	1890.00	83.07	11256.93
22	95	20	267	3	4	2	10	1890.00	112.80	18787.20
1937	15	21	352	5	4	3	3	490.00	137.14	1332.86
1932	84	21	298	2	3	3	8	490.00	151.59	3768.41
1900	58	21	119	5	4	2	9	490.00	99.06	4310.94
1890	35	21	274	3	2	1	1	490.00	156.86	333.14
1823	83	21	111	2	4	4	5	490.00	165.78	2284.22
1805	57	21	140	5	3	2	3	490.00	135.70	1334.30
1664	33	21	47	4	3	4	6	490.00	254.86	2685.14
1657	47	21	124	3	4	1	9	490.00	184.37	4225.63
1461	54	21	28	2	1	4	6	490.00	29.68	2910.32
1382	49	21	41	1	2	1	9	490.00	258.93	4151.07
1343	3	21	129	3	2	3	3	490.00	286.94	1183.06
1334	28	21	360	1	4	1	10	490.00	152.86	4747.14
1202	34	21	53	1	4	3	10	490.00	219.10	4680.90
1198	38	21	235	5	3	1	6	490.00	191.83	2748.17
1190	10	21	228	2	1	1	6	490.00	166.02	2773.98
1186	4	21	127	5	3	1	7	490.00	268.78	3161.22
969	33	21	186	2	4	3	4	490.00	175.27	1784.73
968	37	21	196	5	2	3	10	490.00	192.36	4707.64
945	98	21	329	5	4	4	9	490.00	190.49	4219.51
891	71	21	95	3	1	4	5	490.00	77.87	2372.13
865	3	21	358	1	2	4	7	490.00	182.32	3247.68
832	36	21	197	2	4	3	10	490.00	24.06	4875.94
739	57	21	290	2	4	1	3	490.00	189.56	1280.44
694	28	21	39	1	4	1	4	490.00	123.87	1836.13
666	41	21	19	3	3	4	10	490.00	139.90	4760.10
603	77	21	284	1	2	2	8	490.00	32.76	3887.24
541	44	21	154	2	3	3	6	490.00	228.33	2711.67
428	53	21	87	1	2	1	8	490.00	205.30	3714.70
371	49	21	46	1	1	2	2	490.00	136.29	843.71
324	35	21	18	4	2	2	10	490.00	83.16	4816.84
164	10	21	260	3	3	2	9	490.00	92.81	4317.19
161	21	21	121	1	2	1	9	490.00	158.72	4251.28
135	24	21	18	2	3	3	2	490.00	3.59	976.41
84	52	21	66	4	3	2	6	490.00	219.82	2720.18
65	52	21	14	3	2	4	1	490.00	24.25	465.75
32	55	21	285	2	1	1	4	490.00	295.30	1664.70
1909	46	22	169	5	1	1	3	665.00	264.53	1730.47
1864	78	22	306	2	1	2	5	665.00	173.09	3151.91
1853	35	22	63	2	1	1	9	665.00	175.63	5809.37
1793	37	22	167	4	3	4	1	665.00	172.53	492.47
1750	79	22	146	4	2	2	7	665.00	129.72	4525.28
1602	5	22	285	3	4	2	4	665.00	247.60	2412.40
1522	61	22	21	2	1	1	4	665.00	150.36	2509.64
1463	91	22	236	5	2	1	9	665.00	137.13	5847.87
1425	97	22	17	2	4	4	2	665.00	288.73	1041.27
1413	20	22	38	5	4	4	3	665.00	16.73	1978.27
1257	4	22	273	1	4	2	9	665.00	2.48	5982.52
1225	2	22	141	5	1	2	7	665.00	63.96	4591.04
1167	95	22	91	4	4	1	6	665.00	245.94	3744.06
1137	40	22	213	1	2	4	2	665.00	51.09	1278.91
1126	4	22	222	5	4	1	6	665.00	30.21	3959.79
1115	73	22	202	3	4	4	8	665.00	248.85	5071.15
1112	3	22	344	3	4	2	10	665.00	161.39	6488.61
1038	9	22	29	3	4	4	9	665.00	236.14	5748.86
1035	74	22	114	2	3	2	3	665.00	176.02	1818.98
920	14	22	168	3	4	4	6	665.00	164.02	3825.98
762	49	22	208	5	3	4	1	665.00	49.65	615.35
753	54	22	114	4	2	3	10	665.00	83.71	6566.29
748	73	22	2	2	3	1	6	665.00	246.64	3743.36
736	82	22	248	1	3	2	7	665.00	216.64	4438.36
711	94	22	35	5	4	4	6	665.00	79.63	3910.37
697	7	22	28	1	1	3	3	665.00	271.29	1723.71
671	71	22	290	5	2	2	4	665.00	219.62	2440.38
527	82	22	4	4	4	4	10	665.00	196.85	6453.15
494	37	22	175	1	3	4	3	665.00	198.35	1796.65
460	72	22	132	5	3	1	10	665.00	121.05	6528.95
405	19	22	253	4	3	1	1	665.00	179.94	485.06
353	95	22	136	1	1	3	3	665.00	197.12	1797.88
327	19	22	292	2	2	1	10	665.00	272.03	6377.97
285	29	22	265	5	1	2	9	665.00	152.54	5832.46
235	3	22	133	1	2	1	8	665.00	94.15	5225.85
160	43	22	349	5	1	3	2	665.00	33.76	1296.24
58	26	22	264	5	4	2	1	665.00	180.71	484.29
1998	88	23	223	5	4	2	6	2490.00	62.98	14877.02
1950	33	23	215	4	3	2	8	2490.00	177.94	19742.06
1898	63	23	169	4	3	2	9	2490.00	248.65	22161.35
1881	40	23	70	4	2	2	4	2490.00	33.09	9926.91
1863	89	23	155	4	2	4	9	2490.00	244.40	22165.60
1746	34	23	117	5	2	2	5	2490.00	88.89	12361.11
1736	82	23	178	2	2	3	4	2490.00	73.99	9886.01
1683	17	23	335	3	2	3	1	2490.00	185.85	2304.15
1671	4	23	2	1	2	1	8	2490.00	203.51	19716.49
1658	19	23	101	4	2	3	10	2490.00	193.31	24706.69
1622	44	23	7	2	2	4	8	2490.00	251.46	19668.54
1472	77	23	166	3	4	2	7	2490.00	93.57	17336.43
1466	41	23	259	5	2	3	10	2490.00	95.30	24804.70
1439	64	23	219	4	3	2	1	2490.00	133.44	2356.56
1372	31	23	353	5	2	2	10	2490.00	84.25	24815.75
1347	65	23	124	4	1	2	5	2490.00	277.84	12172.16
1312	42	23	52	5	3	3	3	2490.00	62.14	7407.86
1271	21	23	96	5	3	1	9	2490.00	171.63	22238.37
1209	1	23	245	1	1	3	8	2490.00	72.49	19847.51
1183	6	23	5	5	3	1	1	2490.00	257.78	2232.22
1171	82	23	155	2	1	4	9	2490.00	125.92	22284.08
1086	28	23	179	1	3	2	9	2490.00	82.57	22327.43
1082	3	23	299	1	1	1	6	2490.00	87.42	14852.58
1081	20	23	199	1	4	2	2	2490.00	296.72	4683.28
940	77	23	68	2	4	4	8	2490.00	247.23	19672.77
924	79	23	241	4	2	1	7	2490.00	202.74	17227.26
908	70	23	29	5	4	3	10	2490.00	151.44	24748.56
879	44	23	2	2	2	4	7	2490.00	58.93	17371.07
815	88	23	50	4	4	2	3	2490.00	106.28	7363.72
649	20	23	19	2	4	3	5	2490.00	68.02	12381.98
648	82	23	6	1	1	4	3	2490.00	263.79	7206.21
586	19	23	232	1	2	2	2	2490.00	261.98	4718.02
578	76	23	139	1	4	2	10	2490.00	42.49	24857.51
514	90	23	363	3	4	3	4	2490.00	83.67	9876.33
506	30	23	228	1	4	2	10	2490.00	215.71	24684.29
477	36	23	333	4	4	1	4	2490.00	47.42	9912.58
469	71	23	260	3	2	3	1	2490.00	102.15	2387.85
466	89	23	48	5	2	3	1	2490.00	229.27	2260.73
410	71	23	10	2	4	1	10	2490.00	279.78	24620.22
395	79	23	17	4	2	4	3	2490.00	278.73	7191.27
355	5	23	85	1	3	4	9	2490.00	88.90	22321.10
216	50	23	204	4	4	1	1	2490.00	145.70	2344.30
203	3	23	272	4	4	4	10	2490.00	111.14	24788.86
68	18	23	9	1	4	4	6	2490.00	145.07	14794.93
1987	14	24	123	4	2	4	4	420.00	179.30	1500.70
1924	30	24	51	2	1	2	7	420.00	70.09	2869.91
1904	37	24	6	1	4	4	6	420.00	204.49	2315.51
1902	31	24	132	4	2	4	6	420.00	219.00	2301.00
1894	74	24	200	3	3	3	10	420.00	291.70	3908.30
1848	36	24	255	1	3	1	6	420.00	215.17	2304.83
1724	5	24	49	1	4	4	8	420.00	260.01	3099.99
1718	33	24	106	4	4	3	6	420.00	265.15	2254.85
1703	73	24	235	2	3	1	1	420.00	46.70	373.30
1682	61	24	235	4	2	1	9	420.00	230.63	3549.37
1674	93	24	360	5	3	2	10	420.00	56.62	4143.38
1640	3	24	313	5	3	1	10	420.00	251.16	3948.84
1606	72	24	131	4	1	3	1	420.00	142.99	277.01
1597	9	24	42	3	1	2	2	420.00	165.27	674.73
1476	21	24	132	5	1	3	8	420.00	160.19	3199.81
1427	26	24	128	3	1	2	6	420.00	71.95	2448.05
1358	13	24	283	3	2	3	7	420.00	283.19	2656.81
1348	85	24	143	2	1	2	5	420.00	162.54	1937.46
1330	7	24	48	4	4	4	10	420.00	109.58	4090.42
1311	62	24	157	1	3	1	10	420.00	77.11	4122.89
1281	84	24	32	4	4	3	2	420.00	52.53	787.47
1279	13	24	26	5	4	1	8	420.00	120.02	3239.98
1139	50	24	14	1	2	4	2	420.00	45.39	794.61
1124	77	24	169	4	2	4	1	420.00	153.44	266.56
1117	21	24	70	2	1	3	7	420.00	17.57	2922.43
1020	63	24	111	2	1	4	5	420.00	103.92	1996.08
997	84	24	195	4	1	2	6	420.00	68.61	2451.39
981	50	24	24	2	2	4	9	420.00	199.22	3580.78
966	24	24	96	3	2	2	3	420.00	220.18	1039.82
909	55	24	139	5	1	3	7	420.00	213.77	2726.23
881	92	24	1	1	4	4	8	420.00	0.29	3359.71
867	61	24	288	3	3	4	3	420.00	55.56	1204.44
839	33	24	305	2	3	3	9	420.00	57.94	3722.06
802	60	24	219	4	3	4	5	420.00	235.52	1864.48
718	94	24	164	5	3	2	6	420.00	134.43	2385.57
712	6	24	107	4	4	3	7	420.00	214.83	2725.17
704	28	24	115	2	3	1	9	420.00	284.10	3495.90
673	54	24	118	5	4	2	9	420.00	250.49	3529.51
612	83	24	203	3	2	2	7	420.00	230.17	2709.83
576	28	24	129	1	3	4	5	420.00	256.80	1843.20
554	7	24	337	2	4	4	3	420.00	224.50	1035.50
545	46	24	203	2	4	2	6	420.00	299.69	2220.31
497	25	24	86	1	1	4	7	420.00	215.33	2724.67
488	12	24	226	2	1	3	2	420.00	210.41	629.59
463	82	24	164	2	4	3	9	420.00	279.85	3500.15
454	84	24	157	2	2	2	6	420.00	259.09	2260.91
350	76	24	87	1	2	1	10	420.00	66.72	4133.28
341	17	24	286	1	4	1	7	420.00	199.79	2740.21
314	29	24	221	5	1	4	4	420.00	128.64	1551.36
299	43	24	325	1	2	1	2	420.00	168.96	671.04
234	48	24	165	5	3	3	1	420.00	258.05	161.95
201	45	24	253	2	1	2	4	420.00	81.21	1598.79
121	5	24	348	5	1	4	3	420.00	42.49	1217.51
20	24	24	355	3	4	3	3	420.00	266.84	993.16
1962	89	25	38	2	4	2	8	290.00	213.62	2106.38
1908	69	25	178	2	2	4	5	290.00	148.74	1301.26
1835	91	25	54	2	4	4	7	290.00	257.13	1772.87
1781	69	25	69	2	2	4	10	290.00	7.67	2892.33
1780	2	25	80	5	2	1	5	290.00	241.05	1208.95
1727	63	25	163	4	2	3	10	290.00	75.13	2824.87
1719	33	25	124	2	2	1	8	290.00	226.27	2093.73
1717	94	25	184	1	4	4	10	290.00	74.36	2825.64
1644	34	25	254	4	1	1	4	290.00	113.15	1046.85
1551	7	25	70	1	4	4	7	290.00	162.64	1867.36
1510	95	25	34	3	1	2	6	290.00	153.79	1586.21
1433	84	25	330	5	3	1	9	290.00	163.60	2446.40
1424	71	25	230	1	4	4	5	290.00	168.16	1281.84
1388	6	25	208	3	4	4	6	290.00	288.97	1451.03
1370	47	25	265	4	3	2	9	290.00	96.40	2513.60
1350	17	25	10	1	2	4	6	290.00	289.43	1450.57
1307	32	25	234	2	3	3	5	290.00	241.66	1208.34
1274	47	25	348	1	2	2	9	290.00	273.65	2336.35
1242	43	25	306	3	4	1	8	290.00	103.27	2216.73
1205	99	25	108	1	1	2	7	290.00	10.43	2019.57
1175	64	25	245	3	3	2	7	290.00	19.05	2010.95
1161	36	25	276	3	3	2	4	290.00	220.33	939.67
1144	47	25	41	3	2	1	1	290.00	15.60	274.40
1068	54	25	332	2	1	4	10	290.00	42.84	2857.16
1024	2	25	263	4	4	2	8	290.00	297.59	2022.41
724	22	25	229	3	2	2	5	290.00	88.02	1361.98
723	19	25	306	1	2	1	1	290.00	256.90	33.10
654	4	25	133	1	4	2	6	290.00	116.26	1623.74
589	26	25	51	5	4	3	8	290.00	260.32	2059.68
564	56	25	361	1	4	4	2	290.00	180.30	399.70
550	83	25	249	4	3	1	6	290.00	176.98	1563.02
503	32	25	230	3	4	1	9	290.00	110.67	2499.33
441	76	25	323	3	3	4	8	290.00	235.49	2084.51
366	30	25	324	2	1	1	7	290.00	173.05	1856.95
297	66	25	231	2	3	1	7	290.00	2.87	2027.13
258	50	25	250	1	1	2	9	290.00	196.71	2413.29
198	51	25	298	2	1	3	9	290.00	202.67	2407.33
186	58	25	127	3	2	2	4	290.00	97.20	1062.80
171	77	25	122	3	3	3	4	290.00	248.33	911.67
96	51	25	43	2	4	4	6	290.00	199.88	1540.12
55	56	25	162	2	4	2	10	290.00	262.50	2637.50
1896	16	26	40	3	3	3	1	350.00	287.27	62.73
1680	97	26	213	4	3	4	6	350.00	58.63	2041.37
1548	11	26	267	2	3	2	3	350.00	223.77	826.23
1527	17	26	47	2	3	2	5	350.00	230.93	1519.07
1518	58	26	85	5	4	4	6	350.00	77.04	2022.96
1496	14	26	296	3	1	2	10	350.00	132.77	3367.23
1438	76	26	249	2	1	3	2	350.00	227.00	473.00
1400	87	26	46	3	1	4	2	350.00	29.27	670.73
1362	64	26	283	1	1	3	5	350.00	143.34	1606.66
1332	12	26	334	1	2	1	4	350.00	58.21	1341.79
1329	70	26	98	2	1	1	9	350.00	149.58	3000.42
1297	16	26	1	1	1	2	9	350.00	62.48	3087.52
1131	79	26	180	2	4	1	7	350.00	128.42	2321.58
1096	49	26	204	3	1	1	8	350.00	158.85	2641.15
1091	4	26	129	2	1	2	4	350.00	170.91	1229.09
1085	94	26	67	5	4	2	9	350.00	202.32	2947.68
1060	85	26	110	5	4	4	7	350.00	229.30	2220.70
961	77	26	53	3	3	1	7	350.00	61.95	2388.05
942	88	26	72	5	1	2	6	350.00	283.22	1816.78
927	68	26	83	3	4	4	2	350.00	83.48	616.52
923	51	26	312	2	2	2	7	350.00	292.86	2157.14
892	39	26	85	3	2	4	4	350.00	246.53	1153.47
847	52	26	168	1	3	1	3	350.00	32.58	1017.42
797	73	26	251	2	3	1	7	350.00	75.11	2374.89
766	98	26	16	1	4	2	2	350.00	140.12	559.88
639	47	26	101	3	1	2	8	350.00	245.58	2554.42
553	43	26	107	3	4	1	8	350.00	147.57	2652.43
484	1	26	254	2	4	1	1	350.00	46.28	303.72
326	83	26	280	3	3	4	6	350.00	25.33	2074.67
179	37	26	157	2	4	3	2	350.00	170.06	529.94
163	25	26	349	4	4	1	9	350.00	110.18	3039.82
146	77	26	229	3	1	3	3	350.00	153.22	896.78
78	92	26	285	3	2	4	7	350.00	283.85	2166.15
34	6	26	222	1	3	1	5	350.00	86.31	1663.69
26	33	26	6	5	4	2	5	350.00	280.82	1469.18
4	20	26	70	5	3	3	6	350.00	29.08	2070.92
1986	32	27	307	4	1	4	10	690.00	24.34	6875.66
1974	99	27	158	1	2	2	4	690.00	37.45	2722.55
1866	38	27	228	5	4	4	2	690.00	107.87	1272.13
1829	25	27	58	2	4	1	2	690.00	75.61	1304.39
1824	49	27	111	3	4	3	9	690.00	206.90	6003.10
1800	39	27	123	2	1	4	5	690.00	38.65	3411.35
1667	80	27	80	5	3	4	5	690.00	271.12	3178.88
1537	11	27	327	1	1	1	1	690.00	140.71	549.29
1525	7	27	89	4	2	2	7	690.00	17.06	4812.94
1491	41	27	251	5	3	4	9	690.00	30.19	6179.81
1368	35	27	294	1	3	1	7	690.00	270.89	4559.11
1286	88	27	209	4	1	4	6	690.00	6.21	4133.79
1248	9	27	162	2	1	4	10	690.00	97.01	6802.99
1238	6	27	210	2	1	3	4	690.00	196.29	2563.71
1099	33	27	76	5	3	3	5	690.00	247.70	3202.30
1048	63	27	78	5	4	4	10	690.00	199.83	6700.17
1002	87	27	103	3	3	4	7	690.00	165.49	4664.51
900	57	27	223	3	1	3	3	690.00	55.52	2014.48
843	85	27	24	2	1	3	6	690.00	208.89	3931.11
640	54	27	149	1	1	1	2	690.00	72.64	1307.36
532	40	27	54	2	2	1	4	690.00	49.03	2710.97
383	34	27	19	5	3	4	7	690.00	144.29	4685.71
330	29	27	339	2	1	4	8	690.00	133.93	5386.07
325	49	27	273	1	1	1	8	690.00	265.80	5254.20
248	43	27	4	3	4	2	8	690.00	0.06	5519.94
242	50	27	344	2	4	3	9	690.00	193.31	6016.69
194	97	27	54	3	1	1	5	690.00	13.52	3436.48
152	74	27	309	5	2	1	7	690.00	145.53	4684.47
114	82	27	324	2	3	4	6	690.00	144.32	3995.68
69	38	27	335	5	4	1	3	690.00	198.97	1871.03
1935	7	28	211	3	4	1	9	390.00	125.95	3384.05
1889	41	28	59	4	1	3	4	390.00	222.68	1337.32
1875	78	28	221	4	4	2	8	390.00	80.68	3039.32
1867	96	28	306	2	2	4	6	390.00	29.79	2310.21
1849	40	28	241	4	3	3	3	390.00	168.98	1001.02
1802	37	28	80	1	4	2	10	390.00	106.29	3793.71
1776	69	28	298	2	4	3	1	390.00	71.68	318.32
1765	10	28	176	5	2	1	3	390.00	174.34	995.66
1722	100	28	270	1	1	3	6	390.00	80.07	2259.93
1708	25	28	345	3	4	3	8	390.00	269.97	2850.03
1701	33	28	211	1	4	3	1	390.00	67.46	322.54
1681	4	28	347	2	1	3	6	390.00	291.75	2048.25
1586	41	28	184	4	3	4	5	390.00	93.59	1856.41
1572	18	28	122	4	4	4	5	390.00	46.16	1903.84
1494	81	28	284	4	3	4	10	390.00	184.95	3715.05
1415	12	28	326	1	1	4	9	390.00	182.66	3327.34
1396	69	28	70	1	3	2	8	390.00	84.69	3035.31
1367	26	28	84	1	2	2	9	390.00	131.07	3378.93
1298	68	28	60	3	3	2	9	390.00	92.11	3417.89
1224	78	28	6	3	2	2	7	390.00	106.14	2623.86
1217	20	28	27	2	1	3	4	390.00	13.92	1546.08
1207	87	28	122	1	1	1	9	390.00	151.50	3358.50
957	44	28	316	2	4	1	6	390.00	196.71	2143.29
749	4	28	114	4	4	1	7	390.00	14.54	2715.46
625	65	28	148	4	2	2	10	390.00	211.03	3688.97
579	95	28	44	1	1	2	10	390.00	270.94	3629.06
487	44	28	183	5	2	1	3	390.00	110.13	1059.87
474	82	28	122	4	2	3	10	390.00	125.16	3774.84
434	57	28	133	4	2	3	5	390.00	31.85	1918.15
429	35	28	278	1	3	2	5	390.00	287.66	1662.34
426	85	28	78	4	1	4	4	390.00	29.78	1530.22
304	1	28	144	4	1	4	5	390.00	207.55	1742.45
223	31	28	243	3	2	1	1	390.00	122.38	267.62
219	1	28	25	2	3	1	9	390.00	141.86	3368.14
215	31	28	256	2	2	2	4	390.00	238.83	1321.17
188	10	28	355	5	4	3	2	390.00	256.23	523.77
115	71	28	235	4	3	3	4	390.00	220.63	1339.37
98	88	28	86	3	2	3	3	390.00	42.90	1127.10
21	8	28	185	3	2	1	1	390.00	85.42	304.58
19	8	28	281	5	3	1	4	390.00	62.92	1497.08
1886	65	29	292	1	1	3	1	850.00	8.02	841.98
1883	87	29	286	4	2	4	8	850.00	84.95	6715.05
1862	42	29	2	4	3	3	8	850.00	5.98	6794.02
1778	79	29	239	1	2	2	10	850.00	181.65	8318.35
1764	9	29	186	5	3	4	8	850.00	226.85	6573.15
1756	10	29	46	2	3	3	5	850.00	80.28	4169.72
1686	61	29	138	4	1	4	6	850.00	138.44	4961.56
1666	32	29	131	1	4	1	7	850.00	296.22	5653.78
1587	17	29	251	1	3	4	6	850.00	197.68	4902.32
1545	3	29	72	3	4	2	6	850.00	291.91	4808.09
1381	58	29	272	2	1	4	5	850.00	258.76	3991.24
1331	40	29	337	4	2	1	6	850.00	158.84	4941.16
1302	99	29	218	2	3	3	8	850.00	235.01	6564.99
1252	36	29	118	5	2	1	1	850.00	196.09	653.91
1159	95	29	154	2	3	1	4	850.00	56.31	3343.69
1150	30	29	342	4	3	2	10	850.00	55.06	8444.94
1143	78	29	62	4	1	1	2	850.00	268.84	1431.16
1027	45	29	80	1	3	4	4	850.00	275.24	3124.76
1011	85	29	91	4	4	3	10	850.00	94.74	8405.26
950	82	29	202	4	1	2	7	850.00	106.37	5843.63
898	38	29	76	3	2	4	2	850.00	265.38	1434.62
846	69	29	215	1	3	4	7	850.00	101.64	5848.36
826	8	29	197	1	3	2	9	850.00	80.31	7569.69
771	46	29	210	3	3	2	4	850.00	298.69	3101.31
670	68	29	349	4	2	3	5	850.00	52.02	4197.98
591	90	29	248	5	1	4	10	850.00	238.08	8261.92
512	76	29	65	2	2	3	6	850.00	123.10	4976.90
471	44	29	220	1	1	2	4	850.00	128.53	3271.47
427	31	29	199	1	1	3	6	850.00	98.30	5001.70
418	38	29	95	2	1	2	1	850.00	218.58	631.42
349	15	29	17	3	4	2	6	850.00	161.25	4938.75
284	28	29	344	4	1	3	9	850.00	281.53	7368.47
265	12	29	111	1	4	1	6	850.00	286.44	4813.56
213	80	29	283	5	2	1	3	850.00	224.83	2325.17
165	64	29	204	4	4	4	8	850.00	270.54	6529.46
144	34	29	217	4	1	1	4	850.00	61.96	3338.04
1874	56	30	320	4	1	1	2	1390.00	2.03	2777.97
1847	69	30	134	5	3	1	1	1390.00	230.38	1159.62
1796	90	30	206	4	4	4	1	1390.00	68.65	1321.35
1642	68	30	141	5	4	2	1	1390.00	268.40	1121.60
1605	24	30	236	2	1	4	2	1390.00	227.87	2552.13
1590	15	30	120	2	3	4	3	1390.00	35.54	4134.46
1565	5	30	284	4	1	1	9	1390.00	136.58	12373.42
1559	17	30	59	1	4	2	6	1390.00	19.77	8320.23
1431	92	30	341	3	1	4	3	1390.00	258.78	3911.22
1379	72	30	124	1	2	1	4	1390.00	27.14	5532.86
1366	9	30	230	5	1	4	1	1390.00	171.13	1218.87
1261	26	30	196	3	1	1	1	1390.00	140.56	1249.44
1193	30	30	323	3	4	4	3	1390.00	5.65	4164.35
1191	42	30	170	3	1	4	10	1390.00	214.43	13685.57
1138	2	30	229	3	1	3	4	1390.00	252.58	5307.42
1130	73	30	75	1	3	1	2	1390.00	34.61	2745.39
1061	2	30	16	4	3	3	5	1390.00	288.24	6661.76
1015	93	30	7	3	1	1	10	1390.00	6.93	13893.07
955	93	30	271	4	3	2	9	1390.00	37.08	12472.92
954	14	30	362	4	4	2	1	1390.00	40.28	1349.72
901	18	30	217	4	1	1	4	1390.00	26.69	5533.31
844	30	30	171	5	4	3	7	1390.00	1.70	9728.30
842	98	30	25	3	1	3	8	1390.00	118.37	11001.63
841	80	30	175	2	3	1	4	1390.00	27.12	5532.88
800	18	30	185	3	1	2	9	1390.00	260.35	12249.65
594	74	30	341	3	1	3	7	1390.00	233.69	9496.31
542	15	30	250	5	2	1	5	1390.00	283.54	6666.46
485	4	30	106	4	3	3	9	1390.00	278.82	12231.18
455	23	30	238	2	3	4	2	1390.00	16.71	2763.29
448	5	30	42	5	1	3	2	1390.00	30.72	2749.28
430	27	30	34	1	2	4	8	1390.00	173.74	10946.26
417	6	30	57	2	2	2	1	1390.00	283.10	1106.90
404	34	30	5	1	4	4	8	1390.00	293.65	10826.35
394	18	30	165	1	3	1	8	1390.00	182.13	10937.87
270	79	30	346	3	3	1	4	1390.00	177.25	5382.75
237	17	30	80	3	1	4	9	1390.00	170.49	12339.51
137	29	30	1	1	4	2	5	1390.00	7.76	6942.24
134	47	30	35	2	3	1	10	1390.00	249.74	13650.26
132	78	30	54	2	4	3	10	1390.00	247.14	13652.86
102	36	30	230	3	2	3	2	1390.00	99.88	2680.12
64	1	30	311	4	1	3	5	1390.00	287.20	6662.80
42	36	30	227	2	2	3	2	1390.00	101.42	2678.58
1345	19	31	47	2	3	2	5	10.00	22.94	27.06
1273	100	31	142	5	2	3	9	10.00	76.03	13.97
780	28	31	300	3	4	3	7	10.00	26.99	43.01
662	45	31	187	5	4	3	10	10.00	45.74	54.26
431	33	31	222	1	3	4	8	10.00	21.79	58.21
1992	19	32	17	4	4	3	3	100.00	282.43	17.57
1976	1	32	254	3	4	1	5	100.00	124.64	375.36
1973	81	32	274	1	4	3	9	100.00	255.83	644.17
1893	39	32	108	2	4	1	4	100.00	178.41	221.59
1760	84	32	31	2	2	1	10	100.00	207.26	792.74
1599	13	32	118	1	3	2	7	100.00	197.10	502.90
1598	66	32	91	2	1	3	7	100.00	35.63	664.37
1520	1	32	87	5	3	4	6	100.00	22.68	577.32
1380	13	32	242	5	4	3	2	100.00	153.74	46.26
1319	96	32	42	2	1	2	5	100.00	271.81	228.19
1201	13	32	103	1	2	3	9	100.00	4.81	895.19
1179	6	32	127	5	2	2	8	100.00	36.56	763.44
1177	48	32	2	5	4	2	1	100.00	31.17	68.83
1098	64	32	293	3	4	3	4	100.00	128.23	271.77
1034	34	32	46	2	4	1	5	100.00	237.01	262.99
947	70	32	95	5	3	1	3	100.00	218.55	81.45
931	99	32	136	2	4	1	4	100.00	296.99	103.01
860	49	32	340	2	2	4	10	100.00	236.71	763.29
631	51	32	213	4	2	2	10	100.00	127.34	872.66
590	99	32	133	1	1	3	8	100.00	291.95	508.05
442	26	32	135	5	2	1	10	100.00	13.99	986.01
435	46	32	282	2	2	3	7	100.00	279.46	420.54
393	42	32	70	5	4	3	2	100.00	57.19	142.81
360	25	32	162	3	4	4	10	100.00	83.49	916.51
336	28	32	152	3	1	1	8	100.00	149.25	650.75
269	47	32	233	5	3	4	8	100.00	236.50	563.50
91	12	32	332	5	1	3	8	100.00	144.87	655.13
1820	18	33	67	3	1	2	7	20.00	46.49	93.51
1769	4	33	249	3	3	3	8	20.00	9.02	150.98
1688	14	33	40	5	3	3	10	20.00	193.13	6.87
1677	97	33	245	4	4	2	6	20.00	106.12	13.88
1650	45	33	329	5	2	1	9	20.00	132.56	47.44
1039	74	33	52	5	2	3	7	20.00	83.78	56.22
951	2	33	63	2	4	4	9	20.00	163.50	16.50
690	100	33	25	5	3	2	10	20.00	16.41	183.59
513	67	33	338	1	1	4	9	20.00	105.64	74.36
230	3	33	182	4	4	2	10	20.00	125.53	74.47
190	2	33	125	2	4	3	7	20.00	14.61	125.39
167	59	33	158	4	1	4	8	20.00	17.39	142.61
61	34	33	251	2	1	1	8	20.00	147.01	12.99
1830	24	34	105	1	3	3	7	1699.99	294.35	11605.58
1795	33	34	318	4	2	1	2	1699.99	90.80	3309.18
1783	95	34	67	3	3	1	7	1699.99	276.10	11623.83
1741	66	34	256	3	3	1	7	1699.99	99.49	11800.44
1656	26	34	251	1	2	2	6	1699.99	126.38	10073.56
1619	18	34	310	1	4	1	4	1699.99	274.05	6525.91
1618	36	34	190	4	2	4	8	1699.99	295.81	13304.11
1554	77	34	256	1	2	2	9	1699.99	103.55	15196.36
1523	51	34	94	3	3	3	2	1699.99	71.73	3328.25
1392	54	34	146	2	3	3	5	1699.99	40.02	8459.93
1387	19	34	192	1	1	3	3	1699.99	101.31	4998.66
1322	63	34	110	2	1	2	9	1699.99	9.86	15290.05
1310	62	34	137	3	2	1	2	1699.99	59.07	3340.91
1120	63	34	130	3	3	2	7	1699.99	292.81	11607.12
1119	32	34	56	2	4	4	4	1699.99	156.15	6643.81
1111	29	34	364	3	3	3	3	1699.99	83.44	5016.53
1103	64	34	123	4	2	3	3	1699.99	192.94	4907.03
1049	8	34	282	3	2	4	9	1699.99	164.82	15135.09
936	76	34	252	3	1	2	7	1699.99	279.60	11620.33
824	91	34	130	4	2	2	8	1699.99	278.80	13321.12
708	41	34	252	4	2	2	4	1699.99	106.11	6693.85
701	43	34	244	3	1	4	3	1699.99	197.71	4902.26
653	6	34	94	1	1	3	2	1699.99	176.44	3223.54
596	91	34	65	2	2	2	7	1699.99	73.93	11826.00
476	54	34	311	1	4	4	8	1699.99	140.00	13459.92
419	92	34	247	5	4	3	8	1699.99	161.32	13438.60
406	75	34	106	5	1	1	7	1699.99	117.64	11782.29
399	79	34	148	5	1	3	9	1699.99	184.54	15115.37
388	30	34	50	3	4	1	9	1699.99	230.37	15069.54
281	8	34	135	2	4	4	8	1699.99	79.80	13520.12
187	77	34	148	2	1	4	8	1699.99	150.49	13449.43
155	31	34	86	5	3	1	5	1699.99	123.06	8376.89
147	12	34	352	3	2	4	3	1699.99	250.29	4849.68
48	62	34	95	4	3	2	10	1699.99	279.27	16720.63
1913	9	35	75	1	4	3	10	72.00	112.78	607.22
1888	70	35	97	4	3	3	1	72.00	49.49	22.51
1859	70	35	232	5	2	1	7	72.00	244.16	259.84
1803	67	35	254	2	1	2	4	72.00	230.57	57.43
1679	88	35	164	1	2	4	5	72.00	261.56	98.44
1668	60	35	308	5	2	4	10	72.00	157.37	562.63
1627	96	35	352	1	4	2	5	72.00	177.10	182.90
1521	61	35	267	4	1	2	4	72.00	43.42	244.58
1417	22	35	284	2	2	1	3	72.00	179.34	36.66
1294	48	35	306	5	1	1	9	72.00	63.62	584.38
1278	58	35	295	4	2	3	3	72.00	70.37	145.63
1197	72	35	47	2	1	3	7	72.00	266.48	237.52
1136	93	35	190	2	4	1	4	72.00	149.31	138.69
971	13	35	15	3	4	3	5	72.00	275.08	84.92
903	63	35	229	4	1	3	6	72.00	158.79	273.21
899	21	35	304	5	1	1	10	72.00	165.80	554.20
886	15	35	50	5	3	3	2	72.00	68.78	75.22
796	57	35	363	4	2	2	3	72.00	205.58	10.42
769	85	35	289	2	2	3	8	72.00	13.85	562.15
700	61	35	106	1	3	1	2	72.00	113.19	30.81
607	85	35	280	2	2	1	3	72.00	110.70	105.30
475	60	35	13	4	1	3	7	72.00	154.41	349.59
464	70	35	278	3	3	3	3	72.00	61.19	154.81
459	92	35	253	4	1	1	6	72.00	112.65	319.35
359	32	35	122	5	1	4	4	72.00	121.48	166.52
309	49	35	50	4	2	1	2	72.00	105.48	38.52
256	79	35	333	4	3	4	8	72.00	178.91	397.09
222	30	35	124	2	3	4	10	72.00	296.60	423.40
166	42	35	115	3	2	4	7	72.00	119.88	384.12
150	73	35	186	4	1	2	7	72.00	101.27	402.73
60	72	35	49	3	4	1	10	72.00	2.87	717.13
1941	87	36	19	4	2	3	10	34.00	180.09	159.91
1906	80	36	177	1	4	3	8	34.00	27.99	244.01
1899	88	36	77	2	3	4	7	34.00	40.08	197.92
1869	84	36	165	3	2	4	7	34.00	3.93	234.07
1515	49	36	221	4	3	2	10	34.00	249.79	90.21
1436	32	36	176	3	3	1	10	34.00	287.68	52.32
1407	67	36	312	3	2	1	2	34.00	41.47	26.53
1397	83	36	216	5	3	4	10	34.00	34.83	305.17
1259	40	36	17	4	2	2	9	34.00	123.15	182.85
1219	8	36	355	3	1	3	2	34.00	26.14	41.86
1122	79	36	44	2	3	4	9	34.00	219.86	86.14
1078	45	36	91	5	1	2	6	34.00	58.73	145.27
1047	5	36	102	1	2	3	9	34.00	86.60	219.40
1017	24	36	329	1	1	4	5	34.00	138.57	31.43
750	86	36	98	5	2	2	9	34.00	240.43	65.57
705	100	36	96	2	1	4	8	34.00	151.97	120.03
698	93	36	202	5	1	2	9	34.00	132.95	173.05
655	42	36	48	5	4	3	10	34.00	295.63	44.37
628	50	36	221	3	1	3	6	34.00	79.12	124.88
609	68	36	33	5	1	2	10	34.00	280.60	59.40
593	19	36	350	5	4	4	9	34.00	151.53	154.47
567	15	36	134	4	2	3	7	34.00	25.34	212.66
414	52	36	110	2	1	4	3	34.00	1.24	100.76
290	13	36	143	5	1	2	9	34.00	35.74	270.26
1979	88	37	154	4	3	4	3	62.00	11.89	174.11
1954	40	37	227	4	2	2	10	62.00	55.44	564.56
1861	44	37	259	2	4	2	10	62.00	41.67	578.33
1857	51	37	21	2	3	1	3	62.00	45.89	140.11
1714	59	37	104	1	2	2	7	62.00	203.35	230.65
1620	43	37	295	3	2	4	7	62.00	157.47	276.53
1576	57	37	5	3	4	4	7	62.00	222.13	211.87
1541	64	37	131	2	1	1	8	62.00	280.36	215.64
1513	94	37	291	4	4	4	6	62.00	263.93	108.07
1502	21	37	335	1	2	1	6	62.00	66.95	305.05
1483	91	37	170	5	2	4	9	62.00	237.29	320.71
1480	63	37	197	3	2	1	3	62.00	32.21	153.79
1460	9	37	177	5	3	3	5	62.00	73.51	236.49
1435	79	37	54	5	1	3	9	62.00	19.88	538.12
1386	91	37	104	2	4	4	7	62.00	16.07	417.93
1360	62	37	328	3	3	4	9	62.00	29.82	528.18
1241	39	37	18	3	3	4	5	62.00	173.51	136.49
943	5	37	338	4	1	3	4	62.00	8.92	239.08
890	79	37	211	1	2	2	4	62.00	234.49	13.51
836	15	37	268	5	4	2	7	62.00	265.87	168.13
807	57	37	196	1	3	1	3	62.00	14.34	171.66
764	60	37	82	5	1	1	1	62.00	15.00	47.00
726	98	37	286	2	1	3	7	62.00	187.26	246.74
715	50	37	85	3	3	1	7	62.00	160.52	273.48
699	43	37	149	4	3	3	5	62.00	145.74	164.26
692	85	37	273	5	3	1	3	62.00	91.82	94.18
681	7	37	88	4	1	3	10	62.00	296.63	323.37
647	64	37	246	3	2	3	4	62.00	92.82	155.18
566	63	37	247	4	1	2	10	62.00	104.62	515.38
408	71	37	135	5	4	3	3	62.00	171.46	14.54
384	4	37	109	3	3	4	2	62.00	25.01	98.99
380	92	37	333	3	4	3	5	62.00	126.63	183.37
332	15	37	125	4	4	4	5	62.00	205.76	104.24
311	66	37	53	4	1	1	4	62.00	176.28	71.72
300	25	37	9	4	3	3	10	62.00	198.53	421.47
268	4	37	226	1	3	4	7	62.00	127.18	306.82
251	48	37	99	3	2	3	7	62.00	69.46	364.54
233	11	37	84	5	4	4	8	62.00	164.86	331.14
63	26	37	296	3	2	4	3	62.00	3.98	182.02
36	36	37	117	5	2	2	5	62.00	163.34	146.66
33	99	37	185	2	1	4	4	62.00	161.98	86.02
1930	21	38	188	1	1	3	10	420.00	200.88	3999.12
1925	2	38	272	1	2	1	8	420.00	146.29	3213.71
1905	57	38	201	3	2	4	8	420.00	137.67	3222.33
1892	74	38	201	4	4	4	6	420.00	85.64	2434.36
1877	90	38	72	3	3	4	8	420.00	228.42	3131.58
1826	88	38	186	4	2	2	1	420.00	259.72	160.28
1788	34	38	181	4	1	2	6	420.00	240.37	2279.63
1726	3	38	251	4	4	2	2	420.00	147.72	692.28
1604	69	38	52	2	3	2	3	420.00	230.68	1029.32
1538	43	38	122	5	2	4	9	420.00	73.54	3706.46
1509	1	38	46	1	4	2	9	420.00	110.48	3669.52
1468	49	38	178	1	4	4	7	420.00	143.17	2796.83
1450	31	38	236	4	3	4	2	420.00	243.32	596.68
1346	16	38	183	4	1	1	4	420.00	116.34	1563.66
1315	82	38	148	1	1	4	3	420.00	46.80	1213.20
1251	71	38	67	3	4	4	6	420.00	277.60	2242.40
1214	59	38	299	4	2	4	10	420.00	186.25	4013.75
1110	33	38	29	3	2	3	4	420.00	151.56	1528.44
1019	56	38	166	1	2	1	10	420.00	89.64	4110.36
979	21	38	171	5	3	3	2	420.00	218.10	621.90
930	96	38	217	4	2	2	10	420.00	16.54	4183.46
929	77	38	344	4	4	1	8	420.00	110.36	3249.64
868	15	38	316	2	4	4	1	420.00	136.00	284.00
686	72	38	180	5	1	1	1	420.00	11.01	408.99
679	45	38	329	3	4	2	7	420.00	110.31	2829.69
661	48	38	22	3	3	3	6	420.00	251.55	2268.45
650	11	38	91	5	1	3	6	420.00	247.40	2272.60
600	20	38	186	4	2	4	5	420.00	126.50	1973.50
575	51	38	341	5	2	3	1	420.00	165.24	254.76
543	47	38	27	5	1	1	8	420.00	269.51	3090.49
500	38	38	308	1	1	2	4	420.00	119.52	1560.48
483	55	38	265	3	1	4	2	420.00	97.27	742.73
447	6	38	35	4	1	2	6	420.00	289.01	2230.99
346	8	38	193	2	2	3	7	420.00	293.46	2646.54
323	35	38	296	3	1	4	3	420.00	65.53	1194.47
204	89	38	228	5	1	3	5	420.00	21.55	2078.45
113	19	38	319	1	4	1	4	420.00	124.17	1555.83
74	95	38	25	1	4	4	6	420.00	271.88	2248.12
1	69	38	44	4	4	3	10	420.00	269.91	3930.09
1995	46	39	139	5	4	3	1	899.99	117.78	782.21
1852	13	39	76	4	1	4	6	899.99	155.78	5244.16
1832	12	39	228	3	2	1	6	899.99	234.67	5165.27
1704	43	39	208	4	4	4	2	899.99	103.88	1696.10
1630	76	39	128	4	3	3	1	899.99	142.59	757.40
1593	7	39	269	1	3	2	6	899.99	184.71	5215.23
1566	93	39	194	1	3	3	6	899.99	145.37	5254.57
1540	56	39	305	5	1	1	8	899.99	51.20	7148.72
1484	66	39	252	4	3	3	10	899.99	287.70	8712.20
1404	63	39	57	5	1	3	10	899.99	200.09	8799.81
1340	14	39	325	5	4	2	7	899.99	74.79	6225.14
1262	4	39	320	2	1	2	9	899.99	57.37	8042.54
1246	67	39	18	3	1	1	1	899.99	295.18	604.81
1223	96	39	177	5	3	3	8	899.99	36.79	7163.13
1208	95	39	307	5	2	3	6	899.99	90.90	5309.04
1114	90	39	29	5	4	1	3	899.99	93.07	2606.90
1046	34	39	160	5	1	4	9	899.99	216.64	7883.27
990	29	39	310	5	3	2	10	899.99	281.40	8718.50
934	21	39	65	5	2	2	10	899.99	34.11	8965.79
895	13	39	146	1	3	1	1	899.99	119.70	780.29
875	66	39	152	3	4	1	3	899.99	146.85	2553.12
808	82	39	102	1	2	4	4	899.99	149.10	3450.86
770	89	39	143	3	1	3	7	899.99	142.95	6156.98
714	84	39	190	2	1	3	9	899.99	86.83	8013.08
693	16	39	229	3	3	4	1	899.99	254.88	645.11
608	3	39	138	5	1	1	8	899.99	228.66	6971.26
537	83	39	332	1	2	1	6	899.99	235.37	5164.57
510	11	39	235	1	1	4	2	899.99	258.00	1541.98
508	60	39	344	1	4	3	9	899.99	124.83	7975.08
461	13	39	261	3	3	1	2	899.99	110.72	1689.26
458	40	39	361	2	3	2	1	899.99	29.11	870.88
374	21	39	68	5	3	2	8	899.99	6.07	7193.85
372	57	39	283	1	3	3	2	899.99	138.05	1661.93
322	18	39	104	4	4	4	3	899.99	111.84	2588.13
305	52	39	57	2	1	1	7	899.99	96.65	6203.28
303	89	39	45	5	3	2	4	899.99	275.12	3324.84
273	36	39	37	2	3	2	5	899.99	224.60	4275.35
71	18	39	143	2	3	4	1	899.99	138.04	761.95
24	47	39	320	3	1	1	2	899.99	17.10	1782.88
1942	17	40	182	2	2	2	1	299.99	32.03	267.96
1828	76	40	197	2	3	1	9	299.99	263.96	2435.95
1758	10	40	274	3	1	2	1	299.99	265.08	34.91
1705	67	40	362	2	1	3	8	299.99	10.22	2389.70
1687	71	40	335	5	2	3	2	299.99	129.71	470.27
1621	79	40	37	5	2	1	3	299.99	34.13	865.84
1614	79	40	55	1	1	4	6	299.99	218.40	1581.54
1594	86	40	19	4	3	1	8	299.99	88.81	2311.11
1591	81	40	114	3	1	1	5	299.99	203.11	1296.84
1577	46	40	361	1	4	3	9	299.99	171.51	2528.40
1557	96	40	310	4	3	4	2	299.99	255.81	344.17
1534	63	40	250	4	3	4	8	299.99	252.58	2147.34
1508	66	40	242	2	4	2	8	299.99	102.96	2296.96
1414	57	40	139	1	2	3	9	299.99	92.43	2607.48
1328	11	40	153	4	2	1	9	299.99	35.68	2664.23
1321	84	40	86	5	4	2	10	299.99	79.17	2920.73
1293	99	40	236	2	2	2	5	299.99	138.20	1361.75
1250	58	40	16	5	1	1	4	299.99	107.32	1092.64
1145	17	40	124	4	3	4	9	299.99	202.05	2497.86
1021	39	40	338	5	3	2	10	299.99	213.42	2786.48
1009	69	40	160	3	1	2	3	299.99	132.36	767.61
982	80	40	277	4	2	2	4	299.99	164.70	1035.26
976	10	40	357	4	3	3	10	299.99	157.17	2842.73
859	7	40	68	2	1	3	3	299.99	262.11	637.86
768	99	40	257	3	3	3	6	299.99	221.64	1578.30
745	39	40	54	3	3	4	2	299.99	43.72	556.26
657	36	40	217	3	2	2	1	299.99	123.90	176.09
644	31	40	299	4	2	3	8	299.99	87.07	2312.85
568	42	40	126	4	2	4	4	299.99	183.10	1016.86
556	7	40	343	4	1	1	8	299.99	131.64	2268.28
539	41	40	306	5	3	1	2	299.99	262.39	337.59
529	65	40	146	2	3	1	6	299.99	41.97	1757.97
490	61	40	246	1	3	3	10	299.99	217.96	2781.94
401	71	40	12	1	4	3	8	299.99	258.56	2141.36
343	90	40	244	4	4	1	8	299.99	241.27	2158.65
320	77	40	307	5	1	2	6	299.99	116.45	1683.49
264	78	40	183	3	3	1	9	299.99	39.00	2660.91
252	74	40	360	3	1	2	2	299.99	248.18	351.80
170	23	40	82	4	4	4	5	299.99	45.57	1454.38
100	68	40	253	2	4	1	5	299.99	59.00	1440.95
1926	54	41	345	5	4	3	5	60.00	208.93	91.07
1876	49	41	200	3	4	1	7	60.00	61.92	358.08
1767	22	41	320	5	4	4	5	60.00	224.01	75.99
1725	6	41	41	4	1	4	6	60.00	10.47	349.53
1693	2	41	331	5	3	3	8	60.00	283.93	196.07
1689	8	41	177	4	1	3	10	60.00	129.87	470.13
1560	99	41	39	5	4	4	10	60.00	267.85	332.15
1532	46	41	346	2	3	4	2	60.00	52.76	67.24
1512	96	41	79	3	3	1	6	60.00	120.98	239.02
1489	87	41	74	5	3	4	10	60.00	290.90	309.10
1475	36	41	190	3	4	2	4	60.00	76.61	163.39
1327	33	41	9	1	4	2	10	60.00	283.60	316.40
1292	39	41	211	2	2	1	1	60.00	15.13	44.87
1272	75	41	166	1	3	1	1	60.00	52.10	7.90
1195	69	41	81	5	4	2	9	60.00	6.07	533.93
1088	79	41	31	2	4	1	7	60.00	157.89	262.11
904	18	41	356	2	2	1	3	60.00	164.29	15.71
854	55	41	259	5	1	4	9	60.00	0.82	539.18
821	40	41	115	3	2	2	3	60.00	62.43	117.57
599	57	41	43	1	2	2	6	60.00	123.98	236.02
433	80	41	127	3	4	4	5	60.00	50.34	249.66
422	2	41	54	5	2	4	5	60.00	187.89	112.11
379	90	41	345	5	2	2	10	60.00	132.32	467.68
362	22	41	10	4	2	3	10	60.00	63.12	536.88
282	100	41	199	5	3	2	7	60.00	169.27	250.73
177	67	41	348	1	2	1	8	60.00	204.82	275.18
118	34	41	353	1	4	4	10	60.00	149.39	450.61
27	84	41	263	4	2	4	5	60.00	138.65	161.35
12	40	41	281	4	1	1	5	60.00	181.95	118.05
1984	38	42	124	4	2	1	2	510.00	241.62	778.38
1938	8	42	148	3	1	4	3	510.00	154.79	1375.21
1936	44	42	359	1	2	1	9	510.00	22.82	4567.18
1917	72	42	352	1	3	4	7	510.00	166.02	3403.98
1825	74	42	325	4	2	2	4	510.00	47.08	1992.92
1799	37	42	324	3	4	1	3	510.00	129.77	1400.23
1798	87	42	323	5	1	3	6	510.00	244.27	2815.73
1777	88	42	87	4	1	3	2	510.00	205.08	814.92
1661	47	42	115	5	2	1	4	510.00	33.73	2006.27
1655	5	42	194	4	4	4	10	510.00	122.89	4977.11
1641	52	42	175	2	1	3	8	510.00	252.19	3827.81
1615	99	42	227	2	2	3	10	510.00	99.45	5000.55
1569	3	42	290	1	1	1	5	510.00	26.83	2523.17
1544	30	42	195	3	3	3	3	510.00	93.72	1436.28
1501	35	42	76	4	4	4	1	510.00	108.17	401.83
1499	73	42	97	2	2	1	1	510.00	161.40	348.60
1477	72	42	211	3	3	1	9	510.00	75.01	4514.99
1200	75	42	276	3	2	2	3	510.00	110.54	1419.46
1158	13	42	2	3	2	3	1	510.00	21.67	488.33
1116	23	42	148	5	3	2	2	510.00	283.92	736.08
1045	59	42	19	2	4	4	8	510.00	99.49	3980.51
985	20	42	327	2	1	1	1	510.00	64.15	445.85
837	48	42	305	5	3	2	6	510.00	83.96	2976.04
816	82	42	116	4	2	1	9	510.00	123.38	4466.62
804	26	42	13	5	1	3	8	510.00	208.75	3871.25
790	16	42	267	2	1	1	3	510.00	56.37	1473.63
782	56	42	327	2	2	1	3	510.00	242.60	1287.40
687	46	42	139	4	4	3	10	510.00	265.04	4834.96
635	68	42	89	2	2	1	5	510.00	168.08	2381.92
616	2	42	122	1	3	3	4	510.00	94.36	1945.64
515	26	42	334	3	3	3	8	510.00	189.38	3890.62
492	66	42	316	3	3	2	6	510.00	96.85	2963.15
480	26	42	15	2	4	3	8	510.00	132.79	3947.21
354	58	42	156	2	3	1	6	510.00	182.95	2877.05
338	12	42	224	4	3	3	2	510.00	118.07	901.93
316	16	42	306	4	2	2	5	510.00	113.04	2436.96
250	89	42	281	5	2	1	4	510.00	114.50	1925.50
157	24	42	232	5	4	3	1	510.00	64.60	445.40
156	62	42	22	2	3	4	7	510.00	157.58	3412.42
111	66	42	19	4	4	4	8	510.00	58.23	4021.77
107	95	42	157	1	3	2	6	510.00	138.54	2921.46
59	83	42	83	3	4	2	4	510.00	284.91	1755.09
41	85	42	293	5	2	4	1	510.00	64.92	445.08
1967	100	43	282	2	4	3	7	990.00	38.92	6891.08
1927	80	43	265	1	3	4	8	990.00	210.40	7709.60
1919	7	43	315	5	1	4	5	990.00	159.66	4790.34
1812	100	43	282	2	1	3	5	990.00	215.76	4734.24
1755	15	43	184	5	3	3	10	990.00	218.87	9681.13
1753	81	43	363	5	2	1	6	990.00	284.99	5655.01
1673	100	43	71	1	4	3	10	990.00	9.45	9890.55
1652	5	43	114	2	4	2	2	990.00	180.37	1799.63
1646	94	43	53	3	1	3	4	990.00	267.28	3692.72
1625	35	43	236	4	2	2	1	990.00	111.22	878.78
1519	4	43	184	2	3	1	5	990.00	80.68	4869.32
1497	76	43	185	5	1	2	4	990.00	5.62	3954.38
1459	62	43	144	3	2	1	4	990.00	96.34	3863.66
1148	50	43	98	4	3	1	4	990.00	255.36	3704.64
1135	49	43	225	2	4	1	5	990.00	189.47	4760.53
1044	68	43	78	4	4	4	8	990.00	59.99	7860.01
1022	35	43	57	3	4	1	5	990.00	262.20	4687.80
911	74	43	255	1	3	2	8	990.00	112.01	7807.99
907	44	43	360	4	2	3	10	990.00	70.43	9829.57
852	18	43	12	5	3	3	4	990.00	194.94	3765.06
803	38	43	65	1	2	1	7	990.00	242.76	6687.24
682	59	43	14	4	2	3	2	990.00	147.40	1832.60
632	98	43	43	2	2	4	9	990.00	92.84	8817.16
617	51	43	218	5	2	4	8	990.00	27.07	7892.93
552	86	43	172	5	2	1	8	990.00	256.57	7663.43
437	12	43	6	1	1	2	3	990.00	191.48	2778.52
397	63	43	169	2	3	4	5	990.00	184.75	4765.25
334	52	43	249	4	1	1	1	990.00	65.73	924.27
209	66	43	158	1	4	1	2	990.00	185.59	1794.41
168	85	43	23	4	2	3	5	990.00	177.89	4772.11
95	21	43	277	5	2	2	9	990.00	283.36	8626.64
23	30	43	152	4	3	2	1	990.00	17.51	972.49
15	99	43	136	4	4	1	5	990.00	187.91	4762.09
1983	21	44	159	2	4	1	7	249.99	262.32	1487.61
1961	19	44	151	4	1	3	7	249.99	195.58	1554.35
1675	78	44	172	3	3	4	8	249.99	127.98	1871.94
1647	17	44	296	1	4	4	4	249.99	144.61	855.35
1624	39	44	238	5	3	2	9	249.99	144.30	2105.61
1600	100	44	148	3	2	3	2	249.99	206.56	293.42
1530	46	44	341	4	4	1	3	249.99	220.31	529.66
1363	85	44	339	4	4	3	10	249.99	276.97	2222.93
1100	96	44	164	2	1	2	1	249.99	214.33	35.66
1075	21	44	331	5	1	3	9	249.99	38.79	2211.12
993	86	44	29	5	4	4	8	249.99	33.98	1965.94
991	39	44	271	5	4	3	9	249.99	273.14	1976.77
978	51	44	86	3	1	1	3	249.99	128.33	621.64
958	77	44	320	3	3	1	4	249.99	198.31	801.65
932	82	44	358	5	1	2	2	249.99	137.50	362.48
914	27	44	123	4	1	1	9	249.99	73.76	2176.15
880	68	44	349	4	2	2	10	249.99	204.89	2295.01
725	85	44	330	1	4	4	4	249.99	72.40	927.56
668	58	44	333	1	1	1	4	249.99	130.53	869.43
667	54	44	15	5	4	2	9	249.99	137.68	2112.23
651	12	44	84	4	3	3	10	249.99	90.31	2409.59
610	82	44	336	1	1	3	2	249.99	157.37	342.61
588	39	44	279	3	3	3	8	249.99	143.52	1856.40
570	90	44	119	4	4	2	2	249.99	56.70	443.28
561	67	44	129	1	2	1	7	249.99	20.87	1729.06
535	58	44	3	5	4	3	5	249.99	259.08	990.87
470	56	44	83	4	2	4	5	249.99	111.41	1138.54
391	50	44	126	5	3	1	5	249.99	279.76	970.19
389	99	44	119	1	2	4	4	249.99	90.15	909.81
378	64	44	20	5	1	3	5	249.99	102.45	1147.50
369	57	44	101	1	4	2	6	249.99	271.63	1228.31
368	5	44	232	2	3	1	9	249.99	120.85	2129.06
289	33	44	108	1	2	3	7	249.99	211.81	1538.12
238	93	44	186	3	4	1	1	249.99	201.72	48.27
229	67	44	282	2	4	4	8	249.99	219.72	1780.20
225	27	44	358	4	1	2	10	249.99	196.83	2303.07
224	2	44	150	5	2	3	10	249.99	57.41	2442.49
184	3	44	107	1	2	2	10	249.99	61.15	2438.75
128	87	44	174	2	2	3	6	249.99	245.68	1254.26
117	88	44	58	3	3	4	10	249.99	21.15	2478.75
57	1	44	239	5	3	4	9	249.99	67.01	2182.90
47	70	44	236	5	4	4	6	249.99	35.54	1464.40
1945	10	45	280	2	3	4	1	249.99	121.63	128.36
1931	66	45	138	4	4	3	9	249.99	221.04	2028.87
1907	11	45	276	2	2	2	1	249.99	11.94	238.05
1846	21	45	276	2	1	3	7	249.99	243.59	1506.34
1779	69	45	57	4	3	3	1	249.99	150.21	99.78
1754	16	45	68	4	1	3	6	249.99	122.72	1377.22
1691	97	45	212	5	2	4	10	249.99	57.89	2442.01
1645	23	45	277	3	4	4	9	249.99	8.82	2241.09
1631	18	45	27	5	2	4	8	249.99	37.98	1961.94
1391	71	45	182	5	2	2	4	249.99	38.84	961.12
1300	13	45	341	1	2	4	10	249.99	55.79	2444.11
1229	74	45	207	3	1	1	8	249.99	38.20	1961.72
1166	32	45	115	5	4	2	2	249.99	112.78	387.20
1165	93	45	231	5	3	4	2	249.99	17.48	482.50
1108	95	45	35	1	1	2	5	249.99	183.92	1066.03
1054	17	45	313	4	2	2	7	249.99	97.50	1652.43
988	67	45	279	3	2	3	2	249.99	1.26	498.72
960	10	45	69	2	3	2	5	249.99	116.96	1132.99
786	43	45	64	5	1	1	7	249.99	236.33	1513.60
707	77	45	5	2	4	2	9	249.99	151.08	2098.83
548	87	45	268	1	4	3	9	249.99	121.62	2128.29
482	94	45	79	5	2	2	3	249.99	1.45	748.52
423	1	45	116	3	4	3	1	249.99	101.00	148.99
382	90	45	155	3	1	3	10	249.99	127.96	2371.94
370	71	45	305	5	2	3	5	249.99	184.69	1065.26
315	5	45	198	3	2	3	5	249.99	145.97	1103.98
308	73	45	93	4	1	1	1	249.99	170.22	79.77
243	87	45	277	3	4	2	7	249.99	298.63	1451.30
174	46	45	173	5	4	1	3	249.99	247.97	502.00
80	60	45	299	5	1	4	3	249.99	273.68	476.29
50	16	45	266	5	3	1	3	249.99	209.70	540.27
35	49	45	101	4	1	2	9	249.99	261.82	1988.09
1993	28	46	103	4	2	3	6	34.00	185.43	18.57
1952	90	46	321	5	2	3	8	34.00	1.00	271.00
1738	15	46	185	4	3	3	4	34.00	128.86	7.14
1616	58	46	239	3	1	1	9	34.00	215.40	90.60
1567	89	46	78	2	2	3	4	34.00	130.42	5.58
1552	22	46	246	4	1	1	10	34.00	3.07	336.93
1507	95	46	244	4	2	4	7	34.00	11.20	226.80
1470	58	46	124	2	3	3	9	34.00	9.21	296.79
1430	1	46	289	2	2	2	10	34.00	219.40	120.60
1403	5	46	74	1	2	1	10	34.00	191.13	148.87
1266	89	46	271	2	2	4	10	34.00	138.96	201.04
1050	35	46	321	3	2	2	7	34.00	148.17	89.83
1025	32	46	81	2	3	4	4	34.00	130.15	5.85
1005	50	46	124	5	3	3	6	34.00	91.23	112.77
953	42	46	342	5	1	1	2	34.00	55.43	12.57
937	44	46	43	2	1	3	3	34.00	99.93	2.07
893	8	46	215	4	2	2	7	34.00	100.69	137.31
857	19	46	322	2	4	4	7	34.00	191.22	46.78
641	73	46	319	3	1	4	3	34.00	21.16	80.84
637	93	46	199	3	1	3	3	34.00	40.06	61.94
565	14	46	77	5	3	4	8	34.00	67.08	204.92
402	86	46	17	5	4	2	7	34.00	82.14	155.86
329	37	46	324	1	2	1	8	34.00	50.89	221.11
275	57	46	3	1	1	1	9	34.00	129.89	176.11
271	74	46	303	1	2	1	6	34.00	130.83	73.17
141	12	46	101	1	3	4	8	34.00	67.68	204.32
1988	25	47	196	2	4	3	3	90.00	249.97	20.03
1978	50	47	135	3	2	2	7	90.00	129.86	500.14
1934	58	47	244	5	1	2	4	90.00	156.81	203.19
1699	43	47	334	1	3	3	7	90.00	165.31	464.69
1654	51	47	292	3	4	1	5	90.00	70.84	379.16
1613	28	47	231	3	4	4	4	90.00	221.20	138.80
1473	75	47	267	3	4	1	5	90.00	218.91	231.09
1401	69	47	320	3	4	4	7	90.00	166.06	463.94
1371	2	47	159	2	4	1	9	90.00	118.72	691.28
1352	31	47	84	2	3	1	10	90.00	97.22	802.78
1240	91	47	7	5	4	4	5	90.00	66.14	383.86
1235	15	47	263	2	2	1	7	90.00	90.63	539.37
1164	7	47	251	5	1	2	10	90.00	67.04	832.96
1163	34	47	257	2	2	4	6	90.00	242.32	297.68
1084	3	47	325	3	2	4	10	90.00	238.71	661.29
820	18	47	110	2	3	3	5	90.00	235.89	214.11
721	3	47	296	2	2	1	1	90.00	11.39	78.61
663	34	47	183	5	2	3	7	90.00	139.75	490.25
595	95	47	349	4	2	2	6	90.00	178.44	361.56
358	97	47	117	3	1	4	8	90.00	218.98	501.02
217	85	47	138	5	3	3	5	90.00	63.27	386.73
206	46	47	61	5	4	1	4	90.00	254.52	105.48
145	60	47	207	2	3	2	6	90.00	227.83	312.17
16	54	47	323	1	3	1	8	90.00	240.70	479.30
1989	2	48	280	3	4	1	6	460.00	256.92	2503.08
1982	68	48	145	1	3	2	2	460.00	48.15	871.85
1972	29	48	106	4	4	4	4	460.00	196.60	1643.40
1837	70	48	364	4	2	3	7	460.00	151.97	3068.03
1773	75	48	83	2	2	1	1	460.00	79.43	380.57
1766	63	48	306	2	4	1	4	460.00	191.12	1648.88
1739	50	48	281	4	2	4	2	460.00	224.80	695.20
1713	51	48	211	4	1	3	4	460.00	12.90	1827.10
1595	28	48	110	1	2	2	7	460.00	236.53	2983.47
1416	34	48	226	4	4	2	9	460.00	204.67	3935.33
1369	81	48	116	5	3	3	3	460.00	251.23	1128.77
1342	72	48	140	2	3	1	2	460.00	8.78	911.22
1341	53	48	80	4	4	4	4	460.00	283.57	1556.43
1316	91	48	62	5	2	1	6	460.00	203.75	2556.25
1304	4	48	62	5	3	2	10	460.00	158.72	4441.28
1228	35	48	75	2	3	4	10	460.00	210.41	4389.59
1210	37	48	172	2	3	1	10	460.00	72.39	4527.61
1066	87	48	117	5	4	3	2	460.00	23.20	896.80
1000	43	48	182	4	2	1	1	460.00	112.16	347.84
999	57	48	247	2	4	4	2	460.00	175.78	744.22
992	27	48	105	4	2	3	5	460.00	148.83	2151.17
935	57	48	250	5	3	2	3	460.00	101.45	1278.55
916	30	48	345	4	1	1	10	460.00	172.83	4427.17
887	87	48	324	2	1	3	6	460.00	113.38	2646.62
829	91	48	19	4	3	3	9	460.00	268.31	3871.69
792	28	48	1	5	3	1	3	460.00	0.94	1379.06
778	98	48	249	5	3	1	8	460.00	173.40	3506.60
728	76	48	19	2	2	2	4	460.00	244.82	1595.18
717	22	48	86	3	3	3	3	460.00	192.65	1187.35
672	87	48	334	5	2	2	6	460.00	153.66	2606.34
630	14	48	9	1	4	3	4	460.00	279.61	1560.39
601	98	48	339	3	4	2	4	460.00	40.53	1799.47
511	60	48	321	3	1	2	9	460.00	144.68	3995.32
496	61	48	171	1	1	2	5	460.00	137.28	2162.72
489	16	48	207	3	3	4	8	460.00	229.73	3450.27
319	48	48	118	1	3	3	6	460.00	90.03	2669.97
267	6	48	113	1	2	2	8	460.00	261.23	3418.77
261	20	48	29	2	2	4	7	460.00	70.71	3149.29
221	57	48	245	5	4	2	10	460.00	36.56	4563.44
199	46	48	251	3	4	1	8	460.00	160.32	3519.68
182	63	48	96	5	3	4	5	460.00	14.61	2285.39
162	34	48	286	1	4	2	6	460.00	234.07	2525.93
149	41	48	280	4	3	2	8	460.00	178.04	3501.96
49	82	48	290	4	1	3	3	460.00	241.14	1138.86
45	63	48	362	1	3	4	7	460.00	184.61	3035.39
38	89	48	40	3	4	2	8	460.00	72.89	3607.11
11	45	48	341	1	4	4	6	460.00	145.63	2614.37
1895	97	49	147	4	2	1	4	41.00	54.89	109.11
1735	72	49	354	5	4	4	6	41.00	160.26	85.74
1694	79	49	92	3	2	2	10	41.00	1.89	408.11
1601	36	49	226	3	4	2	2	41.00	13.24	68.76
1447	85	49	224	1	3	3	3	41.00	30.88	92.12
1383	96	49	129	2	3	2	9	41.00	266.96	102.04
1237	79	49	265	1	2	4	3	41.00	53.54	69.46
1185	51	49	150	3	4	3	10	41.00	242.96	167.04
1056	1	49	123	5	1	1	3	41.00	115.08	7.92
983	49	49	279	2	3	3	7	41.00	210.45	76.55
870	42	49	121	3	4	3	6	41.00	20.41	225.59
828	3	49	343	5	3	1	1	41.00	24.77	16.23
814	2	49	127	4	3	1	10	41.00	22.20	387.80
783	43	49	29	5	3	1	8	41.00	99.74	228.26
767	40	49	323	3	4	2	6	41.00	91.92	154.08
761	68	49	134	3	4	4	6	41.00	224.91	21.09
759	8	49	13	5	4	2	4	41.00	64.10	99.90
636	80	49	340	4	2	1	10	41.00	269.13	140.87
540	73	49	267	1	4	1	7	41.00	82.33	204.67
504	53	49	201	5	2	3	7	41.00	17.73	269.27
467	31	49	17	3	3	2	7	41.00	279.71	7.29
436	10	49	343	2	4	2	4	41.00	16.11	147.89
328	67	49	238	3	3	4	3	41.00	8.23	114.77
295	20	49	345	3	4	3	8	41.00	191.02	136.98
228	92	49	206	1	4	4	9	41.00	265.37	103.63
143	86	49	227	3	1	2	9	41.00	118.42	250.58
104	53	49	75	3	1	4	8	41.00	42.71	285.29
3	92	49	213	3	1	2	10	41.00	24.36	385.64
1966	78	50	190	3	1	1	7	93.00	76.55	574.45
1850	26	50	201	5	3	2	7	93.00	147.94	503.06
1813	79	50	69	3	3	4	8	93.00	4.15	739.85
1810	18	50	116	1	2	1	2	93.00	177.03	8.97
1768	44	50	154	3	2	1	7	93.00	151.22	499.78
1751	53	50	294	2	2	3	3	93.00	100.27	178.73
1712	2	50	312	2	2	1	6	93.00	256.97	301.03
1711	41	50	44	4	2	1	4	93.00	3.06	368.94
1696	85	50	154	5	2	2	5	93.00	51.73	413.27
1672	12	50	125	1	4	3	9	93.00	112.22	724.78
1498	80	50	32	3	3	2	6	93.00	259.99	298.01
1411	2	50	11	5	3	4	4	93.00	282.84	89.16
1355	36	50	342	3	1	1	6	93.00	123.84	434.16
1280	65	50	75	4	3	4	4	93.00	194.30	177.70
1174	16	50	130	5	2	4	9	93.00	12.28	824.72
1042	77	50	186	4	4	1	1	93.00	9.11	83.89
1014	20	50	303	5	2	2	10	93.00	76.03	853.97
946	36	50	346	3	1	1	4	93.00	188.83	183.17
889	55	50	187	4	4	2	3	93.00	114.37	164.63
664	45	50	315	3	4	1	4	93.00	287.27	84.73
646	21	50	50	3	2	3	5	93.00	145.35	319.65
551	84	50	213	4	3	1	2	93.00	92.38	93.62
528	94	50	172	4	2	2	4	93.00	20.57	351.43
400	20	50	209	4	2	1	6	93.00	218.45	339.55
398	27	50	182	3	3	4	6	93.00	136.71	421.29
260	63	50	191	4	1	4	2	93.00	182.76	3.24
239	39	50	59	4	4	1	2	93.00	118.23	67.77
220	70	50	262	2	1	3	7	93.00	194.37	456.63
97	31	50	230	2	3	2	10	93.00	22.83	907.17
87	21	50	329	1	3	3	9	93.00	131.93	705.07
77	79	50	95	5	1	2	3	93.00	254.86	24.14
43	72	50	121	1	3	1	10	93.00	79.02	850.98
6	97	50	154	4	3	3	9	93.00	86.01	750.99
5	59	50	186	1	1	4	5	93.00	50.23	414.77
105	58	2	180	2	1	1	1	46.00	45.99	0.01
127	87	2	73	5	1	4	5	46.00	229.99	0.01
367	62	2	187	3	2	1	1	46.00	45.99	0.01
465	33	2	338	4	2	2	1	46.00	45.99	0.01
524	7	2	121	3	4	1	6	46.00	275.99	0.01
571	30	2	298	4	4	4	2	46.00	91.99	0.01
577	55	2	174	4	2	4	2	46.00	91.99	0.01
627	97	2	19	4	2	2	1	46.00	45.99	0.01
713	2	2	98	1	3	1	2	46.00	91.99	0.01
876	1	2	335	5	2	1	3	46.00	137.99	0.01
962	25	2	9	5	1	3	6	46.00	275.99	0.01
1170	29	2	152	2	1	4	1	46.00	45.99	0.01
1324	14	2	169	4	1	1	1	46.00	45.99	0.01
1423	11	2	113	2	1	2	2	46.00	91.99	0.01
1536	86	2	39	5	2	4	4	46.00	183.99	0.01
7	16	3	102	1	2	2	3	22.00	65.99	0.01
85	64	3	79	2	1	4	8	22.00	175.99	0.01
130	94	3	85	1	1	4	4	22.00	87.99	0.01
197	72	3	172	1	4	3	1	22.00	21.99	0.01
241	76	3	1	5	1	4	4	22.00	87.99	0.01
348	15	3	133	1	2	1	9	22.00	197.99	0.01
517	41	3	179	4	3	1	3	22.00	65.99	0.01
882	38	3	91	2	4	2	8	22.00	175.99	0.01
883	77	3	180	5	1	1	1	22.00	21.99	0.01
928	29	3	204	4	3	3	6	22.00	131.99	0.01
1008	89	3	319	3	1	2	4	22.00	87.99	0.01
1029	90	3	178	1	4	2	7	22.00	153.99	0.01
1065	61	3	183	2	2	4	2	22.00	43.99	0.01
1073	67	3	357	4	2	4	9	22.00	197.99	0.01
1089	88	3	12	5	2	3	1	22.00	21.99	0.01
1440	44	3	34	4	3	2	8	22.00	175.99	0.01
1568	86	3	51	1	1	4	3	22.00	65.99	0.01
1581	78	3	293	2	3	3	8	22.00	175.99	0.01
1684	62	3	18	3	2	1	3	22.00	65.99	0.01
1748	39	3	78	2	2	2	3	22.00	65.99	0.01
1816	63	3	12	5	4	2	8	22.00	175.99	0.01
1922	3	3	228	1	2	2	2	22.00	43.99	0.01
1948	24	3	261	1	2	2	3	22.00	65.99	0.01
263	22	4	88	5	2	1	4	46.00	183.99	0.01
340	95	4	269	3	3	4	2	46.00	91.99	0.01
963	17	4	205	3	1	1	1	46.00	45.99	0.01
1026	6	4	173	1	3	1	2	46.00	91.99	0.01
1357	53	4	318	3	4	2	1	46.00	45.99	0.01
1504	50	4	76	1	2	2	1	46.00	45.99	0.01
1592	31	4	288	4	4	2	1	46.00	45.99	0.01
1747	41	4	268	3	3	2	2	46.00	91.99	0.01
1891	78	4	142	4	2	3	1	46.00	45.99	0.01
1920	97	4	162	2	4	2	3	46.00	137.99	0.01
245	35	5	176	4	2	1	2	90.00	179.99	0.01
505	46	5	193	4	3	4	2	90.00	179.99	0.01
751	48	5	193	1	1	4	1	90.00	89.99	0.01
1596	99	5	97	2	1	3	2	90.00	179.99	0.01
1856	11	5	111	5	3	2	2	90.00	179.99	0.01
479	1	10	6	1	2	4	1	100.00	99.99	0.01
730	36	10	334	3	3	4	2	100.00	199.99	0.01
1457	37	10	96	3	4	1	1	100.00	99.99	0.01
1840	22	11	75	2	1	2	1	200.00	199.99	0.01
1858	56	11	147	3	1	4	1	200.00	199.99	0.01
180	22	16	284	4	3	3	5	29.00	144.99	0.01
387	65	16	159	4	3	1	3	29.00	86.99	0.01
518	4	16	28	4	4	2	8	29.00	231.99	0.01
645	72	16	95	3	1	2	4	29.00	115.99	0.01
805	3	16	255	5	4	4	2	29.00	57.99	0.01
998	28	16	181	5	1	3	2	29.00	57.99	0.01
1051	5	16	338	5	1	1	6	29.00	173.99	0.01
1142	5	16	243	5	1	4	8	29.00	231.99	0.01
1196	43	16	261	4	4	3	1	29.00	28.99	0.01
1282	29	16	115	1	2	4	7	29.00	202.99	0.01
1421	27	16	304	2	4	3	4	29.00	115.99	0.01
1464	89	16	342	5	3	3	2	29.00	57.99	0.01
1465	43	16	10	2	1	1	1	29.00	28.99	0.01
1584	82	16	279	2	3	4	5	29.00	144.99	0.01
1607	32	16	122	2	3	2	8	29.00	231.99	0.01
1633	36	16	90	4	4	1	2	29.00	57.99	0.01
1792	23	16	210	3	1	4	2	29.00	57.99	0.01
1901	77	16	67	1	3	2	7	29.00	202.99	0.01
158	43	17	51	3	2	4	5	37.00	184.99	0.01
175	33	17	240	1	4	4	1	37.00	36.99	0.01
582	93	17	12	5	1	4	4	37.00	147.99	0.01
584	55	17	313	5	4	1	1	37.00	36.99	0.01
743	96	17	87	4	1	2	6	37.00	221.99	0.01
760	79	17	141	2	1	2	1	37.00	36.99	0.01
888	31	17	59	1	2	4	2	37.00	73.99	0.01
1172	36	17	75	1	2	4	3	37.00	110.99	0.01
1299	40	17	47	1	3	3	5	37.00	184.99	0.01
1339	48	17	56	3	4	3	4	37.00	147.99	0.01
1351	74	17	274	1	4	3	1	37.00	36.99	0.01
1733	56	17	211	1	1	2	1	37.00	36.99	0.01
1839	33	17	221	1	4	2	1	37.00	36.99	0.01
202	97	18	158	1	4	3	1	50.00	49.99	0.01
231	3	18	326	4	2	3	3	50.00	149.99	0.01
363	54	18	178	4	2	1	1	50.00	49.99	0.01
520	59	18	205	5	3	4	3	50.00	149.99	0.01
580	82	18	298	5	1	4	1	50.00	49.99	0.01
695	100	18	346	1	2	2	2	50.00	99.99	0.01
834	22	18	98	3	4	3	5	50.00	249.99	0.01
877	39	18	97	5	4	1	4	50.00	199.99	0.01
995	6	18	304	5	3	4	4	50.00	199.99	0.01
1057	91	18	11	4	2	4	2	50.00	99.99	0.01
1107	32	18	182	2	2	2	3	50.00	149.99	0.01
1571	81	18	185	2	2	3	3	50.00	149.99	0.01
1912	63	18	93	2	1	4	5	50.00	249.99	0.01
154	4	19	310	1	4	2	2	100.00	199.99	0.01
592	37	19	115	3	4	2	2	100.00	199.99	0.01
941	84	19	138	1	2	4	1	100.00	99.99	0.01
1076	43	19	335	3	1	2	2	100.00	199.99	0.01
1083	12	19	84	2	3	1	2	100.00	199.99	0.01
1409	99	19	104	3	2	4	1	100.00	99.99	0.01
1806	75	19	141	4	1	1	1	100.00	99.99	0.01
101	53	31	219	5	1	4	4	10.00	39.99	0.01
139	100	31	88	5	4	2	4	10.00	39.99	0.01
278	78	31	186	4	1	1	2	10.00	19.99	0.01
298	41	31	78	5	1	3	6	10.00	59.99	0.01
415	64	31	245	5	1	3	7	10.00	69.99	0.01
421	54	31	165	2	4	1	1	10.00	9.99	0.01
462	46	31	302	2	3	4	3	10.00	29.99	0.01
472	6	31	346	3	1	2	3	10.00	29.99	0.01
495	50	31	91	2	4	3	4	10.00	39.99	0.01
521	51	31	54	3	2	1	1	10.00	9.99	0.01
533	93	31	240	4	3	1	4	10.00	39.99	0.01
544	12	31	278	2	4	2	4	10.00	39.99	0.01
547	99	31	108	4	1	2	1	10.00	9.99	0.01
643	37	31	225	2	1	3	3	10.00	29.99	0.01
660	4	31	188	2	2	3	1	10.00	9.99	0.01
851	79	31	317	2	4	4	10	10.00	99.99	0.01
885	24	31	193	5	1	3	9	10.00	89.99	0.01
918	65	31	266	3	3	4	1	10.00	9.99	0.01
922	17	31	71	3	4	4	3	10.00	29.99	0.01
1113	52	31	42	1	4	2	2	10.00	19.99	0.01
1134	5	31	26	4	3	3	8	10.00	79.99	0.01
1267	80	31	263	4	4	1	9	10.00	89.99	0.01
1291	68	31	55	5	4	1	2	10.00	19.99	0.01
1349	9	31	299	1	4	3	3	10.00	29.99	0.01
1389	89	31	224	1	1	2	2	10.00	19.99	0.01
1542	59	31	129	2	3	2	1	10.00	9.99	0.01
1636	17	31	98	2	4	3	2	10.00	19.99	0.01
1807	95	31	130	4	2	3	1	10.00	9.99	0.01
1844	28	31	234	5	2	4	5	10.00	49.99	0.01
1916	43	31	15	3	3	4	6	10.00	59.99	0.01
1956	57	31	21	4	1	3	6	10.00	59.99	0.01
140	63	32	114	3	1	2	1	100.00	99.99	0.01
262	5	32	163	5	4	1	2	100.00	199.99	0.01
1092	23	32	262	5	3	2	2	100.00	199.99	0.01
131	26	33	143	2	2	2	3	20.00	59.99	0.01
283	81	33	34	1	1	4	7	20.00	139.99	0.01
493	40	33	343	5	4	3	6	20.00	119.99	0.01
499	10	33	73	2	3	3	7	20.00	139.99	0.01
507	40	33	43	2	2	4	3	20.00	59.99	0.01
525	36	33	200	3	1	3	9	20.00	179.99	0.01
536	84	33	282	4	4	3	2	20.00	39.99	0.01
549	86	33	322	1	1	1	7	20.00	139.99	0.01
611	44	33	240	5	4	1	6	20.00	119.99	0.01
691	73	33	108	4	3	4	10	20.00	199.99	0.01
741	86	33	328	1	4	1	5	20.00	99.99	0.01
848	92	33	2	4	1	4	6	20.00	119.99	0.01
855	87	33	37	1	3	2	4	20.00	79.99	0.01
996	28	33	63	5	1	3	9	20.00	179.99	0.01
1077	77	33	140	3	4	4	4	20.00	79.99	0.01
1101	66	33	36	2	4	4	8	20.00	159.99	0.01
1105	11	33	114	2	3	4	6	20.00	119.99	0.01
1106	63	33	252	5	1	1	3	20.00	59.99	0.01
1243	64	33	346	1	3	3	4	20.00	79.99	0.01
1269	20	33	205	2	2	3	1	20.00	19.99	0.01
1289	92	33	86	5	2	4	8	20.00	159.99	0.01
1399	15	33	270	1	4	2	8	20.00	159.99	0.01
1406	63	33	136	4	4	2	8	20.00	159.99	0.01
1481	30	33	144	4	4	2	8	20.00	159.99	0.01
1583	61	33	300	3	2	2	5	20.00	99.99	0.01
1603	77	33	267	4	2	1	7	20.00	139.99	0.01
1608	88	33	241	4	1	3	3	20.00	59.99	0.01
1685	48	33	166	2	1	4	4	20.00	79.99	0.01
1720	80	33	173	1	4	1	2	20.00	39.99	0.01
1940	23	33	316	4	3	2	6	20.00	119.99	0.01
1980	19	33	243	3	3	4	2	20.00	39.99	0.01
1994	88	33	220	4	3	3	4	20.00	79.99	0.01
72	23	35	124	1	4	3	2	72.00	143.99	0.01
452	22	35	287	4	4	3	2	72.00	143.99	0.01
872	65	35	24	1	4	3	2	72.00	143.99	0.01
949	50	35	289	4	2	1	1	72.00	71.99	0.01
1041	65	35	259	3	4	3	3	72.00	215.99	0.01
1744	11	35	299	5	4	1	2	72.00	143.99	0.01
1771	28	35	236	1	2	1	3	72.00	215.99	0.01
76	73	36	47	2	1	4	1	34.00	33.99	0.01
108	67	36	334	4	1	4	6	34.00	203.99	0.01
585	3	36	43	1	1	2	8	34.00	271.99	0.01
624	70	36	214	4	2	3	1	34.00	33.99	0.01
629	53	36	114	2	4	1	2	34.00	67.99	0.01
633	94	36	142	3	4	2	1	34.00	33.99	0.01
642	66	36	53	1	3	1	7	34.00	237.99	0.01
830	79	36	20	4	4	2	2	34.00	67.99	0.01
838	70	36	218	1	4	2	3	34.00	101.99	0.01
1006	80	36	344	2	2	1	3	34.00	101.99	0.01
1063	96	36	81	1	4	1	4	34.00	135.99	0.01
1154	22	36	260	4	3	4	3	34.00	101.99	0.01
1405	35	36	343	4	3	1	5	34.00	169.99	0.01
1579	11	36	75	3	1	4	7	34.00	237.99	0.01
1659	18	36	44	1	1	2	2	34.00	67.99	0.01
1831	31	36	170	5	3	4	3	34.00	101.99	0.01
1845	13	36	354	1	3	1	2	34.00	67.99	0.01
1865	71	36	163	2	2	2	1	34.00	33.99	0.01
1885	90	36	129	2	4	1	4	34.00	135.99	0.01
1933	93	36	82	2	1	2	2	34.00	67.99	0.01
1981	67	36	261	1	4	2	3	34.00	101.99	0.01
2	46	37	161	2	1	4	3	62.00	185.99	0.01
124	33	37	33	1	4	1	2	62.00	123.99	0.01
1264	8	37	327	1	2	2	1	62.00	61.99	0.01
1609	82	37	183	1	4	4	1	62.00	61.99	0.01
1774	3	37	33	1	3	2	3	62.00	185.99	0.01
1809	50	37	183	1	2	3	2	62.00	123.99	0.01
1949	31	37	23	4	4	4	4	62.00	247.99	0.01
25	22	41	351	4	4	2	4	60.00	239.99	0.01
29	71	41	294	5	1	1	3	60.00	179.99	0.01
88	47	41	70	4	4	4	1	60.00	59.99	0.01
274	63	41	202	2	1	3	3	60.00	179.99	0.01
357	37	41	163	1	4	4	1	60.00	59.99	0.01
742	13	41	257	3	4	3	2	60.00	119.99	0.01
1095	75	41	145	5	3	4	1	60.00	59.99	0.01
1157	76	41	102	1	2	3	2	60.00	119.99	0.01
1323	83	41	177	2	4	4	1	60.00	59.99	0.01
1443	43	41	332	2	3	2	3	60.00	179.99	0.01
342	17	44	222	1	1	1	1	249.99	249.98	0.01
1528	47	44	254	4	4	4	1	249.99	249.98	0.01
54	43	46	223	3	3	3	2	34.00	67.99	0.01
676	72	46	319	1	3	4	6	34.00	203.99	0.01
755	37	46	269	1	1	1	4	34.00	135.99	0.01
972	72	46	336	3	3	2	2	34.00	67.99	0.01
1079	57	46	284	2	3	4	6	34.00	203.99	0.01
1365	11	46	113	3	1	3	5	34.00	169.99	0.01
1533	66	46	65	2	4	2	3	34.00	101.99	0.01
1617	9	46	224	2	1	4	4	34.00	135.99	0.01
1880	100	46	124	4	1	4	2	34.00	67.99	0.01
90	44	47	177	1	3	1	1	90.00	89.99	0.01
674	75	47	210	4	4	3	1	90.00	89.99	0.01
1448	32	47	336	2	1	1	1	90.00	89.99	0.01
1485	23	47	321	4	3	1	1	90.00	89.99	0.01
1578	22	47	273	2	1	2	1	90.00	89.99	0.01
14	16	49	213	5	4	3	2	41.00	81.99	0.01
249	63	49	27	5	1	4	5	41.00	204.99	0.01
257	6	49	106	4	2	3	1	41.00	40.99	0.01
412	42	49	266	2	1	4	2	41.00	81.99	0.01
827	85	49	145	4	4	1	2	41.00	81.99	0.01
840	54	49	265	3	1	3	6	41.00	245.99	0.01
1221	25	49	325	2	1	1	5	41.00	204.99	0.01
1353	92	49	105	4	1	2	2	41.00	81.99	0.01
1585	53	49	322	2	3	4	3	41.00	122.99	0.01
1797	76	49	70	2	4	4	4	41.00	163.99	0.01
1860	87	49	195	1	1	4	1	41.00	40.99	0.01
1897	88	49	213	1	3	4	5	41.00	204.99	0.01
1233	5	50	49	4	3	3	2	93.00	185.99	0.01
\.


--
-- Name: dim_cliente_sk_cliente_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dim_cliente_sk_cliente_seq', 538, true);


--
-- Name: dim_pagamento_sk_pagamento_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dim_pagamento_sk_pagamento_seq', 4, true);


--
-- Name: dim_produto_sk_produto_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dim_produto_sk_produto_seq', 217, true);


--
-- Name: dim_regiao_sk_regiao_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dim_regiao_sk_regiao_seq', 5, true);


--
-- Name: dim_tempo_sk_tempo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dim_tempo_sk_tempo_seq', 1200, true);


--
-- Name: dim_transportadora_sk_transportadora_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dim_transportadora_sk_transportadora_seq', 15, true);


--
-- Name: fato_estoque_sk_estoque_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.fato_estoque_sk_estoque_seq', 500, true);


--
-- Name: fato_financeiro_sk_financeiro_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.fato_financeiro_sk_financeiro_seq', 800, true);


--
-- Name: fato_vendas_sk_venda_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.fato_vendas_sk_venda_seq', 2000, true);


--
-- Name: dim_cliente dim_cliente_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_cliente
    ADD CONSTRAINT dim_cliente_pkey PRIMARY KEY (sk_cliente);


--
-- Name: dim_pagamento dim_pagamento_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_pagamento
    ADD CONSTRAINT dim_pagamento_pkey PRIMARY KEY (sk_pagamento);


--
-- Name: dim_produto dim_produto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_produto
    ADD CONSTRAINT dim_produto_pkey PRIMARY KEY (sk_produto);


--
-- Name: dim_regiao dim_regiao_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_regiao
    ADD CONSTRAINT dim_regiao_pkey PRIMARY KEY (sk_regiao);


--
-- Name: dim_tempo dim_tempo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_tempo
    ADD CONSTRAINT dim_tempo_pkey PRIMARY KEY (sk_tempo);


--
-- Name: dim_transportadora dim_transportadora_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dim_transportadora
    ADD CONSTRAINT dim_transportadora_pkey PRIMARY KEY (sk_transportadora);


--
-- Name: fato_estoque fato_estoque_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fato_estoque
    ADD CONSTRAINT fato_estoque_pkey PRIMARY KEY (sk_estoque);


--
-- Name: fato_financeiro fato_financeiro_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fato_financeiro
    ADD CONSTRAINT fato_financeiro_pkey PRIMARY KEY (sk_financeiro);


--
-- Name: fato_vendas fato_vendas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fato_vendas
    ADD CONSTRAINT fato_vendas_pkey PRIMARY KEY (sk_venda);


--
-- Name: fato_estoque fato_estoque_sk_produto_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fato_estoque
    ADD CONSTRAINT fato_estoque_sk_produto_fkey FOREIGN KEY (sk_produto) REFERENCES public.dim_produto(sk_produto);


--
-- Name: fato_vendas fato_vendas_sk_pagamento_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fato_vendas
    ADD CONSTRAINT fato_vendas_sk_pagamento_fkey FOREIGN KEY (sk_pagamento) REFERENCES public.dim_pagamento(sk_pagamento);


--
-- Name: fato_vendas fato_vendas_sk_produto_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fato_vendas
    ADD CONSTRAINT fato_vendas_sk_produto_fkey FOREIGN KEY (sk_produto) REFERENCES public.dim_produto(sk_produto);


--
-- Name: fato_vendas fato_vendas_sk_regiao_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fato_vendas
    ADD CONSTRAINT fato_vendas_sk_regiao_fkey FOREIGN KEY (sk_regiao) REFERENCES public.dim_regiao(sk_regiao);


--
-- PostgreSQL database dump complete
--

\unrestrict y1q0SHjWyikbcrQcTN4vXSaDvehusHSaurK4xMXybtwMLJolMgF9hAQZWjUnZri

