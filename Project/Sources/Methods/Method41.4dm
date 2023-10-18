//%attributes = {}
C_POINTER:C301($1)

For ($i; 1; Size of array:C274($1->))
	
	If ($1->{$i}>1000)
		return $i
	End if 
End for 



If ($parameter.size=Null:C1517)
	$size:=12
Else 
	$size:=Num:C11($parameter.size)
End if 

$size:=($parameter.size=Null:C1517) ? 12 : Num:C11($parameter.size)

$size:=Choose:C955(($parameter.size=Null:C1517); 12; Num:C11($parameter.size))


$fullname:=($person.firstname && $person.lastname) ? ($person.firstname+" "+$person.lastname) : ($person.lastname || $person.firstname) || ""

$phone:=$person.phone || "unknow"

$phone:=$person.phone || $person.mobile || "unknow"

C_VARIANT:C1683($nbOptions)
$nbOptions:=$product.options && $product.options.length


