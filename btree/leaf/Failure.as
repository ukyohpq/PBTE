package btree.leaf
{
	import btree.LeafTask;
	import btree.Task;
	import btree.TaskStatus;

	/**
	 * {@code Failure} is a leaf that immediately fails.
	 * @author davebaol
	 * @author ukyohpq
	 * 
	 */
	public class Failure extends LeafTask
	{
		public function Failure()
		{
		}
		
		public override function execute():TaskStatus
		{
			return TaskStatus.FAILED;
		}
		
		protected override function copyto(task:Task):Task
		{
			return task;
		}
	}
}