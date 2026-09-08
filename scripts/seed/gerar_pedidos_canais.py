"""
Gera pedidos sinteticos simulando 4 canais de venda externos (Instagram, Facebook,
Marketplace e Mercado Livre), cada um com um formato de documento diferente -
exatamente o cenario que justifica o uso de um banco NoSQL (schema flexivel).

Os produtos usados nos pedidos vem do catalogo real do Postgres (dim_produtos),
via a query administrativo `seed:produtos_ativos`. Cliente, cidade e telefone sao
gerados aleatoriamente com Faker.

Saida: um arquivo .jsonl (1 documento JSON por linha) em scripts/seed/output/,
que depois e carregado no Cosmos DB pelo carregar_pedidos_cosmos.py. Esse arquivo
representa a camada bronze do Data Lake - o dado exatamente como "chegou".

Uso:
    cd backend && python ../scripts/seed/gerar_pedidos_canais.py --total 10000
"""
import argparse
import json
import os
import random
import sys
import uuid
from datetime import datetime, timedelta

sys.path.insert(0, os.path.join(os.path.dirname(__file__), "..", "..", "backend"))

from faker import Faker
from utils.query_executor import executar_query

fake = Faker("pt_BR")

FORMAS_PAGAMENTO = ["Pix", "Cartao de credito", "Boleto", "Cartao de debito"]


def carregar_produtos() -> list[dict]:
    produtos = executar_query("seed:produtos_ativos")
    if not produtos:
        raise RuntimeError(
            "Nenhum produto ativo encontrado em administrativo.dim_produtos. "
            "Confirme que o schema foi migrado e populado antes de rodar este script."
        )
    return produtos


def _itens_aleatorios(produtos: list[dict], min_itens=1, max_itens=4) -> list[dict]:
    escolhidos = random.sample(produtos, k=min(random.randint(min_itens, max_itens), len(produtos)))
    itens = []
    for p in escolhidos:
        qtd = random.randint(1, 5)
        preco_venda = round(float(p["custo_unitario"]) * random.uniform(1.3, 2.2), 2)
        itens.append({
            "produto": p["nome_produto"],
            "quantidade": qtd,
            "preco_unitario": preco_venda,
        })
    return itens


def _data_pedido_aleatoria() -> datetime:
    dias_atras = random.randint(0, 365)
    return datetime.now() - timedelta(days=dias_atras, hours=random.randint(0, 23))


# ---------------------------------------------------------------------------
# Cada função abaixo representa o formato "cru" de um canal diferente.
# Propositalmente inconsistentes entre si (nomes de campo, aninhamento,
# presença ou ausência de CPF/CNPJ) - é o schema flexível que o NoSQL permite.
# ---------------------------------------------------------------------------

def gerar_pedido_instagram(produtos: list[dict]) -> dict:
    itens = _itens_aleatorios(produtos)
    return {
        "canal": "Instagram",
        "pedido_instagram_id": f"IG-{uuid.uuid4().hex[:8].upper()}",
        "cliente": {
            "nome": fake.name(),
            "telefone": fake.phone_number(),
            "cidade": fake.city(),
        },
        "itens": itens,
        "valor_total": round(sum(i["quantidade"] * i["preco_unitario"] for i in itens), 2),
        "forma_pagamento": random.choice(FORMAS_PAGAMENTO),
        "data_pedido": _data_pedido_aleatoria().isoformat(),
        "combinado_via_direct": random.choice([True, False]),
        # Instagram normalmente não coleta CPF/CNPJ - propositalmente ausente
    }


def gerar_pedido_facebook(produtos: list[dict]) -> dict:
    itens = _itens_aleatorios(produtos)
    valor_total = round(sum(i["quantidade"] * i["preco_unitario"] for i in itens), 2)
    doc = {
        "origem": "Facebook",
        "id_pedido_fb": str(uuid.uuid4()),
        "comprador_nome": fake.name(),
        "comprador_telefone": fake.phone_number(),
        "cidade_entrega": fake.city(),
        "produtos": itens,
        "total": valor_total,
        "pagamento": random.choice(FORMAS_PAGAMENTO),
        "criado_em": _data_pedido_aleatoria().isoformat(),
    }
    # Às vezes o cliente informa CPF no chat, às vezes não - realista e proposital
    if random.random() < 0.4:
        doc["cpf_informado"] = fake.cpf()
    return doc


def gerar_pedido_marketplace(produtos: list[dict]) -> dict:
    itens = _itens_aleatorios(produtos)
    valor_total = round(sum(i["quantidade"] * i["preco_unitario"] for i in itens), 2)
    is_pj = random.random() < 0.15  # uma fatia pequena de compradores B2B
    return {
        "canal_venda": "Marketplace",
        "order_id": f"MKT{random.randint(100000, 999999)}",
        "comprador": {
            "nome": fake.name() if not is_pj else fake.company(),
            "documento": fake.cnpj() if is_pj else fake.cpf(),
            "tipo_documento": "CNPJ" if is_pj else "CPF",
            "telefone": fake.phone_number(),
        },
        "endereco_entrega": {
            "cidade": fake.city(),
            "estado": fake.estado_sigla(),
        },
        "itens_pedido": itens,
        "valor_total_pedido": valor_total,
        "valor_frete": round(random.uniform(0, 45), 2),
        "forma_pagamento": random.choice(FORMAS_PAGAMENTO),
        "timestamp_pedido": _data_pedido_aleatoria().isoformat(),
    }


def gerar_pedido_mercado_livre(produtos: list[dict]) -> dict:
    itens = _itens_aleatorios(produtos)
    valor_total = round(sum(i["quantidade"] * i["preco_unitario"] for i in itens), 2)
    return {
        "channel": "Mercado Livre",
        "ml_order_id": f"ML{random.randint(1_000_000_000, 9_999_999_999)}",
        "buyer": {
            "full_name": fake.name(),
            # Mercado Livre exige documento fiscal do comprador - sempre presente
            "document": fake.cpf(),
            "phone": fake.phone_number(),
        },
        "shipping": {
            "city": fake.city(),
            "state": fake.estado_sigla(),
            "cost": round(random.uniform(0, 60), 2),
        },
        "items": itens,
        "total_amount": valor_total,
        "payment_method": random.choice(FORMAS_PAGAMENTO),
        "reputation_bonus_applied": random.choice([True, False]),
        "order_date": _data_pedido_aleatoria().isoformat(),
    }


GERADORES = [
    gerar_pedido_instagram,
    gerar_pedido_facebook,
    gerar_pedido_marketplace,
    gerar_pedido_mercado_livre,
]


def gerar_pedidos(total: int) -> list[dict]:
    produtos = carregar_produtos()
    pedidos = []
    for _ in range(total):
        gerar = random.choice(GERADORES)
        pedidos.append(gerar(produtos))
    return pedidos


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--total", type=int, default=10000, help="Quantidade de pedidos a gerar")
    parser.add_argument(
        "--saida",
        default=os.path.join(os.path.dirname(__file__), "output", "pedidos_canais_externos.jsonl"),
        help="Caminho do arquivo .jsonl de saida",
    )
    args = parser.parse_args()

    os.makedirs(os.path.dirname(args.saida), exist_ok=True)

    print(f"Gerando {args.total} pedidos sinteticos (4 canais)...")
    pedidos = gerar_pedidos(args.total)

    with open(args.saida, "w", encoding="utf-8") as f:
        for pedido in pedidos:
            f.write(json.dumps(pedido, ensure_ascii=False) + "\n")

    print(f"OK: {len(pedidos)} pedidos gravados em {args.saida}")


if __name__ == "__main__":
    main()
