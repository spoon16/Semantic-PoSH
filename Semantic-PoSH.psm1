Push-Location $psScriptRoot

function loadPrerequisiteAssembly {
    param (
        [string] $name,
        [IO.FileInfo] $file
    )
    
    try { 
        $a = [Reflection.Assembly]::Load($name)
    }
    catch [IO.FileNotFoundException] {
	    if($a -eq $null) {
		$a = [Reflection.Assembly]::LoadFrom($file.FullName)
	    }
    }
}

loadPrerequisiteAssembly "PowerCollections" (Get-Item ./bin/PowerCollections.dll)
loadPrerequisiteAssembly "RdfCore" (Get-Item ./bin/RdfCore.dll)

. ./Core/New-DataSource.ps1
. ./Core/ConvertTo-RdfValue.ps1
. ./Core/Restore-RdfObject.ps1
. ./Core/Save-DataSource.ps1
. ./Core/New-Table.ps1
. ./Core/New-TableRow.ps1
. ./Core/Save-Table.ps1
. ./Core/Restore-Table.ps1
. ./Core/New-Statement.ps1
. ./Core/New-RdfLiteral.ps1
. ./Core/New-RdfUri.ps1

Pop-Location

Export-ModuleMember -Function @('New-DataSource', 'ConvertTo-RdfValue', 'New-RdfLiteral', 'New-RdfUri', 'Restore-RdfObject', 'Save-DataSource', 'New-Table', 'New-TableRow', 'Save-Table', 'Restore-Table',  'New-Statement', 'New-ClientModel')
