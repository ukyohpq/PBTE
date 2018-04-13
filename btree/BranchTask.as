package btree
{
	/**
	 * A branch task defines a behavior tree branch, contains logic of starting or running sub-branches and leaves
	 * @author implicit-invocation
	 * @author davebaol
	 * @author ukyohpq
	 * @TaskConstraint(minChildren = 1)
	 */
	public class BranchTask extends Task
	{
		/**
		 * The children of this branch task.
		 */
		protected var children:Vector.<Task>; 
		/**
		 * Create a branch task with a list of children
		 * @param tasks list of this task's children, can be empty. if tasks is null, Create a branch task with no children
		 * 
		 */
		public function BranchTask(tasks:Vector.<Task> = null)
		{
			this.children = tasks == null?tasks:Vector.<Task>([]);
		}
		
		protected override function addChildToTask(child:Task):int
		{
			return children.push(child) - 1;
		}
		
		public override function getChildCount():int
		{
			return children.length
		}

		public override function getChild(i:int):Task
		{
			return children[i];
		}
		
		protected override function copyto(task:Task):Task
		{
			super.copyto();
			var branch:BranchTask = task as BranchTask;
			if(children != null)
			{
				var length:int = children.length;
				for (var i:int = 0; i < length; i++) 
				{
					branch.children.push(children[i].cloneTask());
				}
			}
			return task;
		}
		
		public override function reset():void
		{
			children.splice(0, children.length);
			super.reset();
		}


	}
}