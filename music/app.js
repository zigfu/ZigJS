var app = require('http').createServer(handler)
  , io = require('socket.io').listen(app)
  , fs = require('fs')
  , path = require('path');
  
app.listen(80);

function handler (request, response) {
  console.log('request starting...');
    console.log(request.url); 
    var filePath = '.' + request.url;
    if (filePath == './')
        filePath = './index.html';
    if (request.url[1] == '?')
    {
    	console.log('saw ?, loading kb.htm');
    	filePath = './kb.htm';     
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
	
	socket.on('controllerConnected', function (data) {
		console.log("controllerConnected");
		socket.set('roomid', data['id']);
		socket.join(data['id']);	

		io.sockets.in(data['id']).emit('newjoin');
	});
	
	socket.on("sweet", function(socket) {
		console.log("SWEET");
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
  
  socket.on('joinid', function(data)
  {
  	console.log("joinid:");
  	console.log(data);
  	socket.set('roomid', data['id']);
  	socket.join(data['id']);	
  });
  
  
});