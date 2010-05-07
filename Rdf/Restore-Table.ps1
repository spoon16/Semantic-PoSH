function Restore-Table {
<#
.Synopsis
Reads a table from a stream or file

.Description
Reads a Intellidimension.Rdf.Table or Intellidimension.Rdf.WireTable instance from a stream and writes it to the pipeline

.Parameter file
The file that contains the table source data

.Parameter stream
The stream that contains the table source data

.Parameter format
The format of the source data, can be SPARQLXML or WIRETABLE

.Example
SIMPLE
-------------------
$tbl = Restore-Table .\TEMP.sparqlres

WITH FORMAT
-------------------
$tbl = Resotre-Table -file .\TEMP.wt -format WIRETABLE

FROM STREAM
-------------------
$tbl = Restore-Table -stream $s -format WIRETABLE
#>
	[CmdletBinding(DefaultParameterSetName = "FromFile_ParamSet")]
	param (
		[Parameter(Mandatory = $true, Position = 0, ParameterSetName = "FromFile_ParamSet")]
		[Alias("f")]
		[IO.FileInfo] $file,
		
		[Parameter(Mandatory = $true, ParameterSetName = "FromStream_ParamSet", ValueFromPipeline = $true)]
		[Alias("s")]
		[IO.Stream] $stream,

		[Parameter(Mandatory = $false, Position = 1)]
		[ValidateSet("SPARQLXML", "WIRETABLE")]
		[string] $format = "SPARQLXML"
	)
#	begin {
#	}
	process {
		try {
			switch ($PsCmdlet.ParameterSetName) {
				"FromFile_ParamSet" {
					$targetStream = $file.OpenRead()
				}
				"FromStream_ParamSet" {
					$targetStream = $stream
				}
			}
	
			switch ($format.ToUpperInvariant()) {
				"SPARQLXML" {
					$reader = New-Object IO.StreamReader $targetStream
					$tbl = [Intellidimension.Sparql.SparqlXmlReader]::Parse($reader)
				}
				"WIRETABLE" {
					$tbl = New-Object Intellidimension.Rdf.WireTable
					$tbl.Load($targetStream)
				}
			}
		}
		catch [Exception] {
			Write-Error -Exception $_.Exception
		}
		finally {
			if ($PsCmdlet.ParameterSetName -eq "FromFile_ParamSet" -and $targetStream -ne $null) {
				$targetStream.Close()
				$targetStream.Dispose()
			}
		}

		$tbl
	}
#	end {
#	}
}
