package btree
{
	import org.hamcrest.object.nullValue;

	/**
	 * A {@code SingleRunningChildBranch} task is a branch task that supports only one running child at a time.
	 * @author implicit-invocation
	 * @author davebaol
	 * @author ukyohpq
	 * 
	 */
	public class SingleRunningChildBranch extends BranchTask
	{
		/**
		 * The child in the running status or {@code null} if no child is running.
		 */
		protected var runningChild:Task;
		
		/**
		 * The index of the child currently processed.  
		 */
		protected var currentChildIndex:int;
		
		/**
		 * Array of random children. If it's {@code null} this task is deterministic. 
		 */
		protected var randomChildren:Vector.<Task>;
		
		public function SingleRunningChildBranch(tasks:Vector.<Task> = null)
		{
			super(tasks);
		}
		
		public override function childRunning(runningTask:Object, reporter:Task):void
		{
			runningChild = runningTask;
			running();// Return a running status when a child says it's running
		}
		
		public override function childSuccess(task:Task):void
		{
			this.runningChild = null;
		}
		
		public override function childFail(task:Task):void
		{
			this.runningChild = null;
		}
		
		public override function run():void
		{
			if(runningChild != null)
			{
				runningChild.run();
			}else{
				if(currentChildIndex < children.length)
				{
					if(randomChildren != null)
					{
						var last:int = children.length - 1;
						if(currentChildIndex < last)
						{
							// Random swap
							var otherChildIndex:int = currentChildIndex + Math.round((last - currentChildIndex) * Math.random());
							var temp:Task = randomChildren[currentChildIndex];
							randomChildren[currentChildIndex] = randomChildren[otherChildIndex];
							randomChildren[otherChildIndex] = temp;
						}
						runningChild = randomChildren[currentChildIndex];
					}else{
						runningChild = children[currentChildIndex];
					}
					runningChild.setControl(this);
					runningChild.start();
					if(!runningChild.checkGuard(this))
						runningChild.fail();
					else
						run();
				}else{
					// Should never happen; this case must be handled by subclasses in childXXX methods
				}
			}
		}
		
		public override function start():void
		{
			this.currentChildIndex = 0;
			runningChild = null;
		}
		
		protected override function cancelRunningChildren(startIndex:int):void
		{
			super.cancelRunningChildren(startIndex);
			runningChild = null;
		}
		
		public override function resetTask():void
		{
			super.resetTask();
			this.currentChildIndex = 0;
			this.runningChild = null;
			this.randomChildren = null;
		}
		
		protected override function copyto(task:Task):Task
		{
			var branch:SingleRunningChildBranch = task as SingleRunningChildBranch;
			branch.randomChildren = null;
			return super.copyto(task);
		}
		
//		@SuppressWarnings("unchecked")
		protected function createRandomChildren()
		{
			var rndChildren:Vector.<Task> = Vector.<Task>([]);
			var length:int = children.length;
			for (var i:int = 0; i < length; i++) 
			{
				rndChildren[i] = children[i];
			}
			return rndChildren;
		}
		
		public override function reset():void
		{
			this.currentChildIndex = 0;
			this.runningChild = null;
			this.randomChildren = nullValue();
			super.reset();
		}
	}
}