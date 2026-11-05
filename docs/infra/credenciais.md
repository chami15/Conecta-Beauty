# Credenciais e variáveis de ambiente

Este projeto usa recursos reais na Azure (Postgres, Cosmos DB, Data Lake). As credenciais de acesso a esses recursos **nunca** vão pro Git — nem no código, nem em commit antigo, nem em print de tela público.

## O que existe no repositório

- `backend/.env.example`: lista todas as variáveis que a aplicação e os scripts precisam, com valores fictícios (`...`). É a referência de "o que eu preciso pedir" — nunca contém segredo real.
- `.gitignore` (raiz): já bloqueia qualquer arquivo `.env` de ser commitado, em qualquer pasta do projeto.

## Variáveis necessárias hoje

| Variável | Pra que serve | Quem precisa |
|---|---|---|
| `POSTGRES_HOST`, `POSTGRES_PORT`, `POSTGRES_DB`, `POSTGRES_USER`, `POSTGRES_PASSWORD` | Conexão com o Postgres (Azure) | Backend, scripts de seed, scripts de extração pro Data Lake |
| `COSMOS_MONGO_CONNECTION_STRING` | Conexão com o Cosmos DB for MongoDB | Backend (logs técnicos), notebook Colab (Vitor), scripts de extração |
| `DATALAKE_CONNECTION_STRING` | Conexão com a storage account (ADLS Gen2) | Script de extração pra camada bronze |

## Como pedir/receber uma credencial

1. Copia o `backend/.env.example` pra `backend/.env` (esse arquivo fica só na sua máquina, nunca é commitado).
2. Pede a credencial real pro **Bernardo**, direto (WhatsApp/Discord — nunca em canal público do servidor da faculdade, nunca em issue/PR do GitHub, nunca em print compartilhado).
3. Cola o valor recebido no seu `.env` local.
4. Antes de fazer qualquer commit, roda `git status` e confere que `.env` não aparece na lista de arquivos rastreados — se aparecer, **para e avisa o Bernardo antes de commitar**.

## Se algum dia vazar uma credencial

Se por acidente uma credencial real for commitada ou compartilhada num lugar público:

1. Avisa o Bernardo imediatamente.
2. A credencial é trocada na Azure (regenerar chave/senha) o quanto antes — não adianta só remover do histórico do Git, o valor já vazado tem que ser invalidado.
3. Todo mundo que usa aquela credencial atualiza o `.env` local com o novo valor.

## Confirmação de acesso

Cada pessoa que precisar rodar algo localmente (notebook, script, backend) confirma aqui, depois de validar que conseguiu conectar com sucesso:

- [ ] Vitor — Cosmos DB (notebook Colab, issue #12)
- [ ] Samuel — Postgres/Cosmos (experimentos de ML, issues #11/#21)
