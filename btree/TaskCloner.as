package btree
{
	/**
	 * A {@code TaskCloner} allows you to use third-party libraries like Kryo to clone behavior trees. See {@link Task#TASK_CLONER}
	 * @author davebaol
	 * @author ukyohpq
	 * 
	 */
	public interface TaskCloner
	{
		/**
		 * Makes a deep copy of the given task.
		 * @param task the task to clone
		 * @return the cloned task
		 * 
		 */
		function cloneTask(task:Task):Task;
		/**
		 * Free task previously created by this {@link TaskCloner}
		 * @param task task to free
		 * 
		 */
		function freeTask(task:Task):void;
	}
}