package simpleBtree
{
	public class Sequence extends TaskContainer
	{
		protected override function needContinue(result:TaskResult):Boolean
		{
			return result == TaskResult.SUCCESS;
		}
	}
}