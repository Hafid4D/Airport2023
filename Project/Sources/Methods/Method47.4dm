//%attributes = {}
$object:=OB Copy:C1225($sharedObject)

$sharedObject:=OB Copy:C1225($object; ck shared:K85:29)



$country:=New shared object:C1526("name"; "Cabo Verde"; "capital"; New shared object:C1526("name"; "Praia"))


$collection:=$sharedCollection.copy()

$sharedCollection:=$collection.copy(ck shared:K85:29)

$sharedObjectCopy:=OB Copy:C1225($object; ck shared:K85:29; $sharedCollection)
Use ($sharedCollection)
	$sharedCollection.push($sharedObjectCopy)
End use 