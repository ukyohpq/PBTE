package simpleBtree
{
	public class Tree extends LeafTask
	{
		private var _root:TaskContainer;

		public function get root():TaskContainer
		{
			return _root;
		}

		public function Tree(root:TaskContainer)
		{
			super();
			_root = root;
			if(tree)
				_root.tree = tree;
			else
				_root.tree = this;
		}
		
		protected override function doRun(stepTime:Number):TaskResult
		{
			return _root.run(stepTime);
		}
	}
}