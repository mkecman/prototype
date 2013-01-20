package net.wooga.woong.message.level
{
	/**
	 * ...
	 * @author
	 */
	public class LevelLoaded
	{
		
		private var _xml : XML;
		
		public function LevelLoaded( xml : XML )
		{
			_xml = xml;
		}
		
		public function get xml():XML
		{
			return _xml;
		}
		
	}

}