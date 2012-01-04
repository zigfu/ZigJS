var zmote = (function() {

	var cursorModes = {
		off : "off",
		motion : "motion",
		touchpadabs : "touchpadabs",	
		touchpadrel : "touchpadrel",
	};

	var lastRawOrientation = { alpha : 0, beta : 0, gamma : 0};
	var lastOrientation = { alpha : 0, beta : 0, gamma : 0};
	var calibrationOrientation = { alpha : 0, beta : 0, gamma : 0};
	var lastTouch = { x : 0, y : 0 };
	var lastCursor = { x : 0, y : 0, mode : "abs" };
	var lastDelta = { x : 0, y : 0, mode : "rel" };
	var controllerConnected;

	var touchStart = { x : 0, y : 0 };
	var touchStartTime = 0;

	function clamp01(val) { if (val < 0) return 0; if (val > 1) return 1; return val; }
	function dist(p1, p2) { return Math.sqrt(((p1.x - p2.x) * (p1.x - p2.x)) + ((p1.y - p2.y) * (p1.y - p2.y))); }

	function orientationToCursor(lastOrientation) {
		return {
			x : clamp01((lastOrientation.alpha / -50) + 0.5),
			y : clamp01((lastOrientation.beta / -50) + 0.5),
			mode : "motion"
		}
	}

	function processTouch(touch) {
		lastDelta.x = touch.pageX - lastTouch.x;
		lastDelta.y = touch.pageY - lastTouch.y;

		lastTouch.x = touch.pageX;
		lastTouch.y = touch.pageY;

		lastCursor.x = (touch.pageX - touch.target.offsetLeft) / touch.target.offsetWidth;
		lastCursor.y = (touch.pageY - touch.target.offsetTop) / touch.target.offsetHeight;
	}

	function controller(socket, zmoteid) {

		function ontouchstart(event) {
			lastTouch.x = event.touches[0].pageX;
			lastTouch.y = event.touches[0].pageY;
			touchStart.x = lastTouch.x;
			touchStart.y = lastTouch.y;
			ontouchmove(event);
		}
		
		function ontouchmove(event) {
			processTouch(event.touches[0]);
			if (controllerConnected && ret.cursormode == cursorModes.touchpadabs) {
				socket.emit('zmote-cursor', lastCursor);
			}
			if (controllerConnected && ret.cursormode == cursorModes.touchpadrel) {
				socket.emit('zmote-cursor', lastDelta);
			}
		}

		function ontouchend(event) {
			var d = dist(lastTouch, touchStart);
			if (controllerConnected && d < 10) {
				socket.emit('zmote-click');
			}
		}

		function onclick(event) {
			if (controllerConnected) {
				socket.emit('zmote-click');
			}
		}

		// return API
		var ret = {
			start : function() {
				socket.emit('zmote-connect', { zmoteid : zmoteid })
			},

			stop : function() {
				if (controllerConnected) {
					socket.emit('zmote-disconnect');
					controllerConnected = false;
					ret.ondisconnected();
				}
			},

			recalibrate : function() {
				calibrationOrientation = { 
					alpha : lastRawOrientation.alpha, 
					beta : lastRawOrientation.beta, 
					gamma : lastRawOrientation.gamma
				};
			},

			bindtouchpad : function(elementId) {
				var surface = document.getElementById(elementId);
				surface.addEventListener("touchstart", ontouchstart, false);
				surface.addEventListener("touchmove", ontouchmove, false);
				surface.addEventListener("touchend", ontouchend, false);
			},

			onconnected : function() {},
			ondisconnected : function() {},

			updateorientation : false,
			cursormode : cursorModes.off,
		}

		// socket events
		socket.on('zmote-connected', function(data) {
			controllerConnected = true;
			ret.onconnected();
		});

		socket.on('disconnect', function() {
			controllerConnected = false;
			ret.ondisconnected();
		});

		window.ondeviceorientation = function(event) {
			lastRawOrientation.alpha = event.alpha;
			lastRawOrientation.beta = event.beta;
			lastRawOrientation.gamma = event.gamma;

			lastOrientation.alpha = event.alpha - calibrationOrientation.alpha;
			lastOrientation.beta = event.beta - calibrationOrientation.beta;
			lastOrientation.gamma = event.gamma - calibrationOrientation.gamma;

			if (controllerConnected && ret.updateorientation) {			
				socket.emit('zmote-orientation', lastOrientation );
			}

			if (controllerConnected && ret.cursormode == cursorModes.motion) {
				socket.emit('zmote-cursor', orientationToCursor(lastOrientation) );
			}
		}

		return ret;
	}

	var isSomeoneConnected = false;

	function receiver(socket, id) {

		// API for return object
		var ret = {
			onaccept : function(clientid) { return true; },
			onconnect : function(clientid) {},
			ondisconnect : function() {},
			onorientation : function(a,b,g) {},
			onclick : function() {},
			oncursor : function(x,y) {},
		}

		socket.on('zmote-connect', function(data) {
			if (isSomeoneConnected) {
				socket.emit('zmote-connected', {clientid : data.clientid, success : false, errormsg : "Someone else is connected"});
			} else if (!ret.onaccept(data)) {
				socket.emit('zmote-connected', {clientid : data.clientid, success : false, errormsg : "Connection refused"});
			} else {
				isSomeoneConnected = true;
				ret.onconnect(data.clientid);
				socket.emit('zmote-connected', {clientid : data.clientid, success : true});

				socket.on('zmote-disconnect', function(data) {
					isSomeoneConnected = false;
					ret.ondisconnect();
				});

				socket.on('disconnect', function() {
					isSomeoneConnected = false;
					ret.ondisconnect();
				});
			}
		});

		socket.on('zmote-orientation', function(data) {
			ret.onorientation(data.alpha, data.beta, data.gamma);
		});

		socket.on('zmote-cursor', function(data) {
			ret.oncursor(data.x, data.y, data.mode == "rel");
		});

		socket.on('zmote-click', function(data) {
			ret.onclick();
		});

		if (undefined !== id) {
			socket.emit('zmote-register', { zmoteid : id })
		}

		return ret;
	}


	// public api
	return {
		controller : controller,
		receiver : receiver,
		cursorModes : cursorModes,
	}
}());