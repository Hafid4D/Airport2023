//%attributes = {}
var $airports : Object

$airports:=New object:C1471
$coll:=New collection:C1472

For each ($airport; ds:C1482.Airport.all())
	$obj:=New object:C1471
	$obj.codeIATA:=$airport.codeIATA
	$obj.UUID:=$airport.UUID
	$airports[$airport.codeIATA]:=$obj
	$airports[$airport.UUID]:=$obj
End for each 

For each ($line; ds:C1482.Line.all())
	If ($line.fromAirport#Null:C1517) && ($line.toAirport#Null:C1517)
		$route:=ds:C1482.Routes.query("(Source_airport = :1) && (Destination_airport = :2 )"; $line.fromAirport.codeIATA; $line.toAirport.codeIATA)
		If ($route.length=0)
			$line.drop()
		End if 
	End if 
	
End for each 


For each ($route; ds:C1482.Routes.all())
	$line:=ds:C1482.Line.query("(fromAirport.codeIATA = :1) && (toAirport.codeIATA = :2 )"; $route.Source_airport; $route.Destination_airport)
	
	If ($line.length=0)
		
		$airportFrom:=$airports[$route.Source_airport]
		$airportTo:=$airports[$route.Destination_airport]
		
		If ($airportFrom#Null:C1517) && ($airportTo#Null:C1517)
			
			$newLine:=ds:C1482.Line.new()
			$newLine.UUID_Airport_From:=$airportFrom.UUID
			$newLine.UUID_Airport_To:=$airportTo.UUID
			$newLine.distance:=zzTD_haversineFormula({latitude: $airportFrom.latitude; longitude: $airportFrom.longitude}; {latitude: $airportTo.latitude; longitude: $airportTo.longitude})
			$newLine.save()
		End if 
	End if 
	
End for each 

