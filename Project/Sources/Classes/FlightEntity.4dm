Class extends Entity

Alias fromAirport slot.line.fromAirport

Alias toAirport slot.line.toAirport

Function get takeOffTime()->$time : Time
	
	//$time:=Time(This.slot.takeOffTime)
	//If (This.delayDeparture#Null)
	//$time+=Time(This.delayDeparture)
	//End if 
	$time:=stmp_read_time(This:C1470.realDepartureStmp)
	
Function get landingTime()->$time : Time
	
	//$time:=Time(This.slot.landingTime)
	//If (This.delayLanding#Null)
	//$time+=Time(This.delayLanding)
	//End if 
	$time:=stmp_read_time(This:C1470.realArrivalStmp)
	