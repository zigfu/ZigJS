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

function FpsCounter() {
	var lastFrame;

	var pub = {
		markframe : markframe,
		lastDelta : 0,
		fps : 0,
	}

	function markframe(timestamp) {
		timestamp = timestamp || (new Date()).getTime();
		lastFrame = lastFrame || timestamp;
		pub.lastDelta = ((timestamp - lastFrame) / 1000);
		pub.fps = 1 / pub.lastDelta;
		lastFrame = timestamp;
	}

	return pub;
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

var Orientation = {
	X : 0,
	Y : 1,
	Z : 2,
}

//-----------------------------------------------------------------------------
// UI session controls
//-----------------------------------------------------------------------------

function SteadyDetector(jointId, maxVariance) {
	if (undefined === maxVariance) {
		maxVariance = 50;
	}

	var frameCount = 15;
	var pointBuffer = [];
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
		publicApi.isSteady = false;
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
			steadyThisFrame &= stdDevs[k] < publicApi.maxVariance;
		}
		if (steadyThisFrame && (!publicApi.isSteady)) {
			publicApi.isSteady = true;
			events.fireEvent('steady', publicApi);
			events.fireEvent('steadychanged', publicApi);
		} else if (!steadyThisFrame && publicApi.isSteady) {
			publicApi.isSteady = false;
			events.fireEvent('unsteady', publicApi);
			events.fireEvent('steadychanged', publicApi);
		}
	}

	function onuserupdate(userData) {
		if (undefined != jointId && userData.skeletonTracked && userData.skeleton.hasOwnProperty(jointId)) {
			addValue(userData.skeleton[jointId].position);
		}
	}

	var publicApi = {
		addValue : addValue,
		maxVariance : maxVariance,
		isSteady : false,
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
		driftAmount : 0,
		autoMoveToContain : false,
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

	var isEdge = false;
	var center = [0,0,0];
	var fps = FpsCounter();

	// hand point control callbacks

	function onsessionstart(focusPosition) {
		moveTo(focusPosition, api.initialValue);
		api.value = api.initialValue;
		api.selectedItem = Math.floor(api.itemsCount * api.value);
		events.fireEvent('itemselected', api);
	}

	function onsessionupdate(position) {
		updatePosition(position);
	}

	function onsessionend() {
		events.fireEvent('itemunselected', api);
	}

	function updatePosition(position) {
		fps.markframe();
		if (api.autoMoveToContain) {
			moveToContain(position);
		}

		var distanceFromCenter = position[api.orientation] - center[api.orientation];
		var ret = (distanceFromCenter / api.size) + 0.5;
		ret = clamp(ret, 0, 1);
		if (api.flip) ret = 1 - ret;
		updateValue(ret);

		if (api.driftAmount != 0) {
			var delta = api.initialValue - api.value;
			moveTo(position, api.value + (delta * 0.05));//api.driftAmount * fps.lastDelta));
		}
	}

	function updateValue(val) {
		var newSelected = api.selectedItem;
		var minValue = (api.selectedItem * (1 / api.itemsCount)) - api.hysteresis;
		var maxValue = (api.selectedItem + 1) * (1 / api.itemsCount) + api.hysteresis;
		
		api.value = val;
		events.fireEvent('valuechange', api);
		
		var isThisFrameEdge = (val == 0) || (val == 1);
		if (!isEdge && isThisFrameEdge) {
			events.fireEvent('edge', api);
		}
		isEdge = isThisFrameEdge;

		if (api.value > maxValue) {
			newSelected++;
		}
		if (api.value < minValue) {
			newSelected--;
		}
		
		if (newSelected != api.selectedItem) {
			events.fireEvent('itemunselected', api);
			api.selectedItem = newSelected;
			events.fireEvent('itemselected', api);
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

function PushDetector(size) {
	size = size || 250;

	var api = {
		isPushed : false,
		pushProgress : 0,
		pushTime : 0,
		driftAmount : 15,
		onsessionstart: onsessionstart,
		onsessionupdate: onsessionupdate,
		onsessionend : onsessionend,
	}
	var events = Events();
	events.eventify(api);

	var fader = Fader(Orientation.Z, size);
	fader.flip = true; // positive Z is backwards by default, so flip it
	fader.initialValue = 0.2;
	fader.autoMoveToContain = true;

	fader.driftAmount = api.driftSpeed; // mm/s
	
	function onsessionstart(focusPosition) {
		fader.onsessionstart(focusPosition);
	}

	function onsessionupdate(position) {
		fader.moveToContain(position);
		fader.onsessionupdate(position);
		api.pushProgress = fader.value;
		
		if (!api.isPushed) {
			if (1.0 == api.pushProgress) {
				api.isPushed = true;
				api.pushTime = (new Date()).getTime();
				api.pushPosition = position;
				fader.driftAmount = 0; // stop drifting when pushed
				events.fireEvent('push', api);
			}
		} else {
			if (api.pushProgress < 0.5) {
				api.isPushed = false;
				fader.driftAmount = api.driftAmount;
				if (isClick()) {
					events.fireEvent('click', api);
				}
				events.fireEvent('release', api);
			}
		}
	}
	
	function onsessionend() {
		fader.onsessionend();
		if (api.isPushed) {
			api.isPushed = false;
			events.fireEvent('release', api);
		}
	}

	function isClick() {
		var delta = (new Date()).getTime() - api.pushTime;
		return (delta < 1000);
	} 

	return api;
}

function SwipeDetector() {
	var events = Events();
	var horizontalFader = Fader(Orientation.X);
	var verticalFader = Fader(Orientation.Y);
	var api = {
		driftAmount : 20,
		horizontalFader : horizontalFader,
		verticalFader : verticalFader,
		isSwiped : false,
		onsessionstart: onsessionstart,
		onsessionupdate: onsessionupdate,
		onsessionend : onsessionend,
		onedge : onedge,
		onvaluechange : onvaluechange,
	}
	events.eventify(api);

	horizontalFader.autoMoveToContain = true;
	verticalFader.autoMoveToContain = true;
	horizontalFader.driftAmount = api.driftAmount;
	verticalFader.driftAmount = api.driftAmount;

	horizontalFader.swipeDirections = ['left','right'];
	verticalFader.swipeDirections = ['down','up'];

	horizontalFader.addListener(api);
	verticalFader.addListener(api);

	function onedge(fader) {
		console.log('edge');
		var dir = fader.swipeDirections[fader.value];
		events.fireEvent('swipe' + dir, api);
		events.fireEvent('swipe', dir);
		fader.driftAmount = 0;
		fader.swipeValue = fader.value;
	}

	function onvaluechange(fader) {
		if (undefined !== fader.swipeValue) {
			if (Math.abs(fader.swipeValue - fader.value) >= 0.5) {
				delete fader.swipeValue;
				fader.driftAmount = api.driftAmount;
				events.fireEvent('swiperelease', api);
			}
		}
	}

	function onsessionstart(focusPosition) {
		horizontalFader.onsessionstart(focusPosition);
		verticalFader.onsessionstart(focusPosition);
	}
	function onsessionupdate(position) {
		horizontalFader.onsessionupdate(position);
		verticalFader.onsessionupdate(position);
	}
	function onsessionend() {
		horizontalFader.onsessionend();
		verticalFader.onsessionend();
	}

	return api;
}

//-----------------------------------------------------------------------------
// user controls
//-----------------------------------------------------------------------------

function HandSessionDetector() {
	var events = Events();
	var api = {
		//onuserlost : onuserlost,
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

	return api;
}


//-----------------------------------------------------------------------------
// user engagers
//-----------------------------------------------------------------------------

function EngageFirstUserInSession() {
	var events = Events();
	var api = {
		onuserfound : onuserfound,
		onuserlost : onuserlost,
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

	function onuserfound(newUser) {
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

	function onuserlost(lostUser) {
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
		onuserlost : onuserlost,
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

	function onuserlost(lostUser) {
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
		PushDetector : PushDetector,
		SwipeDetector : SwipeDetector,
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
		toRemove.forEach(function(user) { log('Lost user: ' + user.id); user.removeListener(); events.fireEvent('userlost', user); });
		toAdd.forEach(function(user) { log('New user: ' + user.id); events.fireEvent('userfound', user); });

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