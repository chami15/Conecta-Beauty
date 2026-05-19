import sys
from pathlib import Path
raiz = str(Path(__file__).resolve().parent.parent)
sys.path.append(raiz)
from utils.connection import PostgreConn
from utils.query_executor import executar_query
db = PostgreConn()

def total_venda():
    vendas = executar_query('vendas:coletar_total_vendas')
    for venda in vendas:
        print(venda)

total_venda()
