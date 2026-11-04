"""
Azure Function que roda o pipeline do Data Lake (scripts/datalake/pipeline.py) na nuvem:

    pipeline_diario   gatilho de horario: todo dia as 06:00 UTC (03:00 em Brasilia)
    pipeline_agora    gatilho HTTP: roda na hora, chamando a URL da funcao (exige a chave da funcao)

Os dois executam o mesmo comando do terminal (pipeline.py --executar --treinar-ml), com as
credenciais lidas das configuracoes da Function App em vez do backend/.env.
Passo a passo de publicacao: docs/infra/function_app.md
"""
import logging
import os
import subprocess
import sys

import azure.functions as func

app = func.FunctionApp()

RAIZ = os.path.dirname(os.path.abspath(__file__))
PIPELINE = os.path.join(RAIZ, "scripts", "datalake", "pipeline.py")
ARGUMENTOS = ["--executar", "--treinar-ml"]
TIMEOUT_S = 9 * 60  # abaixo do functionTimeout do host.json (10 min)


def rodar_pipeline() -> tuple[bool, str]:
    env = {
        **os.environ,
        # O codigo publicado e somente leitura: os modelos de ML sao salvos em /tmp.
        "ML_ARTIFACTS_DIR": os.environ.get("ML_ARTIFACTS_DIR", "/tmp/conecta_ml"),
        # As bibliotecas instaladas na publicacao ficam no sys.path deste processo, nao no do filho.
        "PYTHONPATH": os.pathsep.join(p for p in sys.path if p),
        "PYTHONUNBUFFERED": "1",
    }
    resultado = subprocess.run([sys.executable, PIPELINE, *ARGUMENTOS], cwd=RAIZ, env=env,
                               capture_output=True, text=True, timeout=TIMEOUT_S)
    saida = resultado.stdout + (f"\n[stderr]\n{resultado.stderr}" if resultado.stderr.strip() else "")
    for linha in saida.splitlines():
        logging.info(linha)
    return resultado.returncode == 0, saida


@app.timer_trigger(arg_name="timer", schedule="0 0 6 * * *", run_on_startup=False)
def pipeline_diario(timer: func.TimerRequest) -> None:
    ok, _ = rodar_pipeline()
    if not ok:
        raise RuntimeError("Pipeline falhou - veja o log acima.")


@app.route(route="pipeline", methods=["GET", "POST"], auth_level=func.AuthLevel.FUNCTION)
def pipeline_agora(req: func.HttpRequest) -> func.HttpResponse:
    ok, saida = rodar_pipeline()
    resumo = saida[saida.find("========== RESUMO DO PIPELINE"):] if "RESUMO DO PIPELINE" in saida else saida
    return func.HttpResponse(resumo, status_code=200 if ok else 500, mimetype="text/plain; charset=utf-8")
