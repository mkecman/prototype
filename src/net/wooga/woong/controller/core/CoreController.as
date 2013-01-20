package net.wooga.woong.controller.core
{
	import net.wooga.woong.controller.AbstractController;
	import net.wooga.woong.message.core.InitializeCore;
	import net.wooga.woong.message.view.InitializeView;
	import net.wooga.woong.message.view.ViewControl;
	import net.wooga.woong.view.background.message.BackgroundViewControl;
	import net.wooga.woong.view.editor.message.GridEditorViewControl;
	import net.wooga.woong.view.gameplay.message.GameplayViewControl;
	import net.wooga.woong.view.levelmenu.message.LevelMenuViewControl;
	import net.wooga.woong.view.mainmenu.message.MainMenuViewControl;
	import net.wooga.woong.view.mainmenu.message.OpenMainMenuView;
	
	public class CoreController extends AbstractController
	{
		
		
		[MessageHandler]
		public function handleInitializeCore( message : InitializeCore ) : void
		{
			dispatch( new InitializeView() );
			
			dispatch( new BackgroundViewControl( ViewControl.OPEN ) );
			dispatch( new MainMenuViewControl( ViewControl.OPEN ) );
			dispatch( new OpenMainMenuView( GameplayViewControl, ViewControl.OPEN ) );
			dispatch( new OpenMainMenuView( GridEditorViewControl, ViewControl.OPEN ) );
			//dispatch( new OpenMainMenuView( LevelMenuViewControl, ViewControl.OPEN ) );
		}
		
	}

}