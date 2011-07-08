package org.osflash.logger.utils
{
	import org.osflash.logger.logs.warn;
	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public class WarnFunctionTest
	{
		
		[Test]
		public function test_warn_output_utility() : void
		{
			warn('I', 'am', 'a', 'warn', 'utility');
		}
	}
}
