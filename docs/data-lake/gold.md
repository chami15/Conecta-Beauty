# Gold

Essa é a camada final, onde o dado já está pronto pra ser consumido por quem toma decisão — analista, gestor, ferramenta de BI. Aqui não tem mais dado bruto nem intermediário: é **informação já agregada**, resumida e organizada em torno de uma pergunta de negócio.

## Conteúdo esperado

- **Métricas consolidadas**: totais, médias, indicadores por período, categoria, canal, região, etc.
- **Cubos analíticos**: visões multidimensionais prontas pra fatiar e cruzar.
- **Resumos direto-ao-ponto**: o tipo de dado que alimenta um dashboard sem precisar de mais nenhum processamento pesado em cima.

## Regras da camada

1. **Performance em primeiro lugar**: o dado aqui precisa ser rápido de ler, mesmo que isso signifique duplicar informação que já existe em outro lugar.
2. **Clareza pra quem consome**: nomes e estrutura devem fazer sentido pra quem não conhece os detalhes técnicos do pipeline — analista de negócio não deveria precisar entender a Bronze pra usar a Gold.
3. **Granularidade certa**: não é lugar pra dado detalhado demais. Se alguém precisa do detalhe fino, o lugar certo é a Silver ou o banco transacional.
4. **Ligação com uma pergunta de negócio**: cada conjunto de dados aqui deveria responder a algo específico (ex: "quanto vendemos por canal no mês?"), não ser só uma cópia agregada sem propósito claro.

## Quem consome

- Ferramentas de BI (dashboards, relatórios).
- Data Warehouse.
- Qualquer pessoa ou processo que precise de uma visão consolidada pra decisão, sem entrar no detalhe operacional.

## Quem escreve

- Rotinas de agregação do Data Warehouse.
- Jobs agendados de resumo/consolidação.
- Exports de views, cubos ou relatórios já calculados em outros sistemas.
- Qualquer pipeline cuja função seja transformar o dado da Silver em algo pronto pra análise.
