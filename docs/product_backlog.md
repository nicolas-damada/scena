# SCENA — Product Backlog

## 1. Objetivo do produto

Facilitar a divulgação e a descoberta de shows, permitindo que bandas e organizadores publiquem eventos e que o público consulte título, bandas participantes, local e data em um único espaço.

Este backlog foi elaborado a partir do [README](../readme.md), do [briefing](briefing.md) e da leitura do código atual. A ordem representa uma proposta de prioridade para o desenvolvimento. As evoluções futuras são sugestões para avaliação, sem compromisso de entrega.

## 2. Organização

- **Alta:** necessária para disponibilizar o MVP com seus fluxos principais funcionando.
- **Média:** melhora a experiência ou amplia uma funcionalidade existente.
- **Baixa:** pode ser considerada após a estabilização do produto.

O MVP é a primeira versão utilizável para criar uma conta, entrar, publicar, consultar e pesquisar shows, com exclusão exclusiva do administrador.

Os estados abaixo refletem a leitura dos arquivos, sem validação completa dos fluxos em execução:

- **Correção necessária:** existe implementação, mas há pendências identificadas.
- **A validar:** existe implementação e os critérios precisam ser verificados em execução.
- **Proposto:** funcionalidade futura ainda não implementada.

## 3. Backlog priorizado do MVP

| Ordem | ID | Item | História de usuário | Prioridade | Estado | Referência |
| --- | --- | --- | --- | --- | --- | --- |
| 1 | PB01 | Cadastro de conta | Como visitante, quero criar uma conta para acessar as funcionalidades de publicação e pesquisa de shows. | Alta | Correção necessária | RF01, RNF06 |
| 2 | PB02 | Login | Como usuário cadastrado, quero entrar com meu e-mail e senha para acessar as funcionalidades restritas. | Alta | Correção necessária | RF02, RNF05, RNF06 |
| 3 | PB03 | Logout | Como usuário autenticado, quero encerrar minha sessão para finalizar meu acesso à conta. | Alta | A validar | RF03, RNF05 |
| 4 | PB04 | Publicação de show | Como usuário autenticado, quero cadastrar título, data e local de um show para divulgá-lo ao público. | Alta | Correção necessária | RF04, RNF07, RNF08 |
| 5 | PB05 | Bandas participantes | Como usuário autenticado, quero informar uma ou mais bandas em um show para apresentar sua programação. | Alta | Correção necessária | RF05, RNF08 |
| 6 | PB06 | Feed público | Como visitante, quero consultar os shows e suas informações para descobrir eventos de meu interesse. | Alta | Correção necessária | RF06, RNF03 |
| 7 | PB07 | Pesquisa por título | Como usuário autenticado, quero pesquisar shows pelo título para encontrar um evento com facilidade. | Alta | A validar | RF07, RNF07 |
| 8 | PB08 | Permissões administrativas | Como responsável pelo sistema, quero restringir as ações administrativas às contas autorizadas para controlar a moderação dos eventos. | Alta | A validar | RF08, RNF05 |
| 9 | PB09 | Exclusão de show | Como administrador, quero excluir um show para retirar publicações que não devem permanecer no sistema. | Alta | Correção necessária | RF09, RNF05, RNF08 |
| 10 | PB10 | Navegação e formulários | Como pessoa que utiliza o SCENA, quero navegar e preencher os formulários com clareza no celular e no computador para concluir minhas ações. | Média | Correção necessária | RNF02, RNF03, RNF04, RNF09 |
| 11 | PB11 | Documentação de instalação | Como integrante da equipe, quero instruções compatíveis com o projeto para preparar o ambiente e verificar os fluxos principais. | Média | Correção necessária | RNF01 |

### PB01 — Critérios de aceite

