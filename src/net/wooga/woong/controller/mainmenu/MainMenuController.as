package net.wooga.woong.controller.mainmenu {
	import net.wooga.woong.message.view.ViewControl;
	import flash.utils.Dictionary;
	import net.wooga.woong.view.mainmenu.message.OpenMainMenuView;
	import net.wooga.woong.controller.AbstractController;

	/**
	 * @author mk
	 */
	public class MainMenuController extends AbstractController {
		private var _openedViews : Dictionary;
		
		[Init]
		public function init() : void
		{
			_openedViews = new Dictionary();
		}
		
		[MessageHandler]
		public function handleViewControl( message : OpenMainMenuView ) : void
		{
			var viewControlClass : Class;
			for ( var viewControl : Object in _openedViews )
			{
				viewControlClass = viewControl as Class;
				if ( _openedViews[ viewControl ] == ViewControl.OPEN )
					dispatch( new viewControlClass( ViewControl.CLOSE ) );
			}
			
			viewControlClass = message.viewControl as Class;
			dispatch( new viewControlClass( ViewControl.OPEN ) );
			_openedViews[ message.viewControl ] = message.action;
		}
	}
}
