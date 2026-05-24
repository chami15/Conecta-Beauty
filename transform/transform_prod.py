import pandas as pd

def transform_clientes(df):

    df = df.drop_duplicates()

    df = df[df["nome_cliente"].notnull()]

    df["nome_cliente"] = (
        df["nome_cliente"]
        .str.upper()
        .str.strip()
    )

    df["estado"] = (
        df["estado"]
        .str.upper()
        .str.strip()
    )

    df["data_cadastro"] = pd.to_datetime(
        df["data_cadastro"]
    )

    mapa_regiao = {
        "SP": "SUDESTE",
        "RJ": "SUDESTE",
        "MG": "SUDESTE",
        "PR": "SUL"
    }

    df["regiao"] = (
        df["estado"]
        .map(mapa_regiao)
    )

    return df