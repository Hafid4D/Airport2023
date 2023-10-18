Form:C1466.entry:={dataclass: cs:C1710.Line; lb_columns: []; panel: "linePanel"}

Form:C1466.entry.lb_columns.push({header: ""; attribute: "fromAirport.country.tinyFlag"; width: 30; type: Is picture:K8:10; format: Truncated centered:K6:1})
Form:C1466.entry.lb_columns.push({header: "IATA"; attribute: "fromAirport.codes.IATA"; width: 50})
Form:C1466.entry.lb_columns.push({header: "From"; attribute: "fromAirport.city"})
Form:C1466.entry.lb_columns.push({header: ""; attribute: "toAirport.country.tinyFlag"; width: 30; type: Is picture:K8:10; format: Truncated centered:K6:1})
Form:C1466.entry.lb_columns.push({header: "IATA"; attribute: "toAirport.codes.IATA"; width: 50})
Form:C1466.entry.lb_columns.push({header: "To"; attribute: "toAirport.city"})
Form:C1466.entry.lb_columns.push({header: "Nb flights"; attribute: "nbOfFlights"; type: Is real:K8:4; format: "###,###,##0;;"})


Form:C1466.entry.searchField:=[]
//Form.entry.searchField.push({path: "fromAirport.city"; placeHolder: "fromCity"})
//Form.entry.searchField.push({path: "fromAirport.country.name"; placeHolder: "from"})
//Form.entry.searchField.push({path: "fromAirport.location"; placeHolder: "fromLocation"})
//Form.entry.searchField.push({path: "fromAirport.codes.IATA"; placeHolder: "fromIATA"})
//Form.entry.searchField.push({path: "toAirport.city"; placeHolder: "toCity"})
//Form.entry.searchField.push({path: "toAirport.location"; placeHolder: "toLocation"})
//Form.entry.searchField.push({path: "toAirport.codes.IATA"; placeHolder: "toIATA"})

Form:C1466.entry.searchField.push({path: "toAirport.country.name"; placeHolder: "destinationCountry"; tags: ["destination"; "destinationCountry"; "relation"; "relationCountry"]; onlyWithTag: True:C214})
Form:C1466.entry.searchField.push({path: "toAirport.city"; placeHolder: "destinationCity"; tags: ["destination"; "destinationCity"; "relation"; "relationCity"; "city"]; onlyWithTag: False:C215})
Form:C1466.entry.searchField.push({path: "toAirport.location"; placeHolder: "destinationLocation"; tags: ["destination"; "destinationLocation"; "relation"; "relationLocation"]; onlyWithTag: True:C214})
Form:C1466.entry.searchField.push({path: "toAirport.codes.IATA"; placeHolder: "destinationIATA"; tags: ["destination"; "destinationIATA"; "relation"; "relationIATA"]; onlyWithTag: True:C214})
Form:C1466.entry.searchField.push({path: "fromAirport.country.name"; placeHolder: "origineCountry"; tags: ["origine"; "origineCountry"; "relation"; "relationCountry"]; onlyWithTag: True:C214})
Form:C1466.entry.searchField.push({path: "fromAirport.city"; placeHolder: "origineCity"; tags: ["origine"; "origineCity"; "relation"; "relationCity"; "city"]; onlyWithTag: False:C215})
Form:C1466.entry.searchField.push({path: "fromAirport.location"; placeHolder: "origineLocation"; tags: ["origine"; "origineLocation"; "relation"; "relationLocation"]; onlyWithTag: True:C214})
Form:C1466.entry.searchField.push({path: "fromAirport.codes.IATA"; placeHolder: "origineIATA"; tags: ["origine"; "origineIATA"; "relation"; "relationIATA"]; onlyWithTag: True:C214})


main_change_entry

main_change_entry