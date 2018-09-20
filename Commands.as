package
{
	import flash.events.Event;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.utils.describeType;
	
	import mx.controls.Alert;

	public class Commands
	{
		private static var map:Object = {};
		public static function initCMDs():void
		{
			initCMD(FileOperator);
		}
		
		private static function initCMD(cmdCLS:Class):void
		{
			var info:XML = describeType(cmdCLS);
			var methods:XMLList = info..method;
			for each (var method:XML in methods) 
			{
				var mds:XMLList = method.metadata.(@name == "CMD");
				if(mds.length() == 0){
					continue;
				}
				for each (var md:XML in mds) 
				{
					map[md.arg[0].@value.toString()] = cmdCLS[method.@name.toString()];
				}
			}
		}
		
		public static function doCommand(cmdName:String):void
		{
			var func:Function = map[cmdName];
			if(func == null){
				Alert.show("错误的命令:" + cmdName);
				return;
			}
			func();
		}
	}
}