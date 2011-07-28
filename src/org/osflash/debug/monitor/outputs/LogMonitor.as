package org.osflash.debug.monitor.outputs
{
	import org.osflash.debug.monitor.BaseMonitor;
	import org.osflash.debug.monitor.MonitorWriteBuffer;
	import org.osflash.logger.ILog;
	import org.osflash.logger.logs.debug;
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class LogMonitor extends BaseMonitor
	{
		
		public static const HEADER_NAMES : Vector.<String> = new <String>[	'QName', 
																			'Amount', 
																			'Free (%)', 
																			'Active (%)'
																			];
		
		/**
		 * @private
		 */
		private var _log : ILog;
		
		/**
		 * @private
		 */
		private var _output : Function;
		
		/**
		 * @private
		 */
		private var _minHeaderWidths : Vector.<int>;
		
		/**
		 * @private
		 */
		private var _headerWidths : Vector.<int>;
		
		public function LogMonitor(log : ILog = null)
		{
			_log = log;
			
			_output = (null != log) ? _log.debug : debug;
			
			_minHeaderWidths = new Vector.<int>();
			_minHeaderWidths.push(HEADER_NAMES[0].length);
			_minHeaderWidths.push(HEADER_NAMES[1].length);
			_minHeaderWidths.push(HEADER_NAMES[2].length);
			_minHeaderWidths.push(HEADER_NAMES[3].length);
			
			_headerWidths = new Vector.<int>();
		}
		
		/**
		 * @inheritDoc
		 */	
		override protected function writeHeader(widths : Vector.<int>) : void
		{
			var message : String = '| ';
			
			var columnWidths : int = 0; 
			
			const total : int = HEADER_NAMES.length;
			for(var i : int = 0; i<total; i++)
			{
				var width : int = 0;
				switch(i)
				{
					case 0: width = widths[0]; break;
					case 1: width = widths[3]; break;
					case 2: width = widths[4]; break;
					case 3: width = widths[5]; break;
				}
				
				const headerWidth : int = HEADER_NAMES[i].length;
				const columnWidth : int = Math.max(width, headerWidth);
				const line : String = pad(HEADER_NAMES[i], columnWidth) + ' | ';
				
				columnWidths += line.length;
				
				_headerWidths[i] = line.length - 3;
				
				message += line;
			}
			
			_output(pad('', columnWidths + 1, '-'));		
			_output(message);
			_output(pad('', columnWidths + 1, '-'));
		}
		
		/**
		 * @inheritDoc
		 */	
		override protected function writeRow(buffer : MonitorWriteBuffer) : void
		{
			var message : String = '| ';
						
			const name : String = buffer.name;
			const nameLength : int = name.length;
			const columnWidth0 : int =  Math.max(nameLength, _headerWidths[0]) - nameLength;
			message += pad(name, columnWidth0) + ' | ';
			
			const length : String = String(buffer.adapterLength);
			const lengthLength : int = length.length;
			const columnWidth1 : int = Math.max(lengthLength, _headerWidths[1]) - lengthLength;
			message += pad(length, columnWidth1) + ' | ';
			
			const free : String = String(buffer.percentFree);
			const freeLength : int = free.length;
			const columnWidth2 : int = Math.max(freeLength, _headerWidths[2]) - freeLength;
			message += pad(free, columnWidth2) + ' | ';
			
			const active : String = String(buffer.percentActive);
			const activeLength : int = active.length;
			const columnWidth3 : int = Math.max(activeLength, _headerWidths[3]) - activeLength;
			message += pad(active, columnWidth3) + ' | ';
			
			_output(message);
		}
		
		
		/**
		 * @inheritDoc
		 */	
		override protected function writeFooter() : void
		{
			var columnWidths : int = 0;
			
			var index : int = _headerWidths.length;
			while(--index > -1)
			{
				columnWidths += _headerWidths[index] + 3;
			}
			_output(pad('', columnWidths + 1, '-'));
		}
		
		/**
		 * @private
		 */
		private function pad(name : String, num : int, value : String = ' ') : String
		{
			var padding : String = '';
			
			var index : int = num;
			while(--index > -1)
			{
				padding += value;
			}
			
			return name + padding;
		}
	}
}
