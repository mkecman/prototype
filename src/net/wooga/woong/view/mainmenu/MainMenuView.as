package net.wooga.woong.view.mainmenu
{
	import net.wooga.woong.graphic.MainMenuGraphic;
	import net.wooga.woong.message.view.ViewControl;
	import net.wooga.woong.view.AbstractView;
	import net.wooga.woong.view.IMediator;
	import net.wooga.woong.view.editor.message.GridEditorViewControl;
	import net.wooga.woong.view.gameplay.message.GameplayViewControl;
	import net.wooga.woong.view.levelmenu.message.LevelMenuViewControl;

	import flash.events.MouseEvent;

	/**
	 * ...
	 * @author 
	 */
	public class MainMenuView extends AbstractView
	{
		private var _graphic : MainMenuGraphic;
		private var _mediator : MainMenuMediator;

		override public function setup( mediator : IMediator ) : void
		{
			super.setup( mediator );
			_mediator = mediator as MainMenuMediator;

			_graphic = new MainMenuGraphic();
			addChild( _graphic );

			_graphic.gameplayButton.addEventListener( MouseEvent.CLICK, onGameplayClick );
			_graphic.editorButton.addEventListener( MouseEvent.CLICK, onEditorClick );
			_graphic.levelsButton.addEventListener( MouseEvent.CLICK, onLevelsClick );
		}

		private function onEditorClick( event : MouseEvent ) : void
		{
			_mediator.requestView( GridEditorViewControl, ViewControl.OPEN );
		}

		private function onGameplayClick( event : MouseEvent ) : void
		{
			_mediator.requestView( GameplayViewControl, ViewControl.OPEN );
		}

		private function onLevelsClick( e : MouseEvent ) : void
		{
			_mediator.requestView( LevelMenuViewControl, ViewControl.OPEN );
		}
	}
}