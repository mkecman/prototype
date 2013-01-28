package net.wooga.woong.view.mainmenu
{
	import net.wooga.woong.view.AbstractMediator;
	import net.wooga.woong.view.mainmenu.message.OpenMainMenuView;

	/**
	 * @author mk
	 */
	public class MainMenuMediator extends AbstractMediator
	{
		override public function viewClass() : Class
		{
			return MainMenuView;
		}

		internal function requestView( viewControl : Class, action : String ) : void
		{
			dispatch( new OpenMainMenuView( viewControl, action ) );
		}
	}
}
