package org.osflash.logger.output
{
	import org.osflash.logger.ILogOutput;
	import org.osflash.logger.LogLevel;
	import org.osflash.logger.LogTag;
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
		
		/**
		 * @private
		 */
		private var _enabled : Boolean;
		
		/**
		 * @private
		 */
		private var _foldMessage : Boolean;

		public function SOSMaxOutput(foldMessage : Boolean = true)
		{
			_foldMessage = foldMessage;
			
			_enabled = true;
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
		override public function log(tag : LogTag, level : LogLevel, message : String) : void
		{
			if (!_enabled) return;
				
			if (_socket.connected)
				_socket.send(buildMessage(tag, level, message));
            else
            {
            	const bufferedMessage : BufferedOutputMessage = new BufferedOutputMessage(
																this, 
																tag,
																level, 
																buildMessage(tag, level, message)
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
			_socket.send(buildSetKey(LogLevel.DEBUG, 0xAAD4FF)); // 170 212 255
			_socket.send(buildSetKey(LogLevel.INFO, 0xFFFF95)); // 255 255 149
			_socket.send(buildSetKey(LogLevel.WARN, 0xFF9933)); // 255 153 51
			_socket.send(buildSetKey(LogLevel.ERROR, 0xFF1313)); // 255 19 19
			_socket.send(buildSetKey(LogLevel.FATAL, 0xD90303)); // 217 3 3
			
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
			_enabled = false;
			_socket = null;
			_buffer.length = 0;
			
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
		private function buildMessage(tag : LogTag, level : LogLevel, message : String) : String
		{
			var result : String = PACKET_HEADER;
			if(foldMessage && message.indexOf('\n') >= 0)
			{
				const lines : Array = message.split('\n');
				
				result += '<showFoldMessage key="' + level.name + '">'; 
				result += '<title>'; 
				result += '[' + tag.name.toUpperCase() + ']' + escapeMessage(lines.shift());
				result += '</title>';
				result += '<message>' + escapeMessage(lines.join('\n')) + '</message>';
				result += '</showFoldMessage>';
				result += '\n';
			}
			else
			{
				result += '<showMessage key="' + level.name + '">'; 
				result += '[' + tag.name.toUpperCase() + ']' + escapeMessage(message);
				result += '</showMessage>';
				result += '\n';
			}
					
			return result;
		}
		
		public function get foldMessage() : Boolean { return _foldMessage; }
		public function set foldMessage(value : Boolean) : void { _foldMessage = value; }
	}
}
