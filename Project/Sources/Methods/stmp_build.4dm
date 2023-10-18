//%attributes = {}

#DECLARE($date : Date; $time : Time)->$stmp : Integer

var $timeSeconds; $daySeconds : Integer

Case of 
	: (Count parameters:C259=0)
		$date:=Current date:C33
		$time:=Current time:C178
	: (Count parameters:C259=1)
		$time:=Current time:C178
End case 

$origineDate:=Add to date:C393(!00-00-00!; 2003; 1; 1)
$timeSeconds:=$time+0
$daySeconds:=($date-$origineDate)*86400

$stmp:=$daySeconds+$timeSeconds


//C_DATE($1)
//C_TIME($2)
//C_LONGINT($0)

//C_LONGINT($daysSeconds)
//C_LONGINT($timeSeconds)

//$date:=$1
//$time:=$2

//Case of 
//: (Count parameters=0)
//$date:=Current date
//$time:=Current time
//: (Count parameters=1)
//$time:=Current time
//End case 

//$origineDate:=Add to date(!00-00-00!; 2003; 1; 1)
//$timeSeconds:=$time+0
//$daysSeconds:=($date-$origineDate)*86400

//$0:=$daysSeconds+$timeSeconds
