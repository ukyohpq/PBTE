package btree.decorator
{
	import btree.LoopDecorator;
	import btree.Task;

	/**
	 * The {@code UntilSuccess} decorator will repeat the wrapped task until that task succeeds, which makes the decorator succeed.
 	 * <p>
 	 * Notice that a wrapped task that always fails without entering the running status will cause an infinite loop in the current
 	 * frame.
	 * @author implicit-invocation
 	 * @author davebaol
	 * @author ukyohpq
	 * 
	 */
	public class UntilSuccess extends LoopDecorator
	{
		public function UntilSuccess(task:Task = null)
		{
			super(task);
		}
		
		public override function childSuccess(task:Task):void
		{
			success();
			loop = false;
		}
		
		public override function childFail(task:Task):void
		{
			loop = true;
		}
	}
}