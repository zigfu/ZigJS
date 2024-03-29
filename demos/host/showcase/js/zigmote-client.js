var zigmote = (function() {

	plugins = {}
	
	function getRoomListId(roomtype) {
		return "roomslist:"+roomtype;
	}

	function host(socket) {
		var location = {}; // TODO : fill me in!

		var commands = {};

		var locks = {};
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
		
		function startRoom(roomtype, name, successcb) {

			socket.on('zigmote-roomStarted', function(data) {
				// save roomid
				localStorage.setItem('zigmote-roomid', data.roomid);
				successcb(data);

				socket.on('zigmote-sendToHost', function(data) {
					if (commands.hasOwnProperty(data.command)) {
						commands[data.command](data.data, data.userid);
					}
				});
				
				socket.on('zigmote-lock', function(data) {
					if (pendingLocks.hasOwnProperty(data.lockid)) {
						pendingLocks[data.lockid](data.success);
						delete pendingLocks[data.lockid];
					}
				});
				
				socket.on('zigmote-locked', function(data) {
					locks[data.lockid] = data.userid;
					if (lockCallbacks.hasOwnProperty(data.lockid)) {
						lockCallbacks[data.lockid].locked(data.userid);
					}
				});
				
				socket.on('zigmote-unlocked', function(data) {
					if (lockCallbacks.hasOwnProperty(data.lockid)) {
						lockCallbacks[data.lockid].unlocked(data.userid);
					}
					if (locks.hasOwnProperty(data.lockid)) {
						delete locks[data.lockid];
					}
				})	
			});

			// get cookie with roomid
			var roomid = localStorage.getItem('zigmote-roomid');

			socket.emit('zigmote-startRoom', {
				roomid : roomid,
				roomtype : roomtype,
				roomname : name,
				location : location,
				pin : 0,
				adminpin : 0,
			});
		}

		function rename(newname) {
			socket.emit('zigmote-rename', { roomname : newname });
		}

		function on(command, callback) {
			commands[command] = callback;
		}

		function onLock(lockid, lockcallback, unlockcallback) {
			if (undefined === lockcallback) {
				lockcallback = function(userid) {};
			}

			if (undefined === unlockcallback) {
				unlockcallback = function(userid) {};
			}

			lockCallbacks[lockid] = {
				locked : lockcallback,
				unlocked : unlockcallback,
			};

			// if we register callbacks to a locked lock, fire callback immediately
			if (locks.hasOwnProperty(lockid)) {
				lockCallbacks[lockid].locked(lockCallbacks[lockid]);
			}
		}

		function lock(lockid, callback) {
			pendingLocks[lockid] = callback;
			socket.emit('zigmote-lock', { lockid : lockid });
		}

		function unlock(lockid) {
			socket.emit('zigmote-unlock', { lockid : lockid });
		}

		// "install" plugins
		for (var plugin in plugins) if (plugins.hasOwnProperty(plugin)) {
			if (plugins[plugin].hasOwnProperty("host")) {
				ret = plugins[plugin].host(ret);
			}
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
			pendinglocks : pendingLocks, // shouldn't be exposed
			bindbutton : bindbutton,

			onjoin : function() {},
			onjoinerror : function() {},
			ondisconnect : function() {},
			onhostgone : function() {},
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
					ret.roomsharedid = data.roomsharedid;
					successcb(data);
					ret.onjoin();
				} else {
					failcb(data.errormsg);
					ret.onjoinerror();
				}
			});

			socket.on('zigmote-lock', function(data) {
				if (pendingLocks.hasOwnProperty(data.lockid)) {
					pendingLocks[data.lockid](data.success);
					delete pendingLocks[data.lockid];
				}
			});

			socket.on('zigmote-hostGone', function() {
				ret.onhostgone();
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

		function bindbutton(element, command) {
			element.addEventListener('touchend', function(e) {
				sendToHost(command);
				e.preventDefault();
			});
			element.addEventListener('click', function(e) {
				sendToHost(command);
			});
		}

		// "install" plugins
		for (var plugin in plugins) if (plugins.hasOwnProperty(plugin)) {
			if (plugins[plugin].hasOwnProperty("controller")) {
				ret = plugins[plugin].controller(ret);
			}
		}

		return ret;
	}

	// public api
	return {
		host : host,
		controller : controller,
		plugins : plugins,
		getRoomListId : getRoomListId,
	}
}());