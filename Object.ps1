# A hashtable
Write-Host "A hashtable:"
@{
    Name = "Bob";
    Age  = 25
} | ConvertTo-Json
Write-Host

# A object
Write-Host "A object:"
[PSCustomObject]@{
    Name = "Bob";
    Age  = 25
} | ConvertTo-Json
