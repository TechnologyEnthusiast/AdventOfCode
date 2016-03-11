#
# AdventOfCode.ps1
#

Function Day1
{
	PARAM (
	[CmdletBinding()]
	[ValidateNotNullOrEmpty()]
	[string]$Filepath
	)
	$Input = [System.IO.File]::ReadAllText("$Filepath")
	$Input = $Input.ToCharArray()
	$Floor = $Count = 0;

	foreach ($_ in $Input)
	{
		$Count++
		if ($_ -eq '(')
		{
			$Floor++
		}
		elseif ($_ -eq ')')
		{
			$Floor--
			if ($Floor -eq '-1')
			{
				Write-Output "Entered floor $Floor (the basement) on character position $Count"
			}
		}
	}
	Write-Output "The the floor result is: $Floor"
}
# Day1 -Filepath 'D:\Temp\AdventOfCode\Day1\input.txt'


Function Day2
{
	PARAM (
	[CmdletBinding()]
	[ValidateNotNullOrEmpty()]
	[string]$Filepath
	)
	$Input = Get-Content $Filepath
	[int32]$TotalArea = $SurfaceArea = $largeSide = $mediumSide = $smallSide = $RequiredWrappingPaper = $RequiredRibbon = $RibbonForWrap = $RibbonForBow = 0;
	foreach ($_ in $Input)
	{
		$dimensions = $_.split('x')
		[int32]$l = $dimensions[0]
		[int32]$w = $dimensions[1]
		[int32]$h = $dimensions[2]

		if ($l -le $w)
		{
			$smallSide = $l
			$mediumSide = $w
			$largeSide = $h
			if ($h -le $smallSide)
			{
				$largeSide = $mediumSide	
				$mediumSide = $smallSide
				$smallSide = $h
			}
			elseif ($h -le $mediumSide)
			{
				$largeSide = $mediumSide	
				$mediumSide = $h
			}
			else
			{
				#Write-Output "The sides are $smallSide`, $mediumSide`, and $largeSide in order from little to big."
			}
		}
		else
		{
			$smallSide = $w
			$mediumSide = $l
			$largeSide = $h
			if ($h -le $smallSide)
			{
				$largeSide = $mediumSide
				$mediumSide = $smallSide
				$smallSide = $h
			}
			elseif($h -le $mediumSide)
			{
				$largeSide = $mediumSide
				$mediumSide = $h
			}
			else
			{
				#Write-Output "The sides are $smallSide`, $mediumSide`, and $largeSide in order from little to big."
			}
		}

		$SurfaceArea = ( 2 * $l * $w ) + ( 2 * $w * $h ) + ( 2 * $h * $l )
		$TotalArea = $SurfaceArea + ($smallSide * $mediumSide)
		$RequiredWrappingPaper +=$TotalArea
		$RibbonForWrap = ($smallSide * 2) + ($mediumSide * 2)
		$RibbonForBow = ($l * $w * $h)
		$RequiredRibbon += $RibbonForWrap += $RibbonForBow

		$SurfaceArea = $l = $w = $h = $dimenions = $smallSide = $mediumSide = $largeSide =  $RibbonFoWrap = $RibbonForBow = $null
	}
	
	Write-Output "The total square feet of wrapping paper that should be ordered is $RequiredWrappingPaper along with $RequiredRibbon feet of ribbon."
}

# Day2 -Filepath 'D:\Temp\AdventOfCode\Day2\input.txt'

Function Day3
{
	PARAM (
	[CmdletBinding()]
	[ValidateNotNullOrEmpty()]
	[string]$Filepath
	)
	$Input = [System.IO.File]::ReadAllText("D:\Temp\AdventOfCode\Day3\input.txt")
	$Input = $Input.ToCharArray()
	$x = $y = 0;
	$count = 1;
	$deliveryCoords = @{}
	$deliveryCoords.Add("$Count","$x,$y")
	foreach ($_ in $Input)
	{
		if ($_ -eq '^')
		{
			$y++
		}
		elseif ($_ -eq 'v')
		{
			$y--
		}
		elseif ($_ -eq '>')
		{
			$x++
		}
		elseif ($_ -eq '<')
		{
			$x--
		}
		else
		{
			Write-Output "Directions unclear"
		}
		$Count++
		$deliveryCoords.Add("$Count","$x,$y")
	}
	Write-Output "The total number of unique houses visited was" ($deliveryCoords.Values | Sort-Object -Unique).Count
}
Day3 -Filepath 'D:\Temp\AdventOfCode\Day3\input.txt'
