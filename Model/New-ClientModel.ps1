function New-ClientModel {
	[CmdletBinding(DefaultParameterSetName = "New_ParamSet")]
	param (
	)

#	begin {
#	}

	process {
		New-Object Intellidimension.Rdf.ClientModel
	}

#	end {
#	}
}
