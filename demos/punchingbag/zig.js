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

OrientationX = 0;
OrientationY = 1;
OrientationZ = 2;

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
// Helper functions
//-----------------------------------------------------------------------------

function ZigAddHandler(target,eventName,handlerName)
{
	if (target.attachEvent) {
		target.attachEvent("on" + eventName, handlerName);
	} else if ( target.addEventListener ) {
		target.addEventListener(eventName, handlerName, false);
	} else {
		target["on" + eventName] = handlerName;
	}
}

//-----------------------------------------------------------------------------
// ZigControlList
// A list of controls getting updates. Can be nested o'mercy
//-----------------------------------------------------------------------------

function ZigControlList()
{
	this.listeners = [];
	this.focusedControl = undefined;
	this.isInHandpointSession = false;
	this.focusPoint = [0,0,0];
	
	// public
	
	this.AddControl = function(control)
	{
		if (undefined === control) return;
		
		this.listeners.push(control);
		if (this.isInHandpointSession) {
			control.onSessionStart(this.focusPoint);
		}
	}
	
	this.RemoveControl = function(control)
	{
		if (undefined === control) return;
		
		var removed = this.listeners.splice(this.listeners.indexOf(control), 1);
		if (this.isInHandpointSession) {
			removed[0].onSessionEnd();
		}
	}
	
	// this allows nesting control lists
	this.onDoUpdate = function(trackedUser) {
		this.listeners.forEach(function(control) { control.onDoUpdate(trackedUser); });
	}
	
	this.onSessionStart = function(focuspoint) {
		this.isInHandpointSession = true;
		this.focusPoint = focuspoint;
		this.listeners.forEach(function(control) { control.onSessionStart(focuspoint) });
	}
	
	this.onSessionUpdate = function(hands) {
		this.listeners.forEach(function(control) { control.onSessionUpdate(hands) });
	}
	
	this.onSessionEnd = function() {
		this.listeners.forEach(function(control) { control.onSessionEnd() });	
		this.isInHandpointSession = false;
	}
	
	this.SetFocusedControl = function(control) {
		if (control == this.focusedControl) return;
		
		this.RemoveControl(this.focusedControl);
		this.focusedControl = control;
		this.AddControl(control);
	}
}

//-----------------------------------------------------------------------------
// Tracked user
// A tracked user is created for every user we "see".
//-----------------------------------------------------------------------------

function ZigTrackedUser(userid)
{
	this.controls = new ZigControlList();
	this.skeleton = [];
	this.hands = [];
	this.userid = userid;
	this.position = [];
	this.centerofmass = [];
	this.isInHandpointSession = false;
	this.tracked = false;
	
	this.UpdateFullbody = function(centerofmass, tracked, skeleton)
	{
		this.tracked = tracked;
		this.centerofmass = centerofmass;
		this.position = centerofmass;
		this.skeleton = skeleton;
	}
	
	this.UpdateHands = function(hands)
	{
		this.hands = hands;
	}
	
	this.NotifyListeners = function()
	{
		// if we aren't in session, but should be
		if (!this.isInHandpointSession && this.hands.length > 0) {
			this.isInHandpointSession = true;
			var focusPoint = (undefined != this.hands[0].focusposition) ? this.hands[0].focusposition : this.hands[0].position;
			this.controls.onSessionStart(focusPoint);
		}
		
		// if we are in session, but shouldn't be
		if (this.isInHandpointSession && this.hands.length == 0) {
			this.controls.onSessionEnd();
			this.isInHandpointSession = false;
		}
	
		// at this point we know if we are in a session or not,
		// and we sent the start/end notifications. all thats
		// left is updating the controls if we're in session
		if (this.isInHandpointSession) {
			this.controls.onSessionUpdate(this.hands);
		}
		
		this.controls.onDoUpdate(this);
	}
}


