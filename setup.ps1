# wingetでインストール
winget install gerardog.gsudo
winget install Microsoft.PowerToys
winget install git.git

# ファイル配置
$copyFiles = @(
    @{
        # PowerShellプロファイル
        Path        = Join-Path $PSScriptRoot 'PowerShell/Microsoft.PowerShell_profile.ps1'
        Destination = $PROFILE
    },
    @{
        # OhMyPoshテーマ
        Path        = Join-Path $PSScriptRoot 'OhMyPosh/my.omp.json'
        Destination = $PROFILE | Split-Path -Parent
    },
    @{
        # PowerToys Keyboard Manager プロファイル
        Path        = Join-Path $PSScriptRoot 'PowerToys/Keyboard Manager/default.json'
        Destination = Join-Path $env:LOCALAPPDATA 'Microsoft/PowerToys/Keyboard Manager/default.json'
    }
)
foreach($param in $copyFiles){
    if ($param.Destination | ? { !($_ | Split-Path -Parent | Test-Path) }) {
        Write-Warning "コピー元ファイルがありませんでした:$($param.Path)"
        continue
    }
    Copy-Item @param
}

# キー再マップ
# CapsLockを右Ctrlに変更
$param = @{
    Path  = 'HKLM:\SYSTEM\CurrentControlSet\Control\Keyboard Layout'
    Name  = 'Scancode Map'
    Value = [byte[]]@(
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x01, 0x00, 0x00, 0x00, 0x1D, 0xE0, 0x3A, 0x00,
        0x00, 0x00, 0x00, 0x00
    )
}
Set-ItemProperty @param