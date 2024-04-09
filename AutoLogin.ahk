#NoTrayIcon
#NoEnv
SetKeyDelay, -1
SendMode Input
SetWorkingDir %A_ScriptDir%
FileEncoding, UTF-8

; Ler última posição da janela
IniRead, LastPosX, config.ini, WindowPosition, X, 50
IniRead, LastPosY, config.ini, WindowPosition, Y, 50

; Remover linhas em branco dos arquivos de dados
RemoveBlankLines("Chars.txt")
RemoveBlankLines("Email.txt")
RemoveBlankLines("Senhas.txt")

; Carregar contas ao iniciar
ReloadAccounts()

; GUI principal
Gui, Color, 232324
Gui, Add, ListBox, vAccountList w170 h300 gListBoxClick, % ListaDeContas()
Gui, Add, Button, x10 y320 w100 gAddAccount, Adicionar
Gui, Add, Button, x+15 y320 w100 gDeleteAccount, Excluir
Gui, Add, Button, x+20 y320 w100 gExitApp, Sair
Gui, Add, Button, x10 y380 w335 gLogin, Login
Gui, Add, Button, x10 y350 w100 gConfigurarCoordenadas, Configurar
Gui, Add, Button, x245 y350 w100 gCompartilharConta, Compartilhar Conta
Gui, Add, Button, x125 y350 w100 gColarConta, Colar Conta
Gui, Show, w400 h400, Gerenciador de Contas
Gui, Show, x%LastPosX% y%LastPosY% w355 h420, AutoLogin 1.1
Return

ConfigurarCoordenadas:
    ; Instruções para o usuário
    MsgBox, Clique com o botão direito no campo de email no Tibia.
    KeyWait, RButton, D
    MouseGetPos, EmailX, EmailY
    MsgBox, Clique com o botão direito no campo de senha.
    KeyWait, RButton, D
    MouseGetPos, SenhaX, SenhaY
    MsgBox, Clique com o botão direito no botão de login.
    KeyWait, RButton, D
    MouseGetPos, LoginX, LoginY

    ; Salvar as coordenadas no arquivo de configuração
    IniWrite, %EmailX%, config.ini, Coordenadas, EmailX
    IniWrite, %EmailY%, config.ini, Coordenadas, EmailY
    IniWrite, %SenhaX%, config.ini, Coordenadas, SenhaX
    IniWrite, %SenhaY%, config.ini, Coordenadas, SenhaY
    IniWrite, %LoginX%, config.ini, Coordenadas, LoginX
    IniWrite, %LoginY%, config.ini, Coordenadas, LoginY
    MsgBox, Coordenadas configuradas com sucesso.
Return

ListBoxClick:
    ClickedControl := A_GuiControl
    If (A_ThisHotkey = "RButton" && ClickedControl = "AccountList") {
        MouseGetPos, MouseX, MouseY
        Menu, AccountMenu, Show, %MouseX%, %MouseY%
    }
Return

CompartilharConta:
    GuiControlGet, CurrentSelection, , AccountList
    if (CurrentSelection = "") {
        MsgBox, Selecione uma conta para compartilhar.
        return
    }

    ; Obter os detalhes da conta selecionada
    index := -1
    Loop, Read, Chars.txt
    {
        if (A_LoopReadLine = CurrentSelection) {
            index := A_Index
            break
        }
    }

    if (index = -1) {
        MsgBox, Conta nao encontrada.
        return
    }

    ; Ler os detalhes da conta
    FileReadLine, accountName, Chars.txt, %index%
    FileReadLine, accountEmail, Email.txt, %index%
    FileReadLine, accountPassword, Senhas.txt, %index%

    ; Formatar e copiar para a área de transferência
    Clipboard := "Conta: " . accountName . "`nEmail: " . accountEmail . "`nSenha: " . accountPassword
    MsgBox, Detalhes da conta copiados para a area de transferencia.
Return

ColarConta:
    Gui, 3:New, +AlwaysOnTop
    Gui, 3:Add, Edit, vPasteData w300 h100 +Multi  ; Permitir múltiplas linhas
    Gui, 3:Add, Button, gSubmitPaste x10 y110, OK
    Gui, 3:Add, Button, gCancelPaste x+100 y110, Cancelar  ; Corrigido para x+100
    Gui, 3:Show, w320 h140, Colar Conta
Return

