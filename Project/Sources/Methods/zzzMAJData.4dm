//%attributes = {}
For each ($country; ds:C1482.Country.all())
	
	$country.codes:=New object:C1471
	
	$country.codes.iso2:=$country.isoCode_2
	$country.codes.iso3:=$country.isoCode_3
	$country.codes.isoN:=$country.isoCodeNum
	
	
	$codes_IATA:=$country.airports.query("IATA_countryCode # ''").distinct("IATA_countryCode"; ck count values:K85:37)
	If ($codes_IATA.length>0)
		$codes_IATA:=$codes_IATA.orderBy("count desc")
		$country.codes.IATA:=$codes_IATA[0].value
	End if 
	
	$codes_CAA:=$country.airports.query("CAA_countryCode # ''").distinct("CAA_countryCode"; ck count values:K85:37)
	If ($codes_CAA.length>0)
		$codes_CAA:=$codes_CAA.orderBy("count desc")
		$country.codes.CAA:=$codes_CAA[0].value
	End if 
	
	$info:=$country.save()
	
End for each 


For each ($airport; ds:C1482.Airport.all())
	
	$airport.codes:=New object:C1471
	$airport.codes.IATA:=$airport.IATA_airportCode
	$airport.codes.ICAO:=$airport.ICAO_airportCode
	$airport.codes.CAA:=$airport.CAA_airportCode
	
	$airport.geometry:=New object:C1471
	$airport.geometry.latitude:=$airport.latitude
	$airport.geometry.longitude:=$airport.longitude
	$airport.geometry.elevation:=$airport.elevation
	
	$info:=$airport.save()
	
End for each 
