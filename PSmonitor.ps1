#region "var declarations"
$configFile =  "PSmonitor_config.json"

#endregion

#region "main prep"
#load the appropriate assemblies 
[void][Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") 
[void][Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms.DataVisualization")
#load PSminitor_config.ps1
import-module .\PSmonitor_config.ps1

$settings = import-PSmonitorConfig $configFile -type JSON

#endregion

#region "create UI base"

#endregion

#region "create UI modules"

#endregion
