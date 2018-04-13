package btree
{
	public interface TaskCloner
	{
		function cloneTask(task:Task):Task;
		function freeTask(task:Task):void;
	}
}