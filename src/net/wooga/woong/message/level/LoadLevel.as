package net.wooga.woong.message.level
{
	/**
	 * @author mk
	 */
	public class LoadLevel
	{
		private var _id : int;

		public function LoadLevel( id : int )
		{
			_id = id;
		}

		public function get id() : int
		{
			return _id;
		}
	}
}
