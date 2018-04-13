package btree.decorator
{
	import btree.LoopDecorator;
	import btree.Task;

	/**
	 * A {@code Repeat} decorator will repeat the wrapped task a certain number of times, possibly infinite. This task always succeeds
 	 * when reaches the specified number of repetitions.
	 * @author implicit-invocation
	 * @author ukyohpq
	 * 
	 */
	public class Repeat extends LoopDecorator
	{
		/**
		 * Optional task attribute specifying the integer distribution that determines how many times the wrapped task must be
	 	 * repeated. Defaults to {@link ConstantIntegerDistribution#NEGATIVE_ONE} which indicates an infinite number of repetitions.
		 */
		public var times:int;
		
		private var count:int;
		
		/**
		 *Creates a repeat decorator that executes the given task the number of times (possibly infinite) determined by the given
	 	 * distribution. The number of times is drawn from the distribution by the {@link #start()} method. Any negative value means
		 * forever. 
		 * @param times the integer distribution specifying how many times the child must be repeated.
		 * @param child the task that will be wrapped
		 * 
		 */
		public function Repeat(times:int = 1, child:Task = null)
		{
			super(child);
			this.times = times;
		}
		
		/**
		 * Draws a value from the distribution that determines how many times the wrapped task must be repeated. Any negative value
	 	 * means forever.
		 * <p>
		 * This method is called when the task is entered. 
		 * 
		 */
		public override function start()
		{
			count = times;
		}
		
		public override function condition():Boolean
		{
			return loop && count != 0;
		}
		
		public override function childSuccess(task:Task):void
		{
			if(count > 0) count--;
			if(count == 0)
			{
				super.childSuccess(task);
				loop = false;
			}else{
				loop = true;
			}
		}
		
		public override function childFail(task:Task):void
		{
			childSuccess(task);
		}
		
		protected override function copyto(task:Task):Task
		{
			var repeat:Repeat = task as Repeat;
			repeat.times = times;
			return super.copyto(task);
		}
		
		public override function reset():void
		{
			count = 0;
			times = 0;
			super.reset();
		}
	}
}