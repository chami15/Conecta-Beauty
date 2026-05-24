import pandas as pd

from config.database import engine
from config.settings import SCHEMA_FINANCEIRO


def extract_vendas():

    query = f"""
        SELECT
            id_venda,
            fk_cliente,
            fk_produto,
            data_venda,
            quantidade,
            valor_unitario,
            valor_total
        FROM {SCHEMA_FINANCEIRO}.vendas
    """

    df = pd.read_sql(query, engine)

    return df