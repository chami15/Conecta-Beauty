from pipeline.pipeline_master import executar_pipeline_master

from utils.logger import logger

from datetime import datetime

def main():

    inicio = datetime.now()

    logger.info(
        "======================================"
    )

    logger.info(
        "INICIANDO ETL JN MOVEIS"
    )

    logger.info(
        f"Início execução: {inicio}"
    )

    try:

        # EXECUTAR PIPELINE MASTER
        executar_pipeline_master()

        fim = datetime.now()

        tempo_execucao = fim - inicio

        logger.info(
            f"Fim execução: {fim}"
        )

        logger.info(
            f"Tempo total execução: {tempo_execucao}"
        )

        logger.info(
            "ETL EXECUTADO COM SUCESSO"
        )

    except Exception as erro:

        logger.error(
            f"ERRO GERAL ETL: {erro}"
        )

    finally:

        logger.info(
            "FINALIZANDO ETL"
        )

        logger.info(
            "======================================"
        )


if __name__ == "__main__":
  main()