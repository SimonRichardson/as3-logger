package org.osflash.logger.streams
{
	import org.osflash.logger.ILogOutput;
	import org.osflash.logger.ILogOutputStream;
	import org.osflash.logger.LogLevel;
	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public class DefaultOutputStream implements ILogOutputStream
	{
		
		/**
		 * @private
		 */
		private var _outputs : Vector.<ILogOutput>;
		
		/**
		 * Constructor for the LogOutputStream
		 */
		public function DefaultOutputStream()
		{
			_outputs = new Vector.<ILogOutput>();
		}
		
		/**
		 * @inheritDoc
		 */
		public function add(output : ILogOutput) : ILogOutput
		{
			if(_outputs.indexOf(output) >= 0)
				throw new ArgumentError('Output already exists');
			
			_outputs.push(output);
			
			return output;
		}

		/**
		 * @inheritDoc
		 */
		public function remove(output : ILogOutput) : ILogOutput
		{
			const index : int = _outputs.indexOf(output);
			if(index == -1)
				throw new ArgumentError('No such formatter exists');
			
			_outputs.splice(index, 1);
			
			return output;
		}

		/**
		 * @inheritDoc
		 */
		public function contains(output : ILogOutput) : Boolean
		{
			return _outputs.indexOf(output) >= 0;
		}
		
		/**
		 * @inheritDoc
		 */
		public function getAt(index : int) : ILogOutput
		{
			if(index < 0 || index >= _outputs.length)
				throw new RangeError();
			
			return _outputs[index];
		}

		/**
		 * @inheritDoc
		 */
		public function write(level : LogLevel, message : String) : void
		{
			const total : int = _outputs.length;
			for(var i : int = 0; i < total; i++)
			{
				const output : ILogOutput = _outputs[i];
				const outputMessage : String = output.process(message);
				output.log(level, outputMessage);
			}
		}
		
		/**
		 * @inheritDoc
		 */
		public function get length() : int { return _outputs.length; }
	}
}
