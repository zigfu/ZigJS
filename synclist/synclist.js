hash = require('./hash');

var io;
function init(theio) {
	io = theio;
	return exports;
}

lists = {};

function makeListName(listid) {
	return "list-" + listid;
}

function add(listid, itemid, itemdata) {
	lists[listid].setItem(itemid, itemdata);
	io.sockets.in(makeListName(listid)).emit('list-add', { listid : listid, itemid : itemid, itemdata : itemdata } );
}

function remove(listid, itemid) {
	lists[listid].removeItem(itemid);
	io.sockets.in(makeListName(listid)).emit('list-remove', { listid : listid, itemid : itemid } );
}

function clear(listid) {
	lists[listid].clear();
	io.sockets.in(makeListName(listid)).emit('list-clear', { listid : listid });
}

function create(listid) {
	
	if (undefined === lists[listid]) {
		lists[listid] = new hash.Hash();
	}
	
	return {
		add : function(itemdata, itemid) {
			if (undefined === itemid) {
				itemid = lists[listid].length;
			}
			add(listid, itemid, itemdata);
		},
		
		remove : function(itemid) {
			remove(listid, itemid);
		},
		
		clear : function() {
			clear(listid);
		}
	};
}

function destroy(listid) {
	delete lists[listid];
}

function listify(socket) {
	socket.on('list-add', function(data) {
		add(data.listid, data.itemid, data.itemdata);
	});
	
	socket.on('list-remove', function(data) {
		remove(data.listid, data.itemid);
	});
	
	socket.on('list-clear', function(data) {
		clear(data.listid);
	});
	
	socket.on('list-subscribe', function(data) {
		create(data.listid);
		socket.join(makeListName(data.listid));
		socket.emit('list-data', { listid : data.listid, listdata : lists[data.listid].items } );
	});
	
	socket.on('list-unsubscribe', function(data) {
		socket.leave(makeListName(data.listid));
	});
}

exports.init = init;
exports.listify = listify;
exports.create = create;
exports.destroy = destroy;