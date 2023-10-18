Form:C1466.entry:={dataclass: cs:C1710.Slot; lb_columns: []; panel: "slotPanel"}

Form:C1466.entry.lb_columns.push({header: "Flight"; attribute: "flightNumber"; width: 75})
Form:C1466.entry.lb_columns.push({header: "IATA"; attribute: "fromAirport.IATA_airportCode"; width: 50})
Form:C1466.entry.lb_columns.push({header: "From"; attribute: "fromAirport.city"})
Form:C1466.entry.lb_columns.push({header: "IATA"; attribute: "toAirport.IATA_airportCode"; width: 50})
Form:C1466.entry.lb_columns.push({header: "To"; attribute: "toAirport.city"})
Form:C1466.entry.lb_columns.push({header: "Dep."; attribute: "takeOffTime"; type: Is time:K8:8; format: HH MM:K7:2; width: 50; hAlign: Align center:K42:3})
Form:C1466.entry.lb_columns.push({header: "Arr."; attribute: "landingTime"; type: Is time:K8:8; format: HH MM:K7:2; width: 50; hAlign: Align center:K42:3})

Form:C1466.entry.searchField:=[]
Form:C1466.entry.searchField.push({attribute: "flightNumber"; tags: ["flight"; "flightNumber"; "number"]})
Form:C1466.entry.searchField.push({attribute: "takeOffTime"; type: Is time:K8:8; tags: ["takeOff"; "takeOffTime"]})
Form:C1466.entry.searchField.push({attribute: "landingTime"; type: Is time:K8:8; tags: ["landing"; "landingTime"]})

Form:C1466.entry.searchField.push({path: "line.toAirport.country.name"; placeHolder: "destinationCountry"; tags: ["destination"; "destinationCountry"; "relation"; "relationCountry"]})
Form:C1466.entry.searchField.push({path: "line.toAirport.city"; placeHolder: "destinationCity"; tags: ["destination"; "destinationCity"; "relation"; "relationCity"]})
Form:C1466.entry.searchField.push({path: "line.toAirport.location"; placeHolder: "destinationLocation"; tags: ["destination"; "destinationLocation"; "relation"; "relationLocation"]})
Form:C1466.entry.searchField.push({path: "line.toAirport.codes.IATA"; placeHolder: "destinationIATA"; tags: ["destination"; "destinationIATA"; "relation"; "relationIATA"]})
Form:C1466.entry.searchField.push({path: "line.fromAirport.country.name"; placeHolder: "origineCountry"; tags: ["origine"; "origineCountry"; "relation"; "relationCountry"]})
Form:C1466.entry.searchField.push({path: "line.fromAirport.city"; placeHolder: "origineCity"; tags: ["origine"; "origineCity"; "relation"; "relationCity"]})
Form:C1466.entry.searchField.push({path: "line.fromAirport.location"; placeHolder: "origineLocation"; tags: ["origine"; "origineLocation"; "relation"; "relationLocation"]})
Form:C1466.entry.searchField.push({path: "line.fromAirport.codes.IATA"; placeHolder: "origineIATA"; tags: ["origine"; "origineIATA"; "relation"; "relationIATA"]})
Form:C1466.entry.searchField.push({path: "airline.name"; placeHolder: "airlineName"; tag: "airline"})
Form:C1466.entry.searchField.push({path: "airline.designator"; placeHolder: "airlineIATA"; tag: "airline"})
Form:C1466.entry.searchField.push({path: "aircraft.name"; placeHolder: "aircraftName"; tag: "aircraft"})
Form:C1466.entry.searchField.push({path: "aircraft.IATA"; placeHolder: "aircraftIATA"; tag: "aircraft"})



main_change_entry