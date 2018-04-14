package btree.leaf
{
	import btree.LeafTask;
	import btree.Task;
	import btree.TaskStatus;

	/**
	 * {@code Success} is a leaf that immediately succeeds.
	 * @author davebaol
	 * @author ukyohpq
	 * 
	 */
	public class Success extends LeafTask
	{
		public function Success()
		{
		}
		
		/**
		 * Executes this {@code Success} task.
		 * @return {@link Status#SUCCEEDED}.
		 * 
		 */
		public override function execute():TaskStatus
		{
			return TaskStatus.SUCCEEDED;
		}
		
		protected override function copyto(task:Task):Task
		{
			return task;
		}
	}
}