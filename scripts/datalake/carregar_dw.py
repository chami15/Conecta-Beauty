"""
Carrega a camada silver (pedidos dos canais externos) no Data Warehouse (Postgres):

    financeiro.fato_pedido  (1 linha por pedido)
    financeiro.fato_venda   (1 linha por item do pedido)

Cria o que faltar nas dimensoes (canais, formas de pagamento, datas e clientes)
e guarda em financeiro.controle_carga_canais o id original de cada pedido, para
rastrear a origem, nao carregar o mesmo pedido duas vezes e conseguir desfazer.

Por seguranca, sem --executar o script so mostra o que faria (nada e gravado).
Tudo roda em uma unica transacao: ou entra tudo, ou nada.

Uso (a partir da pasta backend, de onde o .env e carregado):
    cd backend
    python ../scripts/datalake/carregar_dw.py                       # simulacao
    python ../scripts/datalake/carregar_dw.py --executar --limite 500
    python ../scripts/datalake/carregar_dw.py --executar --atualizar-cubos   # tambem atualiza os cubos
    python ../scripts/datalake/carregar_dw.py --desfazer --executar # remove o que foi carregado
"""
import argparse
import os
import sys
from collections import Counter
from io import BytesIO

import pandas as pd
from dotenv import load_dotenv
from psycopg2 import sql
from psycopg2.extras import execute_values

sys.path.insert(0, os.path.dirname(__file__))
sys.path.insert(0, os.path.join(os.path.dirname(__file__), "..", "..", "backend"))

from lago import abrir
from tratamento import sem_acento_minusculo
from utils.connection import PostgreConn

load_dotenv()

PASTA_SILVER = "pedidos_canais_externos"

TIPO_CANAL = {
    "Instagram": "Online",
    "Facebook": "Online",
    "Marketplace": "Marketplace",
    "Mercado Livre": "Marketplace",
}

# Nome vindo do canal -> nome aceito pela dim_forma_pagamento (que tem um CHECK com esses valores)
FORMA_PAGAMENTO = {
    "pix": "PIX",
    "boleto": "Boleto",
    "cartao de credito": "Crédito",
    "credito": "Crédito",
    "cartao de debito": "Débito",
    "debito": "Débito",
    "dinheiro": "Dinheiro",
    "transferencia": "Transferência",
}

MESES = ["Janeiro", "Fevereiro", "Março", "Abril", "Maio", "Junho", "Julho", "Agosto",
         "Setembro", "Outubro", "Novembro", "Dezembro"]
DIAS_SEMANA = {1: "Segunda-feira", 2: "Terça-feira", 3: "Quarta-feira", 4: "Quinta-feira",
               5: "Sexta-feira", 6: "Sábado", 7: "Domingo"}

STATUS_PEDIDO = "Confirmado"
LOTE = 1000

DDL_CONTROLE = """
CREATE TABLE IF NOT EXISTS financeiro.controle_carga_canais(
    canal VARCHAR(50) NOT NULL,
    id_pedido_canal VARCHAR(100) NOT NULL,
    numero_pedido INT NOT NULL UNIQUE,
    fk_cliente INT NOT NULL,
    cliente_criado BOOLEAN NOT NULL DEFAULT FALSE,
    hash_origem CHAR(40),
    carregado_em TIMESTAMP NOT NULL DEFAULT NOW(),
    PRIMARY KEY (canal, id_pedido_canal)
)
"""


# ---------------------------------------------------------------- utilitarios
def _v(valor):
    """NaN/NaT do pandas viram None."""
    return None if pd.isna(valor) else valor


def _digitos(texto):
    return "".join(c for c in (texto or "") if c.isdigit())


def conectar():
    conexao = PostgreConn().conn
    if conexao is None:
        raise RuntimeError("Nao foi possivel conectar ao Postgres (confira POSTGRES_* no backend/.env)")
    return conexao


def ler_silver(silver):
    pedidos = silver.listar(f"{PASTA_SILVER}/pedidos", ".parquet")
    if not pedidos:
        raise FileNotFoundError("Nenhum arquivo de pedidos na silver - rode tratar_silver.py antes")
    caminho_pedidos = pedidos[-1]  # o nome tem timestamp: o ultimo e o mais recente
    caminho_itens = caminho_pedidos.replace("/pedidos/pedidos_", "/itens/itens_")
    print(f"Silver: {caminho_pedidos}")
    df_pedidos = pd.read_parquet(BytesIO(silver.ler(caminho_pedidos)))
    df_itens = pd.read_parquet(BytesIO(silver.ler(caminho_itens)))
    return df_pedidos, df_itens


