Case of 
	: (FORM Event:C1606.code=On Getting Focus:K2:7)
		OBJECT SET RGB COLORS:C628(*; "searchbox_border"; "blue"; "white")
		OBJECT SET BORDER STYLE:C1262(*; "searchbox_border"; Border Plain:K42:28)
		
	: (FORM Event:C1606.code=On Losing Focus:K2:8)
		OBJECT SET RGB COLORS:C628(*; "searchbox_border"; "lightgrey"; "white")
		OBJECT SET BORDER STYLE:C1262(*; "searchbox_border"; Border System:K42:33)
		
	: (FORM Event:C1606.code=On Data Change:K2:15)
		main_load_lb_items
		
End case 