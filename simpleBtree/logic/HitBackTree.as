package simpleBtree.logic
{
	import simpleBtree.Sequence;
	import simpleBtree.TaskContainer;
	import simpleBtree.Tree;
	
	public class HitBackTree extends Tree
	{
		public function HitBackTree()
		{
			super();
			root.addChild(new HitCondition());
			root.addChild(new HitTask());
		}
	}
}