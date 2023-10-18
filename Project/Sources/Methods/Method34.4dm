//%attributes = {}
$airline:=ds:C1482.Airline.query("name = :1"; "interjet@")
USE ENTITY SELECTION:C1513($airline)

$slots:=$airline.slots
USE ENTITY SELECTION:C1513($slots)

$flight:=$slots.flights
USE ENTITY SELECTION:C1513($flight)

