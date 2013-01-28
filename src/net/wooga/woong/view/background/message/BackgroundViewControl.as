package net.wooga.woong.view.background.message
{
	import net.wooga.woong.constants.LayersNames;
	import net.wooga.woong.message.view.ViewControl;
	import net.wooga.woong.view.background.BackgroundMediator;

	/**
	 * ...
	 * @author 
	 */
	public class BackgroundViewControl extends ViewControl
	{
		public function BackgroundViewControl( action : String )
		{
			super( action, LayersNames.BACKGROUND, BackgroundMediator );
		}
	}
}