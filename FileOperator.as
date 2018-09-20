package
{
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	
	public class FileOperator
	{
		private static var fr:FileReference;
		[CMD(name="open file")]
		public static function openFile():void
		{
			fr = new FileReference();
			fr.addEventListener(Event.SELECT, onSelect);
			fr.addEventListener(Event.COMPLETE, onComplete);
			fr.browse([new FileFilter("btx", ".btx")]);
		}
		
		public static function onComplete(event:Event):void
		{
			var fr:FileReference = event.target as FileReference;
			var evt:DataEvent = new DataEvent(CoreEvent.SET_DATA);
			evt.data = fr.data.toString();
			CoreEvent.getInstance().dispatchEvent(evt);
		}
		
		public static function onSelect(event:Event):void
		{
			var fr:FileReference = event.target as FileReference;
			fr.load();
		}
	}
}