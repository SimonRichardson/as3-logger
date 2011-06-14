package org.osflash.logger.output
{
	import flash.utils.getDefinitionByName;
	import org.osflash.logger.ILogOutput;
	import org.osflash.logger.LogLevel;
	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public final class TraceOuput extends AbstractOutput implements ILogOutput
	{
		
		private static const method : Function = getDefinitionByName('trace') as Function;
			
		override public function log(level : LogLevel, message : String) : void
		{
			method('[' + level.name.toUpperCase() + ']', message);
		}
	}
}
