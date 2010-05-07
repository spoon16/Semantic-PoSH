function Restore-RdfObject {
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
	[CmdletBinding()]
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
		try {
			if ($context -ne $null) {
				$ds = New-Object Intellidimension.Rdf.InMemoryGraph 3
				$ds.Add($dataSource.GetStatements($context, $null, $null, $null))
			}
			else {
				$ds = $dataSource
			}

			$serializer = New-Object Intellidimension.Rdf.RdfSerializer $ds
			$serializer.Deserialize($uri)
		}
		catch [System.InvalidOperationException] {
			Write-Error "Unable to deserialize object with URI: $uri"
		}
	}
#	end {
#	}
}
