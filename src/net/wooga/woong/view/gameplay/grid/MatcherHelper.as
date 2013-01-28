package net.wooga.woong.view.gameplay.grid
{
	/**
	 * ...
	 * @author
	 */
	public class MatcherHelper
	{
		public static const NOT_FOUND : String = "notFound";
		public static const FIRST_SET : String = "firstSet";
		public static const FOUND : String = "found";
		private var _firstStoneType : int = -1;
		private var _secondStoneType : int = -1;
		private var _firstStoneIndex : int = -1;
		private var _secondStoneIndex : int = -1;
		private var _matchStatus : String = NOT_FOUND;

		public function setStone( stoneIndex : uint, stoneType : uint ) : void
		{
			if ( _firstStoneType == -1 )
			{
				_firstStoneType = stoneType;
				_firstStoneIndex = stoneIndex;
				_matchStatus = FIRST_SET;
			}
			else
			{
				_secondStoneType = stoneType;
				_secondStoneIndex = stoneIndex;
				if ( _firstStoneIndex != _secondStoneIndex )
				{
					if ( _firstStoneType == _secondStoneType )
						_matchStatus = FOUND;
					else
						reset();
				}
			}
		}

		public function reset() : void
		{
			_matchStatus = NOT_FOUND;
			_firstStoneType = -1;
			_secondStoneType = -1;
		}

		public function get matchStatus() : String
		{
			return _matchStatus;
		}
	}
}