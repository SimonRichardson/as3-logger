package org.osflash.logger.formatter
{
	import org.osflash.logger.ILogFormatter;

	import flash.utils.getTimer;
	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public class LogTimestampFormatter implements ILogFormatter
	{
		
		/**
		 * @inheritDoc
		 */
		public function format(message : String) : String
		{
			return getTimer() + 'ms > ' + message;
		}
	}
}
