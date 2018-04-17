package simpleBtree
{
	import utils.Enum;

	public class TaskStatus extends Enum
	{
		public static const FRESH:TaskStatus = new TaskStatus("FRESH");
		public static const RUNNING:TaskStatus = new TaskStatus("RUNNING");
		public static const COMPLETE:TaskStatus = new TaskStatus("COMPLETE");
		public function TaskStatus(v:Object)
		{
			super(v);
		}
	}
}