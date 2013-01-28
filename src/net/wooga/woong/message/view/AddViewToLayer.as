package net.wooga.woong.message.view
{
	import net.wooga.woong.view.IView;

	/**
	 * @author mk
	 */
	public class AddViewToLayer
	{
		private var _view : IView;
		private var _layerName : String;

		public function AddViewToLayer( view : IView, layerName : String )
		{
			_view = view;
			_layerName = layerName;
		}

		public function get view() : IView
		{
			return _view;
		}

		public function get layerName() : String
		{
			return _layerName;
		}
	}
}
