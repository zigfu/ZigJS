(function(zigmote) {
	function controller(zigmoteController) {
		var connected = false;
		var name;
		function connect(gamepadname, callback) {
			zigmoteController.lock("gamepad-" + gamepadname, function(success) {
				connected = success;
				if (success) name = "gamepad-" + gamepadname;
				callback(success);
			});
		}

		function disconnect() {
			if (connected) {
				zigmoteController.unlock(name);
				name = undefined;
				connected = false;
			}
		}

		function bindbutton(button, element) {
			element.addEventListener("touchstart", function(e) {
				zigmoteController.sendToHost("gp-down", { button : button });
				e.preventDefault();
			}, false);
			element.addEventListener("touchend", function(e) {
				zigmoteController.sendToHost("gp-up", { button : button });
				e.preventDefault();
			}, false);
		}

		function binddpad(prefix, element) {

			var dpadbuttons = {
				up : false,
				down : false,
				left : false,
				right : false
			}

			function doDown(button) {
				if (!dpadbuttons[button]) {
					zigmoteController.sendToHost('gp-down', { button : prefix + button });
					dpadbuttons[button] = true;
				}
			}

			function doUp(button) {
				if (dpadbuttons[button]) {
					zigmoteController.sendToHost('gp-up', { button : prefix + button });
					dpadbuttons[button] = false;
				}
			}

			function dpadtouch(e) {
				var touch = e.touches[0];
				var x = touch.pageX - touch.target.offsetLeft;
				var y = touch.pageY - touch.target.offsetTop;
				var w = touch.target.offsetWidth;
				var h = touch.target.offsetHeight;

				// x
				if (x > (2*w / 3)) {
        			doDown("right");
        		}
        		else if (x < (w / 3)) {
        			doDown("left");
        		} else {
        			doUp("left");
        			doUp("right");
        		}

        		// y
        		if (y > (2*h / 3)) {
        			doDown("down");	
        		} else if (y < (h / 3)) {
        			doDown("up");
        		} else {
        			doUp("down");
        			doUp("up");
        		}

        		e.preventDefault();
			}

			function dpadtouchend(e) {
				doUp("left");
				doUp("right");
				doUp("up");
				doUp("down");
				e.preventDefault();
			}

			element.addEventListener("touchstart", dpadtouch, false);
			element.addEventListener("touchmove", dpadtouch, false);
			element.addEventListener("touchend", dpadtouchend, false);
		}

		// return API
		zigmoteController.gamepad = {
			connect : connect,
			disconnect : disconnect,
			bindbutton : bindbutton,
			binddpad : binddpad,
		}

		return zigmoteController;
	}

	function host(zigmoteHost) {

		var players = {} // userid -> gamepad

		function register(gamepadname) {
			var ret = {
				onengage : function(userid) {},
				ondisengage : function(userid) {},
				onbuttondown : function(button) {},
				onbuttonup : function(button) {},
			}

			zigmoteHost.onLock("gamepad-" + gamepadname,
				function(userid) {
					players[userid] = ret;
					ret.onengage(userid);
				},
				function(userid) {
					delete players[userid];
					ret.ondisengage(userid);
				}
			);

			return ret;
		}

		zigmoteHost.on('gp-down', function(data, userid) {
			if (players.hasOwnProperty(userid)) {
				players[userid].onbuttondown(data.button);
			}
		});

		zigmoteHost.on('gp-up', function(data, userid) {
			if (players.hasOwnProperty(userid)) {
				players[userid].onbuttonup(data.button);
			}
		});

		zigmoteHost.gamepad = {
			register : register,
		};
		return zigmoteHost;
	}

	// register as zigmote plugin
	zigmote.plugins.gamepad = {
		host : host,
		controller : controller
	}
})(zigmote);