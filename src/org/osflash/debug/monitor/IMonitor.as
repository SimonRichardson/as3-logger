package org.osflash.debug.monitor
{
	import org.osflash.debug.monitor.adapters.IMonitorAdapter;
	import org.osflash.signals.ISignal;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public interface IMonitor
	{
		
		function add(adapter : IMonitorAdapter) : IMonitorAdapter;
		
		function remove(adapter : IMonitorAdapter) : IMonitorAdapter;
				
		function start() : void;
		
		function stop() : void;
		
		function get length() : int;
		
		function get sweepSignal() : ISignal;
		
		function get writeSignal() : ISignal;
	}
}
