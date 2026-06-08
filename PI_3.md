# Projeto Integrador — Conecta Beauty
## Documento de Referência Técnica Completa

---

## 1. Visão Geral do Projeto

O **Conecta Beauty** é um sistema de análise de dados e gestão para uma empresa do setor de beleza. O sistema coleta dados de vendas, estoque, logística e transações financeiras, processa esses dados em um backend Python, e os exibe em um frontend React com gráficos, tabelas e indicadores estatísticos avançados.

O objetivo central é fornecer uma visão 360° do negócio: do faturamento ao estoque crítico, da tendência de vendas à previsão futura por Machine Learning.

---

## 2. Stack Tecnológica

### Backend
- **Python 3.11** como linguagem principal
- **FastAPI** como framework de API REST — escolhido pela tipagem automática, geração de documentação Swagger e alto desempenho
- **PostgreSQL** como banco de dados relacional — utiliza recursos avançados como schemas, constraints, índices, triggers e stored procedures
- **psycopg2** para conexão com o banco
- **scikit-learn** para o modelo de Machine Learning (MLPRegressor)
- **NumPy / Pandas / SciPy** para cálculos estatísticos no módulo de estatísticas avançadas
- **joblib** para serialização e carregamento do modelo treinado

### Frontend
- **React 18** com Vite como bundler
- **ApexCharts** (via react-apexcharts) para renderização de todos os gráficos — utiliza o modo misto (área + linha) para sobrepor dados históricos e previsão IA no mesmo gráfico com séries de tipos diferentes
- Estilização por CSS customizado com variáveis de design (design system próprio, sem framework de UI externo)
- `api.js` centraliza todas as chamadas HTTP com base relativa — depende do proxy do Vite em desenvolvimento e de configuração de servidor em produção
- Hook customizado `useApi` para data fetching com estados de `loading`, `error` e `data`

### Banco de Dados — Arquitetura
O banco segue o **modelo dimensional (Data Warehouse)**, organizado em 4 schemas:
- `geral` — dimensões compartilhadas: `dim_tempo`, `dim_localizacao`
- `administrativo` — clientes, produtos, fornecedores, categorias, canais de venda
- `financeiro` — pedidos, vendas, transações financeiras, formas de pagamento
- `estoque` — movimentações, fretes, transportadoras, tipos de movimentação

---

## 3. Modelagem do Banco de Dados

### Tabelas de Dimensão
| Tabela | Schema | Descrição |
|--------|--------|-----------|
| `dim_tempo` | geral | Calendário completo com dia, mês, trimestre, ano, dia da semana, nome do mês |
| `dim_localizacao` | geral | Cidades, estados e regiões do Brasil com valor de frete base |
| `dim_clientes` | administrativo | Clientes com dados pessoais e localização |
| `dim_produtos` | administrativo | Produtos com dimensões físicas, custo unitário, limites de estoque |
| `dim_categoria_produto` | administrativo | Hierarquia: categoria → subcategoria → linha de produto |
| `dim_fornecedor` | administrativo | Fornecedores com CNPJ e localização |
| `dim_canal_venda` | administrativo | Canais (Online, Físico, Híbrido, Marketplace) |
| `dim_forma_pagamento` | financeiro | Formas de pagamento (PIX, Crédito, Débito, Boleto, Dinheiro, Transferência) |
| `dim_transportadora` | estoque | Transportadoras com métricas de frete por kg e entrega média |
| `dim_tipo_movimentacao` | estoque | Tipos de movimentação (Compra, Venda, Perda, Ajuste etc.) com natureza ENTRADA/SAÍDA |

### Tabelas Fato
| Tabela | Schema | Descrição |
|--------|--------|-----------|
| `fato_venda` | financeiro | Linha a linha de cada item vendido — núcleo do sistema |
| `fato_pedido` | financeiro | Agrupamento de vendas em pedidos com status e valor total |
| `fato_transacao_financeira` | financeiro | Movimentações financeiras (créditos e débitos) com status |
| `fato_movimentacao_estoque` | estoque | Toda entrada e saída de estoque com saldo anterior e atual |
| `fato_pedido_frete` | estoque | Fretes por pedido com transportadora, rota, peso, atraso e avaria |

### Índices
O banco possui índices estratégicos em todas as chaves estrangeiras principais e em campos de filtro frequente: `ano/mes` na dim_tempo, `status_pedido`, `natureza` do movimento, `fk_produto`, `fk_cliente`, etc. Isso garante performance nas queries de analytics mesmo com grande volume de dados.

