# Oficina Dois Irmãos

Sistema de gestão para oficinas mecânicas desenvolvido com Ruby on Rails, permitindo o gerenciamento de clientes, veículos e ordens de serviço de forma centralizada, segura e eficiente.

## Funcionalidades

### Autenticação e Segurança

* Login e gerenciamento de usuários com Devise
* Controle de acesso às funcionalidades do sistema

### Gestão de Clientes

* Cadastro de clientes
* Consulta e pesquisa de registros
* Edição de informações
* Exclusão de cadastros

### Gestão de Veículos

* Cadastro completo de veículos
* Associação de veículos aos respectivos clientes
* Consulta, edição e exclusão de registros

### Gestão de Ordens de Serviço

* Criação de ordens de serviço
* Vinculação entre clientes, veículos e serviços realizados
* Acompanhamento e gerenciamento dos atendimentos

### Recursos Adicionais

* Validações de dados nos modelos
* Paginação de resultados com Kaminari
* Interface responsiva utilizando Bootstrap
* Exportação de dados em CSV
* Geração de relatórios em PDF com Prawn

## Tecnologias Utilizadas

* Ruby
* Ruby on Rails
* SQLite3
* Devise
* Bootstrap
* Kaminari
* Prawn

## Instalação e Execução

Clone o repositório:

```bash
git clone https://github.com/seu-usuario/oficina-dois-irmaos.git
cd oficina-dois-irmaos
```

Instale as dependências:

```bash
bundle install
```

Configure o banco de dados:

```bash
bundle exec rails db:prepare
bundle exec rails db:seed
```

Inicie o servidor:

```bash
bundle exec rails server
```

Acesse a aplicação em:

```text
http://localhost:3000
```

## Usuário de Demonstração

```text
Email: admin@oficina.com
Senha: 123456
```

## Executando os Testes

```bash
bundle exec rails test
```

## Estrutura do Projeto

O sistema foi desenvolvido seguindo o padrão MVC (Model-View-Controller) do Ruby on Rails, garantindo organização, escalabilidade e facilidade de manutenção do código.

## Autor

Projeto desenvolvido para fins acadêmicos, com foco na aplicação prática de conceitos de desenvolvimento web utilizando Ruby on Rails.
