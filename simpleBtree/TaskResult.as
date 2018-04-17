package simpleBtree
{
	import utils.Enum;

	public final class TaskResult extends Enum
	{
		public static const FAIL:TaskResult = new TaskResult("FAIL");
		public static const SUCCESS:TaskResult = new TaskResult("SUCCESS");
		public static const RUNNING:TaskResult = new TaskResult("RUNNING");
		public function TaskResult(v:Object)
		{
			super(v);
		}
	}
}