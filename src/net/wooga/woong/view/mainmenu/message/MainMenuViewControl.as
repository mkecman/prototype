package net.wooga.woong.view.mainmenu.message {
	import net.wooga.woong.view.mainmenu.MainMenuMediator;
	import net.wooga.woong.constants.LayersNames;
	import net.wooga.woong.message.view.ViewControl;

	/**
	 * @author mk
	 */
	public class MainMenuViewControl extends ViewControl {
		public function MainMenuViewControl(action : String) {
			super(action, LayersNames.TOOLBAR, MainMenuMediator);
		}
	}
}
