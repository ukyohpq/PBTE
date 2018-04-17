package simpleBtree
{
	public class Selector extends TaskContainer
	{
		protected override function needContinue(result:TaskResult):Boolean
		{
			return result == TaskResult.FAIL;
		}
	}
}