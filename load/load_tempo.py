from sqlalchemy import text

from config.database import engine

def load_tempo(df):

    with engine.begin() as connection:

        for _, row in df.iterrows():

            query = text("""

                INSERT INTO geral.dim_tempo (

                    data_completa,
                    ano,
                    mes,
                    dia,
                    trimestre,
                    dia_semana

                )

                VALUES (

                    :data_completa,
                    :ano,
                    :mes,
                    :dia,
                    :trimestre,
                    :dia_semana

                )

                ON CONFLICT (data_completa)
                DO NOTHING

            """)

            connection.execute(query, {

                "data_completa": row["data"],
                "ano": row["ano"],
                "mes": row["mes"],
                "dia": row["dia"],
                "trimestre": row["trimestre"],
                "dia_semana": row["dia_semana"]

            })

    print("Dimensão tempo carregada com sucesso!")