import asyncio
import time
from contextlib import asynccontextmanager

from fastapi import FastAPI, Request
from fastapi.middleware.cors import CORSMiddleware

from app.api.routes import inicio, administrativo, financeiro, estoque, estatisticas, ml
from utils import mongo_logger


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
        await asyncio.to_thread(
            mongo_logger.registrar_erro,
            request.method,
            request.url.path,
            500,
            duracao_ms,
            type(exc).__name__,
            str(exc),
        )
        raise

    duracao_ms = (time.perf_counter() - inicio_ts) * 1000
    if response.status_code >= 400:
        await asyncio.to_thread(
            mongo_logger.registrar_erro,
            request.method,
            request.url.path,
            response.status_code,
            duracao_ms,
            "HTTPError",
            f"Resposta com status {response.status_code}",
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
