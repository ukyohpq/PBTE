package simpleBtree
{
	public interface IGuard extends ITask
	{
		function set target(value:Task):void;
		function get target():Task;
	}
}