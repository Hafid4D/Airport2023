//%attributes = {}
$country:=New shared object:C1526("name"; "Cabo Verde")
$capital:=New shared object:C1526("name"; "Praia")

Use ($country)
	$country.capital:=$capital
End use 

$islands:=New shared object:C1526()

Use ($country)
	$country.islands:=$islands
End use 

$barlavento:=New shared collection:C1527()
$barlavento.push("Santo Antão"; "São Vicente"; "Santa Luzia"; "São Nicolau"; "Sal"; "Boa Vista")

$sotavento:=New shared collection:C1527()
$sotavento.push("Maio"; "Santiago"; "Fogo"; "Brava")

Use ($islands)
	$islands.barlavento:=$barlavento
	$islands.sotavento:=$sotavento
End use 
