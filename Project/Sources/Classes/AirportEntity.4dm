Class extends Entity


//MARK:- codeIATA
Function get codeIATA()->$code : Text
	$code:=This:C1470.codes.IATA
	
Function set codeIATA($value : Text; $event : Object)
	This:C1470.codes.IATA:=$value
	
Function query codeIATA($event : Object)->$result : Object
	$operator:=$event.operator
	$codeToSearch:=$event.value
	
	$query:="codes.IATA "+$operator+" :1"
	$parameters:=New collection:C1472($codeToSearch)
	
	$result:=New object:C1471("query"; $query; "parameters"; $parameters)
	
Function orderBy codeIATA($event : Object)->$result : Text
	$result:="codes.IATA"+((Bool:C1537($event.descending)) ? " desc" : "")
	
	
	
	//MARK:- codeICAO
Function get codeICAO()->$code : Text
	$code:=This:C1470.codes.CAA
	
Function set codeICAO($value : Text; $event : Object)
	This:C1470.codes.CAA:=$value
	
Function query codeICAO($event : Object)->$result : Object
	$operator:=$event.operator
	$codeToSearch:=$event.value
	
	$query:="codes.CAA "+$operator+" :1"
	$parameters:=New collection:C1472($codeToSearch)
	
	$result:=New object:C1471("query"; $query; "parameters"; $parameters)
	
Function orderBy codeICAO($event : Object)->$result : Text
	$result:="codes.CAA"+((Bool:C1537($event.descending)) ? " desc" : "")
	
	
	
	//MARK:- codeCAA
Function get codeCAA()->$code : Text
	$code:=This:C1470.codes.CAA
	
Function set codeCAA($value : Text; $event : Object)
	This:C1470.codes.CAA:=$value
	
Function query codeCAA($event : Object)->$result : Object
	$operator:=$event.operator
	$codeToSearch:=$event.value
	
	$query:="codes.CAA "+$operator+" :1"
	$parameters:=New collection:C1472($codeToSearch)
	
	$result:=New object:C1471("query"; $query; "parameters"; $parameters)
	
Function orderBy codeCAA($event : Object)->$result : Text
	$result:="codes.CAA"+((Bool:C1537($event.descending)) ? " desc" : "")
	
	
	//MARK:- Movement
	
Function get maxMovement()->$maxMovement : Integer
	
	$maxMovement:=1+(This:C1470.level#0 ? 3-This:C1470.level : 0)
	$maxMovement+=This:C1470.intlHub=True:C214 ? 1 : 0
	
Function get nbMovement()->$nbMovement : Integer
	
	$nbMovement:=This:C1470.departureLines.sum("rotationPerDay")+This:C1470.arrivalLines.sum("rotationPerDay")
	
	
	//MARK:-Counts
	
Function get nbOfDestinationAirports()->$nbOfDestinationAirports : Integer
	
	$nbOfDestinationAirports:=This:C1470.departureLines.distinct("UUID_Airport_To").length
	
	
Function get nbOfOrigineAirports()->$nbOfOrigineAirports : Integer
	
	$nbOfOrigineAirports:=This:C1470.arrivalLines.distinct("UUID_Airport_From").length
	
	
Function get nbOfConnectedAirports()->$nbOfConnectedAirports : Integer
	
	$destinationAirports:=This:C1470.departureLines.distinct("UUID_Airport_To")
	$origineAirports:=This:C1470.arrivalLines.distinct("UUID_Airport_From")
	$nbOfConnectedAirports:=$destinationAirports.combine($origineAirports).distinct().length
	
Function get nbFlights()->$nbFlights : Integer
	
	$departureFlights:=This:C1470.departureLines.slots.flights.length
	$arrivalFlights:=This:C1470.arrivalLines.slots.flights.length
	$nbFlights:=$departureFlights+$arrivalFlights
	
	
	//MARK:-Geometry
	
local Function get latitude()->$latitude : Text
	
	If (This:C1470.geometry#Null:C1517) && (This:C1470.geometry.latitude#Null:C1517)
		$latitude:=tool_mathRealToDegrees(Abs:C99(Num:C11(This:C1470.geometry.latitude)))+" "+String:C10(This:C1470.geometry.latitude; "N;S;N")
	Else 
		$latitude:="-"
	End if 
	
	
local Function get longitude()->$longitude : Text
	
	If (This:C1470.geometry#Null:C1517) && (This:C1470.geometry.longitude#Null:C1517)
		$longitude:=tool_mathRealToDegrees(Abs:C99(Num:C11(This:C1470.geometry.longitude)))+" "+String:C10(This:C1470.geometry.longitude; "E;W;E")
	Else 
		$longitude:="-"
	End if 
	
	