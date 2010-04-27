function loadPrerequisiteAssembly {
    param (
        [string] $name,
        [IO.FileInfo] $file
    )
    
    try { 
        $a = [Reflection.Assembly]::Load($name)
    }
    catch [IO.FileNotFoundException] {
        #try {
            if($a -eq $null) {
                $a = [Reflection.Assembly]::LoadFrom($file.FullName)
            }
        #}
    }
}