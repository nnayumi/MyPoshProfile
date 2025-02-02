# エンコーディング
chcp 65001 > $null
$PSDefaultParameterValues['*:Encoding'] = 'utf8'
$global:OutputEncoding = [System.Text.Encoding]::UTF8
[console]::OutputEncoding = [System.Text.Encoding]::UTF8

# OhMyPosh
oh-my-posh init pwsh --config (Join-Path ($PROFILE|Split-Path -Parent) 'my.omp.json')|Invoke-Expression

# キーバインディング設定
Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineKeyHandler -Key Ctrl+i -Function Complete
Set-PSReadLineKeyHandler -Key Tab -Function TabCompleteNext
Set-PSReadLineKeyHandler -Key Shift+Tab -Function TabCompletePrevious
Set-PSReadLineKeyHandler -Key Escape -Function RevertLine

# エイリアス系
Set-Alias gsudo sudo
function open{param($path) explorer.exe $path}
