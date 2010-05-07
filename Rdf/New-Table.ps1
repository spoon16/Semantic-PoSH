function New-Table {
<#
.Synopsis
Create a new Table object

.Description
Creates a new Intellidimension.Rdf.Table instance with the specified column count and column names, can optionally be initialized with a set of table rows passed via the pipeline

.Parameter columnCount
The number of columns the new table should have

.Parameter columnNames
An array that contains the column names that should be assigned to each column in the table

.Parameter rows
Rows that the table should be initialized with

.Example
SIMPLE
----------------------------
$tbl = New-Table 5

WITH COLUMN NAMES
----------------------------
$tbl = New-Table 5 -names @("first", "second", "third", "fourth", "fifth")

WITH ROWS
----------------------------
$tbl = New-Table 5 $rows

WITH ROWS FROM PIPELINE
----------------------------
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
		[Intellidimension.Rdf.TableRow[]] $rows
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
