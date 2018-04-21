package command
{
	public class CreateTreeCMD extends AbstractCommand
	{
		public function CreateTreeCMD(name:String)
		{
			super(name);
		}
		
		public override function execute(...params):void
		{
			var treeName:String = params[0];
		}
	}
}