# Iniciar de forma rapida
1. clone o repositorio com https://github.com/chami15/Conecta-Beauty.git (git clone url do repositorio)

2. Por padrão você ira começar na branch main, a branch de desenvolvimento é a conecta-beauty-v2, então de o comando no terminal: git switch conecta-beauty-v2

3. Inicie o serviço docker ou suba direto para seu postgres o dump_atualizado com o comando no terminal: psql -h localhost -U postgres conecta_beauty < dump_atualizado.sql
    - Caso seja o docker primeiro configure as variaveis de ambiente seguindo o .env.example e de o comando no terminal: cp .env.example .env && move .env backend (certifique-se de estar na pasta raiz do projeto)
    - Tendo configurado o .env e movido para a pasta backend de o comando no terminal: cd backend e depois docker-compose up -d, pronto seu banco estará rodando no docker

4. Acesse backend/sql/banco para ver as tabelas, views, procedures e triggers criados
