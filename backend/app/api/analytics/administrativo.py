from fastapi import HTTPException
from utils.query_executor import executar_query


# ─────────────────────────────────────────────
# Analytics
# ─────────────────────────────────────────────

def get_kpis() -> dict:
    produto = executar_query("administrativo:kpi_produto_lider")
    cliente = executar_query("administrativo:kpi_melhor_cliente")
    fornecedor = executar_query("administrativo:kpi_top_fornecedor")
    canal = executar_query("administrativo:kpi_canal_numero1")

    return {
        "produto_lider": {
            "nome": produto[0]["nome_produto"],
            "faturamento": float(produto[0]["faturamento"]),
        } if produto else None,
        "melhor_cliente": {
            "nome": cliente[0]["nome"],
            "faturamento": float(cliente[0]["faturamento"]),
        } if cliente else None,
        "top_fornecedor": {
            "nome": fornecedor[0]["nome_fornecedor"],
            "faturamento": float(fornecedor[0]["faturamento"]),
        } if fornecedor else None,
        "canal_numero1": {
            "nome": canal[0]["canal_venda"],
            "qtd_pedidos": int(canal[0]["qtd_pedidos"]),
            "faturamento": float(canal[0]["faturamento"]),
        } if canal else None,
    }


def get_canais_por_venda() -> list:
    rows = executar_query("administrativo:canais_por_venda")
    return [
        {
            "canal": r["canal_venda"],
            "tipo": r["tipo_canal"],
            "qtd_pedidos": int(r["qtd_pedidos"]),
            "faturamento": float(r["faturamento"]),
        }
        for r in rows
    ]


def get_clientes_por_regiao() -> list:
    rows = executar_query("administrativo:clientes_por_regiao")
    return [
        {
            "regiao": r["regiao"],
            "estado": r["estado"],
            "qtd_clientes": int(r["qtd_clientes"]),
            "faturamento": float(r["faturamento"]),
        }
        for r in rows
    ]


# ─────────────────────────────────────────────
# CRUD — Clientes
# ─────────────────────────────────────────────

def fmt_cliente(r: dict) -> dict:
    return {
        "id": r["id_cliente"],
        "nome": r["nome"],
        "sexo": r["sexo"],
        "documento": r["documento"],
        "telefone": r["telefone"],
        "endereco_completo": r["endereco_completo"],
        "cidade": r["cidade"],
        "estado": r["estado"],
        "regiao": r["regiao"],
    }


def listar_clientes(page: int = 1, page_size: int = 20) -> dict:
    offset = (page - 1) * page_size
    rows = executar_query("administrativo:listar_clientes", params=(page_size, offset))
    total = executar_query("administrativo:total_clientes")
    return {
        "data": [fmt_cliente(r) for r in rows],
        "total": int(total[0]["total"]) if total else 0,
        "page": page,
        "page_size": page_size,
    }


def buscar_cliente(id: int) -> dict:
    rows = executar_query("administrativo:buscar_cliente", params=(id,))
    if not rows:
        raise HTTPException(404, "Cliente não encontrado")
    r = rows[0]
    return {**fmt_cliente(r), "created_at": str(r["created_at"]), "update_at": str(r["update_at"])}


def criar_cliente(data) -> dict:
    rows = executar_query(
        "administrativo:inserir_cliente",
        returning=True,
        params=(data.nome, data.sexo, data.documento, data.fk_localizacao, data.telefone, data.endereco_completo),
    )
    return {"id_cliente": rows[0]["id_cliente"]}


def atualizar_cliente(id: int, data) -> dict:
    rows = executar_query(
        "administrativo:atualizar_cliente",
        returning=True,
        params=(data.nome, data.sexo, data.documento, data.fk_localizacao, data.telefone, data.endereco_completo, id),
    )
    if not rows:
        raise HTTPException(404, "Cliente não encontrado")
    return {"id_cliente": rows[0]["id_cliente"]}


