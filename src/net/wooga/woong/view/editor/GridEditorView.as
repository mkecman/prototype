package net.wooga.woong.view.editor
{
	import net.wooga.woong.constants.GridInfo;
	import net.wooga.woong.event.StoneEvent;
	import net.wooga.woong.event.WoongEvent;
	import net.wooga.woong.model.StoneModel;
	import net.wooga.woong.view.AbstractView;
	import net.wooga.woong.view.gameplay.GameplayMediator;
	import net.wooga.woong.view.gameplay.grid.GridRenderer;
	import net.wooga.woong.view.IMediator;
	import net.wooga.woong.view.gameplay.grid.MatcherHelper;
	import net.wooga.woong.view.gameplay.grid.Stone;

	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.system.System;
	import flash.text.TextField;
	import flash.utils.Dictionary;

	/**
	 * ...
	 * @author
	 */
	public class GridEditorView extends AbstractView
	{
		private var _stoneModel : StoneModel;
		private var _graphic : Sprite;
		private var _stoneCount : uint;
		private var _toolbar : Toolbar;
		private var mediator : GridEditorMediator;
		private var _gridRenderer : GridRenderer;

		override public function setup( mediator : IMediator ) : void
		{
			super.setup( mediator );
			this.mediator = mediator as GridEditorMediator;

			_graphic = new Sprite();
			addChild( _graphic );

			_gridRenderer = new GridRenderer();
			_gridRenderer.addEventListener( StoneEvent.CLICK, onStoneClick );
			_gridRenderer.addEventListener( StoneEvent.ROLL_OVER, onStoneRollOver );
			_graphic.addChild( _gridRenderer );

			_stoneModel = new StoneModel();
			_gridRenderer.setup( _stoneModel );

			_stoneCount = 0;
			drawStones( GridInfo.LAYER_ONE, new Rectangle( 0, 0, GridInfo.WIDTH, GridInfo.HEIGHT ), 0.1 );
			drawStones( GridInfo.LAYER_TWO, new Rectangle( 0, 0, GridInfo.WIDTH, GridInfo.HEIGHT ), 0 );
			drawStones( GridInfo.LAYER_THREE, new Rectangle( 0, 0, GridInfo.WIDTH, GridInfo.HEIGHT ), 0 );
			drawStones( GridInfo.LAYER_FOUR, new Rectangle( 0, 0, GridInfo.WIDTH, GridInfo.HEIGHT ), 0 );

			_toolbar = new Toolbar();
			_toolbar.x = GridInfo.WIDTH * GridInfo.STONE_WIDTH + 100;
			_graphic.addChild( _toolbar );
			_toolbar.addEventListener( WoongEvent.EXPORT, handleExport );
			_toolbar.addEventListener( WoongEvent.OPEN, handleOpen );
		}

		public function set stoneModel( modelInstance : StoneModel ) : void
		{
			_stoneModel = modelInstance;
			_gridRenderer.setup( _stoneModel );
		}

		public function loadLevel( xml : XML ) : void
		{
			_gridRenderer.removeStones();
			drawStones( GridInfo.LAYER_ONE, new Rectangle( 0, 0, GridInfo.WIDTH, GridInfo.HEIGHT ), 0.1 );
			drawStones( GridInfo.LAYER_TWO, new Rectangle( 0, 0, GridInfo.WIDTH, GridInfo.HEIGHT ), 0 );
			drawStones( GridInfo.LAYER_THREE, new Rectangle( 0, 0, GridInfo.WIDTH, GridInfo.HEIGHT ), 0 );
			drawStones( GridInfo.LAYER_FOUR, new Rectangle( 0, 0, GridInfo.WIDTH, GridInfo.HEIGHT ), 0 );

			var stone : Stone = new Stone();
			for each ( var stoneXML : XML in xml.stone )
			{
				stone.setup( stoneXML.@index, stoneXML.@type, stoneXML.@layerIndex, stoneXML.@xIndex, stoneXML.@yIndex );
				_toolbar.selectedStone = stone;
				onStoneClick( new StoneEvent( StoneEvent.CLICK, stoneXML.@index ) );
			}
		}

		private function drawStones( layerIndex : uint, maxPositions : Rectangle, alpha : Number ) : void
		{
			_gridRenderer.drawEditorStones( layerIndex, maxPositions, alpha );

			for each ( var stone : Stone in _stoneModel._stoneIndexMap )
			{
				if ( stone.layerIndex == GridInfo.LAYER_ONE )
					setStoneListeners( stone, true );
				else
					stone.enabled = false;
			}
		}

		private function setStoneListeners( stone : Stone, active : Boolean ) : void
		{
			if ( active )
			{
				stone.addEventListener( StoneEvent.CLICK, onStoneClick );
				stone.addEventListener( StoneEvent.ROLL_OVER, onStoneRollOver );
			}
			else
			{
				stone.removeEventListener( StoneEvent.CLICK, onStoneClick );
				stone.removeEventListener( StoneEvent.ROLL_OVER, onStoneRollOver );
			}
		}

		private function onStoneClick( e : StoneEvent ) : void
		{
			var clickedStone : Stone = _stoneModel._stoneIndexMap[ e.index ];

			if ( _toolbar.selectedStone.type == GridInfo.TYPE_PLACEHOLDER )
			{
				if ( clickedStone.layerIndex > GridInfo.LAYER_ONE )
					if ( clickedStone.layerIndex == GridInfo.LAYER_FOUR && clickedStone.type != GridInfo.TYPE_PLACEHOLDER )
					{
						clickedStone.setup( clickedStone.index, 15, clickedStone.layerIndex, clickedStone.xIndex, clickedStone.yIndex );
						clickedStone.alpha = 0;
					}
					else
					{
						setStoneListeners( clickedStone, false );
						clickedStone.enabled = false;
						clickedStone.alpha = 0;

						var stoneBelow : Stone = _stoneModel._stoneGridMap[ clickedStone.layerIndex - 1 ][ clickedStone.xIndex ][ clickedStone.yIndex ];
						stoneBelow.setup( stoneBelow.index, 15, stoneBelow.layerIndex, stoneBelow.xIndex, stoneBelow.yIndex );
						if ( stoneBelow.layerIndex == GridInfo.LAYER_ONE )
							stoneBelow.alpha = 0.1;
						else
							stoneBelow.alpha = 0;
						setStoneListeners( stoneBelow, true );
					}
			}
			else
			{
				clickedStone.setup( e.index, _toolbar.selectedStone.type, clickedStone.layerIndex, clickedStone.xIndex, clickedStone.yIndex );
				clickedStone.alpha = 1;
				if ( clickedStone.layerIndex < GridInfo.LAYER_FOUR )
					setStoneListeners( clickedStone, false );

				if ( clickedStone.layerIndex < GridInfo.LAYER_FOUR )
				{
					var stoneAbove : Stone = _stoneModel._stoneGridMap[ clickedStone.layerIndex + 1 ][ clickedStone.xIndex ][ clickedStone.yIndex ];
					stoneAbove.enabled = true;
					setStoneListeners( stoneAbove, true );
				}
			}
		}

		private function handleExport( e : WoongEvent ) : void
		{
			System.setClipboard( updateGameplay() );
		}

		private function handleOpen( e : WoongEvent ) : void
		{
			updateGameplay();
		}

		private function updateGameplay() : String
		{
			var xml : String = "<level>\n";
			for ( var index : int = 0; index <= GridInfo.LAYER_FOUR; index++ )
			{
				// xml += "<layer>";

				for ( var xIndex : int = 0; xIndex < GridInfo.WIDTH; xIndex++ )
				{
					for ( var yIndex : int = 0; yIndex < GridInfo.HEIGHT; yIndex++ )
					{
						var stone : Stone = _stoneModel._stoneGridMap[ index ][ xIndex ][ yIndex ];
						if ( stone.type != GridInfo.TYPE_PLACEHOLDER )
						{
							xml += '\t<stone index="' + stone.index + '" layerIndex="' + stone.layerIndex + '" type="' + stone.type + '" xIndex="' + stone.xIndex + '" yIndex="' + stone.yIndex + '" />\n';
						}
					}
				}

				// xml += "</layer>";
			}
			xml += "</level>";

			mediator.playLevel( new XML( xml ) );

			return xml;
		}

		private function onStoneRollOver( e : StoneEvent ) : void
		{
			_stoneModel._stoneIndexMap[ e.index ].setOverlay();
		}
	}
}