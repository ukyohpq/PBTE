package btree.branch
{
	import btree.SingleRunningChildBranch;
	import btree.Task;

	/**
	 * A {@code Sequence} is a branch task that runs every children until one of them fails. If a child task succeeds, the selector
	 * will start and run the next child task.
	 * @author implicit-invocation
	 * @author ukyohpq
	 * 
	 */
	public class Sequence extends SingleRunningChildBranch
	{
		public function Sequence(tasks:Vector.<Task> = null)
		{
			super(tasks)
		}
		
		public override function childSuccess(task:Task):void
		{
			super.childSuccess(task);
			if(++currentChildIndex < children.length)
				run();// Run next child
			else
				success();// All children processed, return success status
		}

		public override function childFail(task:Task):void
		{
			super.childFail(task);
			fail();// Return failure status when a child says it failed
		}
	}
}