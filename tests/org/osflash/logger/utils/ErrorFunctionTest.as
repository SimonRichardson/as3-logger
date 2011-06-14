package org.osflash.logger.utils
{
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
