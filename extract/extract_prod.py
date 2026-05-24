import pandas as pd

from config.database import engine
from config.settings import SCHEMA_ESTOQUE


def extract_produtos():

    query = f"""
        SELECT
            id_produto,
            nome_produto,
            categoria,
            preco,
            quantidade_estoque
        FROM {SCHEMA_ESTOQUE}.produtos
    """

    df = pd.read_sql(query, engine)

    return df