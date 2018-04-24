package simpleBtree.logic
{
	import simpleBtree.Sequence;
	import simpleBtree.TaskContainer;
	import simpleBtree.Tree;
	
	public class FloatUpTree extends Tree
	{
		public function FloatUpTree()
		{
			super();
			root.addChild(new FloatUpCondition());
			var float:FloatUpTask = new FloatUpTask();
			float.addGuard(new TestGuard());
			root.addChild(float);
		}
	}
}