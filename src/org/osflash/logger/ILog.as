package org.osflash.logger
{
	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public interface ILog
	{
		
		function debug(...args) : void;

		function info(...args) : void;

		function warn(...args) : void;

		function error(...args) : void;

		function fatal(...args) : void;
	}
}
