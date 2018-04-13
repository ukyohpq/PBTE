package btree.branch
{
	import btree.BranchTask;
	import btree.Task;

	/**
	 * A {@code DynamicGuardSelector} is a branch task that executes the first child whose guard is evaluated to {@code true}. At
 	 * every AI cycle, the children's guards are re-evaluated, so if the guard of the running child is evaluated to {@code false}, it
 	 * is cancelled, and the child with the highest priority starts running. The {@code DynamicGuardSelector} task finishes when no
 	 * guard is evaluated to {@code true} (thus failing) or when its active child finishes (returning the active child's termination
 	 * status).
	 * @author davebaol
	 * @author ukyohpq
	 * 
	 */
	public class DynamicGuardSelector extends BranchTask
	{
		/**
		 * The child in the running status or {@code null} if no child is running.
		 */
		protected var runningChild:Task;
		public function DynamicGuardSelector(tasks:Vector.<Task> = null)
		{
			super(tasks);
		}
		
		public override function childRunning(runningTask:Object, reporter:Task):void
		{
			runningChild = runningTask;
			running();
		}
		
		public override function childFail(task:Task):void
		{
			this.runningChild = null;
			fail();
		}
		
		public override function childSuccess(task:Task):void
		{
			this.runningChild = null;
			success();
		}
		
		public override function run():void
		{
			var childToRun:Task;
			var length:int = children.length;
			for (var i:int = 0; i < length; i++) 
			{
				var child:Task = children[i];
				if(child.checkGuard(this))
				{
					childToRun = child;
					break;
				}
			}
			
			if(runningChild != null && runningChild != childToRun)
			{
				runningChild.cancel();
				runningChild = null;
			}
			
			if(childToRun == null)
			{
				fail();
			}else{
				if(runningChild == null)
				{
					runningChild = childToRun;
					runningChild.setControl(this);
					runningChild.start();
				}
				runningChild.run();
			}
		}
		
		public override function resetTask():void
		{
			super.resetTask();
			runningChild = null;
		}
		
		protected override function copyto(task:Task):Task
		{
			var branch:DynamicGuardSelector = task as DynamicGuardSelector;
			branch.runningChild = null;
			return super.copyto(task);
		}
		
		public override function reset():void
		{
			runningChild = null;
			super.reset();
		}
	}
}