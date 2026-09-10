# Bronze

Essa é a camada de entrada do Data Lake. Aqui o dado chega **do jeito que chegou** — sem limpeza, sem padronização, sem ninguém mexendo em nada. A ideia é simples: guardar a matéria-prima exatamente como veio da fonte, pra sempre ter como voltar no histórico original se algo der errado mais na frente no pipeline.

## Conteúdo esperado

Arquivos brutos, geralmente pesados e "crus":

- **Formatos comuns**: JSON, JSONL, CSV, XML, ou qualquer formato que a fonte tenha entregado.
- **Origens possíveis**: export de canal de venda externo, dump de alguma integração, resultado de simulação de dados, extração de API, arquivo recebido de terceiros — qualquer coisa que ainda não passou por tratamento nenhum.
- **Schema livre**: cada arquivo pode ter uma cara diferente, com campos e estruturas que não batem entre si. Isso é esperado e **não é motivo pra "arrumar" nada aqui** — esse trabalho é lá na frente.

## Regras da camada

1. **Imutabilidade**: nada que entra na Bronze é editado depois. Se o dado mudou na origem, o certo é gerar um novo arquivo, nunca sobrescrever ou "corrigir" o que já está gravado.
2. **Fidelidade histórica**: a Bronze é o registro do que realmente aconteceu no momento da ingestão — tem que continuar batendo com isso, mesmo que o dado esteja errado ou incompleto.
3. **Sem schema forçado**: cada fonte manda o que manda, do jeito que manda. Padronizar é problema da próxima camada.
4. **Organização por origem/data**: ajuda manter uma estrutura de pastas que separe por fonte e/ou data de ingestão, facilitando auditoria e reprocessamento.

## Quem consome

- Processos de ETL em geral — notebooks, scripts Python, jobs de processamento.
- Pipelines de dados e serviços de integração da Azure (Data Factory, Synapse Pipelines, etc.).
- Qualquer rotina que precise entender o dado cru antes de decidir como tratá-lo.

## Quem escreve

- Scripts de geração ou simulação de dados.
- Exports de sistemas externos (canais de venda, integrações, parceiros).
- Consultas extraídas de outras bases.
- Qualquer processo de ingestão cujo resultado ainda não passou por tratamento.
