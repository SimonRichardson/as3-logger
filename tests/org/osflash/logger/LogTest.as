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
			_log = factory.create(LogFactory.SOS);
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
		
		[Test]
		public function test_multiline_sos() : void
		{
			_log.debug('hello world\nthis is a funky message');
		}
	}
}
