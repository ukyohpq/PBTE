package
{
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	
	public class FileOperator
	{
		private static var fr:File = new File();
		[CMD(name="open file")]
		public static function openFile():void
		{
			fr.addEventListener(Event.SELECT, onOpenSelect);
			fr.addEventListener(Event.COMPLETE, onOpenComplete);
			fr.browse([new FileFilter("btx", ".btx")]);
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
			var fr:FileReference = event.target as FileReference;
			fr.removeEventListener(Event.COMPLETE, onOpenComplete);
			
			var evt:DataEvent = new DataEvent(CoreEvent.SET_DATA);
			evt.data = fr.data.toString();
			CoreEvent.getInstance().dispatchEvent(evt);
		}
		
		public static function onOpenSelect(event:Event):void
		{
			var fr:FileReference = event.target as FileReference;
			fr.removeEventListener(Event.SELECT, onOpenSelect);
			fr.load();
		}
	}
}