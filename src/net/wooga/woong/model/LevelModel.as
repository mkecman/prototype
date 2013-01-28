package net.wooga.woong.model
{
	/**
	 * ...
	 * @author 
	 */
	public class LevelModel
	{
		public var levels : Vector.<Level>;
		public var currentLevel : Level;

		public function LevelModel()
		{
			levels = new Vector.<Level>();
		}

		public function addLevel( id : int, xml : XML ) : void
		{
			levels.push( new Level( id, xml ) );
		}

		public function getLevel( id : int ) : Level
		{
			var result : Level;
			var index : int;
			var length : int = levels.length;
			for ( index = 0; index < length; index++ )
			{
				if ( id == levels[ index ].id )
				{
					result = levels[ index ];
					break;
				}
			}

			currentLevel = result;
			return result;
		}
	}
}