package command
{
	public class AbstractCommand implements ICommand
	{
		private var _name:String;

		public function get name():String
		{
			return _name;
		}

		public function AbstractCommand(name:String)
		{
			this._name = name;
		}
		
		public function execute(params:Array):void
		{
			trace("do cmd:" + name)
		}
		
		public function undo(params:Array):void
		{
			trace("undo cmd:" + name)
		}
		
	}
}