//%attributes = {}

C_OBJECT:C1216($1)
C_TEXT:C284($0)

$address:=$1
$stringyfiedAddress:=""
If ($address.street1#Null:C1517)
	If ($address.street1#"")
		$stringyfiedAddress+=$address.street1+Char:C90(Carriage return:K15:38)
	End if 
End if 
If ($address.street2#Null:C1517)
	If ($address.street2#"")
		$stringyfiedAddress+=$address.street2+Char:C90(Carriage return:K15:38)
	End if 
End if 
If ($address.zip#Null:C1517)
	If ($address.zip#"")
		$stringyfiedAddress+=$address.zip+" "
	End if 
End if 
If ($address.city#Null:C1517)
	If ($address.city#"")
		$stringyfiedAddress+=$address.city+" "
	End if 
End if 
If ($address.state#Null:C1517)
	If ($address.state#"")
		$stringyfiedAddress+=$address.state
	End if 
End if 
If ($address.country#Null:C1517)
	If ($stringyfiedAddress#"")
		$stringyfiedAddress+=Char:C90(Carriage return:K15:38)
	End if 
	If ($address.country#"")
		$stringyfiedAddress+=$address.country
	End if 
End if 
$0:=$stringyfiedAddress


//*********************************

C_OBJECT:C1216($1)
C_TEXT:C284($0)

$address:=$1
$stringyfiedAddress:=""
If ($address.street1#Null:C1517)
	If ($address.street1#"")
		$stringyfiedAddress+=$address.street1+Char:C90(Carriage return:K15:38)
	End if 
End if 
If ($address.street2#Null:C1517)
	If ($address.street2#"")
		$stringyfiedAddress+=$address.street2+Char:C90(Carriage return:K15:38)
	End if 
End if 
If ($address.zip#Null:C1517)
	If ($address.zip#"")
		$stringyfiedAddress+=$address.zip+" "
	End if 
End if 
If ($address.city#Null:C1517)
	If ($address.city#"")
		$stringyfiedAddress+=$address.city+" "
	End if 
End if 
If ($address.state#Null:C1517)
	If ($address.state#"")
		$stringyfiedAddress+=$address.state
	End if 
End if 
If ($address.country#Null:C1517)
	If ($stringyfiedAddress#"")
		$stringyfiedAddress+=Char:C90(Carriage return:K15:38)
	End if 
	If ($address.country#"")
		$stringyfiedAddress+=$address.country
	End if 
End if 
$0:=$stringyfiedAddress