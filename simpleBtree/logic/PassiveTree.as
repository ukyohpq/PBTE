package simpleBtree.logic
{
	import simpleBtree.Selector;
	import simpleBtree.Tree;
	
	public class PassiveTree extends Tree
	{
		public function PassiveTree()
		{
			super();
			root.addChild(new HitBackTree());
			root.addChild(new FloatUpTree())
		}
	}
}