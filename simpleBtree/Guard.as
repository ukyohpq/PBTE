package simpleBtree
{
	public class Guard extends Task
	{
		/**
		 * Guard每次执行完毕，都需要把状态置回来
		 * @param result
		 * 
		 */
		protected override function onExit(result:TaskResult):void
		{
			this.status = TaskStatus.FRESH;
		}
	}
}