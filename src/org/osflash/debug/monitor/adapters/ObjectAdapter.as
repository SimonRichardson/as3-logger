package org.osflash.debug.monitor.adapters
{
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class ObjectAdapter extends BaseMonitorAdapter
	{
		
		/**
		 * @private
		 */
		private var _object : Object;
		
		public function ObjectAdapter(object : Object)
		{
			super(object);
			
			if(null == object) throw new ArgumentError('Object can not be null');
			_object = object;
		}

		/**
		 * @inheritDoc
		 */
		override public function get length() : int 
		{ 
			var num : int = 0;
			for each(var item : Object in _object)
			{
				num++;
				
				item;
			}
			return num;
		}

		/**
		 * @inheritDoc
		 */
		override public function get active() : int { return length; }

		/**
		 * @inheritDoc
		 */
		override public function get free() : int { return 0; }
	}
}
