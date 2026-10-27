"""
Gera a camada gold do Data Lake: agregados de vendas prontos pra BI, calculados
a partir das tabelas fato/dimensao do Data Warehouse (Postgres) e gravados em
Parquet. Cada conjunto responde a uma pergunta de negocio:

    faturamento_mensal_canal   quanto vendemos por canal, em cada mes?
    vendas_produto_mensal      quais produtos e categorias mais vendem, mes a mes?
    vendas_regiao_mensal       de onde vem a venda (regiao/estado), mes a mes?

Sao calculados direto das tabelas de fato (nao dos cubos OLAP), com LEFT JOIN
onde a informacao pode faltar: venda de cliente sem localizacao entra como
"Nao informada" em vez de sumir.

Cada execucao grava um arquivo novo com timestamp, em:
    gold/vendas/<conjunto>/<conjunto>_<timestamp>.parquet

Uso (a partir da pasta backend, de onde o .env e carregado):
    cd backend && python ../scripts/datalake/gerar_gold.py
    python ../scripts/datalake/gerar_gold.py --gold-local /tmp/gold     # sem rede
"""
import argparse
import os
import sys
from datetime import datetime, timezone
from io import BytesIO

import pandas as pd
from dotenv import load_dotenv

sys.path.insert(0, os.path.dirname(__file__))
sys.path.insert(0, os.path.join(os.path.dirname(__file__), "..", "..", "backend"))

from lago import abrir
from utils.connection import PostgreConn

load_dotenv()

PASTA_GOLD = "vendas"

CONJUNTOS = {
    "faturamento_mensal_canal": """
        SELECT t.ano, t.mes, t.nome_mes, cv.canal_venda, cv.tipo_canal,
               COUNT(DISTINCT v.numero_pedido)::int AS qtd_pedidos,
               SUM(v.quantidade)::int AS qtd_itens,
               SUM(v.valor_total)::float8 AS faturamento,
               (SUM(v.valor_total) / NULLIF(COUNT(DISTINCT v.numero_pedido), 0))::float8 AS ticket_medio
        FROM financeiro.fato_venda v
        JOIN geral.dim_tempo t ON t.id_tempo = v.fk_tempo
        JOIN administrativo.dim_canal_venda cv ON cv.id_canal_venda = v.fk_canal_venda
        GROUP BY t.ano, t.mes, t.nome_mes, cv.canal_venda, cv.tipo_canal
        ORDER BY t.ano, t.mes, cv.canal_venda
    """,
    "vendas_produto_mensal": """
        SELECT t.ano, t.mes, t.nome_mes, p.nome_produto AS produto,
               COALESCE(cat.categoria, 'Nao informada') AS categoria,
               SUM(v.quantidade)::int AS qtd_vendida,
               SUM(v.valor_total)::float8 AS faturamento
        FROM financeiro.fato_venda v
        JOIN geral.dim_tempo t ON t.id_tempo = v.fk_tempo
        JOIN administrativo.dim_produtos p ON p.id_produto = v.fk_produto
        LEFT JOIN administrativo.dim_categoria_produto cat ON cat.id_categoria = p.id_categoria
        GROUP BY t.ano, t.mes, t.nome_mes, p.nome_produto, cat.categoria
        ORDER BY t.ano, t.mes, p.nome_produto
    """,
    "vendas_regiao_mensal": """
        SELECT t.ano, t.mes, t.nome_mes,
               COALESCE(loc.regiao, 'Nao informada') AS regiao,
               COALESCE(loc.estado, 'NI') AS estado,
               COUNT(DISTINCT v.numero_pedido)::int AS qtd_pedidos,
               SUM(v.valor_total)::float8 AS faturamento
        FROM financeiro.fato_venda v
        JOIN geral.dim_tempo t ON t.id_tempo = v.fk_tempo
        JOIN administrativo.dim_clientes c ON c.id_cliente = v.fk_cliente
        LEFT JOIN geral.dim_localizacao loc ON loc.id_localizacao = c.fk_localizacao
        GROUP BY t.ano, t.mes, t.nome_mes, loc.regiao, loc.estado
        ORDER BY t.ano, t.mes, regiao, estado
    """,
}


def _parquet(df: pd.DataFrame) -> bytes:
    buffer = BytesIO()
    df.to_parquet(buffer, engine="pyarrow", index=False)
    return buffer.getvalue()


def main():
    parser = argparse.ArgumentParser(description="Data Warehouse (Postgres) -> Gold (Parquet)")
    parser.add_argument("--gold-local", help="pasta local de saida (em vez do container gold)")
    args = parser.parse_args()

    gold = abrir("gold", args.gold_local)
    conexao = PostgreConn().conn
    if conexao is None:
        raise RuntimeError("Nao foi possivel conectar ao Postgres (confira POSTGRES_* no backend/.env)")

    ts = datetime.now(timezone.utc).strftime("%Y%m%dT%H%M%SZ")
    print("===== DATA WAREHOUSE -> GOLD =====")
    try:
        cur = conexao.cursor()
        for nome, consulta in CONJUNTOS.items():
            cur.execute(consulta)
            df = pd.DataFrame(cur.fetchall(), columns=[c.name for c in cur.description])
            if df.empty:
                print(f"{nome}: sem dados, pulando.")
                continue
            caminho = f"{PASTA_GOLD}/{nome}/{nome}_{ts}.parquet"
            gold.gravar(caminho, _parquet(df))
            print(f"{nome}: {len(df)} linhas -> gold/{caminho}")
    finally:
        conexao.close()


if __name__ == "__main__":
    main()
