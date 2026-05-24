from transform.transform_tempo import criar_dim_tempo

from load.load_tempo import load_tempo

def pipeline_tempo():

    print("Iniciando pipeline tempo...")

    df = criar_dim_tempo(

        "2024-01-01",
        "2026-12-31"

    )

    print("Dimensão tempo criada!")

    load_tempo(df)

    print("Pipeline tempo finalizada!")