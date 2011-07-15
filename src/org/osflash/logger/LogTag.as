package org.osflash.logger
{
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class LogTag
	{
		
		public static const DEFAULT : LogTag = new LogTag("default");
		
		private var _name : String;

		public function LogTag(logName : String) 
		{
			_name = logName;
		}

		public function get name() : String { return _name; }
	}
}
