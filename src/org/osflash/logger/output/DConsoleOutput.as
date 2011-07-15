package org.osflash.logger.output
{
	import org.osflash.logger.ILogOutput;
	import org.osflash.logger.LogLevel;
	import org.osflash.logger.LogTag;

	import flash.utils.getDefinitionByName;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class DConsoleOutput extends AbstractOutput implements ILogOutput
	{
		
		/**
		 * @private
		 */
		private var _console : Class;
		
		/**
		 * @private
		 */		
		private var _consolePrint : Function;
		
		/**
		 * @private
		 */
		private var _consoleLevels : Class;
		
		/**
		 * @private
		 */
		private var _enabled : Boolean;
		
		public function DConsoleOutput()
		{
			_console = getDefinitionByName('com.furusystems.dconsole2.DConsole') as Class;
			_consoleLevels = getDefinitionByName(
										'com.furusystems.dconsole2.core.output.ConsoleMessageTypes'
										) as Class;
			
			_consolePrint = _console['print'];
						
			_enabled = (null != _console && null != _consolePrint);
		}

		/**
		 * @inheritDoc
		 */			
		override public function log(tag : LogTag, level : LogLevel, message : String) : void
		{
			if(!_enabled) return;
			
			var consoleLevel : String = "";
			switch(level)
			{
				case LogLevel.DEBUG: 
					consoleLevel = _consoleLevels['DEBUG']; 
					break;
				case LogLevel.ERROR: 
					consoleLevel = _consoleLevels['ERROR']; 
					break;
				case LogLevel.WARN: 
					consoleLevel = _consoleLevels['WARNING']; 
					break;
				case LogLevel.INFO: 
					consoleLevel = _consoleLevels['INFO']; 
					break;
				case LogLevel.FATAL: 
					consoleLevel = _consoleLevels['FATAL']; 
					break;
			}
						
			_consolePrint('[' + tag.name.toUpperCase() + ']' + message, consoleLevel);
		}
	}
}
