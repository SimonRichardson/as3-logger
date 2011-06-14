package org.osflash.logger
{
	import org.osflash.logger.formatter.LogDateFormatter;
	import org.osflash.logger.formatter.LogTimestampFormatter;
	import org.osflash.logger.output.TraceOuput;
	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public class LogFactory implements ILogFactory
	{
		
		public static const DEFAULT : int = 0;
		
		logger_namespace static const DEFAULT_LOGGER : ILog = new LogFactory().create(DEFAULT);
		
		public function create(type : int = -1) : ILog
		{
			switch(type)
			{
				case DEFAULT:
					const stream : ILogOutputStream = new LogOutputStream();
					const output : ILogOutput = new TraceOuput();
					
					output.add(new LogDateFormatter());
					output.add(new LogTimestampFormatter());
					
					stream.add(output);
					
					return new Log(stream);
					break;
				default:
					throw new ArgumentError('Unknown log type');
					break;
			}
		}		
	}
}
