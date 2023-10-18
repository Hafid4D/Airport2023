
Case of 
	: (Form event code:C388=On Clicked:K2:4)
		
		// cette ligne va changer en v18R2, la commande Form event retourne le nom de la colonne sur laquelle le clique est fait
		LISTBOX GET CELL POSITION:C971(*; "flight_lb"; $colonne; $ligne)
		
		If ($colonne=1)
			If (Form:C1466.item#Null:C1517)
				If (Form:C1466.item.pict#Null:C1517)
					
					If (Form:C1466.item.down)
						Form:C1466.item.pict:=Storage:C1525.right.pict
						$toHide:=Form:C1466.flights.query("id = :1"; Form:C1466.item.id)
						Form:C1466.hiddens.combine(Form:C1466.flights.slice(Form:C1466.item_position; $toHide.length+Form:C1466.item_position-1))
						Form:C1466.flights.remove(Form:C1466.item_position; $toHide.length-1)
					Else 
						Form:C1466.item.pict:=Storage:C1525.down.pict
						$toDisplay:=Form:C1466.hiddens.query("id = :1"; Form:C1466.item.id)
						Form:C1466.flights.combine($toDisplay; Form:C1466.item_position)
						
						$position:=-1
						$continue:=True:C214
						For each ($line; Form:C1466.hiddens) While ($continue)
							If ($line.id=Form:C1466.item.id)
								$continue:=False:C215
							End if 
							$position:=$position+1
						End for each 
						
						Form:C1466.hiddens.remove($position; $toDisplay.length)
						
					End if 
					
					Form:C1466.item.down:=Not:C34(Form:C1466.item.down)
				End if 
			End if 
		End if 
End case 


