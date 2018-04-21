package command
{
	public interface ICommand
	{
		function execute(params:Array):void;
		function undo():void;
		function get name():String;
	}
}