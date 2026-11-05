# Conecta Beauty v3: arquitetura na Azure

Na versão 3, os dados do Conecta Beauty (JN Móveis) saíram do computador da equipe e passaram a ficar na Azure, disponíveis o tempo todo para o sistema (ERP), para o Power BI e para os notebooks do Google Colab. Além de hospedar o banco, a v3 organiza o caminho dos dados em **camadas**, do dado cru que chega dos canais de venda até o indicador pronto para a gestão.

## 1. Visão geral

```
                         CANAIS EXTERNOS                          ERP (frontend + API)
            Instagram · Facebook · Marketplace · Mercado Livre    Loja Física · WhatsApp · ...
                                │ .jsonl (um formato por canal)           │ cadastros e vendas
                                ▼                                         ▼
 ┌──────────────── DATA LAKE (Azure Data Lake Storage Gen2) ───────┐   ┌──────────────────────────┐
 │                                                                 │   │  POSTGRES (Azure Database │
 │  BRONZE  dado cru, como chegou                                  │   │  for PostgreSQL)          │
 │    gerados_por_script/*.jsonl ──┬──────────────────────────┐    │   │  = DATA WAREHOUSE         │
 │    postgres/... e cosmos/...    │ (cópias de segurança) ◄───┼────┼───┤  fatos, dimensões,        │
 │                                 │                           │    │   │  cubos OLAP, ml.*         │
 │                 tratar_silver.py│              notebook Colab    │   └──────────┬───────────────┘
 │                                 ▼                           ▼    │              │
 │  SILVER  dado limpo e padronizado (Parquet)        COSMOS DB     │              │
 │    pedidos_canais_externos/pedidos e /itens        (NoSQL)       │              │
 │                                 │ carregar_dw.py ────────────────┼─────────────►│
 │                                 │                                │              │
 │  GOLD  resumos prontos (Parquet) ◄── gerar_gold.py ──────────────┼──────────────┤
 │    vendas/faturamento_mensal_canal, vendas_produto_mensal, ...   │              │
 └─────────────────────────────────────────────────────────────────┘              │
                                                                                  ▼
                                              Power BI (gestão) · frontend (operação) · ML
```

| Serviço Azure | Papel no projeto |
|---|---|
| **Azure Database for PostgreSQL** (Flexible Server) | banco do sistema e **Data Warehouse**: modelo estrela, cubos OLAP e resultados do ML |
| **Azure Cosmos DB for MongoDB** | banco **NoSQL**: pedidos dos canais no formato original de cada canal e logs técnicos da API |
| **Azure Data Lake Storage Gen2** | **Data Lake** com os containers `bronze`, `silver` e `gold` |
| **Azure Functions** | roda o pipeline automaticamente (todo dia e por um link) |

## 2. As camadas

### Bronze: o dado como chegou

**O que é:** arquivos guardados exatamente como vieram, sem nenhuma alteração. É a "fonte da verdade": se uma regra de tratamento mudar, dá para reprocessar tudo a partir daqui.

**O que tem:**

| Pasta | Conteúdo | Quem grava |
|---|---|---|
| `gerados_por_script/pedidos_canais_externos.jsonl` | pedidos dos 4 canais externos, um pedido por linha, cada canal com nomes de campo e estrutura diferentes (o Instagram não manda CPF, o Mercado Livre manda o frete dentro de `shipping`...) | `scripts/seed/gerar_pedidos_canais.py --enviar-bronze` |
| `postgres/<schema>/<tabela>/<tabela>_<data>.parquet` | cópia completa das tabelas do Postgres (fatos e dimensões) | `scripts/datalake/extrair_bronze.py` |
| `cosmos/logs_tecnicos/logs_tecnicos_<data>.parquet` | cópia dos logs técnicos da API | `scripts/datalake/extrair_bronze.py` |

**Regras:** nada é apagado nem alterado. As cópias do Postgres e do Cosmos ganham data e hora no nome e servem de **histórico e backup**: não são tratadas por nenhuma camada seguinte. O arquivo dos canais tem sempre o mesmo nome, e um envio novo substitui o anterior, porque a silver lê todos os `.jsonl` da pasta.

**Para que serve:** guardar o dado original para auditoria e reprocessamento, e ser o ponto de entrada dos canais externos.

