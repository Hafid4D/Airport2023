
Case of 
	: (Form event code:C388=On Load:K2:1)
		Form:C1466.city_departure:=""
		Form:C1466.city_arrival:=""
		Form:C1466.date_departure:=Current date:C33
		Form:C1466.time_departure:=Time:C179(Time string:C180(((Current time:C178+3600)\3600)*3600))
		
		Form:C1466.hiddens:=New collection:C1472
		
		Use (Storage:C1525)
			$open_arrow:=Get 4D folder:C485(Current resources folder:K5:16)+"image"+Folder separator:K24:12+"arrow"+Folder separator:K24:12+"down.png"
			READ PICTURE FILE:C678($open_arrow; $pict_down)
			
			$open_arrow:=Get 4D folder:C485(Current resources folder:K5:16)+"image"+Folder separator:K24:12+"arrow"+Folder separator:K24:12+"right.png"
			READ PICTURE FILE:C678($open_arrow; $pict_right)
			
			Storage:C1525.down:=New shared object:C1526("pict"; $pict_down)
			Storage:C1525.right:=New shared object:C1526("pict"; $pict_right)
		End use 
		
End case 