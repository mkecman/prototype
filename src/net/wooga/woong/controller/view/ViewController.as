package net.wooga.woong.controller.view
{
	import net.wooga.woong.controller.AbstractController;
	import net.wooga.woong.message.view.InitializeView;
	import net.wooga.woong.message.view.InitializeViewLayers;
	import net.wooga.woong.message.view.ViewControl;
	import net.wooga.woong.view.IMediator;

	import org.spicefactory.lib.logging.LogContext;
	import org.spicefactory.parsley.core.context.Context;
	import org.spicefactory.parsley.core.context.DynamicObject;

	/**
	 * ...
	 * @author $(DefaultUser)
	 */
	public class ViewController extends AbstractController
	{
		[Inject]
		public var context : Context;

		[MessageHandler]
		public function handleInitializeView( message : InitializeView ) : void
		{
			dispatch( new InitializeViewLayers() );
		}

		[MessageHandler(selector="open")]
		public function handleViewControlOpen( message : ViewControl ) : void
		{
			try
			{
				var mediator : IMediator = ( context.getObjectByType( message.mediatorClass ) as IMediator );
			}
			catch(error : Error)
			{
				LogContext.getLogger( this ).warn( "Can't find mediator of type : " + String( message.mediatorClass ) );
			}
			finally
			{
				if ( mediator == null )
				{
					var mediatorClass : Class = message.mediatorClass;
					mediator = new mediatorClass();
					context.addDynamicObject( mediator );
				}
				mediator.handleOpenView( message );
			}
		}

		[MessageHandler(selector="close")]
		public function handleViewControlClose( message : ViewControl ) : void
		{
			try
			{
				var mediator : IMediator = ( context.getObjectByType( message.mediatorClass ) as IMediator );
				mediator.handleCloseView( message );
			}
			catch(error : Error)
			{
				LogContext.getLogger( this ).warn( "Can't find mediator of type : " + String( message.mediatorClass ) );
			}
		}
	}
}