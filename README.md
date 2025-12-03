# Conecta Beauty - Aplicação Web

Sistema completo de gestão e análise de dados para negócios de beleza, desenvolvido com Streamlit. 

## Funcionalidades

### Home (Dashboard Principal)
- KPIs principais: Faturamento, Pedidos, Ticket Médio, Clientes
- Gráficos de vendas por ano, top produtos e análise de canais
- Navegação rápida para todas as páginas

### Gerenciamento de Clientes
- **CRUD Completo**: Adicionar, editar e excluir clientes
- **Busca**: Filtrar por nome
- **Dashboard**: Análises por sexo, região e clientes mais valiosos
- Campos: Nome, Sexo, Cidade, Estado, Telefone

### Gerenciamento de Produtos
- **CRUD Completo**: Adicionar, editar e excluir produtos
- **Busca**: Filtrar por nome e categoria
- **Dashboard**: Top produtos, vendas por segmento, cores mais vendidas
- Campos: Nome, Categoria, Fornecedor, Valor Unitário

### Gerenciamento de Vendas
- **CRUD Completo**: Adicionar, editar e excluir vendas/pedidos
- **Busca**: Filtrar por canal e forma de pagamento
- **Dashboard**: KPIs, evolução temporal, análise de canais, sazonalidade
- Campos: Cliente, Data, Valor Total, Forma de Pagamento, Canal

###  Chat IA
- Criado a partir de Inteligencia Generativa usando a LLM da OpenAI 
- Assistente inteligente com 7 ferramentas de análise
- Histórico de conversas
- Múltiplas sessões isoladas
- Análises: clientes, produtos, vendas, campanhas, mix de produtos

## Pré-requisitos

```bash
Python 3.8+
MongoDB Atlas (ou local)
Streamlit
Agno (para o agente IA)
```

## Instalação

1. **Clone ou baixe os arquivos**

2. **Instale as dependências**:
```bash
pip install streamlit pandas pymongo plotly requests agno python-dotenv
```

3. **Configure o arquivo .env**:
```env
MONGO_URI=sua_connection_string_mongodb
DB_NAME=ConectaBeauty
OPENAI_API_KEY = sua_chave #Para acessar o ChatBot
```

4. **Inicie o agente IA** (necessário para o Chat):
```bash
python agent.py
```
O agente deve estar rodando em `http://127.0.0.3:9999`

5. **Execute a aplicação**:
```bash
streamlit run app.py
```

## Estrutura do Projeto

```
.
├── Inicio.py                   # Página principal (Home)
├── interface/                  # Páginas Streamlit
│   ├── Clientes.py            # Gerenciamento de clientes
│   ├── Produtos.py            # Gerenciamento de produtos
│   ├── Vendas.py              # Gerenciamento de vendas
│   └── Chat_Analises.py       # Chat com agente IA
├── Dados/                      # Módulos de dados e análises
│   ├── mongo.py               # Conexão MongoDB
│   ├── dados.py               # Funções de acesso aos dados
│   ├── analises.py            # Classe de análises
│   ├── charts.py              # Geração de gráficos Plotly
│   ├── graficos.py            # Batch de gráficos HTML
│   └── transformacao.py       # Transformações de dados
├── ChatBot/                    # Sistema de chat IA
│   ├── agent.py               # Configuração do agente IA
│   ├── tools.py               # Ferramentas do agente
│   ├── chat.py                # Interface de chat
│   └── agno.db                # Banco de dados do agente
├── utils/                      # Utilitários
│   ├── styles.py              # Sistema de estilos CSS
│   ├── crud_operations.py     # Operações MongoDB
│   └── chart_loader.py        # Carregamento de gráficos
├── graficos_html/              # Gráficos Plotly pré-gerados
│   ├── vendas_ano.html
│   ├── vendas_canal.html
│   ├── vendas_forma_pagamento.html
│   ├── vendas_segmento.html
│   ├── top_produtos.html
│   ├── top_cosmeticos.html
│   ├── top_cadeiras_lavatorios.html
│   ├── top3_segmento.html
│   ├── cores_vendidas.html
│   ├── clientes_sexo.html
│   ├── clientes_regiao.html
│   ├── clientes_valiosos.html
│   ├── kpi_totais.html
│   ├── sazonalidade_heatmap.html
│   └── canal_venda_pareto.html
├── codigo_mongoDB/             # Arquivos JSON MongoDB
│   ├── tabela_cor.json
│   ├── tabela_itens_do_pedido.json
│   ├── tabela_itens_pedido_corrigido.json
│   ├── tabela_pedido.json
│   └── tabela_produto.json
├── tmp/                        # Arquivos temporários
│   └── chroma/
│       └── chroma.sqlite3
├── requirements.txt            # Dependências Python
├── README.md                   # Este arquivo
└── .env                        # Variáveis de ambiente
```

