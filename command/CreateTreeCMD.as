package command
{
	import simpleBtree.Tree;

	public class CreateTreeCMD extends AbstractCommand
	{
		public function CreateTreeCMD(name:String)
		{
			super(name);
		}
		
		public override function execute(params:Array):void
		{
			super.execute(params);
			var treeName:String = params[0];
			var description:String = params[1];
//			var window:
			var tree:Tree = new Tree();
			tree.name = treeName;
			tree.description = description;
		}
		
		public override function undo(params:Array):void
		{
			super.undo(params);
		}
	}
}