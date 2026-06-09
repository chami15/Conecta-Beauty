from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from app.api.routes import inicio, administrativo, financeiro, estoque, estatisticas, ml

app = FastAPI(
    title="Conecta Beauty API",
    version="1.0.0",
)

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(inicio.router)
app.include_router(administrativo.router)
app.include_router(financeiro.router)
app.include_router(estoque.router)
app.include_router(estatisticas.router)
app.include_router(ml.router)


@app.get("/health")
def health():
    return {"status": "ok"}
