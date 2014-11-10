% include('templates/header.tpl', title='Alerts for '+group, groups=groups )

  <div id="alertbox" style="height: 80vh; position: relative; overflow: auto;">
  </div>

  % if alerts:
  <script type="text/javascript">
  var notices = [];
  var stack = {"dir1": "right", "dir2": "down", "push": "top", "context": $("#alertbox")};
  function messageBox(id, message, severity, date){
  	
  	var opts = {
				title: message,
				text: date,
				addclass: "stack-topleft",
				stack: stack,
				hide: false,
				buttons: {
					sticker: false
				}
			};
			switch(severity) {
				case '-1':
					opts.type='info';
					opts.icon='glyphicon glyphicon-thumbs-up';
					break;
				case '0':
				case '1':
					opts.type='info';
					break;
				case '2':
				case '3':
					opts.type='regular';
					break;
				case '4':
				case '5':
				default:
					opts.type='error';
			}
			notice = new PNotify(opts);
			notice.get().click(function(){
					$.get( "/acknowledge/" + id);
				});
			notices[id] = notice;
  	return notice;
  }
  
  $( document ).ready(function() {
  % for alert in alerts:
    messageBox('{{alert[0]}}', '{{alert[1]}}', '{{alert[2]}}', '{{alert[4]}}');
  % end
  });
  </script>
  % end

<script type="text/javascript">
	var pusher = new Pusher('{{key}}');
	var channel = pusher.subscribe('alerts-{{group}}');
	channel.bind('new-alerts', function(data) {
		if (data.type == 'recovery'){
			notices[data.id].update({type: 'success', hide: 'true', icon: 'glyphicon glyphicon-ok'});
		}
		else if (data.type == 'ack'){
			notices[data.id].update({type: 'info', icon: 'glyphicon glyphicon-thumbs-up'});
		}
		else {
			messageBox(data.id, data.message, data.severity, data.date);
		}
	});
</script>

% include('templates/footer.tpl')
