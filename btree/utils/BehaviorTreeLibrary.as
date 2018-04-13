package btree.utils
{
	import btree.BehaviorTree;
	import btree.Task;
	
	import flash.utils.Dictionary;

	/**
	 * A {@code BehaviorTreeLibrary} is a repository of behavior tree archetypes. Behavior tree archetypes never run. Indeed, they are
 	 * only cloned to create behavior tree instances that can run.
	 * @author davebaol
	 * @author ukyohpq
	 * 
	 */
	public class BehaviorTreeLibrary
	{
		protected var repository:Dictionary;
//		protected var resolver
		public function BehaviorTreeLibrary()
		{
		}
		
		/**
		 * Creates the root task of {@link BehaviorTree} for the specified reference.
		 * @param treeReference the tree identifier, typically a path
		 * @return the root task of the tree cloned from the archetype.
		 * @throws SerializationException if the reference cannot be successfully parsed.
		 * @throws TaskCloneException if the archetype cannot be successfully parsed.
		 * 
		 */
		public function createRootTask(treeReference:String):Task
		{
//			TODO
			return null;
		}
		
		/**
		 * Creates the {@link BehaviorTree} for the specified reference
		 * @param treeReference the tree identifier, typically a path
		 * @param blackboard the blackboard object (it can be {@code null}).
		 * @return the tree cloned from the archetype.
		 * @throws SerializationException if the reference cannot be successfully parsed.
		 * @throws TaskCloneException if the archetype cannot be successfully parsed.
		 * 
		 */
		public function createBehaviorTree(treeReference:String, blackboard:Object = null):BehaviorTree
		{
//			TODO
			return null;
		}
		
		/**
		 * Dispose behavior tree obtain by this library.
		 * @param treeReference the tree identifier.
		 * @param tree the tree to dispose.
		 * 
		 */
		public function disposeBehaviorTree(treeReference:String, tree:BehaviorTree):void
		{
			if(Task.TASK_CLONER != null)
			{
				Task.TASK_CLONER.freeTask(tree);
			}
		}
	}
}