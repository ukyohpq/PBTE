package simpleBtree
{
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;

	public class Task
	{
		public var parent:TaskContainer;
		public var tree:Tree;

		private var _startTime:Number;

		protected function get startTime():Number
		{
			return _startTime;
		}

		private var _sumTime:Number;

		protected function get sumTime():Number
		{
			return _sumTime;
		}

		private var _status:TaskStatus;

		public function set status(value:TaskStatus):void
		{
//			if(value == TaskStatus.FRESH)
//				trace(123);
			_status = value;
		}


		public function get status():TaskStatus
		{
			return _status;
		}

		private var _eventMap:Dictionary;
		public function Task()
		{
			_eventMap = new Dictionary();
			reset();
		}
		
		protected function onEnter():void
		{
			trace("onEnter" + this);
		}
		
		protected function onExit(result:TaskResult):void
		{
			
		}
		
		protected function doRun(stepTime:Number):TaskResult
		{
			return TaskResult.FAIL;
		}
		
		public final function run(stepTime:Number):TaskResult
		{
			var result:TaskResult;
			while(true)
			{
				switch(_status)
				{
					case TaskStatus.FRESH:
						onEnter();
						status = TaskStatus.RUNNING;
						break;
					case TaskStatus.RUNNING:
						result = this.doRun(stepTime);
						switch(result)
						{
							case TaskResult.FAIL:
							case TaskResult.SUCCESS:
								status = TaskStatus.COMPLETE;
								break;
							case TaskResult.RUNNING:
								_status = TaskStatus.RUNNING;
								_sumTime += stepTime;
								return result;
							default:
								throw new Error("非法的运行结果:" + result);
						}
					case TaskStatus.COMPLETE:
						this.onExit(result);
						return result;
					default:
						//不可能执行到的分支
						throw new Error("非法的任务状态：" + _status);
						break;
				}
			}
			return result;
		}
		
		public function reset():void
		{
			_startTime = 0;
			_sumTime = 0;
			status = TaskStatus.FRESH;
		}
			
		public function addEventListener(event:String, handler:Function):void
		{
		}
		
		public function removeEventListener(event:String, handler:Function):void
		{
		}
		
		public function dispatchEvent(event:String, data:Object):void
		{
		}
	}
}