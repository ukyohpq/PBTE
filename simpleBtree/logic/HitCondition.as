package simpleBtree.logic
{
	import simpleBtree.LeafTask;
	import simpleBtree.TaskResult;
	
	public class HitCondition extends LeafTask
	{
		protected override function doRun(stepTime:Number):TaskResult
		{
			return TaskResult.FAIL;
		}
	}
}