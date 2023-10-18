//%attributes = {}
//$es:=ds.Line.all().distinct("UUID_Airport_From"; ck count values)
//$es:=$es.orderBy("count desc"


$series:=New collection:C1472()

For each ($country; ds:C1482.Country.all())
	
	$serie:=New object:C1471()
	
	$serie.name:=$country.name
	$serie.value:=$country.nbOfConnectedAirports
	
	$series.push($serie)
	
End for each 

$series:=$series.orderBy("value desc")
$others:=$series.slice(10)
$series:=$series.slice(0; 10)
If ($others.length>10)
	$series.push(New object:C1471("name"; "others"; "value"; $others.sum("value")))
End if 