---

## 4. Arquitetura do Backend

### Estrutura de Arquivos
```
backend/
├── main.py                          # Ponto de entrada da API
├── app/
│   ├── api/
│   │   ├── analytics/               # Camada de negócio (cálculos e formatação)
│   │   │   ├── inicio.py
│   │   │   ├── administrativo.py
│   │   │   ├── financeiro.py
│   │   │   ├── estoque.py
│   │   │   └── estatisticas.py
│   │   └── routes/                  # Camada de roteamento (FastAPI)
│   │       ├── inicio.py
│   │       ├── administrativo.py
│   │       ├── financeiro.py
│   │       ├── estoque.py
│   │       ├── estatisticas.py
│   │       └── ml.py
│   └── ml/
│       ├── treinar.py               # Script de treinamento
│       ├── predictor.py             # Singleton de previsão
│       ├── modelo.pkl               # Artefato: rede neural treinada
│       ├── scaler_x.pkl             # Artefato: normalizador de features
│       ├── scaler_y.pkl             # Artefato: normalizador do target
│       └── meta.pkl                 # Artefato: metadados e série histórica
├── sql/
│   ├── banco/
│   │   ├── tabelas.sql              # DDL completo
│   │   ├── views.sql                # Materialized Views (cubos OLAP)
│   │   ├── procedure.sql            # Stored procedures
│   │   └── trigger.sql              # Triggers e suas funções
│   ├── inicio.sql                   # Queries da tela Início
│   ├── administrativo.sql           # Queries da tela Administrativo
│   ├── financeiro.sql               # Queries da tela Financeiro
│   ├── estoque.sql                  # Queries da tela Estoque
│   └── analytics.sql                # Queries do módulo de Estatísticas
└── utils/
    ├── query_executor.py            # Carrega e executa queries por chave
    ├── db.py                        # Classe Database (context manager)
    └── connection.py                # Configuração da conexão
```

### Padrão de Queries SQL
Todas as queries analíticas são armazenadas em arquivos `.sql` separados e identificadas por comentários no formato `--QUERY: nome_da_query`. O `query_executor.py` carrega esses arquivos em memória na inicialização e permite executar qualquer query pelo nome no formato `"modulo:nome_query"` (ex: `"inicio:total_faturamento"`). Isso mantém o SQL totalmente separado do Python e facilita a manutenção.

