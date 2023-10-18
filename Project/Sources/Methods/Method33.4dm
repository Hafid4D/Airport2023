//%attributes = {}
$qs:="(arrivalLines.fromAirport.city = :origneCity2) AND (departureLines.toAirport.city = :destinationCity3) order by city"

$lines1:=ds:C1482.Line.query("fromAirport.city = :1"; "paris")
$lines2:=ds:C1482.Line.query("toAirport.city = :1"; "san francisco")
$lines3:=$lines1.and($lines2)

$lines:=ds:C1482.Line.query("fromAirport.city = :1 and toAirport.city = :2"; "paris"; "San francisco")
$airports:=$lines.fromAirport.or($lines.toAirport)

$qs:="((arrivalLines.fromAirport.city = :1) OR (departureLines.toAirport.city = :2)) AND (city= :1 OR city= :2)"
$airports:=ds:C1482.Airport.query($qs; "london"; "new york")