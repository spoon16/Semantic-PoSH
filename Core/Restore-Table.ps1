function Restore-Table {
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

		if ($PsCmdlet.ParameterSetName) {
			$targetStream.Close()
			$targetStream.Dispose()
		}

		$tbl
	}
#	end {
#	}
}
