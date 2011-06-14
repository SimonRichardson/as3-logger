package org.osflash.logger.output
{
	import org.osflash.logger.ILogOutput;
	import org.osflash.logger.LogLevel;
	import org.osflash.logger.streams.BufferedOutputMessage;

	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.XMLSocket;
	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public class SOSMaxOutput extends AbstractOutput implements ILogOutput
	{
		
		/**
		 * @private
		 */
		private var _socket : XMLSocket;
		
		/**
		 * @private
		 */
		private var _buffer : Vector.<BufferedOutputMessage>;

		public function SOSMaxOutput()
		{
			_buffer = new Vector.<BufferedOutputMessage>();
			
			_socket = new XMLSocket();
			_socket.addEventListener(Event.CONNECT, handleConnect);
			_socket.addEventListener(IOErrorEvent.IO_ERROR, handleError);
			_socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, handleError);
			
			try { _socket.connect("127.0.0.1", 4444); }
			catch(error : Error) { trace("SOSLogOutput error trying to connect."); }
		}

		/**
		 * @inheritDoc
		 */			
		override public function log(level : LogLevel, message : String) : void
		{
			if (_socket.connected)
			{
				_socket.send("!SOS<showMessage key=\"" + 
											level.name + 
											"\">" + 
											escapeXML(message) + 
											"</showMessage>\n"
											);
			}
            else
            	_buffer.push(new BufferedOutputMessage(this, level, message));
		}
		
		/**
		 * @private
		 */
		private function handleConnect(event : Event) : void 
		{
			_socket.send("!SOS<clear/>\n");
			_socket.send("!SOS<setKey><name>debug</name><color>" + 0xefefef + "</color></setKey>\n");
			_socket.send("!SOS<setKey><name>trace</name><color>" + 0xffffff + "</color></setKey>\n");
			_socket.send("!SOS<setKey><name>info</name><color>" + 0xe2ff00 + "</color></setKey>\n");
			_socket.send("!SOS<setKey><name>warn</name><color>" + 0xff7c00 + "</color></setKey>\n");
			_socket.send("!SOS<setKey><name>error</name><color>" + 0xff008e + "</color></setKey>\n");
			_socket.send("!SOS<setKey><name>fatal</name><color>" + 0x00ff00 + "</color></setKey>\n");
			
			const total : int = _buffer.length;
			for(var i : int = 0; i<total; i++)
			{
				const bufferedMessage : BufferedOutputMessage = _buffer[i];
				_socket.send("!SOS<showMessage key=\"" + 
											bufferedMessage.level.name + 
											"\">" + 
											escapeXML(bufferedMessage.message) + 
											"</showMessage>\n"
											);
			}
			
			_buffer.length = 0;
		}
		
		/**
		 * @private
		 */
		private function handleError(event : Event) : void 
		{
			trace("SOSLogOutput Error : " + event);
		}
		
		/**
		 * @private
		 */
		private function escapeXML(value : String) : String 
		{
			value = value.replace(/&/ig, "&amp;");
			value = value.replace(/\</ig, "&lt;");
			value = value.replace(/\>/ig, "&gt;");
			return value;
		}
	}
}
