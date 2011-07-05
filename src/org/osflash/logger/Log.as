package org.osflash.logger
{
	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public final class Log implements ILog
	{
		
		/**
		 * @private
		 */
		private var _stream : ILogOutputStream;
		
		public function Log(stream : ILogOutputStream)
		{
			if(null == stream) throw new ArgumentError('Given stream can not be null');
			
			_stream = stream;
		}
		
		/**
		 * @inheritDoc
		 */
		public function debug(...args) : void
		{
			_stream.write(LogLevel.DEBUG, args.join(" "));
		}

		/**
		 * @inheritDoc
		 */
		public function info(...args) : void
		{
			_stream.write(LogLevel.INFO, args.join(" "));
		}

		/**
		 * @inheritDoc
		 */
		public function warn(...args) : void
		{
			_stream.write(LogLevel.WARN, args.join(" "));
		}

		/**
		 * @inheritDoc
		 */
		public function error(...args) : void
		{
			_stream.write(LogLevel.ERROR, args.join(" "));
		}

		/**
		 * @inheritDoc
		 */
		public function fatal(...args) : void
		{
			_stream.write(LogLevel.FATAL, args.join(" "));
		}
		
		/**
		 * @inheritDoc
		 */
		public function get stream() : ILogOutputStream { return _stream; }
		
		/**
		 * @inheritDoc
		 */
		public function get enabled() : Boolean { return stream.enabled; }
		public function set enabled(value : Boolean) : void { stream.enabled = value; }
	}
}