## Design

- **Paleta de Cores**:
  - Primary: `#1E3A5F` (Azul escuro)
  - Secondary: `#4A90E2` (Azul)
  - Accent: `#F39C12` (Laranja)
  
- **Layout**:
  - Wide mode para melhor aproveitamento
  - Sidebar com navegação
  - Tabs para organização de conteúdo
  - Cards KPI com gradientes

## Segurança

- Sessões isoladas no Chat IA
- Validação de tipos nos CRUD
- Tratamento de erros em todas operações
- Confirmação antes de exclusões

## Ferramentas do Agente IA

1. **Analisar Clientes**: Análises detalhadas da base de clientes
2. **Analisar Produtos**: Informações sobre produtos e categorias
3. **Analisar Vendas**: Análises de vendas, faturamento e tendências
4. **Obter Cotação**: Consulta preços de produtos
5. **Buscar Produto**: Busca produtos no catálogo
6. **Recomendar Campanha**: Sugere campanhas de marketing
7. **Analisar Mix de Produtos**: Análise de mix e desempenho

## Gráficos Disponíveis

### Clientes
- Distribuição por sexo
- Análise por região
- Clientes mais valiosos

### Produtos
- Top produtos mais vendidos
- Vendas por segmento
- Cores mais vendidas
- Top cosméticos
- Top cadeiras e lavatórios
- Top 3 por segmento

### Vendas
- KPIs totais
- Evolução de vendas por ano
- Vendas por canal
- Vendas por forma de pagamento
- Heatmap de sazonalidade
- Análise de Pareto

## Exemplos de Uso

### CRUD de Clientes
```
1. Clique em "➕ Adicionar"
2. Preencha: Nome, Sexo (F/M), Cidade, Estado, Telefone
3. Clique em "✅ Salvar Cliente"
4. Para editar: Clique no botão "✏️" ao lado do cliente
5. Para excluir: Clique no botão "🗑️"
```

### Chat IA
```
Perguntas exemplo:
- "Quantos clientes temos cadastrados?"
- "Quais os produtos mais vendidos este mês?"
- "Qual foi o faturamento total?"
- "Me mostre a análise de clientes por região"
- "Sugira uma campanha para aumentar as vendas"
```

## Troubleshooting

### Erro de conexão MongoDB
- Verifique se o `MONGO_URI` no `.env` está correto
- Confirme que seu IP está autorizado no MongoDB Atlas

### Chat IA não responde
- Verifique sua chave de API esta no .env
- Certifique-se de que `agent.py` está rodando
- Verifique se a porta 9999 está disponível
- Confirme a URL do agente: `http://127.0.0.3:9999`

### Gráficos não aparecem
- Verifique se a pasta `graficos_html/` existe
- Confirme que os arquivos HTML dos gráficos estão presentes

### Erro ao adicionar/editar registros
- Verifique se todos os campos obrigatórios estão preenchidos
- Confirme que os tipos de dados estão corretos (números, datas)

## Possiveis atualizações Futuras

- [ ] Exportação de dados para Excel/CSV
- [ ] Relatórios em PDF
- [ ] Sistema de notificações
- [ ] Backup automático
- [ ] Autenticação de usuários
- [ ] Logs de auditoria
- [ ] Dashboard personalizável

##  Suporte

Para problemas ou sugestões, verifique:
1. Se todas as dependências estão instaladas
2. Se o arquivo `.env` está configurado corretamente
3. Se o MongoDB está acessível
4. Se o agente IA está rodando

## Licença

Este projeto é um sistema proprietário desenvolvido para JN Moveis.

---

**Desenvolvido com Streamlit, MongoDB e Agno**
