"""
Roda a cadeia inteira do Data Lake com um comando, na ordem:

    1. bronze -> silver   tratar_silver.py   (trata os .jsonl dos canais e grava Parquet)
    2. silver -> DW       carregar_dw.py     (fato_pedido/fato_venda no Postgres + cubos OLAP)
    3. DW     -> gold     gerar_gold.py      (resumos de vendas em Parquet para o Power BI)
    4. ML (opcional)      retreina o K-Means (grava ml.segmento_pedido) e o MLP de previsao

Cada etapa roda o proprio script, sem mudar nada nele, e o pipeline para na primeira
que falhar (as seguintes dependem dela). E o mesmo codigo que um agendador (ex.: Azure
Function com gatilho de horario ou de arquivo novo no bronze) vai chamar.

Por seguranca, sem --executar a carga no DW e so simulada e a gold e o ML nao rodam
(eles leem o DW, que nao mudou). A silver e gravada nos dois casos: cada execucao cria
um arquivo novo com timestamp e nunca apaga os anteriores.

Uso (de qualquer pasta; o .env e lido de backend/):
    python scripts/datalake/pipeline.py                                  # simulacao
    python scripts/datalake/pipeline.py --executar                       # carga de verdade
    python scripts/datalake/pipeline.py --executar --treinar-ml          # + retreina os modelos
    python scripts/datalake/pipeline.py --bronze-local ../seed/output --silver-local /tmp/silver \\
        --gold-local /tmp/gold --executar                                # sem Data Lake (teste)
"""
import argparse
import os
import subprocess
import sys
import time

PASTA_SCRIPTS = os.path.dirname(os.path.abspath(__file__))
PASTA_BACKEND = os.path.join(PASTA_SCRIPTS, "..", "..", "backend")

# Treino dos dois modelos pelo mesmo codigo da API (POST /api/ml/kmeans/treinar e /api/ml/treinar).
TREINO_ML = """
from app.ml.kmeans import treinar_kmeans_banco
from app.ml.treinar import treinar_modelo
k = treinar_kmeans_banco()
print(f"K-Means: {k['n_clusters']} grupos, silhouette {k['silhouette_score']}, {k['pedidos_gravados']} pedidos em ml.segmento_pedido")
for g in k["clusters"]:
    print(f"  {g['segmento']:<38} {g['quantidade_pedidos']:>6} pedidos  ticket medio R$ {g['ticket_medio']:,.2f}")
m = treinar_modelo()
print(f"MLP: {m['n_amostras']} meses, erro medio (MAE) R$ {m['mae_cv']:,.2f}")
"""


def script(nome, *args):
    return [sys.executable, os.path.join(PASTA_SCRIPTS, nome), *args]


def montar_etapas(args):
    local_silver = ["--silver-local", args.silver_local] if args.silver_local else []
    local_bronze = ["--bronze-local", args.bronze_local] if args.bronze_local else []
    local_gold = ["--gold-local", args.gold_local] if args.gold_local else []

    etapas = [("bronze -> silver", script("tratar_silver.py", *local_bronze, *local_silver))]
    if args.executar:
        etapas.append(("silver -> DW", script("carregar_dw.py", *local_silver, "--executar", "--atualizar-cubos")))
        etapas.append(("DW -> gold", script("gerar_gold.py", *local_gold)))
        if args.treinar_ml:
            etapas.append(("treino ML", [sys.executable, "-c", TREINO_ML]))
    else:
        etapas.append(("silver -> DW (simulacao)", script("carregar_dw.py", *local_silver)))
    return etapas


def main():
    parser = argparse.ArgumentParser(description="Pipeline do Data Lake: bronze -> silver -> DW -> gold")
    parser.add_argument("--executar", action="store_true", help="carrega o DW de verdade e gera a gold (sem isso, so simula)")
    parser.add_argument("--treinar-ml", action="store_true", help="retreina os modelos de ML ao final (exige --executar)")
    parser.add_argument("--bronze-local", help="pasta local com os .jsonl (em vez do container bronze)")
    parser.add_argument("--silver-local", help="pasta local da silver (em vez do container silver)")
    parser.add_argument("--gold-local", help="pasta local da gold (em vez do container gold)")
    args = parser.parse_args()
    if args.treinar_ml and not args.executar:
        parser.error("--treinar-ml exige --executar (sem carga, o DW nao muda)")
    # Caminhos locais relativos a pasta de onde o comando foi chamado (as etapas rodam em backend/).
    for campo in ("bronze_local", "silver_local", "gold_local"):
        if getattr(args, campo):
            setattr(args, campo, os.path.abspath(getattr(args, campo)))

    etapas = montar_etapas(args)
    resumo = []
    inicio_total = time.time()
    for numero, (nome, comando) in enumerate(etapas, start=1):
        print(f"\n########## [{numero}/{len(etapas)}] {nome} ##########", flush=True)
        inicio = time.time()
        # Roda a partir de backend/, de onde os scripts e a API leem o .env e importam utils/ e app/.
        resultado = subprocess.run(comando, cwd=PASTA_BACKEND)
        duracao = time.time() - inicio
        resumo.append((nome, resultado.returncode == 0, duracao))
        if resultado.returncode != 0:
            break

    print("\n========== RESUMO DO PIPELINE ==========")
    for nome, ok, duracao in resumo:
        print(f"  {'OK   ' if ok else 'FALHA'} {nome:<28} {duracao:6.1f}s")
    for nome, _ in etapas[len(resumo):]:
        print(f"  --    {nome:<28} nao executada")
    print(f"  Tempo total: {time.time() - inicio_total:.1f}s")
    if not args.executar:
        print("\nSimulacao: o DW nao foi alterado. Rode com --executar para carregar e gerar a gold.")

    sys.exit(0 if all(ok for _, ok, _ in resumo) and len(resumo) == len(etapas) else 1)


if __name__ == "__main__":
    main()
