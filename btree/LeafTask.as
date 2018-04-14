package btree
{
	/**
	 * A {@code LeafTask} is a terminal task of a behavior tree, contains action or condition logic, can not have any child.
	 * @author implicit-invocation
 	 * @author davebaol
	 * @author ukyohpq
	 * 
	 */
	public class LeafTask extends Task
	{
		public function LeafTask()
		{
			
		}
		
		/**
		 * This method contains the update logic of this leaf task. The actual implementation MUST return one of {@link Status#RUNNING}
	 	 * , {@link Status#SUCCEEDED} or {@link Status#FAILED}. Other return values will cause an {@code IllegalStateException}.
		 * @return 
		 * 
		 */
		public function execute():TaskStatus
		{
			throw "must be override";
		}
		
		/**
		 * This method contains the update logic of this task. The implementation delegates the {@link #execute()} method. 
		 * 
		 */
		public final function run():void
		{
			var result:TaskStatus = execute();
			if(result == null)
				throw new Error("Invalid status 'null' returned by the execute method");
			switch(result)
			{
				case TaskStatus.SUCCEEDED:
					success();
					break;
				case TaskStatus.FAILED:
					fail();
					break;
				case TaskStatus.RUNNING:
					running();
					break
				default:
					throw new Error("Invalid status '" + result.name() + "' returned by the execute method");
					break;
			}
		}
		
		protected override function addChildToTask(child:Task):int
		{
			throw new Error("A leaf task cannot have any children");
		}
		
		public override function getChildCount():int
		{
			return 0;
		}
		
		public override function getChild(i:int):Task
		{
			throw new Error("A leaf task can not have any child");
		}
		
		public override function childRunning(runningTask:Object, reporter:Task):void
		{
			
		}
		
		public override function childFail(task:Task):void
		{
			
		}
		
		public override function childSuccess(task:Task):void
		{
			
		}
	}
}