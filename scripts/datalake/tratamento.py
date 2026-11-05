"""
Regras de tratamento dos pedidos dos canais externos (bronze -> silver).

Funcoes puras, sem acesso a rede ou banco: recebem o documento cru de um canal
(Instagram, Facebook, Marketplace ou Mercado Livre, cada um com um formato) e
devolvem o pedido padronizado, mais a lista de itens. Sao as mesmas regras do
notebook de BD II, reunidas aqui para os scripts de carga reaproveitarem.
"""
import hashlib
import json
import re
import unicodedata
from datetime import datetime

# Caminho de cada informacao dentro do documento de cada canal.
# None = o canal nao informa aquele campo (ausencia real, nao erro).
MAPA_CANAIS = {
    "Instagram": {
        "id": "pedido_instagram_id", "cliente": "cliente.nome", "telefone": "cliente.telefone",
        "cidade": "cliente.cidade", "estado": None, "documento": None, "itens": "itens",
        "valor": "valor_total", "frete": None, "pagamento": "forma_pagamento", "data": "data_pedido",
    },
    "Facebook": {
        "id": "id_pedido_fb", "cliente": "comprador_nome", "telefone": "comprador_telefone",
        "cidade": "cidade_entrega", "estado": None, "documento": "cpf_informado", "itens": "produtos",
        "valor": "total", "frete": None, "pagamento": "pagamento", "data": "criado_em",
    },
    "Marketplace": {
        "id": "order_id", "cliente": "comprador.nome", "telefone": "comprador.telefone",
        "cidade": "endereco_entrega.cidade", "estado": "endereco_entrega.estado",
        "documento": "comprador.documento", "itens": "itens_pedido", "valor": "valor_total_pedido",
        "frete": "valor_frete", "pagamento": "forma_pagamento", "data": "timestamp_pedido",
    },
    "Mercado Livre": {
        "id": "ml_order_id", "cliente": "buyer.full_name", "telefone": "buyer.phone",
        "cidade": "shipping.city", "estado": "shipping.state", "documento": "buyer.document",
        "itens": "items", "valor": "total_amount", "frete": "shipping.cost",
        "pagamento": "payment_method", "data": "order_date",
    },
}

CAMPOS_SO_DIGITOS = {"documento", "document", "cpf_informado", "telefone", "phone", "comprador_telefone"}

# Colunas (e ordem) do schema da silver. Mudou aqui, mudou o contrato: avisar quem consome.
COLUNAS_PEDIDOS = [
    "id_pedido_canal", "canal", "hash_origem", "cliente", "telefone", "cidade", "estado",
    "documento", "tipo_documento", "documento_valido", "qtd_itens", "valor_total", "frete",
    "forma_pagamento", "data_pedido", "alertas", "arquivo_origem", "linha_origem", "processado_em",
]
COLUNAS_ITENS = [
    "id_pedido_canal", "canal", "numero_item", "produto", "quantidade", "preco_unitario", "valor_item",
]


def normalizar_texto(texto):
    texto = unicodedata.normalize("NFC", texto)
    return re.sub(r"\s+", " ", texto).strip()


def sem_acento_minusculo(texto):
    """Chave de comparacao: 'Cartao de Crédito ' -> 'cartao de credito'."""
    base = unicodedata.normalize("NFKD", texto or "")
    return normalizar_texto("".join(c for c in base if not unicodedata.combining(c))).lower()


def limpar_recursivo(valor, chave=None):
    """Limpa textos em qualquer nivel do documento; documento e telefone ficam so com digitos."""
    if isinstance(valor, dict):
        return {k: limpar_recursivo(v, k) for k, v in valor.items()}
    if isinstance(valor, list):
        return [limpar_recursivo(v, chave) for v in valor]
    if isinstance(valor, str):
        if chave in CAMPOS_SO_DIGITOS:
            return re.sub(r"\D", "", valor)
        return normalizar_texto(valor)
    return valor


def cpf_valido(cpf):
    if len(cpf) != 11 or cpf == cpf[0] * 11:
        return False
    for posicao in (9, 10):
        soma = sum(int(cpf[i]) * (posicao + 1 - i) for i in range(posicao))
        if (soma * 10) % 11 % 10 != int(cpf[posicao]):
            return False
    return True


