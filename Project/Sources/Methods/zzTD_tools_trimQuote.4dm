//%attributes = {}
#DECLARE($string : Text)->$result : Text

If (Substring:C12($string; 1; 1)="\"")
	$string:=Substring:C12($string; 2)
End if 
If (Substring:C12($string; Length:C16($string); 1)="\"")
	$string:=Substring:C12($string; 1; Length:C16($string)-1)
End if 
$result:=$string