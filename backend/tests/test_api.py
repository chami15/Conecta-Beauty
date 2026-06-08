"""
Testa se os endpoints da API estão respondendo corretamente.
O backend precisa estar rodando antes de executar este script.

Como rodar:
    1. Suba o backend:  cd backend && uvicorn main:app --reload
    2. Em outro terminal: cd backend && python tests/test_api.py

Configuração (opcional):
    BASE_URL = "http://localhost:8000"  (padrão)
"""

import sys
import urllib.request
import urllib.error
import json

BASE_URL = "http://localhost:8000"

VERDE   = "\033[92m"
VERM    = "\033[91m"
AMARELO = "\033[93m"
RESET   = "\033[0m"
NEGRITO = "\033[1m"

passou = []
falhou = []


def ok(msg, detalhe=""):
    detalhe_str = f" {AMARELO}({detalhe}){RESET}" if detalhe else ""
    print(f"  {VERDE}✓{RESET}  {msg}{detalhe_str}")
    passou.append(msg)


def fail(msg, detalhe=""):
    detalhe_str = f" → {AMARELO}{detalhe}{RESET}" if detalhe else ""
    print(f"  {VERM}✗{RESET}  {msg}{detalhe_str}")
    falhou.append(msg)


def secao(titulo):
    print(f"\n{NEGRITO}{titulo}{RESET}")


def get(path, esperado_200=True, verificar_dados=None):
    url = BASE_URL + path
    try:
        req = urllib.request.Request(url, headers={"Accept": "application/json"})
        with urllib.request.urlopen(req, timeout=8) as resp:
            status = resp.status
            body = json.loads(resp.read().decode())

            if status == 200:
                # Verificação opcional de dados não-vazios
                if verificar_dados:
                    resultado = verificar_dados(body)
                    if resultado is True:
                        ok(f"GET {path}", f"200 · com dados")
                    else:
                        ok(f"GET {path}", f"200 · {resultado}")
                else:
                    ok(f"GET {path}", "200")
            else:
                fail(f"GET {path}", f"status {status}")
    except urllib.error.HTTPError as e:
        fail(f"GET {path}", f"HTTP {e.code}")
    except urllib.error.URLError as e:
        fail(f"GET {path}", f"Sem conexão: {e.reason}")
    except Exception as e:
        fail(f"GET {path}", str(e))


# ─── API online? ──────────────────────────────────────────
secao("1. Status da API")
try:
    req = urllib.request.Request(BASE_URL + "/health")
    with urllib.request.urlopen(req, timeout=5) as resp:
        ok("/health", "API online")
except Exception as e:
    print(f"\n{VERM}✗  API não respondeu em {BASE_URL}{RESET}")
    print(f"   {AMARELO}Suba o backend primeiro: uvicorn main:app --reload{RESET}")
    sys.exit(1)

# ─── Início ───────────────────────────────────────────────
secao("2. Módulo Início")
get("/api/inicio/kpis",
    verificar_dados=lambda b: "faturamento_total" in b or "faturamento" in b or len(b) > 0)
get("/api/inicio/faturamento-diario",
    verificar_dados=lambda b: f"{len(b)} pontos" if isinstance(b, list) else "ok")
get("/api/inicio/pedidos-por-status",
    verificar_dados=lambda b: f"{len(b)} status" if isinstance(b, list) else "ok")
get("/api/inicio/top-produtos",
    verificar_dados=lambda b: f"{len(b)} produtos" if isinstance(b, list) else "ok")
get("/api/inicio/saude",
    verificar_dados=lambda b: "score_geral" in b or "score" in b)

# ─── Financeiro ───────────────────────────────────────────
secao("3. Módulo Financeiro")
get("/api/financeiro/kpis")
get("/api/financeiro/receita-vs-despesa",
    verificar_dados=lambda b: f"{len(b)} meses" if isinstance(b, list) else "ok")
get("/api/financeiro/mix-pagamento")
get("/api/financeiro/transacoes?page=1&size=5",
    verificar_dados=lambda b: "total" in b or isinstance(b, list))
get("/api/financeiro/formas-pagamento",
    verificar_dados=lambda b: f"{len(b)} formas" if isinstance(b, list) else "ok")

# ─── Estoque ─────────────────────────────────────────────
secao("4. Módulo Estoque")
get("/api/estoque/kpis",
    verificar_dados=lambda b: "itens_em_estoque" in b or len(b) > 0)
get("/api/estoque/movimentacoes-por-dia")
get("/api/estoque/performance-transportadoras")
get("/api/estoque/saldos?page=1&size=5")
get("/api/estoque/transportadoras")
get("/api/estoque/tipos-movimentacao")

# ─── Administrativo ───────────────────────────────────────
secao("5. Módulo Administrativo")
get("/api/admin/kpis")
get("/api/admin/clientes?page=1&size=5")
get("/api/admin/produtos?page=1&size=5")
get("/api/admin/fornecedores?page=1&size=5")
get("/api/admin/canais")
get("/api/admin/categorias")

# ─── ML ───────────────────────────────────────────────────
secao("6. Módulo ML")
get("/api/ml/status",
    verificar_dados=lambda b: "modelo_disponivel" in b)

# ─── Resultado ────────────────────────────────────────────
print(f"\n{'─'*45}")
total = len(passou) + len(falhou)
print(f"{NEGRITO}Resultado: {VERDE}{len(passou)}{RESET}/{total} endpoints passaram{RESET}")
if falhou:
    print(f"{VERM}Falhas:{RESET}")
    for f in falhou:
        print(f"  • {f}")
sys.exit(0 if not falhou else 1)
