package
{
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.utils.Dictionary;
	
	public class FileOperator
	{
		private static const fileMap:Object = {};
		private static var file:File = new File();
		[CMD(name="open file")]
		public static function openFile():void
		{
			file.addEventListener(Event.SELECT, onOpenSelect);
			file.addEventListener(Event.COMPLETE, onOpenComplete);
			file.browse([new FileFilter("btx", ".btx")]);
		}
		
		[CMD(name="save")]
		public static function save():void
		{
			
		}
		
		[CMD(name="save as")]
		public static function saveAs():void
		{
			
		}
		
		public static function onOpenComplete(event:Event):void
		{
			var file:File = event.target as File;
			file.removeEventListener(Event.COMPLETE, onOpenComplete);
			
			var evt:DataEvent = new DataEvent(CoreEvent.SET_DATA);
			evt.data = file.data.toString();
			//把打开的文件和XMLList关联起来,便于存文件使用
			fileMap[file.url + file.name] = XMLList(file.data.toString());
			CoreEvent.getInstance().dispatchEvent(evt);
		}
		
		public static function onOpenSelect(event:Event):void
		{
			var file:File = event.target as File;
			if(fileMap[file.url + file.name] != null){
				trace("该文件已经打开");
				return;
			}
			trace(file.url);
			file.removeEventListener(Event.SELECT, onOpenSelect);
			file.load();
		}
	}
}