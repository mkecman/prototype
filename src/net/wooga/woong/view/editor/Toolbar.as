package net.wooga.woong.view.editor
{
	import net.wooga.woong.constants.GridInfo;
	import net.wooga.woong.event.StoneEvent;
	import net.wooga.woong.event.WoongEvent;
	import net.wooga.woong.graphic.ButtonExport;
	import net.wooga.woong.graphic.ButtonOpenInGameplay;
	import net.wooga.woong.view.gameplay.grid.Stone;

	import flash.display.Sprite;
	import flash.events.MouseEvent;

	/**
	 * ...
	 * @author
	 */
	public class Toolbar extends Sprite
	{
		private var _selectedStone : Stone;

		public function Toolbar()
		{
			drawButtons();
			drawExport();

			_selectedStone = getChildAt( 0 ) as Stone;
			_selectedStone.setHighlight( true );
		}

		private function drawButtons() : void
		{
			for ( var index : int = 0; index <= GridInfo.TYPE_PLACEHOLDER; index++ )
			{
				var stone : Stone = new Stone();
				stone.setup( index, index, 0, 0, 0 );
				stone.x = Math.floor( index / 5 ) * GridInfo.STONE_WIDTH;
				stone.y = Math.floor( index % 5 ) * GridInfo.STONE_HEIGHT;
				addChild( stone );
				stone.addEventListener( StoneEvent.CLICK, onStoneClick );
				stone.enabled = true;
			}
		}

		private function drawExport() : void
		{
			var button : ButtonExport = new ButtonExport();
			button.addEventListener( MouseEvent.CLICK, handleExportClick );
			addChild( button );
			button.y = 7 * GridInfo.STONE_HEIGHT;

			var buttonOpen : ButtonOpenInGameplay = new ButtonOpenInGameplay();
			buttonOpen.addEventListener( MouseEvent.CLICK, handleOpenClick );
			addChild( buttonOpen );
			buttonOpen.y = 8 * GridInfo.STONE_HEIGHT;
		}

		private function onStoneClick( e : StoneEvent ) : void
		{
			selectedStone.setHighlight( false );
			for ( var index : int = 0; index <= GridInfo.TYPE_PLACEHOLDER; index++ )
			{
				var stone : Stone = getChildAt( index ) as Stone;
				if ( stone.type == e.index )
				{
					stone.setHighlight( true );
					_selectedStone = stone;
				}
			}
		}

		private function handleExportClick( e : MouseEvent ) : void
		{
			dispatchEvent( new WoongEvent( WoongEvent.EXPORT ) );
		}

		private function handleOpenClick( e : MouseEvent ) : void
		{
			dispatchEvent( new WoongEvent( WoongEvent.OPEN ) );
		}

		public function get selectedStone() : Stone
		{
			return _selectedStone;
		}

		public function set selectedStone( value : Stone ) : void
		{
			_selectedStone = value;
		}
	}
}