#region "var declarations"
$configFile =  "PSmonitor_config.json"

#endregion

#region "main prep"
#load the appropriate assemblies 
[void][Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") 
[void][Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms.DataVisualization")
#load modules
import-module .\PSmonitor_config.ps1
import-module .\PSmonitor_module.ps1

#import settings
$settings = import-PSmonitorConfig $configFile -type JSON #TODO: check data Validiti
#create data structure
$global:data = new-object psobject
$data | add-member -membertype noteproperty -name tabs -value $(New-Object -TypeName System.Collections.ArrayList)
#add tabs
for ($i = 0; $i -lt $settings.no_tabs; $i++) {
    $data.tabs +=$(new-object psobject)
}

#endregion

#region "create UI base"

#endregion

#region "create UI modules"

#endregion
