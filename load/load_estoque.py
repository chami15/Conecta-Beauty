from sqlalchemy import text

from config.database import engine

def load_estoque(df):

    with engine.begin() as connection:

        for _, row in df.iterrows():

            query = text("""

                INSERT INTO estoque.estoque (

                    id_estoque,
                    fk_produto,
                    saldo_atual,
                    status_estoque

                )

                VALUES (

                    :id_estoque,
                    :fk_produto,
                    :saldo_atual,
                    :status_estoque

                )

                ON CONFLICT (id_estoque)
                DO NOTHING

            """)

            connection.execute(query, {

                "id_estoque": row["id_estoque"],
                "fk_produto": row["fk_produto"],
                "saldo_atual": row["saldo_atual"],
                "status_estoque": row["status_estoque"]})

    print("Estoque carregado com sucesso!")