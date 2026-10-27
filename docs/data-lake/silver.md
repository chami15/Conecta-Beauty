# Silver

Essa é a camada intermediária, onde o dado já passou por um primeiro tratamento. Saiu da bagunça da Bronze e virou algo **confiável**: limpo, validado, com schema consistente. Ainda não é o dado "pronto pra apresentar", mas já dá pra confiar nele pra alimentar sistemas e análises.

## Conteúdo esperado

Arquivos já tratados, com um passo de transformação real por trás:

- **Formato**: costuma valer a pena usar um formato colunar (Parquet, por exemplo) por causa da performance de leitura, mas o que importa de verdade é o **estado do dado**, não a extensão do arquivo.
- **Normalização**: informações que vinham de fontes/formatos diferentes já foram unificadas num schema único.
- **Qualidade**: duplicidade removida, tipos corrigidos, valores nulos ou inconsistentes tratados.

## Regras da camada

1. **Schema documentado e estável**: quem for consumir um arquivo da Silver precisa saber o que esperar de estrutura, sem surpresas.
2. **Mudança consciente**: o schema pode evoluir, mas qualquer alteração deve ser intencional e comunicada — nunca um acidente herdado da Bronze.
3. **Rastreabilidade**: idealmente dá pra saber de qual lote/execução da Bronze aquele dado da Silver se originou.
4. **Sem dado bruto misturado**: se algo ainda não foi tratado, não é da Silver — volta pra Bronze até passar pelo processo.

## Quem consome

- Processos de carga que alimentam bancos transacionais ou analíticos (Postgres, Data Warehouse, etc.).
- Notebooks e análises exploratórias.
- Modelos de Machine Learning que precisam de dado confiável sem reprocessar a Bronze do zero.

## Quem escreve

- Jobs e pipelines de ETL/transformação.
- Notebooks que fazem a limpeza e padronização.
- Qualquer processo cuja função seja pegar o que está na Bronze e devolver limpo e estruturado.

## Datasets atuais

### Pedidos dos canais externos

Pedidos que chegam de canais de venda diferentes (Instagram, Facebook, Marketplace, Mercado Livre), cada um com um formato próprio no Bronze, já unificados num schema só. Fica em duas pastas, uma linha por pedido e uma linha por item:

- **pedidos**: `id_pedido_canal`, `canal`, `hash_origem`, `cliente`, `telefone`, `cidade`, `estado`, `documento`, `tipo_documento`, `documento_valido`, `qtd_itens`, `valor_total`, `frete`, `forma_pagamento`, `data_pedido`, `alertas`, `arquivo_origem`, `linha_origem`, `processado_em`
- **itens**: `id_pedido_canal`, `canal`, `numero_item`, `produto`, `quantidade`, `preco_unitario`, `valor_item`

O que já foi tratado nesse dataset:

1. **Pedido repetido** (mesmo canal e mesmo id) vira um só.
2. **Texto** normalizado (espaços e acentuação) e **documento/telefone** só com dígitos.
3. **CPF/CNPJ validado** pelos dígitos verificadores. Se o canal não informa documento, o campo fica vazio: ausência é característica do canal, não erro.
4. **Problemas de qualidade viram alerta** (coluna `alertas`), não são "consertados" por conta própria.
5. **Rastreabilidade**: `arquivo_origem` e `linha_origem` apontam pro Bronze, `hash_origem` identifica o pedido bruto.

Cada execução gera um par de arquivos novo com timestamp, sem sobrescrever os anteriores.
