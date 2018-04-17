package simpleBtree.logic
{
	import simpleBtree.LeafTask;
	import simpleBtree.TaskResult;
	
	public class FloatUpCondition extends LeafTask
	{
		protected override function doRun(stepTime:Number):TaskResult
		{
			return TaskResult.SUCCESS;
		}
	}
}