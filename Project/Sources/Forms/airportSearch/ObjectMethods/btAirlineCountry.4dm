var $country : Object


$objectName:=OBJECT Get name:C1087(Object current:K67:2)

$country:=countryMenu(Form:C1466.search.airline.countryCode)

If ($country#Null:C1517)
	Form:C1466.search.airline.country:=$country.name
	Form:C1466.search.airline.countryCode:=$country.code
End if 