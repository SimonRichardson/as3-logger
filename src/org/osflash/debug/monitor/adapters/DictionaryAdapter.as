package org.osflash.debug.monitor.adapters
{
	import flash.utils.Dictionary;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class DictionaryAdapter extends BaseMonitorAdapter
	{
		
		/**
		 * @private
		 */
		private var _dictionary : Dictionary;
		
		public function DictionaryAdapter(dictionary : Dictionary)
		{
			super(dictionary);
			
			if(null == dictionary) throw new ArgumentError('Dictionary can not be null');
			_dictionary = dictionary;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function get length() : int 
		{ 
			var num : int = 0;
			for each(var item : Object in _dictionary)
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
