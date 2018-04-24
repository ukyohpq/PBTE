package model
{
	import simpleBtree.Tree;

	/**
	 * 窗口中的行为树的数据
	 * @author ukyohpq
	 * 
	 */
	public class TreeData
	{
		private var _tree:Tree;

		public function get tree():Tree
		{
			return _tree;
		}

		public function TreeData()
		{
		}
		
		public function clear():void
		{
			_tree = null;
		}
		
		public function createNewTree():void
		{
			_tree = new Tree();
			return _tree;
		}
	}
}