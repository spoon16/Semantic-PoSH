function New-Table {
<#
.Synopsis
Create a new Table object

.Description
Creates a new Intellidimension.Rdf.Table instance with the specified column count and column names, can optionally be initialized with a set of table rows passed via the pipeline

.Parameter columnCount

.Parameter columnNames

.Parameter row

.Example
$tbl = ($rows | New-Table 5)
#>
	[CmdletBinding()]
	param (
		[Parameter(Mandatory = $true, Position = 0)]
		[Alias("columns")]
		[int] $columnCount,

		[Parameter(Mandatory = $false)]
		[Alias("names")]
		[string[]] $columnNames,

		[Parameter(Mandatory = $false, Position = 1, ValueFromPipeline = $true)]
		$rows
	)
	begin {
		$tbl = New-Object Intellidimension.Rdf.Table $columnCount
		for ($i = 0;
		     $i -lt $columnNames.Count -and $i -lt $columnCount;
                     $i ++) {
			$tbl.SetColumnName($i, $columnNames[$i])
		}
	}
	process {
		foreach ($row in $rows) {
			$tbl.AddRow($row) | Out-Null
		}
	}
	end {
		$tbl
	}
}
