import pandas as pd

def transform_estoque(df):

    df = df.drop_duplicates()

    df["saldo_atual"] = pd.to_numeric(
        df["saldo_atual"]
    )

    df["status_estoque"] = df["saldo_atual"].apply(
        lambda x: (
            "BAIXO"
            if x < 5
            else "NORMAL"
        )  )