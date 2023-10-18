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
$sets:=New collection:C1472()


//MARK:-Searches for airport fields
If (String:C10(Form:C1466.search.city)#"")
	QUERY:C277([Airport:6]; [Airport:6]city:2=Form:C1466.search.city)
	
	$setName:=$setPrefix+"airportCity"
	$sets.push($setName)
	CREATE SET:C116([Airport:6]; $setName)
End if 

If (String:C10(Form:C1466.search.location)#"")
	QUERY:C277([Airport:6]; [Airport:6]location:3=Form:C1466.search.location)
	$setName:=$setPrefix+"airportLocation"
	$sets.push($setName)
	CREATE SET:C116([Airport:6]; $setName)
End if 

If (String:C10(Form:C1466.search.countryCode)#"")
	//QUERY([Airport]; [Country]isoCode_2=Form.search.countryCode)
	QUERY BY ATTRIBUTE:C1331([Airport:6]; [Country:4]codes:10; "iso2"; =; Form:C1466.search.countryCode)
	$setName:=$setPrefix+"airportCountryCode"
	$sets.push($setName)
	CREATE SET:C116([Airport:6]; $setName)
End if 

If (String:C10(Form:C1466.search.country)#"")
	QUERY:C277([Airport:6]; [Country:4]name:2=Form:C1466.search.country)
	$setName:=$setPrefix+"airportCountry"
	$sets.push($setName)
	CREATE SET:C116([Airport:6]; $setName)
End if 

If (String:C10(Form:C1466.search.IATAcode)#"")
	QUERY BY ATTRIBUTE:C1331([Airport:6]; [Airport:6]codes:21; "IATA"; =; Form:C1466.search.IATAcode)
	$setName:=$setPrefix+"airportIATAcode"
	$sets.push($setName)
	CREATE SET:C116([Airport:6]; $setName)
End if 

If (String:C10(Form:C1466.search.ICAOcode)#"")
	QUERY BY ATTRIBUTE:C1331([Airport:6]; [Airport:6]codes:21; "ICAO"; =; Form:C1466.search.ICAOcode)
	$setName:=$setPrefix+"airportICAOcode"
	$sets.push($setName)
	CREATE SET:C116([Airport:6]; $setName)
End if 

If (Bool:C1537(Form:C1466.search.airportIntl))
	QUERY:C277([Airport:6]; [Airport:6]international:14=True:C214)
	$setName:=$setPrefix+"airportIntl"
	$sets.push($setName)
	CREATE SET:C116([Airport:6]; $setName)
End if 

If (Bool:C1537(Form:C1466.search.airportIntlHub))
	QUERY:C277([Airport:6]; [Airport:6]intlHub:20=True:C214)
	$setName:=$setPrefix+"airportIntlHub"
	$sets.push($setName)
	CREATE SET:C116([Airport:6]; $setName)
End if 

If (Bool:C1537(Form:C1466.search.airportDomestic))
	QUERY:C277([Airport:6]; [Airport:6]domestic:15=True:C214)
	$setName:=$setPrefix+"airportDomestic"
	$sets.push($setName)
	CREATE SET:C116([Airport:6]; $setName)
End if 



//MARK:-Searches for airlines

If (String:C10(Form:C1466.search.airline.name)#"")
	QUERY:C277([Slot:1]; [Airline:3]name:2=Form:C1466.search.airline.name)
	RELATE ONE SELECTION:C349([Slot:1]; [Line:5])
	
	DISTINCT VALUES:C339([Line:5]UUID_Airport_From:2; $_uuidAirportFrom)
	DISTINCT VALUES:C339([Line:5]UUID_Airport_To:3; $_uuidAirportTo)
	
	QUERY WITH ARRAY:C644([Airport:6]UUID:1; $_uuidAirportFrom)
	CREATE SET:C116([Airport:6]; $setPrefix+"airportFrom")
	
	QUERY WITH ARRAY:C644([Airport:6]UUID:1; $_uuidAirportTo)
	CREATE SET:C116([Airport:6]; $setPrefix+"airportTo")
	
	$setName:=$setPrefix+"airlineName"
	$sets.push($setName)
	UNION:C120($setPrefix+"airportTo"; $setPrefix+"airportFrom"; $setName)
	
	CLEAR SET:C117($setPrefix+"airportFrom")
	CLEAR SET:C117($setPrefix+"airportTo")
End if 

Case of 
	: (String:C10(Form:C1466.search.airline.countryCode)#"")
		QUERY BY ATTRIBUTE:C1331([Airline:3]; [Country:4]codes:10; "iso2"; =; Form:C1466.search.airline.countryCode)
		RELATE ONE SELECTION:C349([Airline:3]; [Slot:1])
		RELATE ONE SELECTION:C349([Slot:1]; [Line:5])
		
		DISTINCT VALUES:C339([Line:5]UUID_Airport_From:2; $_uuidAirportFrom)
		DISTINCT VALUES:C339([Line:5]UUID_Airport_To:3; $_uuidAirportTo)
		
		QUERY WITH ARRAY:C644([Airport:6]UUID:1; $_uuidAirportFrom)
		CREATE SET:C116([Airport:6]; $setPrefix+"airportFrom")
		
		QUERY WITH ARRAY:C644([Airport:6]UUID:1; $_uuidAirportTo)
		CREATE SET:C116([Airport:6]; $setPrefix+"airportTo")
		
		$setName:=$setPrefix+"airlineCountryCode"
		$sets.push($setName)
		
		UNION:C120($setPrefix+"airportTo"; $setPrefix+"airportFrom"; $setName)
		
		CLEAR SET:C117($setPrefix+"airportFrom")
		CLEAR SET:C117($setPrefix+"airportTo")
		
	: (String:C10(Form:C1466.search.airline.country)#"")
		QUERY:C277([Airline:3]; [Country:4]name:2=Form:C1466.search.airline.country)
		RELATE ONE SELECTION:C349([Airline:3]; [Slot:1])
		RELATE ONE SELECTION:C349([Slot:1]; [Line:5])
		
		DISTINCT VALUES:C339([Line:5]UUID_Airport_From:2; $_uuidAirportFrom)
		DISTINCT VALUES:C339([Line:5]UUID_Airport_To:3; $_uuidAirportTo)
		
		QUERY WITH ARRAY:C644([Airport:6]UUID:1; $_uuidAirportFrom)
		CREATE SET:C116([Airport:6]; $setPrefix+"airportFrom")
		
		QUERY WITH ARRAY:C644([Airport:6]UUID:1; $_uuidAirportTo)
		CREATE SET:C116([Airport:6]; $setPrefix+"airportTo")
		
		$setName:=$setPrefix+"airlineCountry"
		$sets.push($setName)
		
		UNION:C120($setPrefix+"airportTo"; $setPrefix+"airportFrom"; $setName)
		
		CLEAR SET:C117($setPrefix+"airportFrom")
		CLEAR SET:C117($setPrefix+"airportTo")
End case 

If (String:C10(Form:C1466.search.airline.IATAcode)#"")
	//QUERY BY ATTRIBUTE([Flight]; [Airline]codes; "IATA"; =; Form.search.airline.IATAcode)
	QUERY:C277([Slot:1]; [Airline:3]designator:4=Form:C1466.search.airline.IATAcode)
	RELATE ONE SELECTION:C349([Slot:1]; [Line:5])
	
	DISTINCT VALUES:C339([Line:5]UUID_Airport_From:2; $_uuidAirportFrom)
	DISTINCT VALUES:C339([Line:5]UUID_Airport_To:3; $_uuidAirportTo)
	
	QUERY WITH ARRAY:C644([Airport:6]UUID:1; $_uuidAirportFrom)
	CREATE SET:C116([Airport:6]; $setPrefix+"airportFrom")
	
	QUERY WITH ARRAY:C644([Airport:6]UUID:1; $_uuidAirportTo)
	CREATE SET:C116([Airport:6]; $setPrefix+"airportTo")
	
	$setName:=$setPrefix+"airlineIATAcode"
	$sets.push($setName)
	
	UNION:C120($setPrefix+"airportTo"; $setPrefix+"airportFrom"; $setName)
	
	CLEAR SET:C117($setPrefix+"airportFrom")
	CLEAR SET:C117($setPrefix+"airportTo")
End if 

If (String:C10(Form:C1466.search.airline.ICAOcode)#"")
	QUERY:C277([Slot:1]; [Airline:3]ICAOdesignator:6=Form:C1466.search.airline.ICAOode)
	
	RELATE ONE SELECTION:C349([Slot:1]; [Line:5])
	
	DISTINCT VALUES:C339([Line:5]UUID_Airport_From:2; $_uuidAirportFrom)
	DISTINCT VALUES:C339([Line:5]UUID_Airport_To:3; $_uuidAirportTo)
	
	QUERY WITH ARRAY:C644([Airport:6]UUID:1; $_uuidAirportFrom)
	CREATE SET:C116([Airport:6]; $setPrefix+"airportFrom")
	
	QUERY WITH ARRAY:C644([Airport:6]UUID:1; $_uuidAirportTo)
	CREATE SET:C116([Airport:6]; $setPrefix+"airportTo")
	
	$setName:=$setPrefix+"airlineICAOcode"
	$sets.push($setName)
	UNION:C120($setPrefix+"airportTo"; $setPrefix+"airportFrom"; $setName)
	
	CLEAR SET:C117($setPrefix+"airportFrom")
	CLEAR SET:C117($setPrefix+"airportTo")
End if 


//MARK:-Searches for aircraft
If (String:C10(Form:C1466.search.aircraft.name)#"")
	QUERY:C277([Slot:1]; [Aircraft:9]name:1=Form:C1466.search.aircraft.name)
	RELATE ONE SELECTION:C349([Slot:1]; [Line:5])
	
	DISTINCT VALUES:C339([Line:5]UUID_Airport_From:2; $_uuidAirportFrom)
	DISTINCT VALUES:C339([Line:5]UUID_Airport_To:3; $_uuidAirportTo)
	
	QUERY WITH ARRAY:C644([Airport:6]UUID:1; $_uuidAirportFrom)
	CREATE SET:C116([Airport:6]; $setPrefix+"airportFrom")
	
	QUERY WITH ARRAY:C644([Airport:6]UUID:1; $_uuidAirportTo)
	CREATE SET:C116([Airport:6]; $setPrefix+"airportTo")
	
	$setName:=$setPrefix+"aircraftName"
	$sets.push($setName)
	
	UNION:C120($setPrefix+"airportTo"; $setPrefix+"airportFrom"; $setName)
	
	CLEAR SET:C117($setPrefix+"airportFrom")
	CLEAR SET:C117($setPrefix+"airportTo")
	
End if 

//MARK:-Searches for departures

If (String:C10(Form:C1466.search.flightsFrom.city)#"")
	
	QUERY:C277([Airport:6]; [Airport:6]city:2=Form:C1466.search.flightsFrom.city)
	RELATE MANY SELECTION:C340([Line:5]UUID_Airport_From:2)
	
	DISTINCT VALUES:C339([Line:5]UUID_Airport_To:3; $_uuidAirportTo)
	QUERY WITH ARRAY:C644([Airport:6]UUID:1; $_uuidAirportTo)
	
	$setName:=$setPrefix+"flightsFromCity"
	$sets.push($setName)
	CREATE SET:C116([Airport:6]; $setName)
End if 

If (String:C10(Form:C1466.search.flightsFrom.location)#"")
	QUERY:C277([Airport:6]; [Airport:6]location:3=Form:C1466.search.flightsFrom.location)
	RELATE MANY SELECTION:C340([Line:5]UUID_Airport_From:2)
	
	DISTINCT VALUES:C339([Line:5]UUID_Airport_To:3; $_uuidAirportTo)
	QUERY WITH ARRAY:C644([Airport:6]UUID:1; $_uuidAirportTo)
	
	$setName:=$setPrefix+"flightsFromLocation"
	$sets.push($setName)
	CREATE SET:C116([Airport:6]; $setName)
End if 

Case of 
	: (String:C10(Form:C1466.search.flightsFrom.countryCode)#"")
		
		QUERY BY ATTRIBUTE:C1331([Airport:6]; [Country:4]codes:10; "iso2"; =; Form:C1466.search.flightsFrom.countryCode)
		RELATE MANY SELECTION:C340([Line:5]UUID_Airport_From:2)
		
		DISTINCT VALUES:C339([Line:5]UUID_Airport_To:3; $_uuidAirportTo)
		QUERY WITH ARRAY:C644([Airport:6]UUID:1; $_uuidAirportTo)
		
		$setName:=$setPrefix+"flightsFromCountryCode"
		$sets.push($setName)
		CREATE SET:C116([Airport:6]; $setName)
		
	: (String:C10(Form:C1466.search.flightsFrom.country)#"")
		
		QUERY:C277([Airport:6]; [Country:4]name:2=Form:C1466.search.flightsFrom.country)
		RELATE MANY SELECTION:C340([Line:5]UUID_Airport_From:2)
		
		DISTINCT VALUES:C339([Line:5]UUID_Airport_To:3; $_uuidAirportTo)
		QUERY WITH ARRAY:C644([Airport:6]UUID:1; $_uuidAirportTo)
		
		$setName:=$setPrefix+"flightsFromCountry"
		$sets.push($setName)
		CREATE SET:C116([Airport:6]; $setName)
		
End case 

//If (Time(Form.search.flightsFrom.arrivalTimeFrom)#?00:00:00?)
//QUERY([Flight]; [Flight]landingTime>=Form.search.flightsFrom.arrivalTimeFrom)
//RELATE ONE SELECTION([Flight]; [Line])

//DISTINCT VALUES([Line]UUID_Airport_From; $_uuidAirportFrom)
//DISTINCT VALUES([Line]UUID_Airport_To; $_uuidAirportTo)

//QUERY WITH ARRAY([Airport]UUID; $_uuidAirportFrom)
//CREATE SET([Airport]; $setPrefix+"airportFrom")

//QUERY WITH ARRAY([Airport]UUID; $_uuidAirportTo)
//CREATE SET([Airport]; $setPrefix+"airportTo")

//$setName:=$setPrefix+"flightsFromTimeFrom"
//$sets.push($setName)
//UNION($setPrefix+"airportTo"; $setPrefix+"airportFrom"; $setName)

//$sets.push($setName)
//CREATE SET([Airport]; $setName)

//End if 

//If (Time(Form.search.flightsFrom.arrivalTimeTo)#?00:00:00?)
//QUERY([Flight]; [Flight]landingTime<=Form.search.flightsFrom.arrivalTimeTo)
//RELATE ONE SELECTION([Flight]; [Line])

//DISTINCT VALUES([Line]UUID_Airport_From; $_uuidAirportFrom)
//DISTINCT VALUES([Line]UUID_Airport_To; $_uuidAirportTo)

//QUERY WITH ARRAY([Airport]UUID; $_uuidAirportFrom)
//CREATE SET([Airport]; $setPrefix+"airportFrom")

//QUERY WITH ARRAY([Airport]UUID; $_uuidAirportTo)
//CREATE SET([Airport]; $setPrefix+"airportTo")

//$setName:=$setPrefix+"flightsFromTimeTo"
//$sets.push($setName)
//UNION($setPrefix+"airportTo"; $setPrefix+"airportFrom"; $setName)

//$sets.push($setName)
//CREATE SET([Airport]; $setName)

//End if 

// MARK: ---Todo Flights from Period


//MARK:-Searches for destinations
If (String:C10(Form:C1466.search.flightsTo.city)#"")
	QUERY:C277([Airport:6]; [Airport:6]city:2=Form:C1466.search.flightsTo.city)
	RELATE MANY SELECTION:C340([Line:5]UUID_Airport_To:3)
	
	DISTINCT VALUES:C339([Line:5]UUID_Airport_From:2; $_uuidAirportFrom)
	QUERY WITH ARRAY:C644([Airport:6]UUID:1; $_uuidAirportFrom)
	
	$setName:=$setPrefix+"flightsToCity"
	$sets.push($setName)
	CREATE SET:C116([Airport:6]; $setName)
End if 

If (String:C10(Form:C1466.search.flightsTo.location)#"")
	
	QUERY:C277([Airport:6]; [Airport:6]location:3=Form:C1466.search.flightsTo.location)
	RELATE MANY SELECTION:C340([Line:5]UUID_Airport_To:3)
	
	DISTINCT VALUES:C339([Line:5]UUID_Airport_From:2; $_uuidAirportFrom)
	QUERY WITH ARRAY:C644([Airport:6]UUID:1; $_uuidAirportFrom)
	
	$setName:=$setPrefix+"flightsToLocation"
	$sets.push($setName)
	CREATE SET:C116([Airport:6]; $setName)
End if 

Case of 
	: (String:C10(Form:C1466.search.flightsTo.countryCode)#"")
		QUERY BY ATTRIBUTE:C1331([Airport:6]; [Country:4]codes:10; "iso2"; =; Form:C1466.search.flightsTo.countryCode)
		RELATE MANY SELECTION:C340([Line:5]UUID_Airport_To:3)
		
		DISTINCT VALUES:C339([Line:5]UUID_Airport_From:2; $_uuidAirportFrom)
		QUERY WITH ARRAY:C644([Airport:6]UUID:1; $_uuidAirportFrom)
		
		$setName:=$setPrefix+"flightsToCountryCode"
		$sets.push($setName)
		CREATE SET:C116([Airport:6]; $setName)
		
	: (String:C10(Form:C1466.search.flightsTo.country)#"")
		
		QUERY:C277([Airport:6]; [Country:4]name:2=Form:C1466.search.flightsTo.country)
		RELATE MANY SELECTION:C340([Line:5]UUID_Airport_To:3)
		
		DISTINCT VALUES:C339([Line:5]UUID_Airport_From:2; $_uuidAirportFrom)
		QUERY WITH ARRAY:C644([Airport:6]UUID:1; $_uuidAirportFrom)
		
		$setName:=$setPrefix+"flightsToCountry"
		$sets.push($setName)
		CREATE SET:C116([Airport:6]; $setName)
End case 

//If (Time(Form.search.flightsTo.departureTimeFrom)#?00:00:00?)
//QUERY([Flight]; [Flight]takeOffTime>=Form.search.flightsTo.departureTimeFrom)
//RELATE ONE SELECTION([Flight]; [Line])

//DISTINCT VALUES([Line]UUID_Airport_From; $_uuidAirportFrom)
//QUERY WITH ARRAY([Airport]UUID; $_uuidAirportFrom)

//$sets.push($setName)
//CREATE SET([Airport]; $setName)

//End if 

//If (Time(Form.search.flightsTo.departureTimeTo)#?00:00:00?)
//QUERY([Flight]; [Flight]takeOffTime<=Form.search.flightsTo.departureTimeTo)
//RELATE ONE SELECTION([Flight]; [Line])

//DISTINCT VALUES([Line]UUID_Airport_From; $_uuidAirportFrom)
//DISTINCT VALUES([Line]UUID_Airport_To; $_uuidAirportTo)

//QUERY WITH ARRAY([Airport]UUID; $_uuidAirportFrom)
//CREATE SET([Airport]; $setPrefix+"airportFrom")

//QUERY WITH ARRAY([Airport]UUID; $_uuidAirportTo)
//CREATE SET([Airport]; $setPrefix+"airportTo")

//$setName:=$setPrefix+"flightsToTimeTo"
//$sets.push($setName)
//UNION($setPrefix+"airportTo"; $setPrefix+"airportFrom"; $setName)

//$sets.push($setName)
//CREATE SET([Airport]; $setName)

//End if 

// MARK: ---Todo Flights to Period



//MARK:-operate the sets
$firstSet:=$sets.shift()
For each ($setName; $sets)
	If (Form:C1466.search.conjonction.index=0)
		INTERSECTION:C121($firstSet; $setName; $firstSet)
	Else 
		UNION:C120($firstSet; $setName; $firstSet)
	End if 
End for each 
If ($firstSet#Null:C1517)
	USE SET:C118($firstSet)
End if 

//MARK:-clean the sets

For each ($setName; $sets.push($firstSet))
	If ($setName#Null:C1517)
		CLEAR SET:C117($setName)
	End if 
End for each 

If (Bool:C1537(Form:C1466.search.logs))
	SET DATABASE PARAMETER:C642(4D Server log recording:K37:28; 0)
End if 



//MARK:-Apply the result
$airports:=Create entity selection:C1512([Airport:6])
Form:C1466.lb_items:=$airports
ACCEPT:C269

//MARK:-call logsDisplayer

If (Bool:C1537(Form:C1466.search.logs))
	SET DATABASE PARAMETER:C642(Client log recording:K37:44; 0)
	$p:=New process:C317("logsDisplayer"; 0; "$logsDisplayer"; *)
	CALL FORM:C1391(Storage:C1525.logsDisplayer.window; "logsDisplayer_update")
End if 