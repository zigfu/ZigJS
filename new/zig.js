function makeEvents() {
	var events = {};
	var listeners = [];	

	function addEventListener(eventName, callback) {
		if (!events.hasOwnProperty(eventName)) {
			events[eventName] = [];
		}
		events[eventName].push(callback);
	}

	function removeEventListener(eventName, callback) {
		if (!events.hasOwnProperty(eventName)) return;
		var i = events[eventName].indexOf(callback);
		if (1 >= 0) events[eventName].splice(i,1);
	}

	function addListener(listener) {
		listeners.push(listener);
	}

	function removeListener(listener) {
		var i = listeners.indexOf(listener);
		if (i>=0) listeners.splice(i,1);
	}

	function fireEvent(eventName, arg) {
		// first listeners
		listeners.forEach(function(listener) { 
			if (listener.hasOwnProperty(eventName)) {
				try {
					listener[eventName].call(listener, arg);
				} catch (e) { console.log("Error calling callback for " + eventName + ": " + e); }
			}
		});

		// and then events
		if (events.hasOwnProperty(eventName)) {
			events[eventName].forEach(function(cb) {
				try {
					cb.call(null, arg);
				} catch (e) { console.log("Error calling callback for " + eventName + ": " + e); }
			});
		}
	}

	return {
		addEventListener : addEventListener,
		removeEventListener : removeEventListener,
		addListener : addListener,
		removeListener : removeListener,
		fireEvent : fireEvent
	}
}

var zig = (function() {
	var plugin;
	var verbose = true;
	var events = makeEvents();

	var perUserCallbacks = {};

	function log(text) {
		if (verbose) console.log("Zig: " + text);
	}

	function bindDomEvent(target,eventName,handlerName) {
		if (target.attachEvent) {
			target.attachEvent("on" + eventName, handlerName);
		} else if ( target.addEventListener ) {
			target.addEventListener(eventName, handlerName, false);
		} else {
			target["on" + eventName] = handlerName;
		}
	}

	function doUpdate(users) {
		
	}

	function init(pluginElement) {
		// TODO: handle pluginElement = id (string)
		// TODO: handle pluginElement = undefined
		plugin = pluginElement;
		bindDomEvent(pluginElement, "NewFrame", function () { return function(data) { var obj = JSON.parse(data); doUpdate(obj.users); }}());
		log("inited");
	}

	return {
		// 
		init : init,
		verbose : verbose,

		// event stuff
		addListener : events.addListener,
		removeListener : events.removeListener,
		addEventListener : events.addEventListener,
		removeEventListener : events.removeEventListener,
	}

}());