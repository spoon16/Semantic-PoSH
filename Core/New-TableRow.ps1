function New-TableRow {
<#
.Synopsis
Creates a new table row that can be added to a table

.Description
Creates a new Intellidimension.Rdf.TableRow instance that can be added to a table

.Parameter cellCount
The number of cells the row will have

.Parameter table
The source table the new row should use as a template

.Parameter cells
The values that the new row should be initialized with
#>
	[CmdletBinding(DefaultParameterSetName = "FromInt_ParamSet")]
	param (
		[Parameter(Mandatory = $true, Position = 0, ParameterSetName = "FromInt_ParamSet")]
		[Alias("count")]
		[int] $cellCount,

		[Parameter(Mandatory = $true, Position = 0, ParameterSetName = "FromTable_ParamSet")]
		[Alias("tbl", "t")]
		[Intellidimension.Rdf.Table] $table,

		[Parameter(Mandatory = $true, Position = 1)]
		[Intellidimension.Rdf.RdfValue[]] $cells
	)
#	begin {
#	}
	process {
		switch ($PsCmdlet.ParameterSetName) {
			"FromTable_ParamSet" {
				$row = $table.NewRow($cells)
			}
			"FromInt_ParamSet" {
				$row = New-Object Intellidimension.Rdf.TableRow $cellCount
				for ($i = 0; $i -lt $row.Count -and $i -lt $cells.Length; $i ++) {
					$v = $cells[$i]
					$row.Cells[$i] = $cells[$i]
				}
			}
		}
		, $row
	}
#	end {
#	}
}
