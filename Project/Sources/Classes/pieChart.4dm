
property heightArea : Integer
property widthArea : Integer
property title : Text
property sizeTitle : Integer
property withLight : Boolean

Class constructor
	
	This:C1470.heightArea:=500
	This:C1470.widthArea:=500
	
	This:C1470._topMargin:=10
	This:C1470._topLeft:=10
	This:C1470._topRight:=150
	
	This:C1470._series:=New collection:C1472
	This:C1470._nbSeries:=0
	This:C1470.title:=""
	This:C1470.sizeTitle:=12
	This:C1470.withLight:=False:C215
	
Function drawGraph()->$picture : Picture
	
	
	This:C1470._widthGraphArea:=This:C1470.widthArea-This:C1470._topLeft-This:C1470._topRight
	This:C1470._heightGraphArea:=This:C1470.heightArea-This:C1470._topMargin
	
	If (This:C1470._widthGraphArea>This:C1470._heightGraphArea)
		This:C1470._radius:=(This:C1470._heightGraphArea/2)*0.8
	Else 
		This:C1470._radius:=(This:C1470._widthGraphArea/2)*0.8
	End if 
	
	This:C1470._center:=New object:C1471
	This:C1470._center.x:=This:C1470._radius+This:C1470._topLeft
	This:C1470._center.y:=This:C1470._radius+This:C1470._topMargin
	
	$colors:=This:C1470._loadShades(This:C1470._nbSeries)
	
	$zone_svg:=SVG_New
	
	$decalage_ombrage:=5
	SVG_New_circle($zone_svg; \
		This:C1470._center.x+$decalage_ombrage; This:C1470._center.y+$decalage_ombrage; \
		This:C1470._radius; "None"; SVG_Color_grey(60)+":70")
	
	$nb_total:=Form:C1466.series.sum("value")
	$start:=0
	$graphe_gouttiere:=70
	$i:=0
	For each ($serie; Form:C1466.series)
		$i+=1
		$finish:=$start+(360*$serie.value/$nb_total)
		SVG_New_arc($zone_svg; This:C1470._center.x; This:C1470._center.y; This:C1470._radius; $start; $finish; "none"; $colors[$i-1]; 1)
		SVG_New_text($zone_svg; String:C10($serie.value/$nb_total*100; "###.0%"); This:C1470._topLeft+(This:C1470._radius*2)+$graphe_gouttiere-12; 18+(($i-1)*25); "Arial"; 12; 0; 4)
		SVG_New_rect($zone_svg; This:C1470._topLeft+(This:C1470._radius*2)+$graphe_gouttiere; 20+(($i-1)*25); 10; 10; 2; 2; "black"; $colors[$i-1]+":50"; 1)
		SVG_New_text($zone_svg; $serie.name+" : "+String:C10($serie.value; "### ##0"); This:C1470._topLeft+(This:C1470._radius*2)+$graphe_gouttiere+20; 18+(($i-1)*25); "Arial"; 12)
		$start:=$finish
	End for each 
	$i:=$i+1
	SVG_New_text($zone_svg; "Total : "+String:C10($nb_total; "### ##0"); This:C1470._topLeft+(This:C1470._radius*2)+$graphe_gouttiere+20; 18+(($i-1)*25); "Arial"; 12)
	
	If (This:C1470.withLight)
		$nom_du_degrade:="monDegrade"
		SVG_Define_radial_gradient($zone_svg; $nom_du_degrade; "white:80"; SVG_Color_grey(30)+":30"; 50; 50; 50; 20; 20)
		SVG_New_circle($zone_svg; This:C1470._center.x; This:C1470._center.y; This:C1470._radius; "none"; "url(#"+$nom_du_degrade+")")
	End if 
	
	If (This:C1470.title#"")
		$i:=$i+2
		SVG_New_text($zone_svg; This:C1470.title; (This:C1470._topLeft+This:C1470._radius)/2; (This:C1470._topMargin+This:C1470._radius)*2; "Arial"; This:C1470.sizeTitle)
	End if 
	
	$picture:=SVG_Export_to_picture($zone_svg)
	
	
	//MARK:-managment of data
	
Function set values($data : Collection)
	
	This:C1470._series:=$data
	This:C1470._nbSeries:=This:C1470._series.length
	
Function get values()->$data : Collection
	
	$data:=This:C1470._series
	
	//MARK:-managment of colors
	
Function _loadShades()->$colors : Collection
	
	$max:=This:C1470._nbSeries
	$colors:=Split string:C1554("darkred;red;orangered;darkgreen;green;olive;darkorange;orange;gold;yellow;saddiebrown"; ";")
	$nb:=($max\$colors.length)+1
	For ($i; 2; $nb)
		$colors:=$colors.combine($colors)
	End for 
	