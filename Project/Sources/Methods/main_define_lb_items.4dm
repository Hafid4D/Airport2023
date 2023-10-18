//%attributes = {}
#DECLARE()
var $nil : Pointer

LISTBOX DELETE COLUMN:C830(*; "lb_items"; 1; 1000)  //1000 is enough!
$i:=0
For each ($column; Form:C1466.entry.lb_columns)
	$i+=1
	$expression:="This."+$column.attribute
	$header:=$column.header
	$type:=($column.type#Null:C1517) ? $column.type : Is text:K8:3
	$columnName:="column_"+String:C10($i)
	LISTBOX INSERT COLUMN FORMULA:C970(*; "lb_items"; 1000; $columnName; $expression; $type; "header_"+String:C10($i); $nil)
	OBJECT SET TITLE:C194(*; "header_"+String:C10($i); $header)
	If ($column.width#Null:C1517)
		LISTBOX SET COLUMN WIDTH:C833(*; $columnName; $column.width)
	End if 
	If ($column.format#Null:C1517)
		$format:=($column.type=Is date:K8:7) | ($column.type=Is time:K8:8) | ($column.type=Is picture:K8:10) ? Char:C90($column.format) : $column.format
		OBJECT SET FORMAT:C236(*; $columnName; $format)
	End if 
	If ($column.hAlign#Null:C1517)
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $columnName; $column.hAlign)
	End if 
	If ($column.vAlign#Null:C1517)
		OBJECT SET VERTICAL ALIGNMENT:C1187(*; $columnName; $column.vAlign)
	End if 
	OBJECT SET ENTERABLE:C238(*; $columnName; Bool:C1537($column.enterable))
End for each 