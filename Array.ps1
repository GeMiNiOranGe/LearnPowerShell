function Write-Loop {
    $numbers = 1..5
    $squaredNumbers = $numbers | ForEach-Object { "Number at $_ = $($_ * $_)" }

    Write-Host "Square:`n  $($squaredNumbers -join "`n  ")"
    # Write-Host $([string]::Join(", ", $squaredNumbers))
}

function Write-Array {
    $fruits = @("apple", "banana", "cherry")
    Write-Host "Origin:     $($fruits)"
    Write-Host "Type:       $($fruits.GetType())"
    Write-Host

    Write-Host "First item: $($fruits[0])"

    $fruits += "mango"
    Write-Host "Append:     $($fruits)"

    $fruits[1] = "water melon"
    Write-Host "Replace:    $($([string]::Join(", ", $fruits)))"
}
