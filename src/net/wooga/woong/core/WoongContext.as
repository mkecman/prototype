package net.wooga.woong.core
{
	import net.wooga.woong.controller.core.CoreController;
	import net.wooga.woong.controller.level.LevelController;
	import net.wooga.woong.controller.mainmenu.MainMenuController;
	import net.wooga.woong.controller.service.ServiceController;
	import net.wooga.woong.controller.view.LayerController;
	import net.wooga.woong.controller.view.ViewController;
	import net.wooga.woong.model.LevelModel;
	import net.wooga.woong.model.StoneModel;
	import net.wooga.woong.view.background.BackgroundMediator;
	import net.wooga.woong.view.editor.GridEditorMediator;
	import net.wooga.woong.view.gameplay.GameplayMediator;
	import net.wooga.woong.view.levelmenu.LevelMenuMediator;
	import net.wooga.woong.view.mainmenu.MainMenuMediator;

	public class WoongContext
	{
		public var levelModel : LevelModel = new LevelModel();
		public var stoneModel : StoneModel = new StoneModel();
		public var coreController : CoreController = new CoreController();
		public var viewController : ViewController = new ViewController();
		public var layerController : LayerController = new LayerController();
		public var mainMenuController : MainMenuController = new MainMenuController();
		public var levelController : LevelController = new LevelController();
		public var serviceController : ServiceController = new ServiceController();
		public var gameplayMediator : GameplayMediator = new GameplayMediator();
		public var gridEditorMediator : GridEditorMediator = new GridEditorMediator();
		public var levelMediator : LevelMenuMediator = new LevelMenuMediator();
		public var backgroundMediator : BackgroundMediator = new BackgroundMediator();
		public var mainMenuMediator : MainMenuMediator = new MainMenuMediator();
	}
}