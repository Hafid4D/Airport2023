


Case of 
	: (FORM Event:C1606.code=On Double Clicked:K2:5)
		
		GET LIST ITEM PARAMETER:C985(UTests_hl; *; "functionAndLine"; $value)
		
		If ($value#"")
			METHOD OPEN PATH:C1213(\
				"[class]/"+Replace string:C233(Split string:C1554($value; ";")[0]; "."; "/"); \
				Num:C11(Split string:C1554($value; ";")[1]))
		End if 
End case 
