function New-RdfUri {
<#
.Synopsis
Create a new RdfUri

.Description
Create a new Intellidimension.Rdf.RdfUri instance

.Parameter value
The value that will be used to initialize the new RdfUri

.Example
SIMPLE
------------------
$uri = New-RdfUri 'http://example.org/resource#id'
#>
	[CmdletBinding()]
	param (
		[Parameter(Mandatory = $true, Position = 0)]
		[Alias("v")]
		[string] $value
	)
	begin {
	}
	process {
		New-Object Intellidimension.Rdf.RdfUri $value
	}
	end {
	}
}
