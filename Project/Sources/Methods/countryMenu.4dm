//%attributes = {}
#DECLARE($countryCode : Text)->$choosenCountry : Object

If (Storage:C1525.popupMenu.country=Null:C1517)
	
	$menu:=Create menu:C408
	For each ($country; ds:C1482.Country.all().orderBy("name"))
		APPEND MENU ITEM:C411($menu; $country.name; *)
		SET MENU ITEM ICON:C984($menu; -1; "file:image/flags/tiny/"+String:C10($country.codes.iso2)+".png")
		SET MENU ITEM PARAMETER:C1004($menu; -1; String:C10($country.codes.iso2)+"--"+$country.name)
		If ($country.codes.iso2=$countryCode)
			SET MENU ITEM MARK:C208($menu; -1; Char:C90(18))
		End if 
	End for each 
	
	Use (Storage:C1525.popupMenu)
		Storage:C1525.popupMenu.country:=$menu
	End use 
End if 

$line:=Dynamic pop up menu:C1006(Storage:C1525.popupMenu.country)
// we don't release the menu after use to be able to reuse it in another object method

If ($line#"")
	$choosenCountry:=New object:C1471()
	$choosenCountry.code:=Split string:C1554($line; "--"; sk ignore empty strings:K86:1)[0]
	$choosenCountry.name:=Split string:C1554($line; "--"; sk ignore empty strings:K86:1)[1]
End if 
