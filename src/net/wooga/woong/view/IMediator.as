package net.wooga.woong.view
{
	import net.wooga.woong.message.view.ViewControl;

	/**
	 * ...
	 * @author 
	 */
	public interface IMediator
	{
		function viewClass() : Class;

		function handleOpenView( message : ViewControl ) : void;

		function handleCloseView( message : ViewControl ) : void;
	}
}