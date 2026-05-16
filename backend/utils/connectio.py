import psycopg2
from psycopg2.extras import execute_values
import os

class PostgreConn:
    def __init__(self, sufix=""):
        print(sufix)
        try: 
            if sufix:
                host=os.getenv((f"POSTGRES_HOST_{sufix}"), os.getenv("POSTGRES_HOST", "localhost")),
                port=os.getenv((f"POSTGRES_PORT_{sufix}"), os.getenv("POSTGRES_HOST", "5432")),
                database=os.getenv(f"POSTGRES_DB_{sufix}"),
                user = os.getenv(f"POSTGRES_USER_{sufix}"),
                password=os.get_secret(f"POSTGRES_PASSWORD_{sufix}")
                
            else:
                host=os.getenv("POSTGRES_HOST", "localhost"),
                port=os.getenv("POSTGRES_PORT", "5432"),
                database=os.getenv("POSTGRES_DB"),
                user = os.getenv("POSTGRES_USER"),
                password=os.getenv("POSTGRES_PASSWORD")
                
            self.conn = psycopg2.connect(
                host=host,
                port=port,
                database=database,
                user=user,
                password=password
            )
            self.cur = self.conn.cursor()
            print('conectado')

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

    
        
iniciar = PostgreConn()
iniciar.__init__()