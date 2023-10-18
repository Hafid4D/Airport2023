Case of 
	: (FORM Event:C1606.code=On Load:K2:1)
		SET TIMER:C645(60)
		
	: (FORM Event:C1606.code=On Bound Variable Change:K2:52)
		$currentDate:=String:C10(Current date:C33; ISO date GMT:K1:10; Current time:C178)
		$currentTime:=Num:C11(Time:C179(Substring:C12($currentDate; 12; 8)))
		
		Form:C1466.time:=Time string:C180(Time:C179($currentTime+(Num:C11(Form:C1466.Country.localTime)*3600)))
		
	: (Form event code:C388=On Timer:K2:25)
		If (Form:C1466.Airport#Null:C1517)
			$currentDate:=String:C10(Current date:C33; ISO date GMT:K1:10; Current time:C178)
			$currentTime:=Num:C11(Time:C179(Substring:C12($currentDate; 12; 8)))
			
			Form:C1466.time:=Time string:C180(Time:C179($currentTime+(Num:C11(Form:C1466.Airport.localTime)*3600)))
		End if 
		
End case 