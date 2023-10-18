

$graphe_marge_haute:=10
$graphe_marge_gauche:=10
$graphe_marge_droite:=150

$graphe_zone_hauteur:=500
$graphe_zone_largeur:=500

$graphe_zone_utile_largeur:=$graphe_zone_largeur-$graphe_marge_gauche-$graphe_marge_droite
$graphe_zone_utile_hauteur:=$graphe_zone_hauteur-$graphe_marge_haute

If ($graphe_zone_utile_largeur>$graphe_zone_utile_hauteur)
	$graphe_pie_radius:=($graphe_zone_utile_hauteur/2)*0.8
Else 
	$graphe_pie_radius:=($graphe_zone_utile_largeur/2)*0.8
End if 

$graphe_pie_center_x:=$graphe_pie_radius+$graphe_marge_gauche
$graphe_pie_center_y:=$graphe_pie_radius+$graphe_marge_haute

$nb_serie:=Form:C1466.series.length
$colors:=graphe_serie_color($nb_serie)

$zone_svg:=SVG_New

$decalage_ombrage:=5
SVG_New_circle($zone_svg; \
$graphe_pie_center_x+$decalage_ombrage; $graphe_pie_center_y+$decalage_ombrage; \
$graphe_pie_radius; "None"; SVG_Color_grey(60)+":70")

$nb_total:=Form:C1466.series.sum("value")
$start:=0
$graphe_gouttiere:=70
$i:=0
For each ($serie; Form:C1466.series)
	$i+=1
	$finish:=$start+(360*$serie.value/$nb_total)
	SVG_New_arc($zone_svg; $graphe_pie_center_x; $graphe_pie_center_y; $graphe_pie_radius; $start; $finish; "none"; $colors[$i-1]; 1)
	SVG_New_text($zone_svg; String:C10($serie.value/$nb_total*100; "###.0%"); $graphe_marge_gauche+($graphe_pie_radius*2)+$graphe_gouttiere-12; 18+(($i-1)*25); "Arial"; 12; 0; 4)
	SVG_New_rect($zone_svg; $graphe_marge_gauche+($graphe_pie_radius*2)+$graphe_gouttiere; 20+(($i-1)*25); 10; 10; 2; 2; "black"; $colors[$i-1]+":50"; 1)
	SVG_New_text($zone_svg; $serie.name+" : "+String:C10($serie.value; "### ##0"); $graphe_marge_gauche+($graphe_pie_radius*2)+$graphe_gouttiere+20; 18+(($i-1)*25); "Arial"; 12)
	$start:=$finish
End for each 
$i:=$i+1
SVG_New_text($zone_svg; "Total : "+String:C10($nb_total; "### ##0"); $graphe_marge_gauche+($graphe_pie_radius*2)+$graphe_gouttiere+20; 18+(($i-1)*25); "Arial"; 12)

$nom_du_degrade:="monDegrade"
SVG_Define_radial_gradient($zone_svg; $nom_du_degrade; "white:80"; SVG_Color_grey(30)+":30"; 50; 50; 50; 20; 20)
SVG_New_circle($zone_svg; $graphe_pie_center_x; $graphe_pie_center_y; $graphe_pie_radius; "none"; "url(#"+$nom_du_degrade+")")

$i:=$i+2
$titre:="Nombre d'aéroports par pays"
SVG_New_text($zone_svg; $titre; ($graphe_marge_gauche+$graphe_pie_radius)/2; 18+(($i-1)*25); "Arial"; 12)

Form:C1466.graphPicture:=SVG_Export_to_picture($zone_svg)