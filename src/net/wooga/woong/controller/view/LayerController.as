package net.wooga.woong.controller.view
{
	import net.wooga.woong.constants.LayersNames;
	import net.wooga.woong.controller.AbstractController;
	import net.wooga.woong.core.ViewRoot;
	import net.wooga.woong.message.view.AddViewToLayer;
	import net.wooga.woong.message.view.InitializeViewLayers;

	import flash.display.Sprite;
	import flash.utils.Dictionary;

	/**
	 * @author mk
	 */
	public class LayerController extends AbstractController
	{
		[Inject]
		public var viewRoot : ViewRoot;
		private var layers : Dictionary;

		[Init]
		public function init() : void
		{
			layers = new Dictionary();
		}

		[MessageHandler]
		public function handleInitializeViewLayers( message : InitializeViewLayers ) : void
		{
			addLayer( LayersNames.BACKGROUND );
			addLayer( LayersNames.MAIN_MENU );
			addLayer( LayersNames.GAMEPLAY );
			addLayer( LayersNames.TOOLBAR );
		}

		[MessageHandler]
		public function handleAddViewToLayer( message : AddViewToLayer ) : void
		{
			var layer : Sprite = layers[ message.layerName ];
			var view : Sprite = message.view as Sprite;
			view.visible = false;
			layer.addChild( view );
		}

		private function addLayer( name : String ) : void
		{
			var layer : Sprite = new Sprite();
			layer.name = name;
			viewRoot.addChild( layer );
			layers[ name ] = layer;
		}
	}
}
