package net.wooga.woong.view.background 
{
	import net.wooga.woong.graphic.BackgroundGraphic;
	import net.wooga.woong.view.AbstractView;
	import net.wooga.woong.view.IMediator;
	
	/**
	 * ...
	 * @author 
	 */
	public class BackgroundView extends AbstractView 
	{
		private var _graphic:BackgroundGraphic;
		
		public function BackgroundView() 
		{
			super();
			
		}
		
		public override function setup( mediator : IMediator ) : void
		{
			_graphic = new BackgroundGraphic();
			addChild( _graphic );
		}
		
	}

}