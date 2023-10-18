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

$setPrefix:=Bool:C1537(Form:C1466.search.useLocalSet) ? "$" : ""

//MARK:-Init the necessary elements
var $airports : cs:C1710.AirportSelection

If (Form:C1466.search.conjonction.index=0)
	$airports:=ds:C1482.Airport.all()
	$conjonction:="and"
Else 
	$airports:=ds:C1482.Airport.newSelection()
	$conjonction:="or"
End if 

//MARK:-Searches for airport fields
If (String:C10(Form:C1466.search.city)#"")
	$airportsTemp:=ds:C1482.Airport.query("city = :1"; Form:C1466.search.city)
	$airports:=$airports[$conjonction]($airportsTemp)
	
End if 

If (String:C10(Form:C1466.search.location)#"")
	$airportsTemp:=ds:C1482.Airport.query("location = :1"; Form:C1466.search.location)
	$airports:=$airports[$conjonction]($airportsTemp)
End if 

If (String:C10(Form:C1466.search.countryCode)#"")
	$airportsTemp:=ds:C1482.Country.query("codes.iso2 = :1"; Form:C1466.search.countryCode).airports
	$airports:=$airports[$conjonction]($airportsTemp)
End if 

If (String:C10(Form:C1466.search.country)#"")
	$airportsTemp:=ds:C1482.Country.query("name = :1"; Form:C1466.search.country).airports
	$airports:=$airports[$conjonction]($airportsTemp)
End if 

If (String:C10(Form:C1466.search.IATAcode)#"")
	$airportsTemp:=ds:C1482.Airport.query("codes.IATA = :1"; Form:C1466.search.IATAcode)
	$airports:=$airports[$conjonction]($airportsTemp)
End if 

If (String:C10(Form:C1466.search.ICAOcode)#"")
	$airportsTemp:=ds:C1482.Airport.query("codes.ICAO = :1"; Form:C1466.search.ICAO)
	$airports:=$airports[$conjonction]($airportsTemp)
End if 

If (Bool:C1537(Form:C1466.search.airportIntl))
	$airportsTemp:=ds:C1482.Airport.query("international = True")
	$airports:=$airports[$conjonction]($airportsTemp)
End if 

If (Bool:C1537(Form:C1466.search.airportIntlHub))
	$airportsTemp:=ds:C1482.Airport.query("intlHub = True")
	$airports:=$airports[$conjonction]($airportsTemp)
End if 

If (Bool:C1537(Form:C1466.search.airportDomestic))
	$airportsTemp:=ds:C1482.Airport.query("domestic = True")
	$airports:=$airports[$conjonction]($airportsTemp)
End if 



//MARK:-Searches for airlines

If (String:C10(Form:C1466.search.airline.name)#"")
	
	$lines:=ds:C1482.Slot.query("airline.name = :1"; Form:C1466.search.airline.name).line
	
	$airportsTemp:=$lines.toAirport.or($lines.fromAirport)
	
	$airports:=$airports[$conjonction]($airportsTemp)
End if 

Case of 
	: (String:C10(Form:C1466.search.airline.countryCode)#"")
		
		$lines:=ds:C1482.Country.query("codes.iso2 = :1"; Form:C1466.search.airline.countryCode).airlines.slots.line
		
		$airportsTemp:=$lines.toAirport.or($lines.fromAirport)
		
		$airports:=$airports[$conjonction]($airportsTemp)
		
	: (String:C10(Form:C1466.search.airline.country)#"")
		$lines:=ds:C1482.Country.query("name = :1"; Form:C1466.search.country).airlines.slots.line
		
		$airportsTemp:=$lines.toAirport.or($lines.fromAirport)
		
		$airports:=$airports[$conjonction]($airportsTemp)
End case 

If (String:C10(Form:C1466.search.airline.IATAcode)#"")
	$lines:=ds:C1482.Slot.query("airline.designator = :1"; Form:C1466.search.airline.IATAcode).line
	
	$airportsTemp:=$lines.toAirport.or($lines.fromAirport)
	
	$airports:=$airports[$conjonction]($airportsTemp)
End if 

If (String:C10(Form:C1466.search.airline.ICAOcode)#"")
	$lines:=ds:C1482.Slot.query("airline.ICAOdesignator = :1"; Form:C1466.search.airline.ICAOcode).line
	
	$airportsTemp:=$lines.toAirport.or($lines.fromAirport)
	
	$airports:=$airports[$conjonction]($airportsTemp)
End if 


//MARK:-Searches for aircraft
If (String:C10(Form:C1466.search.aircraft.name)#"")
	$lines:=ds:C1482.Slot.query("aircraft.name = :1"; Form:C1466.search.aircraft.name).line
	
	$airportsTemp:=$lines.toAirport.or($lines.fromAirport)
	
	$airports:=$airports[$conjonction]($airportsTemp)
End if 

//MARK:-Searches for departures

If (String:C10(Form:C1466.search.flightsFrom.city)#"")
	$lines:=ds:C1482.Airport.query("city = :1"; Form:C1466.search.flightsFrom.city).departureLines
	
	$airports:=$airports[$conjonction]($lines.toAirport)
End if 

If (String:C10(Form:C1466.search.flightsFrom.location)#"")
	$lines:=ds:C1482.Airport.query("location = :1"; Form:C1466.search.flightsFrom.location).departureLines
	
	$airports:=$airports[$conjonction]($lines.toAirport)
End if 

Case of 
	: (String:C10(Form:C1466.search.flightsFrom.countryCode)#"")
		
		$lines:=ds:C1482.Country.query("codes.iso2 = :1"; Form:C1466.search.flightsFrom.countryCode).airports.departureLines
		
		$airports:=$airports[$conjonction]($lines.toAirport)
		
	: (String:C10(Form:C1466.search.flightsFrom.country)#"")
		
		$lines:=ds:C1482.Country.query("name = :1"; Form:C1466.search.flightsFrom.country).airports.departureLines
		
		$airports:=$airports[$conjonction]($lines.toAirport)
		
End case 

// TODO: --Flights from / arrival time 
//If (Time(Form.search.flightsFrom.arrivalTimeFrom)#?00:00:00?)
//End if 
//If (Time(Form.search.flightsFrom.arrivalTimeTo)#?00:00:00?)
//End if 

// TODO: --Flights from Period



//MARK:-Searches for destinations
If (String:C10(Form:C1466.search.flightsTo.city)#"")
	$lines:=ds:C1482.Airport.query("city = :1"; Form:C1466.search.flightsTo.city).arrivalLines
	
	$airports:=$airports[$conjonction]($lines.fromAirport)
	
End if 

If (String:C10(Form:C1466.search.flightsTo.location)#"")
	$lines:=ds:C1482.Airport.query("location = :1"; Form:C1466.search.flightsTo.location).arrivalLines
	
	$airports:=$airports[$conjonction]($lines.fromAirport)
	
End if 

Case of 
	: (String:C10(Form:C1466.search.flightsTo.countryCode)#"")
		$lines:=ds:C1482.Country.query("codes.iso2 = :1"; Form:C1466.search.flightsTo.countryCode).airports.arrivalLines
		
		$airports:=$airports[$conjonction]($lines.fromAirport)
		
	: (String:C10(Form:C1466.search.flightsTo.country)#"")
		$lines:=ds:C1482.Country.query("name = :1"; Form:C1466.search.flightsTo.country).airports.arrivalLines
		
		$airports:=$airports[$conjonction]($lines.fromAirport)
End case 



// TODO: --Flights to / departure time 
//If (Time(Form.search.flightsTo.departureTimeFrom)#?00:00:00?)
//End if 
//If (Time(Form.search.flightsTo.departureTimeTo)#?00:00:00?)
//End if 

// TODO: -- Flights to / Period



If (Bool:C1537(Form:C1466.search.logs))
	SET DATABASE PARAMETER:C642(4D Server log recording:K37:28; 0)
End if 



//MARK:-Apply the result
Form:C1466.lb_items:=$airports
ACCEPT:C269

//MARK:-call logsDisplayer

If (Bool:C1537(Form:C1466.search.logs))
	SET DATABASE PARAMETER:C642(Client log recording:K37:44; 0)
	$p:=New process:C317("logsDisplayer"; 0; "$logsDisplayer"; *)
	CALL FORM:C1391(Storage:C1525.logsDisplayer.window; "logsDisplayer_update")
End if 