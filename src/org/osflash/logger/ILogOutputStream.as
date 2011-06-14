package org.osflash.logger
{
	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public interface ILogOutputStream
	{
		
		function add(output : ILogOutput) : ILogOutput;
		
		function remove(output : ILogOutput) : ILogOutput;
		
		function contains(output : ILogOutput) : Boolean;
		
		function getAt(index : int) : ILogOutput;
		
		function write(level : LogLevel, message : String) : void;
		
		function get length() : int;
	}
}
