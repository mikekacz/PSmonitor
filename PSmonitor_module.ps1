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