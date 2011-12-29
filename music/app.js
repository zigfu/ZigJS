var app = require('http').createServer(handler)
  , io = require('socket.io').listen(app)
  , fs = require('fs')
  , path = require('path')
  , net = require('net')
  , useragent = require('./useragent')
  , location = require('./location');
  
app.listen(80);

// yes, these should be persistent
var activeRooms = {};
var roomLocations = {};
activeRooms["31337"] = { name : "31337 H4xx0r room" };

function handler (request, response) {
    console.log("Request: " + request.url); 
	var ua = useragent.parse(request.headers['user-agent']);
    var filePath = '.' + request.url;
    
	// is this a tv? or a controller?
	var isMobile = /mobile/i.test(request.headers['user-agent']);
	
	var forceTv = (request.url == "tv");
	var isTv = forceTv || !isMobile;
	
	// default page (for tv & controller)
		
    if (filePath == './') {
		if (isTv) {
			console.log("Zig.TV: The TV");
			filePath = './musicplayer.html';
		} else {
			console.log("Zig.TV: A controller");
			filePath = './kb4.htm';
		}
	}
	
	// make sure query strings dont interfere with fetching from fs
	if (filePath.indexOf('?') > -1) {
		filePath = filePath.substr( 0, filePath.lastIndexOf('?') );
	}
	
	if (request.url[1] == '?')
    {
    	console.log('saw ?, loading kb4.htm');
    	filePath = './kb4.htm';     
    }    

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
	
	// this is sent by mobile controllers
	socket.on('controllerConnected', function (data) {
		socket.roomid = data['id'];
		socket.name = data['name'];
		
		if (undefined !== data.location) {
			console.log("Connection has valid location");
			socket.location = data.location;
		}
		
		// valid room id
		if (socket.roomid > 0) {
			// join room
			roomToJoin = ""+socket.roomid;
			if (roomToJoin in activeRooms) {
				console.log("Valid room id, joining");
				socket.roomid = roomToJoin;
				socket.join(socket.roomid);
				socket.emit("roomJoined", {success : true});
				roomLocations[socket.roomid] = data.location;

				// notify the "Server"
				io.sockets.in(socket.roomid + "_server").emit('userJoined', { name : socket.name });
				
				// register the disconnect to notify when user leaves
				socket.on('disconnect', function() {
					io.sockets.in(socket.roomid + "_server").emit('userLeft', { name : socket.name });
				});
			} else {
				socket.emit("roomJoined", { success : false, error : "Invalid room id" });
				socket.emit("roomList", activeRooms);
			}
			
			//socket.join(socket.roomid);
					// no valid room id
		} else {
			// TODO: only send rooms within location threshold
			/*for (var roomid in roomLocations) {
				if (roomLocations.hasOwnProperty(roomid)) {
					var d = distanceBetween(roomLocations[roomid], socket.location);
				}
			}*/
			socket.emit("roomList", activeRooms);
		}
		
		socket.on('joinRoom', function (data) {
			var roomToJoin = data['id'];
			if ("31337" == roomToJoin) {
				socket.emit("roomJoined", { success : false, error : "No permission to join" });
			}
			else if (roomToJoin in activeRooms) {
				socket.roomid = roomToJoin;
				socket.join(socket.roomid);
				socket.emit("roomJoined", {success : true});
				
				// notify the "Server"
				io.sockets.in(socket.roomid + "_server").emit('userJoined', { name : socket.name });
				
				// register the disconnect to notify when user leaves
				socket.on('disconnect', function() {
					io.sockets.in(socket.roomid + "_server").emit('userLeft', { name : socket.name });
				});
			} else {
				socket.emit("roomJoined", { success : false, error : "Invalid room id" });
			}
		});
	});
	
	// only the tv sends this
	socket.on('startRoom', function(data) {
		console.log("Start room request");
		socket.roomid = data['id'];
		
		activeRooms[socket.roomid] = { name : data['name'], location : data['location']};
		
		// TODO: Send the TV a stored location from prev session
		// socket.emit("locationSet", {location : roomLocations[socket.roomid]});
		
		socket.join(socket.roomid);
		socket.join(socket.roomid + "_server");
		
		socket.on('setName', function(data) {
			console.log("TV name changed: " + data.name);
			socket.name = data.name;
			activeRooms[socket.roomid].name = data.name;
			socket.broadcast.to(socket.roomid).emit('roomList', activeRooms);
		});
		
		socket.on('disconnect', function () {
			console.log("TV disconnected, removing room details");
			delete activeRooms[socket.roomid];
		});
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
  
  socket.on('input', function(data){
	console.log('input: ' + data['value']);
	socket.get('roomid',function(err, room) {
		io.sockets.in(room).emit('input', data);
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
 
 socket.on('touchstart', function (data) {
 	io.sockets.in(socket.roomid+'_server').emit('touchstart', data);
 });
 
 socket.on('touchmove', function (data) {
 	io.sockets.in(socket.roomid+'_server').emit('touchmove', data);
 });
 
 socket.on('touchend', function(data){
 	io.sockets.in(socket.roomid+'_server').emit('touchend', data);
 });
 
 
  socket.on('ax', function (data) {
 	io.sockets.in(socket.roomid+'_server').emit('touchstart', data);
 });
 
 socket.on('ar', function (data) {
 	io.sockets.in(socket.roomid+'_server').emit('touchmove', data);
 });
 
 socket.on('or', function(data){
 	io.sockets.in(socket.roomid+'_server').emit('touchend', data);
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
  
});


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
