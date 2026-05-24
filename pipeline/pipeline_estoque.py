from extract.extract_estoque import extract_estoque

from transform.transform_estoque import transform_estoque

from load.load_estoque import load_estoque

def pipeline_estoque():

    print("Iniciando pipeline de estoque...")
    
    df = extract_estoque()

    print("Estoque extraído com sucesso!")

    df = transform_estoque(df)

    print("Estoque transformado com sucesso!")

    load_estoque(df)

    print("Pipeline estoque finalizada!")