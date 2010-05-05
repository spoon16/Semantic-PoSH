function Save-Table {
	[CmdletBinding()]
	param(
		[Parameter(Mandatory = $true, Position = 0)]
		[Alias("t", "tbl")]
		$table,

		[Parameter(Mandatory = $false, Position = 1)]
		[Alias("f")]
		[IO.FileInfo] $file,
		
		[Parameter(Mandatory = $false, Position = 2)]
		[ValidateSet("SPARQLXML", "WIRETABLE")] 
		[string] $format = "SPARQLXML"
	)
#	begin {
#	}
	process {
		if ($table -is [Intellidimension.Rdf.Table] -or $table -is [Intellidimension.Rdf.WireTable]) {
			if ($file -ne $null) {
				Write-Debug ("Saving table to: " + $file.FullName)
				$stream = $file.Create()
			}
			else {
				$stream = New-Object IO.MemoryStream
			}

			switch ($format.ToUpperInvariant()) {
				"SPARQLXML" {
					$textWriter = New-Object IO.StreamWriter $stream

					$table = [Intellidimension.Rdf.Table] $table
					$formatter = New-Object Intellidimension.Sparql.SparqlXmlFormatter @($table, [Intellidimension.Sparql.CommandSelect])
					$formatter.Write($textWriter)
				}
				"WIRETABLE" {
					$table = [Intellidimension.Rdf.WireTable] $table
					$table.Save($stream)
				}
			}

			if ($stream -isnot [IO.FileStream]) {
				$stream.ToArray()
			}
			
			$stream.Close()
			$stream.Dispose()
		}
		else {
			Write-Error "`$table must be of type Intellidimension.Rdf.Table or Intellidimension.Rdf.WireTable"
		}
	}
#	end {
#	}
}
