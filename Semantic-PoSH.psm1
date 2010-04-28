Push-Location $psScriptRoot

. ./Helpers.ps1

loadPrerequisiteAssembly "PowerCollections" (Get-Item ./bin/PowerCollections.dll)
loadPrerequisiteAssembly "RdfCore" (Get-Item ./bin/RdfCore.dll)

. ./Core/New-DataSource.ps1
. ./Core/ConvertTo-RdfValue.ps1

Pop-Location

Export-ModuleMember -Function @('New-DataSource', 'ConvertTo-RdfValue')
