package org.osflash.debug.monitor
{
	import org.osflash.debug.monitor.adapters.IMonitorAdapter;
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;

	import flash.events.TimerEvent;
	import flash.utils.Timer;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class BaseMonitor implements IMonitor
	{
		
		public static const DEFAULT_DELAY : int = 1000;
		
		/**
		 * @private
		 */
		private var _timer : Timer;
			
		/**
		 * @private
		 */
		private var _adapters : Vector.<IMonitorAdapter>;
		
		/**
		 * @inheritDoc
		 */
		private var _sweepSignal : ISignal;
		
		/**
		 * @inheritDoc
		 */
		private var _writeSignal : ISignal;
		
		public function BaseMonitor()
		{
			_adapters = new Vector.<IMonitorAdapter>();
			
			_timer = new Timer(DEFAULT_DELAY);
			_timer.addEventListener(TimerEvent.TIMER, handleTimerEvent);
		}
		
		/**
		 * @inheritDoc
		 */
		public function add(adapter : IMonitorAdapter) : IMonitorAdapter
		{
			if(null == adapter) throw new ArgumentError('Adapter can not be null');
			
			if(_adapters.indexOf(adapter) == -1) _adapters.push(adapter);
			
			if(!_timer.running) start();
				
			return adapter;
		}
		
		/**
		 * @inheritDoc
		 */
		public function remove(adapter : IMonitorAdapter) : IMonitorAdapter
		{
			if(null == adapter) throw new ArgumentError('Adapter can not be null');
			
			const index : int = _adapters.indexOf(adapter);
			if(index >= 0) _adapters.splice(index, 1);
			
			if(!_timer.running && _adapters.length > 0) start();
			
			return adapter;
		}
		
		/**
		 * @inheritDoc
		 */
		public function start() : void
		{
			_timer.reset();
			_timer.start();
		}
		
		/**
		 * @inheritDoc
		 */
		public function stop() : void
		{
			_timer.stop();
		}
		
		/**
		 * @private
		 */
		protected function writeHeader(widths : Vector.<int>) : void
		{
			throw new Error('Abstract method error');
		}
		
		/**
		 * @private
		 */
		protected function writeRow(buffer : MonitorWriteBuffer) : void
		{
			throw new Error('Abstract method error');
		}
		
		/**
		 * @private
		 */
		protected function writeFooter() : void
		{
			throw new Error('Abstract method error');
		}
		
		/**
		 * @private
		 */
		private function handleTimerEvent(event : TimerEvent) : void
		{
			sweepSignal.dispatch();
			
			const buffers : Vector.<MonitorWriteBuffer> = new Vector.<MonitorWriteBuffer>();
			const widths : Vector.<int> = new Vector.<int>(6, true);
			
			widths[0] = 0;
			widths[1] = 0;
			widths[2] = 0;
			widths[3] = 0;
			widths[4] = 0;
			widths[5] = 0;
			
			var index : int = _adapters.length;
			while(--index > -1)
			{
				const adapter : IMonitorAdapter = _adapters[index];
				
				const adapterFree : int = adapter.free;
				const adapterActive : int = adapter.active;
				const adapterLength : int = adapter.length;
				
				const percentFree : Number = adapterFree / adapterLength * 100;
				const percentActive : Number = adapterActive / adapterLength * 100;
				
				const buffer : MonitorWriteBuffer = new MonitorWriteBuffer(	adapter.name, 
																			adapterFree, 
																			adapterActive, 
																			adapterLength, 
																			percentFree, 
																			percentActive
																			);
				buffers.push(buffer);
				
				widths[0] = Math.max(widths[0], stringWidth(adapter.name));
				widths[1] = Math.max(widths[1], intWidth(adapterFree));
				widths[2] = Math.max(widths[2], intWidth(adapterActive));
				widths[3] = Math.max(widths[3], intWidth(adapterLength));
				widths[4] = Math.max(widths[4], numberWidth(percentFree));
				widths[5] = Math.max(widths[5], numberWidth(percentActive));
			}
			
			writeSignal.dispatch();
			
			writeHeader(widths);
			
			index = buffers.length;
			while(--index > -1)
			{
				writeRow(buffers[index]);
			}
			
			writeFooter();
		}
		
		/**
		 * @private
		 */
		private function stringWidth(value : String) : int
		{
			return value.length;
		}
		
		/**
		 * @private
		 */
		private function intWidth(value : int) : int
		{
			return String(value).length;
		}
		
		/**
		 * @private
		 */
		private function numberWidth(value : int) : int
		{
			return String(value).length;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get length() : int { return _adapters.length; }
		
		/**
		 * @inheritDoc
		 */
		public function get sweepSignal() : ISignal
		{
			if(null == _sweepSignal) _sweepSignal = new Signal();
			return _sweepSignal;
		}
		
		
		/**
		 * @inheritDoc
		 */
		public function get writeSignal() : ISignal
		{
			if(null == _writeSignal) _writeSignal = new Signal();
			return _writeSignal;
		}
	}
}
