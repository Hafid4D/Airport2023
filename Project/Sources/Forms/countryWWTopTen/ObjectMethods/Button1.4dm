If (1=1)
	var $pieChart : cs:C1710.pieChart
	
	$pieChart:=cs:C1710.pieChart.new()
	
	OBJECT GET COORDINATES:C663(*; "graphPicture"; $left; $top; $right; $bottom)
	$pieChart.heightArea:=$bottom-$top
	$pieChart.widthArea:=$right-$left
	
	$pieChart.values:=Form:C1466.series
	
	$pieChart.title:="Top ten des pays par nombre d'aéroports"
	$pieChart.sizeTitle:=18
	$pieChart.withLight:=True:C214
	
	Form:C1466.graphPicture:=$pieChart.drawGraph()
	
Else 
	
	
End if 