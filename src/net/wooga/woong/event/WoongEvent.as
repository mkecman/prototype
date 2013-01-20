package net.wooga.woong.event
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author
	 */
	public class WoongEvent extends Event
	{
		public static const EXPORT : String = "woongExport";
		public static const OPEN : String = "woongOpen";
		
		public function WoongEvent( type : String )
		{
			super( type, bubbles, cancelable );
		}
		
	
	}

}