- O formulário deve abrir sem erros de inclusão de arquivos.
- Nome, e-mail e senha devem ser obrigatórios, com validação no servidor e respeito aos limites definidos no banco.
- E-mail inválido ou já cadastrado deve gerar uma mensagem compreensível, sem criar outra conta.
- A senha deve ser armazenada como hash, e a conta comum deve ser criada sem permissão administrativa.
- Após o cadastro bem-sucedido, o usuário deve receber confirmação e conseguir acessar o login, sem autenticação automática.

### PB02 — Critérios de aceite

- Credenciais válidas devem iniciar a sessão e direcionar ao feed.
- Credenciais inválidas devem manter o acesso bloqueado e exibir uma mensagem de erro.
- A sessão e o redirecionamento devem funcionar sem depender de buffer de saída do PHP.
- A verificação da senha deve usar o hash armazenado, e o perfil administrativo deve ser carregado da conta autenticada.

### PB03 — Critérios de aceite

- A ação de sair deve encerrar a sessão e direcionar ao feed público.
- Após sair, o acesso direto à publicação e à pesquisa deve solicitar login.
- A interface deve voltar a apresentar as opções de visitante.

### PB04 — Critérios de aceite

- Somente usuários autenticados devem conseguir publicar, inclusive ao enviar uma requisição diretamente à rota.
- Título, data válida e local devem ser obrigatórios e validados no servidor; título e local devem respeitar os limites do banco.
- O evento e suas bandas devem ser salvos em uma única transação: uma falha em qualquer inserção deve desfazer toda a publicação.
- Após o sucesso, o evento deve aparecer no feed com os dados informados; falhas devem gerar mensagem compreensível, sem expor detalhes internos do banco.

### PB05 — Critérios de aceite

- O usuário deve conseguir cadastrar uma ou mais bandas separadas por vírgula.
- Espaços excedentes e entradas vazias devem ser removidos; nomes exatamente repetidos após esse tratamento devem ser registrados uma única vez por show.
- Se nenhuma banda válida restar após o tratamento, a publicação deve ser recusada antes de gravar o show.
- As bandas devem aparecer no evento correto no feed e na pesquisa; o mesmo nome pode participar de outros shows.

### PB06 — Critérios de aceite

- O feed deve estar disponível sem login e mostrar título, bandas, local e data no formato `dd/mm/aaaa`.
- Os eventos devem ser ordenados pela data do show em ordem crescente, com texto na página compatível com essa ordenação.
- Uma mensagem deve informar quando não houver shows cadastrados.
- O MVP deve manter a consulta de eventos passados, como ocorre atualmente; o filtro de próximos shows está proposto em PB13.

### PB07 — Critérios de aceite

- A pesquisa deve exigir autenticação.
- A busca deve localizar parte do título sem diferenciar letras maiúsculas de minúsculas e utilizar consulta parametrizada.
- Os resultados devem mostrar os dados do evento e ser ordenados pela data do show.
- A tela deve informar quando a busca não encontrar correspondências.

### PB08 — Critérios de aceite

- Contas comuns não devem conseguir conceder a si mesmas a permissão `is_admin` por formulário ou requisição manipulada.
- A opção de excluir deve estar disponível apenas para administradores.
- O servidor deve bloquear a exclusão por visitantes e usuários comuns, inclusive em acessos diretos à rota.
- A atribuição administrativa deve permanecer sob responsabilidade da gestão do sistema.

### PB09 — Critérios de aceite

- Um administrador deve conseguir confirmar a exclusão de um show existente.
- A exclusão deve utilizar POST e validar um token de proteção contra CSRF; uma requisição GET não deve remover dados.
- Após a exclusão, o show deve desaparecer do feed e da pesquisa, e suas participações em `shows_bandas` devem ser removidas.
- Outros shows e suas bandas devem permanecer intactos; identificadores inválidos ou inexistentes devem receber tratamento adequado.

### PB10 — Critérios de aceite

