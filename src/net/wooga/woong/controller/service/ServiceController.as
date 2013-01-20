package net.wooga.woong.controller.service 
{
	import net.wooga.woong.controller.AbstractController;
	import net.wooga.woong.message.service.RemoteCall;
	import net.wooga.woong.service.amf.AMF;
	
	/**
	 * ...
	 * @author 
	 */
	public class ServiceController extends AbstractController 
	{
		
		public function ServiceController() 
		{
			AMF.init();
		}
		
		[MessageHandler]
		public function handleRemoteCall( message : RemoteCall ) : void
		{
			AMF.exec( message.methodName, message.resultHandler, message.faultHandler, message.rest );
		}
		
	}

}