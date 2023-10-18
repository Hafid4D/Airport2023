//%attributes = {}
#DECLARE($realVal : Real)->$result : Text

var $rest : Real
var $degrees : Integer
var $minutes : Integer
var $seconds : Real

$degrees:=Int:C8($realVal)
$rest:=$realVal-$degrees

$minutes:=Int:C8($rest*60)
$rest-=($minutes/60)

$seconds:=Round:C94($rest*60*60; 2)
If ($seconds=60)  // because of the numeric precision
	$minutes+=1
	$seconds:=0
End if 
If ($minutes>=60)
	$degrees+=($minutes-59)
	$minutes:=0
End if 
$result:=String:C10(Int:C8($degrees))+"°"
$result+=String:C10($minutes; "00")+"’"
$result+=String:C10($seconds; "00.00")+"’'"
