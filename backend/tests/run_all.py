"""
Executa todos os scripts de teste em sequência e exibe um resumo final.

Como rodar (a partir da raiz do projeto):
    cd backend
    python tests/run_all.py

Ordem:
    1. test_banco.py    — conexão e dados no PostgreSQL
    2. test_api.py      — endpoints da API (backend deve estar rodando)
    3. test_frontend.py — build do React

IMPORTANTE: Suba o backend antes de rodar este script:
    uvicorn main:app --reload   (em outro terminal)
"""

import sys
import subprocess
from pathlib import Path

VERDE   = "\033[92m"
VERM    = "\033[91m"
AMARELO = "\033[93m"
RESET   = "\033[0m"
NEGRITO = "\033[1m"
CYAN    = "\033[96m"

TESTS_DIR = Path(__file__).resolve().parent

SCRIPTS = [
    ("test_banco.py",    "Banco de dados"),
    ("test_api.py",      "Endpoints da API"),
    ("test_frontend.py", "Build do frontend"),
]


def separador(char="─", n=50):
    print(char * n)


def rodar_script(nome, titulo):
    script = TESTS_DIR / nome
    print(f"\n{CYAN}{'═'*50}{RESET}")
    print(f"{NEGRITO}  {titulo.upper()}{RESET}")
    print(f"{CYAN}{'═'*50}{RESET}")

    result = subprocess.run(
        [sys.executable, str(script)],
        cwd=str(TESTS_DIR.parent),
    )
    return result.returncode == 0


print(f"\n{NEGRITO}{'═'*50}")
print("  CONECTA BEAUTY — SUITE DE TESTES")
print(f"{'═'*50}{RESET}")
print(f"{AMARELO}  Certifique-se de que o backend está rodando em")
print(f"  http://localhost:8000 antes de continuar.{RESET}")
input(f"\n  Pressione ENTER para começar... ")

resultados = {}
for nome, titulo in SCRIPTS:
    resultados[titulo] = rodar_script(nome, titulo)

# Resumo final
print(f"\n{NEGRITO}{'═'*50}")
print("  RESUMO FINAL")
print(f"{'═'*50}{RESET}")

todos_ok = True
for titulo, passou in resultados.items():
    status = f"{VERDE}PASSOU{RESET}" if passou else f"{VERM}FALHOU{RESET}"
    print(f"  {'✓' if passou else '✗'}  {titulo:<30} {status}")
    if not passou:
        todos_ok = False

print(f"{'─'*50}")
if todos_ok:
    print(f"{VERDE}{NEGRITO}  Sistema pronto para rodar. ✓{RESET}")
else:
    print(f"{VERM}{NEGRITO}  Há falhas. Veja os detalhes acima.{RESET}")

sys.exit(0 if todos_ok else 1)
