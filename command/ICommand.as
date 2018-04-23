package command
{
	public interface ICommand
	{
		function execute(params:Array):void;
		function undo(params:Array):void;
		function get name():String;
	}
}