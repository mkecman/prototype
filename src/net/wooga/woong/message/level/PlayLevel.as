package net.wooga.woong.message.level
{
	/**
	 * ...
	 * @author 
	 */
	public class PlayLevel
	{
		private var _xml : XML;

		public function PlayLevel( xml : XML )
		{
			_xml = xml;
		}

		public function get xml() : XML
		{
			return _xml;
		}
	}
}