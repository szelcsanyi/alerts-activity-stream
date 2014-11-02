% include('templates/header.tpl', title='Alerts activity stream', groups=groups )

<div class="row">
	<div class="col-md-5 col-md-offset-1">

	<div class="panel panel-warning">
		<div class="panel-heading">
			<h3 class="panel-title">Required json informations</h3>
		</div>
		<div class="panel-body">
		<strong>
		<ul>
			<li>type: error|recovery</li>
			<li>message: alert details</li>
			<li>severity: 0..5 (none|information|warning|average|high|disaster)</li>
			<li>group: alert group</li>
		</ul>
		</strong>
		</div>
	</div>

	</div>

	<div class="col-md-5">
	<div class="panel panel-info">
		<div class="panel-heading">
			<h3 class="panel-title">Curl example</h3>
		</div>
		<div class="panel-body">
			<pre>
curl -H 'Content-Type: application/json' \
-d '{"data":"{
 \"message\":\"Low disk space in /\",
 \"type\":\"error\",
 \"severity\":\"2\",
 \"group\":\"sysop\"}' \
 http://activityserver/send
	      	</pre>
		</div>
	</div>
	</div>

</div>
<div class="row">
	<div class="col-md-5 col-md-offset-1">

	<div class="panel panel-warning">
		<div class="panel-heading">
			<h3 class="panel-title">Acknowledge alert</h3>
		</div>
		<div class="panel-body">
		<p><strong>Click on the alert popup to acknowledge it. Click again to resolv it. The alert will disappear in a few seconds.</strong></p>
		</div>
	</div>

	</div>

	<div class="col-md-5">

	<div class="panel panel-info">
		<div class="panel-heading">
			<h3 class="panel-title">Python example</h3>
		</div>
		<div class="panel-body">
			<pre>
import json
import request
url = 'http://activityserver/send'
payload = {'type': 'error', 
'message': 'Low disk spave in /', 
'severity': '2', 'group': 'sysop'}
r = requests.post(url, data=json.dumps(payload))
	      	</pre>
		</div>
	</div>
	</div>

</div>

% include('templates/footer.tpl')
