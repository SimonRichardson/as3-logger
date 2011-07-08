package org.osflash.logger.utils
{
	import org.osflash.logger.logs.info;

	import flash.trace.Trace;
	import flash.utils.getTimer;

	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public class Tracer
	{
		
		private static const CLEAN_REGEXP : RegExp = /[^a-zA-Z0-9_,.@:\/\?\[\]\(\)\-\$]/g;

		/**
		 * @private
		 */
		private var _running : Boolean;

		public function Tracer()
		{
			_running = false;

			Trace.setLevel(Trace.METHODS_AND_LINES_WITH_ARGS, Trace.LISTENER);
		}

		public function start() : void
		{
			if (!_running) Trace.setListener(handleTrace);
		}

		public function stop() : void
		{
			if (_running) Trace.setListener(null);
		}
		
		/**
		 * @private
		 */
		private function handleTrace(	classPath : String, 
										line : int, 
										method : String, 
										args : String
										) : void
		{
			const methodParts : Array = method.split("/");
			
			const qname : String = methodParts[0];
			const qnameParts : Array = qname.split("::");
			
			const className : String = qnameParts[qnameParts.length - 1];
			
			const methodName : String = '' + methodParts[1];
			
			info(	getTimer(), 
					method.replace(CLEAN_REGEXP, '.'), 	
					'\n\tQualified name:', qname.replace(CLEAN_REGEXP, ''),
					'\n\tClass name:', className.replace(CLEAN_REGEXP, ''),
					'\n\tMethod name:', methodName.replace(CLEAN_REGEXP, ''),
					'\n\tLine number:', line,
					'\n\tArguments:', args.replace(CLEAN_REGEXP, '')
					);
			
			// Ignore these for now
			classPath;
		}
	}
}