def cnpj_valido(cnpj):
    if len(cnpj) != 14 or cnpj == cnpj[0] * 14:
        return False
    pesos = [5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2]
    for posicao, pesos_posicao in ((12, pesos), (13, [6] + pesos)):
        resto = sum(int(cnpj[i]) * pesos_posicao[i] for i in range(posicao)) % 11
        if (0 if resto < 2 else 11 - resto) != int(cnpj[posicao]):
            return False
    return True


def identificar_canal(doc):
    for canal, mapa in MAPA_CANAIS.items():
        if mapa["id"] in doc:
            return canal
    return None


def ler_caminho(doc, caminho):
    """Le um valor por caminho com pontos ('comprador.documento'); None se algum nivel nao existe."""
    if caminho is None:
        return None
    atual = doc
    for parte in caminho.split("."):
        if not isinstance(atual, dict):
            return None
        atual = atual.get(parte)
    return atual


def hash_documento(bruto):
    """Identidade do pedido bruto: mesmo conteudo gera sempre o mesmo hash (rastreabilidade/dedup)."""
    return hashlib.sha1(json.dumps(bruto, sort_keys=True, ensure_ascii=False).encode("utf-8")).hexdigest()


def _numero(valor):
    try:
        return round(float(valor), 2) if valor is not None else None
    except (TypeError, ValueError):
        return None


def tratar_pedido(bruto):
    """
    Converte um documento cru em (pedido, itens) no schema da silver.
    Devolve None se o canal nao for identificado.
    Problemas de qualidade viram alertas; nada e inventado nem 'consertado' por conta propria.
    """
    canal = identificar_canal(bruto)
    if canal is None:
        return None

    mapa = MAPA_CANAIS[canal]
    doc = limpar_recursivo(bruto)

    itens_brutos = ler_caminho(doc, mapa["itens"]) or []
    documento = ler_caminho(doc, mapa["documento"]) or None
    valor = _numero(ler_caminho(doc, mapa["valor"]))
    frete = _numero(ler_caminho(doc, mapa["frete"]))
    estado = ler_caminho(doc, mapa["estado"])

    try:
        data_pedido = datetime.fromisoformat(ler_caminho(doc, mapa["data"]))
    except (TypeError, ValueError):
        data_pedido = None

    tipo_documento = documento_ok = None
    if documento:
        tipo_documento = {11: "CPF", 14: "CNPJ"}.get(len(documento))
        documento_ok = (
            cpf_valido(documento) if tipo_documento == "CPF"
            else cnpj_valido(documento) if tipo_documento == "CNPJ"
            else False
        )

    itens = []
    for numero, item in enumerate(itens_brutos, start=1):
        quantidade = int(item.get("quantidade") or 0)
        preco = _numero(item.get("preco_unitario"))
        itens.append({
            "numero_item": numero,
            "produto": item.get("produto"),
            "quantidade": quantidade,
            "preco_unitario": preco,
            "valor_item": round(quantidade * preco, 2) if preco is not None else None,
        })

    alertas = []
    if not valor:
        alertas.append("valor_total ausente ou zerado")
    if not itens:
        alertas.append("pedido sem itens")
    if data_pedido is None:
        alertas.append("data do pedido ausente ou invalida")
    if documento and not documento_ok:
        alertas.append("documento invalido")

    id_pedido = ler_caminho(doc, mapa["id"])
    pedido = {
        "id_pedido_canal": str(id_pedido) if id_pedido is not None else None,
        "canal": canal,
        "hash_origem": hash_documento(bruto),
        "cliente": ler_caminho(doc, mapa["cliente"]),
        "telefone": ler_caminho(doc, mapa["telefone"]) or None,
        "cidade": ler_caminho(doc, mapa["cidade"]),
        "estado": estado.upper() if isinstance(estado, str) and estado else None,
        "documento": documento,
        "tipo_documento": tipo_documento,
        "documento_valido": documento_ok,
        "qtd_itens": sum(i["quantidade"] for i in itens),
        "valor_total": valor,
        "frete": frete,
        "forma_pagamento": ler_caminho(doc, mapa["pagamento"]),
        "data_pedido": data_pedido,
        "alertas": "; ".join(alertas),
    }
    for item in itens:
        item["id_pedido_canal"] = pedido["id_pedido_canal"]
        item["canal"] = canal
    return pedido, itens
