function Hash()
{
	this.length = 0;
	this.items = {}; //new Array();
	for (var i = 0; i < arguments.length; i += 2) {
		if (typeof(arguments[i + 1]) != 'undefined') {
			this.items[arguments[i]] = arguments[i + 1];
			this.length++;
		}
	}
   
	this.removeItem = function(in_key)
	{
		var tmp_previous;
		if (typeof(this.items[in_key]) != 'undefined') {
			this.length--;
			var tmp_previous = this.items[in_key];
			delete this.items[in_key];
		}
	   
		return tmp_previous;
	}

	this.getItem = function(in_key) {
		return this.items[in_key];
	}

	this.setItem = function(in_key, in_value)
	{
		var tmp_previous;
		if (typeof(in_value) != 'undefined') {
			if (typeof(this.items[in_key]) == 'undefined') {
				this.length++;
			}
			else {
				tmp_previous = this.items[in_key];
			}

			this.items[in_key] = in_value;
		}
	   
		return tmp_previous;
	}

	this.hasItem = function(in_key)
	{
		return typeof(this.items[in_key]) != 'undefined';
	}

	this.clear = function()
	{
		for (var i in this.items) {
			delete this.items[i];
		}

		this.length = 0;
	}
}

var synclist = (function() {

	lists = {};
	
	possiblecallbacks = {
		add : function() {},
		remove : function() {},
		clear : function() {},
	};
	
	function subscribe(socket, id, callbacks) {
		listify(socket);
		
		lists[id] = {};
		lists[id].items = new Hash();
		lists[id].callbacks = possiblecallbacks;
		for (var cb in callbacks) {
			if (callbacks.hasOwnProperty(cb)) {
				lists[id].callbacks[cb] = callbacks[cb];
			}
		}
		
		socket.emit("list-subscribe", { listid : id });
		
		return {
			add : function(newitem, itemid) {
				if (undefined === itemid) {
					itemid = lists[id].items.length;
				}
				
				socket.emit("list-add", { listid : id, itemid : itemid, itemdata : newitem });
			},
			
			remove : function(itemid) {
				socket.emit("list-remove", { listid : id, itemid : itemid });
			},
			
			clear : function() {
				socket.emit("list-clear", { listid : id });
			},
			
			get items() {
				return lists[id].items.items;
			}
		};
	}
	
	function add(listid, itemid, itemdata) {
		lists[listid].items.setItem(itemid, itemdata);
		lists[listid].callbacks.add(itemid, itemdata);
	}

	function remove(listid, itemid) {
		delete lists[listid].items.removeItem(itemid);
		lists[listid].callbacks.remove(itemid);
	}
	
	function clear(listid) {
		lists[listid].items.clear();
		lists[listid].callbacks.clear();
	}
	
	function listify(socket) {
		if (undefined !== socket.listified) {
			return;
		}
		socket.listified = true;
		
		socket.on("list-add", function(data) {
			add(data.listid, data.itemid, data.itemdata);
		});
	
		socket.on("list-remove", function(data) {
			remove(data.listid, data.itemid);
		});
	
		socket.on("list-data", function(data) {
			clear(data.listid);
			for (var itemid in data.listdata) {
				add(data.listid, itemid, data.listdata[itemid]);
			}
		});
		
		socket.on("list-clear" , function(data) {
			clear();
		});
	}
	
	return {
		listify : listify,
		subscribe : subscribe,
	};
}());