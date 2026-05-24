def validate_tempo(df):

    erros = []

    if df["data"].isnull().sum() > 0:

        erros.append(
            "Existem datas nulas."
        )

    if df["data"].duplicated().sum() > 0:

        erros.append(
            "Existem datas duplicadas."
        )

    if erros:

        print("ERROS ENCONTRADOS:")

        for erro in erros:
            print(f"- {erro}")

        return False

    print("Validação tempo OK!")

    return True