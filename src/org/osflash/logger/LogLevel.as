package org.osflash.logger
{
	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public class LogLevel
	{
		
		public static const DEBUG : LogLevel = new LogLevel("debug");
		
		public static const INFO : LogLevel = new LogLevel("info");

		public static const WARN : LogLevel = new LogLevel("warn");

		public static const ERROR : LogLevel = new LogLevel("error");

		public static const FATAL : LogLevel = new LogLevel("fatal");

		public var name : String;

		public function LogLevel(logName : String) 
		{
			name = logName;
		}
	}
}
