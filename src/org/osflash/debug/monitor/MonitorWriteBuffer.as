package org.osflash.debug.monitor
{
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class MonitorWriteBuffer
	{
		
		/**
		 * @private
		 */
		private var _name : String; 
		
		/**
		 * @private
		 */
		private var _adapterFree : int;
		
		/**
		 * @private
		 */
		private var _adapterActive : int; 
		
		/**
		 * @private
		 */
		private var _adapterLength : int;
		
		/**
		 * @private
		 */
		private var _percentFree : Number;
		
		/**
		 * @private
		 */
		private var _percentActive : Number;
		
		public function MonitorWriteBuffer(	name : String, 
												adapterFree : int, 
												adapterActive : int, 
												adapterLength : int, 
												percentFree : Number, 
												percentActive : Number
												)
		{
			if(null == name) throw new ArgumentError('Name can not be null');
			
			if(isNaN(adapterFree)) throw new ArgumentError('Name can not be NaN');
			if(isNaN(adapterActive)) throw new ArgumentError('Name can not be NaN');
			if(isNaN(adapterLength)) throw new ArgumentError('Name can not be NaN');
			if(isNaN(percentFree)) throw new ArgumentError('Name can not be NaN');
			if(isNaN(percentActive)) throw new ArgumentError('Name can not be NaN');
			
			_name = name;
			
			_adapterFree = adapterFree;
			_adapterActive = adapterActive;
			_adapterLength = adapterLength;
			_percentFree = percentFree;
			_percentActive = percentActive;
		}
		
		public function get width() : int
		{
			var num : int = 0;
			
			num += name.length;
			
			num += String(adapterFree).length;
			num += String(adapterActive).length;
			num += String(adapterLength).length;
			
			num += String(percentFree).length;
			num += String(percentActive).length;
			
			return num;
		}

		public function get name() : String { return _name; }

		public function get adapterFree() : int { return _adapterFree; }

		public function get adapterActive() : int { return _adapterActive; }

		public function get adapterLength() : int { return _adapterLength; }

		public function get percentFree() : Number { return _percentFree; }

		public function get percentActive() : Number { return _percentActive; }
	}
}
