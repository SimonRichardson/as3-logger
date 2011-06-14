package org.osflash.logger.utils
{
	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public class DebugFunctionTest
	{
		[Test]
		public function test_debug_output_utility() : void
		{
			debug('I', 'am', 'a', 'debug', 'utility');
		}
	}
}
