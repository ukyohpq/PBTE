package command
{
	public class CreateTreeCMD extends AbstractCommand
	{
		public function CreateTreeCMD(name:String)
		{
			super(name);
		}
		
		public override function execute(params:Array):void
		{
			super.execute(params);
//			var treeName:String = params[0];
		}
		
		public override function undo(params:Array):void
		{
			super.undo(params);
		}
	}
}