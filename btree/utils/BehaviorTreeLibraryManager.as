package btree.utils
{
	import btree.BehaviorTree;
	import btree.Task;

	/**
	 * The {@code BehaviorTreeLibraryManager} is a singleton in charge of the creation of behavior trees using the underlying library.
 	 * If no library is explicitly set (see the method {@link #setLibrary(BehaviorTreeLibrary)}), a default library instantiated by
 	 * the constructor {@link BehaviorTreeLibrary#BehaviorTreeLibrary() BehaviorTreeLibrary()} is used instead.
	 * @author davebaol
	 * @author ukyohpq
	 * 
	 */
	public final class BehaviorTreeLibraryManager
	{
		private static var _ins:BehaviorTreeLibraryManager;
		public static function getInstance():BehaviorTreeLibraryManager
		{
			return _ins ||= new BehaviorTreeLibraryManager();
		}
		
		protected var library:BehaviorTreeLibrary;
		public function BehaviorTreeLibraryManager()
		{
			setLibrary(new BehaviorTreeLibrary());
		}
		
		/**
		 * Sets the the behavior tree library
		 * @param lib the behavior tree library to set 
		 * 
		 */
		public function setLibrary(lib:BehaviorTreeLibrary):void
		{
			this.library = lib;
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
			return library.createRootTask(treeReference);
		}
		
		/**
		 * Creates the {@link BehaviorTree} for the specified reference and blackboard object.
		 * @param treeReference the tree identifier, typically a path
		 * @param blackboard the blackboard object (it can be {@code null}).
		 * @return the tree cloned from the archetype.
		 * @throws SerializationException if the reference cannot be successfully parsed.
		 * @throws TaskCloneException if the archetype cannot be successfully parsed.
		 * 
		 */
		public override function createBehaviorTree(treeReference:String, blackboard:Object = null):BehaviorTree
		{
			return library.createBehaviorTree(treeReference, blackboard);
		}
		
		public function disposeBehaviorTree(treeReference:String, tree:BehaviorTree):void
		{
			library.disposeBehaviorTree(treeReference, tree);
		}
	}
}