# ---------------------------------------------------------------- leitura das dimensoes
def carregar_dimensoes(cur):
    d = {}

    cur.execute("SELECT id_produto, nome_produto FROM administrativo.dim_produtos")
    d["produtos"], d["produtos_repetidos"] = {}, 0
    for id_, nome in cur.fetchall():
        chave = sem_acento_minusculo(nome)
        if chave in d["produtos"]:
            d["produtos_repetidos"] += 1  # nome repetido no catalogo: fica com o primeiro
        else:
            d["produtos"][chave] = id_

    cur.execute("SELECT id_forma_pagamento, forma_pagamento FROM financeiro.dim_forma_pagamento")
    d["formas"] = {nome: id_ for id_, nome in cur.fetchall()}

    cur.execute("SELECT id_canal_venda, canal_venda FROM administrativo.dim_canal_venda")
    d["canais"] = {nome: id_ for id_, nome in cur.fetchall()}

    cur.execute("SELECT id_tempo, data FROM geral.dim_tempo")
    d["tempo"] = {data: id_ for id_, data in cur.fetchall()}

    cur.execute("SELECT id_localizacao, cidade, estado FROM geral.dim_localizacao")
    d["loc_exata"], d["loc_por_cidade"] = {}, {}
    for id_, cidade, estado in cur.fetchall():
        cidade_n = sem_acento_minusculo(cidade)
        d["loc_exata"][(cidade_n, (estado or "").strip().upper())] = id_
        d["loc_por_cidade"].setdefault(cidade_n, set()).add(id_)

    cur.execute("SELECT id_cliente, nome, documento, telefone FROM administrativo.dim_clientes")
    d["cli_por_doc"], d["cli_por_nome_tel"] = {}, {}
    for id_, nome, documento, telefone in cur.fetchall():
        if documento:
            d["cli_por_doc"].setdefault(_digitos(documento), id_)
        if telefone:
            d["cli_por_nome_tel"].setdefault((sem_acento_minusculo(nome), _digitos(telefone)), id_)
    return d


def tabela_controle_existe(cur):
    cur.execute("SELECT to_regclass('financeiro.controle_carga_canais') IS NOT NULL")
    return cur.fetchone()[0]


# ---------------------------------------------------------------- validacao e mapeamento
def localizar(dim, cidade, estado):
    """Reaproveita uma localizacao existente. Nunca cria: sem correspondencia, o cliente fica sem localizacao."""
    cidade_n = sem_acento_minusculo(cidade or "")
    if not cidade_n:
        return None
    if estado:
        return dim["loc_exata"].get((cidade_n, estado.strip().upper()))
    candidatas = dim["loc_por_cidade"].get(cidade_n, set())
    return next(iter(candidatas)) if len(candidatas) == 1 else None  # ambigua = nao chuta


def preparar(df_pedidos, df_itens, dim, ja_carregados, limite):
    """Valida cada pedido e monta o plano de carga. Devolve (aceitos, rejeitados[Counter], ja_existiam)."""
    itens_por_pedido = {}
    for linha in df_itens.itertuples(index=False):
        itens_por_pedido.setdefault((linha.canal, linha.id_pedido_canal), []).append(linha)

    aceitos, rejeitados, ja_existiam = [], Counter(), 0
    for p in df_pedidos.itertuples(index=False):
        chave = (p.canal, p.id_pedido_canal)
        if chave in ja_carregados:
            ja_existiam += 1
            continue

        data_pedido, valor = _v(p.data_pedido), _v(p.valor_total)
        itens = itens_por_pedido.get(chave, [])
        forma = FORMA_PAGAMENTO.get(sem_acento_minusculo(_v(p.forma_pagamento) or ""))

        motivo = None
        if data_pedido is None:
            motivo = "data do pedido ausente ou invalida"
        elif not valor:
            motivo = "valor total ausente ou zerado"
        elif not itens:
            motivo = "pedido sem itens"
        elif not _v(p.cliente):
            motivo = "pedido sem nome de cliente"
        elif forma is None:
            motivo = "forma de pagamento desconhecida"
        elif any(i.preco_unitario is None or pd.isna(i.preco_unitario) or not i.quantidade for i in itens):
            motivo = "item sem preco ou quantidade"
        elif any(sem_acento_minusculo(i.produto or "") not in dim["produtos"] for i in itens):
            motivo = "produto fora do catalogo"
        elif abs(sum(i.valor_item for i in itens) - valor) > 0.01:
            motivo = "total diverge da soma dos itens"
        if motivo:
            rejeitados[motivo] += 1
            continue

        aceitos.append({"p": p, "itens": itens, "forma": forma, "data": pd.Timestamp(data_pedido)})

    aceitos.sort(key=lambda a: (a["data"], a["p"].canal, a["p"].id_pedido_canal))
    if limite:
        aceitos = aceitos[:limite]
    return aceitos, rejeitados, ja_existiam


