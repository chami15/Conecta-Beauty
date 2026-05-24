def validate_vendas(df):

    erros = []

    if (df["valor_total"] < 0).sum() > 0:

        erros.append(
            "Existem vendas com valor negativo."
        )

    if (df["quantidade"] <= 0).sum() > 0:

        erros.append(
            "Existem vendas com quantidade inválida."
        )

    if df["fk_cliente"].isnull().sum() > 0:

        erros.append(
            "Existem vendas sem cliente."
        )

    if df["fk_produto"].isnull().sum() > 0:

        erros.append(
            "Existem vendas sem produto."
        )

    if df["id_venda"].duplicated().sum() > 0:

        erros.append(
            "Existem vendas duplicadas."
        )

    if erros:

        print("ERROS ENCONTRADOS:")

        for erro in erros:
            print(f"- {erro}")

        return False

    print("Validação vendas OK!")

    return True