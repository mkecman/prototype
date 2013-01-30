package net.wooga.woong.view.gameplay
{
	import net.wooga.woong.graphic.GameplayGraphic;
	import net.wooga.woong.message.view.ViewControl;
	import net.wooga.woong.view.levelmenu.message.LevelMenuViewControl;
	import net.wooga.woong.graphic.EndRoundGraphic;
	import flash.display.StageQuality;
	import flash.geom.Rectangle;
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
		private const TIME : int = 60;
		private var _stoneModel : StoneModel;
		private var _graphic : GameplayGraphic;
		private var _matchHelper : MatcherHelper;
		private var _firstStoneIndex : int = -1;
		private var _secondStoneIndex : int = -1;
		private var _foundMatches : uint;
		private var foundLabel : TextField;
		private var timeLabel : TextField;
		private var _startButton : StartButton;
		private var _roundTimer : Timer;
		private var _gridRenderer : GridRenderer;
		private var _endRoundGraphic : EndRoundGraphic;
		private var _mediator : GameplayMediator;
		private var _currentXML : XML;

		override public function setup( mediator : IMediator ) : void
		{
			super.setup( mediator );
			_mediator = mediator as GameplayMediator;

			_graphic = new GameplayGraphic();
			addChild( _graphic );

			_matchHelper = new MatcherHelper();
			_gridRenderer = new GridRenderer();
			_gridRenderer.addEventListener( StoneEvent.CLICK, onStoneClick );
			_gridRenderer.addEventListener( StoneEvent.ROLL_OVER, onStoneRollOver );
			_graphic.addChild( _gridRenderer );
			_gridRenderer.x = 60;
			_gridRenderer.y = 130;
			
			_stoneModel = new StoneModel();
			_gridRenderer.setup( _stoneModel );
			
			foundLabel = _graphic.score;
			addChild( foundLabel );
			foundLabel.htmlText = "SCORE:";

			timeLabel = _graphic.time;
			addChild( timeLabel );
			timeLabel.htmlText = TIME.toString();
			_graphic.timeBar.gotoAndStop(1);

			_startButton = new StartButton();
			_startButton.addEventListener( MouseEvent.CLICK, onStartClick );
			addChild( _startButton );
			
			_endRoundGraphic = new EndRoundGraphic();
			_endRoundGraphic.againButton.addEventListener( MouseEvent.CLICK, onAgainClick );
			_endRoundGraphic.againButton.buttonMode = true;
			_endRoundGraphic.againButton.useHandCursor = true;
			_endRoundGraphic.nextButton.addEventListener( MouseEvent.CLICK, onEndRoundClick );
			_endRoundGraphic.nextButton.buttonMode = true;
			_endRoundGraphic.nextButton.useHandCursor = true;
			addChild( _endRoundGraphic );
			_endRoundGraphic.visible = false;

			_roundTimer = new Timer( 1000 );
			_roundTimer.addEventListener( TimerEvent.TIMER, onRoundTimerTick );
		}

		public function loadLevel( xml : XML ) : void
		{
			_currentXML = xml;
			stage.quality = StageQuality.MEDIUM;
			_endRoundGraphic.visible = false;
			resetRound();
			_gridRenderer.removeStones();
			_gridRenderer.loadLevel( xml );

			reenableStones();

			prepareStartButton();
			stage.quality = StageQuality.BEST;
		}

		private function reenableStones() : void
		{
			for each ( var stone : Stone in _stoneModel._stoneIndexMap )
			{
				stone.enabled = isStoneFree( stone.index );
			}
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
			
			checkValidMoves();
		}

		private function checkValidMoves() : void
		{
			var matchesFound : uint = 0;
			for each ( var currentStone : Stone in _stoneModel._stoneIndexMap )
			{
				if ( currentStone.enabled && currentStone.visible && isStoneFree( currentStone.index ) )
				{
					for each ( var stone : Stone in _stoneModel._stoneIndexMap )
					{
						if ( stone != currentStone && stone.enabled && stone.visible && isStoneFree( stone.index ) )
						{
							if ( stone.type == currentStone.type )
								matchesFound++;
						}
					}
				}
			}
			
			if ( matchesFound == 0 )
				endRound( "NO MORE VALID MOVES!" );
		}

		private function handleMatchNotFound() : void
		{
			_stoneModel._stoneIndexMap[ _firstStoneIndex ].showNotMatch();
			_stoneModel._stoneIndexMap[ _secondStoneIndex ].showNotMatch();

			resetSelectedStones();
		}

		private function handleMatchFirstSet() : void
		{
		}

		private function handleMatchFound() : void
		{
			_foundMatches++;
			foundLabel.htmlText = "SCORE:" + _foundMatches;

			removeStone( _firstStoneIndex );
			removeStone( _secondStoneIndex );

			resetSelectedStones();
			_matchHelper.reset();
			
			reenableStones();

			LogContext.getLogger( this ).warn( "found : " + _foundMatches );
		}

		private function resetRound() : void
		{
			_foundMatches = 0;
			foundLabel.htmlText = "SCORE:" + _foundMatches;
			timeLabel.htmlText = TIME.toString();
			_graphic.timeBar.gotoAndStop( TIME );

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

		private function resetSelectedStones() : void
		{
			_firstStoneIndex = -1;
			_secondStoneIndex = -1;
		}
		
		private function endRound( type : String ) : void
		{
			_roundTimer.stop();
			_endRoundGraphic.description.htmlText = type;
			_endRoundGraphic.visible = true;
		}
		
		private function onEndRoundClick( event : MouseEvent ) : void
		{
			_mediator.requestView( LevelMenuViewControl, ViewControl.OPEN );
			
			_endRoundGraphic.visible = false;
			timeLabel.text = TIME.toString();
		}
		
		private function onAgainClick( event : MouseEvent ) : void
		{
			loadLevel( _currentXML );
		}
		
		
		

		private function onStoneRollOver( e : StoneEvent ) : void
		{
			if ( isStoneFree( e.index ) )
			{
				_stoneModel._stoneIndexMap[ e.index ].setOverlay();
			}
		}

		private function isStoneFree( index : uint ) : Boolean
		{
			var freeLeft : Boolean = true;
			var freeRight : Boolean = true;
			var xColumn : Dictionary;
			var nextStone : Stone;
			var stone : Stone = _stoneModel._stoneIndexMap[ index ];
			
			if ( stone.layerIndex < GridInfo.LAYER_FOUR )
			{
				nextStone = _stoneModel._stoneGridMap[ stone.layerIndex + 1 ][ stone.xIndex ][ stone.yIndex ];
				if ( nextStone && nextStone.visible )
					return false;
			}
			
			xColumn = _stoneModel._stoneGridMap[ stone.layerIndex ][ stone.xIndex - 1 ];
			if ( xColumn )
			{
				nextStone = xColumn[ stone.yIndex ];
				if ( nextStone && nextStone.visible )
					freeLeft = false;
			}
			xColumn = _stoneModel._stoneGridMap[ stone.layerIndex ][ stone.xIndex + 1 ];
			if ( xColumn )
			{
				nextStone = xColumn[ stone.yIndex ];
				if ( nextStone && nextStone.visible )
					freeRight = false;
			}
			
			return freeLeft || freeRight;
		}

		private function prepareStartButton() : void
		{
			_startButton.visible = true;
		}

		private function onStartClick( e : MouseEvent ) : void
		{
			_startButton.visible = false;
			_roundTimer.reset();
			_roundTimer.start();
		}

		private function onRoundTimerTick( e : TimerEvent ) : void
		{
			var remainingTime : int = TIME - _roundTimer.currentCount;
			timeLabel.text = remainingTime.toString();
			_graphic.timeBar.gotoAndStop( remainingTime );
			
			if ( _roundTimer.currentCount == TIME )
			{
				endRound( "Time's Up!" );
			}
		}
	}
}