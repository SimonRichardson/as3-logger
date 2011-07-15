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
		
		function filter(tag : LogTag) : void;
		
		function filterNot(tag : LogTag) : void;
		
		function write(tag : LogTag, level : LogLevel, message : String) : void;
		
		function get enabled() : Boolean;
		function set enabled(value : Boolean) : void;
		
		function get length() : int;
	}
}
