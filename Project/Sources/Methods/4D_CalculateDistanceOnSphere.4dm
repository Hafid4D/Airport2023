
// ----------------------------------------------------
// Nom utilisateur (OS) : 4D
// Date et heure : 25/04/08, 14:52:56
// ----------------------------------------------------
// Méthode : 4D_CalculateDistanceOnSphere
// Description
// 
//
// Paramètres
// ----------------------------------------------------



//calculates the distance between two points on earth
//(or any other sphere, if a fifth parameter is given to define the radius)

//the parameters are the geographical positions of the points
//in DECIMAL DEGREES and the optional radius in any unit (result will depend on th


//the default value is 6371 kilometers and the result in kilometers too


//calcule la distance, en km, entre deux points terrestres dont les coordonnées
//XY sont données en paramètres, exprimés en degrés décimaux
//ex : g_calculateDistance(14,5;45,33;-12,15;18)

//  cos(angle) = sin(latitude1)sin(latitude2)…
//  …+cos(latitude1)cos(latitude2)cos(Longitude1-longitude2)

//SAMPLE : 
//4D_CalculateDistance (-50,81;10,35;40,98;-80,53{;6371})


C_REAL($1; $2; $3; $4; $0)
C_REAL($Latitude1; $Longitude1; $Latitude2; $Longitude2; $DeltaLongitude; $Radius)
C_LONGINT(zsMath)

If (Bool(zsMath=0))
	$Longitude1:=$1*Pi/180
	$Latitude1:=$2*Pi/180
	
	$Longitude2:=$3*Pi/180
	$Latitude2:=$4*Pi/180
	
	If (Count parameters=5)
		$Radius:=$5
	Else 
		$Radius:=6371  //6371 = earth radius (km)
	End if 
	
	$DeltaLongitude:=Abs($Longitude1-$Longitude2)
	If ($DeltaLongitude>Pi)
		$DeltaLongitude:=(2*Pi)-$DeltaLongitude
	End if 
	
	$Cos_x:=(Sin($Latitude1)*Sin($Latitude2))+(Cos($Latitude1)*Cos($Latitude2)*Cos($DeltaLongitude))  //-1 to 1
	If ($Cos_x>0)
		$x:=Arctan(((1-($Cos_x^2))^0.5)/$Cos_x)  //in radian
	Else 
		$x:=Pi-Abs(Arctan(((1-($Cos_x^2))^0.5)/$Cos_x))  //in radian
	End if 
	
	$Distance:=$Radius*$x
	$0:=Abs($distance)
	
Else 
	
	$0:=Math.spherodistance(New object("longitude1"; $1; "latitude1"; $2; "longitude2"; $3; "latitude2"; $4))
	Form.math_nb:=Num(Form.math_nb)+1
End if 