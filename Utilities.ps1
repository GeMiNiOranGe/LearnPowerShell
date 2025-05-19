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

function Write-Message {
    [CmdletBinding()]
    param (
        [Parameter()]
        [string]$Message,

        [Parameter()]
        [int]$Times
    )

    Write-Host $($Message * $(if ($Times) { $Times } else { 1 }))
}

# Write-Message -Message "Hello world`n" -Times 10

function Write-Alias {
    # Output: cls -> Clear-Host
    Get-Alias cls
    
    # Output:
    # ALIASES
    #     clear
    #     cls
    Get-Help cls

    Get-Help help

    # Open online docs
    Get-Help Get-ChildItem -Online
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
