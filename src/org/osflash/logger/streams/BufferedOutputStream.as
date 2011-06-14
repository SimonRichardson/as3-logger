package org.osflash.logger.streams
{
	import org.osflash.logger.ILogOutput;
	import org.osflash.logger.ILogOutputStream;
	import org.osflash.logger.LogLevel;

	import flash.events.TimerEvent;
	import flash.utils.Timer;
	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public class BufferedOutputStream implements ILogOutputStream
	{

		/**
		 * @private
		 */
		private var _outputs : Vector.<ILogOutput>;
		
		/**
		 * @private
		 */
		private var _timer : Timer;
		
		/**
		 * @private
		 */
		private var _buffer : Vector.<BufferedMessage>;
		
		/**
		 * Constructor for the BufferedOutputStream
		 */
		public function BufferedOutputStream()
		{
			_outputs = new Vector.<ILogOutput>();
			
			_buffer = new Vector.<BufferedMessage>();
			
			_timer = new Timer(500, -1);
			_timer.addEventListener(TimerEvent.TIMER, handleTimerEvent);
		}
		
		/**
		 * @inheritDoc
		 */
		public function add(output : ILogOutput) : ILogOutput
		{
			if(_outputs.indexOf(output) >= 0)
				throw new ArgumentError('Output already exists');
			
			_outputs.push(output);
			
			return output;
		}

		/**
		 * @inheritDoc
		 */
		public function remove(output : ILogOutput) : ILogOutput
		{
			const index : int = _outputs.indexOf(output);
			if(index == -1)
				throw new ArgumentError('No such formatter exists');
			
			_outputs.splice(index, 1);
			
			return output;
		}

		/**
		 * @inheritDoc
		 */
		public function contains(output : ILogOutput) : Boolean
		{
			return _outputs.indexOf(output) >= 0;
		}
		
		/**
		 * @inheritDoc
		 */
		public function getAt(index : int) : ILogOutput
		{
			if(index < 0 || index >= _outputs.length)
				throw new RangeError();
			
			return _outputs[index];
		}

		/**
		 * @inheritDoc
		 */
		public function write(level : LogLevel, message : String) : void
		{
			_buffer.push(new BufferedMessage(level, message));
			
			if(!_timer.running) _timer.start();
			
			// TODO : have a timer here to workout if we can close this down or not!
		}
		
		/**
		 * @private
		 */
		private function handleTimerEvent(event : TimerEvent) : void
		{
			var index : int = _buffer.length;
			while(--index > -1)
			{
				const bufferedMessage : BufferedMessage = _buffer.shift();
				
				const total : int = _outputs.length;
				for(var i : int = 0; i < total; i++)
				{
					const output : ILogOutput = _outputs[i];
					const outputMessage : String = output.process(bufferedMessage.message);
					output.log(bufferedMessage.level, outputMessage);
				}
			}
		}
		
		/**
		 * @inheritDoc
		 */
		public function get length() : int { return _outputs.length; }
	}
}
import org.osflash.logger.LogLevel;
internal class BufferedMessage
{
	
	public var level : LogLevel;
	
	public var message : String;

	public function BufferedMessage(level : LogLevel, message : String)
	{
		this.level = level;
		this.message = message;
	}	
}
