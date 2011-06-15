package org.osflash.logger
{
	import org.osflash.logger.output.SOSMaxOutput;
	import org.osflash.logger.streams.BufferedOutputStream;
	import org.osflash.logger.formatter.LogDateFormatter;
	import org.osflash.logger.formatter.LogTimestampFormatter;
	import org.osflash.logger.output.TextFieldOutput;
	import org.osflash.logger.output.TraceOuput;
	import org.osflash.logger.streams.DefaultOutputStream;
	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public class LogFactory implements ILogFactory
	{
		
		public static const DEFAULT : int = SOS;
		
		public static const TRACE : int = 0;
		
		public static const TEXTFIELD : int = 1;
		
		public static const SOS : int = 2;
		
		logger_namespace static const DEFAULT_LOGGER : ILog = new LogFactory().create(DEFAULT);
		
		public function create(type : int, buffered : Boolean = false) : ILog
		{
			var output : ILogOutput;
			
			const stream : ILogOutputStream = buffered ? 
														new BufferedOutputStream() 
														: 
														new DefaultOutputStream();
			switch(type)
			{
				case TEXTFIELD:
					output = new TextFieldOutput();
					
					output.add(new LogDateFormatter());
					output.add(new LogTimestampFormatter());
					
					stream.add(output);	
					break; 
				
				case SOS:
					output = new SOSMaxOutput();
					
					output.add(new LogDateFormatter());
					output.add(new LogTimestampFormatter());
					
					stream.add(output);
					break;
				case TRACE:
					output = new TraceOuput();
					
					output.add(new LogDateFormatter());
					output.add(new LogTimestampFormatter());
					
					stream.add(output);
					break;
				default:
					throw new ArgumentError('Unknown log type');
					break;
			}
			
			return new Log(stream);
		}	
	}
}
