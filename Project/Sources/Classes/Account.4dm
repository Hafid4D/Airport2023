Class constructor
	This:C1470.owner:={id: 1; isAdmin: False:C215}
	
Function isUserOwner($user : Object)
	return This:C1470.owner.id=$user.id
	
Function canResetPassword($user : Object)->$cancel : Boolean
	Case of 
		: ($user.isAdmin)
			$cancel:=True:C214
			
		: (This:C1470.isUserOwner($user))
			$cancel:=True:C214
			
		Else 
			$cancel:=False:C215
			
	End case 