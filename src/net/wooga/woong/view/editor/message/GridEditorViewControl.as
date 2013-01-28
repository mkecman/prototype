package net.wooga.woong.view.editor.message
{
	import net.wooga.woong.constants.LayersNames;
	import net.wooga.woong.message.view.ViewControl;
	import net.wooga.woong.view.editor.GridEditorMediator;

	/**
	 * @author mk
	 */
	public class GridEditorViewControl extends ViewControl
	{
		public function GridEditorViewControl( action : String )
		{
			super( action, LayersNames.GAMEPLAY, GridEditorMediator );
		}
	}
}
