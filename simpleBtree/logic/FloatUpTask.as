package simpleBtree.logic
{
	import simpleBtree.LeafTask;
	import simpleBtree.TaskResult;
	
	public class FloatUpTask extends LeafTask
	{
		private var _duration:Number;
		public function FloatUpTask()
		{
			super();
		}
		
		protected override function onEnter():void
		{
			super.onEnter();
			_duration = 1;
		}
		
		protected override function doRun(stepTime:Number):TaskResult
		{
			if(sumTime < _duration)
			{
				return TaskResult.RUNNING;
			}else{
				return TaskResult.SUCCESS;
			}
		}
		
		protected override function onReset():void
		{
			_duration = 0;
		}
	}
}