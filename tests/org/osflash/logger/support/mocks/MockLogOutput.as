package org.osflash.logger.support.mocks
{
	import asunit.asserts.assertNotNull;
	import asunit.asserts.assertEquals;
	import org.osflash.logger.ILogOutput;
	import org.osflash.logger.LogLevel;
	import org.osflash.logger.output.AbstractOutput;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class MockLogOutput extends AbstractOutput implements ILogOutput
	{
		
		private var _level : LogLevel;
		
		private var _message : String;
		
		override public function log(level : LogLevel, message : String) : void
		{
			assertNotNull('LogLevel should not be null', level);
			assertEquals('LogLevel should equal', _level, level);
			assertEquals('Message should equal', _message, message);
			
			_level = null;
			_message = "";
		}

		public function set message(value : String) : void { _message = value; }

		public function set level(value : LogLevel) : void { _level = value; }
	}
}
