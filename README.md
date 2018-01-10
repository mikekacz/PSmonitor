# PSmonitor

PSmonitor is GUI interface for powershell .xml datasources

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Prerequisites

What things you need to install the software and how to install them

* Microsoft Chart Controls for Microsoft .NET [System.Windows.Forms.DataVisualization] (required for generation of Charts), available at [MS Download Center](https://www.microsoft.com/en-us/download/details.aspx?id=14422)

### File list

* PSmonitor.ps1 - script that loads PS GUI

* PSmonitor_config.ps1 - module used for creation and displaying .xml config files

* PSmonitor_config.xml - sample .xml config file, should not be edited manually, unless small chages, like changing names of fileds or tweaking extend vaules.

* Workers/*.ps1 - sample worker scripts that output data

* XMLs/*.xml - sample .xml files containing data to display

### Structure

#### PSmonitor.ps1

#### PSmonitor_config.ps1

Module that allows creating XML config file.

Implements two functions:

* **New-PSmonitorConfig**
Creates from user input new config.

##### Description on used attributes:

* **AX,AY,BX,BY** - fractional coordinates of Top-Left (AX,AY) and Bottom-Right (BX,BY) extends of Controls within Main Window, where (0,0) equals Top-Left corner of Main Window and (1,1) equals Bottom-Right corner of Main Window.

* **Type** - Types of the Controls used. Currently available: List, Chart (TODO: HTML, image)

* **maxValue** - max value in charts, used for scaling. If 0 then 'automatic' scaling applies.


* **View-PSmonitorConfig**
Displays config

##### Usage

Sample

```
PS > $config = New-PSmonitorConfig
Number of Tabs: 2
App Title: PSmonitor
Tab 0
Tab Name: Services
Number of Sources: 1
Tab 0, Source: 0
Source Name: Win7
Path to XML file: <pathtofile>.xml
...
PS > $config | export-CliXML <nameOfTheConfig>.xml
```

```
PS > $config = import-CliXML PSmonitor_config.xml
PS > Show-PSmonitorConfig $conf
XenApp

SourceName              path                        AX  AY  BX  BY Type  chrt_xlabel chrt_ylabel maxValue
----------              ----                        --  --  --  -- ----  ----------- ----------- --------
Servers - Heavy Load    \xmls\CTX_monitor_1_v2.xml    0   0 0,6 0,2 List
Servers - Capacity      \xmls\CTX_monitor_2_v2.xml  0,6   0   1 0,2 Chart Service     Load        1
Servers - Services      \xmls\CTX_monitor_3_v2.xml    0 0,2 0,6 0,6 List
Servers with 7011 error \xmls\CTX_monitor_7_v2.xml    0 0,6 0,3   1 List
Possible Logon issues   \xmls\CTX_monitor_8_v2.xml  0,3 0,6 0,6   1 List
Servers - Max metrics   \xmls\CTX_monitor_5_v2.xml  0,8 0,6   1   1 Chart Metric      MAX         0
Servers - Heavy Load    \xmls\CTX_monitor_6a_v2.xml 0,6 0,6 0,8   1 Chart ServerName  Load        10000
Servers - Logonmode     \xmls\CTX_monitor_6b_v2.xml 0,6 0,2 0,8 0,6 Chart Name        Count       0
Sessions - state        \xmls\CTX_monitor_6c_v2.xml 0,8 0,2   1 0,6 Chart Name        Count       0

```

### Installing

A step by step series of examples that tell you have to get a development env running

Say what the step will be

```
TODO:Give the example
```

## Development

TODO: switch from XML to JSON

## Deployment

TODO: Add additional notes about how to deploy this on a live system

## Authors

* **Michal Kaczmarek** - *Initial work* - [GITHUB](https://github.com/mikekacz)

See also the list of [contributors](https://github.com/mikekacz/PSmonitor/contributors) who participated in this project.

## License

This project is licensed under the GNU GPLv3 License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments



