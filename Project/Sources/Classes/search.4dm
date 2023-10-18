Class constructor
	
	This:C1470.searchbox:=""
	This:C1470.queryString:=""
	This:C1470.querySettings:=New object:C1471()
	This:C1470.querySettings.parameters:=New object:C1471()
	This:C1470.querySettings.attributes:=New object:C1471()
	This:C1470.querySettings.queryPlan:=False:C215
	This:C1470.querySettings.queryPath:=False:C215
	This:C1470.queryPlan:=""
	This:C1470.queryPath:=""
	
	
Function _all()->$entitySelection : 4D:C1709.EntitySelection
	
	$entitySelection:=ds:C1482[This:C1470.entry.dataclass.name].all()
	If (Form:C1466.entry.orderByDefault#Null:C1517)
		$entitySelection:=$entitySelection.orderBy(Form:C1466.entry.orderByDefault)
	End if 
	
Function _query()->$entitySelection : 4D:C1709.EntitySelection
	
	This:C1470._splitSearchboxInParts()
	This:C1470._buildQueryString()
	
	If (This:C1470.queryString="")  //in case of the analyze return a empty string
		$entitySelection:=This:C1470._all()
	Else 
		$entitySelection:=ds:C1482[This:C1470.entry.dataclass.name].query(This:C1470.queryString; This:C1470.querySettings)
	End if 
	If (This:C1470.querySettings.queryPlan)
		This:C1470.queryPlan:=$entitySelection.queryPlan
	End if 
	
	If (This:C1470.querySettings.queryPath)
		This:C1470.queryPath:=$entitySelection.queryPath
	End if 
	
Function perform($entry : Object; $rawSearchbox : Text)->$entitySelection : 4D:C1709.EntitySelection
	
	This:C1470.entry:=$entry
	This:C1470.searchbox:=$rawSearchbox
	
	This:C1470._cleanSearchbox()
	If (This:C1470.searchbox="")
		$entitySelection:=This:C1470._all()
	Else 
		$entitySelection:=This:C1470._query()
	End if 
	
	
Function _cleanSearchbox()  //to remove useless spaces in content of the searchbox 
	
	This:C1470.searchbox:=Split string:C1554(This:C1470.searchbox; " ").join(" "; ck ignore null or empty:K85:5)
	
	
	
Function _splitSearchboxInParts()
	
	var $rawSearchbox : Text  //the contents of the search box ready to be eaten character by character
	var $currentValue : Text  //the currentPart build char by char
	var $char : Text  //the current char to analyze
	var $positionNext : Integer  //where is the next char to be process
	
	This:C1470.queryParts:=New collection:C1472
	This:C1470.querySettings.queryPlan:=False:C215
	This:C1470.querySettings.queryPath:=False:C215
	
	$rawSearchbox:=This:C1470.searchbox
	$currentValue:=""
	$inDoubleQuotes:=False:C215
	This:C1470.tagToAdd:=""
	This:C1470.notToAdd:=False:C215
	While ($rawSearchbox#"")
		$char:=$rawSearchbox[[1]]
		$positionNext:=2
		Case of 
			: ($rawSearchbox="$plan@")
				This:C1470._pushCurrentValueInParts($currentValue)
				$currentValue:=""
				$positionNext:=6
				This:C1470.querySettings.queryPlan:=True:C214
				
			: ($rawSearchbox="$path@")
				This:C1470._pushCurrentValueInParts($currentValue)
				$currentValue:=""
				$positionNext:=6
				This:C1470.querySettings.queryPath:=True:C214
				
			: ($rawSearchbox="AND @") || ($rawSearchbox="AND(@")
				If (This:C1470.queryParts.length=0)
					This:C1470._pushCurrentValueInParts("and")
					$currentValue:=""
				Else 
					$part:=New object:C1471
					$part.type:="operator"
					$part.value:="AND"
					This:C1470.queryParts.push($part)
				End if 
				$positionNext:=($rawSearchbox="AND @") ? 5 : 4
				
			: ($rawSearchbox="OR @") || ($rawSearchbox="OR(@")
				If (This:C1470.queryParts.length=0)
					This:C1470._pushCurrentValueInParts("or")
					$currentValue:=""
				Else 
					$part:=New object:C1471
					$part.type:="operator"
					$part.value:="OR"
					This:C1470.queryParts.push($part)
				End if 
				$positionNext:=($rawSearchbox="OR @") ? 4 : 3
				
			: ($char="-") & ($currentValue="")
				This:C1470.notToAdd:=True:C214
				
			: (($char="(") || ($char=")")) & Not:C34($inDoubleQuotes)
				This:C1470._pushCurrentValueInParts($currentValue)
				$currentValue:=""
				$part:=New object:C1471
				$part.type:="parenthesis"
				$part.value:=$char
				This:C1470.queryParts.push($part)
				
			: ($char="\"")
				This:C1470._pushCurrentValueInParts($currentValue)
				$currentValue:=""
				$inDoubleQuotes:=Not:C34($inDoubleQuotes)
				
			: ($char=" ") & Not:C34($inDoubleQuotes)
				This:C1470._pushCurrentValueInParts($currentValue)
				$currentValue:=""
				
			: ($char=":") & Not:C34($inDoubleQuotes)
				$potentialTag:=$currentValue
				$indices:=Form:C1466.entry.searchField.indices("tag = :1 or tags[] = :1"; $potentialTag)
				If ($indices.length>0)
					This:C1470.tagToAdd:=$potentialTag
					$currentValue:=""
				Else 
					$currentValue+=$char
				End if 
				
			Else 
				$currentValue+=$char
		End case 
		$rawSearchbox:=Substring:C12($rawSearchbox; $positionNext)
	End while 
	This:C1470._pushCurrentValueInParts($currentValue)
	This:C1470._completeImpliciteOperator()
	
Function _pushCurrentValueInParts($currentValue : Text)
	
	var $part : 4D:C1709.Object
	
	$part:=(This:C1470.notToAdd) ? New object:C1471("not"; True:C214) : New object:C1471
	
	Case of 
		: ($currentValue="")
		: (This:C1470.tagToAdd#"")
			$part.type:="value"
			$part.tag:=This:C1470.tagToAdd
			$part.value:=$currentValue
			This:C1470.queryParts.push($part)
			This:C1470.tagToAdd:=""
		Else 
			$part.type:="value"
			$part.value:=$currentValue
			This:C1470.queryParts.push($part)
	End case 
	
Function _completeImpliciteOperator()
	var $previousPart : Object
	
	$queryPartsIN:=This:C1470.queryParts
	This:C1470.queryParts:=New collection:C1472
	$previousPart:=Null:C1517
	$nbParentheses:=0
	For each ($part; $queryPartsIN)
		Case of 
			: ($previousPart.type="value") & ($part.type="value")
				This:C1470._pushANDOperator()
				
			: ($previousPart.type="parenthesis") & ($previousPart.value=")") & ($part.type="value")
				This:C1470._pushANDOperator()
				
			: ($previousPart.type="parenthesis") & ($previousPart.value=")") & ($part.type="parenthesis") & ($part.value="(")
				This:C1470._pushANDOperator()
				$nbParentheses+=1
				
			: ($part.type="parenthesis") & ($part.value="(")
				$nbParentheses+=1
				
			: ($part.type="parenthesis") & ($part.value=")")
				$nbParentheses-=1
				
		End case 
		This:C1470.queryParts.push($part)
		$previousPart:=$part
	End for each 
	
	Case of 
		: ($nbParentheses>0)
			For ($i; $nbParentheses; 0; -1)
				$parenthesisPart:=New object:C1471
				$parenthesisPart.type:="parenthesis"
				$parenthesisPart.value:=")"
				This:C1470.queryParts.push($parenthesisPart)
			End for 
			
		: ($nbParentheses<0)
			For ($i; $nbParentheses; 0)
				$parenthesisPart:=New object:C1471
				$parenthesisPart.type:="parenthesis"
				$parenthesisPart.value:="("
				This:C1470.queryParts.unshift($parenthesisPart)
			End for 
			
	End case 
	
Function _pushANDOperator()
	
	$operatorPart:=New object:C1471
	$operatorPart.type:="operator"
	$operatorPart.value:="AND"
	This:C1470.queryParts.push($operatorPart)
	
	
Function _buildQueryString()
	
	var $partIndice : Integer
	var $subQueryStringPart : Text
	var $subQueryStringParts : Collection
	var $part : Object
	var $valueToSearch : Variant
	var $field : Object
	var $parameterName : Text
	
	This:C1470.queryStringParts:=New collection:C1472
	
	$partIndice:=1
	For each ($part; This:C1470.queryParts)
		
		Case of 
			: ($part.type="value")
				$subQueryStringParts:=New collection:C1472()
				$partIndice+=0
				Case of 
					: ($part.tag#Null:C1517)
						$searchFields:=Form:C1466.entry.searchField.query("tag = :1 or tags[] = :1"; $part.tag)
					Else 
						$searchFields:=Form:C1466.entry.searchField.query("onlyWithTag = false or onlyWithTag = null")
				End case 
				For each ($field; $searchFields)
					$subQueryStringPart:=""
					If ($field.type#Null:C1517)
						$valueToSearch:=This:C1470._constructSearchValue($part.value; $field.type)
					Else 
						$valueToSearch:=This:C1470._constructSearchValue($part.value)
					End if 
					Case of 
						: (Value type:C1509($valueToSearch)=Is collection:K8:32)
							$operator:=$valueToSearch.shift()
							Case of 
								: ($operator="between")
									If ($field.placeHolder#Null:C1517)
										$i:=0
										While ($valueToSearch.length>=2)
											$i+=1
											$parameterName:=$field.placeHolder+String:C10($partIndice)+"_"+String:C10($i)
											$subQueryStringPart+=($subQueryStringPart="") ? "( " : " OR ("
											$subQueryStringPart+=$field.path+" >= :"+$parameterName
											This:C1470.querySettings.parameters[$parameterName]:=$valueToSearch.shift()
											$i+=1
											$parameterName:=$field.placeHolder+String:C10($partIndice)+"_"+String:C10($i)
											$subQueryStringPart+=" and "+$field.path+" <= :"+$parameterName+" )"
											This:C1470.querySettings.parameters[$parameterName]:=$valueToSearch.shift()
										End while 
									Else 
										$i:=0
										While ($valueToSearch.length>=2)
											$i+=1
											$parameterName:=$field.attribute+String:C10($partIndice)+"_"+String:C10($i)
											$subQueryStringPart+=($subQueryStringPart="") ? "( " : " OR ("
											$subQueryStringPart+=$field.attribute+" >= :"+$parameterName
											This:C1470.querySettings.parameters[$parameterName]:=$valueToSearch.shift()
											$i+=1
											$parameterName:=$field.attribute+String:C10($partIndice)+"_"+String:C10($i)
											$subQueryStringPart+=" and "+$field.attribute+" <= :"+$parameterName+" )"
											This:C1470.querySettings.parameters[$parameterName]:=$valueToSearch.shift()
										End while 
									End if 
									
								: ($operator="in")
									If ($field.placeHolder#Null:C1517)
										$parameterName:=$field.placeHolder+String:C10($partIndice)
										$subQueryStringPart+=$field.path+" in :"+$parameterName
										This:C1470.querySettings.parameters[$parameterName]:=$valueToSearch
									Else 
										$parameterName:=$field.attribute+String:C10($partIndice)
										$subQueryStringPart+=$field.attribute+" in :"+$parameterName
										This:C1470.querySettings.parameters[$parameterName]:=$valueToSearch
									End if 
							End case 
						Else 
							If ($field.placeHolder#Null:C1517)
								$parameterName:=$field.placeHolder+String:C10($partIndice)
								$subQueryStringPart+=$field.path+" = :"+$parameterName
								This:C1470.querySettings.parameters[$parameterName]:=$valueToSearch
							Else 
								$parameterName:=$field.attribute+String:C10($partIndice)
								$subQueryStringPart+=$field.attribute+" = :"+$parameterName
								This:C1470.querySettings.parameters[$parameterName]:=$valueToSearch
							End if 
					End case 
					$subQueryStringParts.push($subQueryStringPart)
				End for each 
				If (Bool:C1537($part.not))
					This:C1470.queryStringParts.push("not("+$subQueryStringParts.join(" OR ")+")")
				Else 
					This:C1470.queryStringParts.push("("+$subQueryStringParts.join(" OR ")+")")
				End if 
				
			: ($part.type="operator")
				This:C1470.queryStringParts.push($part.value)
				
			: ($part.type="parenthesis")
				This:C1470.queryStringParts.push($part.value)
				
		End case 
		
	End for each 
	
	This:C1470.queryString:=This:C1470.queryStringParts.join(" ")
	If (Form:C1466.entry.orderByDefault#Null:C1517)
		This:C1470.queryString+=" order by "+Form:C1466.entry.orderByDefault
	End if 
	
	
Function _constructSearchValue($value : Text; $type : Integer)->$valueToSearch : Variant
	
	$typeOfValue:=(Num:C11($type)=0) ? Is text:K8:3 : $type
	Case of 
		: ($typeOfValue=Is text:K8:3)
			Case of 
				: (Position:C15(";"; $value)>0)
					$valueToSearch:=New collection:C1472("in")
					For each ($valueToPush; Split string:C1554($value; ";"))
						Case of 
							: (Position:C15("@"; $valueToPush; *)>0)
								$valueToSearch.push($valueToPush)
							Else 
								$valueToSearch.push("@"+$valueToPush+"@")
						End case 
					End for each 
				: (Position:C15("@"; $value; *)>0)
					$valueToSearch:=$value
				Else 
					$valueToSearch:="@"+$value+"@"
			End case 
			
		: ($typeOfValue=Is time:K8:8)
			Case of 
				: ($value="day")
					$valueToSearch:=New collection:C1472("between"; ?07:00:00?; ?19:00:00?)
				: ($value="sunrise") | ($value="dawn")
					$valueToSearch:=New collection:C1472("between"; ?05:00:00?; ?07:00:00?)
				: ($value="morning")
					$valueToSearch:=New collection:C1472("between"; ?07:00:00?; ?12:00:00?)
				: ($value="noon") | ($value="midday")
					$valueToSearch:=New collection:C1472("between"; ?11:30:00?; ?13:30:00?)
				: ($value="afternoon")
					$valueToSearch:=New collection:C1472("between"; ?13:00:00?; ?18:00:00?)
				: ($value="evening")
					$valueToSearch:=New collection:C1472("between"; ?18:00:00?; ?22:00:00?)
				: ($value="sunset") | ($value="dusk")
					$valueToSearch:=New collection:C1472("between"; ?20:00:00?; ?22:30:00?)
				: ($value="night")
					$valueToSearch:=New collection:C1472("between"; ?22:00:00?; ?23:59:59?; ?00:00:00?; ?05:00:00?)
				: ($value="midnight")
					$valueToSearch:=New collection:C1472("between"; ?23:30:00?; ?23:59:59?; ?00:00:00?; ?00:30:00?)
				: ($value="aftermidnight")
					$valueToSearch:=New collection:C1472("between"; ?00:00:00?; ?05:00:00?)
				: ($value="now")
					$valueToSearch:=New collection:C1472("between"; Current time:C178-?00:05:00?; Current time:C178+?00:05:00?)
				: (Position:C15("-"; $value)>1)  // Not the first char
					$timesInString:=Split string:C1554($value; "-")
					If ($timesInString.length=2)
						$valueToSearch:=New collection:C1472("between")
						For each ($timeInString; $timesInString)
							$valueToSearch.push(Time:C179($timeInString))
						End for each 
					End if 
				: ($value="@:")
					$valueToSearch:=New collection:C1472("between")
					$length:=8-Length:C16(Replace string:C233(String:C10(Time:C179($value)); $value; ""))
					Case of 
						: ($length=3)
							$valueToSearch.push(Time:C179($value); Time:C179($value)+3540)
						: ($length=6)
							$valueToSearch.push(Time:C179($value); Time:C179($value)+59)
						Else 
							$valueToSearch:=Time:C179($value)
					End case 
				Else 
					$valueToSearch:=Time:C179($value)
			End case 
			
		: ($typeOfValue=Is date:K8:7)
			Case of 
				: ($value="today")
					$valueToSearch:=Current date:C33
				: ($value="tomorrow")
					$valueToSearch:=Current date:C33+1
				: ($value="yesterday")
					$valueToSearch:=Current date:C33-1
				: ($value="7lastdays")
					$valueToSearch:=New collection:C1472("between"; Current date:C33-7; Current date:C33-1)
				: ($value="7nextdays")
					$valueToSearch:=New collection:C1472("between"; Current date:C33+1; Current date:C33+7)
				: ($value="thisWeek") || ($value="lastWeek") || ($value="nextWeek")
					$numberOfDay:=Day number:C114(Current date:C33)-1
					$numberOfDay:=(($numberOfDay=0) ? 7 : $numberOfDay)+(7*Num:C11($value="lastWeek"))-(7*Num:C11($value="nextWeek"))
					$valueToSearch:=New collection:C1472("between"; Current date:C33-$numberOfDay+1; Current date:C33-$numberOfDay+7)
				: ($value="thisMonth") || ($value="lastMonth") || ($value="nextMonth")
					$month:=Month of:C24(Current date:C33)-Num:C11($value="lastMonth")+Num:C11($value="nextMonth")
					$year:=Year of:C25(Current date:C33)
					$valueToSearch:=New collection:C1472("between"; Add to date:C393(!00-00-00!; $year; $month; 1); Add to date:C393(!00-00-00!; $year; $month+1; 1)-1)
				: ($value="thisYear") || ($value="lastYear") || ($value="nextYear")
					$year:=Year of:C25(Current date:C33)-Num:C11($value="lastYear")+Num:C11($value="nextYear")
					$valueToSearch:=New collection:C1472("between"; Add to date:C393(!00-00-00!; $year; 1; 1); Add to date:C393(!00-00-00!; $year; 12; 31))
				Else 
					$valueToSearch:=Date:C102($value)
			End case 
			
	End case 