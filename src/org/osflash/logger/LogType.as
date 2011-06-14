package org.osflash.logger
{
	/**
	 * @author Simon Richardson - me@simonrichardson.info
	 */
	public class LogType
	{
		
		/**
		 * Default log type constant
		 * @return LogType with default name.
		 */
		public static const DEFAULT : LogType = new LogType('DEFAULT');
		
		/**
		 * @private
		 */
		private var _name : String;
		
		/**
		 * Create a new LogType with a give name
		 */
		public function LogType(name : String)
		{
			_name = name;
		}
		
		/**
		 * Get the name of the current log type.
		 * 
		 * @return String
		 */
		public function get name() : String
		{
			return _name;
		}
	}
}