// Fader
function Fader(orientation, size)
{
	// defaults
	if (undefined === size) {
		size = 250;
	}

	// vars
	this.size = size;
	this.orientation = orientation;
	this.value = 0;
	this.center = [0,0,0];
	this.itemsCount = 1;
	this.hysteresis = 0.1;
	this.selectedItem = 0;
	this.initialValue = 0.5;
	this.flip = false;

	// events
	// TODO: make real events
	this.onItemSelected = function(item){};
	this.onItemUnselected = function(item){};
	this.onValueChange = function(value) {};

	// hand point control callbacks
	this.onSessionStart = function(sessionStartPosition) {
		this.moveTo(sessionStartPosition, this.initialValue);
		this.value = this.initialValue;
		this.selectedItem = Math.floor(this.itemsCount * this.value);
		this.onItemSelected(this.selectedItem);
	}

	this.onSessionUpdate = function(hands) {
		var position = hands[0].position;
		var distanceFromCenter = position[this.orientation] - this.center[this.orientation];
		var ret = (distanceFromCenter / this.size) + 0.5;
		this.value = this.clamp(ret, 0, 1);
		if (this.flip) this.value = 1 - this.value;

		var newSelected = this.selectedItem;
		var minValue = (this.selectedItem * (1 / this.itemsCount)) - this.hysteresis;
		var maxValue = (this.selectedItem + 1) * (1 / this.itemsCount) + this.hysteresis;
		
		this.onValueChange(this.value);
		
		if (this.value > maxValue) {
			newSelected++;
		}
		if (this.value < minValue) {
			newSelected--;
		}
		
		if (newSelected != this.selectedItem) {
			this.onItemUnselected(this.selectedItem);
			this.selectedItem = newSelected;
			this.onItemSelected(newSelected);
		}
	}

	this.onSessionEnd = function() {
		this.onItemUnselected(this.selectedItem);
	}
	
	this.onDoUpdate = function() {};
	
	this.moveTo = function(position, value) {
		if (this.flip) value = 1 - value;
		this.center[this.orientation] = position[this.orientation] + ((0.5 - value) * this.size);
	}
	
	this.moveToContain = function(position) {
		var distanceFromCenter = position[this.orientation] - this.center[this.orientation];
		if (distanceFromCenter > this.size / 2) {
			this.center[this.orientation] += distanceFromCenter - (this.size / 2);
		} else if (distanceFromCenter < this.size / -2) {
			this.center[this.orientation] += distanceFromCenter + (this.size / 2);
		}
	}
	
	// internal functions
	
	this.clamp = function(x, min, max)
	{
		if (x < min) return min;
		if (x > max) return max;
		return x;
	}
}

function Fader2D(width, height)
{
	this.width = width;
	this.height = height;
	this.topleft = $V([0,0,0]);
	this.initialValue = [0.5, 0.75];
	this.value = [0,0];

	// events
	this.onValueChange = function(value) {}
	
	this.onSessionStart = function(focusPoint) {
		this.topleft = $V(focusPoint).subtract($V([this.initialValue[0] * width, this.initialValue[1] * height, 0]));
		console.log("Top left is at: " + this.topleft.inspect());
	}
	
	this.onSessionUpdate = function(hands) {
		var position = hands[0].position;
		var distanceFromTopleft = $V(position).subtract(this.topleft);
		this.value = [this.clamp(distanceFromTopleft.elements[0] / width,0,1), this.clamp(distanceFromTopleft.elements[1] / height,0,1)];
		this.onValueChange(this.value);
	}
	
	this.onSessionEnd = function() {}
	this.onDoUpdate = function() {}
	
	this.clamp = function(x, min, max)
	{
		if (x < min) return min;
		if (x > max) return max;
		return x;
	}
}

function PushDetector(size)
{
	this.isPushed = false;
	this.pushProgress = 0;
	this.pushTime = 0;

	// events
	this.onPush = function() {}
	this.onRelease = function() {}
	this.onClick = function() {}
	
	if (undefined === size) {
		size = 150;
	}
		
	this.fader = new Fader(OrientationZ, size);
	this.fader.flip = true; // positive Z is backwards by default, so flip it
	this.fader.initialValue = 0.2;
	
	// callbacks
	this.onSessionStart = function(focusPoint) {
		this.fader.onSessionStart(focusPoint);
	}
	
	this.onSessionUpdate = function(hands) {
		var position = hands[0].position;
		
		this.fader.moveToContain(position);
		this.fader.onSessionUpdate(hands);
		this.pushProgress = this.fader.value;
		
		if (!this.isPushed) {
			if (1.0 == this.pushProgress) {
				this.isPushed = true;
				this.pushTime = (new Date()).getTime();
				this.pushPosition = position;
				this.onPush();
			}
		} else {
			if (this.pushProgress < 0.5) {
				this.isPushed = false;
				if (this.isClick()) {
					this.onClick();
				}
				this.onRelease();
			}
		}
		
		// drift if not pushed
		if (!this.pushed) {
			var delta = this.fader.initialValue - this.pushProgress;
			this.fader.moveTo(position, this.pushProgress + delta * 0.05);
		}
	}
	
	this.onSessionEnd = function() {
		this.fader.onSessionEnd();
		if (this.isPushed) {
			this.isPushed = false;
			this.onRelease();
		}
	}
	
	this.onDoUpdate = function() {}
	
	// internal
	
	this.isClick = function() 
	{
		var delta = (new Date()).getTime() - this.pushTime;
		return (delta < 1000);
	} 
}

