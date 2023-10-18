Form:C1466.entry:={dataclass: cs:C1710.Airline; lb_columns: []; panel: "airlinePanel"}

Form:C1466.entry.lb_columns.push({header: ""; attribute: "country.tinyFlag"; width: 30; type: Is picture:K8:10; format: Truncated centered:K6:1})
Form:C1466.entry.lb_columns.push({header: "Code"; attribute: "designator"; width: 40})
Form:C1466.entry.lb_columns.push({header: "Name"; attribute: "name"; width: 250})
Form:C1466.entry.lb_columns.push({header: ""; attribute: "tinyLogo"; width: 30; type: Is picture:K8:10; format: Scaled to fit prop centered:K6:6})
Form:C1466.entry.lb_columns.push({header: "Nb flights"; attribute: "nbOfFlights"; width: 80; type: Is real:K8:4; format: "###,###,##0;;"})


Form:C1466.entry.searchField:=[]
Form:C1466.entry.searchField.push({attribute: "name"})
Form:C1466.entry.searchField.push({attribute: "designator"})
Form:C1466.entry.searchField.push({path: "country.codes.iso2"; placeHolder: "iso"})

main_change_entry