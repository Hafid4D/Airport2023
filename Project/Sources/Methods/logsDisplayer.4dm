//%attributes = {}

$ref:=Open form window:C675("logsDisplayer"; Palette form window:K39:9; On the right:K39:3; At the top:K39:5)
Use (Storage:C1525.logsDisplayer)
	Storage:C1525.logsDisplayer.window:=$ref
End use 
DIALOG:C40("logsDisplayer")
CLOSE WINDOW:C154($ref)
Use (Storage:C1525.logsDisplayer)
	Storage:C1525.logsDisplayer.window:=0
End use 

