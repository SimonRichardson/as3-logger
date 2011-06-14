package org.osflash.logger.output
{
	import org.osflash.logger.ILogFormatter;
	import org.osflash.logger.ILogOutput;
	import org.osflash.logger.LogLevel;
	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public class AbstractOutput implements ILogOutput
	{
		/**
		 * @private
		 */
		private var _formatters : Vector.<ILogFormatter>;
		
		/**
		 * Constructor for the AbstractOutput
		 */
		public function AbstractOutput()
		{
			_formatters = new Vector.<ILogFormatter>();
		}
		
		/**
		 * @inheritDoc
		 */
		public function process(message : String) : String
		{			
			var result : String = message;
			var index : int = _formatters.length;
			while(--index > -1)
			{
				const formatter : ILogFormatter = _formatters[index];
				result = formatter.format(result); 
			}
			return result;
		}
		
		/**
		 * @inheritDoc
		 */
		public function log(level : LogLevel, message : String) : void
		{
			throw new Error('Abstract method error');
		}

		/**
		 * @inheritDoc
		 */
		public function add(formatter : ILogFormatter) : ILogFormatter
		{
			if(_formatters.indexOf(formatter) >= 0)
				throw new ArgumentError('Formatter already exists');
			
			_formatters.push(formatter);
			
			return formatter;
		}

		/**
		 * @inheritDoc
		 */
		public function remove(formatter : ILogFormatter) : ILogFormatter
		{
			const index : int = _formatters.indexOf(formatter);
			if(index == -1)
				throw new ArgumentError('No such formatter exists');
			
			_formatters.splice(index, 1);
			
			return formatter;
		}

		/**
		 * @inheritDoc
		 */
		public function contains(formatter : ILogFormatter) : Boolean
		{
			return _formatters.indexOf(formatter) >= 0;
		}
	}
}
