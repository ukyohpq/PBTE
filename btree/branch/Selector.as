package btree.branch
{
	import btree.SingleRunningChildBranch;
	import btree.Task;

	/**
	 * A {@code Selector} is a branch task that runs every children until one of them succeeds. If a child task fails, the selector
	 * will start and run the next child task.
	 * @author implicit-invocation
	 * @author ukyohpq
	 * 
	 */
	public class Selector extends SingleRunningChildBranch
	{
		public function Selector(tasks:Vector.<Task> = null)
		{
			super(tasks);
		}
		
		public override function childFail(task:Task):void
		{
			super.childFail(task);
			if(++currentChildIndex < children.length)
				run();// Run next child
			else
				fail();// All children processed, return failure status
		}
		
		public override function childSuccess(task:Task):void
		{
			super.childSuccess(task);
			success();// Return success status when a child says it succeeded
		}
	}
}