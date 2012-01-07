var zigmote = (function() {
	
	function host(socket) {
		var location = {}; // TODO : fill me in!

		var commands = {};

		var ret = {
			startRoom : startRoom,
			rename : rename,
			on : on,
		};

		function startRoom(roomid, name, successcb) {

			socket.on('zigmote-roomStarted', function(data) {
				successcb(data.roomid, data.roomdata);

				socket.on('zigmote-sendToHost', function(data) {
					console.log("Received command from controller: " + data.command);
					if (commands.hasOwnProperty(data.command)) {
						commands[data.command](data.data);
					}
				});
			});

			socket.emit('zigmote-startRoom', {
				roomid : roomid,
				roomname : name,
				location : location,
				pin : 0,
				adminpin : 0,
			});
		}

		function rename(newname) {
			socket.emit('zigmote-rename', { username : newname });
		}

		function on(command, callback) {
			commands[command] = callback;
		}

		return ret;
	}

	function controller(socket) {

		var location = {}; // TODO : fill me in!

		var ret = {
			getRoomList : getRoomList,
			joinRoom : joinRoom,
			rename : rename,
			sendToHost : sendToHost,
		};

		function getRoomList() {
			// implement me!
			return [];
		}

		function joinRoom(roomid, name, successcb, failcb) {

			if (undefined === successcb) {
				successcb = function() {};
			}

			if (undefined === failcb) {
				failcb = function() {};
			}

			socket.on('zigmote-joinedRoom', function(data) {
				if (data.success) {
					successcb();
				} else {
					failcb(data.errormsg);
				}
			});

			socket.emit('zigmote-joinRoom', {
				roomid : roomid,
				username : name,
				location : location,
			});
		}

		function rename(newname) {
			socket.emit('zigmote-rename', { username : newname });
		}

		function sendToHost(command, data) {
		    socket.emit('zigmote-sendToHost', { command : command, data : data });
		}

		return ret;
	}

	// public api
	return {
		host : host,
		controller : controller,
		roomslistid : "roomslist",
	}
}());