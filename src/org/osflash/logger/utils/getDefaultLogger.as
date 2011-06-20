package org.osflash.logger.utils
{
	import org.osflash.logger.ILog;
	import org.osflash.logger.LogFactory;
	import org.osflash.logger.logger_namespace;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public function getDefaultLogger() : ILog
	{
		use namespace logger_namespace;
		return LogFactory.DEFAULT_LOGGER;
	}
}
