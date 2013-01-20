package net.wooga.woong.view.levelmenu
{
	import flash.events.MouseEvent;
	import net.wooga.woong.graphic.LevelMenuGraphic;
	import net.wooga.woong.view.AbstractView;
	import net.wooga.woong.view.IMediator;
	
	/**
	 * ...
	 * @author
	 */
	public class LevelMenuView extends AbstractView
	{
		private var mediator : LevelMenuMediator;
		private var _graphic : LevelMenuGraphic;
		
		public override function setup( mediator : IMediator ) : void
		{
			this.mediator = mediator as LevelMenuMediator;
			
			_graphic = new LevelMenuGraphic();
			addChild( _graphic );
			
			for ( var index : uint = 1; index <= 12; index++ )
			{
				_graphic[ "level" + index ].addEventListener( MouseEvent.CLICK, onLevelClick );
			}
		}
		
		private function onLevelClick( e : MouseEvent ) : void
		{
			mediator.loadLevel( e.currentTarget.name.substr( 5 ) );
		}
	}

}