def resolver_clientes(aceitos, dim):
    """Para cada pedido, acha o cliente existente ou agrupa os novos. Devolve (novos, contagens)."""
    novos, contagens = {}, Counter()
    for a in aceitos:
        p = a["p"]
        documento = _digitos(_v(p.documento)) if bool(_v(p.documento_valido)) else ""
        telefone = _digitos(_v(p.telefone))
        nome_n = sem_acento_minusculo(p.cliente)

        existente = dim["cli_por_doc"].get(documento) if documento else None
        if existente is None and telefone:
            existente = dim["cli_por_nome_tel"].get((nome_n, telefone))
        if existente is not None:
            a["cliente"] = ("existente", existente)
            contagens["clientes reaproveitados"] += 1
            continue

        chave = documento or f"{nome_n}|{telefone}|{sem_acento_minusculo(_v(p.cidade) or '')}"
        if chave not in novos:
            loc = localizar(dim, _v(p.cidade), _v(p.estado))
            novos[chave] = {"nome": p.cliente[:200], "documento": documento or None,
                            "telefone": telefone[:20] or None, "fk_localizacao": loc}
            contagens["clientes novos"] += 1
            contagens["  com localizacao" if loc else "  sem localizacao"] += 1
        a["cliente"] = ("novo", chave)
    return novos, contagens


# ---------------------------------------------------------------- gravacao
def garantir_datas(cur, datas, dim):
    faltantes = sorted({d for d in datas if d not in dim["tempo"]})
    if not faltantes:
        return 0
    cur.execute("SELECT DISTINCT mes, nome_mes FROM geral.dim_tempo")
    meses = {mes: nome for mes, nome in cur.fetchall()}
    cur.execute("SELECT DISTINCT EXTRACT(ISODOW FROM data)::int, dia_semana FROM geral.dim_tempo")
    dias = {dow: nome for dow, nome in cur.fetchall()}
    linhas = [
        (d, d.day, d.month, meses.get(d.month, MESES[d.month - 1]), (d.month - 1) // 3 + 1, d.year,
         dias.get(d.isoweekday(), DIAS_SEMANA[d.isoweekday()]))
        for d in faltantes
    ]
    execute_values(cur, """INSERT INTO geral.dim_tempo (data, dia, mes, nome_mes, trimestre, ano, dia_semana)
                           VALUES %s ON CONFLICT (data) DO NOTHING""", linhas)
    cur.execute("SELECT id_tempo, data FROM geral.dim_tempo WHERE data = ANY(%s)", (faltantes,))
    dim["tempo"].update({data: id_ for id_, data in cur.fetchall()})
    return len(faltantes)


def garantir_canais_e_formas(cur, aceitos, dim):
    criados = Counter()
    for canal in sorted({a["p"].canal for a in aceitos} - set(dim["canais"])):
        cur.execute("""INSERT INTO administrativo.dim_canal_venda (canal_venda, tipo_canal)
                       VALUES (%s, %s) RETURNING id_canal_venda""", (canal, TIPO_CANAL[canal]))
        dim["canais"][canal] = cur.fetchone()[0]
        criados["canais"] += 1
    for forma in sorted({a["forma"] for a in aceitos} - set(dim["formas"])):
        cur.execute("""INSERT INTO financeiro.dim_forma_pagamento (forma_pagamento)
                       VALUES (%s) RETURNING id_forma_pagamento""", (forma,))
        dim["formas"][forma] = cur.fetchone()[0]
        criados["formas de pagamento"] += 1
    return criados


def inserir_clientes(cur, novos):
    """Reserva os ids na sequence e insere em lote (nao depende da ordem do RETURNING)."""
    if not novos:
        return {}
    cur.execute("""SELECT nextval(pg_get_serial_sequence('administrativo.dim_clientes', 'id_cliente'))
                   FROM generate_series(1, %s)""", (len(novos),))
    ids = [linha[0] for linha in cur.fetchall()]
    mapa = dict(zip(novos.keys(), ids))
    linhas = [(mapa[k], c["nome"], c["documento"], c["fk_localizacao"], c["telefone"]) for k, c in novos.items()]
    execute_values(cur, """INSERT INTO administrativo.dim_clientes
                           (id_cliente, nome, documento, fk_localizacao, telefone) VALUES %s""",
                   linhas, page_size=LOTE)
    return mapa


