package simpleBtree.logic
{
	import simpleBtree.Sequence;
	import simpleBtree.TaskContainer;
	import simpleBtree.Tree;
	
	public class FloatUpTree extends Tree
	{
		public function FloatUpTree()
		{
			super(new Sequence());
			root.addChild(new FloatUpCondition());
			root.addChild(new FloatUpTask());
		}
	}
}