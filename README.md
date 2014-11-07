# Alerts activity stream
[![Build Status](https://travis-ci.org/szelcsanyi/alerts-activity-stream.svg?branch=master)](https://travis-ci.org/szelcsanyi/alerts-activity-stream)

## Description
Alerts dashboard with real-time notifications.

## How to use
Post json data with proper information. An alert popup will be displayed on the dashboard if its type was error. You can acknowledge it by clicking on the popup and set manual resolved by clicking on it again. If the type is recovery and the message is the same as the error one then its status will be set to resolved and will be gone in a few seconds.

## How does it look like
![Screenshot](https://raw.githubusercontent.com/szelcsanyi/assets/master/alerts-activity-stream/screenshot.png)

### Json message format
 - type: error|recovery
 - message: alert details
 - severity: 0..5 (none|information|warning|average|high|disaster)
 - group: alert group

### Examples
Curl:
<pre>
curl -H 'Content-Type: application/json' \
-d {"type":"error",
"message":"Low disk space in / on mail01",
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
'message': 'Low disk space in / on mail01',
'severity': '2', 'group': 'sysop'}
r = requests.post(url, data=json.dumps(payload))
</pre>

### Installation
- create a virtualenv: virtualenv /path/to/virtualenv
- source /path/to/virtualenv/bin/activate
- git clone this repo to /path/to/alerts-activity-stream
- pip install -r /path/to/alerts-activity-stream/requirements.txt
- create /path/to/alerts-activity-stream/config.py with required settings
- install uwsgi
- install apache or nginx

#### Config examples

##### config.py
<pre>
APP_ID='pusher app id'
KEY='pusher app key'
SECRET='pusher app secret'
DB_PATH='/path/to/sqlite.db'
</pre>

##### uwsgi - alerts.ini
<pre>
[uwsgi]
vhost = true
plugins = python
master = true
enable-threads = true
processes = 2
wsgi-file = /path/to/alerts-activity-stream/alert-activity-stream.py
virtualenv = /path/to/virtualenv
chdir = /path/to/alerts-activity-stream
touch-reload = /path/to/alerts-activity-stream/reload
socket = 127.0.0.1:3031
</pre>

###### Apache2
<pre>
&lt;VirtualHost *:80&gt;
    ServerName alerts.yourdomain

    DocumentRoot /path/to/alerts-activity-stream

    &lt;Directory /path/to/alerts-activity-stream&gt;
        Options Indexes FollowSymLinks MultiViews
        AllowOverride None
        Order allow,deny
        allow from all
    &lt;/Directory&gt;

    &lt;Location /&gt;
        Options FollowSymLinks Indexes
        SetHandler uwsgi-handler
        uWSGISocket 127.0.0.1:3031
    &lt;/Location&gt;

    &lt;Location /static&gt;
        SetHandler none
    &lt;/Location&gt;
&lt;/VirtualHost&gt;
</pre>

###### Nginx
<pre>
server {
        listen   80;
        autoindex off;

        server_name alerts.yourdomain;

        location /static/ {
            alias /path/to/alerts-activity-stream/static/;
            expires max;
            log_not_found off;
        }

        location / {
                uwsgi_pass  127.0.0.1:3031;
                include     uwsgi_params;
        }
}
</pre>


## Thanks to
- [Pusher.com](https://pusher.com/) for real-time push notification service
- [PNotify](http://sciactive.github.io/pnotify/) for awesome javascript notifications
- [FlipClock.js](http://flipclockjs.com/) for nice clock solution
- [Bootstrap](http://getbootstrap.com/) for framework

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

* Freely distributable and licensed under the [MIT license](http://szelcsanyi.mit-license.org/2014/license.html).
* Copyright (c) 2014 Gabor Szelcsanyi

[![image](https://ga-beacon.appspot.com/UA-56493884-1/alerts-activity-stream/README.md)](https://github.com/szelcsanyi/alerts-activity-stream)