SubmitPaste:
    Gui, 3:Submit
    ; Parsear os dados com quebras de linha
    if (RegExMatch(PasteData, "Conta: (.*?)\nEmail: (.*?)\nSenha: (.*)", matches)) {
        FileAppend, %matches1%`n, Chars.txt
        FileAppend, %matches2%`n, Email.txt
        FileAppend, %matches3%`n, Senhas.txt
        Reload  ; Reinicia o script
    } else {
        MsgBox, Formato de dados inválido.
    }
    Gui, 3:Destroy
Return

CancelPaste:
    Gui, 3:Destroy
Return



; Eventos dos botões
AddAccount:
    Gui, 2:New, +AlwaysOnTop
    Gui, 2:Add, Text, , Nome do Char:
    Gui, 2:Add, Edit, vNewChar
    Gui, 2:Add, Text, , Email:
    Gui, 2:Add, Edit, vNewEmail
    Gui, 2:Add, Text, , Senha:
    Gui, 2:Add, Edit, vNewPassword Password  ; Campo de senha
    Gui, 2:Add, Button, Default gSubmitNewAccount, Salvar
    Gui, 2:Add, Button, gCancelNewAccount, Cancelar
    Gui, 2:Show, , Adicionar Nova Conta
Return

SubmitNewAccount:
    Gui, 2:Submit  ; Salva os dados inseridos nas variáveis
    if (NewChar = "" || NewEmail = "" || NewPassword = "") {
        MsgBox, Todos os campos são obrigatórios.
        return
    }
    FileAppend, %NewChar%`n, Chars.txt
    FileAppend, %NewEmail%`n, Email.txt
    FileAppend, %NewPassword%`n, Senhas.txt

    Reload  ; Reinicia o script
Return

CancelNewAccount:
    Gui, 2:Destroy
Return

DeleteAccount:
    GuiControlGet, CurrentSelection, , AccountList
    if (CurrentSelection = "") {
        MsgBox, Selecione uma conta para excluir.
        return
    }

    MsgBox, 4, , Tem certeza que deseja excluir esta conta? Esta acao nao pode ser desfeita.
    IfMsgBox, No
        return

    ; Encontrar o índice da conta selecionada
    index := -1
    Loop, Read, Chars.txt
    {
        if (A_LoopReadLine = CurrentSelection) {
            index := A_Index
            break
        }
    }

    if (index = -1) {
        MsgBox, Conta nao encontrada.
        return
    }

    ; Remover a conta dos arquivos
    RemoveLine(index, "Chars.txt")
    RemoveLine(index, "Email.txt")
    RemoveLine(index, "Senhas.txt")

    Reload  ; Reinicia o script
Return

RemoveLine(lineNumber, filePath) {
    TempFile := A_Temp "\temp.txt"
    FileDelete, %TempFile%
    FileRead, fileContent, %filePath%
    SplitFile := StrSplit(fileContent, "`n", "`r")
    
    ; Reescrever o conteúdo no arquivo temporário, excluindo a linha selecionada
    Loop, % SplitFile.MaxIndex()
    {
        if (A_Index != lineNumber)
            FileAppend, % SplitFile[A_Index] "`n", %TempFile%
    }
    
    ; Substituir o arquivo original pelo temporário
    FileDelete, %filePath%
    FileMove, %TempFile%, %filePath%
}


GuiClose:
ExitApp:
    ; Salvar posição da janela antes de sair
    WinGetPos, CurrentX, CurrentY, Width, Height, A
    IniWrite, %CurrentX%, config.ini, WindowPosition, X
    IniWrite, %CurrentY%, config.ini, WindowPosition, Y
    ExitApp
Return


Login:
    GuiControlGet, CurrentSelection, , AccountList
    if (CurrentSelection = "") {
        MsgBox, Selecione uma conta para fazer login.
        return
    }

    ; Verifica se o Tibia está aberto
    IfWinExist, ahk_class Qt5158QWindowOwnDCIcon
    {
        WinActivate, ahk_class Qt5158QWindowOwnDCIcon

        ; Ler as coordenadas de config.ini
        IniRead, EmailX, config.ini, Coordenadas, EmailX
        IniRead, EmailY, config.ini, Coordenadas, EmailY
        IniRead, SenhaX, config.ini, Coordenadas, SenhaX
        IniRead, SenhaY, config.ini, Coordenadas, SenhaY
        IniRead, LoginX, config.ini, Coordenadas, LoginX
        IniRead, LoginY, config.ini, Coordenadas, LoginY

        ; Verifica se as coordenadas estão configuradas
        if (EmailX = "" or EmailY = "" or SenhaX = "" or SenhaY = "" or LoginX = "" or LoginY = "")
        {
            MsgBox, Configure as coordenadas antes de tentar fazer login.
            return
        }

        ; Obter email e senha da conta selecionada
        index := -1
        Loop, Read, Chars.txt
        {
            if (A_LoopReadLine = CurrentSelection) {
                index := A_Index
                break
            }
        }

        if (index = -1) {
            MsgBox, Conta nao encontrada.
            return
        }

        FileReadLine, accountEmail, Email.txt, %index%
        FileReadLine, accountPassword, Senhas.txt, %index%

        ; Automação de login
        Sleep, 200  ; Espera para garantir que a janela esteja ativa
        MouseClick, left, %EmailX%, %EmailY%
        Sleep, 200
        SendInput, %accountEmail%
        Sleep, 200
        MouseClick, left, %SenhaX%, %SenhaY%
        Sleep, 200
        SendInput, {Raw}%accountPassword%
        Sleep, 100
        MouseClick, left, %LoginX%, %LoginY%

    } else {
        MsgBox, Tibia não encontrado.
    }
Return


; Funções adicionais
ListaDeContas() {
    lista := ""
    Loop, Read, Chars.txt
    {
        ; Cada nome do personagem é adicionado à lista, separado por '|'
        lista .= A_LoopReadLine . "|"
    }
    return RTrim(lista, "|")  ; Remove o último '|'
}

ReloadAccounts() {
    accounts := []  ; Limpa a lista atual de contas
    Loop, Read, Chars.txt
    {
        charName := A_LoopReadLine
        accounts.Push({char: charName})
    }
    GuiControl,, AccountList, % ListaDeContas()  ; Atualiza a ListBox
}

RemoveBlankLines(filePath) {
    TempContent := ""
    Loop, Read, %filePath%
    {
        if (A_LoopReadLine != "")
            TempContent .= A_LoopReadLine . "`n"
    }
    FileDelete, %filePath%
    FileAppend, %TempContent%, %filePath%
}

