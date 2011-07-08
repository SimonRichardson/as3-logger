package org.osflash.logger.utils
{
	import org.osflash.logger.logs.info;
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
