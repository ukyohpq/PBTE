package btree.branch
{
	import btree.Task;

	/**
	 * A {@code RandomSequence} is a sequence task's variant that runs its children in a random order.
	 * @author implicit-invocation
	 * @author ukyohpq
	 * 
	 */
	public class RandomSequence extends Sequence
	{
		public function RandomSequence(tasks:Vector.<Task> = null)
		{
			super(tasks);
		}
		
		public override function start():void
		{
			super.start();
			if(randomChildren == null)
				randomChildren = createRandomChildren();
		}

	}
}