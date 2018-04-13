package btree.branch
{
	import btree.Task;

	/**
	 * A {@code RandomSelector} is a selector task's variant that runs its children in a random order.
	 * @author implicit-invocation
	 * @author ukyohpq
	 * 
	 */
	public class RandomSelector extends Selector
	{
		public function RandomSelector(tasks:Vector.<Task> = null)
		{
			super(tasks)
		}
		
		public override function start():void
		{
			super.start();
			if(randomChildren == null)
				randomChildren = createRandomChildren();
		}
	}
}