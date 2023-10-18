var $entity : 4D:C1709.Entity

OBJECT SET ENABLED:C1123(bValidate; $entity.touched())

If (bValidate=1)
	//do something
End if 


If (OBJECT Get pointer:C1124(Object named:K67:5; "bValidate")->=1)
	//do something
End if 