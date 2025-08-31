# Instruções técnicas do desenvolvedor e demais anotações para uso e funcionamento.

## Objetivo
- Criar file_system, como a gem "ancestry".
(Usada como referência para resolução do desafio). 

## Regras de Negócio 
- Diretórios podem conter subdiretórios e arquivos.
- Arquivos podem ser armazenados em diferentes tipos de storage:
  - **db (blob)**: armazenamento no banco de dados.
  - **disk (local)**: armazenamento em disco local.
  - **s3 (mock)**: armazenamento em S3 simulado via LocalStack.


## Stack

- **Ruby** 3.3.8
- **Rails** 8.0.2
- **PostgreSQL**
- **Active Record**
- **ActiveStorage**
- **RSpec** para testes automatizados
- **Docker** e **LocalStack** para mock do S3

## Técnicas  
 - Service Object Pattern
 - Active Record Pattern 
 - Enum Pattern
 - Factory Pattern (para testes)
 - Separation of Concerns
 - Convention over Configuration
 - Uso de Docker e Mock de Serviços 
 - Clean Architeture , inspiração. 
 - Aplicação do SRP (Single Responsibility Principle )
 

## Passo a passo para rodar o projeto

### 1. Instale as dependências

- bundle install

### 2. Configure as variáveis de ambiente

- Crie um arquivo `.env` na raiz do projeto com o seguinte conteúdo:

env
- AWS_ACCESS_KEY_ID=test
- AWS_SECRET_ACCESS_KEY=test
- AWS_BUCKET=test-bucket
- AWS_REGION=us-east-1


**Dica:** Não versionar o `.env`. Use o `.env.dev` como referência.

### 3. Suba o serviço LocalStack (mock S3)
- Necessita do Docker instalado.

Execute o docker-compose.yml.

- docker compose up -d
- docker logs -f mock_services_s3_localstack

- Aguarde até o LocalStack exibir `Ready.` nos logs:

**Caso apareça algum erro, execute os camando abaixo:** 

- docker compose down
- rm -rf ./localstack_data 

- repita o passo 3 novamente

### 4. Crie o bucket no mock S3

No terminal, execute:

- export AWS_ACCESS_KEY_ID=test
- export AWS_SECRET_ACCESS_KEY=test
- export AWS_REGION=us-east-1
- aws --endpoint-url=http://localhost:4566 s3 mb s3://test-bucket --region us-east-1


### 5. Configure o Rails para usar o mock S3

No arquivo `config/environments/development.rb` ou `config/environments/test.rb`, defina:


- config.active_storage.service = :test_s3


### 6. Rode a aplicação
- rails db:create db:migrate
- rails server

### 7. Execute os testes
- rspec ou bundle exec rspec

### 8. Como alternar entre os tipos de armazenamento 

No arquivo `config/environments/development.rb`

- config.active_storage.service = :local

- rails db:create db:migrate
- rails server

No arquivo `config/environments/test.rb`

- config.active_storage.service = :test

### 9. Execute os testes novamente 

- rspec ou bundle exec rspec

### 10. Criado um CI para rodar os testes no github actions

- workflows/ci.yml 


### Agradecimento 

Obrigado pela oportunidade de participar desse desafio. Foi um excelente teste que me permitiu aplicar boas práticas e explorar conceitos importantes de modelagem com Ruby on Rails. 


