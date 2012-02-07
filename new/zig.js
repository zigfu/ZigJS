function makeEvents() {
	var events = {};
	var listeners = [];	

	function addEventListener(eventName, callback) {
		eventName = "on" + eventName;
		if (!events.hasOwnProperty(eventName)) {
			events[eventName] = [];
		}
		events[eventName].push(callback);
	}

	function removeEventListener(eventName, callback) {
		eventName = "on" + eventName;
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
		eventName = "on" + eventName;
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

	function eventify(obj) {
		obj.addEventListener = addEventListener;
		obj.removeEventListener = removeEventListener;
		obj.addListener = addListener;
		obj.removeListener = removeListener;
	}

	return {
		addEventListener : addEventListener,
		removeEventListener : removeEventListener,
		addListener : addListener,
		removeListener : removeListener,
		fireEvent : fireEvent,
		eventify : eventify,
	}
}

var zig = (function() {
	var plugin;
	var events = makeEvents();

	// both of these will hold data per user (indexed by userid)
	var trackedUsers = {};
	var userCallbacks = {};

	var isVerbose = true;
	function verbose(v) {
		if (undefined === v) {
			return isVerbose;
		} else {
			isVerbose = v;
		}
	}

	function log(text) {
		if (isVerbose) console.log("Zig: " + text);
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

	function getItemById(collection, id) {
		for (key in collection) if (collection.hasOwnProperty(key)) {
			if (collection[key].id == id) return collection[key];
		}
		return undefined;
	}

	function doUpdate(users) {
		var toRemove = [];
		var toAdd = [];

		// find users to remove
		for (var userid in trackedUsers) if (trackedUsers.hasOwnProperty(userid)) {
			if (undefined === getItemById(users, userid)) {
				var lostUser = trackedUsers[userid];
				delete trackedUsers[userid];
				toRemove.push(lostUser);
			}
		}

		// find users to add
		for (var key in users) if (users.hasOwnProperty(key)) {
			if (!trackedUsers.hasOwnProperty(users[key].id)) {
				
				// create the new user & feed it with initial data
				var userEvents = makeEvents();
				var newUser = {
					update : function(userData) {
						this.id = userData.id;
						this.positionTracked = true;
						this.position = userData.centerofmass;
						this.skeletonTracked = (userData.tracked > 0);

						// convert joints from an array to associative list for easier access
						var currjoints = userData.joints;
						var newjoints = {};
						for (var i=0; i<currjoints.length; i++) {
							newjoints[currjoints[i].id] = currjoints[i];
						}
						this.skeleton = newjoints;
					}
				};
				userEvents.eventify(newUser);
				newUser.update(users[key]);

				// add to internal lists
				trackedUsers[newUser.id] = newUser;
				userCallbacks[newUser.id] = userEvents;

				// keep track for later
				toAdd.push(newUser);
			}
		}

		// update user data for each tracked user
		for (var userid in trackedUsers) if (trackedUsers.hasOwnProperty(userid)) {
			var user = getItemById(users, userid);
			if (undefined === user) {
				console.log('ERROR!! getItemById returned undefined for userid ' + userid);
				console.log(users);
				console.log(trackedUsers);
				continue;
			} 
			trackedUsers[userid].update(getItemById(users, userid));
		}

		// fire all add/remove events
		toRemove.forEach(function(user) { log('Lost user: ' + user.id); events.fireEvent('lostuser', user); });
		toAdd.forEach(function(user) { log('New user: ' + user.id); events.fireEvent('newuser', user); });

		// fire all update events (dataupdate for all users and userupdate for each user)
		events.fireEvent('dataupdate', trackedUsers);
		for (var userid in trackedUsers) if (trackedUsers.hasOwnProperty(userid)) {
			userCallbacks[userid].fireEvent('userupdate', trackedUsers[userid]);
		}
	}

	function init(pluginElement) {
		// TODO: handle pluginElement = id (getElementById)
		// TODO: handle pluginElement = undefined (add object tag)
		plugin = pluginElement;
		bindDomEvent(pluginElement, "NewFrame", function () {
		 return function(data) { 
		 	try {
				var obj = JSON.parse(data); 
				doUpdate(obj.users);
			} catch (e) { 
				console.log("Error parsing JSON from plugin, skipping frame");
			}
		 }}());
		log("inited");
	}

	// return public API
	var publicApi = {
		init : init,
		verbose : verbose,
		trackedUsers : trackedUsers,
	}

	// Make sure our public API supports events
	events.eventify(publicApi);

	return publicApi;

}());