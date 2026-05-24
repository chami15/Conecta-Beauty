from sqlalchemy import text

from config.database import engine

def load_clientes(df):

    with engine.begin() as connection:

        for _, row in df.iterrows():

            query = text("""

                INSERT INTO administrativo.clientes (
                    id_cliente,
                    nome_cliente,
                    cidade,
                    estado,
                    data_cadastro,
                    regiao
                )

                VALUES (
                    :id_cliente,
                    :nome_cliente,
                    :cidade,
                    :estado,
                    :data_cadastro,
                    :regiao
                )

                ON CONFLICT (id_cliente)
                DO NOTHING

            """)

            connection.execute(query, {

                "id_cliente": row["id_cliente"],
                "nome_cliente": row["nome_cliente"],
                "cidade": row["cidade"],
                "estado": row["estado"],
                "data_cadastro": row["data_cadastro"],
                "regiao": row["regiao"] })

    print("Clientes carregados com sucesso!")