package net.wooga.woong.event
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author
	 */
	public class StoneEvent extends Event
	{
		public static const CLICK : String = "stoneClick";
		static public const ROLL_OVER:String = "stoneRollOver";
		
		private var _index : uint;
		
		public function StoneEvent( type : String, index : uint )
		{
			super( type, true, cancelable );
			_index = index;
		}
		
		public override function clone() : Event
		{
			return new StoneEvent( type, _index );
		}
		
		public override function toString() : String
		{
			return formatToString( "StoneEvent", "type", "bubbles", "cancelable", "eventPhase" );
		}
		
		public function get index() : uint
		{
			return _index;
		}
	
	}

}