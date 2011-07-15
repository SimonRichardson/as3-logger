package org.osflash.logger.streams
{
	import org.osflash.logger.ILogOutput;
	import org.osflash.logger.ILogOutputStream;
	import org.osflash.logger.LogLevel;
	import org.osflash.logger.LogTag;

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
		private var _bufferTimer : Timer;
		
		/**
		 * @private
		 */
		private var _closeTimer : Timer;
		
		/**
		 * @private
		 */
		private var _buffer : Vector.<BufferedOutputMessage>;
		
		/**
		 * @private
		 */
		private var _enabled : Boolean;
		
		/**
		 * Constructor for the BufferedOutputStream
		 */
		public function BufferedOutputStream()
		{
			_outputs = new Vector.<ILogOutput>();
			
			_buffer = new Vector.<BufferedOutputMessage>();
			
			_bufferTimer = new Timer(500, -1);
			_bufferTimer.addEventListener(TimerEvent.TIMER, handleBufferTimerEvent);
			
			_closeTimer = new Timer(1000, -1);
			_closeTimer.addEventListener(TimerEvent.TIMER, handleCloseTimerEvent);
			
			_enabled = true;
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
		public function write(tag : LogTag, level : LogLevel, message : String) : void
		{
			if(!enabled) return;
			
			const total : int = _outputs.length;
			for(var i : int = 0; i < total; i++)
			{
				const output : ILogOutput = _outputs[i];
				const outputMessage : String = output.process(message);
				_buffer.push(new BufferedOutputMessage(output, tag, level, outputMessage));
			}
			
			if(!_bufferTimer.running) _bufferTimer.start();
			
			_closeTimer.reset();
			_closeTimer.start();
		}
		
		/**
		 * @private
		 */
		private function handleBufferTimerEvent(event : TimerEvent) : void
		{
			var index : int = _buffer.length;
			while(--index > -1)
			{
				const bufferedMessage : BufferedOutputMessage = _buffer.shift();
				bufferedMessage.output.log(	bufferedMessage.tag, 
											bufferedMessage.level, 
											bufferedMessage.message
											);
			}
		}
		
		/**
		 * @private
		 */
		private function handleCloseTimerEvent(event : TimerEvent) : void
		{
			if(_bufferTimer.running) _bufferTimer.stop();
			
			_closeTimer.stop();
		}
		
		/**
		 * @inheritDoc
		 */
		public function get enabled() : Boolean { return _enabled; }
		public function set enabled(value : Boolean) : void { _enabled = value; }
		
		/**
		 * @inheritDoc
		 */
		public function get length() : int { return _outputs.length; }
	}
}
