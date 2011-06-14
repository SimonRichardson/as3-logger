package org.osflash.logger
{
	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public interface ILogFactory
	{
		
		function create(type : int, buffered : Boolean = false) : ILog;
	}
}
