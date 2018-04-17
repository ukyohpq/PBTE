package btree
{
	import utils.Enum;

	/**
	 * The enumeration of the values that a task's status can have
	 * @author davebaol
	 * @author ukyohpq
	 * 
	 */
	public final class TaskStatus extends Enum
	{
		public function TaskStatus(value:int)
		{
			super(value);
		}
		/**
		 * Means that the task has never run or has been reset.
		 */
		public static const FRESH:TaskStatus = new TaskStatus(1);
		/**
		 * Means that the task needs to run again.
		 */
		public static const RUNNING:TaskStatus = new TaskStatus(2);
		/**
		 * Means that the task returned a failure result.
		 */
		public static const FAILED:TaskStatus = new TaskStatus(3);
		/**
		 * Means that the task returned a success result.
		 */
		public static const SUCCEEDED:TaskStatus = new TaskStatus(4);
		/**
		 * Means that the task has been terminated by an ancestor.
		 */
		public static const CANCELLED:TaskStatus = new TaskStatus(5);
	}
}