package btree.decorator
{
	import btree.Decorator;
	import btree.Task;

	/**
	 * An {@code Invert} decorator will succeed if the wrapped task fails and will fail if the wrapped task succeeds.
	 * @author implicit-invocation
	 * @author ukyohpq
	 * 
	 */
	public class Invert extends Decorator
	{
		public function Invert(task:Task = null)
		{
			super(task)
		}
		
		public override function childSuccess(task:Task):void
		{
			super.childFail(task);
		}
		
		public override function childFail(task:Task):void
		{
			super.childSuccess(task);
		}
	}
}