


Case of 
	: (FORM Event:C1606.code=On Load:K2:1)
		UTests_hl:=New list:C375
		Form:C1466.UTest.build_HL(UTests_hl)
		
	: (FORM Event:C1606.code=On Unload:K2:2)
		CLEAR LIST:C377(UTests_hl; *)
		
End case 
