#New-Variable -Option Constant -Scope Script -Name DefaultParameterSetName -Value "Default_ParamSet"

function New-DataSource {
<#
.Synopsis
Initialize a new DataSource

.Description
Initializes a new Intellidimension.Rdf.DataSource instance and output's it to the pipeline.

.Link

.Example
$ds = New-DataSource -File .\RDF.ttl -Format Turtle

.Parameter File
The file that represents the RDF graph data to initialize the Intellidimension.Rdf.DataSource with.

.Notes
    History:
        v0.1 - creates a datasource, can be optionally initialized with the contents of a local file or remote URL
#>
    [CmdletBinding(DefaultParameterSetName = "Default_ParamSet")]
    
    param (
        [Parameter(ParameterSetName = "FromFile_ParamSet", ValueFromPipeline = $true, Mandatory = $false)]
        [IO.FileInfo] $file,
        
        [Parameter(Mandatory = $false, Position = 1)]
        [Alias("f")]
        [ValidateSet("RDFXML", "TURTLE", "NTRIPLES", "NQUADS", "SNAPSHOT")]
        [string] $format = "RDFXML",
        
        [Parameter(Mandatory = $false, Position = 2)]
        [Alias("a")]
        [ValidateRange(3, 4)]
        [int] $arity = 3,
        
        [Parameter(Mandatory = $false)]
        [Alias("c", "ctx")]
        [Intellidimension.Rdf.RdfUri] $context = (New-Object Intellidimension.Rdf.RdfUri "http://www.intellidimension.com/rdfserver#null"),
        
        [Parameter(Mandatory = $false)]
        [Alias("bs", "batch")]
        [long] $batchSize = 0
    )

    begin {
        $targetDS = New-Object Intellidimension.Rdf.InMemoryGraph $arity
        
        if ($batchSize -gt 0) {
            $originalBatchSize = $targetDS.BatchSize
            $targetDS.BatchSize = $batchSize
            Write-Debug "BatchSize: {1}" -f $targetDS.BatchSize
        }
        
        $targetDS.BeginUpdateBatch()
    }
    
    process {
        switch ($PsCmdlet.ParameterSetName) {
            "FromFile_ParamSet" {
                fromFile $file $format $context $targetDS
            }
        }
    }
    
    end {
        $targetDS.EndUpdateBatch()
        $targetDS
    }
}

function fromFile {
    param (
        [IO.FileInfo]$file,
        [string]$format,
        [Intellidimension.Rdf.RdfUri]$context,
        [Intellidimension.Rdf.DataSource]$ds
    )
    
    Write-Debug "reading $file as $format"
    
    fromStream $file.OpenRead() $format $context $ds
}

function fromStream {
    param (
        [IO.Stream]$stream,
        [string]$format,
        [Intellidimension.Rdf.RdfUri]$context,
        [Intellidimension.Rdf.DataSource]$ds
    )

    $format = $format.ToUpperInvariant()
    $options = New-Object Intellidimension.Rdf.RdfReaderOptions
    $options.Context = $context
    
    $streamReader = New-Object IO.StreamReader $stream
    try {
        $readCount = 0
        switch ($format) {
            "NTRIPLES" {
                $rdfReader = New-Object Intellidimension.Rdf.NTriplesReader @($ds, $options)
             }
            "TURTLE" {
                $rdfReader = New-Object Intellidimension.Rdf.TurtleReader @($ds, $options)
             }
             "RDFXML" {
                $rdfReader = New-Object Intellidimension.Rdf.RdfXmlReader @($ds, $options)
             }
             "QUADS" {
                $rdfReader = New-Object Intellidimension.Rdf.QuadReader @($ds, $options)
             }
        }
	$readCount = $rdfReader.Parse($streamReader)
        Write-Debug "$readCount statements read"
    }
    finally {
        $streamReader.Dispose()
    }
}
