package net.wooga.woong.view.gameplay
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	import net.wooga.woong.constants.GridInfo;
	import net.wooga.woong.event.StoneEvent;
	import net.wooga.woong.graphic.StartButton;
	import net.wooga.woong.model.StoneModel;
	import net.wooga.woong.view.AbstractView;
	import net.wooga.woong.view.gameplay.grid.GridRenderer;
	import net.wooga.woong.view.gameplay.grid.MatcherHelper;
	import net.wooga.woong.view.gameplay.grid.Stone;
	import net.wooga.woong.view.IMediator;
	import org.spicefactory.lib.logging.LogContext;
	
	/**
	 * ...
	 * @author
	 */
	public class GameplayView extends AbstractView
	{
		private var _stoneModel : StoneModel;
		private var _graphic : Sprite;
		private var _matchHelper : MatcherHelper;
		
		private var _firstStoneIndex : int = -1;
		private var _secondStoneIndex : int = -1;
		private var _foundMatches : uint;
		private var foundLabel:TextField;
		private var timeLabel:TextField;
		private var _startButton:StartButton;
		private var _roundTimer:Timer;
		private var _gridRenderer:GridRenderer;
		
		override public function setup( mediator : IMediator ) : void
		{
			super.setup( mediator );
			
			_graphic = new Sprite();
			addChild( _graphic );
			
			_matchHelper = new MatcherHelper();
			_gridRenderer = new GridRenderer();
			_gridRenderer.addEventListener( StoneEvent.CLICK, onStoneClick );
			_gridRenderer.addEventListener( StoneEvent.ROLL_OVER, onStoneRollOver );
			_graphic.addChild( _gridRenderer );
			
			foundLabel = new TextField();
			addChild( foundLabel );
			foundLabel.htmlText = "FOUND : 0";
			foundLabel.y = 20;
			foundLabel.height = foundLabel.textHeight + 5;
			
			timeLabel = new TextField();
			addChild( timeLabel );
			timeLabel.x = GridInfo.WIDTH * GridInfo.STONE_WIDTH - 50;
			timeLabel.y = 20;
			timeLabel.htmlText = "TIME : 0";
			timeLabel.height = timeLabel.textHeight + 5;
			
			_startButton = new StartButton();
			_startButton.addEventListener( MouseEvent.CLICK, onStartClick );
			addChild( _startButton );
			
			_roundTimer = new Timer( 1000 );
			_roundTimer.addEventListener( TimerEvent.TIMER, onRoundTimerTick );
		}
		
		public function set stoneModel( modelInstance : StoneModel ) : void
		{
			_stoneModel = modelInstance;
			_gridRenderer.setup( _stoneModel );
		}
		
		public function loadLevel( xml : XML ) : void
		{
			resetRound();
			_gridRenderer.removeStones();
			_gridRenderer.loadLevel( xml );
			
			prepareStartButton();
		}
		
		private function onStoneClick( e : StoneEvent ) : void
		{
			if ( _firstStoneIndex == e.index )
			{
				_firstStoneIndex = -1;
				_matchHelper.reset();
			}
			else
			{
				if ( _firstStoneIndex == -1 )
					_firstStoneIndex = e.index;
				else
					_secondStoneIndex = e.index;
				
				_matchHelper.setStone( e.index, _stoneModel._stoneIndexMap[ e.index ].type );
				switch ( _matchHelper.matchStatus )
				{
					case MatcherHelper.NOT_FOUND:
						handleMatchNotFound();
						break;
					case MatcherHelper.FIRST_SET:
						handleMatchFirstSet();
						break;
					case MatcherHelper.FOUND:
						handleMatchFound();
						break;
				}
			}
		}
		
		private function handleMatchNotFound():void
		{
			_stoneModel._stoneIndexMap[ _firstStoneIndex ].showNotMatch();
			_stoneModel._stoneIndexMap[ _secondStoneIndex ].showNotMatch();
			
			resetSelectedStones();
		}
		
		private function handleMatchFirstSet():void
		{
			
		}
		
		private function handleMatchFound():void
		{
			_foundMatches++;
			foundLabel.htmlText = "FOUND : " + _foundMatches;
			
			removeStone( _firstStoneIndex );
			removeStone( _secondStoneIndex );
			
			resetSelectedStones();
			_matchHelper.reset();
			
			LogContext.getLogger( this ).warn( "found : " + _foundMatches );
		}
		
		private function resetRound() : void
		{
			_foundMatches = 0;
			foundLabel.htmlText = "FOUND : " + _foundMatches;
			
			resetSelectedStones();
			_matchHelper.reset();
		}
		
		private function removeStone( stoneIndex : uint ) : void
		{
			var stone : Stone = _stoneModel._stoneIndexMap[ stoneIndex ];
			stone.enabled = false;
			stone.remove();
			_stoneModel._stoneGridMap[ stone.layerIndex ][ stone.xIndex ][ stone.yIndex ] = null;
		}
		
		private function resetSelectedStones():void
		{
			_firstStoneIndex = -1;
			_secondStoneIndex = -1;
		}
		
		private function onStoneRollOver(e:StoneEvent):void
		{
			if ( isStoneFree( e.index ) )
			{
				_stoneModel._stoneIndexMap[ e.index ].setOverlay();
			}
		}
		
		private function isStoneFree(index:uint):Boolean
		{
			var result : Boolean = true;
			var stone : Stone = _stoneModel._stoneIndexMap[ index ];
			if (
					( _stoneModel._stoneGridMap[ stone.layerIndex ][ stone.xIndex - 1 ] && _stoneModel._stoneGridMap[ stone.layerIndex ][ stone.xIndex - 1 ][ stone.yIndex ] )
					&&
					( _stoneModel._stoneGridMap[ stone.layerIndex ][ stone.xIndex + 1 ] && _stoneModel._stoneGridMap[ stone.layerIndex ][ stone.xIndex + 1 ][ stone.yIndex ] )
				)
			{
				result = false;
			}
			
			return result;
		}
		
		private function prepareStartButton():void
		{
			_startButton.visible = true;
		}
		
		private function onStartClick(e:MouseEvent):void
		{
			_startButton.visible = false;
			_roundTimer.reset();
			_roundTimer.start();
		}
		
		private function onRoundTimerTick(e:TimerEvent):void
		{
			timeLabel.text = "TIME: " + _roundTimer.currentCount;
		}
	}

}