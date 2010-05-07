function New-RdfLiteral {
<#
.Synopsis
Creates a new RdfLiteral

.Description
Creates a new Intellidimension.Rdf.RdfLiteral object

.Parameter value
The value of the RdfLiteral

.Parameter type
The URI of the type that will be assigned to the RdfLiteral

.Parameter xsdType
Shortcut for types that exist in the XSD (http://www.w3.org/2001/XMLSchema#) namespace

.Parameter language
The language that will be assigned to the new RdfLiteral

.Example
SIMPLE
--------------------
$ltrl = New-RdfLiteral test

WITH XSD TYPE
--------------------
$ltrl = New-RdfLiteral test -xsdType string

WITH CUSTOM TYPE
--------------------
$ltrl = New-RdfLiteral test -type "http://example.org/myType"

WITH LANGUAGE
--------------------
$ltrl = New-RdfLiteral test -language en
#>
	[CmdletBinding(DefaultParameterSetName = "Xsd_ParamSet")]
	param (
		[Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true)]
		[Alias("v")]
		[string] $value,

		[Parameter(Mandatory = $false, ParameterSetName = "Any_ParamSet")]
		[Alias("t")]
		[string] $type,

		[Parameter(Mandatory = $false, Position = 1, ParameterSetName = "Xsd_ParamSet")]
		[Alias("xsd")]
		[string] $xsdType,

		[Parameter(Mandatory = $false, Position = 2)]
		[Alias("l", "lang")]
		[string] $language = $null
	)
	begin {
		$typeUri = $null

		switch ($PsCmdlet.ParameterSetName) {
			"Any_ParamSet" {
				$typeUri = $type
			}
			"Xsd_ParamSet" {
				if ([string]::IsNullOrEmpty($xsdType) -ne $true) {
					$typeUri = ([Intellidimension.Rdf.NS]::Xsd + $xsdType)
				}
			}
		}
	}
	process {
		New-Object Intellidimension.Rdf.RdfLiteral @($value, $typeUri, $language)
	}
#	end {
#	}
}
