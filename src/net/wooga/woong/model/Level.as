package net.wooga.woong.model
{
	/**
	 * ...
	 * @author 
	 */
	public class Level
	{
		private var _id : int;
		private var _xml : XML;

		public function Level( id : int, xml : XML )
		{
			_id = id;
			_xml = xml;
		}

		public function get id() : int
		{
			return _id;
		}

		public function get xml() : XML
		{
			return _xml;
		}
	}
}