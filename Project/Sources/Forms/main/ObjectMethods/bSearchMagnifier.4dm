
$refMenus:=New collection:C1472()

$mainLevel:=Create menu:C408()
$refMenus.push($mainLevel)

$tagMenu:=Create menu:C408()
$refMenus.push($tagMenu)

$tags:=New collection:C1472()
For each ($field; Form:C1466.entry.searchField)
	If ($field.tag#Null:C1517)
		$tags.push($field.tag)
	End if 
	If ($field.tags#Null:C1517)
		$tags:=$tags.combine($field.tags)
	End if 
End for each 
$tags:=$tags.distinct()
For each ($tag; $tags)
	APPEND MENU ITEM:C411($tagMenu; $tag; *)
	SET MENU ITEM PARAMETER:C1004($tagMenu; -1; "tag:"+$tag)
End for each 
APPEND MENU ITEM:C411($mainLevel; "tags"; $tagMenu)

$indices:=Form:C1466.entry.searchField.indices("type = :1"; Is time:K8:8)
If ($indices.length>0)
	$periodsMenu:=Create menu:C408()
	$refMenus.push($periodsMenu)
	$periods:=Split string:C1554("day;sunrise;dawn;morning;noon;midday;afternoon;evening;sunset;dusk;night;midnight;aftermidnight;now"; ";").orderBy()
	For each ($period; $periods)
		APPEND MENU ITEM:C411($periodsMenu; $period; *)
		SET MENU ITEM PARAMETER:C1004($periodsMenu; -1; "period:"+$period)
	End for each 
	APPEND MENU ITEM:C411($mainLevel; "periods of the day"; $periodsMenu)
End if 

$indices:=Form:C1466.entry.searchField.indices("type = :1"; Is date:K8:7)
If ($indices.length>0)
	$dateMenu:=Create menu:C408()
	$refMenus.push($dateMenu)
	$dates:=Split string:C1554("today;tomorrow;yesterday;7lastdays;7nextdays;thisWeek;lastWeek;nextWeek;thisMonth;lastMonth;nextMonth;thisYear;lastYear;nextYear"; ";").orderBy()
	For each ($date; $dates)
		APPEND MENU ITEM:C411($dateMenu; $date; *)
		SET MENU ITEM PARAMETER:C1004($dateMenu; -1; "date:"+$date)
	End for each 
	APPEND MENU ITEM:C411($mainLevel; "dates"; $dateMenu)
End if 

$choose:=Dynamic pop up menu:C1006($mainLevel)
For each ($refMenu; $refMenus)
	RELEASE MENU:C978($refMenu)
End for each 

Case of 
	: ($choose="tag:@")
		$tag:=Substring:C12($choose; 5)+":"
		GET HIGHLIGHT:C209(*; "searchbox"; $startSel; $endSel)
		Form:C1466.searchbox:=Substring:C12(Form:C1466.searchbox; 1; $startSel-1)+$tag+Substring:C12(Form:C1466.searchbox; $endSel)
		HIGHLIGHT TEXT:C210(*; "searchbox"; $startSel+Length:C16($tag); $startSel+Length:C16($tag))
		main_load_lb_items
		
	: ($choose="period:@")
		$period:=Substring:C12($choose; 8)
		GET HIGHLIGHT:C209(*; "searchbox"; $startSel; $endSel)
		Form:C1466.searchbox:=Substring:C12(Form:C1466.searchbox; 1; $startSel-1)+$period+Substring:C12(Form:C1466.searchbox; $endSel)
		HIGHLIGHT TEXT:C210(*; "searchbox"; $startSel+Length:C16($period); $startSel+Length:C16($period))
		main_load_lb_items
		
	: ($choose="date:@")
		$date:=Substring:C12($choose; 6)
		GET HIGHLIGHT:C209(*; "searchbox"; $startSel; $endSel)
		Form:C1466.searchbox:=Substring:C12(Form:C1466.searchbox; 1; $startSel-1)+$date+Substring:C12(Form:C1466.searchbox; $endSel)
		HIGHLIGHT TEXT:C210(*; "searchbox"; $startSel+Length:C16($date); $startSel+Length:C16($date))
		main_load_lb_items
		
End case 
