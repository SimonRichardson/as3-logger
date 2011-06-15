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
		
		private static const PACKET_HEADER : String = '!SOS';
		
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
				_socket.send(buildMessage(level, message));
            else
            {
            	const bufferedMessage : BufferedOutputMessage = new BufferedOutputMessage(
																	this, 
																	level, 
																	buildMessage(level, message)
																	);
            	_buffer.push(bufferedMessage);
            }
		}
		
		/**
		 * @private
		 */
		private function handleConnect(event : Event) : void 
		{
			_socket.send(buildClear());
			_socket.send(buildSetKey(LogLevel.DEBUG, 0xefefef));
			_socket.send(buildSetKey(LogLevel.INFO, 0xe2ff00));
			_socket.send(buildSetKey(LogLevel.WARN, 0xff7c00));
			_socket.send(buildSetKey(LogLevel.ERROR, 0xff008e));
			_socket.send(buildSetKey(LogLevel.FATAL, 0xff0000));
			
			const total : int = _buffer.length;
			for(var i : int = 0; i<total; i++)
			{
				const bufferedMessage : BufferedOutputMessage = _buffer[i];
				_socket.send(bufferedMessage.message);
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
		private function escapeMessage(value : String) : String 
		{
			if(null == value) return '(null)';
			
			value = value.replace(/&/ig, "&amp;");
			value = value.replace(/\</ig, "&lt;");
			value = value.replace(/\>/ig, "&gt;");
			return value;
		}
		
		private function buildClear() : String
		{
			var result : String = PACKET_HEADER;
			
			result += '<clear/>';
			result += '\n';
			
			return result;
		}
		
		/**
		 * @private
		 */
		private function buildSetKey(level : LogLevel, color : int) : String
		{
			var result : String = PACKET_HEADER;
			
			result += '<setKey>';
			result += '<name>' + level.name + '</name>';
			result += '<color>' + color + '</color>';
			result += '</setKey>';
			result += '\n';
			
			return result;
		}
		
		/**
		 * @private
		 */
		private function buildMessage(level : LogLevel, message : String) : String
		{
			var result : String = PACKET_HEADER;
			if(message.indexOf('\n') >= 0)
			{
				const lines : Array = message.split('\n');
				
				result += '<showFoldMessage key="' + level.name + '">'; 
				result += '<title>' + escapeMessage(lines.shift()) + '</title>';
				result += '<message>' + escapeMessage(lines.join('\n')) + '</message>';
				result += '</showFoldMessage>';
				result += '\n';
			}
			else
			{
				result += '<showMessage key="' + level.name + '">'; 
				result += escapeMessage(message);
				result += '</showMessage>';
				result += '\n';
			}
					
			return result;
		}
	}
}