### Separação de Responsabilidades
- **routes/**: recebe a requisição HTTP, valida parâmetros com Pydantic e delega para analytics
- **analytics/**: executa a query, formata e processa os dados, aplica cálculos em Python quando necessário
- **ml/**: módulo independente com treinamento e previsão

---

## 5. Rotas da API

### Módulo: Início (`/api/inicio`)
| Método | Rota | O que retorna |
|--------|------|--------------|
| GET | `/api/inicio/kpis` | Faturamento total, total de pedidos, ticket médio, clientes ativos |
| GET | `/api/inicio/faturamento-diario` | Faturamento dia a dia (para gráfico de linha) |
| GET | `/api/inicio/pedidos-por-status` | Distribuição de pedidos por status (Pendente, Confirmado, Enviado...) |
| GET | `/api/inicio/top-produtos` | Top 5 produtos por faturamento |
| GET | `/api/inicio/saude` | Score de saúde geral da empresa com 5 componentes |

Todos aceitam query params `?ano=&mes=` opcionais para filtrar o período.

### Módulo: Administrativo (`/api/admin`)
| Método | Rota | O que retorna |
|--------|------|--------------|
| GET | `/api/admin/kpis` | Produto líder, melhor cliente, top fornecedor, canal #1 |
| GET | `/api/admin/canais-por-venda` | Distribuição de pedidos e faturamento por canal |
| GET | `/api/admin/clientes-por-regiao` | Clientes ativos e faturamento por região/estado |
| GET | `/api/admin/localizacoes` | Busca de localizações para formulários |
| GET | `/api/admin/categorias` | Busca de categorias para formulários |
| POST | `/api/admin/atualizar-cubos` | Chama a procedure `atualizar_cubos_olap()` |
| GET/POST/PUT/DELETE | `/api/admin/clientes/{id}` | CRUD completo de clientes |
| GET/POST/PUT/DELETE | `/api/admin/produtos/{id}` | CRUD completo de produtos |
| GET/POST/PUT/DELETE | `/api/admin/fornecedores/{id}` | CRUD completo de fornecedores |
| GET/POST/PUT/DELETE | `/api/admin/canais/{id}` | CRUD completo de canais de venda |

### Módulo: Financeiro (`/api/financeiro`)
| Método | Rota | O que retorna |
|--------|------|--------------|
| GET | `/api/financeiro/kpis` | Receita, despesas, resultado líquido, inadimplência % e valor |
| GET | `/api/financeiro/receita-vs-despesa` | Receita vs despesa mês a mês (para gráfico) |
| GET | `/api/financeiro/mix-pagamento` | Distribuição por forma de pagamento |
| GET/POST/PUT/DELETE | `/api/financeiro/transacoes/{id}` | CRUD completo de transações financeiras |
| GET/POST/PUT/DELETE | `/api/financeiro/formas-pagamento/{id}` | CRUD de formas de pagamento |

### Módulo: Estoque (`/api/estoque`)
| Método | Rota | O que retorna |
|--------|------|--------------|
| GET | `/api/estoque/kpis` | Total de SKUs, itens em estoque, valor em estoque, SKUs em alerta, giro médio |
| GET | `/api/estoque/movimentacoes-por-dia` | Entradas vs saídas diárias (para gráfico) |
| GET | `/api/estoque/performance-transportadoras` | Ranking de transportadoras por fretes, frete médio e taxa no prazo |
| GET | `/api/estoque/skus-ponto-critico` | Produtos com estoque abaixo do mínimo |
| GET | `/api/estoque/calor-movimentacao` | Mapa de calor de movimentação por produto e mês |
| GET | `/api/estoque/saldos` | Saldo atual de todos os SKUs com situação (NORMAL/CRITICO/EXCESSO) |
| GET | `/api/estoque/tipos-movimentacao` | Tipos de movimentação disponíveis |
| GET/POST/DELETE | `/api/estoque/movimentacoes/{id}` | CRUD de movimentações (sem PUT pois movimentações são imutáveis) |
| GET/POST/PUT/DELETE | `/api/estoque/fretes/{id}` | CRUD completo de fretes |
| GET/POST/PUT/DELETE | `/api/estoque/transportadoras/{id}` | CRUD completo de transportadoras |

### Módulo: Analytics Estatísticos (`/api/analytics`)
| Método | Rota | O que retorna |
|--------|------|--------------|
| GET | `/api/analytics/inicio/tendencia` | Regressão linear do faturamento + projeção 3 meses com IC |
| GET | `/api/analytics/inicio/distribuicao-vendas` | Histograma + descritivas + Shapiro-Wilk |
| GET | `/api/analytics/financeiro/anova-trimestres` | ANOVA one-way entre trimestres |
| GET | `/api/analytics/financeiro/intervalo-confianca` | IC 95% da receita mensal |
| GET | `/api/analytics/admin/anova-canais` | ANOVA one-way entre canais de venda |
| GET | `/api/analytics/estoque/correlacao` | Correlação de Pearson estoque vs vendas |
| GET | `/api/analytics/estoque/descritivas` | Estatísticas descritivas por produto |

### Módulo: Machine Learning (`/api/ml`)
| Método | Rota | O que retorna |
|--------|------|--------------|
| GET | `/api/ml/status` | Se o modelo está treinado e disponível |
| POST | `/api/ml/treinar` | Treina (ou re-treina) o modelo com dados atuais |
| GET | `/api/ml/previsao?horizonte=3` | Previsão para N meses + histórico real + métricas do modelo |

---

## 6. Módulo de Estatísticas

O módulo de estatísticas (`app/api/analytics/estatisticas.py`) utiliza NumPy, Pandas e SciPy para realizar análises quantitativas avançadas sobre os dados de vendas. Nenhum resultado é pré-calculado: os cálculos ocorrem em tempo real a partir dos dados do banco.

### 6.1 Tendência de Faturamento — Regressão Linear

**O que faz:** Aplica regressão linear simples sobre a série temporal do faturamento mensal. A variável independente (X) é o índice temporal (1, 2, 3... n) e a dependente (Y) é o faturamento de cada mês.

**Fonte dos dados:** `financeiro.fato_venda` → agrupado por mês → série temporal ordenada por ano/mês.

**O que calcula:**
- Coeficiente angular (slope) — representa o crescimento ou queda média por mês
- Intercepto — valor base da regressão
- R² — qualidade do ajuste (1 = perfeito)
- P-value — significância estatística (< 0,05 indica tendência real)
- Intervalo de confiança de predição para cada ponto histórico (curva superior e inferior)
- Projeção de 3 meses futuros com IC de predição (mais largo que o IC da linha, pois considera incerteza do ponto futuro)

**Por que aparece assim no frontend:** O gráfico de linha exibe lado a lado o faturamento real (azul) e a linha de tendência (laranja tracejada), com os valores de R², slope e intercepto exibidos abaixo. Isso permite ver visualmente se o negócio está em crescimento ou queda, e o quanto a reta se ajusta aos dados.

### 6.2 Distribuição de Vendas — Histograma + Shapiro-Wilk

**O que faz:** Coleta todos os valores individuais de vendas (valor_total de cada linha de fato_venda) e analisa a distribuição estatística.

**Fonte dos dados:** `financeiro.fato_venda.valor_total` — cada transação individual.

**O que calcula:**
- Histograma com número adaptativo de bins (√n, limitado a 5–20)
- Estatísticas descritivas: média, mediana, desvio padrão, variância, mínimo, máximo, Q1, Q3
- Assimetria (skewness) e curtose — medem o formato da distribuição
- Teste de Shapiro-Wilk — testa se a distribuição é normal (p ≥ 0,05 = normal)

**Por que aparece assim no frontend:** O histograma mostra a frequência de ocorrência de cada faixa de valor de venda. Abaixo, as métricas descritivas e o resultado do teste de normalidade. Isso é relevante porque distributions não-normais influenciam quais testes estatísticos posteriores são válidos.

### 6.3 ANOVA — Faturamento por Trimestre

**O que faz:** Agrupa o faturamento mensal por trimestre e aplica ANOVA one-way para testar se há diferença estatisticamente significativa entre Q1, Q2, Q3 e Q4.

**Fonte dos dados:** `financeiro.fato_venda` + `geral.dim_tempo.trimestre` → faturamento total por mês/trimestre.

**O que calcula:**
- F-estatística — razão entre variância entre grupos e variância dentro dos grupos
- P-value — se < 0,05, há diferença real entre pelo menos dois trimestres
- Média e desvio padrão por trimestre

**Por que aparece assim no frontend:** Exibe F-stat, p-valor e a interpretação textual. Se significativo, o negócio tem sazonalidade trimestral real. Isso orienta decisões de planejamento e estoque por período do ano.

### 6.4 Intervalo de Confiança — Receita Mensal (95%)

**O que faz:** Com base nos valores mensais de faturamento histórico, calcula o intervalo de confiança de 95% para a média da receita mensal usando a distribuição t de Student.

**Fonte dos dados:** `financeiro.fato_venda` agrupado por mês.

**O que calcula:**
- Média da série mensal
- Erro padrão da média (SEM)
- IC inferior e IC superior no nível de 95%

**Por que aparece assim no frontend:** Exibe os três valores (média, IC inferior, IC superior) com uma barra visual que representa o intervalo. Isso responde: "Com 95% de confiança, a receita mensal está entre R$ X e R$ Y." É uma referência concreta para expectativas de desempenho.

### 6.5 ANOVA — Canais de Venda

**O que faz:** Idêntico ao ANOVA de trimestres, mas agrupando por canal de venda (Online, Físico, Marketplace etc.).

**Fonte dos dados:** `financeiro.fato_venda` + `administrativo.dim_canal_venda` → faturamento mensal por canal.

**O que calcula:** Mesma estrutura: F-stat, p-value, média e desvio por canal. Se significativo, canais têm desempenhos estatisticamente diferentes.

### 6.6 Correlação de Pearson — Estoque vs Vendas

**O que faz:** Calcula o coeficiente de correlação de Pearson entre o nível médio de estoque de cada produto em cada mês e a quantidade vendida desse produto naquele mês.

**Fonte dos dados:** Dois CTEs: um agrega vendas mensais por produto, outro agrega estoque médio mensal por produto. O join une os dois.

**O que calcula:**
- r de Pearson — varia entre -1 e +1
- R² — proporção da variância explicada
- P-value — significância da correlação
- Classificação: forte (|r| ≥ 0,7), moderada (≥ 0,4), fraca (< 0,4)
- Direção: positiva ou negativa

**Por que aparece assim no frontend:** Exibe r, R², p-value, força e direção com interpretação textual. Adicionalmente, apresenta um scatter com pontos por produto/mês e uma tabela-resumo com estoque médio vs média de vendas por produto. Isso mostra se produtos com mais estoque tendem a vender mais ou se o estoque é independente das vendas.

### 6.7 Estatísticas Descritivas por Produto

**O que faz:** Para cada produto, calcula um conjunto completo de estatísticas sobre as suas vendas individuais.

**Fonte dos dados:** `financeiro.fato_venda` por linha, agrupado por `nome_produto`.

**O que calcula por produto:**
- Quantidade: total, média, mediana, desvio padrão
- Valor total: soma, média, mediana, desvio padrão
- Preço unitário: média, mínimo, máximo
- Número de transações

**Por que aparece assim no frontend:** Tabela com produtos nas linhas e as métricas nas colunas. O frontend exibe média, mediana, desvio, mínimo e máximo do valor total. Serve para identificar produtos com comportamento instável (alto desvio), identificar preços praticados e comparar volumes.

---

## 7. Módulo de Machine Learning

### 7.1 Algoritmo Utilizado
**MLPRegressor (Multi-Layer Perceptron Regressor)** — rede neural artificial de regressão, implementada pelo scikit-learn.

Arquitetura da rede: `entrada (6 features) → camada oculta 64 neurônios (ReLU) → camada oculta 32 neurônios (ReLU) → saída (1 valor)`

Configurações:
- Solver: Adam (otimizador adaptativo)
- Learning rate inicial: 0,001
- Early stopping: ativo (para quando a melhoria para por 30 iterações)
- Máximo de 2000 iterações
- Random state fixo em 42 (reproducibilidade)

### 7.2 Features de Entrada
O modelo recebe 6 features para prever o faturamento do próximo mês:

1. **lag_1** — faturamento do mês anterior
2. **lag_2** — faturamento de dois meses atrás
3. **lag_3** — faturamento de três meses atrás
4. **mes_sin** — seno do mês × 2π/12 (codificação cíclica da sazonalidade)
5. **mes_cos** — cosseno do mês × 2π/12 (codificação cíclica complementar)
6. **t_norm** — índice temporal normalizado pelo tamanho da série (captura tendência de longo prazo)

Os lags capturam a autocorrelação temporal (meses anteriores influenciam o próximo). As features cíclicas sen/cos codificam a sazonalidade sem criar descontinuidade entre dezembro (12) e janeiro (1) — uma codificação linear não faria isso.

### 7.3 Pré-processamento
- **StandardScaler** separado para X (features) e Y (target) — transforma cada variável para média 0 e desvio padrão 1
- O scaler de Y é necessário porque redes neurais convergem melhor com targets normalizados
- Na previsão, a saída é re-transformada (inverse_transform) para o valor em reais

### 7.4 Validação Cruzada em Série Temporal
Usa **TimeSeriesSplit** — técnica específica para séries temporais que respeita a ordem cronológica: treina sempre no passado e valida sempre no futuro. Isso evita data leakage (usar dados futuros para prever o passado).

Métricas calculadas na validação cruzada:
- **MAE** (Mean Absolute Error) — erro médio absoluto em reais
- **RMSE** (Root Mean Squared Error) — penaliza mais os erros grandes

### 7.5 Previsão
A previsão é iterativa (auto-regressiva): para prever o mês 2, usa o mês 1 previsto como lag. Para o mês 3, usa os meses 1 e 2 previstos. Isso aumenta a incerteza para horizontes mais longos.

O intervalo de confiança da previsão é calculado como: `valor ± (MAE_cv × 1,5)`. É uma aproximação conservadora baseada na métrica de validação real do modelo.

### 7.6 Ciclo de Vida do Modelo
1. Usuário clica "Re-treinar modelo" no frontend → chama `POST /api/ml/treinar`
2. Backend consulta `analytics:faturamento_mensal` (todo o histórico)
3. Constrói features, normaliza, treina com TimeSeriesSplit para métricas
4. Treino final com todos os dados disponíveis
5. Persiste 4 artefatos em disco: `modelo.pkl`, `scaler_x.pkl`, `scaler_y.pkl`, `meta.pkl`
6. Recarrega o singleton em memória
7. Frontend chama `GET /api/ml/previsao?horizonte=N` para exibir os resultados

### 7.7 O que o Frontend Exibe
A previsão é exibida diretamente no gráfico de Faturamento da tela Início e na tela Financeiro, sem tela separada:

- **Gráfico de Faturamento (Início):** quando o filtro está em "Ano" ou "Todos", o gráfico de área do faturamento histórico é estendido com uma linha tracejada amarela representando a previsão dos próximos 3 meses. A linha de previsão conecta visualmente do último ponto histórico real, indicando continuidade. Marcadores circulares destacam cada mês previsto.
- **Strip de previsão numérica:** abaixo do gráfico, os valores previstos para cada mês são exibidos em texto (mês/ano + valor) como complemento visual aos pontos do gráfico.
- **Dashboard Financeiro:** exibe um strip similar com os 3 próximos meses previstos, sem sobrepor o gráfico de Receita vs Despesa.
- **Métricas do modelo:** MAE e RMSE da validação cruzada estão disponíveis via `GET /api/ml/previsao` no campo `modelo`, acessíveis para inspeção via Swagger (`/docs`).

---

## 8. Stored Procedure — Análise Dinâmica de Vendas

**Nome:** `financeiro.analisar_vendas_dinamico`

**Parâmetros:**
- `p_data_inicio` e `p_data_fim` — período de análise
- `p_dimensao` — dimensão de agrupamento: `produto`, `cliente`, `categoria` ou `canal`
- `p_top` — quantos registros retornar (padrão 10)

**Como cumpre o requisito:**

A procedure usa um **cursor não vinculado (REFCURSOR)**, que é um tipo de cursor que não está associado a uma query fixa no momento da declaração. A query é construída dinamicamente em texto (`v_query TEXT`) com base no parâmetro `p_dimensao`, e então aberta com `OPEN v_cursor FOR EXECUTE v_query` — isso é a **query dinâmica** (dynamic SQL).

O cursor percorre os registros com `LOOP / FETCH v_cursor INTO v_registro / EXIT WHEN NOT FOUND`. Em cada iteração, acumula a soma total (`v_total`) e conta os registros (`v_contador`).

**Estatística calculada:** Soma do faturamento total por dimensão (produto/cliente/categoria/canal) no período, com ranking decrescente. Ao final, exibe o total acumulado de todos os registros e a contagem.

**Por que é relevante:** Permite responder perguntas como "quais são os 10 produtos que mais faturaram no Q1?" ou "qual cliente gerou mais receita no último mestre?" com uma única chamada SQL parametrizada, sem criar views ou queries separadas para cada dimensão.

**Tabelas e colunas usadas:**
- `financeiro.fato_venda` — `valor_total`, `fk_produto`, `fk_cliente`, `fk_canal_venda`, `fk_tempo`
- `geral.dim_tempo` — `data` (filtro de período), `id_tempo`
- `administrativo.dim_produtos` — `nome_produto` (quando dimensão = produto)
- `administrativo.dim_clientes` — `nome` (quando dimensão = cliente)
- `administrativo.dim_categoria_produto` — `categoria` (quando dimensão = categoria)
- `administrativo.dim_canal_venda` — `canal_venda` (quando dimensão = canal)

**Execução:** `CALL financeiro.analisar_vendas_dinamico('2024-01-01', '2024-12-31', 'produto', 10);`

---

## 9. Triggers

### Trigger 1 — Auditoria de Vendas

**Quando é disparado:** Após qualquer INSERT, UPDATE ou DELETE na tabela `financeiro.fato_venda`.

**Função associada:** `financeiro.auditar_vendas()`

**Ação automática:**
- Em INSERT: registra o novo valor e o usuário na tabela `financeiro.auditoria_vendas`
- Em UPDATE: registra o valor anterior e o novo valor, além do usuário
- Em DELETE: registra o valor anterior que foi removido

**Tabela de log:** `financeiro.auditoria_vendas` contém: `id_auditoria`, `id_venda`, `acao` (INSERT/UPDATE/DELETE), `usuario`, `data_hora`, `valor_anterior`, `valor_novo`.

**Benefício:** Rastreabilidade completa de todas as alterações financeiras. Qualquer venda criada, modificada ou removida fica registrada com o usuário responsável e os valores envolvidos. Isso atende requisitos de auditoria e conformidade.

---

### Trigger 2 — Atualização Automática de Saldo de Estoque

**Quando é disparado:** ANTES de cada INSERT em `estoque.fato_movimentacao_estoque`.

**Função associada:** `estoque.atualizar_saldo_estoque()`

**Ação automática:**
1. Busca o saldo atual mais recente do produto (`MAX(saldo_atual)` da tabela de movimentações)
2. Consulta a natureza do tipo de movimentação (ENTRADA ou SAÍDA)
3. Calcula o novo saldo: saldo anterior + quantidade (ENTRADA) ou − quantidade (SAÍDA)
4. Preenche automaticamente os campos `saldo_anterior` e `saldo_atual` do registro que está sendo inserido
5. Se o saldo calculado ficar negativo, lança exceção e bloqueia a inserção

**Benefício:** Garante a integridade do saldo de estoque a nível de banco de dados. Mesmo que o código da aplicação tente inserir uma movimentação com saldo errado ou negativo, o banco rejeita. O `saldo_anterior` e `saldo_atual` sempre refletem o histórico correto, tornando possível reconstruir a posição do estoque em qualquer momento histórico.

**Nota:** O código Python em `criar_movimentacao()` também calcula o saldo antes de inserir e valida se ficará negativo, retornando HTTP 422 para o frontend. O trigger funciona como segunda linha de defesa a nível de banco, garantindo consistência mesmo em acessos diretos ao banco que bypassed a API.

---

## 10. Sobre as Materialized Views

### O que foram criadas
Quatro Materialized Views (cubos OLAP) foram definidas em `sql/banco/views.sql`:
- `financeiro.cubo_vendas` — cubo completo de vendas com GROUP BY ROLLUP em todas as dimensões
- `estoque.cubo_estoque` — cubo de movimentações de estoque com rollup
- `financeiro.cubo_dre` — cubo de transações financeiras com resultado (receitas - despesas)
- `estoque.cubo_frete` — cubo de fretes com métricas de performance logística

Cada cubo usa `GROUP BY ROLLUP(...)`, que gera subtotais automáticos em todas as combinações de dimensões — técnica padrão de data warehouse para suportar drill-down e drill-up de análises.

### Por que não estão sendo usadas
As queries nos arquivos SQL do backend (`inicio.sql`, `financeiro.sql`, `estoque.sql`, `analytics.sql`, `administrativo.sql`) consultam diretamente as tabelas fato e dimensão, **sem referenciar as materialized views**.

### Impacto disso
As materialized views existem no banco mas são subutilizadas. A rota `POST /api/admin/atualizar-cubos` chama a procedure `atualizar_cubos_olap()` que executa `REFRESH MATERIALIZED VIEW CONCURRENTLY` em cada cubo, mas como as queries de analytics não leem dessas views, o refresh tem efeito prático zero sobre o frontend.

**O que mudaria se fossem usadas:** Queries de analytics poderiam ser reescritas para ler dos cubos (pré-agregados), reduzindo o custo computacional de queries complexas. Em bases muito grandes, a diferença de performance seria significativa. Para o volume atual do projeto, não há impacto real nos resultados — todos os dados exibidos estão corretos porque as queries nas tabelas fato retornam os mesmos valores que os cubos retornariam.

**Conclusão:** A modelagem é tecnicamente correta e demonstra conhecimento de arquitetura OLAP. O produto entregado ao usuário é correto — os dados exibidos no frontend são precisos porque as queries nas tabelas fato retornam os mesmos valores que os cubos retornariam. A lacuna é que as views não estão sendo lidas pelas queries de analytics: seria necessário refatorar os SQLs para consultarem os cubos, ou remover os cubos e a rota de atualização, que são atualmente código morto no contexto do que o frontend consome.

---

## 11. Contrato Backend × Frontend

### O que funciona corretamente
A grande maioria dos endpoints está com contrato perfeito. O arquivo `frontend/src/api.js` mapeia cada função JavaScript para exatamente a rota correspondente no backend. Os CRUDs completos (clientes, produtos, fornecedores, canais, transações, fretes, transportadoras) estão funcionando com os campos corretos. Os módulos de Início, Administrativo, Financeiro e Estoque estão com contrato correto.

### Sobre o módulo de Estatísticas
O componente `ScreenEstatisticas.jsx` existe no código como tela completa (ANOVA, Shapiro-Wilk, regressão linear, IC 95%, correlação de Pearson, descritivas por produto), mas **não está registrado na navegação principal** — a navegação do `App.jsx` contém apenas Início, Administrativo, Financeiro e Estoque.

As análises estatísticas são exibidas de forma integrada nos dashboards dos módulos correspondentes:
- **Início:** tendência de faturamento via regressão linear e distribuição de vendas via Shapiro-Wilk
- **Financeiro:** ANOVA trimestral, intervalo de confiança de 95% da receita mensal e strip de previsão ML — todos inline no card do gráfico de Receita vs Despesa
- **Estoque:** correlação de Pearson entre entradas e saídas — inline no card de Movimentações

Essa abordagem é mais eficaz do ponto de vista de UX: o resultado estatístico aparece contextualizado ao dado que analisa, em vez de numa tela separada que exigiria navegação adicional.

---

## 12. Como os Dados Chegam ao Frontend

### Fluxo completo de um KPI
1. Usuário acessa a tela → componente React chama `useApi(() => api.inicio.kpis())`
2. `useApi` é um hook customizado que faz fetch, gerencia loading/error e retorna o data
3. `api.inicio.kpis()` faz GET para `/api/inicio/kpis`
4. FastAPI roteia para `inicio.router → analytics.get_kpis()`
5. `get_kpis()` chama `executar_query("inicio:total_faturamento", params)`
6. O query_executor lê o SQL correspondente do arquivo `inicio.sql`, executa via psycopg2
7. O resultado retorna como lista de dicionários Python
8. `analytics.py` formata: converte Decimal para float, None para 0.0, etc.
9. FastAPI serializa para JSON e retorna ao frontend
10. O componente React recebe o objeto e renderiza os valores formatados com `fmt.brl()` (R$ com separadores)

### Filtros de período
Quase todos os endpoints aceitam `?ano=&mes=` opcionais. A query SQL usa o padrão `WHERE (%s IS NULL OR t.ano = %s) AND (%s IS NULL OR t.mes = %s)`, onde o mesmo valor é passado duas vezes por parâmetro: o primeiro é o valor para comparar com NULL, o segundo é o valor real do filtro. Quando o frontend não envia filtros, ambos parâmetros chegam como None/null, e a condição `NULL IS NULL` é verdadeira, retornando todos os períodos.

### Paginação
Endpoints de listagem (clientes, produtos, transações, etc.) usam LIMIT/OFFSET. O frontend passa `page` e `page_size`, o analytics.py calcula `offset = (page - 1) * page_size`. O backend retorna `{ data: [...], total: N, page: P, page_size: S }` — o total permite ao frontend calcular o número de páginas.

---

## 13. Verificação Geral — O que está correto e o que precisa atenção

### Está correto
- Toda a modelagem dimensional do banco está correta e bem indexada
- Todos os 6 módulos de rotas estão registrados no `main.py`
- O CORS está configurado para permitir requisições do frontend
- Todos os CRUDs têm tratamento de erro com HTTP 404 para registro não encontrado e HTTP 409 para conflito de chave estrangeira
- O cálculo do score de saúde da empresa usa pesos coerentes e fórmulas corretas
- O módulo de ML segue boas práticas: StandardScaler separado para X e Y, TimeSeriesSplit sem data leakage, early stopping
- Os dois triggers cumprem exatamente o que foi pedido
- A stored procedure usa cursor REFCURSOR e query dinâmica, cumprindo o requisito do professor
- As queries SQL não têm SQL injection (usam parâmetros posicionais `%s`)

### Requer atenção
- **Materialized Views**: estão criadas mas as queries de analytics não as utilizam — são código morto; a rota `POST /api/admin/atualizar-cubos` existe e funciona mas não tem efeito visível no frontend porque nenhuma query de analytics lê dos cubos
- **Procedure duplicada**: `atualizar_cubos_olap()` está definida tanto em `procedure.sql` quanto em `views.sql`, o que causará erro se os dois arquivos forem executados em sequência; executar apenas `procedure.sql` resolve

### Itens corrigidos durante o desenvolvimento
- **DRE (Financeiro):** foi reescrito para usar exclusivamente dados reais da tabela `fato_transacao_financeira`. As linhas anteriores (impostos, CMV, devoluções) usavam percentuais fixos hardcodados e foram removidas. O DRE atual exibe: receita (créditos confirmados/pagos), despesas (débitos confirmados/pagos), resultado líquido e, quando presente, o valor de transações ainda a receber (Previstas).
- **Score de Saúde — fallback removido:** quando o backend não retorna componentes de saúde para o período, o frontend exibia valores fixos (88, 71, 64, 92, 75) como se fossem dados reais. Esse fallback foi substituído por mensagem de ausência de dados.
- **Filtros de data nos CRUDs:** os inputs "De / Até" existiam nos módulos Financeiro (Transações) e Estoque (Movimentações) mas não filtravam nada — o estado `dateFilter` nunca era aplicado ao array de registros. Foram conectados ao `useMemo` de filtragem.
- **"A receber" e "A pagar" (Financeiro):** os itens de menu e os formulários correspondentes foram removidos do frontend. As rotas `/api/financeiro/a-receber` e `/api/financeiro/a-pagar` continuam disponíveis no backend mas não há tabelas dedicadas para essas entidades — as chamadas retornavam HTTP 500 em produção.
- **Botão "Exportar":** presente nos CRUDs de Financeiro e Estoque sem nenhum handler associado — foi removido.
