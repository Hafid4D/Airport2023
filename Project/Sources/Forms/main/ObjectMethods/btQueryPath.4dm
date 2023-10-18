$query:={}
$query.text:=JSON Stringify:C1217(Form:C1466.search.queryPath; *)
$query.querySettings:=JSON Stringify:C1217(Form:C1466.search.querySettings; *)
$query.title:="Query Path"
$query.type:="queryPath"
$query.queryString:=Form:C1466.search.queryString
$query.action:="update"

$p:=New process:C317("queryDisplayer"; 0; "$queryPathDisplayer"; $query; *)

CALL FORM:C1391(Storage:C1525.queryPathDisplayer.window; "queryDisplayer_update"; $query)
