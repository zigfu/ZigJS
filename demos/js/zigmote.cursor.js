(function(zigmote) {

	var cursorModes = {
		off : "off",
		motion : "motion",
		touchpadabs : "touchpadabs",	
		touchpadrel : "touchpadrel",
	};

	function controller(zigmoteController) {

		//---------------------------------------------------------------------
		// private controller 
		//---------------------------------------------------------------------

		var sendingCursor = false;
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

		// FOV in degrees
		var cursorFovX = 60;
		var cursorFovY = 45;

		function fixAngle(angle) {
			//this function is needed for alpha because its range is [0,360)
			// and not centered around 0 like beta and gamma ([-180,180] and [-90,90] respectively)
			if (angle > 180) return angle - 360;
			if (angle < -180) return angle + 360;
			return angle;
		}

		function orientationToCursor(lastOrientation) {
			return {
				// this works because we assume the center (0.5,0.5) is calibrated to (0,0,0) 
				x : clamp01((fixAngle(lastOrientation.alpha) / -cursorFovX) + 0.5),
				y : clamp01((lastOrientation.beta / -cursorFovY) + 0.5),
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

		function ontouchstart(event) {
			touchStartTime = (+new Date);
			lastTouch.x = event.touches[0].pageX;
			lastTouch.y = event.touches[0].pageY;
			touchStart.x = lastTouch.x;
			touchStart.y = lastTouch.y;
			ontouchmove(event);
		}
		
		function ontouchmove(event) {
			processTouch(event.touches[0]);
			if (sendingCursor && ret.cursormode == cursorModes.touchpadabs) {
				zigmoteController.sendToHost('cursor', lastCursor);
			}
			if (sendingCursor && ret.cursormode == cursorModes.touchpadrel) {
				zigmoteController.sendToHost('cursor', lastDelta);
			}
		}

		function ontouchend(event) {
			var dx = dist(lastTouch, touchStart);
			var dt = (+new Date) - touchStartTime;
			if (sendingCursor && dx < 10 && dt < 1000) {
				zigmoteController.sendToHost('click');
			}
		}

		function recalibrate() {
			calibrationOrientation = { 
				alpha : lastRawOrientation.alpha, 
				beta : lastRawOrientation.beta, 
				gamma : lastRawOrientation.gamma
			};
		}

		function internalStart() {
			sendingCursor = true;
			recalibrate();
			zigmoteController.sendToHost('cursorstart');
		}

		var locked;

		// return API
		var ret = {
			start : function(exclusive, callback) {
				if (undefined === exclusive) {
					exclusive = false;
				}

				if (undefined === callback) {
					callback = function() {}
				}

				if (exclusive) {
					zigmoteController.lock("cursor", function(success) {
						if (success) {
							locked = true;
							internalStart();
						}
						callback(success);
					});
				} else {
					internalStart();
					callback(true);
				}
			},

			stop : function() {
				sendingCursor = false;
				if (locked) {
					zigmoteController.unlock("cursor");
					locked = false;
				}
				zigmoteController.sendToHost('cursorstop');
			},

			recalibrate : recalibrate,

			bindtouchpad : function(elementId) {
				var surface = document.getElementById(elementId);
				surface.addEventListener("touchstart", ontouchstart, false);
				surface.addEventListener("touchmove", ontouchmove, false);
				surface.addEventListener("touchend", ontouchend, false);
			},

			updateorientation : false,
			cursormode : cursorModes.off,
		}

		window.ondeviceorientation = function(event) {
			lastRawOrientation.alpha = event.alpha;
			lastRawOrientation.beta = event.beta;
			lastRawOrientation.gamma = event.gamma;

			lastOrientation.alpha = event.alpha - calibrationOrientation.alpha;
			lastOrientation.beta = event.beta - calibrationOrientation.beta;
			lastOrientation.gamma = event.gamma - calibrationOrientation.gamma;

			if (sendingCursor && ret.updateorientation) {			
				zigmoteController.sendToHost('orientation', lastOrientation );
			}

			if (sendingCursor && ret.cursormode == cursorModes.motion) {
				zigmoteController.sendToHost('cursor', orientationToCursor(lastOrientation) );
			}
		}

		zigmoteController.cursor = ret;
		return zigmoteController;
	}

	function host(zigmoteHost) {
		var ret = {
			oncursorlock : function(userid) {},
			oncursorunlock : function() {},
			oncursor : function(x,y,userid) {},
			oncursorstart : function(userid) {},
			oncursorstop : function(userid) {},
			onclick : function(userid) {},
			onorientation : function(a,b,g,userid) {}
		}

		zigmoteHost.onLock("cursor", function(userid) {
			ret.oncursorlock(userid);
		}, function(userid) {
			ret.oncursorunlock(userid);
		});

		zigmoteHost.on("cursor", function(data, userid) {
			ret.oncursor(data.x, data.y, data.mode == "rel", userid);
		});

		zigmoteHost.on("cursorstart", function(data, userid) {
			ret.oncursorstart(userid);
		});

		zigmoteHost.on("cursorstop", function(data, userid) {
			ret.oncursorstop(userid);
		});

		zigmoteHost.on("orientation", function(data, userid) {
			ret.onorientation(data.alpha, data.beta, data.gamma, userid);
		});

		zigmoteHost.on('click', function(data, userid) {
			ret.onclick(userid);
		});

		zigmoteHost.cursor = ret;
		return zigmoteHost;
	}

	// public api
	zigmote.cursor = {
		cursorModes : cursorModes,
	}

	// register as zigmote plugin
	zigmote.plugins.cursor = {
		host : host,
		controller : controller
	}
})(zigmote);