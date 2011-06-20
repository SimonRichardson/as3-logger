package org.osflash.logger.output
{
	import org.osflash.logger.ILogOutput;
	import org.osflash.logger.LogLevel;

	import flash.external.ExternalInterface;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class FirebugOutput extends AbstractOutput implements ILogOutput
	{
		
		/**
		 * @private
		 */
		private var _enabled : Boolean;
		
		public function FirebugOutput()
		{
			_enabled = ExternalInterface.available;
		}

		/**
		 * @inheritDoc
		 */			
		override public function log(level : LogLevel, message : String) : void
		{
			if(!_enabled) return;
			
			// Firebug doesn't support Fatal.
			const levelName : String = level == LogLevel.FATAL ? LogLevel.ERROR.name : level.name;
			const methodName : String = "console." + levelName;
			
			ExternalInterface.call(methodName, message);
		}
	}
}