function SwipeDetector(orientation, size) 
{
	// vars
	this.isSwiped = false;

	// events
	this.onSwipeMin = function() {};
	this.onSwipeMax = function() {};
		
	this.fader = new Fader(orientation, size);
	this.fader.initialValue = 0.5;
	
	// callbacks
	this.onSessionStart = function(focusPoint) {
		this.fader.onSessionStart(focusPoint);
	}
	
	this.onSessionUpdate = function(hands) {
		var position = hands[0].position;
		
		// TODO: Move fader to contain current hand point
		this.fader.onSessionUpdate(hands);
		
		if (!this.isSwiped) {
			if (1 == this.fader.value || 0 == this.fader.value) {
				this.isSwiped = true;
				this.swipeValue = this.fader.value;
				if (1 == this.fader.value) {
					this.onSwipeMax();
				} else {
					this.onSwipeMin();
				}
			}
		} else {
			if (Math.abs(this.fader.value - this.swipeValue) >= 0.3) {
				this.onSwipeRelease();
				this.isSwiped = false;
			}
		}
		
		// TODO: drift if we aren't pushed
	}
	
	this.onSessionEnd = function() {
		this.fader.onSessionEnd();
		if (this.isSwiped) {
			this.isSwiped = false;
			this.onSwipeRelease();
		}
	}
	
	this.onDoUpdate = function() {}
}

function HorizontalSwipeDetector(size)
{
	if (undefined === size) {
		size = 350;
	}
	
	this.onSwipeLeft = function() {}
	this.onSwipeRight = function() {}
	this.onSwipeRelease = function() {}
	
	var me = this;
	this.sd = new SwipeDetector(OrientationX, size);
	this.sd.onSwipeMin = function() { me.onSwipeLeft(); }
	this.sd.onSwipeMax = function() { me.onSwipeRight(); }
	this.sd.onSwipeRelease = function() { me.onSwipeRelease(); }
	
	this.onSessionStart = function(focusPoint) { this.sd.onSessionStart(focusPoint); }
	this.onSessionEnd = function() { this.sd.onSessionEnd(); }
	this.onSessionUpdate = function(hands) { this.sd.onSessionUpdate(hands); }
	this.onDoUpdate = function(user) { this.sd.onDoUpdate(user); }
}

function VerticalSwipeDetector(size)
{
	if (undefined === size) {
		size = 250;
	}
	
	this.onSwipeUp = function() {}
	this.onSwipeDown = function() {}
	this.onSwipeRelease = function() {}

	var me = this;
	this.sd = new SwipeDetector(OrientationY, size);
	this.sd.onSwipeMin = function() { me.onSwipeUp(); }
	this.sd.onSwipeMax = function() { me.onSwipeDown(); }
	this.sd.onSwipeRelease = function() { me.onSwipeRelease(); }
	
	this.onSessionStart = function(focusPoint) { this.sd.onSessionStart(focusPoint); }
	this.onSessionEnd = function() { this.sd.onSessionEnd(); }
	this.onSessionUpdate = function(hands) { this.sd.onSessionUpdate(hands); }
	this.onDoUpdate = function(user) { this.sd.onDoUpdate(user); }
}

