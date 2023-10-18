
C_OBJECT($1; $departure; \
$2; $arrival)

C_COLLECTION($0; $_lines_propose_from_to)

C_OBJECT($lines)

$departure:=$1
$arrival:=$2

$_lines_propose_from_to:=New collection()

$lines:=ds.Line.query("fromAirport.groupOfAirport = :1 and toAirport.groupOfAirport = :2"; $departure.group_id; $arrival.group_id)

If ($lines.length#0)  //vol direct
	
	$_lines_propose_from_to.push($departure)
	$_lines_propose_from_to.push($arrival)
	
Else   // pas de vol direct
	
	$_lines_propose_from_to.push($departure)
	
	$hub_of_departure:=QPF_FindNearestHubGroup_ORDA($departure)
	If ($departure.group_id#$hub_of_departure.group_id)
		$_lines_propose_from_to.push($hub_of_departure)
	End if 
	
	$hub_of_arrival:=QPF_FindNearestHubGroup_ORDA($arrival)
	If ($arrival.group_id#$hub_of_arrival.group_id)
		$_lines_propose_from_to.push($hub_of_arrival)
	End if 
	
	
	$lines:=ds.Line.query("fromAirport.groupOfAirport = :1 and toAirport.groupOfAirport = :2"; $hub_of_departure.group_id; $hub_of_arrival.group_id)
	
	If ($lines.length=0)  // pas de vol direct entre les hub
		
		// TBD
		
	End if 
	
	$_lines_propose_from_to.push($arrival)
End if 


$0:=$_lines_propose_from_to