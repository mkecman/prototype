package net.wooga.woong.view.editor
{
	import net.wooga.woong.message.level.LevelLoaded;
	import net.wooga.woong.message.level.PlayLevel;
	import net.wooga.woong.message.view.ViewControl;
	import net.wooga.woong.model.StoneModel;
	import net.wooga.woong.view.AbstractMediator;

	/**
	 * ...
	 * @author
	 */
	public class GridEditorMediator extends AbstractMediator
	{
		private var view : GridEditorView;

		override public function viewClass() : Class
		{
			return GridEditorView;
		}

		public override function handleOpenView( message : ViewControl ) : void
		{
			super.handleOpenView( message );
			view = _view as GridEditorView;
		}

		[MessageHandler]
		public function handleLoadLevel( message : LevelLoaded ) : void
		{
			view.loadLevel( message.xml );
		}

		internal function playLevel( xml : XML ) : void
		{
			dispatch( new PlayLevel( xml ) );
		}
	}
}