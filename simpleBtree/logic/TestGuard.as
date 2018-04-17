package simpleBtree.logic
{
	import simpleBtree.Guard;
	import simpleBtree.TaskResult;
	import simpleBtree.TaskStatus;
	
	public class TestGuard extends Guard
	{
		private var _t:Number;
		public function TestGuard()
		{
			super();
		}
		
		protected override function onReset():void
		{
			_t = 0;
		}
		
		protected override function doRun(stepTime:Number):TaskResult
		{
			_t += stepTime;
			return _t < 10.6?TaskResult.SUCCESS:TaskResult.FAIL;
		}
	}
}