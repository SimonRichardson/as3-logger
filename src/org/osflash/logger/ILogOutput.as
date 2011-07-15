package org.osflash.logger
{
	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public interface ILogOutput
	{
		
		function process(message : String) : String;
		
		function log(tag : LogTag, level : LogLevel, message : String) : void;
		
		function add(formatter : ILogFormatter) : ILogFormatter;
		
		function remove(formatter : ILogFormatter) : ILogFormatter;
		
		function contains(formatter : ILogFormatter) : Boolean;
	}
}
