package org.osflash.logger.utils
{
	/**
	 * @author Simon Richardson - simon@ustwo.co.uk
	 */
	public function getTracer() : Tracer
	{
		return _tracer; 
	}
}

import org.osflash.logger.utils.Tracer;

const _tracer : Tracer = new Tracer();
