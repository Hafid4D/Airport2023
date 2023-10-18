Class extends Entity


Function get nbOfFlights()->$nb : Integer
	
	$nb:=This:C1470.slots.flights.length
	
Function get rotationPerDay() : Integer
	$rotation:=1
	
	$rotation+=This:C1470.fromAirport.intlHub=True:C214 ? 1 : 0
	$rotation+=This:C1470.toAirport.intlHub=True:C214 ? 1 : 0
	
	$rotation+=This:C1470.fromAirport.UUID_Country=This:C1470.toAirport.UUID_Country ? 1 : 0
	
	$rotation+=This:C1470.fromAirport.level=1 ? 1 : (This:C1470.toAirport.level=1 ? 1 : 0)
	
	return $rotation
	
Function get speed() : Integer
	return This:C1470.distance<1000 ? 950 : (This:C1470.distance<3000 ? 975 : 1050)
	
Function get flightDuration() : Time
	return Time:C179((This:C1470.distance/This:C1470.speed*3600)-((This:C1470.distance/This:C1470.speed*3600)%60))
	