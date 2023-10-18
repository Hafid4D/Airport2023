Class extends Entity


//MARK:- codeISO2
Function get codeISO2()->$code : Text
	$code:=This:C1470.codes.iso2
	
Function set codeISO2($value : Text; $event : Object)
	This:C1470.codes.iso2:=$value
	
Function query codeISO2($event : Object)->$result : Object
	
	$operator:=$event.operator
	$codeToSearch:=$event.value
	
	$query:="codes.iso2 "+$operator+" :1"
	$parameters:=New collection:C1472($codeToSearch)
	
	$result:=New object:C1471("query"; $query; "parameters"; $parameters)
	
Function orderBy codeISO2($event : Object)->$result : Text
	$result:="codes.iso2"+((Bool:C1537($event.descending)) ? " desc" : "")
	
	
	
	//MARK:- codeISO3
Function get codeISO3()->$code : Text
	$code:=This:C1470.codes.iso3
	
Function set codeISO3($value : Text; $event : Object)
	This:C1470.codes.iso3:=$value
	
Function query codeISO3($event : Object)->$result : Object
	$operator:=$event.operator
	$codeToSearch:=$event.value
	
	$query:="codes.iso3 "+$operator+" :1"
	$parameters:=New collection:C1472($codeToSearch)
	
	$result:=New object:C1471("query"; $query; "parameters"; $parameters)
	
Function orderBy codeISO3($event : Object)->$result : Text
	$result:="codes.iso3"+((Bool:C1537($event.descending)) ? " desc" : "")
	
	
	
	//MARK:- codeISOn
Function get codeISOn()->$code : Integer
	$code:=This:C1470.codes.isoN
	
Function set codeISOn($value : Integer; $event : Object)
	This:C1470.codes.isoN:=$value
	
Function query codeISOn($event : Object)->$result : Object
	$operator:=$event.operator
	$codeToSearch:=$event.value
	
	$query:="codes.isoN "+$operator+" :1"
	$parameters:=New collection:C1472($codeToSearch)
	
	$result:=New object:C1471("query"; $query; "parameters"; $parameters)
	
Function orderBy codeISOn($event : Object)->$result : Text
	$result:="codes.isoN"+((Bool:C1537($event.descending)) ? " desc" : "")
	
	
	
	//MARK:- codeIATA
Function get codeIATA()->$code : Text
	$code:=This:C1470.codes.IATA
	
Function set codeIATA($value : Text; $event : Object)
	This:C1470.codes.IATA:=$value
	
Function query codeIATA($event : Object)->$result : Object
	$operator:=$event.operator
	$codeToSearch:=$event.value
	
	$query:="codes.IATA "+$operator+" :1"
	$parameters:=New collection:C1472($codeToSearch)
	
	$result:=New object:C1471("query"; $query; "parameters"; $parameters)
	
Function orderBy codeIATA($event : Object)->$result : Text
	$result:="codes.IATA"+((Bool:C1537($event.descending)) ? " desc" : "")
	
	
	//MARK:- codeCAA
Function get codeCAA()->$code : Text
	$code:=This:C1470.codes.CAA
	
Function set codeCAA($value : Text; $event : Object)
	This:C1470.codes.CAA:=$value
	
Function query codeCAA($event : Object)->$result : Object
	$operator:=$event.operator
	$codeToSearch:=$event.value
	
	$query:="codes.CAA "+$operator+" :1"
	$parameters:=New collection:C1472($codeToSearch)
	
	$result:=New object:C1471("query"; $query; "parameters"; $parameters)
	
Function orderBy codeCAA($event : Object)->$result : Text
	$result:="codes.CAA"+((Bool:C1537($event.descending)) ? " desc" : "")
	
	
	
	
	
	//MARK:-Counts
	
Function get nbOfDestinationAirports()->$nbOfDestinationAirports : Integer
	
	$nbOfDestinationAirports:=This:C1470.airports.departureLines.distinct("UUID_Airport_To").length
	
	
Function get nbOfOrigineAirports()->$nbOfOrigineAirports : Integer
	
	$nbOfOrigineAirports:=This:C1470.airports.arrivalLines.distinct("UUID_Airport_From").length
	
	
Function get nbOfConnectedAirports()->$nbOfConnectedAirports : Integer
	
	$destinationAirports:=This:C1470.airports.departureLines.distinct("UUID_Airport_To")
	$origineAirports:=This:C1470.airports.arrivalLines.distinct("UUID_Airport_From")
	$nbOfConnectedAirports:=$destinationAirports.combine($origineAirports).distinct().length
	
	
	//MARK:-Flags
local Function get bigFlag()->$flag : Picture
	
	$path:=This:C1470.bigFlagPath
	
	BLOB TO PICTURE:C682(File:C1566($path; fk posix path:K87:1).getContent(); $flag)
	
	
local Function get bigFlagPath()->$path : Text
	var $folderFlags : 4D:C1709.Folder
	var $pictureFile : 4D:C1709.File
	
	$folderFlags:=Folder:C1567("/RESOURCES/image/flags/"; fk posix path:K87:1)
	$pictureFile:=File:C1566($folderFlags.path+This:C1470.codeISO2+".png"; fk posix path:K87:1)
	If (Not:C34($pictureFile.exists))
		$pictureFile:=File:C1566($folderFlags.path+"noFlag"+".png"; fk posix path:K87:1)
	End if 
	
	$path:=$pictureFile.path
	