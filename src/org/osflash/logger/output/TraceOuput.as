package org.osflash.logger.output
{
	import org.osflash.logger.ILogOutput;
	import org.osflash.logger.LogLevel;
	import org.osflash.logger.LogTag;

	import flash.utils.getDefinitionByName;
	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public final class TraceOuput extends AbstractOutput implements ILogOutput
	{
		
		private static const method : Function = getDefinitionByName('trace') as Function;
			
		/**
		 * @inheritDoc
		 */			
		override public function log(tag : LogTag, level : LogLevel, message : String) : void
		{
			method('[' + tag.name.toUpperCase() + '][' + level.name.toUpperCase() + ']', message);
		}
	}
}
