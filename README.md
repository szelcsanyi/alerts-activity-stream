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
-d {"type":"error",
"message":"Low disk space in /",
"severity":"4",
"group":"sysop"} \
 http://activityserver/send
</pre>

Python:
<pre>
import json
import requests
url = 'http://activityserver/send'
payload = {'type': 'error', 
'message': 'Low disk space in /', 
'severity': '2', 'group': 'sysop'}
r = requests.post(url, data=json.dumps(payload))
</pre>

## uWSGI example
- uwsgi - alerts.ini
<pre>
[uwsgi]
vhost = true
plugins = python
master = true
enable-threads = true
processes = 2
wsgi-file = /path/to/alerts-activity-stream/alert-activity-stream.py
virtualenv = /path/to/alerts-activity-stream
chdir = /path/to/alerts-activity-stream/alerts-activity-stream
touch-reload = /path/to/alerts-activity-stream/reload
socket = 127.0.0.1:3031
</pre>

- Apache2
<pre>
<VirtualHost *:80>
    ServerName alerts.yourdomain

    DocumentRoot /path/to/alerts-activity-stream/alerts-activity-stream

    <Directory /path/to/alerts-activity-stream/alerts-activity-stream>
        Options Indexes FollowSymLinks MultiViews
        AllowOverride None
        Order allow,deny
        allow from all
    </Directory>

    <Location />
        Options FollowSymLinks Indexes
        SetHandler uwsgi-handler
        uWSGISocket 127.0.0.1:3031
    </Location>

    <Location /static>
        SetHandler none
    </Location>
</VirtualHost>
</pre>

- Nginx
<pre>
server {
        listen   80;
        index index.html;

        rewrite_log on;
        autoindex off;

        server_name alerts.yourdomain;

        location /static/ {
            alias /path/to/static/;
            expires max;
            log_not_found off;
        }

        location / {
                uwsgi_pass  127.0.0.1:3031;
                include     uwsgi_params;
        }
}
</pre>

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

* Freely distributable and licensed under the [MIT license](http://szelcsanyi.mit-license.org/2014/license.html).
* Copyright (c) 2014 Gabor Szelcsanyi
