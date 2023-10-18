If (FORM Event:C1606.code=On Selection Change:K2:29)
	var $ptrTable : Pointer
	var $formName : Text
	
	OBJECT GET SUBFORM:C1139(*; "subformPanel"; $ptrTable; $formName)
	$entryPanel:=Form:C1466.entry.panel
	If ($formName#$entryPanel)
		OBJECT SET SUBFORM:C1138(*; "subformPanel"; $entryPanel)
	End if 
	
	
	Form:C1466.subform:=New object:C1471()
	Form:C1466.subform[Form:C1466.entry.dataclass.name]:=Form:C1466.currentItem
	
End if 