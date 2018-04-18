package simpleBtree.logic
{
	import simpleBtree.Guard;
	import simpleBtree.Task;
	import simpleBtree.TaskResult;
	
	public class TestGuard extends Guard
	{
		public function TestGuard(target:Task = null)
		{
			super(target);
		}
		
		protected override function doRun(stepTime:Number):TaskResult
		{
			return target.sumTime < .6?TaskResult.SUCCESS:TaskResult.FAIL;
		}
		
	}
}