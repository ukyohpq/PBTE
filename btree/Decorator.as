package btree
{
	/**
	 * A {@code Decorator} is a wrapper that provides custom behavior for its child. The child can be of any kind (branch task, leaf
 	 * task, or another decorator). 
	 * @author ukyohpq
	 * @author implicit-invocation
 	 * @author davebaol
	 * @TaskConstraint(minChildren = 1, maxChildren = 1)
	 */
	public class Decorator extends Task
	{
		/**
		 * The child task wrapped by this decorator
		 */
		protected var child:Task;
		
		/**
		 * Creates a decorator that wraps the given task
		 * @param child the task that will be wrapped.if child is null, Creates a decorator with no child task
		 * 
		 */
		public function Decorator(child:Task = null)
		{
			this.child = child;
		}
		
		protected override function addChildToTask(child:Task):int
		{
			if(child != null) throw new Error("A decorator task cannot have more than one child");
			this.child = child;
			return 0;
		}
		
		public override function getChildCount():int
		{
			return child == null?0:1;
		}
		
		public override function getChild(i:int):Task
		{
			if(i == 0 && child != null)
				return child;
			throw new Error("index can't be >= size: " + i + " >= " + getChildCount());
		}
		
		public override function run():void
		{
			if(child.status == TaskStatus.RUNNING)
			{
				child.run();
			}else{
				child.setControl(this);
				child.start();
				if(child.checkGuard(this))
					child.run();
				else
					child.fail();
			}
		}
		
		public override function childRunning(runningTask:Object, reporter:Task):void
		{
			running();
		}
		
		public override function childFail(task:Task):void
		{
			fail();
		}
		
		public override function childSuccess(task:Task):void
		{
			success();
		}
		
		protected override function copyto(task:Task):Task
		{
			if(this.child != null)
			{
				var decorator:Decorator = task as Decorator;
				decorator.child = this.child.cloneTask();
			}
			return task;
		}
		
		public override function reset():void
		{
			child = null;
			super.reset();
		}
	}
}