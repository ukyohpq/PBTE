package simpleBtree
{
	public interface ITaskContainer extends ITask
	{
		function addChild(task:ITask):void;
		function removeChild(task:ITask):void
	}
}