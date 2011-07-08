package org.osflash.logger
{
	import org.osflash.logger.support.mocks.MockLogFactory;
	import org.osflash.logger.support.mocks.MockLogOutput;
	import org.osflash.logger.utils.getTracer;
	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public class LogTest
	{
		
		private var _log : ILog;
		
		private var _output : MockLogOutput;
		
		[Before]
		public function setUp() : void
		{
			const factory : ILogFactory = new MockLogFactory();
			_log = factory.create(MockLogFactory.DEFAULT);
			_output = _log.stream.getAt(0) as MockLogOutput;
			
			getTracer().start();
		}
		
		[After]
		public function tearDown() : void
		{
			_log = null;
		}
		
		[Test]
		public function test_logger_exists() : void
		{
			_output.level = LogLevel.DEBUG;
			_output.message = 'HELLO WORLD';
			
			_log.debug('HELLO', 'WORLD');
		}
		
		[Test]
		public function test_multiline_sos() : void
		{
			_output.level = LogLevel.DEBUG;
			_output.message = 'hello world\nthis is a funky message';
			
			_log.debug('hello world\nthis is a funky message');
		}
	}
}
