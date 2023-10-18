// Préremplir plein de valeurs dans le form pour éviter d'avoir à les saisir manuellement et aller + vite pour la démo
Case of 
	: (FORM Event:C1606.code=On Clicked:K2:4)
		
		Form:C1466.nbOfFilling+=1
		
		airportSearchInitForm
		
		Case of 
			: (Form:C1466.nbOfFilling=1)  //Departure from NY 
				Form:C1466.search.flightsFrom:={city: "New York"; location: "John F Kennedy Intl"}
				Form:C1466.search.fill:="1 - Airports served by flights from New York"
				
			: (Form:C1466.nbOfFilling=2)  // to United States by a French airline
				Form:C1466.search.flightsTo:={countryCode: "US"; country: "United States of America"}
				Form:C1466.search.airline:={countryCode: "FR"; country: "France"}
				Form:C1466.search.fill:="2 - Airports providing flights to the US\r by a French airline"
				
				
			: (Form:C1466.nbOfFilling=3)
				Form:C1466.search.flightsTo.city:="San Francisco"
				Form:C1466.search.flightsFrom.city:="Paris"
				Form:C1466.search.fill:="3 - Airports providing flights to San Francisco,\ralso served by flights from Paris"
				
			: (Form:C1466.nbOfFilling=4)
				Form:C1466.nbOfFilling:=0  //  Init form + Go back to the beginning
		End case 
		
End case 