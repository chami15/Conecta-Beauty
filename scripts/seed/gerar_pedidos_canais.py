"""
Gera pedidos sinteticos simulando 4 canais de venda externos (Instagram, Facebook,
Marketplace e Mercado Livre), cada um com um formato de documento diferente -
exatamente o cenario que justifica o uso de um banco NoSQL (schema flexivel).

Os produtos usados nos pedidos vem do catalogo real do Postgres (dim_produtos),
via a query administrativo `seed:produtos_ativos`. Cliente, cidade e telefone sao
gerados aleatoriamente com Faker.

Para os pedidos serem coerentes com o historico do ERP (2021 a 2026), o gerador segue
as mesmas proporcoes medidas nas vendas ja existentes no banco:
- datas: distribuidas mes a mes na proporcao do volume de pedidos do ERP no periodo
  (mesmo crescimento e sazonalidade); sem vendas no periodo, distribuicao uniforme;
- itens por pedido, unidades por item e margem sobre o custo: as distribuicoes do ERP
  (media de 2,1 itens por pedido, 1 a 3 unidades em 94% dos itens, preco = custo x 2,2).

Saida: um arquivo .jsonl (1 documento JSON por linha) em scripts/seed/output/.
Esse arquivo representa a camada bronze do Data Lake - o dado exatamente como
"chegou". A extracao, limpeza/tratamento e carga desse arquivo no Cosmos DB
(colecao pedidos_canais_externos) e feita no notebook da issue #12
(Programação em Banco de Dados II).

Com --enviar-bronze o arquivo tambem sobe para bronze/gerados_por_script no Data Lake,
sempre com o mesmo nome: o envio substitui o arquivo anterior (a silver le todos os
.jsonl da pasta, entao dois arquivos duplicariam os pedidos).

Uso:
    cd backend && python ../scripts/seed/gerar_pedidos_canais.py --enviar-bronze
    python ../scripts/seed/gerar_pedidos_canais.py --total 3000 --inicio 2024-01-01 --fim 2026-06-09
"""
import argparse
import json
import os
import random
import sys
import uuid
from calendar import monthrange
from datetime import date, datetime, timedelta

sys.path.insert(0, os.path.join(os.path.dirname(__file__), "..", "..", "backend"))
sys.path.insert(0, os.path.join(os.path.dirname(__file__), "..", "datalake"))

from faker import Faker
from utils.query_executor import executar_query

fake = Faker("pt_BR")

FORMAS_PAGAMENTO = ["Pix", "Cartao de credito", "Boleto", "Cartao de debito"]

# Distribuicoes medidas nas vendas do ERP (fato_venda, 2021 a 2026).
ITENS_POR_PEDIDO = {1: 40, 2: 29, 3: 19, 4: 8, 5: 4}                  # % dos pedidos
UNIDADES_POR_ITEM = {1: 31, 2: 31, 3: 32, 4: 1, 5: 1.5, 6: 1.5, 7: 1.5, 8: 1.5}  # % dos itens
MARGEM_MIN, MARGEM_MAX = 1.84, 2.56   # preco de venda / custo (P10 e P90 do ERP; media 2,2)

PASTA_BRONZE = "gerados_por_script"  # mesma pasta lida pelo tratar_silver.py e pelo notebook
NOME_ARQUIVO = "pedidos_canais_externos.jsonl"

INICIO_PADRAO = "2021-01-01"
FIM_PADRAO = "2026-06-09"             # ultimo dia com venda no ERP
TOTAL_PADRAO = 2000                   # ~31 pedidos/mes, perto de 40% do volume do ERP


def carregar_produtos() -> list[dict]:
    produtos = executar_query("seed:produtos_ativos")
    if not produtos:
        raise RuntimeError(
            "Nenhum produto ativo encontrado em administrativo.dim_produtos. "
            "Confirme que o schema foi migrado e populado antes de rodar este script."
        )
    return produtos


def _sortear(distribuicao: dict) -> int:
    return random.choices(list(distribuicao), weights=list(distribuicao.values()))[0]


def _itens_aleatorios(produtos: list[dict]) -> list[dict]:
    escolhidos = random.sample(produtos, k=min(_sortear(ITENS_POR_PEDIDO), len(produtos)))
    itens = []
    for p in escolhidos:
        qtd = _sortear(UNIDADES_POR_ITEM)
        preco_venda = round(float(p["custo_unitario"]) * random.uniform(MARGEM_MIN, MARGEM_MAX), 2)
        itens.append({
            "produto": p["nome_produto"],
            "quantidade": qtd,
            "preco_unitario": preco_venda,
        })
    return itens


