Push-Location $psScriptRoot

. ./Helpers.ps1

loadPrerequisiteAssembly "PowerCollections" (Get-Item ./bin/PowerCollections.dll)
loadPrerequisiteAssembly "RdfCore" (Get-Item ./bin/RdfCore.dll)

. ./Core/New-DataSource.ps1
. ./Core/ConvertTo-RdfValue.ps1
. ./Core/Restore-RdfObject.ps1
. ./Core/Save-DataSource.ps1
. ./Core/New-Table.ps1
. ./Core/New-TableRow.ps1
. ./Core/Save-Table.ps1

Pop-Location

Export-ModuleMember -Function @('New-DataSource', 'ConvertTo-RdfValue', 'Restore-RdfObject', 'Save-DataSource', 'New-Table', 'New-TableRow', 'Save-Table')
