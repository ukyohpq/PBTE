package btree.decorator
{
	import btree.Decorator;
	import btree.Task;

	/**
	 * An {@code AlwaysFail} decorator will fail no matter the wrapped task fails or succeeds.
	 * @author implicit-invocation 
	 * @author ukyohpq
	 * 
	 */
	public class AlwaysFail extends Decorator
	{
		public function AlwaysFail(task:Task)
		{
			super(task);
		}
		
		public override function childSuccess(task:Task):void
		{
			childFail(task);
		}
	}
}