package net.wooga.woong.message.view
{
	/**
	 * ...
	 * @author
	 */
	public class ViewControl
	{
		public static const OPEN : String = "open";
		public static const CLOSE : String = "close";
		private var _action : String;
		private var _layer : String;
		private var _mediatorClass : Class;

		public function ViewControl( action : String, layer : String = null, mediatorClass : Class = null )
		{
			_action = action;
			_layer = layer;
			_mediatorClass = mediatorClass;
		}

		[Selector]
		public function get action() : String
		{
			return _action;
		}

		public function get layer() : String
		{
			return _layer;
		}

		public function get mediatorClass() : Class
		{
			return _mediatorClass;
		}
	}
}