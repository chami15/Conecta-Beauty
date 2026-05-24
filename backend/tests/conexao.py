#Importações e ajustes para coletar funçoes e classes de arquivos da pasta util
import sys
from pathlib import Path
raiz = str(Path(__file__).resolve().parent.parent)
sys.path.append(raiz)
from utils.connection import PostgreConn
from utils.query_executor import executar_query

#instanciando a conexão do banco 
db = PostgreConn()

#função basica de exemplo
#para executar a querie, ela tem que estar na pasta sql e você passa assim para a função (nome_arquivo:nome_query)
def total_venda():
    vendas = executar_query('vendas:coletar_total_vendas')
    for venda in vendas:
        print(venda)

total_venda()