- Os links de navegação devem levar às páginas corretas e refletir o estado da sessão.
- Os campos devem ter rótulos visíveis e corretamente associados, incluindo senha e pesquisa; a pesquisa deve ter uma ação de envio identificável.
- As telas principais devem permitir leitura, navegação e preenchimento em celular e computador sem rolagem horizontal causada pelo layout.
- As ações devem ser acessíveis pelo teclado, com foco visível e mensagens claras de sucesso ou erro.

### PB11 — Critérios de aceite

- As instruções devem permitir configurar a conexão, criar um banco vazio e iniciar a aplicação com as rotas corretas.
- O README, o dicionário de dados e o DER devem descrever o mesmo modelo dos scripts oficiais, incluindo `is_admin` e a ausência de vínculo de autoria entre usuários e shows.
- Scripts de criação, dados de exemplo e migração devem ter finalidades identificadas.
- O roteiro de verificação deve abranger visitante, usuário comum e administrador, diferenciando resultados esperados de testes efetivamente realizados.

## 4. Evoluções propostas após o MVP

| Ordem | ID | Item | História de usuário | Prioridade | Critérios de aceite propostos | Dependências |
| --- | --- | --- | --- | --- | --- | --- |
| 12 | PB12 | Pesquisa por banda | Como usuário autenticado, quero buscar shows pelo nome de uma banda para encontrar suas apresentações. | Média | Localizar parte do nome sem diferenciar maiúsculas de minúsculas; mostrar cada show uma única vez mesmo quando várias bandas coincidirem. | PB05 e PB07. |
| 13 | PB13 | Filtro de próximos shows | Como visitante, quero consultar somente os eventos de hoje em diante para planejar minha agenda. | Média | Permitir alternar entre todos os eventos e os próximos shows; considerar a data no fuso definido para a aplicação; informar quando não houver resultados. | PB06. |
| 14 | PB14 | Detalhes do evento | Como pessoa interessada em um show, quero consultar horário e descrição para decidir minha participação. | Média | Exibir uma página do evento com título, bandas, data, local, horário e descrição; validar os novos campos e tratar evento inexistente. | PB04 e PB06; definição das regras e ampliação do modelo de dados. |
| 15 | PB15 | Atualização da conta | Como usuário autenticado, quero atualizar meu nome, e-mail e senha para manter meus dados corretos. | Baixa | Permitir alterar somente a própria conta; validar e-mail único; exigir a senha atual para trocar a senha e armazenar o novo hash; impedir alteração de privilégios. | PB01 e PB02. |
| 16 | PB16 | Paginação de eventos | Como pessoa que consulta shows, quero navegar por páginas de resultados para encontrar eventos em listas extensas. | Baixa | Dividir feed e pesquisa em páginas de tamanho definido; manter o termo pesquisado e uma ordenação estável entre páginas; tratar páginas sem resultados. | PB06 e PB07. |

Todos os itens desta seção estão no estado **Proposto** e precisam ser refinados antes da implementação.

## 5. Condições para considerar um item concluído

- Os critérios de aceite do item foram atendidos e verificados em execução.
- As regras de acesso e de integridade relacionadas ao item foram verificadas, incluindo cenários de erro.
- As alterações não impediram o funcionamento dos fluxos principais relacionados.
- A documentação afetada foi atualizada e os resultados da verificação foram registrados.

## 6. Sequência sugerida de entrega

1. **Acesso à plataforma:** corrigir e validar cadastro, login e logout, correspondentes a PB01–PB03.
2. **Publicação e descoberta:** concluir e validar publicação, bandas, feed e pesquisa, correspondentes a PB04–PB07.
3. **Moderação e preparação do MVP:** validar permissões, corrigir a exclusão, revisar a experiência e alinhar a documentação, correspondentes a PB08–PB11.
4. **Evolução:** revisar as prioridades de PB12–PB16 conforme o uso e o retorno das pessoas que utilizam o SCENA.

As entregas não possuem datas ou estimativas de esforço definidas. A equipe deve refiná-las conforme sua capacidade e revisar a ordem do backlog quando surgirem novas necessidades.
