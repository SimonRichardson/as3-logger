package org.osflash.logger.output
{
	import org.osflash.logger.ILogOutput;
	import org.osflash.logger.LogLevel;

	import flash.text.TextField;
	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public final class TextFieldOutput extends AbstractOutput implements ILogOutput
	{
		
		/**
		 * @private
		 */
		private var _textField : TextField;
		
		public function TextFieldOutput(textField : TextField = null)
		{
			_textField = textField || new TextField();
		}

		/**
		 * @inheritDoc
		 */	
		override public function log(level : LogLevel, message : String) : void
		{
			_textField.appendText('[' + level.name.toUpperCase() + '] ' + message + '\n');
		}
		
		/**
		 * Get the current textfield used for the output
		 * 
		 * @return TextField currently used.
		 */
		public function get textField() : TextField
		{
			return _textField;
		}		
	}
}
