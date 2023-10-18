Case of 
	: (FORM Event:C1606.code=On Load:K2:1)
		
		Form:C1466.series:=New collection:C1472()
		
		For each ($country; ds:C1482.Country.all())
			$serie:=New object:C1471()
			$serie.name:=$country.name
			$serie.value:=$country.airports.length  //nbOfConnectedAirports
			Form:C1466.series.push($serie)
		End for each 
		
		Form:C1466.series:=Form:C1466.series.orderBy("value desc")
		$others:=Form:C1466.series.slice(10)
		Form:C1466.series:=Form:C1466.series.slice(0; 10)
		If ($others.length>10)
			Form:C1466.series.push(New object:C1471("name"; "others"; "value"; $others.sum("value")))
		End if 
		
		
End case 