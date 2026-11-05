# Azure Function: pipeline automático

A Function App roda o `scripts/datalake/pipeline.py --executar --treinar-ml` na nuvem, sem ninguém com o computador ligado. O código está em `function_app.py` (raiz do repositório) e tem dois gatilhos:

| Função | Quando roda |
|---|---|
| `pipeline_diario` | todo dia às 06:00 UTC (03:00 em Brasília) |
| `pipeline_agora` | na hora, abrindo a URL da função no navegador (útil na apresentação) |

## 1. Instalar as ferramentas (uma vez, no seu computador)

```powershell
winget install Microsoft.AzureCLI
winget install Microsoft.Azure.FunctionsCoreTools
```

Feche e abra o terminal depois de instalar. Confira com `az --version` e `func --version`.

## 2. Criar a Function App no Portal

Portal Azure → **Criar um recurso** → **Aplicativo de Funções** (Function App):

1. Plano de hospedagem: **Consumo Flex** (Flex Consumption).
2. Grupo de recursos: o mesmo do projeto.
3. Nome: por exemplo `conectabeauty-pipeline` (vira parte da URL).
4. Região: a mesma do Postgres.
5. Pilha de runtime: **Python**, versão **3.11**.
6. Armazenamento: deixe o Portal **criar uma conta nova**. Não use a do Data Lake: a Function precisa de uma só dela.
7. Monitoramento: **Application Insights = Sim** (é onde aparecem os logs).
8. **Revisar + criar** → **Criar**.

## 3. Configurar as credenciais

Function App → **Configurações** → **Variáveis de ambiente** → **+ Adicionar**, uma por vez, com os mesmos valores do `backend/.env`:

- `POSTGRES_HOST`
- `POSTGRES_PORT`
- `POSTGRES_DB`
- `POSTGRES_USER`
- `POSTGRES_PASSWORD`
- `DATALAKE_CONNECTION_STRING`

Clique em **Aplicar** e confirme.

## 4. Liberar a rede

- **Postgres** → **Rede** → marque **"Permitir acesso público de qualquer serviço do Azure dentro do Azure a este servidor"** → **Salvar**.
- **Storage account do Data Lake** → **Rede**: se estiver em "Habilitado de redes virtuais e endereços IP selecionados", a Function não entra (o IP dela não é fixo). Para a Function funcionar, troque para **"Habilitado de todas as redes"**. O acesso continua exigindo a chave ou o SAS, mas qualquer IP pode tentar; se preferir manter restrito, a alternativa é integrar a Function a uma rede virtual (mais trabalhoso).

## 5. Publicar o código

Na **raiz** do repositório (onde fica o `function_app.py`):

```powershell
az login
func azure functionapp publish conectabeauty-pipeline --python
```

A publicação instala o `requirements.txt` na nuvem e leva alguns minutos. O `.funcignore` define o que não sobe (frontend, docs, notebooks, `.env`).

## 6. Testar

1. Function App → **Visão geral** → em Funções, abra **`pipeline_agora`** → **Obter URL da função** → copie a URL (`default`, já vem com a chave).
2. Abra a URL no navegador. Em 1 a 2 minutos aparece o resumo do pipeline:

```
========== RESUMO DO PIPELINE ==========
  OK    bronze -> silver
  OK    silver -> DW
  OK    DW -> gold
  OK    treino ML
```

3. Logs completos: função → **Monitorar** (invocações) ou Function App → **Fluxo de logs**.

Rodar de novo não duplica nada: a carga só grava os pedidos que ainda não estão no Data Warehouse.

## Erros comuns

| Erro no log | Causa |
|---|---|
| `Nao foi possivel conectar ao Postgres` | passo 4 (Postgres) ou variável `POSTGRES_*` errada no passo 3 |
| `AuthorizationFailure` / `This request is not authorized` | firewall do Data Lake (passo 4) |
| `DATALAKE_CONNECTION_STRING nao configurada` | faltou a variável no passo 3 |
| tempo esgotado | o limite é 10 min (`host.json`); o pipeline costuma levar menos de 2 |

## Observações

- Os modelos de ML treinados na Function ficam em `/tmp` dela. O que importa para o Power BI vai para o banco (`ml.segmento_pedido`). A API do frontend continua usando os modelos treinados no seu computador.
- Para mudar o horário, edite `schedule="0 0 6 * * *"` em `function_app.py` (formato: segundo minuto hora dia mês dia-da-semana, em UTC) e publique de novo.
