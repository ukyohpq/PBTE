package btree.decorator
{
	import btree.Decorator;
	import btree.Task;
	
	/**
	 * The {@code Random} decorator succeeds with the specified probability, regardless of whether the wrapped task fails or succeeds.
 	 * Also, the wrapped task is optional, meaning that this decorator can act like a leaf task.
	  * <p>
 	 * Notice that if success probability is 1 this task is equivalent to the decorator {@link AlwaysSucceed} and the leaf
 	 * {@link Success}. Similarly if success probability is 0 this task is equivalent to the decorator {@link AlwaysFail} and the leaf
 	 * {@link Failure}.
	 * @author davebaol
	 * @author ukyohpq
	 * @TaskConstraint(minChildren = 0, maxChildren = 1)
	 * 
	 */
	public class Random extends Decorator
	{
		/**
		 * Optional task attribute specifying the random distribution that determines the success probability. It defaults to 0.5
		 */
		public var success:Number;
		private var p:Number;
		/**
		 * Creates a {@code Random} decorator with the given child that succeeds with the specified probability.
		 * @param success the random distribution that determines success probability
		 * @param task the child task to wrap
		 * 
		 */
		public function Random(success:Number = 0.5, task:Task = null)
		{
			super(task);
			this.success = success;
		}
		
		/**
		 * Draws a value from the distribution that determines the success probability.
		 * <p>
	 	 * This method is called when the task is entered.
		 * 
		 */
		public override function start():void
		{
			p = success;
		}
		
		public override function run():void
		{
			if(child != null)
				super.run();
			else
				decide();
		}
		
		public override function childFail(task:Task):void
		{
			decide();
		}
		
		public override function childSuccess(task:Task):void
		{
			decide();
		}
		
		private function decide():void
		{
			if(Math.random() <= p)
				success();
			else
				fail();
		}
		
		protected override function copyto(task:Task):Task
		{
			var random:Random = task as Random;
			random.success = success;
			return super.copyto(task);
		}
		
		public override function reset():void
		{
			p = 0;
			success = 0.5;
			super.reset();
		}
	}
}