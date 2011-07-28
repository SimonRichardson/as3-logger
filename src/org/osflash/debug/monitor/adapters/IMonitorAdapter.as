package org.osflash.debug.monitor.adapters
{
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public interface IMonitorAdapter
	{
		
		function get name() : String;
		
		function get length() : int;
		
		function get active() : int;
		
		function get free() : int;
	}
}
