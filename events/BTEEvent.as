package events
{
	import flash.events.Event;

	public class BTEEvent extends Event
	{
		public static const CREATE_TREE:String = "createTree";
		public var data:Object;
		public function BTEEvent(type:String)
		{
			super(type, false, false);
		}
	}
}