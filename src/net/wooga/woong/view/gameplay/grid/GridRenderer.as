package net.wooga.woong.view.gameplay.grid
{
	import org.spicefactory.lib.logging.LogContext;
	import flash.display.Sprite;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.DropShadowFilter;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;

	import net.wooga.woong.constants.GridInfo;
	import net.wooga.woong.event.StoneEvent;
	import net.wooga.woong.model.StoneModel;

	/**
	 * ...
	 * @author
	 */
	public class GridRenderer extends Sprite
	{
		private var _stoneModel : StoneModel;
		private var _graphic : Sprite;
		private var _layers : Dictionary;
		private var _initialized : Boolean;

		public function setup( stoneModel : StoneModel ) : void
		{
			if ( !_initialized )
			{
				_initialized = true;

				_stoneModel = stoneModel;
				_graphic = new Sprite();
				addChild( _graphic );

				_layers = new Dictionary();

				addLayer( GridInfo.LAYER_ONE );
				addLayer( GridInfo.LAYER_TWO );
				addLayer( GridInfo.LAYER_THREE );
				addLayer( GridInfo.LAYER_FOUR );
			}
		}

		public function loadLevel( xml : XML ) : void
		{
			
			for each ( var stoneXML : XML in xml.stone )
			{
				addStone( stoneXML.@index, stoneXML.@type, stoneXML.@layerIndex, stoneXML.@xIndex, stoneXML.@yIndex );
				LogContext.getLogger(this).warn("added : " + stoneXML.@index );
			}
		}

		public function drawEditorStones( layerIndex : uint, maxPositions : Rectangle, alpha : Number ) : void
		{
			var index : uint;
			for ( var xIndex : uint = maxPositions.x; xIndex < maxPositions.width; xIndex++ )
			{
				for ( var yIndex : uint = maxPositions.y; yIndex < maxPositions.height; yIndex++ )
				{
					index = ( xIndex * GridInfo.WIDTH + yIndex ) + ( layerIndex * GridInfo.WIDTH * GridInfo.HEIGHT );
					addStone( index, 15, layerIndex, xIndex, yIndex, alpha );
				}
			}
		}

		public function removeStones() : void
		{
			for each ( var stone : Stone in _stoneModel._stoneIndexMap )
			{
				stone.enabled = false;
				stone.remove();
			}
		}

		private function addStone( index : uint, type : uint, layerIndex : uint, xIndex : uint, yIndex : uint, alpha : Number = 1 ) : void
		{
			var stone : Stone = _stoneModel._stoneIndexMap[ index ];
			if ( stone == null )
			{
				stone = new Stone();
				_layers[ stone.layerIndex ].addChild( stone );
				_stoneModel._stoneIndexMap[ index ] = stone;
				_stoneModel._stoneGridMap[ layerIndex ][ xIndex ][ yIndex ] = stone;
			}
			stone.setup( index, type, layerIndex, xIndex, yIndex );
			stone.x = stone.xIndex * GridInfo.STONE_WIDTH - stone.layerIndex * 5;
			stone.y = stone.yIndex * GridInfo.STONE_HEIGHT - stone.layerIndex * 5;
			stone.alpha = alpha;
			stone.enabled = true;
		}

		private function addLayer( layerIndex : uint ) : void
		{
			var index : uint;
			var layer : Sprite = new Sprite();
			_layers[ layerIndex ] = layer;
			_stoneModel._stoneGridMap[ layerIndex ] = new Dictionary();
			_graphic.addChild( layer );
			layer.mouseEnabled = false;

			for ( var xIndex : uint = 0; xIndex < GridInfo.WIDTH; xIndex++ )
			{
				_stoneModel._stoneGridMap[ layerIndex ][ xIndex ] = new Dictionary();
				for ( var yIndex : uint = 0; yIndex < GridInfo.HEIGHT; yIndex++ )
				{
					_stoneModel._stoneGridMap[ layerIndex ][ xIndex ][ yIndex ] = null;
					index = ( xIndex * GridInfo.WIDTH + yIndex ) + ( layerIndex * GridInfo.WIDTH * GridInfo.HEIGHT );
					addStone( index, 15, layerIndex, xIndex, yIndex );
				}
			}
			
			layer.filters = [ new DropShadowFilter( 5, 45, 0, 1, 16, 16, 1.5, BitmapFilterQuality.HIGH ) ];
		}
	}
}