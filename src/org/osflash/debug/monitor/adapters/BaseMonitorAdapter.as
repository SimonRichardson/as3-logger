package org.osflash.debug.monitor.adapters
{
	import flash.utils.getQualifiedClassName;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class BaseMonitorAdapter implements IMonitorAdapter
	{
		
		/**
		 * @private
		 */
		private var _qname : String;
		
		/**
		 * @private
		 */
		private var _observed : *;

		public function BaseMonitorAdapter(observed : *)
		{
			_observed = observed;
			
			_qname = getQualifiedClassName(observed);
		}

		/**
		 * @inheritDoc
		 */
		public function get name() : String { return _qname; }

		/**
		 * @inheritDoc
		 */
		public function get length() : int
		{
			throw new Error('Abstract method error');
		}

		/**
		 * @inheritDoc
		 */
		public function get active() : int
		{
			throw new Error('Abstract method error');
		}

		/**
		 * @inheritDoc
		 */
		public function get free() : int
		{
			throw new Error('Abstract method error');
		}
	}
}
