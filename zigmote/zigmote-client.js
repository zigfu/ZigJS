var zigmote = (function() {
	
	function host(socket) {
		var location = {}; // TODO : fill me in!

		var commands = {};

		var lockCallbacks = {};
		var pendingLocks = {};

		var ret = {
			startRoom : startRoom,
			rename : rename,
			on : on,
			onLock : onLock, 
			lock : lock,
			unlock : unlock,
		};

		function startRoom(roomid, name, successcb) {

			socket.on('zigmote-roomStarted', function(data) {
				successcb(data);

				socket.on('zigmote-sendToHost', function(data) {
					console.log("Received command from controller: " + data.command);
					if (commands.hasOwnProperty(data.command)) {
						commands[data.command](data.data);
					}
				});
				
				socket.on('zigmote-lock', function(data) {
					if (pendingLocks.hasOwnProperty(data.lockid)) {
						pendingLocks[data.lockid](data.success);
						delete pendingLocks[data.lockid];
					}
				});
				
				socket.on('zigmote-locked', function(data) {
					if (lockCallbacks.hasOwnProperty(data.lockid)) {
						lockCallbacks[data.lockid].locked(data);
					}
				});
				
				socket.on('zigmote-unlocked', function(data) {
					if (lockCallbacks.hasOwnProperty(data.lockid)) {
						lockCallbacks[data.lockid].unlocked(data);
					}
				})	
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

		function onLock(lockid, lockcallback, unlockcallback) {
			if (undefined === lockcallback) {
				lockcallback = function() {};
			}

			if (undefined === unlockcallback) {
				unlockcallback = function() {};
			}

			lockCallbacks[lockid] = {
				locked : lockcallback,
				unlocked : unlockcallback,
			};
		}

		function lock(lockid, callback) {
			pendingLocks[lockid] = callback;
			socket.emit('zigmote-lock', { lockid : lockid });
		}

		function unlock(lockid) {
			socket.emit('zigmote-unlock', { lockid : lockid });
		}

		return ret;
	}

	function controller(socket) {

		var location = {}; // TODO : fill me in!

		var pendingLocks = {};

		var ret = {
			getRoomList : getRoomList,
			joinRoom : joinRoom,
			rename : rename,
			sendToHost : sendToHost,
			lock : lock,
			unlock : unlock,

			onjoin : function() {},
			onjoinerror : function() {},
			ondisconnect : function() {},
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
					ret.onjoin();
				} else {
					failcb(data.errormsg);
					ret.onjoinerror();
				}
			});

			socket.on('zigmote-lock', function(data) {
				console.log('got a lock response ' + data.success);
				if (pendingLocks.hasOwnProperty(data.lockid)) {
					pendingLocks[data.lockid](data.success);
					delete pendingLocks[data.lockid];
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

		function lock(lockid, callback) {
			pendingLocks[lockid] = callback;
			socket.emit('zigmote-lock', { lockid : lockid });
		}

		function unlock(lockid) {
			socket.emit('zigmote-unlock', { lockid : lockid });	
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