C_OBJECT($1; $0)

$0:=New object()
If ($1.pict#Null)
	$0.fill:="#DCDCDC"
	//$0.fontWeight:="bold"
Else 
	$0.fill:="white"
End if 