### Silver: o dado limpo e padronizado

**O que é:** os pedidos dos canais externos tratados e num formato único, em **Parquet** (formato de tabela compacto e tipado).

**Quem grava:** `scripts/datalake/tratar_silver.py`, que lê o `.jsonl` do bronze e, para cada pedido:
1. descobre o canal pelo campo que identifica o pedido (`pedido_instagram_id`, `ml_order_id`...);
2. tira de cada formato os mesmos campos (cliente, cidade, estado, itens, valor, frete, pagamento, data);
3. limpa documentos e telefones (só dígitos), valida CPF/CNPJ pelos dígitos verificadores e padroniza textos;
4. remove pedidos repetidos (mesmo canal e mesmo número);
5. sinaliza problemas de qualidade em vez de "consertar" o dado (por exemplo, pedido sem itens).

**O que tem:**

| Arquivo | Uma linha por | Principais colunas |
|---|---|---|
| `pedidos_canais_externos/pedidos/pedidos_<data>.parquet` | pedido | canal, id do pedido no canal, cliente, cidade, estado, documento (validado), qtd. de itens, valor total, frete, forma de pagamento, data, alertas, arquivo e linha de origem |
| `pedidos_canais_externos/itens/itens_<data>.parquet` | item do pedido | canal, id do pedido, número do item, produto, quantidade, preço unitário, valor do item |

**Para que serve:** ser a base confiável para análise e para a carga no Data Warehouse. A silver ainda é arquivo: o dado só entra no banco na etapa seguinte.

### Data Warehouse (Postgres): o dado integrado

**O que é:** o banco relacional, em **modelo estrela**: tabelas **fato** (os acontecimentos, como vendas, pedidos, fretes, movimentações e transações) ligadas a tabelas **dimensão** (quem, o quê, quando e onde: cliente, produto, canal, data, localização, forma de pagamento).

**Quem grava:**
- o **ERP** (frontend + API), em tempo real, nas vendas e cadastros do dia a dia;
- `scripts/datalake/carregar_dw.py`, que lê a silver e grava os pedidos dos canais em `fato_pedido` e `fato_venda`, criando o que faltar nas dimensões (canais, datas, clientes). Cada pedido carregado fica registrado em `financeiro.controle_carga_canais`, o que impede carregar o mesmo pedido duas vezes e permite desfazer a carga.

**O que tem além das tabelas:**
- **Cubos OLAP** (views materializadas: `cubo_vendas`, `cubo_dre`, `cubo_estoque`, `cubo_frete`): resumos pré-calculados, atualizados pelo pipeline;
- **ML**: a view `ml.pedidos_padronizados` (um pedido por linha, base do K-Means) e a tabela `ml.segmento_pedido` (o segmento de cada pedido);
- **Triggers**: auditoria das vendas e controle de saldo do estoque.

**Para que serve:** juntar num lugar só os dados do ERP e dos canais externos. O frontend lê as tabelas fato em tempo real; o Power BI e o ML leem daqui.

### Gold: o dado pronto para consumo

**O que é:** resumos de negócio já calculados, em Parquet, prontos para quem só quer consultar.

**Quem grava:** `scripts/datalake/gerar_gold.py`, que consulta o Data Warehouse.

**O que tem:**

| Conjunto | Responde | Uma linha por |
|---|---|---|
| `vendas/faturamento_mensal_canal` | quanto vendemos por canal, mês a mês? | ano, mês e canal |
| `vendas/vendas_produto_mensal` | quais produtos e categorias mais vendem? | ano, mês e produto |
| `vendas/vendas_regiao_mensal` | de onde vem a venda? | ano, mês, região e estado |

Cada execução grava um arquivo novo com data e hora, então a gold guarda o **histórico dos indicadores** (como os números estavam em cada carga).

**Para que serve:** ser a camada de consumo da gestão. O Power BI (conector Azure Data Lake Storage Gen2) ou um analista leem um arquivo pequeno e pronto, sem pesar o banco do sistema.

### Cosmos DB: o caminho NoSQL

