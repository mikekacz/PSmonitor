# PSmonitor

PSmonitor is GUI interface for powershell .xml datasources

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Prerequisites

What things you need to install the software and how to install them

```
* Microsoft Chart Controls for Microsoft .NET [System.Windows.Forms.DataVisualization] (required for genration of Charts), available at [MS Download Center](https://www.microsoft.com/en-us/download/details.aspx?id=14422)
```

### File list

* PSmonitor.ps1 - script that loads PS GUI

* PSmonitor_config.ps1 - module used for creation and displaying .xml config files

* PSmonitor_comfig.xml - sample .xml config file

### Structure

#### PSmonitor.ps1

#### PSmonitor_config.ps1

Module that allows creating XML config file.

Implements two functions:

* New-PSmonitorConfig - Creates from user input new config
* View-PSmonitorConfig - Displays config

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



### Installing

A step by step series of examples that tell you have to get a development env running

Say what the step will be

```
TODO:Give the example
```

## Deployment

TODO: Add additional notes about how to deploy this on a live system

## Authors

* **Michal Kaczmarek** - *Initial work* - [PurpleBooth](https://github.com/mikekacz)

See also the list of [contributors](https://github.com/mikekacz/PSmonitor/contributors) who participated in this project.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments



