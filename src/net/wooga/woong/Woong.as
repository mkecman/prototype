package net.wooga.woong {
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import net.wooga.woong.core.ViewRoot;
	import net.wooga.woong.core.WoongContext;
	import net.wooga.woong.message.core.InitializeCore;
	import org.spicefactory.lib.logging.Appender;
	import org.spicefactory.lib.logging.impl.DefaultLogFactory;
	import org.spicefactory.lib.logging.impl.SOSAppender;
	import org.spicefactory.lib.logging.impl.TraceAppender;
	import org.spicefactory.lib.logging.LogContext;
	import org.spicefactory.lib.logging.LogFactory;
	import org.spicefactory.lib.logging.Logger;
	import org.spicefactory.lib.logging.LogLevel;
	import org.spicefactory.lib.logging.SpiceLogFactory;

	import org.spicefactory.parsley.asconfig.ActionScriptConfig;
	import org.spicefactory.parsley.context.ContextBuilder;
	import org.spicefactory.parsley.core.context.Context;
	import org.spicefactory.parsley.core.events.ContextEvent;

	import flash.display.Sprite;
	
	[SWF(width='1280', height='600', backgroundColor='#CCCCCC', frameRate='30')]
	public class Woong extends Sprite
	{
		public var viewRoot : ViewRoot;
		private var log:Logger = LogContext.getLogger(Woong);
		
		public function Woong()
		{
			viewRoot = new ViewRoot();
			addChild( viewRoot );
			stage.align     = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			initLogger();
			initContext();
		}
		
		private function initContext() : void
		{
			var contextBuilder : ContextBuilder = ContextBuilder.newSetup()
					.description( "Woong" )
					.viewRoot( viewRoot )
					.newBuilder();
			
			registerDynamicObjects( contextBuilder );
			
			var context : Context = contextBuilder
					.config( ActionScriptConfig.forClass( WoongContext ) )
					.build();
			
			if ( context.initialized )
				completeContext();
			else
				context.addEventListener( ContextEvent.INITIALIZED, handleContextInitialized );
		}

		private function handleContextInitialized( event : ContextEvent ) : void
		{
			( event.currentTarget as Context ).removeEventListener( ContextEvent.INITIALIZED, handleContextInitialized );
			completeContext();
		}
		
		private function completeContext() : void
		{
			viewRoot.dispatch( new InitializeCore() );
		}
		
		private function registerDynamicObjects( contextBuilder : ContextBuilder ) : void
		{
			contextBuilder.objectDefinition()
					.forInstance( viewRoot )
					.asSingleton()
					.id( "viewRoot" )
					.register();

			contextBuilder.objectDefinition()
					.forInstance( stage )
					.asSingleton()
					.register();
		}
		
		public function initLogger() : void
		{
			/*var factory:SpiceLogFactory = new DefaultLogFactory();
			factory.setRootLogLevel(LogLevel.WARN);
			factory.addLogLevel("net.wooga.woong", LogLevel.DEBUG);
			var traceApp:Appender = new TraceAppender();
			traceApp.threshold = LogLevel.TRACE;
			factory.addAppender(traceApp);
			LogContext.factory = factory;*/
			
			/*var factory:DefaultLogFactory = new DefaultLogFactory();

			factory.setRootLogLevel(LogLevel.WARN);
			factory.addLogLevel("net.wooga.woong", LogLevel.DEBUG);

			var traceApp:Appender = new SOSAppender();
			traceApp.threshold = LogLevel.TRACE;
			factory.addAppender(traceApp);

			var logger : Logger = LogContext.getLogger( Woong );
			LogContext.factory = factory;
			
			logger.warn("evo e");
			logger.debug("a ovo");*/
		}
	}
}
