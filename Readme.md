# PI - Conecta Beauty
## Integrantes

| Bernardo Cunha Tassini | 2041382511011 |
| Nathan Ferreira Alexandre Lima | 2041382511027 |
| Samuel Passoni da Silva | 2041382511034 |
| Vitor Augusto Alexandre Vieira | 2041382511029 |

--- 

## Para acessar o data warehouse
A criação das tabelas e das views materializadas estão no caminho backend/sql/banco, e estão dividios em 4 schemas: `financeiro`, `estoque`, `administrativo` e `geral`.

## Para visualizar o banco em diagrama
Pegue o arquivo que esta em docs, chamado conecta_beauty e suba para o drawio

---

## Requisitos funcionais

### Stored Procedures
- 1. **analisar_vendas_dinamico**
 A procedure analisar_vendas_dinamico foi criada com os parametros data_inicio, data_fim, dimensao e top, sendo chamada assim `CALL financeiro.analisar_vendas_dinamico(data_inicio, data_fim, dimensao, top)`. Foi feita com um cursor não vinculado (REFCURSOR) + query dinâmica que calcula o faturamento total por dimensão, sendo elas: `produto`, `cliente`, `categoria` ou `canal` e gera um ranking com a quantidade de itens que o parametro `top` recebeu.

**Estatística calculada:** soma de `valor_total` de `fato_venda`, agrupada pela dimensão escolhida, ordenada de forma decrescente e limitada ao `top` N — produzindo um ranking de faturamento por produto, cliente, categoria ou canal de venda.

| Dimensão | Tabelas no Cursor | Colunas utilizadas |
|----------|-------------------|--------------------|
| `produto` | `fato_venda` + `dim_produtos` + `dim_tempo` | `fk_produto`, `valor_total`, `nome_produto`, `data` |
| `cliente` | `fato_venda` + `dim_clientes` + `dim_tempo` | `fk_cliente`, `valor_total`, `nome`, `data` |
| `categoria` | `fato_venda` + `dim_produtos` + `dim_categoria_produto` + `dim_tempo` | `fk_produto`, `valor_total`, `id_categoria`, `categoria`, `data` |
| `canal` | `fato_venda` + `dim_canal_venda` + `dim_tempo` | `fk_canal_venda`, `valor_total`, `canal_venda`, `data` |

> **Relevância:** Identifica produtos mais vendidos, clientes mais lucrativos e canais mais eficientes em qualquer recorte de período.

- 2. **atualizar_cubos_olap**
Foi criado com o objetivo de atualizar as 4 Materialized Views: `cubo_vendas`, `cubo_estoque`, `cubo_dre` e `cubo_frete`, executando `REFRESH MATERIALIZED VIEW CONCURRENTLY` em cada uma, na ordem correta, sem bloquear leituras simultâneas.

> **Relevância:** As Materialized Views são a camada OLAP do projeto — sem atualização periódica, os cubos ficam com dados desatualizados. A procedure centraliza esse refresh em uma única chamada, garantindo consistência entre todos os cubos e simplificando a manutenção operacional.

---

### Triggers
- 1. `trg_auditoria_vendas (AFTER INSERT OR UPDATE OR DELETE)`

**Situação de disparo:** ativado automaticamente após qualquer `INSERT`, `UPDATE` ou `DELETE` na tabela `financeiro.fato_venda`.

**Ação automática:** insere um registro na tabela `financeiro.auditoria_vendas` com as colunas: `id_venda`, `acao` (INSERT/UPDATE/DELETE), `usuario` (usuário PostgreSQL ativo), `data_hora` (timestamp automático), `valor_anterior` e `valor_novo` — ambos mapeados da coluna `valor_total` de `fato_venda`.

> **Benefício:** Rastreabilidade completa de todas as alterações financeiras, segurança contra fraude e compliance — qualquer modificação no faturamento fica registrada com usuário, horário e os valores antes e depois da operação.

- 2. `trg_atualizar_saldo (BEFORE INSERT)`

**Situação de disparo:** ativado automaticamente antes de cada `INSERT` na tabela `estoque.fato_movimentacao_estoque`.

**Ação automática:** consulta o `saldo_atual` mais recente do produto via `fk_produto`, obtém a natureza da movimentação (`ENTRADA` ou `SAÍDA`) a partir de `dim_tipo_movimentacao.natureza`, preenche automaticamente as colunas `saldo_anterior` e `saldo_atual` da nova linha, e **lança exceção bloqueando a operação** caso `saldo_atual` resultante seja negativo.

> **Benefício:** Integridade total dos dados de estoque — o saldo é sempre calculado automaticamente sem depender da aplicação, e saídas que causariam estoque negativo são rejeitadas na camada do banco, prevenindo ruptura de produtos e inconsistências operacionais.

---

## Materialized Views (Cubos OLAP)

| Cubo | Esquema | Métricas Principais |
|------|---------|---------------------|
| `cubo_vendas` | financeiro | Faturamento, ticket médio, itens por pedido |
| `cubo_estoque` | estoque | Entradas/saídas, giro de estoque, custo médio |
| `cubo_dre` | financeiro | Receitas, despesas, margem de resultado |
| `cubo_frete` | estoque | Frete médio, taxa de avaria, custo por kg |

---

# **Para replicar o projeto**

### Pré-requisitos
- Python 3.12+
- Node.js 18+
- PostgreSQL 15

### Banco de dados
Crie um banco PostgreSQL e execute os arquivos na ordem abaixo:

```
backend/sql/banco/tabelas.sql
backend/sql/banco/views.sql
backend/sql/banco/trigger.sql
backend/sql/banco/procedure.sql
```

### Variáveis de ambiente
Copie o arquivo de exemplo e preencha com as credenciais do banco:

```bash
cd backend
cp .env.example .env
```

### Backend
```bash
cd backend
pip install -r requirements.txt
uvicorn main:app --reload
```

### Frontend
```bash
cd frontend
npm i
npm run conecta
```

### Treinar o modelo de ML
Com o backend rodando, execute uma requisição para treinar o modelo:

```bash
curl -X POST http://localhost:8000/api/ml/treinar
```

**ou** rode o modelo antes de iniciar

```bash
cd backend/app/ml && python treinar.py

```

### Rodar os testes de infraestrutura
Com o backend e o frontend rodando em terminas separado, execute:

```bash
cd backend
python tests/run_all.py
```