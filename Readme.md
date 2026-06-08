# PI - Conecta Beauty
## Integrantes
- Bernardo Cunha Tassini – RA 2041382511011  

- Nathan Ferreira Alexandre Lima – RA 2041382511027 

- Samuel Passoni da Silva – RA 2041382511034 

- Vitor Augusto Alexandre Vieira – RA 2041382511029

## Para acessar o data warehouse
A criação das tabelas e das views materializadas estão no caminho backend/sql/banco

## Para visualizar o banco em diagrama
Pegue o arquivo que esta em docs, chamado conecta_beauty e suba para o drawio

## Para replicar o projeto

### Pré-requisitos
- Python 3.12+
- Node.js 18+
- PostgreSQL 15

### Banco de dados
Crie um banco PostgreSQL e execute os arquivos na ordem abaixo:

```
backend/sql/banco/tabelas.sql
backend/sql/banco/views.sql
backend/sql/banco/trigger.sql
backend/sql/banco/procedure.sql
```

### Variáveis de ambiente
Copie o arquivo de exemplo e preencha com as credenciais do banco:

```
cd backend
cp .env.example .env
```

### Backend
```
cd backend
pip install -r requirements.txt
uvicorn main:app --reload
```

### Frontend
```
cd frontend
npm i
npm run conecta
```

### Treinar o modelo de ML
Com o backend rodando, execute uma requisição para treinar o modelo:

```
POST http://localhost:8000/api/ml/treinar
```

Pode ser feito pelo Swagger em `http://localhost:8000/docs` ou via curl:

```
curl -X POST http://localhost:8000/api/ml/treinar
```

### Rodar os testes de infraestrutura
Com o backend rodando em outro terminal:

```
cd backend
python tests/run_all.py
```