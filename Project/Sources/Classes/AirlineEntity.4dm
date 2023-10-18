Class extends Entity



Function get nbOfFlights()->$nb : Integer
	
	$nb:=This:C1470.slots.flights.length
	
	
Function get nbOfAirports()->$nb : Integer
	$collUUID:=This:C1470.slots.line.extract("UUID_Airport_From"; "from"; "UUID_Airport_To"; "to")
	$nb:=$collUUID.extract("from").concat($collUUID.extract("to")).distinct().length