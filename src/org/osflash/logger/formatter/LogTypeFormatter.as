package org.osflash.logger.formatter
{
	import org.osflash.logger.ILogFormatter;
	import org.osflash.logger.LogType;

	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public class LogTypeFormatter implements ILogFormatter
	{
		
		/**
		 * @private
		 */
		private var _type : LogType;
		
		/**
		 * Create a new LogTypeFormatter which will prepend a LogType.name to the beginning 
		 * of the message.
		 * 
		 * @param type LogType which to prepend.
		 */
		public function LogTypeFormatter(type : LogType)
		{
			if(null == type) throw new ArgumentError('Given value can not be null');
			
			_type = type;
		}
		
		/**
		 * @inheritDoc
		 */
		public function format(message : String) : String
		{
			return '[' + _type.name + '] ' + message;
		}
	}
}
