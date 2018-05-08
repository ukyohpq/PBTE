package command
{
	import model.AppData;
	
	import simpleBtree.Tree;

	public class CreateTreeCMD extends AbstractCommand
	{
		private static const DEFAULT_NAME:String = "默认树";
		private static const DEFAULT_DESCRIPTION:String = "默认描述";
		public function CreateTreeCMD(name:String)
		{
			super(name);
		}
		
		public override function execute(params:Array):void
		{
			super.execute(params);
			var treeName:String = params[0];
			var description:String = params[1];
			var tree:Tree = new Tree();
			tree.name = DEFAULT_NAME;
			tree.description = DEFAULT_DESCRIPTION;
//			AppData.getInstance().currentProject
		}
		
		public override function undo(params:Array):void
		{
			super.undo(params);
		}
	}
}