
function hasClass(ele,cls) {
    return ele.className.match(new RegExp('(\\s|^)'+cls+'(\\s|$)'));
}

function addClass(ele,cls) {
    if (!this.hasClass(ele,cls)) ele.className += " "+cls;
}

function removeClass(ele,cls) {
    if (hasClass(ele,cls)) {
        var reg = new RegExp('(\\s|^)'+cls+'(\\s|$)');
        ele.className=ele.className.replace(reg,'');
    }
}






function fillArc(start,total)
{
	//console.log("start: " + start + " total: " + total);
    context.arc(centerX, centerY, radius, start*(3.1415926/180), (start+total)*(3.1415926/180), counterclockwise);
    context.stroke();

}

var context, canvas, centerX, centerY, radius, counterclockwise;
var ce;

var last = [0,0];
var target = [0,0];
var mouseovertarget = null;
var c;

var pos = 0;
var del = 20;
var amt = 10;
var endHover = false;
function clear()
{
	endHover = true;
	canvas.width = canvas.width;
}
function startHoverClick()
{
	console.log("START HOVER CLICK " + mouseovertarget.id);
	pos = 0;
	endHover = false;
	fillCircle();	
	
}
function fillCircle()
{
	if (!endHover)
	{
		context.lineWidth = 10;
		fillArc(pos,amt);
		pos += amt;
		if (pos < 360)
		{
			window.setTimeout(fillCircle,del);
		}
		else
		{
			pos = 0;
			window.setTimeout(end,del);
		}
	}
}
function end()
{
	console.log("HOVER CLICK " + mouseovertarget.id);
	context.lineWidth = 17;
    context.strokeStyle = "green"; // line color
    
	fillArc(0,360);
	xpos = c.x * window.innerWidth;
	ypos = c.y * window.innerHeight; 
	var evt = document.createEvent("MouseEvents");				
	evt.initMouseEvent("click", true, true, window, 1, xpos, ypos, xpos, ypos, false, false, false, false, 0, null);	
	mouseovertarget.dispatchEvent(evt);
	
	
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

function setCursor(x,y)
 {
	xpos = x * window.innerWidth;
	ypos = y * window.innerHeight; 
	ce.style.left = xpos - (ce.offsetWidth / 2); "px";
	ce.style.top = ypos - (ce.offsetHeight / 2); "px";
	
	
	elem = document.elementFromPoint(xpos,ypos);
	//output = document.getElementById("output");
	if (elem)
	{
		
		var r = elem;
		var n=elem, el=n, elems=[];		
		k=0;
		do {
			
			elems.push(el);	
			if (el.tagName.toUpperCase() == "CANVAS")
			{
				//console.log("decrease canvas z");
				//console.log(el.parentNode.id)
				el.parentNode.style.zIndex = parseInt(el.parentNode.style.zIndex||0)-(1000+k);
			}
			else
			{
				el.style.zIndex = parseInt(el.style.zIndex||0)-(1000+k);
				//var evt = document.createEvent("MouseEvents");				
				//evt.initMouseEvent("mousemove", true, true, window, 1, xpos, ypos, xpos, ypos, false, false, false, false, 0, null);
				//el.dispatchEvent(evt);
				if (el != mouseovertarget)
				{
					clear();
					if (mouseovertarget)
					{
						console.log("CLASS: " + mouseovertarget.classList);
						//mouseovertarget.classList.remove("zigHover");
						removeClass(mouseovertarget, "zigHover");
						console.log("REMOVE zigHover class from " + mouseovertarget.id );
						console.log("CLASS: " + mouseovertarget.classList);
						var evt = document.createEvent("MouseEvents");				
						evt.initMouseEvent("mouseout", true, true, window, 1, xpos, ypos, xpos, ypos, false, false, false, false, 0, null);
						console.log("mouseout: " + mouseovertarget.id);
						mouseovertarget.dispatchEvent(evt);
					

					}
					mouseovertarget = el;
					console.log("mouseover: " + mouseovertarget.id);
					var evt = document.createEvent("MouseEvents");				
					evt.initMouseEvent("mouseover", true, true, window, 1, xpos, ypos, xpos, ypos, false, false, false, false, 0, null);					
					mouseovertarget.dispatchEvent(evt);		
					//mouseovertarget.classList.add("zigHover");
					
					console.log("ADD zigHover class to " + mouseovertarget.id );
						if (hasClass(mouseovertarget, "hoverable"))						
						{
							startHoverClick();
							addClass(mouseovertarget, "zigHover");
						}
				}
			}
			//console.log("next");
			r = el;
			el = document.elementFromPoint(xpos, ypos);
			//console.log(el);//console.log(el.id);
			k++;
		} while(el!=n && el!=r && k<2);
		//console.log(elems.length);
		elems.toString=function(){
			var buf=[];
			for(var ii=0; ii<this.length; ii++)
			buf.push(this[ii].id);
			return buf.join(", ");
			}
		//console.log(elems);
		for(var ii=0; ii<elems.length; ii++)
		{
			if (elems[ii].tagName.toUpperCase() == "CANVAS")
			{
			//console.log("increase canvas z: " + elems[ii].parentNode.style.zIndex);
			elems[ii].parentNode.style.zIndex = parseInt(elems[ii].parentNode.style.zIndex) + (1000+ii);
			}
			else
			{
			elems[ii].style.zIndex = parseInt(elems[ii].style.zIndex) + (1000+ii);	
			}
		}
		//output.innerHTML = "xpos: " + xpos + " y: " + ypos + "<br>elems " + elems;
	}
}
	




window.onload = function(){
    canvas = document.createElement("canvas");
	ce = document.createElement("div");
	ce.id="cursor";
	ce.style.position = "fixed";
	ce.style.display = "block";
	ce.style.width = "100px";
	ce.style.height = "100px";
	ce.style.backgroundImage = "url('zigcursor.png')";
	ce.style.backgroundPosition = "center";
	ce.style.backgroundRepeat = "no-repeat";
	document.body.appendChild(ce);
	ce.appendChild(canvas);
	
	canvas.width = 100;
	canvas.height = 100;
	canvas.style.width = '100px';
	canvas.style.height = '100px';
    context = canvas.getContext("2d");
    centerX = canvas.width / 2;
    centerY = canvas.height / 2;
    radius = 40;    
    counterclockwise = false;
	
    context.strokeStyle = "black"; // line color
    context.lineWidth = 10;
	
//window.onmousemove = function(e){
//	target[0] = e.clientX / window.innerWidth;
//	target[1] = e.clientY / window.innerHeight;
//};

function moveCursor()
{
	//console.log(target);
	last = vlerp(last,target,.3);
	setCursor(last[0],last[1]);
}
	window.setInterval(moveCursor,15);

// Create cursor and cursor dom element
  c = zig.controls.Cursor();

	
	
 // 1. show/hide cursor on session start/end
zig.singleUserSession.addEventListener('sessionstart', function(focusPosition) {
	ce.style.display = 'block';
});
zig.singleUserSession.addEventListener('sessionend', function() {
	ce.style.display = 'block';
});
 
// 2. move the cursor element on cursor move
c.addEventListener('move', function(cursor) {
	target[0] = c.x;
	target[1] = c.y;
});





// 3. Add/remove 'pushed' class on cursor push/release
c.addEventListener('push', function(c) {
	
	//console.log("mousedown: " + mouseovertarget.id);
	addClass(ce,'pushed');
	xpos = c.x * window.innerWidth;
	ypos = c.y * window.innerHeight; 
	var evt = document.createEvent("MouseEvents");				
	evt.initMouseEvent("mousedown", true, true, window, 1, xpos, ypos, xpos, ypos, false, false, false, false, 0, null);
	
	mouseovertarget.dispatchEvent(evt);
	
	
});
c.addEventListener('release', function(c) {
	removeClass(ce,'pushed');
	//console.log("mouseup: " + mouseovertarget.id);
	xpos = c.x * window.innerWidth;
	ypos = c.y * window.innerHeight; 
	var evt = document.createEvent("MouseEvents");				
	evt.initMouseEvent("mouseup", true, true, window, 1, xpos, ypos, xpos, ypos, false, false, false, false, 0, null);
	
	mouseovertarget.dispatchEvent(evt);
	
});
 
// 4. Simulate mouse click on our virtual cursor
c.addEventListener('click', function(c) {
	var xpos = c.x * window.innerWidth;
	var ypos = c.y * window.innerHeight;
	var evt = document.createEvent("MouseEvents");
	
	
	elem = document.elementFromPoint(xpos,ypos);
	//console.log("xpos: " + xpos + " y: " + ypos);
	
	
	if (elem)
	{

		var r = elem;
		var n=elem, el=n, elems=[];		
		k=0;
		do {
			
			elems.push(el);	
			if (el.tagName.toUpperCase() == "CANVAS")
			{
				//console.log("decrease canvas z");
				//console.log(el.parentNode.id)
				el.parentNode.style.zIndex = parseInt(el.parentNode.style.zIndex||0)-(1000+k);
			}
			else
			{
				//console.log("click");
				evt.initMouseEvent("click", true, true, el, 1, xpos, ypos, xpos, ypos, false, false, false, false, 0, null);
				el.dispatchEvent(evt);
				el.style.zIndex = parseInt(el.style.zIndex||0)-(1000+k);	
			}
			//console.log("next");
			r = el;
			el = document.elementFromPoint(xpos, ypos);
			//console.log(el);//console.log(el.id);
			k++;
		} while(el!=n && el!=r && k<3);
		//console.log(elems.length);
		elems.toString=function(){
			var buf=[];
			for(var ii=0; ii<this.length; ii++)
			buf.push(this[ii].id);
			return buf.join(", ");
			}
		//console.log(elems);
		for(var ii=0; ii<elems.length; ii++)
		{
			if (elems[ii].tagName.toUpperCase() == "CANVAS")
			{
			//console.log("increase canvas z: " + elems[ii].parentNode.style.zIndex);
			elems[ii].parentNode.style.zIndex = parseInt(elems[ii].parentNode.style.zIndex) + (1000+ii);
			}
			else
			{
			elems[ii].style.zIndex = parseInt(elems[ii].style.zIndex) + (1000+ii);	
			}
		}
	}
	
	
	
});
 
// Add cursor to our single user UI session
zig.singleUserSession.addListener(c);


//modify style sheets to make :hover to .zigHover and make "a" elements hoverable
for (var i = 0; i < document.styleSheets.length; i++)
{


	els = document.getElementsByTagName("a");
	for (var j = 0; j < els.length; j++)
	{
		addClass(els[j], "hoverable");
	}
	
	console.log("stylesheet " + i);
	ss = document.styleSheets[i];

	for (var r = 0; r < ss.rules.length; r++)
	{
		console.log(ss.rules[r].selectorText);
		if (ss.rules[r].selectorText.search(":hover") > 0)
		{
			console.log("add hover");			
			txt = ss.rules[r].cssText;
			newstyle = txt.replace(":hover", ".zigHover");
			console.log(newstyle);
			ss.insertRule(newstyle);
			r++; //make sure we don't do it for the same rule twice after inserting
		}
	}
	
}


}




