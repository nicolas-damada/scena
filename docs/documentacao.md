# SCENA — Documentação do projeto

**Divulgação simples para fortalecer a cena musical.**

Documento elaborado a partir do [briefing executivo](briefing.md), seguindo a estrutura do rascunho de documentação. As informações sobre a implementação foram conferidas nos arquivos PHP e SQL do repositório. Funcionalidades ainda não implementadas estão identificadas como previstas.

## 1. Objetivo

Desenvolver um sistema web que facilite a divulgação e a descoberta de shows, aproximando bandas, organizadores, responsáveis por espaços de música e pessoas interessadas em acompanhar a cena musical.

O SCENA reúne eventos em um feed com informações essenciais sobre título, bandas participantes, local e data. A proposta é permitir que o usuário publique um show em poucos passos e encontre eventos com facilidade.

## 2. Briefing

### Problema

A divulgação de shows se dispersa entre publicações sobre outros assuntos, dificultando encontrar informações sobre os eventos e decidir onde e quando ir. Formulários longos também tornam a divulgação mais trabalhosa para quem organiza.

### Solução

Uma plataforma dedicada a shows, com cadastro de usuários, autenticação, publicação de eventos, feed e pesquisa. A experiência se aproxima de uma rede social centrada em música, com formulários objetivos e informações fáceis de consultar.

### Público-alvo

- Bandas e artistas que desejam divulgar suas apresentações.
- Organizadores e produtores de eventos musicais.
- Responsáveis por casas de show e outros espaços de música.
- Pessoas interessadas em descobrir shows e acompanhar a cena musical.

### Diferenciais

- **Simplicidade:** cadastro direto e apresentação clara dos eventos.
- **Foco em música:** bandas, locais e datas no centro da navegação.
- **Velocidade:** poucos passos para publicar e consultar shows.

## 3. Tecnologias utilizadas

| Camada | Tecnologia | Responsabilidade |
| --- | --- | --- |
| Backend | PHP | Processar formulários, autenticação e regras de acesso. |
| Banco de dados | PostgreSQL | Armazenar usuários, shows e bandas participantes. |
| Frontend | HTML e CSS | Estruturar as páginas e definir a apresentação visual. |
| Acesso ao banco | PDO | Executar consultas e comandos SQL com parâmetros. |
| Autenticação | Sessões PHP | Manter a identificação e o perfil do usuário após o login. |

## 4. Dicionário de dados

O modelo abaixo segue o arquivo [tabelas atuais.sql](../database/tabelas%20atuais.sql), compatível com o cadastro e a consulta de shows no código. A proposta anterior de uma tabela independente `bandas` foi substituída, nesse modelo, pelo armazenamento dos nomes em `shows_bandas`.

### Tabela `usuarios`

Armazena as contas de acesso.

| Campo | Tipo | Restrições | Descrição |
| --- | --- | --- | --- |
| `id` | `SERIAL` | Chave primária | Identificador do usuário. |
| `nome` | `VARCHAR(50)` | Obrigatório | Nome do usuário. |
| `email` | `VARCHAR(255)` | Obrigatório e único | E-mail utilizado para entrar na conta. |
| `senha` | `VARCHAR(255)` | Obrigatório | Hash da senha, gerado pelo PHP no cadastro. |

**Pendência no esquema:** o código de autenticação também consulta `is_admin` para distinguir usuários comuns de administradores, mas o campo não está declarado nos scripts SQL do repositório. A definição proposta é `BOOLEAN NOT NULL DEFAULT FALSE`, com atribuição de administrador pela gestão do sistema.

### Tabela `shows`

Armazena as informações principais dos eventos.

| Campo | Tipo | Restrições | Descrição |
| --- | --- | --- | --- |
| `id` | `SERIAL` | Chave primária | Identificador do show. |
| `titulo` | `VARCHAR(255)` | Obrigatório | Nome do evento. |
| `data_show` | `DATE` | Obrigatório | Data de realização do show. |
| `endereco` | `VARCHAR(255)` | Obrigatório | Local ou endereço do evento. |

### Tabela `shows_bandas`

Armazena os nomes das bandas participantes de cada show.

| Campo | Tipo | Restrições | Descrição |
| --- | --- | --- | --- |
| `show_id` | `INT` | Obrigatório; chave estrangeira | Referência ao show em `shows(id)`. |
| `nome_banda` | `VARCHAR(255)` | Obrigatório | Nome da banda participante. |

A chave primária composta por `show_id` e `nome_banda` impede repetir o mesmo nome no mesmo show. A chave estrangeira utiliza `ON DELETE CASCADE`, removendo as participações quando o show é excluído.

### Relacionamentos

- Um usuário pode estar associado a vários shows; cada show pode ter um usuário responsável.
- Um show pode ter várias bandas participantes, registradas em `shows_bandas`.
- Uma banda pode aparecer em diferentes shows pelo nome, sem um cadastro independente de artista no modelo atual.

