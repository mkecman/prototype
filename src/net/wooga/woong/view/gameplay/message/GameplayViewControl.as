package net.wooga.woong.view.gameplay.message {
	import net.wooga.woong.constants.LayersNames;
	import net.wooga.woong.message.view.ViewControl;
	import net.wooga.woong.view.gameplay.GameplayMediator;

	/**
	 * @author mk
	 */
	public class GameplayViewControl extends ViewControl {
		public function GameplayViewControl(action : String ) {
			super(action, LayersNames.GAMEPLAY, GameplayMediator);
		}
	}
}
