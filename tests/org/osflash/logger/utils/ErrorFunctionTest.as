package org.osflash.logger.utils
{
	import org.osflash.logger.logs.error;
	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public class ErrorFunctionTest
	{
		[Test]
		public function test_error_output_utility() : void
		{
			error('I', 'am', 'a', 'error', 'utility');
		}
	}
}
