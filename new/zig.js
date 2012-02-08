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
// Helper objects
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
		return callback;
	}

	function removeEventListener(eventName, callback) {
		eventName = "on" + eventName;
		if (!events.hasOwnProperty(eventName)) return;
		var i = events[eventName].indexOf(callback);
		if (1 >= 0) events[eventName].splice(i,1);
	}

	function addListener(listener) {
		listeners.push(listener);
		return listener;
	}

	function removeListener(listener) {
		if (undefined === listener) {
			listeners = [];
			return;
		}
		var i = listeners.indexOf(listener);
		if (i>=0) listeners.splice(i,1);
	}

	function fireEvent(eventName, arg, specificListener) {
		eventName = "on" + eventName;
		// first listeners
		listeners.forEach(function(listener) {
			if (undefined !== specificListener && specificListener != listener) return;

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

function BoundingBox(size, center) {

	if (undefined === center) {
		center = [0,0,0];
	}
	if (undefined === size) {
		size = [0,0,0];
	}

	var center = $V(center);
	var size = $V(size);
	var extents = size.multiply(0.5);
	var min = center.subtract(extents);
	var max = center.add(extents);

	function contains(point) {
		point = $V(point);
		return (point.e(1) >= min.e(1) && point.e(1) <= max.e(1) && 
				point.e(2) >= min.e(2) && point.e(2) <= max.e(2) &&
				point.e(3) >= min.e(3) && point.e(3) <= max.e(3));
	}

	function recenter(newCenter) {
		center = $V(newCenter);
		min = center.subtract(extents);
		max = center.add(extents);
	}

	function resize(newSize) {
		size = $V(size);
		extents = size.multiply(0.5);
		min = center.subtract(extents);
		max = center.add(extents);
	}

	function inspect() {
		console.log({center: center, size: size, min : min, max : max});
	}

	return {
		contains : contains,
		resize : resize,
		recenter : recenter,
		inspect : inspect
	}
}

function clamp(x, min, max)
{
	if (x < min) return min;
	if (x > max) return max;
	return x;
}

function lerp(from, to, amount) 
{
	return from + ((to - from) * amount);
}

function vlerp(p1,p2,r)
{
	out = [];
	for (i=0;i<p1.length;i++)
	{	
		out.push(p2[i]*r+p1[i]*(1-r));
	}
	return out;
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

function SteadyDetector(jointId, maxVariance) {
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
			steadyThisFrame &= stdDevs[k] < maxVariance;
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

// Fader
function Fader(orientation, size) {
	// defaults
	size = size || 250;

	// return object
	var api = {
		itemsCount : 1,
		hysteresis : 0.1,
		initialValue : 0.5,
		flip : false,
		value : 0,
		selectedItem : 0,
		size : size,
		orientation : orientation,
		updatePosition : updatePosition,
		updateValue : updateValue,
		moveTo : moveTo,
		moveToContain : moveToContain,
		onsessionstart : onsessionstart,
		onsessionupdate : onsessionupdate,
		onsessionend : onsessionend,
	}
	var events = Events();
	events.eventify(api);

	var center = [0,0,0];

	// hand point control callbacks

	function onsessionstart(focusPosition) {
		moveTo(focusPosition, api.initialValue);
		api.value = api.initialValue;
		api.selectedItem = Math.floor(api.itemsCount * api.value);
		events.fireEvent('itemselected', api.selectedItem);
	}

	function onsessionupdate(position) {
		updatePosition(position);
	}

	function onsessionend() {
		events.fireEvent('itemunselected', api.selectedItem);
	}

	function updatePosition(position) {
		var distanceFromCenter = position[api.orientation] - center[api.orientation];
		var ret = (distanceFromCenter / api.size) + 0.5;
		ret = clamp(ret, 0, 1);
		if (api.flip) ret = 1 - ret;
		updateValue(ret);
	}

	function updateValue(val) {
		var newSelected = api.selectedItem;
		var minValue = (api.selectedItem * (1 / api.itemsCount)) - api.hysteresis;
		var maxValue = (api.selectedItem + 1) * (1 / api.itemsCount) + api.hysteresis;
		
		api.value = val;
		events.fireEvent('valuechange', api.value);
		
		if (api.value > maxValue) {
			newSelected++;
		}
		if (api.value < minValue) {
			newSelected--;
		}
		
		if (newSelected != api.selectedItem) {
			events.fireEvent('itemunselected', api.selectedItem);
			api.selectedItem = newSelected;
			events.fireEvent('itemselected', newSelected);
		}		
	}
	
	function moveTo(position, value) {
		if (api.flip) value = 1 - value;
		center[api.orientation] = position[api.orientation] + ((0.5 - value) * api.size);
	}
	
	function moveToContain(position) {
		var distanceFromCenter = position[api.orientation] - center[api.orientation];
		if (distanceFromCenter > api.size / 2) {
			center[api.orientation] += distanceFromCenter - (api.size / 2);
		} else if (distanceFromCenter < api.size / -2) {
			center[api.orientation] += distanceFromCenter + (api.size / 2);
		}
	}

	return api;
}

//-----------------------------------------------------------------------------
// user controls
//-----------------------------------------------------------------------------

function HandSessionDetector() {
	var events = Events();
	var api = {
		//onlostuser : onlostuser,
		onuserupdate : onuserupdate,
		onattachtouser : onattachtouser,
		ondetachfromuser : ondetachfromuser,
		startSession : startSession,
		stopSession : stopSession,
	}
	events.eventify(api);

	var bboxOffset = $V([0, 250, -300]);
	var bbox = BoundingBox([1000, 500, 500]);

	var shouldRotateHand = true;
	var inSession = false;
	var jointToUse;
	var framesNotInBbox = 0;
	var maxFramesNotInBbox = 15;

	var currentUser;
	var leftSteady = zig.SteadyDetector(zig.Joints.LeftHand);
	var rightSteady = zig.SteadyDetector(zig.Joints.RightHand);

	leftSteady.addEventListener('steady', function() {
		steadyDetected(zig.Joints.LeftHand);
	});
	rightSteady.addEventListener('steady', function() {
		steadyDetected(zig.Joints.RightHand);
	});

	function onattachtouser(user) {
		currentUser = user;
		user.addListener(leftSteady);
		user.addListener(rightSteady);
	}

	function ondetachfromuser(user) {
		if (inSession) {
			inSession = false;
			events.fireEvent('sessionend');
		}
		currentUser = undefined;
	}
	
	function rotatedPoint(point) {
		return (shouldRotateHand) ? rotatePoint(point, currentUser.position) : point;
	}

	function inBbox(point) {
		var userPosition = rotatedPoint(currentUser.position);
		bbox.recenter($V(userPosition).add(bboxOffset));
		return bbox.contains(rotatedPoint(point));
	}

	function steadyDetected(joint) {
		if (inSession) return;
		
		if (inBbox(currentUser.skeleton[joint].position)) {
			startSession(joint);
		}
	}

	function onuserupdate(userData) {
		if (inSession) {
			if (!inBbox(userData.skeleton[jointToUse].position)) {
				framesNotInBbox++;
				if (framesNotInBbox >= maxFramesNotInBbox) {
					framesNotInBbox = 0;
					stopSession();
				}
			} else {
				framesNotInBbox = 0;
				events.fireEvent('sessionupdate', rotatedPoint(userData.skeleton[jointToUse].position));
			}
		}
	}

	function startSession(joint) {
		stopSession();
		inSession = true;
		jointToUse = joint;
		events.fireEvent('sessionstart', rotatedPoint(currentUser.skeleton[joint].position));
	}

	function stopSession() {
		if (inSession) {
			inSession = false;
			events.fireEvent('sessionend');
		}
	}

	function rotatePoint(handPos, comPos)
	{
		// change the forward vector to be u = (CoM - (0,0,0))
		// instead of (0,0,1)
		var cx = comPos[0];
		var cy = comPos[1];
		var cz = comPos[2];
		
		var len = Math.sqrt(cx*cx + cy*cy + cz*cz);
		// project the vector to XZ plane, so it's actually (cx,0,cz). let's call it v
		// so cos(angle) = v . u / (|u|*|v|)
		var lenProjected = Math.sqrt(cx*cx + cz*cz);
		var cosXrotation = (cx*cx + cz*cz) / (lenProjected * len); // this can be slightly simplified
		var xRot = Math.acos(cosXrotation);
		if (cy < 0) xRot = -xRot; // set the sign which we lose in 
		// now for the angle between v and the (0,0,1) vector for Y-axis rotation
		var cosYrotation = cz / lenProjected;
		var yRot = Math.acos(cosYrotation);
		if (cx > 0) yRot = -yRot;
		return (Matrix.RotationX(xRot).x(Matrix.RotationY(yRot))).x($V(handPos)).elements;
	}

	/*
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
	}*/

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
		var sessionDetector = HandSessionDetector();

		sessionDetector.addEventListener('sessionstart', function(focusPosition) {
			onsessionstart(newUser, focusPosition);
		});
		sessionDetector.addEventListener('sessionupdate', function(position) {
			onsessionupdate(newUser, position);
		});
		sessionDetector.addEventListener('sessionend', function() {
			onsessionend(newUser);
		});

		newUser.addListener(sessionDetector);
	}

	function onlostuser(lostUser) {
		if (lostUser.id == engagedUserId) {
			onsessionend(lostUser);
		}
	}

	return api;
}


function EngageUsersWithSkeleton(count) {
	if (undefined === count) {
		count = 1;
	}

	var events = Events();
	var api = {
		onlostuser : onlostuser,
		ondataupdate : ondataupdate,
	}
	events.eventify(api);

	var engagedUsers = [];

	function ondataupdate(zigObject) {
		// if we're looking for more users to engage
		if (engagedUsers.length < count) {
			for (var userid in zigObject.users) if (zigObject.users.hasOwnProperty(userid)) {
				var user = zigObject.users[userid];
				if (user.skeletonTracked && (-1 == engagedUsers.indexOf(user))) {
					if (engagedUsers.length < count) {
						engagedUsers.push(user);
						events.fireEvent('userengaged', user);
					}
				}
			}

			if (engagedUsers.length == count) {
				events.fireEvent('allusersengaged', engagedUsers);
			}
		}
	}

	function onlostuser(lostUser) {
		var i = engagedUsers.indexOf(lostUser);
		if (-1 != i) {
			engagedUsers.splice(i, 1);
			events.fireEvent('userdisengaged', lostUser);
		}
	}

	return api;
}

//-----------------------------------------------------------------------------
// Main 'zig' object
//-----------------------------------------------------------------------------

var zig = (function() {
	var plugin;

	// both of these will hold data per user (indexed by userid)
	var trackedUsers = {};
	var userCallbacks = {};

	var publicApi = {
		init : init,
		verbose : verbose,
		users : trackedUsers,

		Joints : Joints,

		SteadyDetector : SteadyDetector,
		Fader : Fader,
		HandSessionDetector : HandSessionDetector,
		EngageFirstUserInSession : EngageFirstUserInSession,
		EngageUsersWithSkeleton : EngageUsersWithSkeleton,
	}

	// Make sure our public API supports events
	var events = Events();
	events.eventify(publicApi);

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
				newUser.update(users[key]);

				// expose Events interface, but override default functionality
				userEvents.eventify(newUser);
				newUser.addListener = function(listener) {
					userEvents.addListener(listener);
					userEvents.fireEvent('attachtouser', newUser, listener);
				}
				newUser.removeListener = function(listener) {
					userEvents.removeListener(listener);
					userEvents.fireEvent('detachfromuser', newUser, listener);
				}

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
		toRemove.forEach(function(user) { log('Lost user: ' + user.id); user.removeListener(); events.fireEvent('lostuser', user); });
		toAdd.forEach(function(user) { log('New user: ' + user.id); events.fireEvent('newuser', user); });

		// fire all update events (dataupdate for all users and userupdate for each user)
		events.fireEvent('dataupdate', publicApi);
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

	return publicApi;

}());