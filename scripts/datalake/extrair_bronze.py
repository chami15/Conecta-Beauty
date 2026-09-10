"""
Extrai as tabelas fato/dimensao do Postgres (Azure) e os logs tecnicos do
Cosmos DB, e joga cada um como um arquivo Parquet na camada bronze do
Data Lake (ADLS Gen2) - dado bruto, sem nenhum tratamento.

Cada execucao cria um novo arquivo com timestamp (nunca sobrescreve um
snapshot anterior), seguindo a regra de imutabilidade da camada bronze
(ver docs/data-lake/bronze.md).

Estrutura de caminhos gerada no container "bronze":
    postgres/<schema>/<tabela>/<tabela>_<timestamp>.parquet
    cosmos/<colecao>/<colecao>_<timestamp>.parquet

Uso:
    cd backend && python ../scripts/datalake/extrair_bronze.py
"""
import os
import sys
from datetime import datetime, timezone
from io import BytesIO

import pandas as pd
from azure.storage.filedatalake import DataLakeServiceClient
from dotenv import load_dotenv
from pymongo import MongoClient

sys.path.insert(0, os.path.join(os.path.dirname(__file__), "..", "..", "backend"))

from utils.db import Database

load_dotenv()

BRONZE_CONTAINER = "bronze"

TABELAS_POSTGRES = [
    ("geral", "dim_tempo"),
    ("geral", "dim_localizacao"),
    ("administrativo", "dim_canal_venda"),
    ("administrativo", "dim_clientes"),
    ("administrativo", "dim_categoria_produto"),
    ("administrativo", "dim_fornecedor"),
    ("administrativo", "dim_produtos"),
    ("financeiro", "dim_forma_pagamento"),
    ("financeiro", "fato_pedido"),
    ("financeiro", "fato_venda"),
    ("financeiro", "fato_transacao_financeira"),
    ("financeiro", "auditoria_vendas"),
    ("estoque", "dim_transportadora"),
    ("estoque", "dim_tipo_movimentacao"),
    ("estoque", "fato_movimentacao_estoque"),
    ("estoque", "fato_pedido_frete"),
]

COLECOES_COSMOS = ["logs_tecnicos"]


def _timestamp() -> str:
    return datetime.now(timezone.utc).strftime("%Y%m%dT%H%M%SZ")


def _cliente_datalake() -> DataLakeServiceClient:
    connection_string = os.getenv("DATALAKE_CONNECTION_STRING")
    if not connection_string:
        raise RuntimeError("DATALAKE_CONNECTION_STRING nao configurada no .env")
    return DataLakeServiceClient.from_connection_string(connection_string)


def _upload_parquet(container_client, caminho: str, df: pd.DataFrame):
    buffer = BytesIO()
    df.to_parquet(buffer, engine="pyarrow", index=False)
    buffer.seek(0)
    dados = buffer.read()

    file_client = container_client.get_file_client(caminho)
    file_client.create_file()
    file_client.append_data(dados, offset=0, length=len(dados))
    file_client.flush_data(len(dados))
    print(f"  OK: {caminho} ({len(dados) / 1024:.1f} KB, {len(df)} linhas)")


def extrair_postgres(container_client, ts: str):
    print("Extraindo tabelas do Postgres...")
    with Database() as db:
        conn = db.get_conn()
        for schema, tabela in TABELAS_POSTGRES:
            df = pd.read_sql(f"SELECT * FROM {schema}.{tabela}", conn)
            caminho = f"postgres/{schema}/{tabela}/{tabela}_{ts}.parquet"
            _upload_parquet(container_client, caminho, df)


def extrair_cosmos(container_client, ts: str):
    connection_string = os.getenv("COSMOS_MONGO_CONNECTION_STRING")
    if not connection_string:
        print("COSMOS_MONGO_CONNECTION_STRING nao configurada - pulando extracao do Cosmos.")
        return

    print("Extraindo colecoes do Cosmos DB...")
    client = MongoClient(connection_string, serverSelectionTimeoutMS=5000)
    banco = client["conectabeauty"]
    try:
        for colecao in COLECOES_COSMOS:
            documentos = list(banco[colecao].find({}))
            if not documentos:
                print(f"  {colecao}: sem documentos, pulando.")
                continue
            for doc in documentos:
                doc["_id"] = str(doc["_id"])
            df = pd.json_normalize(documentos)
            caminho = f"cosmos/{colecao}/{colecao}_{ts}.parquet"
            _upload_parquet(container_client, caminho, df)
    finally:
        client.close()


def main():
    ts = _timestamp()
    servico = _cliente_datalake()
    container_client = servico.get_file_system_client(BRONZE_CONTAINER)

    extrair_postgres(container_client, ts)
    extrair_cosmos(container_client, ts)

    print(f"\nExtracao concluida (timestamp {ts}).")


if __name__ == "__main__":
    main()
