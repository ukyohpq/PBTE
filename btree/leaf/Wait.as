package btree.leaf
{
	import btree.LeafTask;
	import btree.Task;
	import btree.TaskStatus;
	import btree.utils.BTTime;
	
	import flash.net.sendToURL;

	/**
	 * {@code Wait} is a leaf that keeps running for the specified amount of time then succeeds.
	 * @author davebaol 
	 * @author ukyohpq
	 * 
	 */
	public class Wait extends LeafTask
	{
		
		/**
		 * Mandatory task attribute specifying the random distribution that determines the timeout in seconds.
		 * 
		 */
		public var seconds:Number;
		
		private var startTime:Number;
		private var timeout:Number;
		
		/**
		 * Creates a {@code Wait} task running for the specified number of seconds.
		 * @param seconds the random distribution determining the number of seconds to wait for
		 * 
		 */
		public function Wait(seconds:Number = 0)
		{
			this.seconds = seconds;
		}
		
		/**
		 * Draws a value from the distribution that determines the seconds to wait for.
	 	 * <p>
	 	 * This method is called when the task is entered. Also, this method internally calls {@link Timepiece#getTime()
	 	 * GdxAI.getTimepiece().getTime()} to get the current AI time. This means that
	 	 * <ul>
	 	 * <li>if you forget to {@link Timepiece#update(float) update the timepiece} this task will keep running indefinitely.</li>
	 	 * <li>the timepiece should be updated before this task runs.</li>
	 	 * </ul>
		 * 
		 */
		public override function start():void
		{
			timeout = seconds;
			startTime = BTTime.getTime();
		}
		
		public override function execute():TaskStatus
		{
			return BTTime.getTime() - startTime < timeout?TaskStatus.RUNNING:TaskStatus.SUCCEEDED;s
		}
		
		protected override function copyto(task:Task):Task
		{
			var wait:Wait = task as Wait;
			wait.seconds = seconds;
			return task;
		}
		
		public override function reset():void
		{
			seconds = 0;
			startTime = 0;
			timeout = 0;
			super.reset();
		}
	}
}