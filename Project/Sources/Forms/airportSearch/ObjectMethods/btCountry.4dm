var $country : Object


$objectName:=OBJECT Get name:C1087(Object current:K67:2)

$country:=countryMenu(Form:C1466.search.countryCode)

If ($country#Null:C1517)
	Form:C1466.search.country:=$country.name
	Form:C1466.search.countryCode:=$country.code
End if 