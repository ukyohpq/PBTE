package btree.decorator
{
	import btree.LoopDecorator;
	import btree.Task;

	/**
	 * The {@code UntilFail} decorator will repeat the wrapped task until that task fails, which makes the decorator succeed.
 	 * <p>
 	 * Notice that a wrapped task that always succeeds without entering the running status will cause an infinite loop in the current
 	 * frame.
	 * @author implicit-invocation
 	 * @author davebaol
	 * @author ukyohpq
	 * 
	 */
	public class UntilFail extends LoopDecorator
	{
		public function UntilFail(task:Task = null)
		{
			super(task);
		}
		
		public override function childSuccess(task:Task):void
		{
			loop = true;
		}
		
		public override function childFail(task:Task):void
		{
			success();
			loop = false;
		}
	}
}