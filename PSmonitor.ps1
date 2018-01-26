#region "var declarations"
$configFile = "PSmonitor_config.json"

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
for ($i = 0; $i -lt $settings.no_tabs; $i++) {
    #add tabs
    $data.tabs += $(new-object psobject)

    #add objects to store SourceUpdateTime for each DataSource
    for ($l = 0; $l -lt @($settings.tabs[$i].sources).count; $l++) {
        $data.tabs[$i] | add-member -membertype noteproperty -name "SourceUpdateTime$l" -value "" -force
    }
}
#add UpdateTimer_onTick
$data | add-member -membertype noteproperty -name UpdateTimer_onTick -value {} -force
#prep icons for UpdateTimer
$imgOK = [System.Drawing.Image]::Fromfile((get-item 'accept-icon.png'));
$imgNO = [System.Drawing.Image]::Fromfile((get-item 'cancel-icon.png'));
$imgsync = [System.Drawing.Image]::Fromfile((get-item 'sync-icon.png'));

#resize scriptblock
$form_resize = {
    $form.SuspendLayout()
    $F_width = $Form.clientsize.Width
    $F_height = $Form.clientsize.height
    $tabcontrol.Size = New-Object System.Drawing.Size($F_width, $F_height)
    $TC_width = $tabcontrol.clientsize.Width
    $TC_height = $tabcontrol.clientsize.height

    for ($i = 0; $i -lt $settings.no_tabs; $i++) {
        $data.tabs[$i].tabpage.size = New-Object System.Drawing.Size($TC_width, $TC_height)
    }

    $Tab_width = $data.tabs[0].tabpage.clientsize.Width
    $Tab_height = $data.tabs[0].tabpage.clientsize.height

    for ($i = 0; $i -lt $settings.no_tabs; $i++) {
        for ($l = 0; $l -lt @($settings.tabs[$i].sources).Count; $l++) {
            $width = ($settings.tabs[$i].sources[$l].bx - $settings.tabs[$i].sources[$l].ax) * $Tab_width
            $height = ($settings.tabs[$i].sources[$l].by - $settings.tabs[$i].sources[$l].ay) * $Tab_height
            $data.tabs[$i]."group$l".size = New-Object System.Drawing.Size($width, $height)
            $data.tabs[$i]."group$l".Location = New-Object System.Drawing.Point(($settings.tabs[$i].sources[$l].ax * $Tab_width), ($settings.tabs[$i].sources[$l].ay * $Tab_height ))
            
            #what if List source
            if ($settings.tabs[$i].sources[$l].Type -eq "List") {
                $data.tabs[$i]."listBox$l".Size = New-Object System.Drawing.Size(($data.tabs[$i]."group$l".width - 12), ($data.tabs[$i]."group$l".height - 45))
            }
            
            #what if Chart source
            if ($settings.tabs[$i].sources[$l].Type -eq "Chart") {
                $data.tabs[$i]."chart$l".Width = ($data.tabs[$i]."group$l".width - 12) 
                $data.tabs[$i]."chart$L".Height = ($data.tabs[$i]."group$l".height - 45) 
            }
            
            $data.tabs[$i]."timer$($l)_img".Location = New-Object System.Drawing.Point(6, ($data.tabs[$i]."group$l".height - 26))
            $data.tabs[$i]."timer$($l)_label".Location = New-Object System.Drawing.Point(36, ($data.tabs[$i]."group$l".height - 26))
        }
    }
    $form.resumeLayout()
}

#endregion

#region "create UI base"
#main Form
$Form = New-Object Windows.Forms.Form 
$Form.Text = $settings.title 
$Form.Width = 1500
$Form.Height = 800
$Form.add_resize($form_resize)
$Form.add_load($form_resize)
#
$F_width=$Form.clientsize.Width
$F_height=$Form.clientsize.height
#
$font = New-object System.Drawing.Font("Arial", 10)
$font_tabs = New-object System.Drawing.Font("Microsoft Sans Serif", 12., [System.Drawing.FontStyle]::Bold)

#tabControl
$tabcontrol = new-object System.Windows.Forms.tabcontrol
$tabcontrol.Size = New-Object System.Drawing.Size($F_width,$F_height)
$tabcontrol.Location = New-Object System.Drawing.Point(0, 0)
$TabControl.ItemSize = New-Object System.Drawing.Size(350, 35)
$TabControl.Padding = New-object System.Drawing.Point(10, 5)
$TabControl.font = $font_tabs
#
$TC_width=$tabcontrol.clientsize.Width
$TC_height=$tabcontrol.clientsize.height
#
$TabControl.SuspendLayout()
$form.SuspendLayout()

#create TabPages
for ($i = 0; $i -lt $settings.no_tabs; $i++) {
    $data.tabs[$i] | add-member -membertype noteproperty -name Tabpage -value $(New-Object System.Windows.Forms.TabPage)
	
	$data.tabs[$i].tabpage.Location = New-Object System.Drawing.Point(0, 0)
	$data.tabs[$i].tabpage.Name = "TabPage1"
	$data.tabs[$i].tabpage.Padding = New-Object System.Windows.Forms.Padding(3)
	$data.tabs[$i].tabpage.Size = New-Object System.Drawing.Size($TC_width, $TC_height)
	$data.tabs[$i].tabpage.TabIndex = $i
	$data.tabs[$i].tabpage.Text = $settings.tabs[$i].tabname
	$data.tabs[$i].tabpage.UseVisualStyleBackColor = $True
	  
	$data.tabs[$i].tabpage.SuspendLayout()
}
#endregion

#region "create UI modules"
#TODO: Groups
#TODO: Chart and ChartAreas
#TODO: Chart Legends

#TODO: Draw Charts
#TODO: TimerLabels
#TODO: DataSources ListBoxes


#endregion
