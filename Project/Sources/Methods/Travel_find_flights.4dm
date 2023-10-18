//%attributes = {}

C_COLLECTION:C1488($1; $_segments)

C_COLLECTION:C1488($0; $flights_proposed)

C_DATE:C307($2; $departure_date)
C_TIME:C306($3; $departure_time)

$_segments:=$1
$departure_date:=$2
$departure_time:=$3

$flights_proposed:=New collection:C1472()

$departure_time_emp:=$departure_time


$flight_date:=$departure_date
$conitnue:=True:C214
For each ($segment; $_segments) While ($conitnue)
	
	$dayOfweek:=Day number:C114($flight_date)
	
	$lines:=ds:C1482.Line.query("fromAirport.groupOfAirport = :1 and toAirport.groupOfAirport = :2"; $segment.from.group_id; $segment.to.group_id)
	If ($lines.length#0)
		
		$flights:=$lines.slots
		
		$nbr_try:=0
		Repeat 
			
			$flights_at_day:=$flights.query("daysOfWeek."+String:C10($dayOfweek)+" = :1 order by takeOffTime asc"; True:C214)
			
			If ($departure_time_emp#0)
				$flights_at_day:=$flights_at_day.query("takeOffTime >= :1 order by takeOffTime asc"; $departure_time_emp)
			End if 
			
			If ($flights_at_day.length=0)
				
				$departure_time_emp:=?00:00:00?
				
				$dayOfweek:=$dayOfweek+1
				If ($dayOfweek>7)  //sunday
					$dayOfweek:=1  //monday            
				End if 
				
				$flight_date:=$flight_date+1
			End if 
			$nbr_try:=$nbr_try+1
		Until ($flights_at_day.length#0) & ($nbr_try<10)
		
		If ($flights_at_day.length#0)
			$flight:=$flights_at_day.first()
			$flight:=$flight.toObject()
			$flight.date_proposed:=$flight_date
			
			If ($flight.landingTime<$flight.takeOffTime)
				
				$dayOfweek:=$dayOfweek+1
				If ($dayOfweek>7)  //sunday
					$dayOfweek:=1  //monday            
				End if 
				
				$flight_date:=$flight_date+1
			End if 
			
			$flights_proposed.push($flight)
			
			
			$departure_time_emp:=$flight.landingTime+?00:30:00?
		Else 
			$conitnue:=False:C215
		End if 
	End if 
	
End for each 

$0:=$flights_proposed