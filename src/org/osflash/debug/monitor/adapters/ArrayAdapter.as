package org.osflash.debug.monitor.adapters
{
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ArrayAdapter extends BaseMonitorAdapter
	{
		
		/**
		 * @private
		 */
		private var _array : Array;
		
		public function ArrayAdapter(array : Array)
		{
			super(array);
			
			if(null == array) throw new ArgumentError('Array can not be null');
			_array = array;
		}

		/**
		 * @inheritDoc
		 */
		override public function get length() : int { return _array.length; }

		/**
		 * @inheritDoc
		 */
		override public function get active() : int { return _array.length; }

		/**
		 * @inheritDoc
		 */
		override public function get free() : int { return 0; }
	}
}
