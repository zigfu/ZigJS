//-----------------------------------------------------------------------------
// Includes
//-----------------------------------------------------------------------------
function include(file)
{
	var script  = document.createElement('script');
	script.src  = file;
	script.type = 'text/javascript';
	script.defer = true;
	document.getElementsByTagName('head').item(0).appendChild(script);
}

include("sylvester.js");

//-----------------------------------------------------------------------------
// Event stuff
//-----------------------------------------------------------------------------

function Events() {
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
		return obj;
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

//-----------------------------------------------------------------------------
// Consts
//-----------------------------------------------------------------------------

var Joints = {
 	Invalid 		: 0,
 	Head 			: 1,
 	Neck 			: 2,
 	Torso 			: 3,
 	Waist 			: 4,
 	LeftCollar		: 5,
 	LeftShoulder 	: 6,
 	LeftElbow 		: 7,
 	LeftWrist 		: 8,
 	LeftHand 		: 9,
 	LeftFingertip 	: 10,
 	RightCollar 	: 11,
 	RightShoulder 	: 12,
 	RightElbow 		: 13,
 	RightWrist 		: 14,
 	RightHand 		: 15,
 	RightFingertip 	: 16,
 	LeftHip 		: 17,
 	LeftKnee 		: 18,
 	LeftAnkle 		: 19,
 	LeftFoot 		: 20,
 	RightHip 		: 21,
 	RightKnee 		: 22,
 	RightAnkle 		: 23,
 	RightFoot 		: 24,
};

//-----------------------------------------------------------------------------
// UI session controls
//-----------------------------------------------------------------------------

function SteadyDetector(jointId, maxVariance)
{
	if (undefined === maxVariance) {
		maxVariance = 50;
	}

	var frameCount = 15;
	var pointBuffer = [];
	var steady = false;
	var maxVariance = maxVariance;
	var jointId = jointId;
	var events = Events();
	
	function sumMatrix(mat) {
		var sum = 0;
		elements = mat.elements
		for(var i in elements) {
			for(var j in elements[i]) {
				sum += elements[i][j];
			}
		}
		return sum;
	}
	
	// Reference: Oliver K. Smith: Eigenvalues of a symmetric 3 × 3 matrix. Commun. ACM 4(4): 168 (1961) 
	// find the eigenvalues of a 3x3 symmetric matrix
	function getEigenvalues(mat) {
		var m = mat.trace() / 3;
		var K = mat.subtract( Matrix.I(3).x(m)); // K = mat - I*tr(mat)
		var q = K.determinant() / 2;
		var tempForm = K.x(K);
	 
		var p = sumMatrix(tempForm) / 6;
	 
		// NB in Smith's paper he uses phi = (1/3)*arctan(sqrt(p*p*p - q*q)/q), which is equivalent to below:
		var phi = (1/3)*Math.acos(q/Math.sqrt(p*p*p));
	 
		if (Math.abs(q) >= Math.abs(Math.sqrt(p*p*p))) {
			phi = 0;
		}
	 
		if (phi < 0) {
			phi = phi + Math.PI/3;
		}
	 
		var eig1 = m + 2*Math.sqrt(p)*Math.cos(phi);
		var eig2 = m - Math.sqrt(p)*(Math.cos(phi) + Math.sqrt(3)*Math.sin(phi));
		var eig3 = m - Math.sqrt(p)*(Math.cos(phi) - Math.sqrt(3)*Math.sin(phi));
	 
		return [eig1, eig2, eig3];
	}

	function getCofactorMatrix(mat) {
		var dims = mat.dimensions();
		var xSize = dims.cols;
		var ySize = dims.rows;
		var output = mat.map(function(x, i, j) { return mat.minor(i+1,j+1,xSize-1, ySize-1).determinant(); } );
		return output;
	}

	function getStddevs(vectors) {
		if (vectors.length == 0) { return []; }
		var sum = Vector.Zero(vectors[0].dimensions());
		for(k in vectors) {
			sum = sum.add(vectors[k]);
		}
		var avg = sum.multiply(1/(vectors.length));
		var covarianceMatrix = Matrix.Zero(avg.dimensions(), avg.dimensions());
		for(k in vectors) {
			var temp = vectors[k].subtract(avg);
			covarianceMatrix = covarianceMatrix.map(function(x, i, j) { return x + temp.elements[i-1]*temp.elements[j-1]; } );
		}
		var values = getEigenvalues(covarianceMatrix);
		for (key in values) {
			values[key] = Math.sqrt(Math.abs(values[key]));
		}
		return values;
	}
	
	function clear() {
		pointBuffer = [];
		steady = false;
	}
	
	function addValue(position) {
		pointBuffer.push($V(position));
		while (pointBuffer.length > frameCount) {
			pointBuffer.shift();
		}
		pb = pointBuffer;
		var steadyThisFrame = true;
		var stdDevs = getStddevs(pointBuffer);
		for(var k in stdDevs) {
			steadyThisFrame &= stdDevs[k] < 50;
		}
		if (steadyThisFrame && (!steady)) {
			steady = true;
			events.fireEvent('steady');
			events.fireEvent('steadychanged', steady);
		} else if (!steadyThisFrame && steady) {
			steady = false;
			events.fireEvent('unsteady');
			events.fireEvent('steadychanged', steady);
		}
	}

	function onuserupdate(userData) {
		if (undefined != jointId && userData.skeletonTracked && userData.skeleton.hasOwnProperty(jointId)) {
			addValue(userData.skeleton[jointId].position);
		}
	}

	var publicApi = {
		addValue : addValue,
		onuserupdate : onuserupdate,
	}
	events.eventify(publicApi);
	return publicApi;
}

//-----------------------------------------------------------------------------
// user controls
//-----------------------------------------------------------------------------

function HandSessionDetector(user) {
	var events = Events();
	var api = {
		onlostuser : onlostuser,
		onuserupdate : onuserupdate,
		startSession : startSession,
		stopSession : stopSession,
	}
	events.eventify(api);


	var inSession = false;
	var jointToUse;

	var leftSteady = zig.SteadyDetector(zig.Joints.LeftHand);
	var rightSteady = zig.SteadyDetector(zig.Joints.RightHand);

	leftSteady.addEventListener('steady', function() {
		steadyDetected(zig.Joints.LeftHand);
	});
	rightSteady.addEventListener('steady', function() {
		steadyDetected(zig.Joints.RightHand);
	});

	user.addListener(leftSteady);
	user.addListener(rightSteady);
	user.addListener(api);
	
	function steadyDetected(joint) {
		if (inSession) return;
		// TODO: Check bounding box
		startSession(joint);
	}

	function onuserupdate(userData) {
		if (inSession) {
			events.fireEvent('sessionupdate', userData.skeleton[jointToUse].position);
		}
	}

	function startSession(joint) {
		stopSession();
		inSession = true;
		jointToUse = joint;
		events.fireEvent('sessionstart', user.skeleton[joint].position);
	}

	function stopSession() {
		if (inSession) {
			inSession = false;
			events.fireEvent('sessionend');
		}
	}

	// HACK - this ensures we get notified if our user was lost during a session.
	// if this happens we fire the session end event, and remove our reference from
	// the main zig object
	zig.addListener(api);
	function onlostuser(lostUser) {
		if (lostUser.id === user.id) {
			if (inSession) {
				inSession = false;
				events.fireEvent('sessionend');
			}
			zig.removeListener(api);
		}
	}

	return api;
}


//-----------------------------------------------------------------------------
// user engagers
//-----------------------------------------------------------------------------

function EngageFirstUserInSession() {
	var events = Events();
	var api = {
		onnewuser : onnewuser,
		onlostuser : onlostuser,
	}
	events.eventify(api);
	var engagedUserId = 0;

	function onsessionstart(user, focusPosition) {
		if (engagedUserId != 0) return;

		engagedUserId = user.id;
		events.fireEvent('userengaged', user);
		events.fireEvent('sessionstart', focusPosition);
	}

	function onsessionupdate(user, position) {
		if (user.id == engagedUserId) {
			events.fireEvent('sessionupdate', position);
		}
	}

	function onsessionend(user) {
		if (user.id == engagedUserId) {
			engagedUserId = 0;
			events.fireEvent('sessionend');
			events.fireEvent('userdisengaged', user);
		}
	}

	function onnewuser(newUser) {
		var sessionDetector = HandSessionDetector(newUser);
		sessionDetector.addEventListener('sessionstart', function(focusPosition) {
			onsessionstart(newUser, focusPosition);
		})
		sessionDetector.addEventListener('sessionupdate', function(position) {
			onsessionupdate(newUser, position);
		})
		sessionDetector.addEventListener('sessionend', function() {
			onsessionend(newUser);
		})
	}

	function onlostuser(lostUser) {
		if (lostUser.id == engagedUserId) {
			onsessionend(lostUser);
		}
	}

	return api;
}


//-----------------------------------------------------------------------------
// Main 'zig' object
//-----------------------------------------------------------------------------

var zig = (function() {
	var plugin;
	var events = Events();

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
				var userEvents = Events();
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

		Joints : Joints,

		SteadyDetector : SteadyDetector,
		EngageFirstUserInSession : EngageFirstUserInSession,
	}

	// Make sure our public API supports events
	events.eventify(publicApi);

	return publicApi;

}());