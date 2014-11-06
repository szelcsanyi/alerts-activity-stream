<!DOCTYPE html>
<html lang="en">
	<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta name="description" content="Alerts activity stream">
	<meta name="author" content="Gabor Szelcsanyi">

	<!-- jquery -->
	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>

	<!-- bootstrap -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css">
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>

	<!-- pusher -->
	<script src="https://js.pusher.com/2.2/pusher.min.js" type="text/javascript"></script>

	<!-- pnotify -->
	<script type="text/javascript" src="/static/pnotify.custom.min.js"></script>
	<link href="/static/pnotify.custom.min.css" rel="stylesheet" type="text/css">

	<!-- flipclock -->
	<script type="text/javascript" src="/static/flipclock.min.js"></script>
	<link href="/static/flipclock.css" rel="stylesheet" type="text/css">

	<meta http-equiv="content-type" content="text/html; charset=utf8" />
	<style>
	body {
		background: #222 url(/static/map-image.png) no-repeat center center fixed;
		-webkit-background-size: cover;
		-moz-background-size: cover;
		background-size: cover;
		-o-background-size: cover;
		padding-top: 80px;
	}
	</style>

	<title>{{title}}</title>
</head>
<body>
    <div class="clock" style="position: fixed; bottom: 0;"></div>
    <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="/">Alerts activity stream</a>
        </div>
        <div id="navbar" class="collapse navbar-collapse">
          <ul class="nav navbar-nav navbar-right">
            % for group in groups:
            <li><a href="/alerts/{{group[0]}}">{{group[0]}}</a></li>
            % end
          </ul>
        </div><!--/.nav-collapse -->
      </div>
    </nav>

    <div class="container">
