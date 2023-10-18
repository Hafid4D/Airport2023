Case of 
	: (FORM Event:C1606.code=On Load:K2:1)
		
		If (Form:C1466.query.type="queryPlan")
			OBJECT SET RGB COLORS:C628(*; "inputQueryText"; Foreground color:K23:1; "#EDF3FB")
		Else 
			OBJECT SET RGB COLORS:C628(*; "inputQueryText"; Foreground color:K23:1; "#E7FBE6")
		End if 
		
		SET WINDOW TITLE:C213(Form:C1466.query.title)
		
End case 