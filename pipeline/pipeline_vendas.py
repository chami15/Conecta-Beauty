from extract.extract_vendas import extract_vendas

from transform.transform_vendas import transform_vendas

from load.load_vendas import load_vendas

def pipeline_vendas():

    print("Iniciando pipeline de vendas...")

    df = extract_vendas()

    print("Vendas extraídas com sucesso!")

    df = transform_vendas(df)

    print("Vendas transformadas com sucesso!")

    load_vendas(df)

    print("Pipeline vendas finalizada!")