import pandas as pd

from config.database import engine
from config.settings import SCHEMA_ESTOQUE


def extract_estoque():

    query = f"""
        SELECT
            id_estoque,
            fk_produto,
            saldo_atual,
            ultima_movimentacao
        FROM {SCHEMA_ESTOQUE}.estoque
    """

    df = pd.read_sql(query, engine)

    return df