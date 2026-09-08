"""
Logs tecnicos da aplicacao (requisicoes e erros), gravados no Cosmos DB
(colecao logs_tecnicos, banco conectabeauty). Nao e auditoria de negocio -
essa ja existe no Postgres via financeiro.auditoria_vendas.

A conexao e aberta uma unica vez na subida do Uvicorn (ver lifespan em main.py)
e fechada no encerramento - nunca reconecta a cada log.

Se o Cosmos DB estiver fora do ar ou a gravacao falhar por qualquer motivo,
o erro so aparece no terminal - nunca derruba a aplicacao nem tenta de novo
imediatamente (evita avalancha de tentativas em cima de um servico fora do ar).
"""
import os
from datetime import datetime

from pymongo import MongoClient
from pymongo.errors import PyMongoError

_client: MongoClient | None = None
_collection = None


def conectar():
    global _client, _collection
    connection_string = os.getenv("COSMOS_MONGO_CONNECTION_STRING")
    if not connection_string:
        print("[AVISO] COSMOS_MONGO_CONNECTION_STRING nao configurada - logs tecnicos desativados.")
        return
    try:
        _client = MongoClient(connection_string, serverSelectionTimeoutMS=5000)
        _client.admin.command("ping")
        _collection = _client["conectabeauty"]["logs_tecnicos"]
        print("[INFO] Conectado ao Cosmos DB (logs tecnicos habilitados).")
    except PyMongoError as e:
        print(f"[AVISO] Nao foi possivel conectar ao Cosmos DB - logs tecnicos desativados: {e}")
        _client = None
        _collection = None


def desconectar():
    global _client
    if _client is not None:
        _client.close()
        _client = None


def _formatar_mensagem(tipo_evento: str, resto: str) -> str:
    agora = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    return f"[{agora}]:{tipo_evento.upper()}:{resto}"


def _inserir(documento: dict):
    if _collection is None:
        return
    try:
        _collection.insert_one(documento)
    except PyMongoError as e:
        print(f"[AVISO] Falha ao gravar log tecnico no Cosmos DB: {e}")


def registrar_requisicao(metodo: str, caminho: str, status_code: int, duracao_ms: float):
    resto = f"{metodo} {caminho} {status_code} {duracao_ms:.1f}ms"
    _inserir({
        "tipo_evento": "requisicao",
        "metodo": metodo,
        "caminho": caminho,
        "status_code": status_code,
        "duracao_ms": round(duracao_ms, 1),
        "timestamp": datetime.now().isoformat(),
        "mensagem": _formatar_mensagem("requisicao", resto),
    })


def registrar_erro(metodo: str, caminho: str, status_code: int, duracao_ms: float, tipo_excecao: str, mensagem_erro: str):
    resto = f"{metodo} {caminho} {status_code} {duracao_ms:.1f}ms - {tipo_excecao}: {mensagem_erro}"
    _inserir({
        "tipo_evento": "erro",
        "metodo": metodo,
        "caminho": caminho,
        "status_code": status_code,
        "duracao_ms": round(duracao_ms, 1),
        "tipo_excecao": tipo_excecao,
        "mensagem_erro": mensagem_erro,
        "timestamp": datetime.now().isoformat(),
        "mensagem": _formatar_mensagem("erro", resto),
    })
