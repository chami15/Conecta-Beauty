"""
Le o arquivo .jsonl gerado por gerar_pedidos_canais.py e insere os documentos
na colecao `pedidos_canais_externos` do Cosmos DB (API para MongoDB, RU-based).

Insere em lotes para nao estourar o limite de RU/s do free tier.

Uso:
    export COSMOS_MONGO_CONNECTION_STRING="mongodb://..."
    python carregar_pedidos_cosmos.py --arquivo output/pedidos_canais_externos.jsonl
"""
import argparse
import json
import os
import time

from pymongo import MongoClient

TAMANHO_LOTE = 200
PAUSA_ENTRE_LOTES_SEGUNDOS = 1.0


def carregar_documentos(caminho: str) -> list[dict]:
    with open(caminho, encoding="utf-8") as f:
        return [json.loads(linha) for linha in f if linha.strip()]


def inserir_em_lotes(colecao, documentos: list[dict]):
    total = len(documentos)
    for inicio in range(0, total, TAMANHO_LOTE):
        lote = documentos[inicio: inicio + TAMANHO_LOTE]
        colecao.insert_many(lote)
        print(f"  {min(inicio + TAMANHO_LOTE, total)}/{total} inseridos")
        if inicio + TAMANHO_LOTE < total:
            time.sleep(PAUSA_ENTRE_LOTES_SEGUNDOS)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "--arquivo",
        default=os.path.join(os.path.dirname(__file__), "output", "pedidos_canais_externos.jsonl"),
    )
    parser.add_argument("--banco", default="conectabeauty")
    parser.add_argument("--colecao", default="pedidos_canais_externos")
    args = parser.parse_args()

    connection_string = os.environ.get("COSMOS_MONGO_CONNECTION_STRING")
    if not connection_string:
        raise SystemExit(
            "Defina a variavel de ambiente COSMOS_MONGO_CONNECTION_STRING "
            "(pegue no portal Azure: Cosmos DB > Cadeias de conexao)."
        )

    documentos = carregar_documentos(args.arquivo)
    print(f"Lidos {len(documentos)} documentos de {args.arquivo}")

    client = MongoClient(connection_string)
    colecao = client[args.banco][args.colecao]

    inserir_em_lotes(colecao, documentos)
    print(f"OK: {colecao.count_documents({})} documentos agora em {args.banco}.{args.colecao}")


if __name__ == "__main__":
    main()
