package command
{
	import flash.utils.Dictionary;
	
	import model.AppData;

	public class CommandManager
	{
		private static var _ins:CommandManager;
		public static function getInstance():CommandManager
		{
			return _ins ||= new CommandManager();
		}
		
		public function CommandManager()
		{
			_cmdMap = new Dictionary();
			init();
		}
		
		private var _cmdMap:Dictionary = new Dictionary();
		
		public function registCMD(cmdName:String):void
		{
			var cmd:ICommand;
			switch(cmdName)
			{
				default:
					cmd = new CreateTreeCMD(cmdName);
			}
			_cmdMap[cmdName] = cmd;
		}
		//注册所有命令
		private function init():void
		{
			registCMD("1A");
			registCMD("2A");
			registCMD("3A");
			registCMD("1B");
		}
		
		public function doCommand(cmdName:String, params:Array = null):void
		{
			redo(cmdName, params);
			AppData.getInstance().currentProject.cmdStack.push(cmdName, params);
		}
		
		public function redo(cmdName:String, params:Array = null):void
		{
			var cmd:ICommand = _cmdMap[cmdName] as ICommand;
			cmd.execute(params);
		}
		
		public function undo(cmdName:String, params:Array = null):void
		{
			var cmd:ICommand = _cmdMap[cmdName] as ICommand;
			cmd.undo(params);
		}
	}
}