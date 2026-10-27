"""
Le os pedidos dos canais externos da camada bronze (.jsonl, um pedido por linha,
formato diferente em cada canal), trata e padroniza, e grava na camada silver
em Parquet:

    silver/pedidos_canais_externos/pedidos/pedidos_<timestamp>.parquet   (1 linha por pedido)
    silver/pedidos_canais_externos/itens/itens_<timestamp>.parquet       (1 linha por item)

Cada execucao gera um novo par de arquivos com timestamp. Pedido repetido no
bronze (mesmo canal e mesmo id) vira um so. Quem consome a silver: carregar_dw.py.

Uso (a partir da pasta backend, de onde o .env e carregado):
    cd backend && python ../scripts/datalake/tratar_silver.py
    python ../scripts/datalake/tratar_silver.py --bronze-local ../scripts/seed/output --silver-local /tmp/silver
"""
import argparse
import json
import os
import sys
from datetime import datetime, timezone
from io import BytesIO

import pandas as pd
from dotenv import load_dotenv

sys.path.insert(0, os.path.dirname(__file__))

from lago import abrir
from tratamento import COLUNAS_ITENS, COLUNAS_PEDIDOS, tratar_pedido

load_dotenv()

PASTA_BRONZE = "gerados_por_script"
PASTA_SILVER = "pedidos_canais_externos"


def _parquet(df: pd.DataFrame) -> bytes:
    buffer = BytesIO()
    df.to_parquet(buffer, engine="pyarrow", index=False)
    return buffer.getvalue()


def tratar(bronze, pasta_bronze: str):
    """Percorre os .jsonl do bronze e devolve (pedidos, itens, contagens)."""
    contagens = {"linhas_lidas": 0, "json_invalido": 0, "canal_nao_identificado": 0,
                 "sem_id": 0, "repetidos": 0}
    processado_em = datetime.now(timezone.utc).isoformat()
    pedidos, itens, vistos = [], [], set()

    arquivos = bronze.listar(pasta_bronze, ".jsonl")
    if not arquivos:
        raise FileNotFoundError(f"Nenhum .jsonl encontrado em {pasta_bronze}")

    for arquivo in arquivos:
        texto = bronze.ler(arquivo).decode("utf-8")
        for numero_linha, linha in enumerate(texto.splitlines(), start=1):
            if not linha.strip():
                continue
            contagens["linhas_lidas"] += 1
            try:
                bruto = json.loads(linha)
            except json.JSONDecodeError:
                contagens["json_invalido"] += 1
                continue

            resultado = tratar_pedido(bruto) if isinstance(bruto, dict) else None
            if resultado is None:
                contagens["canal_nao_identificado"] += 1
                continue
            pedido, itens_pedido = resultado

            if not pedido["id_pedido_canal"] or pedido["id_pedido_canal"] == "None":
                contagens["sem_id"] += 1
                continue
            chave = (pedido["canal"], pedido["id_pedido_canal"])
            if chave in vistos:
                contagens["repetidos"] += 1
                continue
            vistos.add(chave)

            pedido.update(arquivo_origem=arquivo, linha_origem=numero_linha, processado_em=processado_em)
            pedidos.append(pedido)
            itens.extend(itens_pedido)

    return pedidos, itens, contagens


def main():
    parser = argparse.ArgumentParser(description="Bronze (jsonl dos canais) -> Silver (Parquet)")
    parser.add_argument("--bronze-local", help="pasta local com os .jsonl (em vez do container bronze)")
    parser.add_argument("--silver-local", help="pasta local de saida (em vez do container silver)")
    parser.add_argument("--pasta-bronze", default=os.getenv("DATALAKE_PASTA_BRONZE", PASTA_BRONZE),
                        help=f"pasta dentro do bronze (padrao: {PASTA_BRONZE})")
    args = parser.parse_args()

    bronze = abrir("bronze", args.bronze_local)
    silver = abrir("silver", args.silver_local)
    pasta_bronze = "" if args.bronze_local else args.pasta_bronze

    pedidos, itens, c = tratar(bronze, pasta_bronze)

    df_pedidos = pd.DataFrame(pedidos, columns=COLUNAS_PEDIDOS)
    df_itens = pd.DataFrame(itens, columns=COLUNAS_ITENS)

    ts = datetime.now(timezone.utc).strftime("%Y%m%dT%H%M%SZ")
    caminho_pedidos = f"{PASTA_SILVER}/pedidos/pedidos_{ts}.parquet"
    caminho_itens = f"{PASTA_SILVER}/itens/itens_{ts}.parquet"
    silver.gravar(caminho_pedidos, _parquet(df_pedidos))
    silver.gravar(caminho_itens, _parquet(df_itens))

    com_alerta = int((df_pedidos["alertas"] != "").sum())
    print("===== BRONZE -> SILVER =====")
    print(f"Linhas lidas no bronze:        {c['linhas_lidas']}")
    print(f"  JSON invalido (descartadas): {c['json_invalido']}")
    print(f"  Canal nao identificado:      {c['canal_nao_identificado']}")
    print(f"  Sem id de pedido:            {c['sem_id']}")
    print(f"  Repetidas (mesmo pedido):    {c['repetidos']}")
    print(f"Pedidos na silver:             {len(df_pedidos)} ({len(df_itens)} itens)")
    print(f"  Com alerta de qualidade:     {com_alerta}")
    for canal, qtd in df_pedidos["canal"].value_counts().items():
        print(f"  {canal:<15} {qtd}")
    print(f"Gravado: silver/{caminho_pedidos}")
    print(f"Gravado: silver/{caminho_itens}")


if __name__ == "__main__":
    main()
