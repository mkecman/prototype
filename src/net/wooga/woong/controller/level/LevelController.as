package net.wooga.woong.controller.level
{
	import net.wooga.woong.constants.RemoteCallNames;
	import net.wooga.woong.controller.AbstractController;
	import net.wooga.woong.message.level.LevelLoaded;
	import net.wooga.woong.message.level.LoadLevel;
	import net.wooga.woong.message.service.RemoteCall;
	import net.wooga.woong.message.view.ViewControl;
	import net.wooga.woong.model.Level;
	import net.wooga.woong.model.LevelModel;
	import net.wooga.woong.view.editor.message.GridEditorViewControl;
	import net.wooga.woong.view.mainmenu.message.OpenMainMenuView;

	/**
	 * ...
	 * @author
	 */
	public class LevelController extends AbstractController
	{
		[Inject]
		public var levelModel : LevelModel;
		private var _requestedLevelId : int;

		public function LevelController()
		{
		}

		[MessageHandler]
		public function handleLoadLevel( message : LoadLevel ) : void
		{
			var level : Level = levelModel.getLevel( message.id );
			if ( level )
			{
				dispatch( new LevelLoaded( level.xml ) );
				dispatch( new OpenMainMenuView( GridEditorViewControl, ViewControl.OPEN ) );
			}
			else
			{
				_requestedLevelId = message.id;
				dispatch( new RemoteCall( RemoteCallNames.LOAD_LEVEL, onLoadLevelComplete, onLoadLevelFault, message.id ) );
			}
		}

		private function onLoadLevelComplete( result : Object ) : void
		{
			levelModel.addLevel( _requestedLevelId, new XML( result ) );
			handleLoadLevel( new LoadLevel( _requestedLevelId ) );
		}

		private function onLoadLevelFault() : void
		{
		}
	}
}