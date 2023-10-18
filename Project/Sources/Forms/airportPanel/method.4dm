Case of 
	: (Form event code:C388=On Load:K2:1)
		SET TIMER:C645(60)
		
	: (FORM Event:C1606.code=On Bound Variable Change:K2:52)
		
		If (Form:C1466.Airport#Null:C1517)
			$currentDate:=String:C10(Current date:C33; ISO date GMT:K1:10; Current time:C178)
			$currentTime:=Num:C11(Time:C179(Substring:C12($currentDate; 12; 8)))
			
			Form:C1466.time:=Time string:C180(Time:C179($currentTime+(Num:C11(Form:C1466.Airport.localTime)*3600)))
			
			$pictOn:="/RESOURCES/image/button/on-button.png"
			$pictOff:="/RESOURCES/image/button/off-button.png"
			
			
			$btnFormat:="1;1;path:"+(Form:C1466.Airport.international ? $pictOn : $pictOff)+";0;0"
			OBJECT SET FORMAT:C236(*; "btnIntl"; $btnFormat)
			
			$btnFormat:="1;1;path:"+(Form:C1466.Airport.intlHub ? $pictOn : $pictOff)+";0;0"
			OBJECT SET FORMAT:C236(*; "btnIntlHub"; $btnFormat)
			
			$btnFormat:="1;1;path:"+(Form:C1466.Airport.domestic ? $pictOn : $pictOff)+";0;0"
			OBJECT SET FORMAT:C236(*; "btnDomestic"; $btnFormat)
			
			
			$folder:=Folder:C1567(fk resources folder:K87:11).folder("map")
			$file:=$folder.file("google_map.html")
			$blob_input:=$file.getContent()
			$html_input:=Convert to text:C1012($blob_input; "UTF-8")
			
			
			$markers:=New collection:C1472
			$marker:=New object:C1471
			$marker.Latitude:=Form:C1466.Airport.geometry.latitude
			$marker.Longitude:=Form:C1466.Airport.geometry.longitude
			$markers.push($marker)
			
			$options:=New object:C1471
			$options.Latitude:=Form:C1466.Airport.geometry.latitude
			$options.Longitude:=Form:C1466.Airport.geometry.longitude
			
			PROCESS 4D TAGS:C816($html_input; $html_output; JSON Stringify:C1217($markers); JSON Stringify:C1217($options); "AIzaSyC089mUWgsq1So_Fw_FVjkXFPIr1iSRP84")
			
			WA SET PAGE CONTENT:C1037(*; "mapAirport"; $html_output; "")
			
		End if 
		
	: (Form event code:C388=On Timer:K2:25)
		If (Form:C1466.Airport#Null:C1517)
			$currentDate:=String:C10(Current date:C33; ISO date GMT:K1:10; Current time:C178)
			$currentTime:=Num:C11(Time:C179(Substring:C12($currentDate; 12; 8)))
			
			Form:C1466.time:=Time string:C180(Time:C179($currentTime+(Num:C11(Form:C1466.Airport.localTime)*3600)))
		End if 
End case 