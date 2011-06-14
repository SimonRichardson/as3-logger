package org.osflash.logger
{
	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public class LogTest
	{
		
		private var _log : ILog;
		
		[Before]
		public function setUp() : void
		{
			const factory : ILogFactory = new LogFactory();
			_log = factory.create(LogFactory.DEFAULT);
		}
		
		[After]
		public function tearDown() : void
		{
			_log = null;
		}
		
		[Test]
		public function test_logger_exists() : void
		{
			_log.debug('HELLO', 'WORLD');
		}
	}
}
