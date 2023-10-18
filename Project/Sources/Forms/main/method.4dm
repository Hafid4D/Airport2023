


Case of 
	: (FORM Event:C1606.code=On Load:K2:1)
		Form:C1466.searchbox:=""
		SET TIMER:C645(-1)
		
	: (FORM Event:C1606.code=On Timer:K2:25)
		
		SET TIMER:C645(0)
		OBJECT GET COORDINATES:C663(*; "rbAirport"; $left; $top; $right; $bottom)
		POST CLICK:C466($left; $top)
		
	: (FORM Event:C1606.code=On Unload:K2:2)
		
		$query:={action: "hide"}
		CALL FORM:C1391(Storage:C1525.queryPathDisplayer.window; "queryDisplayer_update"; $query)
		CALL FORM:C1391(Storage:C1525.queryPlanDisplayer.window; "queryDisplayer_update"; $query)
		
End case 