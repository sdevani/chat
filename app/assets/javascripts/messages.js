function insertNewMessage(m) {
	if (typeof(m) == "string") {
		m = JSON.parse(m);
	}
	if ($('.message_' + m.id).length == 0) {
		var new_div = "<div class='message message_" + m.id + "'>";
		new_div += "<h4>" + m.from_user + "</h4>";
		new_div += "<p>" + m.text + "</p>";
		new_div += "</div>"
		$('.chats').prepend($(new_div));
		while ($('.message').length > 30) {
			$('.message').last().remove();
		}
	}
}

$(document).ready(
	function() {
		var source = new EventSource('/stream');
		source.addEventListener('message', function(e) {
			console.log('Received a message:', e.data);
			var messages = JSON.parse(e.data);
			var i;
			for(i = 0; i < messages.length; i++) {
				insertNewMessage(messages[i]);
			}
		});
	}
);
