package org.osflash.debug.monitor
{
	import org.osflash.debug.monitor.adapters.IMonitorAdapter;
	import org.osflash.debug.monitor.adapters.SignalAdapter;
	import org.osflash.debug.monitor.adapters.VectorIntAdapter;
	import org.osflash.debug.monitor.adapters.VectorObjectAdapter;
	import org.osflash.debug.monitor.outputs.LogMonitor;

	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class VectorIntTest extends Sprite
	{
		
		private var _vector0 : Vector.<int>;
		
		private var _vector1 : Vector.<Object>;
		
		private var _count1 : int;

		public function VectorIntTest()
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			_count1 = 0;
						
			_vector0 = new Vector.<int>();
			_vector1 = new Vector.<Object>(1024, true);
			
			const monitor : IMonitor = new LogMonitor();
			
			const adapter0 : IMonitorAdapter = new VectorIntAdapter(_vector0);
			const adapter1 : IMonitorAdapter = new VectorObjectAdapter(_vector1);
			const adapter2 : IMonitorAdapter = new SignalAdapter(monitor.sweepSignal);
			
			monitor.sweepSignal.add(handleSweepSignal);
			monitor.add(adapter0);
			monitor.add(adapter1);
			monitor.add(adapter2);	
			monitor.start();
		}
		
		private function handleSweepSignal() : void
		{
			var index : int = 50;
			while(--index > -1)
			{
				_vector0.push(int(Math.random()  * 100));
				
				_vector1[_count1 % 1024] = int(Math.random() * 100);
				
				_count1++;
			}
		}

	}
}
