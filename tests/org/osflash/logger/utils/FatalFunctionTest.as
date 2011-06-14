package org.osflash.logger.utils
{
	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public class FatalFunctionTest
	{
		[Test]
		public function test_fatal_output_utility() : void
		{
			fatal('I', 'am', 'a', 'fatal', 'utility');
		}
	}
}
