//%attributes = {}
//OBJECT Get pointer(Object named; "MySpinner")->:=OBJECT Get pointer(Object named; "MySpinner")->+1
var $airport : cs:C1710.AirportEntity

$airport:=ds:C1482.Airport.query("location = :1"; "charles@").first()

compteur:=0

//$airport.codeIATA:=$airport.codeIATA+"X"

$codeIATA:=$airport.codeIATA+"x"
$airport.codeIATA:=$codeIATA


$airport.codeIATA+="X"
