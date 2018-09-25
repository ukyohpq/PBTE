package events
{
	import flash.events.Event;

	public class BTEvent extends Event
	{
		public static const CREATE_TREE:String = "createTree";
		public var data:Object;
		public function BTEvent(type:String)
		{
			super(type, false, false);
		}
	}
}