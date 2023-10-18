//%attributes = {}
#DECLARE($fromCords : Object; $toCords : Object) : Integer

$p:=Pi:K30:1/180

$a:=Cos:C18(($toCords.latitude-$fromCords.latitude)*$p)/2
$b:=Cos:C18($fromCords.latitude*$p)*Cos:C18($toCords.latitude*$p)*(1-Cos:C18(($toCords.longitude-$fromCords.longitude)*$p))/2

$x:=Square root:C539(0.5-$a+$b)

$res:=12742*Arctan:C20($x/Square root:C539(1-($x*$x)))  // 2 * 6371 = 2 x earth radius
return Num:C11(Split string:C1554(String:C10($res); ",")[0])
