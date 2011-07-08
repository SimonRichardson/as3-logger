package org.osflash.logger.utils
{
	import org.osflash.logger.logs.fatal;
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
