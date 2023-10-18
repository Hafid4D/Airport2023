//%attributes = {}

C_TEXT:C284($name)
C_LONGINT:C283($age)
C_BOOLEAN:C305($isAdult)
C_DATE:C307($birthday)
C_OBJECT:C1216($options)
C_OBJECT:C1216($employee)
C_OBJECT:C1216($employees)
C_OBJECT:C1216($chart)
C_OBJECT:C1216($file)
C_BLOB:C604($body)


var $name : Text
var $age : Integer
var $isAdult : Boolean
var $birthday : Date
var $options : Object
var $employee : cs:C1710.EmployeeEntity
var $employees : cs:C1710.EmployeeSelection
var $chart : cs:C1710.chart
var $file : 4D:C1709.File
var $body : 4D:C1709.Blob

C_TEXT:C284(<>charCR)
<>charCR:=Char:C90(Carriage return:K15:38)
$text:="First line"+<>charCR+"Second line"


C_TEXT:C284(<>charDoubleQuote)
<>charDoubleQuote:=Char:C90(Double quote:K15:41)
$text:="Do you really want to delete "+<>charDoubleQuote+$customerName+<>charDoubleQuote+" ?"

C_REAL:C285(<>pi)
<>pi:=3.14159

$area:=<>pi*($radius^2)


C_TEXT:C284(<>folderSep)
If (Is macOS:C1572)
	<>folderSep:=":"
Else 
	<>folderSep:="\""
End if 

$subfolder:=Get 4D folder:C485(Current resources folder:K5:16)+"image"+<>folderSep+"logo"
$subfolder:=Get 4D folder:C485(Current resources folder:K5:16)+Folder separator:K24:12+<>folderSep+"logo"

var $myObject : Object


#DECLARE($person : Pointer)
OB SET:C1220($person->; "lastName"; "Hardy")


var $geometry : Object

OB SET:C1220($geometry; "latitude"; 45.4; "longitude"; 1.5; "elevation"; 400)

$geometry:={latitude: 45.4; longitude: 1.5; elevation: 400}

$geometry:=New object:C1471
$geometry["latitude"]:=45.4
$geometry["longitude"]:=1.5
$geometry["elevation"]:=400

$geometry:=New object:C1471
$geometry.latitude:=45.4
$geometry.longitude:=1.5
$geometry.elevation:=400

$coordinate:="latitude"
$geometry[$coordinate]:=45.4

$vAge:=$employee.children[2].age


var $myColl : Collection
$myColl:=["alpha"; "bravo"; 66; ->myPtr; Current date:C33; $obj1; $myOtherCollection]

$casting:=[{first: "Stan"; last: "Laurel"}; {first: "Oliver"; last: "Hardy"}]

$nbOfActors:=$casting.length






var $obj1; $obj4 : Object
var $myColl : Collection
$obj1:=New object:C1471("prop1"; "blah")
$myColl:=New collection:C1472("alpha"; "bravo"; 66; $obj1)
$text:=$myColl[3].prop1  //blah  
$obj4:=$myColl[3]
$obj4.prop1:="other"
$text:=$myColl[3].prop1  //other

$obj4:=OB Copy:C1225($myColl[3])

$mySharedObject:=New shared object:C1526("customer_ID"; 1235)
$goldMedalist:=$standings[0].runner
$silverMedalist:=$standings[1].runner

Use ($mySharedObject)
	$mySharedObject.customer_ID:=6478
End use 

Use ($smtpServer)
	$ipAddress:=$smtpServer.ip
	$portAddress:=$smtpServer.port
	$login:=$smtpServer.login
	$password:=$smtpServer.pw
End use 
$customer_ID:=$mySharedObject.customer_ID