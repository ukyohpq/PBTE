package simpleBtree.logic
{
	import simpleBtree.LeafTask;
	import simpleBtree.TaskResult;
	
	public class HitTask extends LeafTask
	{
		public function HitTask()
		{
			super();
		}
		
		protected override function doRun(stepTime:Number):TaskResult
		{
			return TaskResult.FAIL;
		}
	}
}