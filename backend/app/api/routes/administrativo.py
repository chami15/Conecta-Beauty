from typing import Optional
from fastapi import APIRouter, HTTPException, Query
from pydantic import BaseModel
from app.api.analytics import administrativo as analytics
from utils.db import Database

router = APIRouter(prefix="/api/admin", tags=["Administrativo"])


# ─────────────────────────────────────────────
# Schemas (Pydantic)
# ─────────────────────────────────────────────

class ClienteBody(BaseModel):
    nome: str
    sexo: Optional[str] = None
    documento: Optional[str] = None
    fk_localizacao: Optional[int] = None
    telefone: Optional[str] = None
    endereco_completo: Optional[str] = None


class ProdutoBody(BaseModel):
    nome_produto: str
    descricao: Optional[str] = None
    id_categoria: Optional[int] = None
    id_fornecedor: Optional[int] = None
    custo_unitario: float
    peso_kg: Optional[float] = None
    altura_cm: Optional[float] = None
    largura_cm: Optional[float] = None
    profundidade_cm: Optional[float] = None
    estoque_min: int = 0
    estoque_max: Optional[int] = None
    ativo: bool = True


class FornecedorBody(BaseModel):
    nome_fornecedor: str
    cnpj: Optional[str] = None
    telefone: Optional[str] = None
    id_localizacao: Optional[int] = None
    endereco_completo: Optional[str] = None


class CanalVendaBody(BaseModel):
    canal_venda: str
    tipo_canal: str
    ativo: bool = True


# ─────────────────────────────────────────────
# Analytics
# ─────────────────────────────────────────────

@router.get("/kpis")
def kpis():
    try:
        return analytics.get_kpis()
    except Exception as e:
        raise HTTPException(500, str(e))


@router.get("/canais-por-venda")
def canais_por_venda():
    try:
        return analytics.get_canais_por_venda()
    except Exception as e:
        raise HTTPException(500, str(e))


@router.get("/clientes-por-regiao")
def clientes_por_regiao():
    try:
        return analytics.get_clientes_por_regiao()
    except Exception as e:
        raise HTTPException(500, str(e))


@router.post("/atualizar-cubos")
def atualizar_cubos_olap():
    """Executa CALL atualizar_cubos_olap() para refrescar todas as Materialized Views."""
    try:
        with Database() as conn:
            conn.execute("CALL atualizar_cubos_olap()")
            conn.commit()
        return {
            "status": "ok",
            "cubos_atualizados": [
                "financeiro.cubo_vendas",
                "estoque.cubo_estoque",
                "financeiro.cubo_dre",
                "estoque.cubo_frete",
            ],
        }
    except Exception as e:
        raise HTTPException(500, str(e))


# ─────────────────────────────────────────────
# CRUD — Clientes
# ─────────────────────────────────────────────

@router.get("/clientes")
def listar_clientes(page: int = Query(1, ge=1), page_size: int = Query(20, ge=1, le=100)):
    try:
        return analytics.listar_clientes(page, page_size)
    except Exception as e:
        raise HTTPException(500, str(e))


@router.get("/clientes/{id}")
def buscar_cliente(id: int):
    return analytics.buscar_cliente(id)


@router.post("/clientes", status_code=201)
def criar_cliente(body: ClienteBody):
    try:
        return analytics.criar_cliente(body)
    except Exception as e:
        raise HTTPException(500, str(e))


@router.put("/clientes/{id}")
def atualizar_cliente(id: int, body: ClienteBody):
    return analytics.atualizar_cliente(id, body)


@router.delete("/clientes/{id}")
def deletar_cliente(id: int):
    return analytics.deletar_cliente(id)


# ─────────────────────────────────────────────
# CRUD — Produtos
# ─────────────────────────────────────────────

@router.get("/produtos")
def listar_produtos(page: int = Query(1, ge=1), page_size: int = Query(20, ge=1, le=100)):
    try:
        return analytics.listar_produtos(page, page_size)
    except Exception as e:
        raise HTTPException(500, str(e))


@router.get("/produtos/{id}")
def buscar_produto(id: int):
    return analytics.buscar_produto(id)


@router.post("/produtos", status_code=201)
def criar_produto(body: ProdutoBody):
    try:
        return analytics.criar_produto(body)
    except Exception as e:
        raise HTTPException(500, str(e))


@router.put("/produtos/{id}")
def atualizar_produto(id: int, body: ProdutoBody):
    return analytics.atualizar_produto(id, body)


@router.delete("/produtos/{id}")
def deletar_produto(id: int):
    return analytics.deletar_produto(id)


# ─────────────────────────────────────────────
# CRUD — Fornecedores
# ─────────────────────────────────────────────

@router.get("/fornecedores")
def listar_fornecedores(page: int = Query(1, ge=1), page_size: int = Query(20, ge=1, le=100)):
    try:
        return analytics.listar_fornecedores(page, page_size)
    except Exception as e:
        raise HTTPException(500, str(e))


@router.get("/fornecedores/{id}")
def buscar_fornecedor(id: int):
    return analytics.buscar_fornecedor(id)


@router.post("/fornecedores", status_code=201)
def criar_fornecedor(body: FornecedorBody):
    try:
        return analytics.criar_fornecedor(body)
    except Exception as e:
        raise HTTPException(500, str(e))


@router.put("/fornecedores/{id}")
def atualizar_fornecedor(id: int, body: FornecedorBody):
    return analytics.atualizar_fornecedor(id, body)


@router.delete("/fornecedores/{id}")
def deletar_fornecedor(id: int):
    return analytics.deletar_fornecedor(id)


# ─────────────────────────────────────────────
# CRUD — Canais de Venda
# ─────────────────────────────────────────────

@router.get("/canais")
def listar_canais():
    try:
        return analytics.listar_canais()
    except Exception as e:
        raise HTTPException(500, str(e))


@router.get("/canais/{id}")
def buscar_canal(id: int):
    return analytics.buscar_canal(id)


@router.post("/canais", status_code=201)
def criar_canal(body: CanalVendaBody):
    try:
        return analytics.criar_canal(body)
    except Exception as e:
        raise HTTPException(500, str(e))


@router.put("/canais/{id}")
def atualizar_canal(id: int, body: CanalVendaBody):
    return analytics.atualizar_canal(id, body)


@router.delete("/canais/{id}")
def deletar_canal(id: int):
    return analytics.deletar_canal(id)
