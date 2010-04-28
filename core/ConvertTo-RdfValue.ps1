function ConvertTo-RdfValue {
<#
.Synopsis
Convert a string to an RDF value

.Description
Converts a string to the RDF value (Intellidimension.Rdf.RdfValue) that it represents.

.Example
$subject = ConvertTo-RdfValue "<http://example.org/resource/12345>"

.Parameter value
The string value that should be converted to an RDF value

.Notes
	History:
		v0.1 - converts a string to an RDF value
#>
	[CmdletBinding()]
	param (
		[Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true)]
		[Alias("v", "val")]
		[string]$value
	)
#	begin {
#	}
	process {
		if ($value -eq $null) {
			New-Object Intellidimension.Rdf.RdfNull
		}
		else {
			[Intellidimension.Rdf.RdfValue]::Parse($value)
		}
	}
#	end {
# 	}
}
