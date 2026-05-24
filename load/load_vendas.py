from sqlalchemy import text

from config.database import engine


def load_vendas(df):

    with engine.begin() as connection:

        for _, row in df.iterrows():

            query = text("""

                INSERT INTO financeiro.vendas (

                    id_venda,
                    fk_cliente,
                    fk_produto,
                    data_venda,
                    quantidade,
                    valor_total,
                    ticket_medio,
                    categoria_venda

                )

                VALUES (

                    :id_venda,
                    :fk_cliente,
                    :fk_produto,
                    :data_venda,
                    :quantidade,
                    :valor_total,
                    :ticket_medio,
                    :categoria_venda

                )

                ON CONFLICT (id_venda)
                DO NOTHING

            """)

            connection.execute(query, {

                "id_venda": row["id_venda"],
                "fk_cliente": row["fk_cliente"],
                "fk_produto": row["fk_produto"],
                "data_venda": row["data_venda"],
                "quantidade": row["quantidade"],
                "valor_total": row["valor_total"],
                "ticket_medio": row["ticket_medio"],
                "categoria_venda": row["categoria_venda"]})

    print("Vendas carregadas com sucesso!")