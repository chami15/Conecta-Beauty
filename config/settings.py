SCHEMA_ADMINISTRATIVO = "administrativo"
SCHEMA_FINANCEIRO = "financeiro"
SCHEMA_ESTOQUE = "estoque"
SCHEMA_GERAL = "geral"
SCHEMA_STAGING = "staging"


LOG_PATH = "logs/etl.log"


BATCH_SIZE = 1000


TABELAS_ADMINISTRATIVO = [
    "clientes",
    "pedidos"
]

TABELAS_ESTOQUE = [
    "produtos",
    "estoque"
]

TABELAS_FINANCEIRO = [
    "vendas"
]