function TopDownUsersRadar(parentElement, userClass)
{
	this.parentElement = parentElement;
	this.users = [];
	
	this.onNewUser = function(user) {
		var el = document.createElement('div');
		el.classList.add(userClass);
		this.users[user.userid] = el;
		this.parentElement.appendChild(el);
	}
	
	this.onLostUser = function(user) {
		this.parentElement.removeChild(this.users[user.userid]);
		delete this.users[user];
	}
	
	this.DoUserEngaged = function(user) {
		this.users[user.userid].classList.add('active');
	}
	
	this.DoUserDisengaged = function(user) {
		this.users[user.userid].classList.remove('active');
	}
	
	this.onUpdate = function(trackedUsers) 
	{
		for (var userIndex in trackedUsers) {
			var currUser = trackedUsers[userIndex];
			var el = this.users[currUser.userid];
			var pos = currUser.position;
			el.style.left = (((pos[0] / 4000) + 0.5) * this.parentElement.offsetWidth - (el.offsetWidth / 2)) + "px";
			el.style.top = ((pos[2] / 4000.0) * this.parentElement.offsetHeight - (el.offsetHeight / 2)) + "px";
		}		
	}
}

function SteadyDetector(maxVariance)
{
	if (undefined === maxVariance) {
		maxVariance = 50;
	}

	this.frameCount = 15;
	this.pointBuffer = [];
	this.steady = false;
	this.maxVariance = maxVariance;
	this.onSteady = [];
	
	this.useJoint = false;
	this.joint = Joints.Invalid;
	
	this.onSteady = function() {}
	this.onUnsteady = function() {}
	
	this.sumMatrix = function(mat) {
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
	this.getEigenvalues = function(mat) {
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

	this.getCofactorMatrix = function(mat) {
		var dims = mat.dimensions();
		var xSize = dims.cols;
		var ySize = dims.rows;
		var output = mat.map(function(x, i, j) { return mat.minor(i+1,j+1,xSize-1, ySize-1).determinant(); } );
		return output;
	}

	this.getStddevs = function(vectors) {
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
	
	this.clear = function() {
		this.pointBuffer = [];
		this.steady = false;
	}
	
	this.addValue = function(position) {
		this.pointBuffer.push($V(position));
		while (this.pointBuffer.length > this.frameCount) {
			this.pointBuffer.shift();
		}
		pb = this.pointBuffer;
		var steadyThisFrame = true;
		var stdDevs = getStddevs(this.pointBuffer);
		for(var k in stdDevs) {
			steadyThisFrame &= stdDevs[k] < 50;
		}
		if (steadyThisFrame && (!this.steady)) {
			this.steady = true;
			this.onSteady();
		} else if (!steadyThisFrame && this.steady) {
			this.steady = false;
			this.onUnsteady();
		}
	}
	
	this.onSessionStart = function(focusPoint) {
		if (!this.useJoint) {
			this.clear();
		}
	}
	
	this.onSessionUpdate = function(hands) {
		if (!this.useJoint) {
			this.addValue(hands[0].position);
		}
	}
	
	this.onSessionEnd = function() {}
	
	this.onDoUpdate = function(trackedUser) {
		if (this.useJoint && (trackedUser.skeleton[this.joint] !== undefined)) {
			this.addValue(trackedUser.skeleton[this.joint].position);
		}
	}
}

function ZigHandRaiseDetector()
{
	this.steadyLeft = new ZigSteadyDetector();
	this.steadyLeft.useJoint = true;
	this.steadyLeft.joint = Joints.LeftHand;
	this.steadyRight = new ZigSteadyDetector();
	this.steadyRight.useJoint = true;
	this.steadyRight.joint = Joints.RightHand;
	
	function makeSteadyFunction(detector, joint) 
	{
		return function() {
			var user = detector.user;
			if (user.skeleton[joint].position[1] >= user.skeleton[Joints.Head].position[1]) {
				detector.onHandRaise();
			}
		}
	}

	this.steadyLeft.onSteady = makeSteadyFunction(this, Joints.LeftHand);
	this.steadyRight.onSteady = makeSteadyFunction(this, Joints.RightHand);
	
	this.onHandRaise = function() { console.log("Hand raised"); }
	
	this.onDoUpdate = function(trackedUser) {
		this.user = trackedUser;
		this.steadyLeft.onDoUpdate(trackedUser);
		this.steadyRight.onDoUpdate(trackedUser);
	}
	
	this.onSessionStart = function() {}
	this.onSessionUpdate = function() {}
	this.onSessionEnd = function() {}
}

//-----------------------------------------------------------------------------
// "Engagement" managers
//-----------------------------------------------------------------------------

function ZigEngageSingleUser(userid)
{	
	// the session manager can be inited with a valid userid
	// (for persisting state between pages, etc.)
	if (undefined == userid) {
		userid = 0;
	}
	
	this.PrimaryUser = new ZigControlList();
	this.userid = userid;
	
	this.onNewUser = function(trackeduser) {
		// not tracking anyone yet?
		if (0 == this.userid) {
			// start now
			this.userid = trackeduser.userid;
			trackeduser.controls.AddControl(this.PrimaryUser);
		}
	}
	
	this.onLostUser = function(trackeduser) {
		// lost the engaged user?
		if (trackeduser.userid == this.userid) {
			// bummer
			this.userid = 0;
		}
	}
	
	this.onUpdate = function() {}
}

// NOTE: This needs to be rewritten; user control that waits till the user is in alone in a "region"
// Init 2 of those per user, one for left and one for right
function ZigEngageSideBySide(usertracker, leftuserid, rightuserid)
{
	this.usertracker = usertracker;
	this.LeftUser = new ZigControlList();
	this.RightUser = new ZigControlList();
	this.leftuserid = (leftuserid == undefined ? 0 : leftuserid);
	this.rightuserid = (rightuserid == undefined ? 0 : rightuserid);
	
	this.onUsersEngaged = function() {}
	this.onUsersMissing = function() {}

	this.leftUserIdealPosition = [-1000,1000,2000];
	this.rightUserIdealPosition = [1000,1000,2000];

	this.getUserClosestTo = function(trackedusers, position) 
	{
		var minDistance = -1;
		var ret = 0;
		for (userid in trackedusers) {
			currDistance = $V(trackedusers[userid].centerofmass).distanceFrom($V(position));
			if (-1 == minDistance || currDistance < minDistance) {
				minDistance = currDistance;
				ret = userid;
			}
		}
	}
	
	this.onUpdate = function() {
		// if not all users are engaged
		var allusersengaged = this.allUsersEngaged();
		var trackedusers = this.usertracker.trackedUsers;
		if (!this.allUsersEngaged()) {
			// check distance of each user from the "ideal" positions
			var closestLeft = this.getUserClosestTo(trackedusers, this.leftUserIdealPosition);
			var closestRight = this.getUserClosestTo(trackedusers, this.rightUserIdealPosition);
			
			// if the perfect user for both positions is the same
			if (closestLeft == closestRight) {
				// keep looking for another one
				var dLeft = $V(trackedusers[closestLeft].centerofmass).distanceFrom($V(this.leftUserIdealPosition));
				var dRight = $V(trackedusers[closestRight].centerofmass).distanceFrom($V(this.rightUserIdealPosition));
				if (dLeft < dRight) {
					closestRight = 0; 
				} else {
					closestLeft = 0;
				}
			}
		}
		
		// should we fire the UsersEngaged event?
		if (!allusersengaged && this.allUsersEngaged()) {
			this.userTracker
			this.onUsersEngaged();
		}
	}
	
	this.onLostUser = function(trackeduser) {
		// is the lost user one of our engaged users?
		var allusersengaged = this.allUsersEngaged();
		if (trackeduser.userid == this.leftuserid) {
			this.leftuserid = 0;
		}
		if (trackeduser.userid == this.rightuserid) {
			this.rightuserid = 0;
		}
		
		// should we fire the UsersMissing event?
		if (allusersengaged && !this.allUsersEngaged()) {
			this.onUsersMissing();
		}
	}
	
	this.allUsersEngaged = function() {
		return (this.leftuserid != 0 && this.rightuserid != 0);
	}
}

function ZigEngageSingleSession(usertracker, userid)
{
	this.controls = new ZigControlList();
	
	// the session manager can be inited with a valid userid
	// (for persisting state between pages, etc.)
	if (undefined === userid) {
		userid = 0;
	} else {
		usertracker.trackedUsers[userid].controls.AddControl(this.Controls);
	}
	
	this.usertracker = usertracker;
	this.userid = userid;

	// public events
	this.onUserEngaged = function(user) {}
	this.onUserDisengaged = function(user) {}
	
	this.onNewUser = function(trackeduser) {
		// create a hand point control to do our "work" for us
		var WaitForSession = function(parent, user) { 
			this.onSessionStart = function(focuspoint) { 
				// no active user
				if (parent.userid == 0) {
					// now we do
					parent.userid = user.userid;
					user.engaged = true;
					user.controls.AddControl(parent.controls);
					parent.onUserEngaged(user);
				}
			}
			this.onSessionEnd = function() {
				// active user was us
				if (parent.userid == user.userid) {
					// not anymore
					parent.userid = 0;
					user.engaged = false;
					user.controls.RemoveControl(parent.controls);
					parent.onUserDisengaged(user);
				}
			}
			this.onSessionUpdate = function() {}
			this.onDoUpdate = function() { }
		}
		trackeduser.controls.AddControl(new WaitForSession(this, trackeduser));
	}
	
	this.onLostUser = function(trackeduser) {
		// lost the engaged user?
		if (trackeduser.userid == this.userid) {
			// bummer
			this.userid = 0;
		}
	}
	
	this.onUpdate = function() {}
	
	this.Reset = function() {
		if (this.userid != 0) {
			this.userTracker.trackedUsers[this.userid].controls.RemoveControl(this.Controls);
			this.userid = 0;
		}
	}
}

//-----------------------------------------------------------------------------
// Zig object
//-----------------------------------------------------------------------------

var Zig = function() {
	// raw data from last frame, directly from acquisition layer
	var rawUsers = [];
	var rawHands = [];
	// mapping of userid's to TrackedUser's
	var trackedUsers = [];
	// mapping of handid's to userid's
	var trackedHands = [];

	// do we allow hand point sessions from hand points
	// with no associated userid?
	var allowHandsForUntrackedUsers = true;
	
	var listeners = [];
	
	// TODO: make real events (listeners for now)
	function onNewUser(trackedUser)	{
		listeners.forEach(function(listener) { listener.onNewUser(trackedUser) });
	}
	
	function onLostUser(trackedUser) {
		listeners.forEach(function(listener) { listener.onLostUser(trackedUser) });
	}
	
	function onUpdate(userTracker) {
		listeners.forEach(function(listener) { listener.onUpdate(userTracker) });
	}
	
	function init(pluginElement) {
		plugin = pluginElement;
		ZigAddHandler(pluginElement, "NewFrame", function () { return function(data) { var obj = JSON.parse(data); DoUpdate(obj.users, obj.hands); }}());
		log("Zig: inited");
	}
	
	function Pause() { plugin.firingEvents = false; }
	function Resume() { plugin.firingEvents = true; }
	
	function ProcessNewUser(userid) {
		log("Zig: new user " + userid);
	
		// if we aren't tracking this user yet, start now
		// (its possible that we are already tracking the user
		//  from a previous hand point etc.)
		if (!isUserTracked(userid)) {
			trackedUsers[userid] = new ZigTrackedUser(userid);
			onNewUser(trackedUsers[userid]);
		}
	}

	function ProcessLostUser(userid) {
		log("Zig: lost user " + userid);
		
		if (isUserTracked(userid)) {
			lost = trackedUsers[userid];
			delete trackedUsers[userid];
			onLostUser(lost);
		}
	}

	function ProcessNewHand(handid, userid)	{
		log("Zig: new hand " + handid);
		
		// no user id
		if (userid <= 0) {
			log("Zig: new hand belongs to non-tracked user");
			
			// get out if we dont allow such hands
			if (!allowHandsForUntrackedUsers) return;
			
			// otherwise allocate a "fake" user id and use it
			userid = getFakeUserId();
		}
	
		// add the user if neccessary
		if (!isUserTracked(userid)) {
			ProcessNewUser(userid);
		}
		
		// associate this hand with the user
		log("Zig: new hand associated with user " + userid);
		trackedHands[handid] = userid;
	}

	function ProcessLostHand(handid) {
		log("Zig: lost hand");
		
		// remove the hand->user association
		var userid = trackedHands[handid];
		delete trackedHands[handid];
		
		// if this user is "fake" (created for this specific 
		// hand point) then get rid of it
		if (!isRealUser(userid)) {
			log("Zig: lost hand was with fake user, removing");
			ProcessLostUser(userid);
		}
	}
	
	function UpdateUsers (users) {
		// get rid of old users
		for (userid in trackedUsers) {
			var curruser = getItemById(users, userid);
			if (undefined === curruser && isRealUser(userid)) {
				ProcessLostUser(userid);
			}
		}
		
		// add new users
		for (user in users) {
			if (!isUserTracked(users[user].id)) {
				ProcessNewUser(users[user].id);
			}
		}

		// save raw data before updating the fullbody controls
		rawUsers = users;
		
		// update stuff
		for (user in users) {
			var currjoints = users[user].joints;
			var newjoints = [];
			for (var i=0; i<currjoints.length; i++) {
				newjoints[currjoints[i].id] = currjoints[i];
			}
			trackedUsers[users[user].id].UpdateFullbody(users[user].centerofmass, users[user].tracked, newjoints);
		}
	}

	function UpdateHands(hands) {
		// get rid of old hands
		for (handid in trackedHands) {
			var currhand = getItemById(hands, handid);
			if (undefined === currhand) {
				ProcessLostHand(handid);
			}
		}
		
		// add new hands
		for (handindex in hands) {
			var hand = hands[handindex];
			if (undefined === trackedHands[hand.id]) {
				ProcessNewHand(hand.id, hand.userid);
			}
		}

		// save raw data before updating the handpoint controls
		rawHands = hands;
		
		// update hand points
		// go through list of users
		for (userid in trackedUsers) {
			// find hands belonging to this user
			var currhands = [];
			for (handid in trackedHands) {
				if (trackedHands[handid] == userid) {
					var hand = getItemById(hands, handid);
					if (isRealUser(userid)) { // if hand isn't associated with a user, just pass the raw hand
						hand.position = rotateHand(hand.position, trackedUsers[userid].centerofmass);
						if (undefined !== hand.focusposition)
							hand.focusposition = rotateHand(hand.focusposition, trackedUsers[userid].centerofmass);
					}
					currhands.push(hand);
				}
			}
			trackedUsers[userid].UpdateHands(currhands);
		}
	}
	
	function DoUpdate (users, hands) {
		UpdateUsers(users);
		UpdateHands(hands);
		trackedUsers.forEach(function(trackedUser) { trackedUser.NotifyListeners(); });
		var userTracker = this;
		listeners.forEach(function(listener) { listener.onUpdate(trackedUsers); });
	}
	
	// does this user actually exist in the acquisition layer?
	function isRealUser(userid)
	{
		return containsId(rawUsers, userid);
	}
	
	// are we tracking this (real or "fake") user?
	// a fake user is one that doesn't exist in the acquisition layer (from external 
	// hand tracker, for instance)
	function isUserTracked (userid)
	{
		return (typeof(trackedUsers[userid]) != 'undefined');
	}
	
	// we want to make sure our "fake" user id range doesn't conflict with
	// user id's from the acquisition layer.
	var lastFakeUserId = 1337;
	function getFakeUserId()
	{
		var ret = lastFakeUserId;
		lastFakeUserId++;
		return ret;
	}
	
	function containsId (collection, id)
	{
		return (getItemById(collection, id) !== undefined);
	}
	
	// TODO: change from "userid" to "id" so it will work for both hands
	// and users
	function getItemById(collection, id)
	{
		for (item in collection) {
			if (collection[item].id == id) return collection[item];
		}
		return undefined;
	}
	
	function log(s)
	{
		if (verbose) {
			console.log(s);
		}
	}
	
	var singleUser = new ZigEngageSingleSession(this);
	listeners.push(singleUser);
	
	var verbose = true;
	
	// public API
	return {
		// user tracker
		init : init,
		trackedUsers : trackedUsers,
		listeners : listeners,
		pause : Pause,
		resume : Resume,
		Pause : Pause,
		Resume : Resume,
		
		// user engagement stuff
		SingleUser : singleUser,
		
		// controls
		Fader : Fader,
		Fader2D : Fader2D,
		PushDetector : PushDetector,
		SteadyDetector : SteadyDetector,
		VerticalSwipeDetector : VerticalSwipeDetector,
		HorizontalSwipeDetector : HorizontalSwipeDetector,
		TopDownUsersRadar : TopDownUsersRadar,

		// consts
		OrientationX : OrientationX,
		OrientationY : OrientationY,
		OrientationZ : OrientationZ,
		Joints 	: Joints,
		verbose :  verbose,
	}
} ();

function rotateHand(handPos, comPos)
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
