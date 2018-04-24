package simpleBtree
{
	public class Selector extends TaskContainer implements ISelector
	{
		protected override function needContinue(result:TaskResult):Boolean
		{
			return result == TaskResult.FAIL;
		}
	}
}