import asyncio
import json
import time
import traceback
from contextlib import asynccontextmanager

from fastapi import FastAPI, Request
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import Response

from app.api.routes import inicio, administrativo, financeiro, estoque, estatisticas, ml
from utils import mongo_logger

TRACEBACK_MAX_CHARS = 4000


@asynccontextmanager
async def lifespan(app: FastAPI):
    mongo_logger.conectar()
    yield
    mongo_logger.desconectar()


app = FastAPI(
    title="Conecta Beauty API",
    version="1.0.0",
    lifespan=lifespan,
)

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["*"],
    allow_headers=["*"],
)


@app.middleware("http")
async def log_tecnico_middleware(request: Request, call_next):
    inicio_ts = time.perf_counter()
    try:
        response = await call_next(request)
    except Exception as exc:
        duracao_ms = (time.perf_counter() - inicio_ts) * 1000
        tb = traceback.format_exc()[-TRACEBACK_MAX_CHARS:]
        await asyncio.to_thread(
            mongo_logger.registrar_erro,
            request.method,
            request.url.path,
            500,
            duracao_ms,
            type(exc).__name__,
            tb,
        )
        raise

    duracao_ms = (time.perf_counter() - inicio_ts) * 1000

    if response.status_code >= 400:
        detail = f"HTTP {response.status_code}"
        body_bytes = b"".join([chunk async for chunk in response.body_iterator])
        # reconstroi a resposta porque o corpo so pode ser lido uma vez
        response = Response(
            content=body_bytes,
            status_code=response.status_code,
            headers=dict(response.headers),
            media_type=response.media_type,
        )
        try:
            detail_bruto = json.loads(body_bytes).get("detail", detail)
            # detail pode vir como lista/dict (ex.: erro de validacao 422 do FastAPI)
            detail = detail_bruto if isinstance(detail_bruto, str) else json.dumps(detail_bruto, ensure_ascii=False)
        except (json.JSONDecodeError, AttributeError):
            pass
        await asyncio.to_thread(
            mongo_logger.registrar_erro,
            request.method,
            request.url.path,
            response.status_code,
            duracao_ms,
            "HTTPError",
            detail,
        )
    else:
        await asyncio.to_thread(
            mongo_logger.registrar_requisicao,
            request.method,
            request.url.path,
            response.status_code,
            duracao_ms,
        )
    return response


app.include_router(inicio.router)
app.include_router(administrativo.router)
app.include_router(financeiro.router)
app.include_router(estoque.router)
app.include_router(estatisticas.router)
app.include_router(ml.router)


@app.get("/health")
def health():
    return {"status": "ok"}
