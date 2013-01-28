package net.wooga.woong.view.mainmenu.message
{
	/**
	 * @author mk
	 */
	public class OpenMainMenuView
	{
		private var _viewControl : Class;
		private var _action : String;

		public function OpenMainMenuView( viewControl : Class, action : String )
		{
			_viewControl = viewControl;
			_action = action;
		}

		public function get action() : String
		{
			return _action;
		}

		public function get viewControl() : Class
		{
			return _viewControl;
		}
	}
}
