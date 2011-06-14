package org.osflash.logger.utils
{
	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public class InfoFunctionTest
	{
		
		[Test]
		public function test_info_output_utility() : void
		{
			info('I', 'am', 'a', 'info', 'utility');
		}
	}
}
