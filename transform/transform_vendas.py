import pandas as pd

def transform_vendas(df):

    df = df.drop_duplicates()

    df["data_venda"] = pd.to_datetime(
        df["data_venda"]
    )

    df["valor_total"] = pd.to_numeric(
        df["valor_total"]
    )

    df["quantidade"] = pd.to_numeric(
        df["quantidade"]
    )

    df["ticket_medio"] = (
        df["valor_total"] / df["quantidade"]
    )

    df["categoria_venda"] = df["valor_total"].apply(
        lambda x: (
            "ALTA"
            if x >= 5000
            else "MEDIA"
            if x >= 1000
            else "BAIXA"
        ) )