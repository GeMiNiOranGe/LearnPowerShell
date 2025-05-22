$person = @{
    id             = 1
    height         = 1.88
    "phone number" = "0462365476"
    address        = @{
        street   = "Torotachi"
        district = 9
    }
    habit          = @(
        "Sprint",
        "Walk",
        "Climbing"
    )
}

Write-Host "===> Origin:"
$person

Write-Host

$person["age"] = 30
$person."phone number" = "0000000000"
$person.Add("name", "Mike")

Write-Host "===> After adding:"
$person

Write-Host

$person.Remove("phone number")

Write-Host "===> Remove 'phone number':"
$person

Write-Host

$keyColumnSize = -10
Write-Host "===> Use 'GetEnumerator' method:"
Write-Host "$("{0,$keyColumnSize}" -f "Key")Value"
foreach ($entry in $person.GetEnumerator()) {
    $key = $entry.Key
    $value = $entry.Value

    Write-Host "$("{0,$keyColumnSize}" -f "${key}:")$value"
}
Write-Host

Write-Host "===> Use 'Keys' property:"
Write-Host "$("{0,$keyColumnSize}" -f "Key")Value"
foreach ($key in $person.Keys) {
    $value = $person[$key]

    Write-Host "$("{0,$keyColumnSize}" -f "${key}:")$value"
}
