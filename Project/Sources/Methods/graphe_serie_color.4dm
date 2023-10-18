//%attributes = {}
#DECLARE($nb_color : Integer)->$colors : Collection

LIST TO ARRAY:C288("camaieu"; $_val)
$max:=Size of array:C274($_val)  //se protéger contre une série plus longue que prévue dans nos modèles de 
ARRAY TEXT:C222($_color; 0)
For ($i; 1; $nb_color)
	$indice:=$i%$max
	If ($indice#0)
		$color:=$_val{$i}
	Else 
		$color:=$_val{$max}
	End if 
	APPEND TO ARRAY:C911($_color; $color)
End for 
$colors:=New collection:C1472()

ARRAY TO COLLECTION:C1563($colors; $_color)