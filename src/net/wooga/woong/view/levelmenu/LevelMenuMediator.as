package net.wooga.woong.view.levelmenu 
{
	import net.wooga.woong.message.level.LoadLevel;
	import net.wooga.woong.view.AbstractMediator;
	
	/**
	 * ...
	 * @author 
	 */
	public class LevelMenuMediator extends AbstractMediator 
	{
		
		public function LevelMenuMediator() 
		{
			
		}
		
		public override function viewClass() : Class
		{
			return LevelMenuView;
		}
		
		internal function loadLevel( id : int ) : void
		{
			dispatch( new LoadLevel( id ) );
		}
		
	}

}