def gravar(cur, aceitos, novos, dim):
    cur.execute(DDL_CONTROLE)

    criados = garantir_canais_e_formas(cur, aceitos, dim)
    criados["datas"] = garantir_datas(cur, {a["data"].date() for a in aceitos}, dim)
    mapa_novos = inserir_clientes(cur, novos)

    cur.execute("""SELECT GREATEST(
                       COALESCE((SELECT MAX(numero_pedido) FROM financeiro.fato_venda), 0),
                       COALESCE((SELECT MAX(numero_pedido) FROM financeiro.fato_pedido), 0),
                       COALESCE((SELECT MAX(numero_pedido) FROM financeiro.controle_carga_canais), 0))""")
    proximo = cur.fetchone()[0] + 1

    pedidos, vendas, controle = [], [], []
    for numero, a in enumerate(aceitos, start=proximo):
        p, data = a["p"], a["data"]
        tipo, ref = a["cliente"]
        fk_cliente = ref if tipo == "existente" else mapa_novos[ref]
        fk_tempo = dim["tempo"][data.date()]
        fk_canal = dim["canais"][p.canal]
        fk_forma = dim["formas"][a["forma"]]
        frete = _v(p.frete)

        pedidos.append((numero, fk_tempo, fk_cliente, fk_canal, fk_forma, int(p.qtd_itens),
                        float(p.valor_total), None if frete is None else float(frete),
                        STATUS_PEDIDO, data.to_pydatetime()))
        for i in a["itens"]:
            vendas.append((numero, int(i.numero_item), fk_tempo, fk_cliente,
                           dim["produtos"][sem_acento_minusculo(i.produto)], fk_canal, fk_forma,
                           int(i.quantidade), float(i.preco_unitario), float(i.valor_item),
                           data.to_pydatetime()))
        controle.append((p.canal, p.id_pedido_canal, numero, fk_cliente, tipo == "novo", _v(p.hash_origem)))

    execute_values(cur, """INSERT INTO financeiro.fato_pedido
        (numero_pedido, fk_tempo, fk_cliente, fk_canal_venda, fk_forma_pagamento, qtd_itens,
         valor_total, valor_frete, status_pedido, data_hora_pedido) VALUES %s""", pedidos, page_size=LOTE)
    execute_values(cur, """INSERT INTO financeiro.fato_venda
        (numero_pedido, numero_item, fk_tempo, fk_cliente, fk_produto, fk_canal_venda, fk_forma_pagamento,
         quantidade, valor_unitario, valor_total, data_hora_venda) VALUES %s""", vendas, page_size=LOTE)
    execute_values(cur, """INSERT INTO financeiro.controle_carga_canais
        (canal, id_pedido_canal, numero_pedido, fk_cliente, cliente_criado, hash_origem) VALUES %s""",
                   controle, page_size=LOTE)
    return criados, len(pedidos), len(vendas), (proximo, proximo + len(pedidos) - 1)


# ---------------------------------------------------------------- desfazer
def desfazer(conexao, executar):
    cur = conexao.cursor()
    if not tabela_controle_existe(cur):
        print("Nada a desfazer: a tabela de controle nao existe.")
        return
    cur.execute("SELECT numero_pedido, fk_cliente, cliente_criado FROM financeiro.controle_carga_canais")
    linhas = cur.fetchall()
    numeros = [n for n, _, _ in linhas]
    clientes_criados = sorted({c for _, c, criado in linhas if criado})
    print("===== DESFAZER CARGA DOS CANAIS EXTERNOS =====")
    print(f"Pedidos a remover:   {len(numeros)}")
    print(f"Clientes criados:    {len(clientes_criados)} (so sao removidos se nao tiverem outras vendas)")
    if not executar:
        print("\nSimulacao: nada foi alterado. Use --executar para desfazer de verdade.")
        return

    cur.execute("DELETE FROM financeiro.fato_venda WHERE numero_pedido = ANY(%s)", (numeros,))
    vendas = cur.rowcount
    cur.execute("DELETE FROM financeiro.fato_pedido WHERE numero_pedido = ANY(%s)", (numeros,))
    pedidos = cur.rowcount
    cur.execute("DELETE FROM financeiro.controle_carga_canais")
    cur.execute("""DELETE FROM administrativo.dim_clientes c WHERE c.id_cliente = ANY(%s)
                   AND NOT EXISTS (SELECT 1 FROM financeiro.fato_venda v WHERE v.fk_cliente = c.id_cliente)
                   AND NOT EXISTS (SELECT 1 FROM financeiro.fato_pedido p WHERE p.fk_cliente = c.id_cliente)""",
                (clientes_criados,))
    clientes = cur.rowcount
    conexao.commit()
    print(f"Removidos: {pedidos} pedidos, {vendas} itens de venda, {clientes} clientes.")
    print("(Os canais, formas de pagamento e datas criados nas dimensoes ficam: sao inofensivos.)")


