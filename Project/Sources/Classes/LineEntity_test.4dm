Class constructor
	This:C1470.UTest:=cs:C1710.UTest.new()
	This:C1470.sut:=ds:C1482.Line.all().first()
	//This.testMethods:=New collection("speed_test")
	
Function speed_test
	$result:=This:C1470.sut.speed
	
	This:C1470.UTest.describe("Test speed with distance 6197")\
		.expect($result)\
		.toBe(1050)
	
	
	