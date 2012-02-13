if (undefined === zig) {

// script: zig.js
// Does stuff

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
				if (undefined !== specificListener && specificListener != cb) return;
				try {
					cb.call(null, arg);
				} catch (e) { console.log("Error calling callback for " + eventName + ": " + e); }
			});
		}
	}

	function eventify(obj) {
		obj.addEventListener = addEventListener;
		obj.removeEventListener = removeEventListener;
		obj.addListener = function(listener) {
			addListener(listener);
			fireEvent('attach', obj, listener);
			return listener;
		}
		obj.removeListener = function(listener) {
			fireEvent('detach', obj, listener);
			removeListener(listener);
		}

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

function clamp(x, min, max) {
	if (x < min) return min;
	if (x > max) return max;
	return x;
}

function vclamp(v, vmin, vmax) {
	return [clamp(v[0], vmin[0], vmax[0]), clamp(v[1], vmin[1], vmax[1]), clamp(v[2], vmin[2], vmax[2])];
}

function lerp(from, to, amount) {
	return from + ((to - from) * amount);
}

function vlerp(p1,p2,r) {
	out = [];
	for (i=0;i<p1.length;i++) {	
		out.push(p2[i]*r+p1[i]*(1-r));
	}
	return out;
}

function vscale(v1, v2) {
	return [v1[0]*v2[0], v1[1]*v2[1], v1[2]*v2[2]];
}

var Joint = {
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

// group: Single point controls

//class: SteadyDetector
function SteadyDetector(maxVariance) {
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
	
	// Reference : Oliver K. Smith: Eigenvalues of a symmetric 3 × 3 matrix. Commun. ACM 4(4): 168 (1961) 
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

	function onsessionstart(focusPosition) {
		clear();
	}

	function onsessionupdate(position) {
		addValue(position);
	}
	
	var publicApi = {
		addValue : addValue,
		maxVariance : maxVariance,
		onsessionstart : onsessionstart,
		onsessionupdate : onsessionupdate,
		isSteady : false,
	}
	events.eventify(publicApi);
	return publicApi;
}

// class: Fader
// Simple 1D fader
function Fader(orientation, size) {
	// defaults
	size = size || 250;

	// return object
	var api = {
		// property: itemsCount
		// How many logical items on our Fader
		itemsCount : 1,
		// property: hysteresis
		// blah blah blah
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

//class: Fader3D
// 3D fader
function Fader3D(size) {
	var events = Events();
	var api = {
		size : size,
		value : [0,0,0],
		initialValue : [0.5, 0.5, 0.5],
		onsessionstart : onsessionstart,
		onsessionupdate : onsessionupdate,
		onsessionend : function() {},
	}
	events.eventify(api);

	var center = [0,0,0];

	function onsessionstart(focusPosition) {
		moveTo(focusPosition, api.initialValue);
	}

	function onsessionupdate(position) {
		var d = $V(position).subtract($V(center)).elements;
		var val = [clamp((d[0]/api.size[0]) + 0.5, 0, 1),
				   clamp((d[1]/api.size[1]) + 0.5, 0, 1),
				   clamp((d[2]/api.size[2]) + 0.5, 0, 1)];
		updateValue(val);
	}

	function updateValue(value) {
		api.value = value;
		events.fireEvent('valuechange', api);
	}

	function moveTo(position, value) {
		//var delta = vscale($V([0.5,0.5,0.5]).subtract($V(value)).elements, api.size);
		//center = position.add($V(delta)).elements;
		center[0] = position[0] + ((0.5 - value[0]) * api.size[0]);
		center[1] = position[1] + ((0.5 - value[1]) * api.size[1]);
		center[2] = position[2] + ((0.5 - value[2]) * api.size[2]);
	}

	return api;
}

// class: Fader2D
// This is the 2d version of the popular fader
function Fader2D(width, height) {
	width = width || 300;
	height = height || 250;

	var events = Events();
	var api = {
		width : width,
		height : height,
		value : [0,0],
		onsessionstart : onsessionstart,
		onsessionupdate : onsessionupdate,
		onsessionend : onsessionend,
	}
	events.eventify(api);

	var fader3d = Fader3D([width, height, 1]);
	fader3d.addEventListener('valuechange', function(f) {
		api.value[0] = f.value[0];
		api.value[1] = f.value[1];
		events.fireEvent('valuechange', api);
	});

	function onsessionstart(focusPosition) {
		fader3d.onsessionstart(focusPosition);
	}
	function onsessionupdate(position) {
		fader3d.size[0] = api.width;
		fader3d.size[1] = api.height;
		fader3d.onsessionupdate(position);
	}
	function onsessionend() {
		fader3d.onsessionend();
	}

	return api;
}

// class: PushDetector
// Detects push gestures
function PushDetector(size) {
	size = size || 200;

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

// class: SwipeDetector
// Detects swipes
function SwipeDetector() {
	var events = Events();
	var horizontalFader = Fader(Orientation.X);
	var verticalFader = Fader(Orientation.Y);
	var api = {
		driftAmount : 20,
		horizontalFader : horizontalFader,
		verticalFader : verticalFader,
		isSwiped : false,
		/*nsessionstart: onsessionstart,
		onsessionupdate: onsessionupdate,
		onsessionend : onsessionend,*/
		onattach : onattach,
		ondetach : ondetach,
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

	function onattach(target) {
		target.addListener(horizontalFader);
		target.addListener(verticalFader);
	}

	function ondetach(target) {
		target.removeListener(horizontalFader);
		target.removeListener(verticalFader);
	}

	return api;
}

// class: Cursor
// Use this for your cursor needs
function Cursor() {
	var fader2d = Fader2D();
	var pushDetector = PushDetector();

	var events = Events();
	var api = {
		onattach : onattach,
		ondetach : ondetach,
		pushDetector : pushDetector,
		fader2d : fader2d,
		value : [0,0],
		x : 0,
		y : 0,
	}
	events.eventify(api);
	
	fader2d.addEventListener('valuechange', function(f) {
		api.value[0] = api.x = f.value[0];
		api.value[1] = api.y = 1 - f.value[1];
		events.fireEvent('move', api);
	});

	pushDetector.addEventListener('push', function(pd) {
		events.fireEvent('push', api);
	});
	pushDetector.addEventListener('release', function(pd) {
		events.fireEvent('release', api);
	});
	pushDetector.addEventListener('click', function(pd) {
		events.fireEvent('click', api);
	});

	function onattach(target) {
		target.addListener(fader2d);
		target.addListener(pushDetector);
	}

	function ondetach(target) {
		target.removeListener(fader2d);
		target.removeListener(pushDetector);
	}

	return api;
}

// class: WaveDetector
// Detects wave gestures
function WaveDetector() {
	var fader = Fader(Orientation.X, 100);
	fader.autoMoveToContain = true;
	fader.driftAmount = 15;

	var api = {
		onattach : onattach,
		ondetach : ondetach,
		fader : fader,
		numberOfWaves : 5,
	}
	var events = Events();
	events.eventify(api);

	var edgebuffer = []
	var lastEdge = -1;

	fader.addEventListener('edge', function(f) {
		var now = (new Date()).getTime();
		while ((edgebuffer.length > 0) && (now - edgebuffer[0] > 2000)) edgebuffer.shift();
		if (edgebuffer.length == 0) lastEdge = -1;
		if (lastEdge != f.value) edgebuffer.push(now);
		lastEdge = f.value;

		if (edgebuffer.length >= api.numberOfWaves) {
			events.fireEvent('wave', api);
			edgebuffer=[];
		}
	});

	function onattach(target) {
		target.addListener(fader);
	}
	function ondetach(target) {
		target.removeListener(fader);
	}

	return api;
}

//-----------------------------------------------------------------------------
// user controls
//-----------------------------------------------------------------------------

// class: HandSessionDetector
// Manages the lifetime of hand point based sessions. Controls can be attached 
// to the session detector with <HandSessionDetector.addListener>
function HandSessionDetector() {
	var events = Events();
	var api = {
		shouldRotateHand : true,
		shouldSmoothPoints : true,
		onuserupdate : onuserupdate,
		onattach : onattach,
		ondetach : ondetach,
		startSession : startSession,
		stopSession : stopSession,
		startOnWave : false,
		startOnSteady : true,
	}
	events.eventify(api);

	var bboxOffset = $V([0, 250, -300]);
	var bbox = BoundingBox([1000, 500, 500]);

	var rotateReference;
	var inSession = false;
	var jointToUse;
	var framesNotInBbox = 0;
	var maxFramesNotInBbox = 15;
	var lastPosition = [0,0,0];

	var currentUser;

	function onattach(user) {
		currentUser = user;
		rotateReference = user.position;

		if (api.startOnWave) {
			var wdLeft = WaveDetector();
			var wdRight = WaveDetector();
			wdLeft.addEventListener('wave', sessionShouldStart);
			wdRight.addEventListener('wave', sessionShouldStart);
			user.mapJointToControl(Joint.LeftHand, wdLeft);
			user.mapJointToControl(Joint.RightHand, wdRight);
		}

		if (api.startOnSteady) {
			var sdLeft = SteadyDetector();
			var sdRight = SteadyDetector();
			sdLeft.addEventListener('steady', sessionShouldStart);
			sdRight.addEventListener('steady', sessionShouldStart);
			user.mapJointToControl(Joint.LeftHand, sdLeft);
			user.mapJointToControl(Joint.RightHand, sdRight);
		}
	}

	function ondetach(user) {
		if (inSession) {
			inSession = false;
			events.fireEvent('sessionend');
		}
		currentUser = undefined;
		// TODO: unmap joint->control
	}
	
	function rotatedPoint(point) {
		return (api.shouldRotateHand) ? rotatePoint(point, rotateReference) : point;
	}

	function inBbox(point) {
		var userPosition = rotatedPoint(currentUser.position);
		bbox.recenter($V(userPosition).add(bboxOffset));
		return bbox.contains(rotatedPoint(point));
	}

	function sessionShouldStart(detector) {
		if (inSession) return;
		
		if (inBbox(currentUser.skeleton[detector.mappedJoint].position)) {
			startSession(detector.mappedJoint);
		}
	}

	function onuserupdate(userData) {
		rotateReference = vlerp(rotateReference, userData.position, 0.5);
		if (inSession) {
			if (!inBbox(userData.skeleton[jointToUse].position)) {
				framesNotInBbox++;
				if (framesNotInBbox >= maxFramesNotInBbox) {
					framesNotInBbox = 0;
					stopSession();
				}
			} else {
				framesNotInBbox = 0;
				var position = rotatedPoint(userData.skeleton[jointToUse].position);
				if (api.shouldSmoothPoints) {
					position = vlerp(lastPosition, position, 0.8);
				}
				lastPosition = position;
				events.fireEvent('sessionupdate', lastPosition);
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

// class: EngageFirstUserInSession
// Waits for the first user in session
function EngageFirstUserInSession() {
	var events = Events();
	var api = {
		onuserfound : onuserfound,
		onuserlost : onuserlost,
		engagedUser : null,
	}
	events.eventify(api);
	var engagedUserId = 0;

	function onsessionstart(user, focusPosition) {
		if (engagedUserId != 0) return;

		engagedUserId = user.id;
		api.engagedUser = user;
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
			api.engagedUser = null;
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

// class: EngageUsersWithSkeleton
// Waits for the first <count> users with skeleton tracking to enter the frame
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

// class: UserJoint
// Represents a tracked joint
function UserJoint() {
// property: id
// The <zig.Joint> of this joint
var id;
// property: position
// Joint position
var position;
// property: rotation
// Joint orientation
var rotation;
}

//-----------------------------------------------------------------------------
// class: User
// Represents a tracked user
//-----------------------------------------------------------------------------
function User(userData) {

	var api = {
		// property: id
		// User id as reported by middleware
		id : 0,
		// property: positionTracked
		// true if user has a valid position
		positionTracked : false,
		// property: position
		// Position of user relative to the sensor, only valid if positionTracked is true
		position : [0,0,0],
		// property: skeletonTracked
		// true if user has full body skeleton data available
		skeletonTracked : false,
		// property: skeleton
		// Full body skeleton data, only valid if skeletonTracked. Collection of <UserJoints> indexed by <UserJoint.id>
		skeleton : {},
		// method: mapJointToControl
		// Updates a control with data from a specific <zig.Joint> for tracked user
		mapJointToControl : mapJointToControl,
		update : update,
	};

	update(userData);

	function update(userData) {
		api.id = userData.id;
		api.positionTracked = true;
		api.position = userData.centerofmass;
		api.skeletonTracked = (userData.tracked > 0);

		// convert joints from an array to associative list for easier access
		var currjoints = userData.joints;
		var newjoints = {};
		for (var i=0; i<currjoints.length; i++) {
			newjoints[currjoints[i].id] = currjoints[i];
		}
		api.skeleton = newjoints;
	}

	function mapJointToControl(joint, control) {
		var events = Events();
		var inSession = false;

		function onuserupdate(userData) {
			if (userData.skeletonTracked && userData.skeleton.hasOwnProperty(joint)) {
				if (!inSession) {
					control.mappedJoint = joint;
					inSession = true;
					events.fireEvent('sessionstart', userData.skeleton[joint].position);
				}
				events.fireEvent('sessionupdate', userData.skeleton[joint].position);
			} else if (inSession) {
				inSession = false;
				delete control.mappedJoint;
				events.fireEvent('sessionend');
			}
		}

		var adapter = {
			onuserupdate : onuserupdate
		}
		events.eventify(adapter);
		adapter.addListener(control);
		api.addListener(adapter);
	}

	return api;
}

//-----------------------------------------------------------------------------
// class: zig
//-----------------------------------------------------------------------------
var zig = (function() {
	var plugin;

	// both of these will hold data per user (indexed by userid)
	var trackedUsers = {};
	var userCallbacks = {};

	var controls = {
		SteadyDetector : SteadyDetector,
		Fader : Fader,
		Fader2D : Fader2D,
		Fader3D : Fader3D,
		PushDetector : PushDetector,
		SwipeDetector : SwipeDetector,
		WaveDetector : WaveDetector,
		Cursor : Cursor,
	}

	var version = "0.95 beta";

	var publicApi = {
		// method: init
		// Initializes zigjs using an existing plugin object
		init : init,
		// method: embed
		// Initializes zigjs by embedding a new plugin object in the dom
		embed : embed,
		// method : findZigObject
		// Find the zig object dom element, or null if none found
		findZigObject : findzigobject,
		// property: version
		// Zig.js version number, not to be confused with the plugin version number
		version : version,
		// property: verbose
		// Output zigjs trace messages to console
		verbose : verbose,
		// property: users
		// Collection of <Users> currently tracked, indexed by <User.id>
		users : trackedUsers,
		// enum: zig.Joint
		// List of Joint ID's
		Joint : Joint,
		// enum: Orientation
		// Possible orientations for oriented controls (<Fader>, for instance)
		Orientation : Orientation,

		EngageFirstUserInSession : EngageFirstUserInSession,
		EngageUsersWithSkeleton : EngageUsersWithSkeleton,

		HandSessionDetector : HandSessionDetector,
		controls : controls,
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
				var newUser = User(users[key])
				userEvents.eventify(newUser);

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

	function init(zo) {
		plugin = zo;
		bindDomEvent(zo, "NewFrame", function () {
		 return function(data) { 
		 	try {
				var obj = JSON.parse(data); 
				doUpdate(obj.users);
			} catch (e) { 
				console.log("Error parsing JSON from plugin, skipping frame");
			}
		 }}());
		log("inited");
		events.fireEvent('loaded', zo);

		// anyone registering to 'loaded' event from now on will have his cb fired immediately
		var oldaddEventListener = publicApi.addEventListener;
		var newaddEventListener = function(eventName, cb) {
			oldaddEventListener(eventName, cb);
			if ('loaded' == eventName) {
				events.fireEvent('loaded', zo, cb);
			}
		}
		publicApi.addEventListener = newaddEventListener;
	}

	function embed(div) {
		if (undefined === div) {
			div = document.createElement('div');
			document.body.appendChild(div);
		}
		if ('string' == typeof div) div = document.getElementById(div);

		var html = '<object id="zigPluginObject" type="application/x-zig" width="0" height="0"><param name="onload" value="zigloaded" /></object>';
		div.innerHTML = html;
		//return document.getElementById('zigPluginObject');
	}

	var zigobject = null;
	function findzigobject()
	{
		if (typeof zigobject == 'undefined') {
			zigobject = null;
		}

		if (null == zigobject) {
			var objs = document.getElementsByTagName('object');
			for (var i=0; i<objs.length; i++) {
				if (objs[i].requestStreams !== undefined) {
					zigobject = objs[i];
					break;
				}
			}
		}
		return zigobject;
	}

	function domloaded() {
		// try and embed the zig plugin object, if it isn't embedded already
		var zo = findzigobject();
		if (null != zo) {
			init(zo);
		} else {
			embed();
		}
	}
	document.addEventListener('DOMContentLoaded', function () { setTimeout(domloaded, 200); }, false); 

	// some default controls, always available
	// comment out if taking too much cpu
	publicApi.singleUserSession = EngageFirstUserInSession();
	publicApi.addListener(publicApi.singleUserSession);

	return publicApi;

}());
function zigloaded() {
	zig.init(zig.findZigObject());	
}


// NOT SURE WHERE THESE ALL BELONG

zig.toys = (function() {

	injectCursor = function() {
		var c = zig.controls.Cursor();
		var ce = document.createElement('div');
		ce.style.position = 'fixed';
		ce.style.display = 'none';
		ce.style.width = '50px';
		ce.style.height = '50px';
		ce.style.backgroundColor = 'blue';
		document.body.appendChild(ce);

		// show/hide cursor on session start/end
		zig.singleUserSession.addEventListener('sessionstart', function(focusPosition) {
			ce.style.display = 'block';
		});
		zig.singleUserSession.addEventListener('sessionend', function() {
			ce.style.display = 'none';
		});

		// move the cursor element on cursor move
		c.addEventListener('move', function(cursor) {
			ce.style.left = (c.x * window.innerWidth - (ce.offsetWidth / 2)) + "px";
			ce.style.top = (c.y * window.innerHeight - (ce.offsetHeight / 2)) + "px";
		});

		// add the cursor to our singleUserSession to make sure we get events
		zig.singleUserSession.addListener(c);
	}

	return {
		injectCursor : injectCursor
	}
}());


} // if (undefined === zig)
else {
	console.log('preventing double init zig.js');
}