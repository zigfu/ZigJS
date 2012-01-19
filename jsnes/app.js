var app = require('http').createServer(handler)
  , io = require('socket.io').listen(app, {origins: '*:*'}) // TODO: Origins
  , fs = require('fs')
  , path = require('path')
  , net = require('net')
  , zigmote = require('zigmote').listen(io);
  
app.listen(80);

function handler (request, response) {
    var filePath = '.' + request.url;
    
	// default page (for tv & controller)
		
    if (filePath == './') {
        filePath = "./index.html";
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
     
    console.log("Serving " + filePath);
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
