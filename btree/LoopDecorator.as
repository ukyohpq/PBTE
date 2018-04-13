package btree
{
	/**
	 * {@code LoopDecorator} is an abstract class providing basic functionalities for concrete looping decorators.
	 * @author davebaol
	 * @author ukyohpq
	 * 
	 */
	public class LoopDecorator extends Decorator
	{
		/**
		 * Whether the {@link #run()} method must keep looping or not.
		 */
		protected var loop:Boolean;
		public function LoopDecorator(child:Task = null)
		{
			super(child);
		}
		
		/**
		 * Whether the {@link #run()} method must keep looping or not.
		 * @return {@code true} if it must keep looping; {@code false} otherwise.
		 * 
		 */
		public function condition():Boolean
		{
			return loop;
		}
		
		public override function run():void
		{
			loop = true;
			while(condition())
			{
				if(child.status == TaskStatus.RUNNING)
				{
					child.run();
				}else{
					child.setControl(this);
					child.start();
					if(child.checkGuard(this))
						child.run();
					else
						child.fail();
				}
			}
		}
		
		public override function childRunning(runningTask:Object, reporter:Task):void
		{
			super.childRunning(runningTask, reporter);
			loop = false;
		}
		
		public override function reset():void
		{
			loop = false;
			super.reset();
		}
	}
}