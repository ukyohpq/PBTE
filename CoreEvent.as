package
{
	import flash.events.DataEvent;
	import flash.events.EventDispatcher;

	[Event(name="setData", type="CoreEvent")]
	public class CoreEvent extends EventDispatcher
	{
		public static const SET_DATA:String = "setData";
		private static var ins:CoreEvent;
		public static function getInstance():CoreEvent
		{
			return ins ||= new CoreEvent();
		}
		
		public function CoreEvent()
		{
			super(this);
		}
		
	}
}