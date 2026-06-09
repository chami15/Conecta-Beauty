"""
Verifica se o frontend compila sem erros (npm run build).
Testa também se Node.js e npm estão instalados e se as dependências
já foram instaladas (node_modules existe).

Como rodar:
    cd backend
    python tests/test_frontend.py
"""

import sys
import subprocess
import shutil
from pathlib import Path

VERDE   = "\033[92m"
VERM    = "\033[91m"
AMARELO = "\033[93m"
RESET   = "\033[0m"
NEGRITO = "\033[1m"

passou = []
falhou = []
FRONTEND = Path(__file__).resolve().parent.parent.parent / "frontend"


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


def run(cmd, cwd=None, timeout=120):
    """Roda um comando e retorna (código de saída, stdout, stderr)."""
    try:
        result = subprocess.run(
            cmd,
            cwd=cwd,
            capture_output=True,
            text=True,
            timeout=timeout,
            shell=sys.platform == "win32",
        )
        return result.returncode, result.stdout, result.stderr
    except subprocess.TimeoutExpired:
        return -1, "", "Timeout"
    except FileNotFoundError:
        return -1, "", f"Comando não encontrado: {cmd[0]}"


# ─── Ambiente ─────────────────────────────────────────────
secao("1. Ambiente")

node = shutil.which("node")
npm  = shutil.which("npm")

if node:
    code, out, _ = run(["node", "--version"])
    ok("Node.js instalado", out.strip())
else:
    fail("Node.js não encontrado", "Instale em https://nodejs.org")

if npm:
    code, out, _ = run(["npm", "--version"])
    ok("npm instalado", f"v{out.strip()}")
else:
    fail("npm não encontrado")

# ─── Estrutura do frontend ────────────────────────────────
secao("2. Estrutura do frontend")

if FRONTEND.exists():
    ok(f"Pasta frontend encontrada", str(FRONTEND))
else:
    fail("Pasta frontend não encontrada", str(FRONTEND))
    print(f"\n{VERM}Abortando: pasta do frontend não existe.{RESET}")
    sys.exit(1)

pkg_json = FRONTEND / "package.json"
if pkg_json.exists():
    ok("package.json presente")
else:
    fail("package.json não encontrado")

node_modules = FRONTEND / "node_modules"
if node_modules.exists():
    ok("node_modules instalado")
else:
    fail("node_modules não encontrado", "Rode: cd frontend && npm install")
    print(f"\n{AMARELO}Tentando instalar dependências automaticamente...{RESET}")
    code, out, err = run(["npm", "install"], cwd=str(FRONTEND), timeout=180)
    if code == 0:
        ok("npm install executado com sucesso")
    else:
        fail("npm install falhou", err[:200] if err else "sem detalhe")

# ─── Build ────────────────────────────────────────────────
secao("3. Build de produção (npm run build)")

if not node or not npm:
    fail("Build impossível: Node.js ou npm não disponível")
else:
    print(f"  {AMARELO}Executando build... (pode levar 30–60s){RESET}")
    code, out, err = run(["npm", "run", "build"], cwd=str(FRONTEND), timeout=180)

    if code == 0:
        dist = FRONTEND / "dist"
        if dist.exists():
            arquivos = list(dist.rglob("*"))
            ok("Build concluído com sucesso", f"{len(arquivos)} arquivos em dist/")
        else:
            ok("Build concluído (pasta dist não encontrada, mas exit 0)")
    else:
        fail("Build falhou com erros de compilação")
        # Mostrar apenas as linhas com "error" para não poluir o output
        linhas_erro = [l for l in (out + err).split("\n") if "error" in l.lower() or "Error" in l]
        for linha in linhas_erro[:10]:
            print(f"    {AMARELO}{linha}{RESET}")

# ─── Resultado ────────────────────────────────────────────
print(f"\n{'─'*45}")
total = len(passou) + len(falhou)
print(f"{NEGRITO}Resultado: {VERDE}{len(passou)}{RESET}/{total} verificações passaram{RESET}")
if falhou:
    print(f"{VERM}Falhas:{RESET}")
    for f in falhou:
        print(f"  • {f}")
sys.exit(0 if not falhou else 1)
