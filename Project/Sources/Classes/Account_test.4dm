Class constructor
	This:C1470.UTest:=cs:C1710.UTest.new()
	This:C1470.sut:=cs:C1710.Account.new()
	//This.testMethods:=New collection("canResetPassword_test")
	
Function canResetPassword_test()
	// Scenario 1
	$user:={id: 4; isAdmin: True:C214}
	$result:=This:C1470.sut.canResetPassword($user)
	This:C1470.UTest\
		.describe("Can resest password: user not owner but admin")\
		.expect($result)\
		.toBe(True:C214)
	
	// Scenario 2
	$user:={id: 1; isAdmin: False:C215}
	$result:=This:C1470.sut.canResetPassword($user)
	This:C1470.UTest.describe("Can resest password: user is owner and not admin")\
		.expect($result)\
		.toBe(True:C214)
	
	// Scenario 3
	$user:={id: 2; isAdmin: False:C215}
	$result:=This:C1470.sut.canResetPassword($user)
	This:C1470.UTest.describe("Can't resest password: user not owner and not admin")\
		.expect($result)\
		.toBe(False:C215)
	