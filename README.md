# Alerts activity stream
[![Build Status](https://travis-ci.org/szelcsanyi/alerts-activity-stream.svg?branch=master)](https://travis-ci.org/szelcsanyi/alerts-activity-stream)

## Description
Alerts dashboard with real-time notifications.

## How to use
Post json data with proper information. An alert popup will be displayed on the dashboard. You can acknowledge it by clicking on the popup and set manual resolved by clicking on it again.

### Json information
 - type: error|recovery
 - message: alert details
 - severity: 0..5 (none|information|warning|average|high|disaster)
 - group: alert group

### Examples
Curl:
<pre>
curl -H 'Content-Type: application/json' \
-d '{"data":"{
 \"message\":\"Low disk space in /\",
 \"type\":\"error\",
 \"severity\":\"2\",
 \"group\":\"sysop\"}' \
 http://activityserver/send
</pre>

Python
<pre>
import json
import request
url = 'http://activityserver/send'
payload = {'type': 'error', 
'message': 'Low disk space in /', 
'severity': '2', 'group': 'sysop'}
r = requests.post(url, data=json.dumps(payload))
</pre>

## TODO
- WSGI config examples

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

* Freely distributable and licensed under the [MIT license](http://szelcsanyi.mit-license.org/2014/license.html).
* Copyright (c) 2014 Gabor Szelcsanyi
