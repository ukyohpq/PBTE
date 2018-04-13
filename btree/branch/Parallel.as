package btree.branch
{
	import btree.BranchTask;
	import btree.Task;
	
	import flash.display.Sprite;

	/**
	 * A {@code Parallel} is a special branch task that runs all children when stepped. 
	 * Its actual behavior depends on its {@link orchestrator} and {@link policy}.<br>
	 * <br>
	 * The execution of the parallel task's children depends on its {@link #orchestrator}:
	 * <ul>
	 * <li>{@link Orchestrator#Resume}: the parallel task restarts or runs each child every step</li>
	 * <li>{@link Orchestrator#Join}: child tasks will run until success or failure but will not re-run until the parallel task has succeeded or failed</li>
	 * </ul>
	 *  
 	 * The actual result of the parallel task depends on its {@link #policy}:
  	 * <ul>
 	 * <li>{@link Policy#Sequence}: the parallel task fails as soon as one child fails; if all children succeed, then the parallel
 	 * task succeeds. This is the default policy.</li>
 	 * <li>{@link Policy#Selector}: the parallel task succeeds as soon as one child succeeds; if all children fail, then the parallel
 	 * task fails.</li>
 	 * </ul>
 	 * 
 	 * The typical use case: make the game entity react on event while sleeping or wandering.
	 * @author ukyohpq
	 * 
	 */
	public class Parallel extends BranchTask
	{
		/**
		 * Optional task attribute specifying the parallel policy (defaults to {@link Policy#Sequence})
		 */
		public var policy:Policy;
		
		/**
		 * Optional task attribute specifying the execution policy (defaults to {@link Orchestrator#Resume})
		 */
		public var orchestrator:Orchestrator;
		
		public var noRunningTasks:Boolean;
		public var lastResult:Boolean;
		public var currentChildIndex:int;
		public function getChildren():Vector.<Task>
		{
			return this.children;
		}
		
		public function Parallel(policy:Policy = Policy.Sequence, orchestrator:Orchestrator = Orchestrator.Resume, tasks:Vector.<Task> = null)
		{
			super(tasks);
			this.policy = policy;
			this.orchestrator = orchestrator;
			noRunningTasks = true;
		}
		
		public override function run():void
		{
			orchestrator.execute(this);
		}
		
		public override function childRunning(runningTask:Object, reporter:Task):void
		{
			noRunningTasks = false;
		}
		
		public override function childSuccess(task:Task):void
		{
			lastResult = policy.onChildSuccess(this);
		}
		
		public override function childFail(task:Task):void
		{
			lastResult = policy.onChildFail(this);
		}
		
		public override function resetTask():void
		{
			super.resetTask();
			noRunningTasks = true;
		}
		
		protected override function copyto(task:Task):Task
		{
			var parallel:Parallel = task as Parallel;
			parallel.policy = policy;
			parallel.orchestrator = orchestrator;
			return super.copyto(task);
		}
		
		public function resetAllChildren():void
		{
			var length:int = getChildCount();
			for (var i:int = 0; i < length; i++) 
			{
				getChild(i).reset();
			}
		}
		
		public override function reset():void
		{
			policy = Policy.Sequence;
			orchestrator = Orchestrator.Resume;
			noRunningTasks = true;
			lastResult = false;
			currentChildIndex = 0;
			super.reset();
		}
		
		public function _cancelRunningChildren(startIndex):void
		{
			this.cancelRunningChildren(startIndex);
		}
	}
}