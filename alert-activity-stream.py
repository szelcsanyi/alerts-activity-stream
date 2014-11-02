#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
Alert activity stream server
"""

__author__ = "Gabor Szelcsanyi"
__copyright__ = "Copyright 2014"
__credits__ = ["Gabor Szelcsanyi"]
__license__ = "MIT"
__version__ = "1.0.0"
__maintainer__ = "Gabor Szelcsanyi"
__email__ = "szelcsanyi.gabor@gmail.com"

from bottle import route, run, template, request, HTTPError, error, install, static_file
import bottle.ext.sqlite
import pusher
import hashlib
from datetime import datetime
import config

install(bottle.ext.sqlite.Plugin(dbfile=config.DB_PATH))


@route('/static/<filename>')
def server_static(filename):
	return static_file(filename, root='static')

@route('/favicon.ico')
def favicon():
	abort(404, "")

@error(404)
def error404(error):
	return 'Not Found'

@route('/')
def main(db):
	return template('templates/main', groups=get_groups(db) )

@route('/alerts/<group>')
def show(group, db):
	row = db.execute('SELECT * FROM Alerts WHERE AlertGroup=?', [group] ).fetchall()
	return template('templates/alerts', alerts=row, group=group, groups=get_groups(db), key=config.KEY )

@route('/send', method='POST')
def send(db):
	errortype = request.json['type']
	message = request.json['message']
	severity = request.json['severity']
	group = request.json['group']

	id = hashlib.md5(message + severity + group).hexdigest()

	db.execute("CREATE TABLE if not exists Alerts(Id TEXT, Message TEXT, Severity INT, AlertGroup TEXT, AlertDate DATETIME, PRIMARY KEY (Id) )")

	date = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
	if errortype == "error":
		db.execute("INSERT INTO Alerts VALUES(?,?,?,?,?)", (id, message, severity, group, date))
	elif errortype == "recovery":
		db.execute("DELETE FROM Alerts WHERE Id=?", [id] )
	else:
		return HTTPError(500, "Not supported error type!")

	send_push(message, errortype, severity, group, id, date)

@route('/acknowledge/<id>')
def remove(id, db):
	row = db.execute('SELECT AlertGroup, Severity FROM Alerts WHERE id=?', [id] ).fetchone()
	if row:
		if row[1] == -1:
			db.execute("DELETE FROM Alerts WHERE Id=?", [id] )
			send_push('', 'recovery', 0, row[0], id, '')
		else:
			db.execute("UPDATE Alerts SET Severity=-1 WHERE Id=?", [id] )
			send_push('', 'ack', 0, row[0], id, '')
	return "OK"

def send_push(message, errortype, severity, group, id, date):
	p = pusher.Pusher(
		app_id=config.APP_ID,
		key=config.KEY,
		secret=config.SECRET
	)
	p['alerts-'+group].trigger('new-alerts', {'message': message, 'type': errortype, 'severity': severity, 'group': group, 'id': id, 'date': date })

def get_groups(db):
	return db.execute('SELECT distinct AlertGroup FROM Alerts').fetchall()

if __name__ == "__main__":
	run(host='localhost', port=8080, debug=True)
else:
        application = default_app()
