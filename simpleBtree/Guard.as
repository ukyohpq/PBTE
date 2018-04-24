package simpleBtree
{
	public class Guard extends Task implements IGuard
	{
		private var _target:Task

		public function set target(value:Task):void
		{
			_target = value;
		}

		public function get target():Task
		{
			return _target;
		}

		public function Guard(target:Task = null)
		{
			_target = target;
		}
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