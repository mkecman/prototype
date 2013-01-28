package net.wooga.woong.view
{
	/**
	 * ...
	 * @author 
	 */
	public interface IView
	{
		function setup( mediator : IMediator ) : void;

		function open() : void;

		function close() : void;

		function get isOpen() : Boolean;
	}
}