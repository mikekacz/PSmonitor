$root = "\" #path to script (has to contain XMLs folder)

$path = "$root\XMLs"
$file = "PSmonitor_XML_sample.xml" 

$output = @() #variable to containg data

#region "gathering data - sample" 
$computerlist = @("localhost", "10.12.10.10")
$servicelist = "*"
foreach ($computer in $computerlist)
{
    try {
        $services = @(get-service -computername $computer -Name $servicelist -ea Stop | Select-Object MachineName,Status,Name,DisplayName )
    }
    catch {
        $services = @(new-object -TypeName PSobject -property @{MachineName = $computer; status = "Error getting Service data"})
    }
    finally {
        $output += $services
    }
}
#endregion "gathering data - sample"

#region "coloring data"
<#
supported colors:
N - neutral, no color
R - red
A - amber
G - green
TODO: add support for other colors
#>

foreach ($line in $output)
{
    #machineName
    $line.MachineName = @($line.MachineName,"N")
    #status
    switch ($line.status)
    {
        "Error getting Service data" {$line.status = @($line.status,"R")}
        "Running" {$line.status = @($line.status,"N")}
        "Stopped" {$line.status = @($line.status,"R")}
        Default {$line.status = @($line.status,"A")}
    }

}

#endregion "coloring data"


#saving data
@($output) | Export-Clixml $(Join-Path $path $file)
return $true