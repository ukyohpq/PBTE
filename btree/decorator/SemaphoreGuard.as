package btree.decorator
{
	import btree.Decorator;

	/**
	 * A {@code SemaphoreGuard} decorator allows you to specify how many characters should be allowed to concurrently execute its
 	 * child which represents a limited resource used in different behavior trees (note that this does not necessarily involve
 	 * multithreading concurrency).
 	 * <p>
 	 * This is a simple mechanism for ensuring that a limited shared resource is not over subscribed. You might have a pool of 5
 	 * pathfinders, for example, meaning at most 5 characters can be pathfinding at a time. Or you can associate a semaphore to the
 	 * player character to ensure that at most 3 enemies can simultaneously attack him.
 	 * <p>
 	 * This decorator fails when it cannot acquire the semaphore. This allows a selector task higher up the tree to find a different
 	 * action that doesn't involve the contested resource.
	 * @author davebaol
	 * @author ukyohpq
	 * 
	 */
	public class SemaphoreGuard extends Decorator
	{
		/**
		 * Mandatory task attribute specifying the semaphore name.
		 */
		public var name:String;
		
//		TODO transient
		private var semaphore;
		private var semaphoreAcquired:Boolean;
		public function SemaphoreGuard()
		{
		}
	}
}