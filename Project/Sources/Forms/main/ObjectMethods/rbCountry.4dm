Form:C1466.entry:={dataclass: cs:C1710.Country; lb_columns: []; panel: "countryPanel"}

Form:C1466.entry.lb_columns.push({header: ""; attribute: "tinyFlag"; width: 30; type: Is picture:K8:10; format: Truncated centered:K6:1})
Form:C1466.entry.lb_columns.push({header: "Code"; attribute: "isoCode_2"; width: 40})
Form:C1466.entry.lb_columns.push({header: "Name"; attribute: "name"; width: 250})

Form:C1466.entry.searchField:=[]
Form:C1466.entry.searchField.push({attribute: "name"})
Form:C1466.entry.searchField.push({attribute: "continent"})
Form:C1466.entry.searchField.push({path: "codes.iso2"; placeHolder: "iso"})


main_change_entry