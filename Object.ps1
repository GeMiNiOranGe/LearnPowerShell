# A hashtable
Write-Host "A hashtable:"
@{
    Name = "Bob"
    Age  = 25
} | ConvertTo-Json
Write-Host

# A object
Write-Host "A object:"
[PSCustomObject]@{
    Name = "Bob"
    Age  = 25
} | ConvertTo-Json
Write-Host

#################################################

$employee = [PSCustomObject]::new()

Add-Member -InputObject $employee -MemberType NoteProperty -Name "Id" -Value 1
Add-Member -InputObject $employee -MemberType NoteProperty -Name "Name" -Value "Mike"
Add-Member -InputObject $employee -MemberType NoteProperty -Name "Title" -Value "CEO"

Get-Member -InputObject $employee
