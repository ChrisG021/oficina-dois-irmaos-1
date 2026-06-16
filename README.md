# Oficina Dois Irmaos

Sistema academico em Ruby on Rails para administracao de uma oficina mecanica.

## Funcionalidades

- Autenticacao com Devise
- Cadastro, consulta, edicao e exclusao de clientes
- Cadastro, consulta, edicao e exclusao de veiculos
- Cadastro, consulta, edicao e exclusao de ordens de servico
- Associacoes entre cliente, veiculo e ordem de servico
- Validacoes nos modelos
- Paginacao das listagens com Kaminari
- Interface responsiva com Bootstrap
- Exportacao CSV na tela principal
- Exportacao PDF das listagens com Prawn

## Como rodar

```powershell
cd C:\oficina-dois-irmaos-main
bundle install
bundle exec rails db:prepare
bundle exec rails db:seed
bundle exec rails server
```

Abra:

```text
http://localhost:3000
```

Usuario de demonstracao:

```text
Email: admin@oficina.com
Senha: 123456
```

## Testes

```powershell
bundle exec rails test
```