def deletar_cliente(id: int) -> dict:
    try:
        rows = executar_query("administrativo:deletar_cliente", returning=True, params=(id,))
        if not rows:
            raise HTTPException(404, "Cliente não encontrado")
        return {"deleted": True, "id_cliente": id}
    except HTTPException:
        raise
    except Exception:
        raise HTTPException(409, "Não é possível excluir: cliente possui registros vinculados")


# ─────────────────────────────────────────────
# CRUD — Produtos
# ─────────────────────────────────────────────

def fmt_produto(r: dict) -> dict:
    return {
        "id": r["id_produto"],
        "nome_produto": r["nome_produto"],
        "descricao": r["descricao"],
        "custo_unitario": float(r["custo_unitario"]) if r["custo_unitario"] else None,
        "peso_kg": float(r["peso_kg"]) if r["peso_kg"] else None,
        "estoque_min": r["estoque_min"],
        "estoque_max": r["estoque_max"],
        "ativo": r["ativo"],
        "categoria": r["categoria"],
        "subcategoria": r["subcategoria"],
        "fornecedor": r["nome_fornecedor"],
    }


def listar_produtos(page: int = 1, page_size: int = 20) -> dict:
    offset = (page - 1) * page_size
    rows = executar_query("administrativo:listar_produtos", params=(page_size, offset))
    total = executar_query("administrativo:total_produtos")
    return {
        "data": [fmt_produto(r) for r in rows],
        "total": int(total[0]["total"]) if total else 0,
        "page": page,
        "page_size": page_size,
    }


def buscar_produto(id: int) -> dict:
    rows = executar_query("administrativo:buscar_produto", params=(id,))
    if not rows:
        raise HTTPException(404, "Produto não encontrado")
    r = rows[0]
    return {
        **fmt_produto(r),
        "altura_cm": float(r["altura_cm"]) if r["altura_cm"] else None,
        "largura_cm": float(r["largura_cm"]) if r["largura_cm"] else None,
        "profundidade_cm": float(r["profundidade_cm"]) if r["profundidade_cm"] else None,
        "id_categoria": r["id_categoria"],
        "id_fornecedor": r["id_fornecedor"],
        "created_at": str(r["created_at"]),
        "update_at": str(r["update_at"]),
    }


def criar_produto(data) -> dict:
    rows = executar_query(
        "administrativo:inserir_produto",
        returning=True,
        params=(
            data.nome_produto, data.descricao, data.id_categoria, data.id_fornecedor,
            data.custo_unitario, data.peso_kg, data.altura_cm, data.largura_cm,
            data.profundidade_cm, data.estoque_min, data.estoque_max, data.ativo,
        ),
    )
    return {"id_produto": rows[0]["id_produto"]}


def atualizar_produto(id: int, data) -> dict:
    rows = executar_query(
        "administrativo:atualizar_produto",
        returning=True,
        params=(
            data.nome_produto, data.descricao, data.id_categoria, data.id_fornecedor,
            data.custo_unitario, data.peso_kg, data.altura_cm, data.largura_cm,
            data.profundidade_cm, data.estoque_min, data.estoque_max, data.ativo, id,
        ),
    )
    if not rows:
        raise HTTPException(404, "Produto não encontrado")
    return {"id_produto": rows[0]["id_produto"]}


def deletar_produto(id: int) -> dict:
    try:
        rows = executar_query("administrativo:deletar_produto", returning=True, params=(id,))
        if not rows:
            raise HTTPException(404, "Produto não encontrado")
        return {"deleted": True, "id_produto": id}
    except HTTPException:
        raise
    except Exception:
        raise HTTPException(409, "Não é possível excluir: produto possui registros vinculados")


# ─────────────────────────────────────────────
# CRUD — Fornecedores
# ─────────────────────────────────────────────

def fmt_fornecedor(r: dict) -> dict:
    return {
        "id": r["id_fornecedor"],
        "nome_fornecedor": r["nome_fornecedor"],
        "cnpj": r["cnpj"],
        "telefone": r["telefone"],
        "endereco_completo": r["endereco_completo"],
        "cidade": r["cidade"],
        "estado": r["estado"],
        "regiao": r["regiao"],
    }


