function Write-AllConsoleColor {
    $colors = [Enum]::GetValues([System.ConsoleColor])
    $index = 1

    foreach ($fg in $colors) {
        foreach ($bg in $colors) {
            Write-Host $("{0,-5}" -f "${index}:") -NoNewline
            Write-Host "Foreground: $fg, Background: $bg" `
                -ForegroundColor $fg `
                -BackgroundColor $bg
            $index++
        }
    }
}

function Write-CurrentFilePath {
    $currentFilePath = $MyInvocation.PSCommandPath

    Write-Host "$($MyInvocation)"
    Write-Host "$($currentFilePath)"
    Write-Host "Default:        '$(Split-Path $currentFilePath)'"
    Write-Host "-Parent:        '$(Split-Path -Parent $currentFilePath)'"
    Write-Host "-Qualifier:     '$(Split-Path -Qualifier $currentFilePath)'"
    Write-Host "-Leaf:          '$(Split-Path -Leaf $currentFilePath)'"
    Write-Host "-NoQualifier:   '$(Split-Path -NoQualifier $currentFilePath)'"
    Write-Host "-Resolve:       '$(Split-Path -Resolve $currentFilePath)'"
}

function Start-Main {
    # Write-AllConsoleColor
    Write-CurrentFilePath
}

If ((
        Resolve-Path -Path $MyInvocation.InvocationName
    ).ProviderPath -eq $MyInvocation.MyCommand.Path
) {
    Start-Main
}
