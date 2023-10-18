Form:C1466.entry:={dataclass: cs:C1710.Airport; lb_columns: []; panel: "airportPanel"}  //define the entry for the airports

// set the columns for the item list
Form:C1466.entry.lb_columns.push({header: ""; attribute: "country.tinyFlag"; width: 30; type: Is picture:K8:10; format: Truncated centered:K6:1})
Form:C1466.entry.lb_columns.push({header: "IATA"; attribute: "codes.IATA"; width: 50})
Form:C1466.entry.lb_columns.push({header: "City"; attribute: "city"})
Form:C1466.entry.lb_columns.push({header: "Name"; attribute: "location"})

// set the advanced search dialog
Form:C1466.entry.searchDialog:="airportSearch"

// set the search fields 
Form:C1466.entry.searchField:=[]
Form:C1466.entry.searchField.push({attribute: "city"; tag: "city"})
Form:C1466.entry.searchField.push({attribute: "location"; tag: "location"; tags: ["name"; "airportName"]})
Form:C1466.entry.searchField.push({path: "codes.IATA"; placeHolder: "iata"; tag: "iata"})
Form:C1466.entry.searchField.push({path: "country.name"; placeHolder: "countryName"; tag: "country"})
Form:C1466.entry.searchField.push({path: "country.codes.iso2"; placeHolder: "countryCode"; tag: "country"})

Form:C1466.entry.searchField.push({path: "departureLines.toAirport.city"; placeHolder: "destinationCity"; tags: ["destination"; "destinationCity"; "relation"; "relationCity"]; onlyWithTag: True:C214})
Form:C1466.entry.searchField.push({path: "departureLines.toAirport.location"; placeHolder: "destinationLocation"; tags: ["destination"; "destinationLocation"; "relation"; "relationLocation"]; onlyWithTag: True:C214})
Form:C1466.entry.searchField.push({path: "departureLines.toAirport.country.name"; placeHolder: "destinationCountry"; tags: ["destinationCountry"; "relationCountry"]; onlyWithTag: True:C214})
Form:C1466.entry.searchField.push({path: "departureLines.toAirport.country.codes.iso2"; placeHolder: "destinationCountry"; tags: ["destinationCountry"; "relationCountry"]; onlyWithTag: True:C214})
Form:C1466.entry.searchField.push({path: "arrivalLines.fromAirport.city"; placeHolder: "origineCity"; tags: ["origine"; "origineCity"; "relation"; "relationCity"]; onlyWithTag: True:C214})
Form:C1466.entry.searchField.push({path: "arrivalLines.fromAirport.location"; placeHolder: "origineLocation"; tags: ["origine"; "origineLocation"; "relation"; "relationLocation"]; onlyWithTag: True:C214})
Form:C1466.entry.searchField.push({path: "arrivalLines.fromAirport.country.name"; placeHolder: "origineCountry"; tags: ["origineCountry"; "relationCountry"]; onlyWithTag: True:C214})
Form:C1466.entry.searchField.push({path: "arrivalLines.fromAirport.country.codes.iso2"; placeHolder: "origineCountryCode"; tags: ["origineCountry"; "relationCountry"]; onlyWithTag: True:C214})

//  set the default sort order
Form:C1466.entry.orderByDefault:="city"

main_change_entry  // build the environnement for this entry