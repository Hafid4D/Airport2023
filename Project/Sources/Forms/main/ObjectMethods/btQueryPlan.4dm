$query:={}
$query.text:=JSON Stringify:C1217(Form:C1466.search.queryPlan; *)
$query.querySettings:=JSON Stringify:C1217(Form:C1466.search.querySettings; *)
$query.title:="Query Plan"
$query.type:="queryPlan"
$query.queryString:=Form:C1466.search.queryString
$query.action:="update"

$p:=New process:C317("queryDisplayer"; 0; "$queryPlanDisplayer"; $query; *)
BRING TO FRONT:C326($p)
CALL FORM:C1391(Storage:C1525.queryPlanDisplayer.window; "queryDisplayer_update"; $query)
