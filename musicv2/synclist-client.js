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
	
	function subscribe(socket, id) {
		// make sure this socket can receive synclist messages (if it cant already)
		listify(socket);

		// construct our return object
		var ret =  {
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
			},

			get : function(itemid) {
				return lists[id].items.getItem(itemid);
			},

			set : function(itemid, itemdata) {
				socket.emit("list-set", { listid : id, itemid : itemid, itemdata : itemdata });
			},

			bind : function(element, makeelement) {

				if (undefined === makeelement) {
					makeelement = function(id, data) {
						var li = document.createElement('li');
						li.innerHTML = data;
						return li;
					};					
				}

				lists[id].bound = true;
				lists[id].boundelement = element;
				lists[id].makeelement = makeelement;
			},

			onadd : function() {},
			onremove : function() {},
			onclear : function() {},
			onset : function() {}
		};

		// new entry for this list we are subscribed to
		lists[id] = { 
			items : new Hash(),
			obj : ret,
			bound : false,
			};
		
		socket.emit("list-subscribe", { listid : id });
		return ret;
	}
	
	function getElementByItemid(parent, itemid) {
		for (var i = 0; i < parent.children.length; i++) {
 		   if (parent.children[i].getAttribute("data-synclistid") == itemid) {
        		return parent.children[i];
    		}
		}
		return null;
	}

	function add(listid, itemid, itemdata) {
		lists[listid].items.setItem(itemid, itemdata);
		lists[listid].obj.onadd(itemid, itemdata);
		if (lists[listid].bound) {
			var newElement = lists[listid].makeelement(itemid, itemdata);
			newElement.setAttribute("data-synclistid", itemid);
			lists[listid].boundelement.appendChild(newElement)
		}
	}

	function remove(listid, itemid) {
		delete lists[listid].items.removeItem(itemid);
		lists[listid].obj.onremove(itemid);
		if (lists[listid].bound) {
			var child = getElementByItemid(lists[listid].boundelement, itemid);
			lists[listid].boundelement.removeChild(child);
		}
	}
	
	function clear(listid) {
		lists[listid].items.clear();
		lists[listid].obj.onclear();
		if (lists[listid].bound) {
			lists[listid].boundelement.innerHTML = "";
		}
	}

	function set(listid, itemid, itemdata) {
		lists[listid].items.setItem(itemid, itemdata);
		lists[listid].obj.onset(itemid, itemdata);
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

		socket.on("list-set", function(data) {
			set(data.listid, data.itemid, data.itemdata);
		});
	}
	
	return {
		subscribe : subscribe,
	};
}());