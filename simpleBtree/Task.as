package simpleBtree
{
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;

	public class Task implements ITask
	{
		private var _parent:ITaskContainer;

		public function get parent():ITaskContainer
		{
			return _parent;
		}

		public function set parent(value:ITaskContainer):void
		{
			_parent = value;
		}

		private var _tree:ITree;

		public function get tree():ITree
		{
			return _tree;
		}

		public function set tree(value:ITree):void
		{
			_tree = value;
		}

		private var _name:String;

		public function get name():String
		{
			return _name;
		}

		public function set name(value:String):void
		{
			_name = value;
		}

		private var _description:String;

		public function get description():String
		{
			return _description;
		}

		public function set description(value:String):void
		{
			_description = value;
		}

		private var _startTime:Number;

		protected function get startTime():Number
		{
			return _startTime;
		}

		private var _sumTime:Number;

		public function get sumTime():Number
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

		private var _guard:IGuard;
		public function Task()
		{
			reset();
		}
		
		private function enter():void
		{
			tree.setActiveTask(this);
			onEnter();
		}
		
		protected function onEnter():void
		{
//			trace("onEnter" + this);
		}
		
		private function exit(result:TaskResult):void
		{
			onExit(result);
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
			if(!checkGuard(stepTime))
			{
				return TaskResult.CANCEL;
			}
			
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
								this.exit(result);
								return result;
							case TaskResult.RUNNING:
								_status = TaskStatus.RUNNING;
								_sumTime += stepTime;
								return result;
							case TaskResult.CANCEL:
								return result;
							default:
								throw new Error("非法的运行结果:" + result);
						}
					case TaskStatus.COMPLETE:
						throw new Error("不能运行一个已经结束的task");
					default:
						//不可能执行到的分支
						throw new Error("非法的任务状态：" + _status);
				}
			}
			return result;
		}
		
		public final function reset():void
		{
			_startTime = 0;
			_sumTime = 0;
			status = TaskStatus.FRESH;
			if(_guard)
				_guard.reset();
			onReset();
		}
			
		protected function onReset():void
		{
			
		}
		
		public function addGuard(guard:IGuard):void
		{
			_guard = guard;
			_guard.target = this;
		}
		
		public function removeGuard():void
		{
			_guard = null;
		}
		
		private function checkGuard(stepTime:Number):Boolean
		{
			if(!_guard) return true;
			return _guard.run(stepTime) == TaskResult.SUCCESS;
		}
		
		
	}
}