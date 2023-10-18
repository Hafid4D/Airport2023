// ----------------------------------------------------
// Nom utilisateur (OS) : Olivier DESCHANELS
// Date et heure : 27/03/07, 09:35:56
// ----------------------------------------------------
// Méthode : Tools_Fill_Var_From_index
// Description
// 
//
// Paramètres
// ----------------------------------------------------

//This methods has to be called from a text object of a form.

//It receives two pointers : 1st on the object, 2nd on and index containing all
//possibles values for this object.
//The object is filled with the first line found in the array beginning with
//the chars allready entered.
//On return, the text is partialy selected. The selected part is the one that
//has NOT been typed, so user can type again for another guess.

//This method has to be called  "on before keystroke"("sur avant frappe clavier")
//…so don't forget to activate this event !

//       Tools_Fill_Var_From_index(->MyVar;->MyIndex)


C_POINTER($1)

$PtrIndex:=$1


$Frappe:=Keystroke
$CodeFrape:=Character code($Frappe)

Case of 
	: ($CodeFrape>=32)
		
		$Edit:=Get edited text
		GET HIGHLIGHT(Form.city_departure; $Start; $End)
		
		Case of 
			: ($Start#$End)
				$Find:=Substring($Edit; 1; $Start-1)+$Frappe+Substring($Edit; $End)+("@"*Num("@"#$Frappe))
			Else 
				$Find:=$Edit+$Frappe+("@"*Num("@"#$Frappe))
		End case 
		$find2:=$find
		If ("@"#$Frappe)
			$n:=Find in field($PtrIndex->; $Find)
		Else 
			$n:=0
		End if 
		
		If ($n>=0)
			Form.city_departure:=$Find
			HIGHLIGHT TEXT(Form.city_departure; Length($Find2)+Num("@"=$Frappe); 2000)
		Else 
			Form.city_departure:=Substring($Edit; 1; $Start-1)+$Frappe+Substring($Edit; $End)
			HIGHLIGHT TEXT(Form.city_departure; $start+1; $start+1)
		End if 
End case 

If ($CodeFrape>=32)
	FILTER KEYSTROKE("")
End if 