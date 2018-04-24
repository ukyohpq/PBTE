package simpleBtree
{
	public interface ITask
	{
		function get status():TaskStatus;
		function set status(value:TaskStatus):void;
		function run(stepTime:Number):TaskResult;
		function reset():void;
		function addGuard(guard:IGuard):void;
		function removeGuard():void;
		function get parent():ITaskContainer;
		function set parent(value:ITaskContainer):void;
		function get tree():ITree;
		function set tree(value:ITree):void;
		function get name():String;
		function set name(value:String):void;
		function get description():String;
		function set description(value:String):void
	}
}