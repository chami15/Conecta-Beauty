def validate_clientes(df):

    erros = []

    if df["nome_cliente"].isnull().sum() > 0:

        erros.append(
            "Existem clientes sem nome."
        )

    if df["estado"].isnull().sum() > 0:

        erros.append(
            "Existem estados nulos."
        )

    if df["id_cliente"].duplicated().sum() > 0:

        erros.append(
            "Existem clientes duplicados."
        )

    # RESULTADO
    if erros:

        print("ERROS ENCONTRADOS:")

        for erro in erros:
            print(f"- {erro}")

        return False

    print("Validação clientes OK!")

    return True