//%attributes = {}
$airlines:=New object:C1471

$numberColl:=New collection:C1472

For ($x; 1; 9999; 1)
	$numberColl.push($x)
End for 

For each ($airline; ds:C1482.Airline.all())
	$obj:=New object:C1471
	$obj.codeIATA:=$airline.designator
	$obj.UUID:=$airline.UUID
	$obj.flightNumber:=$numberColl.copy()
	$obj.done:=0
	$airlines[$airline.designator]:=$obj
End for each 

$nbFlight:=0
For each ($flight; ds:C1482.Flight.all())
	$random:=Random:C100%(9999-$airlines[$flight.airline.designator].done)
	$nb:=$airlines[$flight.airline.designator].flightNumber[$random]
	
	$index:=$airlines[$flight.airline.designator].flightNumber.indexOf($nb)
	$airlines[$flight.airline.designator].flightNumber.remove($index)
	
	Case of 
		: ($nb<10)
			$nbString:="000"+String:C10($nb)
		: ($nb<100)
			$nbString:="00"+String:C10($nb)
		: ($nb<1000)
			$nbString:="0"+String:C10($nb)
		Else 
			$nbString:=String:C10($nb)
	End case 
	
	$flight.flightNumber:=$flight.airline.designator+"-"+$nbString
	$flight.save()
	$airlines[$flight.airline.designator].done+=1
	
	$nbFlight:=$nbFlight+1
End for each 