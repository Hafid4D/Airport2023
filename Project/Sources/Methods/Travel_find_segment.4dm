C_OBJECT($1; $departure; \
$2; $arrival)

C_BOOLEAN($3; $recursive)
C_COLLECTION($0; $_segments)

C_OBJECT($lines)

$departure:=$1
$arrival:=$2

If (Count parameters>2)
	$recursive:=$3
Else 
	$recursive:=True
End if 


$number_of_segment:=50

$_segments:=New collection()

$lines:=ds.Line.query("fromAirport.groupOfAirport = :1 and toAirport.groupOfAirport = :2"; $departure.group_id; $arrival.group_id)
If ($lines.length#0)  // vol direct entre le départ et l'arrivé
	
	$_line:=New collection()
	$segment:=New object()
	$segment.from:=$departure
	$segment.to:=$arrival
	$_line.push($segment)
	$_segments.push($_line)
	
Else   // Pas de vol direct => il faut chercher un transit d'abord, sinon des hub.
	
	$airport_dest:=ds.Line.query("fromAirport.groupOfAirport = :1"; $arrival.group_id).toAirport
	$airport_source:=ds.Line.query("toAirport.groupOfAirport = :1"; $departure.group_id).fromAirport
	
	$transits:=ds.Airport.query("((country.name = :1 or country.name = :2) and level = 1) or intlHub = :3"; $airport_dest.first().country.name; $airport_source.first().country.name; True)
	$airport_dest:=$airport_dest.and($transits)
	$airport_source:=$airport_source.and($transits)
	$airports:=$airport_dest.and($airport_source)
	
	If ($airports.length#0)  // c'est possible via transit
		
		If ($airports.length>$number_of_segment)
			$xFrom:=$airport_dest.longitude
			$yFrom:=$airport_dest.latitude
			
			$xTo:=$airport_source.longitude
			$yTo:=$airport_source.latitude
			
			$groups_airport:=New collection()
			
			$i:=1
			For each ($airport; $airports)
				
				$x:=$airport.longitude
				$y:=$airport.latitude
				$distance:=4D_CalculateDistanceOnSphere($xFrom; $yFrom; $x; $y)+4D_CalculateDistanceOnSphere($xTo; $yTo; $x; $y)
				
				If ($i<=$number_of_segment)
					$groups_airport.push($airport.groupOfAirport)
				Else 
					
					$index_max:=$groups_airport.indexOf($groups_airport.max())
					If ($distance<$groups_airport[$index_max])
						$groups_airport[$index_max]:=$airport.groupOfAirport
					End if 
				End if 
				
				$i:=$i+1
			End for each 
			
		Else 
			$groups_airport:=$airports.distinct("groupOfAirport")
		End if 
		
		// Création des ségment
		For each ($group; $groups_airport)
			
			$_line:=New collection()
			$segment:=New object()
			$segment.from:=$departure
			$segment.to:=New object("group_id"; $group)
			$_line.push($segment)
			//$_segments.push($_line)
			
			//$_line:=New collection()
			$segment:=New object()
			$segment.from:=New object("group_id"; $group)
			$segment.to:=$arrival
			$_line.push($segment)
			$_segments.push($_line)
		End for each 
		
	Else   // pas de transit => on passe par des hub maintenant
		
		$hub_departure:=QPF_FindNearestHubGroup_ORDA($departure)
		$hub_arrival:=QPF_FindNearestHubGroup_ORDA($arrival)
		
		If ($recursive)
			$_seg:=Travel_find_segment($hub_departure; $hub_arrival; False)
			
			For each ($seg; $_seg)
				If ($hub_departure.group_id#$departure.group_id)
					$segment:=New object()
					$segment.from:=$departure
					$segment.to:=$hub_departure
					$seg.unshift($segment)
				End if 
				
				If ($hub_arrival.group_id#$arrival.group_id)
					$segment:=New object()
					$segment.from:=$hub_arrival
					$segment.to:=$arrival
					$seg.push($segment)
				End if 
			End for each 
			
			$_segments:=$_seg
		End if 
	End if 
	
	
End if 

$0:=$_segments