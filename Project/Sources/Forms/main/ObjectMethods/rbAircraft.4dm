Form:C1466.entry:={dataclass: cs:C1710.Aircraft; lb_columns: []; panel: "aircraftPanel"}

Form:C1466.entry.lb_columns.push({header: "IATA"; attribute: "IATA"; width: 200})
Form:C1466.entry.lb_columns.push({header: "Name"; attribute: "name"; width: 200})

Form:C1466.entry.searchField:=[]
Form:C1466.entry.searchField.push({attribute: "name"})
Form:C1466.entry.searchField.push({attribute: "IATA"})
Form:C1466.entry.searchField.push({attribute: "ICAO"})


main_change_entry