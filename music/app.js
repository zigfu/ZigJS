var roomLocations = [];

/** Converts numeric degrees to radians */
if (typeof(Number.prototype.toRad) === "undefined") {
  Number.prototype.toRad = function() {
    return this * Math.PI / 180;
  }
}

// returns km
function getDistance(lat1,lon1,lat2,lon2) {
    var R = 6371; // km
    var dLat = (lat2-lat1).toRad();
    var dLon = (lon2-lon1).toRad(); 
    var a = Math.sin(dLat/2) * Math.sin(dLat/2) +
            Math.cos(lat1.toRad()) * Math.cos(lat2.toRad()) * 
            Math.sin(dLon/2) * Math.sin(dLon/2); 
    var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a)); 
    return R * c;
}

// returns m
function distanceBetween(pos1, pos2) {
	return getDistance(	pos1.coords.latitude,
						pos1.coords.longitude,
						pos2.coords.latitude,
						pos2.coords.longitude ) * 1000;
}

var app = require('http').createServer(handler)
  , io = require('socket.io').listen(app)
  , fs = require('fs')
  , path = require('path')
  , net = require('net');
app.listen(80);

function getNetworkIP(addr, callback) {
  var socket = net.createConnection(80, addr);
  socket.on('connect', function() {
    callback(undefined, socket.address().address);
    socket.end();
  });
  socket.on('error', function(e) {
    callback(e, 'error');
  });
}

function handler (request, response) {
  console.log('request starting...');
    console.log(request.url); 
    var filePath = '.' + request.url;
    if (filePath == './')
        filePath = './index.html';
    
	if (request.url[1] == '?')
    {
    	//console.log('saw ?, loading kb.htm');
    	//filePath = './kb.htm';
    } 
	
	if (filePath.indexOf('?') > -1) {
		filePath = filePath.substr( 0, filePath.lastIndexOf('?') );
	}
	console.log("Path: " + filePath);
	
    var extname = path.extname(filePath);
    var contentType = 'text/html';
    switch (extname) {
        case '.js':
            contentType = 'text/javascript';
            break;
        case '.css':
            contentType = 'text/css';
            break;
    }
     
    path.exists(filePath, function(exists) {
     
        if (exists) {
            fs.readFile(filePath, function(error, content) {
                if (error) {
                    response.writeHead(500);
                    response.end();
                }
                else {
                    response.writeHead(200, { 'Content-Type': contentType });
                    response.end(content, 'utf-8');
                }
            });
        }
        else {
            response.writeHead(404);
            response.end();
        }
    });
}

io.sockets.on('connection', function (socket) {
	console.log("connection made");
	
	socket.on('controllerConnected', function (data) {
		console.log("controllerConnected");
		socket.roomid = data['id'];
		socket.name = data['name'];
		
		if (undefined !== data.location) {
			console.log("Connection has valid location");
			socket.location = data.location;
		}
		
		// valid room id
		if (socket.roomid > 0) {
			// join room
			console.log("Valid room id, joining");
			socket.join(socket.roomid);
			roomLocations[socket.roomid] = data.location;
		// no valid room id
		} else {
			// check location
			for (var roomid in roomLocations) {
				if (roomLocations.hasOwnProperty(roomid)) {
					var d = distanceBetween(roomLocations[roomid], socket.location);
					console.log("Distance: " + d);
				}
			}
			//roomLocations[socket.roomid] = data.location;
		}
		io.sockets.in(data['id']).emit('newjoin');
	});
	
	socket.on('manualConnect', function (data) {
		socket.roomid = data['id'];
		if (undefined !== data.location) {
			socket.location = data.location;
		}
		
		roomLocations[data['id']] = data.location;
		socket.join(socket.roomid);
	});
	
	socket.on('next', function(data) {
		socket.broadcast.to(socket.roomid).emit('next', {name : socket.name});
	});
	
	socket.on('suggest_local', function(data) {
		console.log('local suggested by tv')
		socket.get('roomid',function(err, room) {
          io.sockets.in(room).emit('try_local', data);
		});
	});
	
	socket.on('localControllerConnected',function (data) {
		console.log("localControllerConnected");
		socket.set('roomid', data['id']);
		socket.join(data['id']);	

		io.sockets.in(data['id']).emit('break_remote');
	});
	
	socket.on("sweet", function(socket) {
		console.log("SWEET");
	});
	
	socket.on("echo", function (data) {
		console.log("echo: " + data);
		socket.emit("echo", data);
	});
	
  socket.on('keydown', function (data) {
    console.log(data);
    socket.get('roomid',function(err, room) {
          io.sockets.in(room).emit('keydown', data);
    });
  });
  
   socket.on('keyup', function (data) {
    console.log(data);
    socket.get('roomid',function(err, room) {
          io.sockets.in(room).emit('keyup', data);
    });

  });
  
  socket.on('shake', function(data){
      console.log(data);
    socket.get('roomid',function(err, room) {
          io.sockets.in(room).emit('shake', data);
    });
  });
  
 socket.on('notify_remote_of_local', function(data) {
 console.log('remote connection has local server: ' + data['ipaddr'] + ':' + data['port']);
 });
 
 socket.on('localhost_connection', function(data) {
	var localaddress = socket.handshake.address;
	//after a successful connection from localhost we need to report the local ip address back
	//gets the LAN ip by opening a connection to zig.tv, put some analytics for this
	getNetworkIP('zig.tv',function(error,ip)
	{
		console.log(ip);
		if (error) {
			console.log('error:', error);
		}
		socket.emit("lan_ip", {ipaddr: ip, port: localaddress.port});
	});
	
 });
 
  // only the tv sends this
  socket.on('joinid', function(data)
  {
  	console.log("joinid:");
  	console.log(data);
  	socket.set('roomid', data['id']);
  	socket.join(data['id']);	
  });
  
  
});