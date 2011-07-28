package org.osflash.debug.monitor.adapters
{
	import org.osflash.signals.ISignal;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class SignalAdapter extends BaseMonitorAdapter
	{
		
		/**
		 * @private
		 */
		private var _signal : ISignal;
		
		public function SignalAdapter(signal : ISignal)
		{
			super(signal);
			
			if(null == signal) throw new ArgumentError('Signal can not be null');
			_signal = signal;
		}

		/**
		 * @inheritDoc
		 */
		override public function get length() : int { return _signal.numListeners; }

		/**
		 * @inheritDoc
		 */
		override public function get active() : int { return _signal.numListeners; }

		/**
		 * @inheritDoc
		 */
		override public function get free() : int { return 0; }
	}
}
