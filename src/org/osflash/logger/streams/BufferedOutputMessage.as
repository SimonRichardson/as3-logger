package org.osflash.logger.streams
{
	import org.osflash.logger.ILogOutput;
	import org.osflash.logger.LogLevel;
	import org.osflash.logger.LogTag;
	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public class BufferedOutputMessage
	{
		
		/**
		 * @private
		 */
		private var _tag : LogTag;
		
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
												tag : LogTag,
												level : LogLevel, 
												message : String
												)
		{
			if(null == output) throw new ArgumentError('Given output can not be null');
			if(null == tag) throw new ArgumentError('Given tag can not be null');
			if(null == level) throw new ArgumentError('Given level can not be null');
			if(null == message) throw new ArgumentError('Given message can not be null');
			
			_output = output;
			
			_tag = tag;
			_level = level;
			_message = message;
		}
		
		public function get tag() : LogTag { return _tag; }
		
		public function get level() : LogLevel { return _level; }

		public function get message() : String { return _message; }

		public function get output() : ILogOutput { return _output; }
	}
}
