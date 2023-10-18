

C_OBJECT($1)


If ($1.pict#Null)
	$0:="# "+String($1.id)
Else 
	$0:=$1.icon
End if 

