# Gerenciador de Contas do Tibia - AutoLogin Script

Este script AutoHotkey oferece uma solução automatizada para gerenciar e acessar múltiplas contas no Tibia. 
Utilizando uma interface gráfica de usuário (GUI) intuitiva, o script simplifica o processo de login, tornando-o rápido e eficiente.

## Observacoes ##
Esse script nao criptografa seus dados, pois eles sao salvos localmente no seu computador.
Nenhuma requisicao externa e feita (Leia-se acessar a internet para nada)
O script vai dar falso positivo com o Windows Defender. Voce pode desabilitar o Windows Defender ou colocar a pasta onde salvar o script em excecao.

## Funcionalidades

### Gerenciamento de Contas de Jogo
- **Adicionar, Excluir e Listar Contas**: Facilmente gerencie suas contas de jogo. Adicione novas contas, exclua as indesejadas ou visualize a lista de contas existentes através de uma GUI amigável.

### Automação do Processo de Login
- **Login Automático**: O script armazena e utiliza informações como e-mail e senha para efetuar logins automáticos nas contas do Tibia, eliminando a necessidade de inserções manuais repetitivas.

### Configuração de Coordenadas de Tela
- **Definição de Coordenadas**: Configure as coordenadas de cliques do mouse para campos de entrada específicos, como e-mail, senha e botão de login. Isso é realizado através de cliques manuais, e as coordenadas são salvas para uso automático posterior.

### Interface Gráfica de Usuário (GUI)
- **Interação Simplificada**: A GUI intuitiva oferece facilidade na gestão das contas, configuração de coordenadas e início do processo de login automático.

### Leitura e Limpeza de Dados
- **Manutenção de Dados**: O script lê informações de contas de arquivos de texto (Chars.txt, Email.txt, Senhas.txt) e realiza a limpeza desses arquivos removendo linhas em branco, garantindo assim a integridade dos dados.

### Personalização e Configuração
- **Customização do Script**: Personalize aspectos como posição e tamanho da janela da GUI, adaptando o script às suas necessidades e preferências.

## Uso
Para usar o script e necessario ter o AutoHotkey v1 instalado no seu computador.
Voce pode encontrar o AutoHotkey aqui: https://www.autohotkey.com/

Aconselho baixar o script dentro de uma pasta e colocar um atalho na area de trabalho, pois ao rodar o script pela primeira vez, ele vai criar arquivos de configuracao e database para as contas (Config.ini, Chars.txt, Senhas.txt, Email.txt).

Ao rodar o script pela primeira vez, voce precisa clicar no botao Configurar e seguir o passo a paso indicado pelo script para configurar as coordenadas da sua caixa de email, senha e o botao de login do Tibia.

## Compartilhar Conta ##
Caso voce queira enviar sua conta para alguem, voce pode selecionar a conta que quer compartilhar e clicar em "Compartilhar Conta". A conta sera automaticamente copiada para a area de transferencia no seguinte formato:
Conta: Conta Fake
Email: contafake@fake.com
Senha: senhafake123

## Colar Conta ##
Se alguem que ja usa esse modelo de script te enviar contas, voce pode copiar os dados e colar em "Colar Conta".
O formato precisa ser o mesmo:
Conta: Conta Fake
Email: contafake@fake.com
Senha: senhafake123


## Login ##
Ao ter configurado e adicionado contas para o script, basta selecionar a conta a ser logada e clicar em "Login".


## Contribuições
Contribuições para melhorar o script são sempre bem-vindas. Se você tiver sugestões ou melhorias, sinta-se à vontade para abrir um issue ou pull request.
