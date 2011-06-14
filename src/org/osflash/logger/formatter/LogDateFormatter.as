package org.osflash.logger.formatter
{
	import org.osflash.logger.ILogFormatter;
	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public class LogDateFormatter implements ILogFormatter
	{
		
		public function format(message : String) : String
		{
			const now : Date = new Date();
			
			const date : String = now.date + "-" + (now.month + 1) + "-" + now.fullYear;
			const time : String = now.hours + ":" + now.minutes +":" + now.seconds;
			
			return '[' + date + " " + time + '] ' + message;
		}
	}
}
