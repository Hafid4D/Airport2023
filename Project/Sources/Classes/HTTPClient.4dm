Class constructor
	
Function getGithubAccount($url)
	This:C1470.url:=$url
	$response:=4D:C1709.HTTPRequest.new(This:C1470.url).wait()
	If ($response.response.status=200)
		return $response.response.body
	End if 
	return {}
	