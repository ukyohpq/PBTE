package command
{
	public class CommandManager
	{
		public function CommandManager()
		{
		}
		
		public static function doCommand(cmdName:String, ...params):void
		{
			switch(cmdName)
			{
				default:
					trace(cmdName);
			}
		}
	}
}