def listar_fornecedores(page: int = 1, page_size: int = 20) -> dict:
    offset = (page - 1) * page_size
    rows = executar_query("administrativo:listar_fornecedores", params=(page_size, offset))
    total = executar_query("administrativo:total_fornecedores")
    return {
        "data": [fmt_fornecedor(r) for r in rows],
        "total": int(total[0]["total"]) if total else 0,
        "page": page,
        "page_size": page_size,
    }


def buscar_fornecedor(id: int) -> dict:
    rows = executar_query("administrativo:buscar_fornecedor", params=(id,))
    if not rows:
        raise HTTPException(404, "Fornecedor não encontrado")
    r = rows[0]
    return {**fmt_fornecedor(r), "created_at": str(r["created_at"]), "update_at": str(r["update_at"])}


def criar_fornecedor(data) -> dict:
    rows = executar_query(
        "administrativo:inserir_fornecedor",
        returning=True,
        params=(data.nome_fornecedor, data.cnpj, data.telefone, data.id_localizacao, data.endereco_completo),
    )
    return {"id_fornecedor": rows[0]["id_fornecedor"]}


def atualizar_fornecedor(id: int, data) -> dict:
    rows = executar_query(
        "administrativo:atualizar_fornecedor",
        returning=True,
        params=(data.nome_fornecedor, data.cnpj, data.telefone, data.id_localizacao, data.endereco_completo, id),
    )
    if not rows:
        raise HTTPException(404, "Fornecedor não encontrado")
    return {"id_fornecedor": rows[0]["id_fornecedor"]}


def deletar_fornecedor(id: int) -> dict:
    try:
        rows = executar_query("administrativo:deletar_fornecedor", returning=True, params=(id,))
        if not rows:
            raise HTTPException(404, "Fornecedor não encontrado")
        return {"deleted": True, "id_fornecedor": id}
    except HTTPException:
        raise
    except Exception:
        raise HTTPException(409, "Não é possível excluir: fornecedor possui registros vinculados")


# ─────────────────────────────────────────────
# CRUD — Canais de Venda
# ─────────────────────────────────────────────

def listar_canais() -> list:
    rows = executar_query("administrativo:listar_canais")
    return [
        {"id": r["id_canal_venda"], "canal_venda": r["canal_venda"], "tipo_canal": r["tipo_canal"], "ativo": r["ativo"]}
        for r in rows
    ]


def buscar_canal(id: int) -> dict:
    rows = executar_query("administrativo:buscar_canal", params=(id,))
    if not rows:
        raise HTTPException(404, "Canal não encontrado")
    r = rows[0]
    return {"id": r["id_canal_venda"], "canal_venda": r["canal_venda"], "tipo_canal": r["tipo_canal"], "ativo": r["ativo"]}


def criar_canal(data) -> dict:
    rows = executar_query(
        "administrativo:inserir_canal",
        returning=True,
        params=(data.canal_venda, data.tipo_canal, data.ativo),
    )
    return {"id_canal_venda": rows[0]["id_canal_venda"]}


def atualizar_canal(id: int, data) -> dict:
    rows = executar_query(
        "administrativo:atualizar_canal",
        returning=True,
        params=(data.canal_venda, data.tipo_canal, data.ativo, id),
    )
    if not rows:
        raise HTTPException(404, "Canal não encontrado")
    return {"id_canal_venda": rows[0]["id_canal_venda"]}


def deletar_canal(id: int) -> dict:
    try:
        rows = executar_query("administrativo:deletar_canal", returning=True, params=(id,))
        if not rows:
            raise HTTPException(404, "Canal não encontrado")
        return {"deleted": True, "id_canal_venda": id}
    except HTTPException:
        raise
    except Exception:
        raise HTTPException(409, "Não é possível excluir: canal possui registros vinculados")
