C_COLLECTION:C1488($flights; $flight_lb)

$start:=Milliseconds:C459

$ptr_city_departure:=OBJECT Get pointer:C1124(Object named:K67:5; "city_departure")
$ptr_city_arrival:=OBJECT Get pointer:C1124(Object named:K67:5; "city_arrival")

If (Form:C1466.departure#Null:C1517) & (Form:C1466.arrival#Null:C1517)
	
	$_segments:=Travel_find_segment(Form:C1466.departure; Form:C1466.arrival)
	$flights:=QPF_FindFlightsForLines_ORDA($_segments; Date:C102(Form:C1466.date_departure); Time:C179(Form:C1466.time_departure)+0)
	
	$flight_lb:=Travel_draw_lb($flights; Date:C102(Form:C1466.date_departure))
	
	$nbr_lines:=$flight_lb.count("pict")
	
	Form:C1466.flights:=$flight_lb
	
	Form:C1466.duration:=String:C10($nbr_lines)+" / "+String:C10(Milliseconds:C459-$start)+" ms"
	
End if 

