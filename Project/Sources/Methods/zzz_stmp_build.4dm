//%attributes = {}
// stmp_build (date : date ; time : time ) -> Integer
C_DATE:C307($1)
C_TIME:C306($2)
C_LONGINT:C283($0)

C_LONGINT:C283($heure_en_seconde; $jours_en_seconde)

$date:=$1
$heure:=$2


Case of 
	: (Count parameters:C259=0)
		$date:=Current date:C33
		$heure:=Current time:C178
	: (Count parameters:C259=1)
		$heure:=Current time:C178
End case 

$date_reference:=Add to date:C393(!00-00-00!; 2003; 1; 1)
$heure_en_seconde:=$heure+0
$jours_en_seconde:=($date-$date_reference)*86400

$0:=$jours_en_seconde+$heure_en_seconde
