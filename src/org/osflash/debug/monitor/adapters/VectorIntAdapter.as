package org.osflash.debug.monitor.adapters
{
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class VectorIntAdapter extends BaseMonitorAdapter
	{
		
		/**
		 * @private
		 */
		private var _vector : Vector.<int>;
		
		public function VectorIntAdapter(vector : Vector.<int>)
		{
			super(vector);
			
			if(null == vector) throw new ArgumentError('Vector can not be null');
			_vector = vector;
		}

		/**
		 * @inheritDoc
		 */
		override public function get length() : int { return _vector.length; }

		/**
		 * @inheritDoc
		 */
		override public function get active() : int 
		{ 
			if(_vector.fixed) return _vector.length - free;
			else return _vector.length;
		}

		/**
		 * @inheritDoc
		 */
		override public function get free() : int 
		{ 
			if(_vector.fixed)
			{
				var num : int = 0;
				var index : int = _vector.length;
				while(--index > -1)
				{
					if(isNaN(_vector[index])) num++;
					else break;
				}
				
				return num;
			}
			else return 0; 
		}
	}
}
