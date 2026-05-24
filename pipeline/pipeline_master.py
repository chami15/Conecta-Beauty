from pipeline.pipeline_clientes import pipeline_clientes

from pipeline.pipeline_vendas import pipeline_vendas

from pipeline.pipeline_estoque import pipeline_estoque

from pipeline.pipeline_tempo import pipeline_tempo


def executar_pipeline_master():

    print("INICIANDO ETL MASTER")

    pipeline_clientes()

    pipeline_vendas()

    pipeline_estoque()

    pipeline_tempo()

    print("ETL FINALIZADO COM SUCESSO!")