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
			const tag : LogTag = args[0] is LogTag ? args.shift() : LogTag.DEFAULT;
			_stream.write(tag, LogLevel.DEBUG, args.join(" "));
		}

		/**
		 * @inheritDoc
		 */
		public function info(...args) : void
		{
			const tag : LogTag = args[0] is LogTag ? args.shift() : LogTag.DEFAULT;
			_stream.write(tag, LogLevel.INFO, args.join(" "));
		}

		/**
		 * @inheritDoc
		 */
		public function warn(...args) : void
		{
			const tag : LogTag = args[0] is LogTag ? args.shift() : LogTag.DEFAULT;
			_stream.write(tag, LogLevel.WARN, args.join(" "));
		}

		/**
		 * @inheritDoc
		 */
		public function error(...args) : void
		{
			const tag : LogTag = args[0] is LogTag ? args.shift() : LogTag.DEFAULT;
			_stream.write(tag, LogLevel.ERROR, args.join(" "));
		}

		/**
		 * @inheritDoc
		 */
		public function fatal(...args) : void
		{
			const tag : LogTag = args[0] is LogTag ? args.shift() : LogTag.DEFAULT;
			_stream.write(tag, LogLevel.FATAL, args.join(" "));
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
