//%attributes = {}

var $file : 4D:C1709.File

$file:=Folder:C1567(fk database folder:K87:14).file("Data/Logs/4DRequestsLogServer_"+String:C10(Storage:C1525.logs.sequentialNumber)+".txt")
$text:=$file.getText()

Form:C1466.lb_lines:=Split string:C1554($text; "\n").slice(3; -1)