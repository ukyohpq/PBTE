package simpleBtree
{
	public class Tree extends LeafTask implements ITree
	{
		private var _root:TaskContainer;
		private var _activeTask:Task;

		public function get activeTask():Task
		{
			return _activeTask;
		}

		public function get root():TaskContainer
		{
			return _root;
		}

		public function Tree()
		{
			_root = new Sequence();
			super();
			if(tree)
				_root.tree = tree;
			else
				_root.tree = this;
		}

		public function setActiveTask(task:Task):void
		{
			_activeTask = task;
		}
		
		protected override function doRun(stepTime:Number):TaskResult
		{
//			如果不是顶级树，即该树是子树，则直接返回运行结果，否则，需要检测是否有cancel
			if(parent)
				return _root.run(stepTime);
			var result:TaskResult
			while(true)
			{
				result = _root.run(stepTime);
//				如果有cancel，则需要重置树，并重新运行
				if(result == TaskResult.CANCEL)
				{
					reset();
				}else{
					return result;
				}
			}
			return result;
		}
		
		protected override function onReset():void
		{
			_root.reset();
		}
	}
}