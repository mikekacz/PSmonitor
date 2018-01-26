function makehash{
	Param (
		[Parameter(Position=0,Mandatory=$True,
		HelpMessage="Please specify an object",ValueFromPipeline=$True)]
		[object]$InputObject,
		$xField=$(throw 'Out-Chart:xField is required'),
        $yField=$(throw 'Out-Chart:yField is required')

	)
	Begin
	{
		$hash = @{}
	}
	Process
	{
		foreach ($object in $InputObject)
		{
			$hash.add($object.$xField,$object.$yField)
		}
	}
	End
	{
		return $hash
	}
}

function draw_chart {
	Param(
	[ref]$Chart,
	[ref]$ChartAr,
	$chrt_title = "Chart Title",
	$chrt_xlabel = "Horizontal Label" ,
	$chrt_ylabel = "Vertical Label" ,
	$chrt_Width = 400,
	$chrt_Height = 400,
	$chrt_Left = 30,
	$chrt_Top = 30
	)
	
	# create chart object 
	
	$Chart.value.Width = $chrt_Width 
	$Chart.value.Height = $chrt_Height 
	$Chart.value.Left = $chrt_Left 
	$Chart.value.Top = $chrt_Top

	# create a chartarea to draw on and add to chart 
	$Chart.value.ChartAreas.Add($ChartAr.value)
	
	# add title and axes labels 
	#[void]$Chart.value.Titles.Add($chrt_title) 
	$ChartAr.value.AxisX.Title = $chrt_xlabel 
	$ChartAr.value.AxisX.Interval = 1
	$ChartAr.value.AxisY.Title = $chrt_ylabel

	[void]$Chart.value.Series.Add("Data") 
	[void]$Chart.value.Series["Data"].points.add(1)
	
	# change chart area colour 
	$Chart.value.BackColor = [System.Drawing.Color]::Transparent
}