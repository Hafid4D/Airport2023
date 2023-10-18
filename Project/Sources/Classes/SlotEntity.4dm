Class extends Entity


Alias fromAirport line.fromAirport

Alias toAirport line.toAirport

local Function get takeOffTime()->$time : Time
	$time:=stmp_read_time(This:C1470.takeOffStmp)
	
local Function get landingTime()->$time : Time
	$time:=stmp_read_time(This:C1470.landingStmp)
	
local Function get durationTime()->$time : Time
	$time:=stmp_read_time(This:C1470.flightDurationStmp)
	
local Function get daysAsStyledText()->$styledText : Text
	$days:="S;M;T;W;T;F;S"
	$i:=0
	For each ($day; Split string:C1554($days; ";"))
		$i+=1
		$styledText+="<span style=\"color:"
		$styledText+=Bool:C1537(This:C1470.daysOfWeek[String:C10($i)])=True:C214 ? "black" : "lightgrey"
		$styledText+="\">"+$day+" </span>"
	End for each 
	