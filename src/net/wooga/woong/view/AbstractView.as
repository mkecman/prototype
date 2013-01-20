package net.wooga.woong.view
{
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author
	 */
	public class AbstractView extends Sprite implements IView
	{
		private var _mediator : IMediator;
		private var _isOpen : Boolean;
		
		public function AbstractView()
		{
			super();
		}

		public function open() : void {
			_isOpen = true;
			visible = true;
		}

		public function close() : void {
			_isOpen = false;
			visible = false;
		}

		public function get isOpen() : Boolean {
			return _isOpen;
		}

		public function setup(mediator : IMediator) : void {
			_mediator = mediator;
		}
		
	}

}