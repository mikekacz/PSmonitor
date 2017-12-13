function New-CTXchartsconfig
{
    $settings = New-Object psobject
    $no_tabs = [int](Read-host -Prompt "Number of Tabs")
    $settings | Add-Member -Value $no_tabs -Name no_tabs -membertype noteproperty
    $title = [string](Read-host -Prompt "App Title")
    $settings | Add-Member -Value $title -Name title -membertype noteproperty
    $settings | Add-Member -Value $null -Name tabs -membertype noteproperty
    $settings.tabs = @()
    for ($i = 0; $i -lt $no_tabs; $i++)
    { 
        Write-host "Tab $i"
        $tabname = [string](Read-host -Prompt "Tab Name")
        $settings.tabs += New-Object psobject
        $settings.tabs[$i] | Add-Member -Value $tabname -Name tabname -membertype noteproperty
        $settings.tabs[$i] | Add-Member -Value $null -Name sources -membertype noteproperty
        $settings.tabs[$i].sources = @()
        $no_workers = [int](Read-host -Prompt "Number of Sources")
        for ($l = 0; $l -lt $no_workers; $l++)
        { 
            Write-host "Tab $i, Source: $l"
            $settings.tabs[$i].sources += New-Object psobject
            $SourceName = [string](Read-host -Prompt "Source Name")
            $path = [string](Read-host -Prompt "Path to XML file")
            if (!(Test-Path $path)) {Write-warning "Path: $path unrecognized"}
            $settings.tabs[$i].sources[$l] | Add-Member -Value $SourceName -Name SourceName -membertype noteproperty
            $settings.tabs[$i].sources[$l] | Add-Member -Value $path -Name path -membertype noteproperty

            #screen settings
            $AX = [float](Read-host -Prompt "Position A value X (0 .. 1)")
            $AY = [float](Read-host -Prompt "Position A value Y (0 .. 1)")
            $BX = [float](Read-host -Prompt "Position B value X (0 .. 1)")
            $BY = [float](Read-host -Prompt "Position B value Y (0 .. 1)")
            $Type = [string](Read-host -Prompt "Source Type (only List and Chart accepted)")

            $settings.tabs[$i].sources[$l] | Add-Member -Value $AX -Name AX -membertype noteproperty
            $settings.tabs[$i].sources[$l] | Add-Member -Value $AY -Name AY -membertype noteproperty
            $settings.tabs[$i].sources[$l] | Add-Member -Value $BX -Name BX -membertype noteproperty
            $settings.tabs[$i].sources[$l] | Add-Member -Value $BY -Name BY -membertype noteproperty
            $settings.tabs[$i].sources[$l] | Add-Member -Value $Type -Name Type -membertype noteproperty

            if ($type -eq "Chart")
            {
                $chrt_xlabel = [string](Read-host -Prompt "chrt_xlabel")
                $chrt_ylabel = [string](Read-host -Prompt "chrt_ylabel")
                $maxValue = [float](Read-host -Prompt "maxValue (0 for automatic)")
            }

            $settings.tabs[$i].sources[$l] | Add-Member -Value $chrt_xlabel -Name chrt_xlabel -membertype noteproperty
            $settings.tabs[$i].sources[$l] | Add-Member -Value $chrt_ylabel -Name chrt_ylabel -membertype noteproperty
            $settings.tabs[$i].sources[$l] | Add-Member -Value $maxValue -Name maxValue -membertype noteproperty
        }


    }

    Show-CTXchartsconfig $settings

    return $settings
}


function Show-CTXchartsconfig
{
    Param
    (
        # Param1 help description
        [Parameter(Position=0)]
        $Config
    )

        foreach ($tb in $Config.tabs){
        $tb.tabname
        $tb.sources |Select-Object SourceName, path, AX, AY, BX, BY, Type, chrt_xlabel, chrt_ylabel, maxValue  | format-table | Out-Host
    }
}

