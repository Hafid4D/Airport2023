If (Form:C1466.previousSearch=Null:C1517)
	Form:C1466.previousSearch:=New object:C1471()
End if 
var $searchDialog : Text
$searchDialog:=Form:C1466.entry.searchDialog
$ref:=Open form window:C675($searchDialog; Sheet form window:K39:12)
DIALOG:C40($searchDialog; Form:C1466.previousSearch)
CLOSE WINDOW:C154($ref)
If (ok=1)
	Form:C1466.lb_items:=Form:C1466.previousSearch.lb_items
End if 