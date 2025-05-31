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

function Find-ApprovedVerb {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string]$Keyword
    )
    
    $match = Get-Verb | Where-Object { $_.Verb -like "*$Keyword*" }

    $match ?? (Write-Warning "No approved verbs found matching keyword '$Keyword'")
}

function Remove-ItemsExcept {
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
    param (
        [string]$Path = ".",

        [Parameter(Mandatory)]
        [ValidateNotNullOrWhiteSpace()]
        [string]$ExcludePattern
    )

    if (-not (Test-Path $Path)) {
        throw "The path '$Path' is not exist."
    }

    $items = Get-ChildItem -Path $Path -Force
    $filteredItems = $items | Where-Object { $_.Name -notmatch $ExcludePattern }
    $filteredItems | ForEach-Object {
        if ($PSCmdlet.ShouldProcess($_, "Remove Item")) {
            Remove-Item -Path $_ -Recurse -Force
        }
    }
}

# How to use
# Remove-ItemsExcept -ExcludePattern "Item1.json|Item2.ps1|Item3.md|Item4.md" # -Confirm:$false
# Complex case:
# ```
# log_2023-12-01.txt
# log_2023-12-02.txt
# log_2024-01-01.txt
# log_2024-01-02.txt
# important-config.json
# latest.log
# ```
# $pattern = '^log_2024-\d{2}-\d{2}\.txt$'
# Or:
# Remove-Item * -Exclude "Item1.json", "Item2.ps1", "Item3.md", "Item4.md"

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
