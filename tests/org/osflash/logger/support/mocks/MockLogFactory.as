package org.osflash.logger.support.mocks
{
	import asunit.asserts.fail;

	import org.osflash.logger.ILog;
	import org.osflash.logger.ILogFactory;
	import org.osflash.logger.ILogOutputStream;
	import org.osflash.logger.Log;
	import org.osflash.logger.streams.DefaultOutputStream;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class MockLogFactory implements ILogFactory
	{

		public static const DEFAULT : int = 0;

		public function create(type : int, buffered : Boolean = false) : ILog
		{
			if(type == DEFAULT)
			{
				const stream : ILogOutputStream = new DefaultOutputStream();
				stream.add(new MockLogOutput());
				return new Log(stream);
			} else fail('Unknown type ' + type);
			
			return null;
		}
	}
}
