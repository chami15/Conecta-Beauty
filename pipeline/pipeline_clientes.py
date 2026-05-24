from extract.extract_clientes import extract_clientes

from transform.transform_clientes import transform_clientes

from load.load_clientes import load_clientes

def pipeline_clientes():

    print("Iniciando pipeline de clientes...")

    df = extract_clientes()

    print("Clientes extraídos com sucesso!")

    df = transform_clientes(df)

    print("Clientes transformados com sucesso!")

    load_clientes(df)

    print("Pipeline clientes finalizada!")