## 5. CRUD e permissões

CRUD representa as operações de criar, consultar, atualizar e excluir dados. Login e logout são operações de autenticação, descritas nas telas e regras de acesso.

### Visitante

| Operação | Acesso |
| --- | --- |
| Criar | Cadastrar uma conta de usuário. |
| Consultar | Visualizar o feed público de shows. |
| Atualizar | Não disponível. |
| Excluir | Não disponível. |

### Usuário autenticado

| Operação | Funcionalidade | Situação |
| --- | --- | --- |
| Criar | Cadastrar shows com uma ou mais bandas participantes. | Implementada; a exigência de ao menos uma banda ainda precisa de validação. |
| Consultar | Visualizar o feed e pesquisar shows por título. | Implementada. |
| Atualizar | Atualizar os dados da própria conta. | Prevista no rascunho; ainda não implementada. |
| Excluir | Excluir shows. | Acesso exclusivo do administrador. |

### Administrador

| Operação | Funcionalidade | Situação |
| --- | --- | --- |
| Criar | Cadastrar shows. | Implementada. |
| Consultar | Visualizar o feed e pesquisar shows por título. | Implementada. |
| Atualizar | Atualizar os dados da própria conta. | Prevista no rascunho; ainda não implementada. |
| Excluir | Remover shows publicados. | Implementada no código; depende da configuração de `is_admin` no banco. |

A exclusão de usuários mencionada no rascunho não integra o escopo do briefing e não está implementada. A função administrativa definida para o projeto é a exclusão de shows.

## 6. Telas e navegação

O cabeçalho atual oferece acesso ao início pela marca SCENA e os links **Postar show**, **Pesquisar**, **Entrar** e **Sair**.

### Tela 1 — Início / feed

- **Arquivo:** `index.php`.
- **Acesso:** público.
- **Conteúdo:** título, bandas, local e data dos shows cadastrados.
- **Comportamento:** apresenta uma mensagem quando não há shows e exibe a opção de exclusão para administradores.
- **Ordenação atual:** data do show em ordem crescente. Embora o título da página mencione shows adicionados recentemente, a consulta não ordena por data de publicação.

### Tela 2 — Pesquisa

- **Arquivo:** `app/search.php`.
- **Acesso:** exige login.
- **Conteúdo:** campo de pesquisa e listagem dos eventos encontrados.
- **Comportamento atual:** busca por parte do título, sem diferenciar maiúsculas de minúsculas, e ordena os resultados pela data do show.
- **Evolução prevista no rascunho:** pesquisa por cidade, artista ou gênero. Esses filtros ainda não estão implementados; o modelo atual também não possui campos específicos para cidade e gênero.

### Tela 3 — Entrar

- **Arquivo:** `login/login.php`.
- **Acesso:** público.
- **Campos:** e-mail e senha.
- **Comportamento:** verifica as credenciais, inicia a sessão e direciona ao feed quando o login é válido. Exibe mensagem para credenciais inválidas.
- **Navegação complementar:** link para criar uma conta. Usuários comuns e administradores utilizam a mesma tela.

### Tela 4 — Cadastro de usuário

- **Arquivo:** `login/cadastrar.php`.
- **Acesso:** público.
- **Campos:** nome, e-mail e senha.
- **Ações:** cadastrar e limpar o formulário.
- **Comportamento:** grava a senha como hash e, no fluxo atual de envio, redireciona ao início. O cadastro não autentica automaticamente o usuário.

### Tela 5 — Cadastro de show

- **Arquivo:** `app/create.php`.
- **Acesso:** exige login.
- **Campos:** título, bandas, data e local.
- **Comportamento:** recebe os nomes das bandas separados por vírgula, remove espaços excedentes e entradas vazias, descarta nomes duplicados e registra as participações do show.

### Ações complementares

- **Sair:** `login/logout.php`, responsável por encerrar a sessão.
- **Excluir show:** `app/delete.php`, acionado pelo feed e protegido pela verificação de administrador. O feed solicita confirmação antes da exclusão.

## 7. Regras de negócio

1. O visitante pode consultar o feed e criar uma conta.
2. A publicação e a pesquisa de shows exigem autenticação na implementação atual.
3. Cada show deve informar título, data e local, obrigatórios no banco de dados.
4. A proposta prevê uma ou mais bandas por show. O formulário atual permite gravar um show sem bandas, portanto essa validação permanece pendente.
5. Somente administradores podem excluir shows; a permissão é verificada no servidor.
6. Ao excluir um show, suas participações em `shows_bandas` também são removidas pelo banco.
7. O e-mail deve ser único no modelo atual, e as senhas cadastradas pela aplicação são armazenadas como hash e verificadas no login.



