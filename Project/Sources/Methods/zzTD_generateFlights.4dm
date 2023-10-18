//%attributes = {}
var $line : cs:C1710.LineEntity
var $flight : cs:C1710.FlightEntity
$nb:=0
$NbLine:=0

For each ($line; ds:C1482.Line.query("nbOfFlights = 0"))
	If (Undefined:C82($line.fromAirport)=False:C215) && (Undefined:C82($line.toAirport)=False:C215)
		$routes:=ds:C1482.Routes.query("Source_airport = :1 & Destination_airport = :2 & Codeshare # \"Y\""; $line.fromAirport.codeIATA; $line.toAirport.codeIATA)
		For each ($route; $routes)
			
			$airlines:=ds:C1482.Airline.query("designator = :1"; $route.Airline)
			If ($airlines.length=0)
				break
			Else 
				$uuidAirline:=$airlines.first().UUID
			End if 
			
			$aircrafts:=Split string:C1554($route.Equipment; " ")
			If ($aircrafts.length=0)
				break
			End if 
			$aircrafts:=ds:C1482.Aircraft.query("IATA = :1"; $aircrafts[Random:C100%$aircrafts.length])
			If ($aircrafts.length=0)
				break
			End if 
			
			$uuidAircraft:=$aircrafts.first().UUID
			
			
			For ($x; 1; $line.rotationPerDay; 1)
				$flight:=ds:C1482.Flight.new()
				$flight.UUID_Line:=$line.UUID
				$flight.flightDuration:=Time:C179($line.flightDuration+600)
				$flight.UUID_Airline:=$uuidAirline
				$flight.UUID_Aircraft:=$uuidAircraft
				
				$isNight:=False:C215
				$chanceNight:=$line.rotationPerDay=5 ? 100 : $line.rotationPerDay-1*11
				If (Random:C100%100+1>=$chanceNight) & ($x=1)
					$isNight:=True:C214
				End if 
				
				$start:=$isNight=True:C214 ? (?21:00:00?+0) : (?05:00:00?+0)  // 21 : 5
				$range:=$isNight=True:C214 ? (?06:00:00?+0) : (?16:00:00?+0)  // 6 : 16
				
				$seed:=((Random:C100*Random:C100)%86400)\60*60
				$timeSecond:=($start+($seed%$range))%86400
				$flight.takeOffTime:=Time:C179($timeSecond)
				
				
				$ok:=False:C215
				While ($ok#True:C214)
					If (zzTD_isTimeSlotFree($flight; True:C214)=True:C214)
						
						$time:=Time:C179($flight.takeOffTime+$flight.flightDuration)
						$flight.landingTime:=$time>=86400 ? Time:C179($time-86400) : $time
						$okArrival:=False:C215
						
						While ($okArrival#True:C214)
							
							If (zzTD_isTimeSlotFree($flight; False:C215)=True:C214)
								$okArrival:=True:C214
							Else 
								$time:=Time:C179($flight.landingTime+60)
								$flight.flightDuration:=Time:C179($flight.flightDuration+60)
								$flight.landingTime:=$time>=86400 ? Time:C179($time-86400) : $time
							End if 
							
						End while 
						$ok:=True:C214
					Else 
						$time:=Time:C179($flight.takeOffTime+60)
						$flight.takeOffTime:=$time>=86400 ? Time:C179($time-86400) : $time
					End if 
				End while 
				
				
				// day of the week
				$obj:=New object:C1471()
				$obj["1"]:=(Random:C100%10=0 ? False:C215 : True:C214)
				$obj["2"]:=(Random:C100%10=0 ? False:C215 : True:C214)
				$obj["3"]:=(Random:C100%10=0 ? False:C215 : True:C214)
				$obj["4"]:=(Random:C100%10=0 ? False:C215 : True:C214)
				$obj["5"]:=(Random:C100%10=0 ? False:C215 : True:C214)
				$obj["6"]:=(Random:C100%10=0 ? False:C215 : True:C214)
				$obj["7"]:=(Random:C100%10=0 ? False:C215 : True:C214)
				
				$flight.daysOfWeek:=$obj
				
				$flight.save()
				$nb:=$nb+1
			End for 
			
		End for each 
	End if 
	$NbLine:=$NbLine+1
End for each 