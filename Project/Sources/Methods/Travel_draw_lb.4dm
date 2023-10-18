//%attributes = {}


C_COLLECTION:C1488($1; \
$0; $result_flights)

C_DATE:C307($2; $departureDate)

$flights_of_allLines:=$1
$departureDate:=$2

$result_flights:=New collection:C1472

$i:=1
For each ($flights_of_oneLine; $flights_of_allLines)
	
	$flight_to_separate:=New object:C1471
	$flight_to_separate.id:=$i
	$flight_to_separate.down:=True:C214
	$flight_to_separate.pict:=Storage:C1525.down.pict
	$flight_to_separate.price:="#Prix"
	
	$result_flights.push($flight_to_separate)
	
	For each ($flight; $flights_of_oneLine)
		$flight_to_add:=New object:C1471
		$flight_to_add.id:=$i
		$flight_to_add.down:=True:C214
		
		$line:=ds:C1482.Line.get($flight.UUID_Line)
		$airport_from:=$line.fromAirport
		$flight_to_add.from:=$airport_from.IATA_airportCode+" : "+$airport_from.city+" ("+$airport_from.country.name+")"
		
		$airport_to:=$line.toAirport
		$flight_to_add.to:=$airport_to.IATA_airportCode+" : "+$airport_to.city+" ("+$airport_to.country.name+")"
		
		
		$flight_to_add.from_time:=Time string:C180($flight.takeOffTime)
		$diff_date:=$flight.date_proposed-$departureDate
		If ($diff_date>0)
			$flight_to_add.from_time:=$flight_to_add.from_time+" (J+"+String:C10($diff_date)+")"
		End if 
		
		$flight_to_add.to_time:=Time string:C180($flight.landingTime)
		If ($flight.takeOffTime>$flight.landingTime)
			$diff_date:=$diff_date+1
		End if 
		
		If ($diff_date>0)
			$flight_to_add.to_time:=$flight_to_add.to_time+" (J+"+String:C10($diff_date)+")"
		End if 
		
		$flight_to_add.icon:=ds:C1482.Airline.get($flight.UUID_Airline).tinyLogo
		
		$result_flights.push($flight_to_add)
	End for each 
	
	$i:=$i+1
End for each 
$0:=$result_flights
