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

    # Array: Performance will decrease when adding a new value because a new
    # array is created to store both the existing values and the newly added
    # one. The old array is then discarded.

    # Safe way: $fruits.Add("mango") ---> throw an exception
    $fruits += "mango"
    Write-Host "Append:     $($fruits)"

    $fruits[1] = "water melon"
    Write-Host "Replace:    $($([string]::Join(", ", $fruits)))"
}

function Write-ArrayAndArrayListType {
    $arraytype = @("Num1", "Num2").GetType()
    Write-Host $arraytype

    $arrayListtype = [System.Collections.ArrayList]::new(@("Num1", "Num2")).GetType()
    Write-Host $arrayListtype
}

function Write-ArrayList {
    $arrayList = [System.Collections.ArrayList]::new()

    [void]$arrayList.Add(50)
    [void]$arrayList.Add("Hello")
    [void]$arrayList.Add("World")

    $arrayList.AddRange(
        @(
            10.7,
            [hashtable]@{
                Name = "Mike";
                Age  = 30
            },
            [array]@(
                1, 
                "New", 
                "World"
            )
        )
    )

    [string]::Join(", ", $arrayList.ToArray())
}
