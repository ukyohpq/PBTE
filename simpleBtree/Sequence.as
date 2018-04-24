package simpleBtree
{
	public class Sequence extends TaskContainer implements ISequence
	{
		protected override function needContinue(result:TaskResult):Boolean
		{
			return result == TaskResult.SUCCESS;
		}
	}
}