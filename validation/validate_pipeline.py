from extract.extract_vendas import extract_vendas

from validation.validate_vendas import validate_vendas

from transform.transform_vendas import transform_vendas

from load.load_vendas import load_vendas


def pipeline_vendas():

    print("Iniciando pipeline vendas...")

    df = extract_vendas()

    if not validate_vendas(df):

        print("Pipeline interrompida.")

        return

    df = transform_vendas(df)

    if not validate_vendas(df):

        print("Pipeline interrompida.")

        return
    load_vendas(df)

    print("Pipeline finalizada!")