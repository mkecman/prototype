package net.wooga.woong.view.levelmenu.message
{
	import net.wooga.woong.constants.LayersNames;
	import net.wooga.woong.message.view.ViewControl;
	import net.wooga.woong.view.levelmenu.LevelMenuMediator;

	/**
	 * ...
	 * @author
	 */
	public class LevelMenuViewControl extends ViewControl
	{
		public function LevelMenuViewControl( action : String, layer : String = null, mediatorClass : Class = null )
		{
			super( action, LayersNames.MAIN_MENU, LevelMenuMediator );
		}
	}
}