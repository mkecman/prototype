package net.wooga.woong.view.background
{
	import net.wooga.woong.view.AbstractMediator;
	
	/**
	 * ...
	 * @author
	 */
	public class BackgroundMediator extends AbstractMediator
	{
		
		public function BackgroundMediator()
		{
			
		}
		
		public override function viewClass() : Class
		{
			return BackgroundView;
		}
		
	}

}