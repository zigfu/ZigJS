var app = require('http').createServer(handler)
  , io = require('socket.io').listen(app)
  , fs = require('fs')
  , path = require('path')
  , net = require('net')
  , useragent = require('./useragent')
  , location = require('./location')
  , synclist = require('synclist').listen(io)
  , zmote = require('zmote').listen(io);
  
app.listen(80);

var roomslist = synclist.create("roomslist");
roomslist.add({ name : "Restricted Room", location : "testing" }, 31337);

// yes, these should be persistent
//var activeRooms = {};
//activeRooms["31337"] = { name : "31337 H4xx0r room" };

function doJoin(socket, roomid) {
	if ("31337" == roomid) {
		socket.emit("roomJoined", { success : false, error : "No permission to join" });
	} else if (!roomslist.contains(roomid)) {
		socket.emit("roomJoined", { success : false, error : "Invalid room id" });
	} else {
		socket.roomid = roomid;
		socket.join(socket.roomid);

		var joining = roomslist.get(roomid);
		socket.emit("roomJoined", {
			success : true, 
			userlist : joining.userlist, 
			playlist : joining.playlist, 
			medialist : joining.medialist,
			zmoteid : joining.zmoteid,
		});

		// send the TV a msg indicating someone connected
		io.sockets.in(socket.roomid + "_server").emit('userJoined', {name : socket.name});
		
		var userlist = synclist.open(joining.userlist);
		var id = userlist.add({ name : socket.name });

		// register the disconnect to notify when user leaves
		socket.on('disconnect', (function(userid) {
			return function() { userlist.remove(userid); }
		}(id)));
		
		socket.on('rename', (function(userid) {
			return function(data) {
				if (undefined === data.name) return;

				var serverData = userlist.get(userid);
				serverData.name = data.name;
				userlist.set(userid, data);
			};
		}(id)));
	}
}

function handler (request, response) {
    console.log("Request: " + request.url); 
	var ua = useragent.parse(request.headers['user-agent']);
    var filePath = '.' + request.url;
    
	// is this a tv? or a controller?
	var isMobile = /mobile/i.test(request.headers['user-agent']);
	
	var forceTv = (request.url == "/?tv");
	var forceController = (request.url[1] == '?' && !forceTv);
	var isTv = !forceController && (forceTv || !isMobile);
	
	// default page (for tv & controller)
		
    if (filePath == './') {
		if (isTv) {
			console.log("Zig.TV: The TV");
			filePath = './musicplayer.html';
		} else {
			console.log("Zig.TV: A controller");
			filePath = './newcontroller.html';
		}
	}

	if (forceController) {
		console.log("Zig.TV: forced controller");
		filePath = './newcontroller.html';
	}
	
	if (forceTv) {
		console.log("Zig.TV: forced TV");
		filePath = "./musicplayer.html";
	}

	// make sure query strings dont interfere with fetching from fs
	if (filePath.indexOf('?') > -1) {
		filePath = filePath.substr( 0, filePath.lastIndexOf('?') );
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
                    response.writeHead(200, { 'Content-Type': contentType, 'Cache-Control': 'No-Cache' });
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
			var roomToJoin = ""+socket.roomid;
			doJoin(socket, roomToJoin);
		}
		
		socket.on('joinRoom', function (data) {
			var roomToJoin = data['id'];
			doJoin(socket, roomToJoin);
		});

		// forward commands to the TV
		socket.on('sendToTV', function(data) {
			io.sockets.in(socket.roomid + "_server").emit('sendToTV', data);
		})
	});
	
	// only the tv sends this
	socket.on('startRoom', function(data) {
		console.log("Start room request");
		socket.roomid = data['id'];
		
		// create synclists for this room
		var playlist = synclist.create(socket.roomid + ":playlist");
		playlist.add("Playlist song 1");
		playlist.add("Playlist song 2");
		playlist.add("Playlist song 3");

		var userlist = synclist.create(socket.roomid + ":userlist");

		var medialist = synclist.create(socket.roomid + ":medialist");

		var zmoteOmercy = zmote.register(socket.roomid + ":zmote", socket);

		var newRoom = {
			roomid : socket.roomid,
			name : data['name'], 
			location : data['location'],
			playlist : playlist.id,
			userlist : userlist.id,
			medialist : medialist.id,
			zmoteid : socket.roomid + ":zmote",
		};

		roomslist.add(newRoom, socket.roomid);
		
		// TODO: Send the TV a stored location from prev session
		// socket.emit("locationSet", {location : roomLocations[socket.roomid]});
		
		socket.join(socket.roomid);
		socket.join(socket.roomid + "_server");
		
		//socket.broadcast.to(socket.roomid + "_server").emit('testMulti', { data : "this is a test"});
		
		socket.on('setName', function(data) {
			console.log("TV name changed: " + data.name);
			socket.name = data.name;
			var roomData = roomslist.get(socket.roomid);
			roomData.name = data.name;
			roomslist.set(socket.roomid, roomData);
		});
		
		socket.on('disconnect', function () {
			console.log("TV disconnected, removing room details");
			roomslist.remove(socket.roomid);
			//delete activeRooms[socket.roomid];
			// notify everyone in the room this happened ?
			socket.broadcast.to(socket.roomid).emit('tvDied');
		});

		socket.emit('roomStarted', newRoom );
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
		socket.emit("echofromzigtv", data);
		socket.broadcast.to(socket.roomid).emit("pingTV",data);
	});
	socket.on("pongTV", function(data)
	{
		socket.broadcast.to(socket.roomid).emit("echofromtv",data);
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
