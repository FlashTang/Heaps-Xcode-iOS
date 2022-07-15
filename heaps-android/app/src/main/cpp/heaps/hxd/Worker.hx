package hxd;

class Worker<T:EnumValue> {

	#if flash
	public static var ENABLE = flash.system.Worker.isSupported;
	var sendChan : flash.system.MessageChannel;
	var recvChan : flash.system.MessageChannel;
	var curMessage : { code : Int, count : Int, args : Array<Dynamic> };
	var queue : Array<Dynamic>;
	#else
	public static var ENABLE = false;
	#end
	var enumValue : Enum<T>;
	var isWorker : Bool;
	var debugPeer : Worker<T>;
	var useWorker : Bool;

	public function new( e : Enum<T> ) {
		this.enumValue = e;
		this.useWorker = ENABLE;
	}

	function clone() : Worker<T> {
		throw "Not implemented";
		return null;
	}

	public function send( msg : T ) {
		if( !useWorker ) {
			#if debug
			// emulate delay
			haxe.Timer.delay(debugPeer.handleMessage.bind(msg), 1);
			#else
			debugPeer.handleMessage(msg);
			#end
			return;
		}
		#if flash
		inline function sendRaw( v : Dynamic ) {
			if( queue != null )
				queue.push(v);
			else
				sendChan.send(v);
		}
		var args = Type.enumParameters(msg);
		sendRaw( { code : Type.enumIndex(msg), count : args.length } );
		// send args as separate messages or else bytearrays will get copied
		for( a in args )
			sendRaw(a);
		#else
		throw "TODO";
		#end
	}

	function readMessage() : T {
		#if flash
		if( curMessage == null ) {
			curMessage = recvChan.receive();
			curMessage.args = [];
			if( curMessage.count > 0 )
				return null;
		} else {
			curMessage.args.push(recvChan.receive());
			if( --curMessage.count > 0 )
				return null;
		}
		var m = Type.createEnumIndex(enumValue, curMessage.code, curMessage.args);
		curMessage = null;
		return m;
		#else
		throw "TODO";
		#end
	}

	function handleMessage( msg : T ) {
		throw "TODO";
	}

	function setupMain() {
	}

	function setupWorker() {
	}

	public function start() {
		if( !useWorker ) {
			isWorker = false;
			setupMain();
			debugPeer = clone();
			debugPeer.isWorker = true;
			debugPeer.setupWorker();
			debugPeer.debugPeer = this;
			return false;
		}
		#if flash
		var cur = flash.system.Worker.current;
		if( cur.isPrimordial ) {
			var wait = true;
			var bgWorker = flash.system.WorkerDomain.current.createWorker(flash.Lib.current.loaderInfo.bytes, true);
			sendChan = cur.createMessageChannel(bgWorker);
			recvChan = bgWorker.createMessageChannel(cur);
			recvChan.addEventListener(flash.events.Event.CHANNEL_MESSAGE, function(_) {
				if( queue != null ) {
					recvChan.receive(true); // ignore
					for( m in queue )
						sendChan.send(m);
					queue = null;
					return;
				}
				var msg = readMessage();
				if( msg != null ) handleMessage(msg);
			});
			bgWorker.setSharedProperty("send", sendChan);
			bgWorker.setSharedProperty("recv", recvChan);
			isWorker = false;
			queue = [];
			setupMain();
			bgWorker.start();
			return false;
		} else {
			// inverse
			sendChan = cur.getSharedProperty("recv");
			recvChan = cur.getSharedProperty("send");
			recvChan.addEventListener(flash.events.Event.CHANNEL_MESSAGE, function(e) {
				var msg = readMessage();
				if( msg != null ) handleMessage(msg);
			});
			isWorker = true;
			sendChan.send(0);
			setupWorker();
			return true;
		}
		#else
		throw "Native worker not supported for this platform";
		#end
	}

}