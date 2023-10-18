//MARK:-Set the options


If (Bool:C1537(Form:C1466.search.trace))
	TRACE:C157
End if 

If (Bool:C1537(Form:C1466.search.logs))
	Use (Storage:C1525.logs)
		Storage:C1525.logs.sequentialNumber+=1
	End use 
	SET DATABASE PARAMETER:C642(4D Server log recording:K37:28; Num:C11(Storage:C1525.logs.sequentialNumber))
End if 



//MARK:-Init the necessary elements
$queryParts:=New collection:C1472
$querySettings:=New object:C1471
$querySettings.parameters:=New object:C1471
$querySettings.attributes:=New object:C1471
$querySettings.queryPlan:=True:C214
$querySettings.queryPath:=True:C214


//MARK:-Searches for airport fields

If (String:C10(Form:C1466.search.city)#"")
	$queryParts.push("city = :city")
	$querySettings.parameters.city:=Form:C1466.search.city
End if 
If (String:C10(Form:C1466.search.localtion)#"")
	$queryParts.push("location = :location")
	$querySettings.parameters.location:=Form:C1466.search.location
End if 
If (String:C10(Form:C1466.search.IATAcode)#"")
	$queryParts.push("IATAcode = :IATAcode")
	$querySettings.parameters.IATAcode:=Form:C1466.search.IATAcode
End if 
If (String:C10(Form:C1466.search.ICAOcode)#"")
	$queryParts.push("ICAOcode = :ICAOcode")
	$querySettings.parameters.ICAOcode:=Form:C1466.search.ICAOcode
End if 
If (Num:C11(Form:C1466.search.level)#0)
	$queryParts.push("level = :level")
	$querySettings.parameters.level:=Form:C1466.search.level
End if 
If (Bool:C1537(Form:C1466.search.airportIntl))
	$queryParts.push("international = :international")
	$querySettings.parameters.international:=Form:C1466.search.airportIntl
End if 
If (Bool:C1537(Form:C1466.search.airportIntlHub))
	$queryParts.push("intlHub = :intlHub")
	$querySettings.parameters.intlHub:=Form:C1466.search.airportIntlHub
End if 
If (Bool:C1537(Form:C1466.search.airportDomestic))
	$queryParts.push("domestic = :domestic")
	$querySettings.parameters.domestic:=Form:C1466.search.airportDomestic
End if 
If (String:C10(Form:C1466.search.countryCode)#"")
	$queryParts.push("country.codes.iso2 = :countryCode")
	$querySettings.parameters.countryCode:=Form:C1466.search.countryCode
End if 



//MARK:-Searches for Airlines

If (String:C10(Form:C1466.search.airline.name)#"")
	$queryParts.push("(departureLines.slots.airline.name = :airlineName or arrivalLines.slots.airline.name = :airlineName)")
	$querySettings.parameters.airlineName:=Form:C1466.search.airline.name
End if 
If (String:C10(Form:C1466.search.airline.countryCode)#"")
	$queryParts.push("(departureLines.slots.airline.country.codes.iso2 = :airlineCountryCode or arrivalLines.slots.airline.country.codes.iso2 = :airlineCountryCode)")
	$querySettings.parameters.airlineCountryCode:=Form:C1466.search.airline.countryCode
End if 
If (String:C10(Form:C1466.search.airline.IATAcode)#"")
	$queryParts.push("(departureLines.slots.airline.designator = :airlineIATA or arrivalLines.slots.airline.designator = :airlineIATA)")
	$querySettings.parameters.airlineIATA:=Form:C1466.search.airline.IATAcode
End if 



//MARK:-Searches for Aircraft
If (String:C10(Form:C1466.search.aircraft.name)#"")
	$queryParts.push("(departureLines.slots.aircraft.name = :aircraftName or arrivalLines.slots.aircraft.name = :aircraftName)")
	$querySettings.parameters.aircraftName:=Form:C1466.search.aircraft.name
End if 



//MARK:-Searches for departures

If (String:C10(Form:C1466.search.flightsFrom.city)#"")
	$queryParts.push("arrivalLines.fromAirport.city = :departureCity")
	$querySettings.parameters.departureCity:=Form:C1466.search.flightsFrom.city
End if 
If (String:C10(Form:C1466.search.flightsFrom.location)#"")
	$queryParts.push("arrivalLines.fromAirport.location = :departureLocation")
	$querySettings.parameters.departureLocation:=Form:C1466.search.flightsFrom.location
End if 
If (String:C10(Form:C1466.search.flightsFrom.countryCode)#"")
	$queryParts.push("arrivalLines.fromAirport.country.codes.iso2 = :departureCountryCode")
	$querySettings.parameters.departureCountryCode:=Form:C1466.search.flightsFrom.countryCode
End if 


//MARK:-Searches for destinations

If (String:C10(Form:C1466.search.flightsTo.city)#"")
	$queryParts.push("departureLines.toAirport.city = :arrivalCity")
	$querySettings.parameters.arrivalCity:=Form:C1466.search.flightsTo.city
End if 
If (String:C10(Form:C1466.search.flightsTo.location)#"")
	$queryParts.push("departureLines.toAirport.location = :arrivalLocation")
	$querySettings.parameters.arrivalLocation:=Form:C1466.search.flightsTo.location
End if 
If (String:C10(Form:C1466.search.flightsTo.countryCode)#"")
	$queryParts.push("departureLines.toAirport.country.codes.iso2 = :arrivalCountryCode")
	$querySettings.parameters.arrivalCountryCode:=Form:C1466.search.flightsTo.countryCode
End if 



//MARK:-Do the query
If ($queryParts.length>0)
	If (Form:C1466.search.conjonction.index=0)
		$queryString:=$queryParts.join(" and ")
	Else 
		$queryString:=$queryParts.join(" or ")
	End if 
	If (Form:C1466.search.orderByAttribute.index>0)
		$queryString+=" order by("+Form:C1466.search.orderByAttribute.valuesAttributes[Form:C1466.search.orderByAttribute.index]+")"
	End if 
	$airports:=ds:C1482.Airport.query($queryString; $querySettings)
Else 
	If (Form:C1466.search.orderByAttribute.index#-1)
		$airports:=ds:C1482.Airport.all().orderBy(Form:C1466.search.orderByAttribute.valuesAttributes[Form:C1466.search.orderByAttribute.index])
	Else 
		$airports:=ds:C1482.Airport.all()
	End if 
End if 



//MARK:-Apply the result

Form:C1466.lb_items:=$airports
ACCEPT:C269

//MARK:-call logsDisplayer

If (Bool:C1537(Form:C1466.search.logs))
	SET DATABASE PARAMETER:C642(4D Server log recording:K37:28; 0)
	$p:=New process:C317("logsDisplayer"; 0; "$logsDisplayer"; *)
	CALL FORM:C1391(Storage:C1525.logsDisplayer.window; "logsDisplayer_update"; JSON Stringify:C1217($airports.queryPlan; *); JSON Stringify:C1217($airports.queryPath; *))
End if 
