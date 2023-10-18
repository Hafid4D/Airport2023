//%attributes = {}
ARRAY LONGINT:C221($_value; 100)
For ($i; 1; 100)
	$_value{$i}:=(Random:C100%1200)-(Random:C100%1200)
End for 


//$firstValueOver1000:=0
//For ($i; 1; Size of array($_value))

//If ($_value{$i}>1000)
//$firstValueOver1000:=$i
//$i:=Size of array($_value)+1
//End if 
//End for 
//$i:=$firstValueOver1000


//For ($i; 1; Size of array($_value))

//If ($_value{$i}>1000)
//break
//End if 
//End for 


$positifTotal:=0
For ($i; 1; Size of array:C274($_value))
	If ($_value{$i}>0)
		$positifTotal+=$_value{$i}
		If ($_value{$i}>1000)
			$firstValueOver1000:=$i
			$i:=Size of array:C274($_value)+1
		End if 
	End if 
End for 
$i:=$firstValueOver1000



$positifTotal:=0
For ($i; 1; Size of array:C274($_value))
	If ($_value{$i}<=0)
		continue
	End if 
	$positifTotal+=$_value{$i}
	If ($_value{$i}>1000)
		break
	End if 
End for 
$i:=$firstValueOver1000

