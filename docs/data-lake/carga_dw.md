# Carga da Silver no Data Warehouse

Fecha o caminho **Bronze → Silver → Data Warehouse** dos pedidos dos canais externos: pega o que está tratado na Silver e grava nas tabelas de fato do Postgres, pra aparecer nas telas e consultas do app.

## Onde estão

Em `scripts/datalake/`:

- `tratar_silver.py`: lê os `.jsonl` do Bronze, trata e grava a Silver em Parquet.
- `carregar_dw.py`: lê a Silver mais recente e carrega no Postgres.
- `tratamento.py` e `lago.py`: regras de tratamento e acesso ao Data Lake, usados pelos dois.

## Como rodar

Sempre a partir da pasta `backend`, de onde o `.env` é carregado. O `.env` precisa ter as variáveis do Postgres e a `DATALAKE_CONNECTION_STRING` (chave da conta: precisa de permissão de escrita no `silver`).

```bash
cd backend
python ../scripts/datalake/tratar_silver.py        # Bronze -> Silver
python ../scripts/datalake/carregar_dw.py          # só simula: mostra o que faria
python ../scripts/datalake/carregar_dw.py --executar --limite 500   # amostra
python ../scripts/datalake/carregar_dw.py --executar --atualizar-cubos
```

Dá pra rodar sem rede: `--bronze-local`, `--silver-local` e `--pasta-bronze` apontam pra pastas locais.

## O que a carga faz

- **Simulação por padrão**: sem `--executar` nada é gravado.
- **Uma transação só**: ou entra tudo, ou nada.
- **Pedido vira linha em `fato_pedido`** e **cada item vira linha em `fato_venda`**, com número de pedido sequencial (o `numero_pedido` do banco é inteiro; o id do canal fica guardado à parte).
- **Cria o que faltar nas dimensões**: os canais, as datas e os clientes novos. Cliente que já existe (mesmo documento válido, ou mesmo nome e telefone) é reaproveitado.
- **Localização nunca é criada**: o cliente só recebe localização se a cidade (e o estado, quando o canal informa) já existir em `dim_localizacao`.
- **Pedido rejeitado** (com o motivo no resumo): sem data, sem valor, sem itens, forma de pagamento desconhecida, produto fora do catálogo ou total que não bate com a soma dos itens.
- **Rodar de novo é seguro**: a tabela `financeiro.controle_carga_canais` guarda o id original de cada pedido, então o que já entrou não entra duas vezes.

## Desfazer

```bash
python ../scripts/datalake/carregar_dw.py --desfazer            # simula
python ../scripts/datalake/carregar_dw.py --desfazer --executar
```

Remove os pedidos, os itens e os clientes criados pela carga (cliente que tem outras vendas fica). Canais, formas de pagamento e datas criados nas dimensões ficam, são inofensivos. A tabela de auditoria de vendas guarda o histórico de entrada e saída, como qualquer outra venda.

## Camada Gold

Com a carga feita, um script gera os resumos de vendas da Gold direto das tabelas de fato (não dos cubos), em Parquet, pronto pra ferramenta de BI ler do Data Lake:

```bash
cd backend
python ../scripts/datalake/gerar_gold.py                 # grava no container gold
python ../scripts/datalake/gerar_gold.py --gold-local pasta   # sem rede
```

O Power BI tem conector nativo de Data Lake Gen2 e de Postgres, então dá pra ligar direto na Gold sem precisar de Synapse.

## Pontos de atenção

- **Os cubos OLAP só enxergam clientes com localização**: o `cubo_vendas` junta com `dim_localizacao` por INNER JOIN, então pedido de cliente sem localização não aparece nele. As consultas do app que leem `fato_venda` direto (faturamento por canal, por exemplo) enxergam tudo.
- **A procedure `atualizar_cubos_olap()` não funciona hoje**: ela usa `REFRESH ... CONCURRENTLY`, que exige índice único em cada view. Por isso `--atualizar-cubos` faz um `REFRESH` simples.
- A carga muda os números do dashboard e do DRE: são pedidos novos de verdade na base. Pra testar antes, use `--limite` e depois `--desfazer`.
