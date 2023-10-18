C_OBJECT($1; $airport; \
$0; $hubOfairport)

$airport:=$1
$hubOfairport:=New object

$airports:=ds.Airport.query("(level = 1 or intlHub = :1) and groupOfAirport = :2"; True; $airport.group_id)

If ($airports.length#0)
	
	$hubOfairport:=$airport
Else 
	
	$airports_of_group:=ds.Airport.query("groupOfAirport = :1"; $airport.group_id)
	If ($airports_of_group.length#0)
		
		$HubOrCapitals:=ds.Airport.query("(level = 1 or intlHub = :1) and country.name = :2"; True; $airports_of_group[0].country.name)
		
		$airports_group_uuid:=$airports_of_group.toCollection("UUID")
		
		$PossibleDestinations_groups:=$airports_of_group.arrivalLines.fromAirport.distinct("groupOfAirport")
		$PossibleDestinations:=ds.Airport.query("groupOfAirport in :1"; $PossibleDestinations_groups)
		
		$airports:=$HubOrCapitals.and($PossibleDestinations)
		
		If ($airports.length=0)
			$airports:=$PossibleDestinations.query("level = 1")
		End if 
		
		$x:=$airports_of_group.first().longitude
		$y:=$airports_of_group.first().latitude
		
		$firstAirport:=$airports.first()
		$distance:=4D_CalculateDistanceOnSphere($x; $y; $firstAirport.longitude; $firstAirport.latitude)
		$hubOfairport.group_id:=$firstAirport.groupOfAirport
		
		If ($airports.length>1)
			
			For ($i; 1; $airports.length-1; 1)
				
				$distance_calculated:=4D_CalculateDistanceOnSphere($x; $y; $airports[$i].longitude; $airports[$i].latitude)
				
				If ($distance_calculated<$distance)
					$distance:=$distance_calculated
					$hubOfairport.group_id:=$airports[$i].groupOfAirport
				End if 
			End for 
		End if 
		
	End if 
End if 

$0:=$hubOfairport


