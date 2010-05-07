function New-Statement {
<#
.Synopsis
Create a new statement

.Description
Creates a new Intellidimension.Rdf.Statement from a provided context (optional), subject, predicate, object

.Parameter subject
Intellidimension.Rdf.RdfUri that represents the predicate of the new statement

.Parameter predicate
Intellidimension.Rdf.RdfUri that represents the predicate of the new statement

.Parameter object
Intellidimension.Rdf.RdfValue that represents the object of the new statement

.Parameter context
Intellidimension.Rdf.RdfUri that represents the context of the new statement

.Example
SIMPLE
--------------------
$stmt = New-Statement $subject $predicate $object

WITH CONTEXT
--------------------
$stmt = New-Statement -s $subject -p $predicate -o $object -c $context
#>
	[CmdletBinding()]
	param (
		[Parameter(Mandatory = $true, Position = 0)]
		[Alias("s")]
		[Intellidimension.Rdf.RdfUri] $subject,

		[Parameter(Mandatory = $true, Position = 1)]
		[Alias("p")]
		[Intellidimension.Rdf.RdfUri] $predicate,

		[Parameter(Mandatory = $true, Position = 2)]
		[Alias("o")]
		[Intellidimension.Rdf.RdfValue] $object,

		[Parameter(Mandatory = $false, Position = 3)]
		[Alias("c")]
		[Intellidimension.Rdf.RdfUri] $context = (ConvertTo-RdfValue ("<" + [Intellidimension.Rdf.NS]::ItdNull + ">"))
	)
	begin {
	}
	process {
		New-Object Intellidimension.Rdf.Statement @($context, $subject, $predicate, $object)
	}
	end {
	}
}
