package org.osflash.logger.streams
{
	import org.osflash.logger.ILogOutput;
	import org.osflash.logger.LogLevel;
	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public class BufferedOutputMessage
	{
		
		/**
		 * @private
		 */
		private var _level : LogLevel;

		/**
		 * @private
		 */
		private var _message : String;
		
		/**
		 * @private
		 */
		private var _output : ILogOutput;

		public function BufferedOutputMessage(	output : ILogOutput, 
												level : LogLevel, 
												message : String
												)
		{
			if(null == output) throw new ArgumentError('Given output can not be null');
			if(null == level) throw new ArgumentError('Given level can not be null');
			if(null == message) throw new ArgumentError('Given message can not be null');
			
			_output = output;
			_level = level;
			_message = message;
		}

		public function get level() : LogLevel
		{
			return _level;
		}

		public function get message() : String
		{
			return _message;
		}

		public function get output() : ILogOutput
		{
			return _output;
		}
	}
}
