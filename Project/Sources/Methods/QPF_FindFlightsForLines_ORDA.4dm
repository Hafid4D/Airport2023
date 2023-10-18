

C_COLLECTION($1; $_segments; \
$0; $_all_flights)

C_DATE($2; $date_departure)
C_TIME($3; $time_departure)

$_segments:=$1
$date_departure:=$2
$time_departure:=$3

$_all_flights:=New collection()
For each ($_lines; $_segments)
	
	$flights_of_lines:=New collection()
	$flights_of_lines:=Travel_find_flights($_lines; $date_departure; $time_departure)
	If ($flights_of_lines.length#0)
		$_all_flights.push($flights_of_lines)
	End if 
End for each 

$0:=$_all_flights