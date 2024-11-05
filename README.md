Take-Away
-
Take-Away é uma aplicação Rails desenvolvida para gerenciamento de pedidos, cardápios e pratos de restaurantes e outros estabelecimentos de alimentação que operam no modelo de "take away" (take-out), onde o cliente faz o pedido e retira diretamente no local, sem entrega a domicílio.

Funcionalidades:
-
Cadastro de usuários:
- Administrador: Tem permissões completas no sistema, podendo cadastrar e gerenciar estabelecimentos, cardápios, pratos, bebidas e pedidos.  
- Funcionário: Possui permissões limitadas, com acesso necessário para gerenciar pedidos e atualizar o status dos mesmos.  
Cadastro de Estabelecimentos: Permite o registro de informações do estabelecimento que utilizará o sistema.  
Gestão de Pratos e Bebidas: Possibilita a criação, edição e exclusão de pratos e bebidas, incluindo detalhes como nome, descrição, preço e categoria.  
Organização de Cardápios: Permite a organização dos pratos e bebidas em cardápios, facilitando a visualização e estruturação dos itens disponíveis.  
Gerenciamento de Pedidos: Criação e acompanhamento do status dos pedidos feitos no estabelecimento, permitindo a atualização do andamento de cada pedido.  

Requisitos:
-
- Ruby: 3.2.5  
- Rails: 7.1.4.1  
- SQLite3: >= 1.4  
- RSpec e Capybara para testes automatizados  

Configuração e Instalação:
-
Clone o repositório:

```git clone git@github.com:vando-ramos/take-away.git```  
```cd take-away```  

Instale as dependências:
-
```bundle install```  

Configure o banco de dados e rode as migrações:
-
```rails db:create```  
```rails db:migrate```  

Seeds:  
-
O arquivo de seeds (db/seeds.rb) inclui dados iniciais para facilitar o desenvolvimento e a visualização dos recursos da aplicação. Os seeds incluem usuários, estabelecimentos, pratos, bebidas e cardápios, além de pedidos de exemplo.  

Para carregar os dados de seed no banco de dados, execute:  

```rails db:seed```  

Execute o servidor:  
-
```rails server```  
Acesse a aplicação em: http://localhost:3000  

Testes:  
-
Os testes são realizados com RSpec e Capybara para garantir a funcionalidade e a usabilidade da aplicação.  

Para rodar os testes:  

```rspec```  

