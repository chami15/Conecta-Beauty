"""
Testa a conexão com o banco de dados PostgreSQL e verifica
se os schemas, tabelas principais e dados estão presentes.

Como rodar:
    cd backend
    python tests/test_banco.py
"""

import sys
from pathlib import Path
sys.path.append(str(Path(__file__).resolve().parent.parent))

from utils.connection import PostgreConn

VERDE  = "\033[92m"
VERM   = "\033[91m"
AMARELO = "\033[93m"
RESET  = "\033[0m"
NEGRITO = "\033[1m"

passou = []
falhou = []


def ok(msg):
    print(f"  {VERDE}✓{RESET}  {msg}")
    passou.append(msg)


def fail(msg, detalhe=""):
    detalhe_str = f" → {AMARELO}{detalhe}{RESET}" if detalhe else ""
    print(f"  {VERM}✗{RESET}  {msg}{detalhe_str}")
    falhou.append(msg)


def secao(titulo):
    print(f"\n{NEGRITO}{titulo}{RESET}")


# ─── Conexão ─────────────────────────────────────────────
secao("1. Conexão com o banco")
db = PostgreConn()

if db.conn and db.cur:
    ok("Conexão estabelecida com sucesso")
else:
    fail("Não foi possível conectar ao banco", "Verifique o arquivo .env e se o PostgreSQL está rodando")
    print(f"\n{VERM}Abortando: sem conexão com o banco.{RESET}")
    sys.exit(1)

# ─── Schemas ─────────────────────────────────────────────
secao("2. Schemas")
SCHEMAS = ["administrativo", "financeiro", "estoque", "geral"]

db.execute(
    "SELECT schema_name FROM information_schema.schemata WHERE schema_name = ANY(%s)",
    (SCHEMAS,)
)
existentes = {row[0] for row in db.fetchall()}

for schema in SCHEMAS:
    if schema in existentes:
        ok(f"Schema '{schema}' encontrado")
    else:
        fail(f"Schema '{schema}' não encontrado")

# ─── Tabelas principais ───────────────────────────────────
secao("3. Tabelas principais")
TABELAS = [
    ("financeiro",     "fato_venda"),
    ("financeiro",     "fato_pedido"),
    ("financeiro",     "fato_transacao_financeira"),
    ("estoque",        "fato_movimentacao_estoque"),
    ("estoque",        "fato_pedido_frete"),
    ("administrativo", "dim_produtos"),
    ("geral",          "dim_tempo"),
]

db.execute(
    """
    SELECT table_schema, table_name
    FROM information_schema.tables
    WHERE table_schema = ANY(%s) AND table_type = 'BASE TABLE'
    """,
    ([s for s, _ in TABELAS],)
)
tabelas_existentes = {(row[0], row[1]) for row in db.fetchall()}

for schema, tabela in TABELAS:
    if (schema, tabela) in tabelas_existentes:
        ok(f"{schema}.{tabela}")
    else:
        fail(f"{schema}.{tabela} não encontrada")

# ─── Dados (contagem de linhas) ────────────────────────────
secao("4. Dados nas tabelas")
CONTAGENS = [
    ("financeiro.fato_venda",                   "Vendas"),
    ("financeiro.fato_transacao_financeira",    "Transações financeiras"),
    ("estoque.fato_movimentacao_estoque",        "Movimentações de estoque"),
    ("administrativo.dim_produtos",             "Produtos"),
    ("geral.dim_tempo",                         "Dimensão tempo"),
]

for tabela, label in CONTAGENS:
    try:
        db.execute(f"SELECT COUNT(*) FROM {tabela}")
        count = db.fetchone()[0]
        if count > 0:
            ok(f"{label}: {count:,} registros")
        else:
            fail(f"{label}: tabela vazia (0 registros)", "Execute o dump SQL para popular o banco")
    except Exception as e:
        fail(f"{label}: erro ao consultar", str(e))

# ─── Materialized Views ───────────────────────────────────
secao("5. Materialized Views (cubos OLAP)")
MVS = [
    ("financeiro", "cubo_vendas"),
    ("financeiro", "cubo_dre"),
    ("estoque",    "cubo_estoque"),
    ("estoque",    "cubo_frete"),
]

db.execute(
    """
    SELECT schemaname, matviewname FROM pg_matviews
    WHERE schemaname = ANY(%s)
    """,
    ([s for s, _ in MVS],)
)
mvs_existentes = {(row[0], row[1]) for row in db.fetchall()}

for schema, mv in MVS:
    if (schema, mv) in mvs_existentes:
        ok(f"{schema}.{mv}")
    else:
        fail(f"{schema}.{mv} não encontrada", "Execute POST /api/admin/atualizar-cubos após subir o backend")

db.close()

# ─── Resultado ────────────────────────────────────────────
print(f"\n{'─'*45}")
total = len(passou) + len(falhou)
print(f"{NEGRITO}Resultado: {VERDE}{len(passou)}{RESET}/{total} verificações passaram{RESET}")
if falhou:
    print(f"{VERM}Falhas:{RESET}")
    for f in falhou:
        print(f"  • {f}")
sys.exit(0 if not falhou else 1)
