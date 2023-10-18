//%attributes = {}
#DECLARE($object : Object)

Case of 
	: (String:C10($object.action)="update")
		Form:C1466.query:=$object
		SHOW WINDOW:C435(Current form window:C827)
		BRING TO FRONT:C326(Current process:C322)
		
	: (String:C10($object.action)="hide")
		HIDE WINDOW:C436(Current form window:C827)
End case 