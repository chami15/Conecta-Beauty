import pandas as pd

def criar_dim_tempo(
    data_inicio,
    data_fim
):

    datas = pd.date_range(
        start=data_inicio,
        end=data_fim
    )

    df = pd.DataFrame()

    df["data"] = datas
    df["ano"] = datas.year
    df["mes"] = datas.month
    df["dia"] = datas.day
    df["trimestre"] = datas.quarter
    df["dia_semana"] = datas.day_name()

    return df