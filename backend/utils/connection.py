import psycopg2
from psycopg2.extras import execute_values
import os
from dotenv import load_dotenv
load_dotenv()

# O banco fica no Azure Database for PostgreSQL (Flexible Server), que exige SSL.
# POSTGRES_SSLMODE pode ser trocado (ex.: "disable") só para um Postgres local de teste.
SSLMODE_PADRAO = "require"
TIMEOUT_CONEXAO_S = 10  # falha rápido se o firewall do Azure bloquear o IP, em vez de travar

class PostgreConn:
    def __init__(self, sufix=None):
        try: 
            if sufix:
                host=os.getenv((f"POSTGRES_HOST_{sufix}"), os.getenv("POSTGRES_HOST"))
                port=os.getenv((f"POSTGRES_PORT_{sufix}"), os.getenv("POSTGRES_PORT",5432))
                database=os.getenv(f"POSTGRES_DB_{sufix}")
                user = os.getenv(f"POSTGRES_USER_{sufix}")
                password=os.getenv(f"POSTGRES_PASSWORD_{sufix}")
                
            else:
                host=os.getenv("POSTGRES_HOST")
                port=int(os.getenv("POSTGRES_PORT",5432))
                database=os.getenv("POSTGRES_DB")
                user = os.getenv("POSTGRES_USER")
                password=os.getenv("POSTGRES_PASSWORD")

            if not host:
                raise ValueError("POSTGRES_HOST não configurado no backend/.env")
                
            self.conn = psycopg2.connect(
                host=host,
                port=port,
                database=database,
                user=user,
                password=password,
                sslmode=os.getenv("POSTGRES_SSLMODE", SSLMODE_PADRAO),
                connect_timeout=TIMEOUT_CONEXAO_S,
            )
            self.cur = self.conn.cursor()
            

        except Exception as e:
            print(f"Erro ao se conectar com o banco: {e}")
            self.conn = None
            self.cur = None
            
    def close(self):
        if self.cur:
            self.cur.close()
        if self.conn:
            self.conn.close()

    def commit(self):
        if self.conn:
            self.conn.commit()
    
    def rollback(self):
        if self.conn:
            self.conn.rollback()
    
    def execute(self, query, params=None):
        # Sem conexão, falha com erro claro: antes a query era ignorada em silêncio
        # e as telas mostravam zero em vez de avisar que o banco estava fora.
        if self.cur is None:
            raise ConnectionError("Sem conexão com o banco (confira o backend/.env e o firewall do Azure).")
        try:
            if self.cur:
                self.cur.execute(query, params)
        except Exception as e:
            print(f'Erro ao executar query: {e}')
            self.rollback()
            raise
    def execute_values(self, insert_query, values_list):
        if self.cur is None:
            raise ConnectionError("Sem conexão com o banco (confira o backend/.env e o firewall do Azure).")
        try:
            if self.cur:
                execute_values(self.cur, insert_query, values_list)
        except Exception as e:
            print(f'Erro ao executar inserção: {e}')
            self.rollback()
            raise
    
    def fetchall(self):
        return self.cur.fetchall() if self.cur else None
    
    def fetchone(self):
        return self.cur.fetchone() if self.cur else None
    
    def fetchmany(self):
        return self.cur.fetchmany() if self.cur else None
    
    def get_cur(self):
        return self.cur
    
    def get_conn(self):
        return self.conn
    
