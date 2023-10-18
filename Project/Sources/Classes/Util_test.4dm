Class constructor
	This:C1470.UTest:=cs:C1710.UTest.new()
	This:C1470.sut:=cs:C1710.Util.new()
	This:C1470.testMethods:=New collection:C1472("fact_test")
	
	
Function fact_test()
	$result:=This:C1470.sut.fact(3)
	
	This:C1470.UTest\
		.describe("test factotial function")\
		.expect($result)\
		.toBe(6)
	
	