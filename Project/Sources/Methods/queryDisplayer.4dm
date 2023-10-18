//%attributes = {}
#DECLARE($query : Object)

$displayer:=$query.type+"Displayer"

$ref:=Open form window:C675("queryDisplayer"; Palette form window:K39:9; On the right:K39:3; At the top:K39:5)
Use (Storage:C1525[$displayer])
	Storage:C1525[$displayer].window:=$ref
End use 
DIALOG:C40("queryDisplayer"; {query: $query})
CLOSE WINDOW:C154($ref)
