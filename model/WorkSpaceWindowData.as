package model
{
	import simpleBtree.Tree;

	public class WorkSpaceWindowData
	{
		private var _tree:Tree;
		public function WorkSpaceWindowData()
		{
		}
		
		public function createTree(name:String = "NewTree", description:String = "this is new tree"):Tree
		{
			_tree = new Tree();
			_tree.name = name;
			_tree.description = description;
			return _tree;
		}
	}
}