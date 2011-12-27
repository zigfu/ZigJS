var qs = document.location.search;
var roomid = qs.substr(1,qs.length);
var socket;
	
anjou = {

	connect: function (url){
		socket = io.connect(url);	

		socket.on('connect', function (){
			socket.emit('controllerConnected',{id: roomid});
		});

		socket.on('try_local', function(data){ 
			local_socket = io.connect('http://'+data['ip']);
	
			local_socket.on('connect', function(){
				local_socket.emit('localControllerConnected',{id: roomid});});
		
			local_socket.on('break_remote', function(){
			//todo: move all events for socket.on to local_socket first
				socket = local_socket;		
			});
		});
	},
	
	emit: function(msg, data){
		socket.emit(msg,data);
	}
}
  