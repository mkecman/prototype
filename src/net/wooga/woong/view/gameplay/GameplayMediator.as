package net.wooga.woong.view.gameplay
{
	import net.wooga.woong.message.level.LevelLoaded;
	import net.wooga.woong.message.level.PlayLevel;
	import net.wooga.woong.message.view.ViewControl;
	import net.wooga.woong.view.AbstractMediator;
	import net.wooga.woong.view.mainmenu.message.OpenMainMenuView;

	/**
	 * ...
	 * @author
	 */
	public class GameplayMediator extends AbstractMediator
	{
		private var view : GameplayView;

		public override function handleOpenView( message : ViewControl ) : void
		{
			super.handleOpenView( message );
			view = _view as GameplayView;
		}

		public override function viewClass() : Class
		{
			return GameplayView;
		}

		[MessageHandler]
		public function handleLevelLoaded( message : LevelLoaded ) : void
		{
			view.loadLevel( message.xml );
		}

		[MessageHandler]
		public function handleLoadLevel( message : PlayLevel ) : void
		{
			view.loadLevel( message.xml );
		}
		
		internal function requestView( viewControl : Class, action : String ) : void
		{
			dispatch( new OpenMainMenuView( viewControl, action ) );
		}
	}
}