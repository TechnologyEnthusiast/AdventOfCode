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
	# Toggle $Helper to $true for day 2
	PARAM (
	[CmdletBinding()]
	[ValidateNotNullOrEmpty()]
	[string]$Filepath,

	[boolean]$Helper = $false
	)
	$Input = [System.IO.File]::ReadAllText("$Filepath")
	$Input = $Input.ToCharArray()
	$x1 = $x2 = $y1 = $y2 = 0;
	$count = 1;
	$deliveryCoords = @{}
	$deliveryCoords.Add("$count","$x1,$y1")

	if ($Help -eq $true)
	{
		$count++
		$deliveryCoords.Add("$count","$x2,$y2")
	}

	foreach ($_ in $Input)
	{
		$Count++
		if ($Count % 2 -or $Helper -eq $false)
		{
			if ($_ -eq '^')
			{
				$y1++
			}
			elseif ($_ -eq 'v')
			{
				$y1--
			}
			elseif ($_ -eq '>')
			{
				$x1++
			}
			elseif ($_ -eq '<')
			{
				$x1--
			}
			else
			{
				Write-Output "Directions unclear"
			}
			$deliveryCoords.Add("$Count","$x1,$y1")
		}
		else
		{
			if ($_ -eq '^')
			{
				$y2++
			}
			elseif ($_ -eq 'v')
			{
				$y2--
			}
			elseif ($_ -eq '>')
			{
				$x2++
			}
			elseif ($_ -eq '<')
			{
				$x2--
			}
			else
			{
				Write-Output "Directions unclear"
			}
			$deliveryCoords.Add("$Count","$x2,$y2")
		}
	}
	Write-Output "The total number of unique houses visited was" ($deliveryCoords.Values | Sort-Object -Unique).Count
}
Day3 -Filepath 'D:\Temp\AdventOfCode\Day3\input.txt' -Helper $true