class SorteioDatas:
    """Sorteia a data de cada pedido entre inicio e fim, mes a mes na proporcao do ERP."""

    def __init__(self, inicio: date, fim: date):
        self.inicio, self.fim = inicio, fim
        linhas = executar_query("seed:pedidos_por_mes", params=(inicio, fim + timedelta(days=1)))
        self.meses = [(int(r["ano"]), int(r["mes"])) for r in linhas]
        self.pesos = [int(r["pedidos"]) for r in linhas]
        if not self.meses:  # banco sem vendas no periodo: todos os meses com o mesmo peso
            ano, mes = inicio.year, inicio.month
            while (ano, mes) <= (fim.year, fim.month):
                self.meses.append((ano, mes))
                ano, mes = (ano + 1, 1) if mes == 12 else (ano, mes + 1)
            self.pesos = [1] * len(self.meses)

    def descrever(self) -> str:
        origem = "volume mensal do ERP" if len(set(self.pesos)) > 1 else "uniforme"
        return f"{self.inicio:%d/%m/%Y} a {self.fim:%d/%m/%Y}, {len(self.meses)} meses, distribuicao {origem}"

    def sortear(self) -> datetime:
        ano, mes = random.choices(self.meses, weights=self.pesos)[0]
        primeiro = max(date(ano, mes, 1), self.inicio)
        ultimo = min(date(ano, mes, monthrange(ano, mes)[1]), self.fim)
        dia = primeiro + timedelta(days=random.randint(0, (ultimo - primeiro).days))
        return datetime(dia.year, dia.month, dia.day, random.randint(8, 21), random.randint(0, 59), random.randint(0, 59))


_datas: SorteioDatas | None = None


def _data_pedido_aleatoria() -> datetime:
    return _datas.sortear()


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


def gerar_pedidos(total: int, inicio: date, fim: date) -> list[dict]:
    global _datas
    produtos = carregar_produtos()
    _datas = SorteioDatas(inicio, fim)
    print(f"Periodo: {_datas.descrever()}")
    pedidos = []
    for _ in range(total):
        gerar = random.choice(GERADORES)
        pedidos.append(gerar(produtos))
    return pedidos


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--total", type=int, default=TOTAL_PADRAO, help="Quantidade de pedidos a gerar")
    parser.add_argument("--inicio", type=date.fromisoformat, default=date.fromisoformat(INICIO_PADRAO),
                        help=f"primeira data dos pedidos, AAAA-MM-DD (padrao: {INICIO_PADRAO})")
    parser.add_argument("--fim", type=date.fromisoformat, default=date.fromisoformat(FIM_PADRAO),
                        help=f"ultima data dos pedidos, AAAA-MM-DD (padrao: {FIM_PADRAO})")
    parser.add_argument(
        "--saida",
        default=os.path.join(os.path.dirname(__file__), "output", NOME_ARQUIVO),
        help="Caminho do arquivo .jsonl de saida",
    )
    parser.add_argument("--enviar-bronze", action="store_true",
                        help=f"sobe o arquivo para bronze/{PASTA_BRONZE} no Data Lake (substitui o anterior)")
    parser.add_argument("--bronze-local", help="com --enviar-bronze, grava numa pasta local em vez do Data Lake (teste)")
    args = parser.parse_args()
    if args.inicio > args.fim:
        parser.error("--inicio deve ser anterior a --fim")

    os.makedirs(os.path.dirname(args.saida), exist_ok=True)

    print(f"Gerando {args.total} pedidos sinteticos (4 canais)...")
    pedidos = gerar_pedidos(args.total, args.inicio, args.fim)

    with open(args.saida, "w", encoding="utf-8") as f:
        for pedido in pedidos:
            f.write(json.dumps(pedido, ensure_ascii=False) + "\n")

    print(f"OK: {len(pedidos)} pedidos gravados em {args.saida}")

    if args.enviar_bronze:
        from lago import abrir

        caminho = f"{PASTA_BRONZE}/{NOME_ARQUIVO}"
        with open(args.saida, "rb") as f:
            abrir("bronze", args.bronze_local).gravar(caminho, f.read())
        print(f"Enviado: bronze/{caminho} (substitui o arquivo anterior)")


if __name__ == "__main__":
    main()
