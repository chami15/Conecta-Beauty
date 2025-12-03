import pandas as pd
from pymongo import MongoClient
from dotenv import load_dotenv
import os
load_dotenv()

MONGO_URI = os.getenv("MONGO_URI")
DB_NAME = os.getenv("DB_NAME")

class Transformacao:
    def __init__(self):
        self.client = MongoClient(MONGO_URI)
        self.db = self.client[DB_NAME]
    
    def transformar_clientes(self):
        """Transforma dados da coleção Clientes"""
        colecao = self.db["Clientes"]
        dados = list(colecao.find({}, {"_id": 0}))
        df = pd.DataFrame(dados)
        
        # Tratamento e limpeza
        df.fillna("", inplace=True)
        
        # Remove duplicatas baseado no id_cliente, mantendo o primeiro
        if 'id_cliente' in df.columns:
            df.drop_duplicates(subset=['id_cliente'], keep='first', inplace=True)
        
        # Remove espaços em branco extras apenas de colunas string
        for col in df.select_dtypes(include=['object']).columns:
            if df[col].dtype == 'object':
                df[col] = df[col].astype(str).str.strip()
        
        return df
    
    def transformar_vendas(self):
        """Transforma dados da coleção Vendas"""
        colecao = self.db["Vendas"]
        dados = list(colecao.find({}, {"_id": 0}))
        df = pd.DataFrame(dados)
        
        # Tratamento e limpeza
        df.fillna("", inplace=True)
        
        # Remove duplicatas se houver coluna de id
        id_cols = [col for col in df.columns if 'id' in col.lower()]
        if id_cols:
            df.drop_duplicates(subset=id_cols, keep='first', inplace=True)
        
        # Remove espaços em branco extras em colunas de texto
        for col in df.select_dtypes(include=['object']).columns:
            if df[col].dtype == 'object':
                df[col] = df[col].astype(str).str.strip()
        
        # Converte colunas numéricas se necessário
        for col in df.columns:
            if 'valor' in col.lower() or 'preco' in col.lower() or 'total' in col.lower():
                try:
                    df[col] = pd.to_numeric(df[col], errors='coerce').fillna(0)
                except:
                    pass
        
        return df
    
    def transformar_produtos(self):
        """Transforma dados da coleção Produtos"""
        colecao = self.db["Produtos"]
        dados = list(colecao.find({}, {"_id": 0}))
        df = pd.DataFrame(dados)
        
        # Tratamento e limpeza
        df.fillna("", inplace=True)
        
        # Remove duplicatas baseado no id do produto
        id_cols = [col for col in df.columns if 'id' in col.lower() and 'produto' in col.lower()]
        if id_cols:
            df.drop_duplicates(subset=id_cols, keep='first', inplace=True)
        
        # Remove espaços em branco extras
        for col in df.select_dtypes(include=['object']).columns:
            if df[col].dtype == 'object':
                df[col] = df[col].astype(str).str.strip()
        
        # Converte valores numéricos
        for col in df.columns:
            if 'preco' in col.lower() or 'valor' in col.lower() or 'estoque' in col.lower():
                try:
                    df[col] = pd.to_numeric(df[col], errors='coerce').fillna(0)
                except:
                    pass
        
        return df
    
    def transformar_cor_produto(self):
        """Transforma dados da coleção CorProduto"""
        colecao = self.db["CorProduto"]
        dados = list(colecao.find({}, {"_id": 0}))
        df = pd.DataFrame(dados)
        
        # Tratamento e limpeza
        df.fillna("", inplace=True)
        
        # Remove duplicatas
        id_cols = [col for col in df.columns if 'id' in col.lower()]
        if id_cols:
            df.drop_duplicates(subset=id_cols, keep='first', inplace=True)
        
        # Remove espaços em branco extras
        for col in df.select_dtypes(include=['object']).columns:
            if df[col].dtype == 'object':
                df[col] = df[col].astype(str).str.strip()
        
        # Padroniza nomes de cores (primeira letra maiúscula)
        for col in df.columns:
            if 'cor' in col.lower() and df[col].dtype == 'object':
                df[col] = df[col].astype(str).str.title()
        
        return df
    
    def transformar_pedidos(self):
        """Transforma dados da coleção Pedidos"""
        colecao = self.db["Pedidos"]
        dados = list(colecao.find({}, {"_id": 0}))
        df = pd.DataFrame(dados)
        
        # Tratamento e limpeza
        df.fillna("", inplace=True)
        
        # Remove duplicatas baseado no id do pedido
        id_cols = [col for col in df.columns if 'id' in col.lower() and 'pedido' in col.lower()]
        if id_cols:
            df.drop_duplicates(subset=id_cols, keep='first', inplace=True)
        
        # Remove espaços em branco extras
        for col in df.select_dtypes(include=['object']).columns:
            if df[col].dtype == 'object':
                df[col] = df[col].astype(str).str.strip()
        
        # Converte valores numéricos
        for col in df.columns:
            if 'valor' in col.lower() or 'preco' in col.lower() or 'total' in col.lower() or 'quantidade' in col.lower():
                try:
                    df[col] = pd.to_numeric(df[col], errors='coerce').fillna(0)
                except:
                    pass
        
        # Converte datas se houver
        for col in df.columns:
            if 'data' in col.lower():
                try:
                    df[col] = pd.to_datetime(df[col], errors='coerce')
                except:
                    pass
        
        return df
    
    def transformar_todas(self):
        """Transforma todas as coleções e retorna um dicionário com os DataFrames"""
        return {
            'clientes': self.transformar_clientes(),
            'vendas': self.transformar_vendas(),
            'produtos': self.transformar_produtos(),
            'cor_produto': self.transformar_cor_produto(),
            'pedidos': self.transformar_pedidos()
        }
    
    def fechar_conexao(self):
        """Fecha a conexão com o MongoDB"""
        self.client.close()


# Exemplo de uso
if __name__ == "__main__":
    transformacao = Transformacao()
    
    # Transformar coleção específica
    df_clientes = transformacao.transformar_clientes()
    df_vendas = transformacao.transformar_vendas()
    df_produtos = transformacao.transformar_produtos()
    df_cor_produto = transformacao.transformar_cor_produto()
    df_pedidos = transformacao.transformar_pedidos() 

    # Ou transformar todas de uma vez
    # todos_dados = transformacao.transformar_todas()
    # for nome, df in todos_dados.items():
    #     print(f"{nome.capitalize()}: {len(df)} registros")
    
    transformacao.fechar_conexao()



