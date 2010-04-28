function Restore-RdfObject {
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> 9ec4aac... Restore-RdfObject documentation added
<#
.Synopsis
Deserialize an RDF object from a DataSource

.Description
Deserialize an RDF object (any object that implements Intellidimension.Rdf.IRdfSerializable) from a DataSource

.Link

.Example
$cm = Restore-RdfObject $ds (ConvertTo-RdfValue "<TheModel>")

.Parameter dataSource
The source of the data that will be deserialized

.Parameter uri
The URI of the object to deserialize

.Parameter context
Optional parameter that can be used to define the context the object should be deserialized from

.Notes
	History:
		v0.1 - deserializes an RDF object
#>
<<<<<<< HEAD
<<<<<<< HEAD
	[CmdletBinding()]
=======
>>>>>>> 5b3d3cc... implemented Restore-RdfObject functionality
=======
	[CmdletBinding]
>>>>>>> 9ec4aac... Restore-RdfObject documentation added
=======
	[CmdletBinding()]
>>>>>>> 2113d06... Fixed bugs in Restore-RdfObject (syntax) and added Restore-RdfObject to module exports
	param (
		[Parameter(Mandatory = $true, Position = 0)]
		[Alias("ds")]
		[Intellidimension.Rdf.DataSource] $dataSource,

		[Parameter(Mandatory = $true, Position = 1)]
		[Alias("u")]
		[Intellidimension.Rdf.RdfUri] $uri,

		[Parameter(Mandatory = $false, Position = 2)]
		[Alias("c", "ctx")]
		[Intellidimension.Rdf.RdfUri] $context = $null
	)
#	begin {
#	}
	process {
<<<<<<< HEAD
<<<<<<< HEAD
		if ($context -ne $null) {
			$ds = New-Object Intellidimension.Rdf.InMemoryGraph 3
			$ds.Add($dataSource.GetStatements($context, $null, $null, $null))
=======
		if ($context -neq $null) {
			$ds = New-Object Intellidimension.Rdf.InMemoryGraph 3
			$ds.Add($dataSource.GetStatements($context, $null, $null, $null)
>>>>>>> 5b3d3cc... implemented Restore-RdfObject functionality
=======
		if ($context -ne $null) {
			$ds = New-Object Intellidimension.Rdf.InMemoryGraph 3
			$ds.Add($dataSource.GetStatements($context, $null, $null, $null))
>>>>>>> 2113d06... Fixed bugs in Restore-RdfObject (syntax) and added Restore-RdfObject to module exports
		}
		else {
			$ds = $dataSource
		}

		$serializer = New-Object Intellidimension.Rdf.RdfSerializer $ds
		$serializer.Deserialize($uri)
	}
#	end {
#	}
}
