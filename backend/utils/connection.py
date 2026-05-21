import psycopg2
from psycopg2.extras import execute_values
import os
from dotenv import load_dotenv
load_dotenv()

class PostgreConn:
    def __init__(self, sufix=None):
        try: 
            if sufix:
                host=os.getenv((f"POSTGRES_HOST_{sufix}"), os.getenv("POSTGRES_HOST", "localhost"))
                port=os.getenv((f"POSTGRES_PORT_{sufix}"), os.getenv("POSTGRES_PORT",5432))
                database=os.getenv(f"POSTGRES_DB_{sufix}")
                user = os.getenv(f"POSTGRES_USER_{sufix}")
                password=os.getenv(f"POSTGRES_PASSWORD_{sufix}")
                
            else:
                host=os.getenv("POSTGRES_HOST", "localhost")
                port=int(os.getenv("POSTGRES_PORT",5432))
                database=os.getenv("POSTGRES_DB")
                user = os.getenv("POSTGRES_USER")
                password=os.getenv("POSTGRES_PASSWORD")
                
            self.conn = psycopg2.connect(
                host=host,
                port=port,
                database=database,
                user=user,
                password=password
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
        try:
            if self.cur:
                self.cur.execute(query, params)
        except Exception as e:
            print(f'Erro ao executar query: {e}')
            self.rollback()
            raise
    def execute_values(self, insert_query, values_list):
        try:
            if self.cur:
                self.execute_values(insert_query, values_list)
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
    
