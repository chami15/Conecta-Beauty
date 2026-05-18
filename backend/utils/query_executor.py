from db import Database
from sql_manager import sql_manager

def executar_query(query_name: str, commit: bool = False, connection: str = "", **param):
    with Database(sufix=connection) as conn:
        query_sql = sql_manager.load_query(query_name, **param)
        print(f"Executando query: {query_name}")
        print(f"Query SQL: {query_sql}")

        conn.execute(query_sql)

        if commit: 
            rows_affected = conn.get_cur().rowcount
            conn.commit()
            return rows_affected
        
        rows = conn.fetchall()
        if not rows:
            return []
        
        columns = [desc[0] for desc in conn.get_cur().description]
        return [dict(zip(columns, row)) for row in rows]

