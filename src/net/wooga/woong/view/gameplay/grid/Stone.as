package net.wooga.woong.view.gameplay.grid
{
	import net.wooga.woong.graphic.FacePlaceholder;

	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	import net.wooga.woong.constants.GridInfo;
	import net.wooga.woong.event.StoneEvent;
	import net.wooga.woong.graphic.FaceCircleBlue;
	import net.wooga.woong.graphic.FaceCircleGreen;
	import net.wooga.woong.graphic.FaceCirclePurple;
	import net.wooga.woong.graphic.FaceCircleRed;
	import net.wooga.woong.graphic.FaceCircleYellow;
	import net.wooga.woong.graphic.FaceSquareBlue;
	import net.wooga.woong.graphic.FaceSquareGreen;
	import net.wooga.woong.graphic.FaceSquarePurple;
	import net.wooga.woong.graphic.FaceSquareRed;
	import net.wooga.woong.graphic.FaceSquareYellow;
	import net.wooga.woong.graphic.FaceTriangleBlue;
	import net.wooga.woong.graphic.FaceTriangleGreen;
	import net.wooga.woong.graphic.FaceTrianglePurple;
	import net.wooga.woong.graphic.FaceTriangleRed;
	import net.wooga.woong.graphic.FaceTriangleYellow;
	import net.wooga.woong.graphic.StoneFace;
	import net.wooga.woong.graphic.StoneGraphic;
	import net.wooga.woong.graphic.StoneHighlight;
	import net.wooga.woong.graphic.StoneNotMatch;
	import net.wooga.woong.graphic.StoneOverlay;

	import org.spicefactory.lib.logging.LogContext;

	/**
	 * @author mk
	 */
	public class Stone extends Sprite
	{
		private var _graphic : StoneGraphic;
		private var _highlight : StoneHighlight;
		private var _overlay : StoneOverlay;
		private var _notMatch : StoneNotMatch;
		private var _index : uint;
		private var _type : uint;
		private var _layerIndex : uint;
		private var _xIndex : uint;
		private var _yIndex : uint;
		private var _errorTimer : Timer;
		private var _stoneFace : StoneFace;

		public function Stone()
		{
			_graphic = new StoneGraphic();

			_highlight = new StoneHighlight();
			_highlight.visible = false;

			_overlay = new StoneOverlay();
			_overlay.alpha = 0.5;
			_overlay.visible = false;

			_notMatch = new StoneNotMatch();
			_notMatch.visible = false;

			addChild( _graphic );
			addChild( _overlay );
			addChild( _highlight );
			addChild( _notMatch );

			addEventListener( MouseEvent.CLICK, onClick );
			addEventListener( MouseEvent.ROLL_OVER, onRollOver );
			addEventListener( MouseEvent.ROLL_OUT, onRollOut );

			_errorTimer = new Timer( 1000, 1 );
			_errorTimer.addEventListener( TimerEvent.TIMER, onErrorTimerTick );
		}

		public function setup( index : uint, type : uint, layerIndex : uint, xIndex : uint, yIndex : uint ) : void
		{
			removeStoneFace();

			_stoneFace = new StoneFace();
			var faceGraphic : Sprite;

			_index = index;
			_type = type;
			_layerIndex = layerIndex;
			_xIndex = xIndex;
			_yIndex = yIndex;

			faceGraphic = getTypeGraphic();
			faceGraphic.x = _stoneFace.faceMask.width / 2 - faceGraphic.width / 2;
			faceGraphic.y = _stoneFace.faceMask.height / 2 - faceGraphic.height / 2;

			_stoneFace.addChild( faceGraphic );
			_stoneFace.setChildIndex( faceGraphic, _stoneFace.numChildren - 1 );
			faceGraphic.mask = _stoneFace.faceMask;
			addChild( _stoneFace );
			visible = true;
		}

		public function remove() : void
		{
			visible = false;
			_highlight.visible = false;
			_notMatch.visible = false;
			removeStoneFace();
		}

		public function showNotMatch() : void
		{
			_highlight.visible = false;

			_notMatch.visible = true;
			_errorTimer.reset();
			_errorTimer.start();
		}

		public function setHighlight( value : Boolean ) : void
		{
			_highlight.visible = value;
		}

		public function setOverlay() : void
		{
			_overlay.visible = true;
			useHandCursor = true;
			buttonMode = true;
		}

		public function get type() : uint
		{
			return _type;
		}

		public function get xIndex() : uint
		{
			return _xIndex;
		}

		public function get yIndex() : uint
		{
			return _yIndex;
		}

		public function get layerIndex() : uint
		{
			return _layerIndex;
		}

		public override function set alpha( value : Number ) : void
		{
			if ( _graphic )
			{
				_graphic.alpha = value;
			}
		}

		public function get index() : uint
		{
			return _index;
		}

		public function set enabled( value : Boolean ) : void
		{
			mouseChildren = value;
			mouseEnabled = value;
			buttonMode = value;
		}
		
		public function get enabled() : Boolean
		{
			return mouseChildren && mouseEnabled && buttonMode;
		}

		private function onClick( e : MouseEvent ) : void
		{
			if ( buttonMode )
			{
				if ( _type != GridInfo.TYPE_PLACEHOLDER )
					setHighlight( !_highlight.visible );
				dispatchEvent( new StoneEvent( StoneEvent.CLICK, _index ) );
			}
		}

		private function onRollOver( e : MouseEvent ) : void
		{
			dispatchEvent( new StoneEvent( StoneEvent.ROLL_OVER, _index ) );
		}

		private function onRollOut( e : MouseEvent ) : void
		{
			_overlay.visible = false;
		}

		private function onErrorTimerTick( e : TimerEvent ) : void
		{
			_notMatch.visible = false;
		}

		private function removeStoneFace() : void
		{
			if ( _stoneFace && contains( _stoneFace ) )
				removeChild( _stoneFace );
		}

		public function getTypeGraphic() : Sprite
		{
			var result : Sprite;
			switch ( _type )
			{
				case GridInfo.TYPE_SQUARE_PURPLE:
					result = new FaceSquarePurple();
					break;
				case GridInfo.TYPE_SQUARE_RED:
					result = new FaceSquareRed();
					break;
				case GridInfo.TYPE_SQUARE_GREEN:
					result = new FaceSquareGreen();
					break;
				case GridInfo.TYPE_SQUARE_YELLOW:
					result = new FaceSquareYellow();
					break;
				case GridInfo.TYPE_SQUARE_BLUE:
					result = new FaceSquareBlue();
					break;
				case GridInfo.TYPE_CIRCLE_PURPLE:
					result = new FaceCirclePurple();
					break;
				case GridInfo.TYPE_CIRCLE_RED:
					result = new FaceCircleRed();
					break;
				case GridInfo.TYPE_CIRCLE_GREEN:
					result = new FaceCircleGreen();
					break;
				case GridInfo.TYPE_CIRCLE_YELLOW:
					result = new FaceCircleYellow();
					break;
				case GridInfo.TYPE_CIRCLE_BLUE:
					result = new FaceCircleBlue();
					break;
				case GridInfo.TYPE_TRIANGLE_PURPLE:
					result = new FaceTrianglePurple();
					break;
				case GridInfo.TYPE_TRIANGLE_RED:
					result = new FaceTriangleRed();
					break;
				case GridInfo.TYPE_TRIANGLE_GREEN:
					result = new FaceTriangleGreen();
					break;
				case GridInfo.TYPE_TRIANGLE_YELLOW:
					result = new FaceTriangleYellow();
					break;
				case GridInfo.TYPE_TRIANGLE_BLUE:
					result = new FaceTriangleBlue();
					break;
				case GridInfo.TYPE_PLACEHOLDER:
					result = new FacePlaceholder();
					break;
			}

			return result;
		}
	}
}