O mesmo `.jsonl` do bronze também segue para o **Cosmos DB**, pelo notebook `notebooks/crud_cosmos_datalake.ipynb` (disciplina de Banco de Dados II). Ali o pedido é gravado **com a estrutura original do canal** e um bloco `padronizado` com os campos comuns, o que justifica o uso de NoSQL: cada canal manda um formato, e o documento aceita todos. O notebook faz o CRUD completo e rotinas automatizadas (qualidade, remoção de duplicados, retenção de logs, relatório).

A coleção `logs_tecnicos` é alimentada pela API do Conecta Beauty, que grava cada requisição e cada erro.

| | Cosmos DB | Silver → Data Warehouse |
|---|---|---|
| Formato | documento original + bloco padronizado | tabela plana (pedidos e itens) |
| Uso | operacional: CRUD, consultas por canal | analítico: cubos, ML, Power BI |

## 3. Como as camadas se conectam

### O pipeline

`scripts/datalake/pipeline.py` executa as etapas em ordem e para na primeira que falhar (as seguintes dependem dela):

```
1. bronze -> silver   tratar_silver.py
2. silver -> DW       carregar_dw.py --executar --atualizar-cubos
3. DW     -> gold     gerar_gold.py
4. treino do ML       K-Means (grava ml.segmento_pedido) e MLP de previsão   (com --treinar-ml)
```

```bash
python scripts/datalake/pipeline.py                         # simulação: não altera o DW
python scripts/datalake/pipeline.py --executar --treinar-ml # carga de verdade
```

Rodar de novo não duplica nada: a carga só grava os pedidos que ainda não estão no Data Warehouse. A cópia de segurança das tabelas para o bronze (`extrair_bronze.py`) roda separada, quando se quiser um novo snapshot.

### Automação: Azure Function

A Function App (`function_app.py`) roda o mesmo pipeline na nuvem, sem ninguém com o computador ligado:
- **todo dia às 03:00** (horário de Brasília);
- **por um link** (gatilho HTTP), para rodar na hora.

As credenciais ficam nas configurações da Function App, e os logs no Application Insights. Passo a passo em `docs/infra/function_app.md`.

### Credenciais e segurança

| Conexão | Como autentica | Onde fica a credencial |
|---|---|---|
| scripts e API → Postgres | usuário e senha, **SSL obrigatório** | `backend/.env` (local) ou configurações da Function App |
| scripts → Data Lake | connection string da conta de armazenamento | `DATALAKE_CONNECTION_STRING` no `.env` |
| notebook Colab → Data Lake | **token SAS** só de leitura, com validade | Secrets do Colab |
| notebook e API → Cosmos DB | connection string | `COSMOS_MONGO_CONNECTION_STRING` (`.env` ou Secrets do Colab) |
| Power BI → Postgres | usuário e senha | no próprio Power BI |

Nenhuma credencial fica no código. O **firewall** do Postgres só aceita os IPs liberados (equipe, Power BI) e os serviços da Azure. O do Data Lake segue o que foi configurado para a Function (ver `docs/infra/function_app.md`); mesmo aberto, todo acesso exige a chave ou o SAS. A conexão com o Postgres tem timeout de 10 segundos: se o IP não estiver liberado, o erro aparece logo, em vez de travar.

## 4. Quem consome o quê

| Consumidor | Lê de | Para quê |
|---|---|---|
| **Frontend (ERP)** | Postgres, tabelas fato, via API | operação do dia a dia, em tempo real; telas de ML ao vivo (treinar, prever, segmentar) |
| **Power BI** | Postgres (fatos, dimensões, `ml.segmento_pedido`) e gold | visão de gestão: histórico, canais, produtos, regiões, segmentos |
| **Modelos de ML** | Postgres (`ml.pedidos_padronizados` e faturamento mensal) | previsão de faturamento (MLP) e segmentação de pedidos (K-Means) |
| **Notebook Colab** | bronze → Cosmos DB | CRUD NoSQL e rotinas automatizadas |

## 5. Próximos passos

- Gatilho da Function por **arquivo novo no bronze** (hoje: horário e link).
- Tabela `ml.previsao_faturamento` para a previsão do MLP aparecer no Power BI.
- Gold com um arquivo `_atual` por conjunto, para o Power BI não somar versões antigas.
- Criar na dimensão de localização as cidades dos canais que informam estado (Marketplace e Mercado Livre).
- Procedure `atualizar_cubos_olap()` com índices únicos, para atualizar os cubos sem bloquear leituras.
