package btree.decorator
{
	import btree.Decorator;
	import btree.Task;

	/**
	 * An {@code AlwaysSucceed} decorator will succeed no matter the wrapped task succeeds or fails.
	 * @author implicit-invocation
	 * @author ukyohpq
	 * 
	 */
	public class AlwaysSucceed extends Decorator
	{
		public function AlwaysSucceed(task:Task)
		{
			super(task);
		}
		
		public override function childFail(task:Task):void
		{
			childSuccess(task);
		}
	}
}