# ---------------------------------------------------------------- principal
def atualizar_cubos(conexao):
    """
    REFRESH simples dos cubos OLAP. A procedure atualizar_cubos_olap() nao serve aqui: ela usa
    REFRESH ... CONCURRENTLY, que exige um indice unico em cada view, e hoje as views nao tem.
    """
    conexao.commit()  # fecha qualquer transacao aberta: o autocommit so pode mudar fora de uma
    conexao.autocommit = True
    cur = conexao.cursor()
    cur.execute("""SELECT schemaname, matviewname FROM pg_matviews
                   WHERE schemaname IN ('financeiro', 'estoque') ORDER BY 1, 2""")
    for schema, nome in cur.fetchall():
        cur.execute(sql.SQL("REFRESH MATERIALIZED VIEW {}.{}").format(sql.Identifier(schema), sql.Identifier(nome)))
        print(f"  Cubo atualizado: {schema}.{nome}")


def main():
    parser = argparse.ArgumentParser(description="Silver (pedidos dos canais) -> Data Warehouse (Postgres)")
    parser.add_argument("--silver-local", help="pasta local com a silver (em vez do container silver)")
    parser.add_argument("--executar", action="store_true", help="grava de verdade (sem isso, so simula)")
    parser.add_argument("--limite", type=int, help="carrega no maximo N pedidos novos (amostra)")
    parser.add_argument("--atualizar-cubos", action="store_true", help="atualiza os cubos OLAP ao final")
    parser.add_argument("--desfazer", action="store_true", help="remove o que esta script carregou")
    args = parser.parse_args()

    conexao = conectar()
    try:
        if args.desfazer:
            desfazer(conexao, args.executar)
            return

        df_pedidos, df_itens = ler_silver(abrir("silver", args.silver_local))
        cur = conexao.cursor()

        ja_carregados = set()
        if tabela_controle_existe(cur):
            cur.execute("SELECT canal, id_pedido_canal FROM financeiro.controle_carga_canais")
            ja_carregados = set(cur.fetchall())

        dim = carregar_dimensoes(cur)
        aceitos, rejeitados, ja_existiam = preparar(df_pedidos, df_itens, dim, ja_carregados, args.limite)
        novos, cont_clientes = resolver_clientes(aceitos, dim)

        print("\n===== SILVER -> DATA WAREHOUSE =====")
        print(f"Pedidos na silver:              {len(df_pedidos)}")
        print(f"  Ja carregados antes:          {ja_existiam}")
        print(f"  Rejeitados:                   {sum(rejeitados.values())}")
        for motivo, qtd in rejeitados.most_common():
            print(f"    {qtd:>6}  {motivo}")
        print(f"  A carregar agora:             {len(aceitos)}")
        for nome, qtd in cont_clientes.items():
            print(f"    {nome}: {qtd}")
        if dim["produtos_repetidos"]:
            print(f"  Aviso: {dim['produtos_repetidos']} nome(s) de produto repetido(s) no catalogo (usado o primeiro).")

        if not args.executar:
            print("\nSimulacao: nada foi gravado. Use --executar para carregar.")
            return
        if aceitos:
            criados, n_pedidos, n_vendas, faixa = gravar(cur, aceitos, novos, dim)
            conexao.commit()
            print("\nCarga concluida (transacao confirmada):")
            print(f"  fato_pedido: {n_pedidos} | fato_venda: {n_vendas} | numero_pedido {faixa[0]} a {faixa[1]}")
            for nome, qtd in criados.items():
                if qtd:
                    print(f"  criados nas dimensoes - {nome}: {qtd}")
        else:
            print("\nNada novo para carregar.")

        if args.atualizar_cubos:
            atualizar_cubos(conexao)
        elif aceitos:
            print("  Cubos OLAP nao atualizados (use --atualizar-cubos).")
    except Exception:
        conexao.rollback()
        raise
    finally:
        conexao.close()


if __name__ == "__main__":
    main()
