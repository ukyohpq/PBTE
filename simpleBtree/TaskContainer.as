package simpleBtree
{
	public class TaskContainer extends Task
	{
		private var _children:Vector.<Task>;
		private var _runIndex:int;
		private var _runningChild:Task;
		public function TaskContainer()
		{
			super();
			_children = Vector.<Task>([]);
			_runIndex = 0;
		}
		
		protected override function onReset():void
		{
			_runIndex = 0;
			_runningChild = null;
			for each (var child:Task in _children) 
			{
				child.reset();
			}
		}
		
		public function addChild(task:Task):void
		{
			var index:int = _children.indexOf(task);
			if(index == -1)
			{
				_children.push(task);
				task.tree = this.tree;
				task.parent = this;
			}else{
				trace("重复添加子task");
			}
		}
		
		public function removeChild(task:Task):void
		{
			var index:int = _children.indexOf(task);
			if(index != -1)
			{
				var child:Task = _children.splice(index, 1) as Task;
				child.tree = null;
				child.parent = null;
			}
		}
		
		protected function nextChild():Task
		{
			if(_runningChild != null)
				return _runningChild;
			if(_runIndex < _children.length)
			{
				return _children[_runIndex++];
			}
			return null;
		}
		
		protected override function doRun(stepTime:Number):TaskResult
		{
			var child:Task;
			var result:TaskResult;
			while(true)
			{
				child = nextChild();
				if(child != null)
				{
					result = child.run(stepTime);
					if(result == TaskResult.RUNNING)
						_runningChild = child;
					else
						_runningChild = null;
					if(needContinue(result))
						continue;
					else
						return result;
				}
				return TaskResult.SUCCESS;
			}
			return result;
		}
		
		protected function needContinue(result:TaskResult):Boolean
		{
			return false;
		}
	}
}