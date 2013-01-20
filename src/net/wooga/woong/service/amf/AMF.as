package net.wooga.woong.service.amf
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.net.NetConnection;
	import flash.net.Responder;
	import flash.net.ObjectEncoding;
	import net.wooga.woong.constants.Config;
	
	/**
	 * ...
	 * @author Marko Kecman
	 */
	public class AMF extends EventDispatcher
	{
		private static var gateway : NetConnection = new NetConnection();
		
		public function AMF( target : IEventDispatcher = null )
		{
			super( target );
		}
		
		public static function init() : void
		{
			gateway.objectEncoding = ObjectEncoding.AMF3;
			gateway.connect( Config.BACKEND_URL );
		}
		
		public static function exec( command : String, handleResult : Function, handleFault : Function, rest : Array ) : void
		{
			//create responder object holding reference to handle functions
			var responder : Responder = new Responder( handleResult, handleFault );
			//make amf call. We use apply because of ...rest arguments that need to be concat so ...rest are not passed as array
			gateway.call.apply( gateway, [ command, responder ].concat( rest ) );
		}
		
	}

}