//%attributes = {}
#DECLARE()

//MARK:-Initialize an instance of the search class
If (Form:C1466.search=Null:C1517)
	Form:C1466.search:=cs:C1710.search_08.new()
End if 

//MARK:-Perform the search
Form:C1466.lb_items:=Form:C1466.search.perform(Form:C1466.entry; Form:C1466.searchbox)

//MARK:-After the search
//MARK:Update the counter

If (Form:C1466.lb_items#Null:C1517)
	OBJECT SET HELP TIP:C1181(*; "inputItemsLength"; String:C10(Form:C1466.lb_items.length)+" / "+String:C10(ds:C1482[Form:C1466.entry.dataclass.name].getCount()))
End if 

//MARK:Query plan / query path
If (Form:C1466.search#Null:C1517)
	OBJECT SET VISIBLE:C603(*; "btQueryPath"; Form:C1466.search.querySettings.queryPath)
	OBJECT SET VISIBLE:C603(*; "btQueryPlan"; Form:C1466.search.querySettings.queryPlan)
End if 