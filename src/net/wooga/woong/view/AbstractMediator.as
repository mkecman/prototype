package net.wooga.woong.view
{
	import net.wooga.woong.message.view.AddViewToLayer;
	import net.wooga.woong.message.view.ViewControl;

	/**
	 * ...
	 * @author 
	 */
	public class AbstractMediator implements IMediator
	{
		[MessageDispatcher]
		public var dispatch : Function;
		protected var _view : IView;

		public function viewClass() : Class
		{
			return null;
		}

		public function handleOpenView( message : ViewControl ) : void
		{
			if ( _view == null )
				setupView( message.layer );
			_view.open();
		}

		public function handleCloseView( message : ViewControl ) : void
		{
			if ( _view && _view.isOpen )
				_view.close();
		}

		private function setupView( layerName : String ) : void
		{
			var viewClassObject : Class = viewClass();
			_view = new viewClassObject() as IView;
			_view.setup( this );
			dispatch( new AddViewToLayer( _view, layerName ) );
		}
	}
}