Case of 
	: (FORM Event:C1606.code=On Load:K2:1)
		
		If (Form:C1466.search=Null:C1517)
			airportSearchInitForm
		End if 
		Form:C1466.nbOfFilling:=0
		
		
		If (Application type:C494#4D Remote mode:K5:5)
			OBJECT SET VISIBLE:C603(*; "cbGenerateLogs"; False:C215)
			Form:C1466.search.logs:=False:C215
		End if 
		
End case 


// Dealing with countries 
$defaultFormat:="Choose a country;#image/flags/tiny/_United Nations.png;0;3;1;1;8;0;0;0;1;0;1"

If (String:C10(Form:C1466.search.country)#"")
	$format:=Form:C1466.search.country+";#image/flags/tiny/"+Form:C1466.search.countryCode+".png;0;3;1;1;8;0;0;0;1;0;1"
Else 
	$format:=$defaultFormat
End if 
OBJECT SET FORMAT:C236(*; "btCountry"; $format)

If (String:C10(Form:C1466.search.airline.country)#"")
	$format:=Form:C1466.search.airline.country+";#image/flags/tiny/"+Form:C1466.search.airline.countryCode+".png;0;3;1;1;8;0;0;0;1;0;1"
Else 
	$format:=$defaultFormat
End if 
OBJECT SET FORMAT:C236(*; "btAirlineCountry"; $format)


If (String:C10(Form:C1466.search.flightsTo.countryCode)#"")
	$format:=Form:C1466.search.flightsTo.country+";#image/flags/tiny/"+Form:C1466.search.flightsTo.countryCode+".png;0;3;1;1;8;0;0;0;1;0;1"
Else 
	$format:=$defaultFormat
End if 
OBJECT SET FORMAT:C236(*; "btFlightsToCountry"; $format)

If (String:C10(Form:C1466.search.flightsFrom.countryCode)#"")
	$format:=Form:C1466.search.flightsFrom.country+";#image/flags/tiny/"+Form:C1466.search.flightsFrom.countryCode+".png;0;3;1;1;8;0;0;0;1;0;1"
Else 
	$format:=$defaultFormat
End if 
OBJECT SET FORMAT:C236(*; "btFlightsFromCountry"; $format)
