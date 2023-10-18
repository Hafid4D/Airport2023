//%attributes = {}
#DECLARE($slot : cs:C1710.SlotEntity; $from : Boolean) : Boolean

$airport:=$from=True:C214 ? $slot.line.fromAirport : $slot.line.toAirport
$time:=$from=True:C214 ? $slot.takeOffTime : $slot.landingTime

$airportSlots:=ds:C1482.Slot.all().query("fromAirport.UUID = :1 || toAirport.UUID = :1"; $airport.UUID)


If ($airportSlots.length#0)
	$flightsTimeSlot:=$airportSlots.query("takeOffTime = :1 || landingTime = :1"; Time:C179($time))
Else 
	return True:C214
End if 



return $flightsTimeSlot.length>$airport.maxMovement ? False:C215 : True:C214