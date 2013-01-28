package net.wooga.woong.message.service
{
	/**
	 * ...
	 * @author 
	 */
	public class RemoteCall
	{
		private var _rest : Array;
		private var _faultHandler : Function;
		private var _resultHandler : Function;
		private var _methodName : String;

		public function RemoteCall( methodName : String, resultHandler : Function, faultHandler : Function, ... rest )
		{
			_methodName = methodName;
			_resultHandler = resultHandler;
			_faultHandler = faultHandler;
			_rest = rest;
		}

		public function get rest() : Array
		{
			return _rest;
		}

		public function get faultHandler() : Function
		{
			return _faultHandler;
		}

		public function get resultHandler() : Function
		{
			return _resultHandler;
		}

		public function get methodName() : String
		{
			return _methodName;
		}
	}
}