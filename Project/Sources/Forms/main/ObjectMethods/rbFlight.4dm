Form:C1466.entry:={dataclass: cs:C1710.Flight; lb_columns: []; panel: "flightPanel"}

Form:C1466.entry.lb_columns.push({header: "Date"; attribute: "date"; width: 75; type: Is date:K8:7; format: Internal date short:K1:7})
Form:C1466.entry.lb_columns.push({header: "IATA"; attribute: "fromAirport.IATA_airportCode"; width: 35})
Form:C1466.entry.lb_columns.push({header: "From"; attribute: "fromAirport.city"; width: 100})
Form:C1466.entry.lb_columns.push({header: "IATA"; attribute: "toAirport.IATA_airportCode"; width: 35})
Form:C1466.entry.lb_columns.push({header: "To"; attribute: "toAirport.city"; width: 100})
Form:C1466.entry.lb_columns.push({header: "Flight"; attribute: "slot.flightNumber"; width: 70})
Form:C1466.entry.lb_columns.push({header: "Dep."; attribute: "takeOffTime"; type: Is time:K8:8; format: HH MM:K7:2; width: 50; hAlign: Align center:K42:3})
Form:C1466.entry.lb_columns.push({header: "Arr."; attribute: "landingTime"; type: Is time:K8:8; format: HH MM:K7:2; width: 50; hAlign: Align center:K42:3})

Form:C1466.entry.searchField:=[]

Form:C1466.entry.searchField.push({attribute: "date"; type: Is date:K8:7; tags: ["date"; "takeOffDate"]})
//Form.entry.searchField.push({path: "slot.takeOffTime"; type: Is time; placeHolder: "takeOffTime"; tags: ["takeOffTime"]})
Form:C1466.entry.searchField.push({path: "takeOffTime"; type: Is time:K8:8; placeHolder: "takeOffTime"; tags: ["takeOffTime"]})

Form:C1466.entry.searchField.push({path: "slot.line.toAirport.country.name"; placeHolder: "destinationCountry"; tags: ["destination"; "destinationCountry"; "relation"; "relationCountry"]; onlyWithTag: True:C214})
Form:C1466.entry.searchField.push({path: "slot.line.toAirport.city"; placeHolder: "destinationCity"; tags: ["destination"; "destinationCity"; "relation"; "relationCity"; "city"]; onlyWithTag: True:C214})
Form:C1466.entry.searchField.push({path: "slot.line.toAirport.location"; placeHolder: "destinationLocation"; tags: ["destination"; "destinationLocation"; "relation"; "relationLocation"]; onlyWithTag: True:C214})
Form:C1466.entry.searchField.push({path: "slot.line.toAirport.codes.IATA"; placeHolder: "destinationIATA"; tags: ["destination"; "destinationIATA"; "relation"; "relationIATA"]; onlyWithTag: True:C214})
Form:C1466.entry.searchField.push({path: "slot.line.fromAirport.country.name"; placeHolder: "origineCountry"; tags: ["origine"; "origineCountry"; "relation"; "relationCountry"]; onlyWithTag: True:C214})
Form:C1466.entry.searchField.push({path: "slot.line.fromAirport.city"; placeHolder: "origineCity"; tags: ["origine"; "origineCity"; "relation"; "relationCity"; "city"]; onlyWithTag: True:C214})
Form:C1466.entry.searchField.push({path: "slot.line.fromAirport.location"; placeHolder: "origineLocation"; tags: ["origine"; "origineLocation"; "relation"; "relationLocation"]; onlyWithTag: True:C214})
Form:C1466.entry.searchField.push({path: "slot.line.fromAirport.codes.IATA"; placeHolder: "origineIATA"; tags: ["origine"; "origineIATA"; "relation"; "relationIATA"]; onlyWithTag: True:C214})


main_change_entry