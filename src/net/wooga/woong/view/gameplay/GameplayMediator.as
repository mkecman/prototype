package net.wooga.woong.view.gameplay {
	import net.wooga.woong.message.level.LevelLoaded;
	import net.wooga.woong.message.level.PlayLevel;
	import net.wooga.woong.message.view.ViewControl;
	import net.wooga.woong.model.StoneModel;
	import net.wooga.woong.view.AbstractMediator;
	
	/**
	 * ...
	 * @author
	 */
	public class GameplayMediator extends AbstractMediator
	{
		[Inject]
		public var stoneModel : StoneModel;
		
		private var view : GameplayView;
		
		public override function handleOpenView(message : ViewControl) : void
		{
			super.handleOpenView( message );
			view = _view as GameplayView;
			view.stoneModel = stoneModel;
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
	
	}

}