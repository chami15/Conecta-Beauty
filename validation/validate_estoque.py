def validate_estoque(df):

    erros = []

    if (df["saldo_atual"] < 0).sum() > 0:

        erros.append(
            "Existem produtos com estoque negativo."
        )

    if df["fk_produto"].isnull().sum() > 0:

        erros.append(
            "Existem produtos sem identificação."
        )

    if df["id_estoque"].duplicated().sum() > 0:

        erros.append(
            "Existem registros duplicados no estoque."
        )

    if erros:

        print("ERROS ENCONTRADOS:")

        for erro in erros:
            print(f"- {erro}")

        return False

    print("Validação estoque OK!")

    return True