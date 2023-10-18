Class constructor($actions : Text)
	This:C1470.UTest:=Null:C1517
	This:C1470.actions:=$actions
	
Function execute()
	$actionsCollection:=Split string:C1554(This:C1470.actions; ";"; sk ignore empty strings:K86:1+sk trim spaces:K86:2)
	
	
	$continue:=True:C214
	For each ($action; $actionsCollection) While ($continue)
		Case of 
			: ($action="compile")
				$continue:=This:C1470.compile()
				
			: ($action="test")
				$continue:=This:C1470.test()
				
			: ($action="build")
				$continue:=This:C1470.build()
				
			: ($action="deploy")
				$continue:=This:C1470.deploy()
				
		End case 
	End for each 
	QUIT 4D:C291
	
Function compile()
	var $resultCompilationText : Text
	
	$options:=New object:C1471("targets"; New collection:C1472())
	$resultCompilation:=Compile project:C1760($options)
	
	$resultCompilationText:=$resultCompilation.success ? "Syntax check passed" : "Syntax check failed"
	If ($resultCompilation.success=False:C215)
		$errors:=$resultCompilation.errors.query("isError == :1"; True:C214)
		For each ($error; $errors)
			$resultCompilationText+="\r------------------------\r"+\
				"Method: "+$error.code.path+"\r"+\
				"Line: "+String:C10($error.line)+"\r"+\
				"Message: "+$error.message
		End for each 
	End if 
	TEXT TO DOCUMENT:C1237("compilationResult.txt"; $resultCompilationText)
	return $resultCompilation.success
	
Function test()
	$resultText:=This:C1470.UTest.runAllTests().resultText()
	TEXT TO DOCUMENT:C1237("UTestResult.txt"; $resultText)
	return This:C1470.UTest.UTest_result.query("success == :1"; False:C215).length>0 ? False:C215 : True:C214
	
	
Function build()
	$file:=File:C1566(Build application settings file:K5:60)
	BUILD APPLICATION:C871($file.platformPath)
	TEXT TO DOCUMENT:C1237("buildResult.txt"; OK=1 ? "build passed" : "build failed")
	return OK=1 ? True:C214 : False:C215
	
Function deploy()  //TEXT TO DOCUMENT("deployResult.txt"; "deploy passed")
	return True:C214