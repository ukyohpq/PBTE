package simpleBtree
{
	public interface ITree extends ILeafTask
	{
		function get activeTask():Task;
		function get root():TaskContainer;
		function setActiveTask(task:Task):void;
	}
}