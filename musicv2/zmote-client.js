var zmote = (function() {

	var cursorModes = {
		off : "off",
		motion : "motion",
		touchpadabs : "touchpadabs",	
		touchpadrel : "touchpadrel",
	};

	var lastOrientation;
	var calibrationOrientation = { alpha : 0, beta : 0, gamma : 0};
	var lastTouch = { x : 0, y : 0 };
	var lastCursor = { x : 0, y : 0 };
	var lastDelta = { x : 0, y : 0 };
	var controllerConnected;

	function clamp01(val) { if (val < 0) return 0; if (val > 1) return 1; return val; }

	function orientationToCursor(lastOrientation) {
		return {
			x : clamp01((lastOrientation.alpha / -50) + 0.5),
			y : clamp01((lastOrientation.beta / -50) + 0.5),
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

	function controller(socket) {

		function ontouchstart(event) {
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
		}

		// return API
		var ret = {
			start : function(zmoteid) {
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
				calibrationOrientation = { alpha : lastOrientation.alpha, beta : lastOrientation.beta, gamme : lastOrientation.gamma};
			},

			bindtouchpad : function(elementId) {
				surface = document.getElementById(elementId);
				surface.addEventListener("touchstart", ontouchstart, false);
				surface.addEventListener("touchmove", ontouchmove, false);
				surface.addEventListener("touchend", ontouchend, false);
				ret.sendmotion = false;
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
			lastOrientation = { 
				alpha : event.alpha - calibrationOrientation.alpha, 
				beta : event.beta - calibrationOrientation.beta, 
				gamma : event.gamma - calibrationOrientation.gamma, 
			};

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

	function receiver(socket) {

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
			ret.oncursor(data.x, data.y);
		});

		return ret;
	}


	// public api
	return {
		controller : controller,
		receiver : receiver,
		cursorModes : cursorModes,
	}
}());