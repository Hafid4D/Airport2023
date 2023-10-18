//%attributes = {}
Form:C1466.search:=New object:C1471()

Form:C1466.search.flightsFrom:={countryCode: ""; country: ""}
Form:C1466.search.flightsTo:={countryCode: ""; country: ""}
Form:C1466.search.airline:={countryCode: ""; country: ""}

Form:C1466.search.flightsFrom.period:={values: []; index: -1; currentValue: "Choose a period"}
Form:C1466.search.flightsFrom.period.values.push("Anytime")
Form:C1466.search.flightsFrom.period.values.push("Today")
Form:C1466.search.flightsFrom.period.values.push("This week")

Form:C1466.search.flightsTo.period:={values: []; index: -1; currentValue: "Choose a period"}
Form:C1466.search.flightsTo.period.values.push("Anytime")
Form:C1466.search.flightsTo.period.values.push("Today")
Form:C1466.search.flightsTo.period.values.push("This week")

Form:C1466.search.conjonction:={values: ["All the criteria"; "At less one criteria"]; index: 0}
Form:C1466.search.orderByAttribute:={values: []; index: -1; currentValue: "no sort"; valuesAttributes: []}
Form:C1466.search.orderByAttribute.values.push("Airport name")
Form:C1466.search.orderByAttribute.values.push("City")
Form:C1466.search.orderByAttribute.values.push("IATA code")

Form:C1466.search.orderByAttribute.valuesAttributes.push("location")
Form:C1466.search.orderByAttribute.valuesAttributes.push("city")
Form:C1466.search.orderByAttribute.valuesAttributes.push("codes.IATA")


Form:C1466.search.logs:=True:C214
Form:C1466.search.trace:=False:C215
Form:C1466.search.useLocalSet:=False:C215

Form:C1466.search.airportIntl:=False:C215
Form:C1466.search.airportIntlHub:=False:C215
Form:C1466.search.airportDomestic:=False:C215

Form:C1466.search.fill:=""

Form:C1466.search.aircraft:={name: ""}