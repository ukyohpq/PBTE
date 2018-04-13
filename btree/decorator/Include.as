package btree.decorator
{
	import btree.Decorator;
	import btree.Task;
	import btree.utils.BehaviorTreeLibraryManager;
	
	import flash.utils.getQualifiedClassName;

	/**
	 * An {@code Include} decorator grafts a subtree. When the subtree is grafted depends on the value of the {@link #lazy} attribute:
 	 * at clone-time if is {@code false}, at run-time if is {@code true}.
	 * @author davebaol
 	 * @author implicit-invocation
	 * @author ukyohpq
	 * @TaskConstraint(minChildren = 0, maxChildren = 0)
	 * 
	 */
	public class Include extends Decorator
	{
		/**
		 * Mandatory task attribute indicating the path of the subtree to include.
		 */
		public var subtree:String;
		
		/**
		 * Optional task attribute indicating whether the subtree should be included at clone-time ({@code false}, the default) or at
	 	 * run-time ({@code true}).
		 */
		public var lazy:Boolean;
		
		/**
		 * Creates an eager or lazy {@code Include} decorator for the specified subtree.
		 * @param subtree the subtree reference, usually a path
		 * @param lazy whether inclusion should happen at clone-time (false) or at run-time (true)
		 * 
		 */
		public function Include(subtree:String = "", lazy:Boolean = false)
		{
			this.subtree = subtree;
			this.lazy = lazy;
		}
		
		public override function start():void
		{
			if(!lazy)
				throw new Error("A non-lazy " + getQualifiedClassName(this) + " isn't meant to be run!");
			if(child == null)
			{
				// Lazy include is grafted at run-time
				addChild(createSubtreeRootTask());
			}
		}
		
		public override function cloneTask():Task
		{
			if(lazy)
				return super.cloneTask();
			// Non lazy include is grafted at clone-time
			return createSubtreeRootTask();
		}
		
		protected override function copyto(task:Task):Task
		{
			if(!lazy)
				throw new Error("A non-lazy " + getQualifiedClassName(this) + " isn't meant to be run!");
			
			var include:Include = task as Include;
			include.subtree = subtree;
			include.lazy = lazy;
			return task;
		}
		
		private function createSubtreeRootTask():Task
		{
			return BehaviorTreeLibraryManager.getInstance().createRootTask(subtree);
		}
		
		public override function reset():void
		{
			lazy = false;
			subtree = null;
			super.reset();
		}
	}
}