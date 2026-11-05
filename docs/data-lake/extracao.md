# Extração para a camada Bronze

Script que extrai as tabelas do Postgres (Azure) e a coleção de logs técnicos do Cosmos DB e grava cada uma como um arquivo Parquet na camada `bronze` do Data Lake.

## Onde está

`scripts/datalake/extrair_bronze.py`

## Como rodar

1. Instalar as dependências extras do script (as dependências do backend já cobrem `pandas`, `psycopg2-binary`, `pymongo` e `python-dotenv` — o script reaproveita a conexão do backend):
   ```bash
   pip install -r scripts/datalake/requirements.txt
   ```
2. Garantir que o `backend/.env` tem preenchidas as variáveis de conexão do Postgres, do Cosmos DB (`COSMOS_MONGO_CONNECTION_STRING`) e do Data Lake (`DATALAKE_CONNECTION_STRING` — pega no Portal Azure, na storage account, em "Chaves de acesso").
3. Rodar a partir da pasta `backend` (é de lá que o `.env` é carregado):
   ```bash
   cd backend
   python ../scripts/datalake/extrair_bronze.py
   ```

## O que o script faz

- Lê cada tabela fato/dimensão do Postgres inteira (`SELECT *`) e converte para Parquet.
- Lê a coleção `logs_tecnicos` do Cosmos DB e converte para Parquet.
- Sobe cada arquivo no container `bronze`, em:
  - `postgres/<schema>/<tabela>/<tabela>_<timestamp>.parquet`
  - `cosmos/<coleção>/<coleção>_<timestamp>.parquet`
- Cada execução gera um novo arquivo com timestamp — nunca sobrescreve uma extração anterior, seguindo a regra de imutabilidade da camada bronze (ver `docs/data-lake/bronze.md`).

## Frequência esperada

Não há agendamento automático ainda (isso entraria com o Synapse/Data Factory na fase seguinte do projeto). Por enquanto, o script é rodado manualmente sempre que se quiser um novo snapshot dos dados — por exemplo, depois de uma carga de dados relevante no Postgres, ou antes de uma entrega que dependa de um snapshot atualizado no Data Lake.
