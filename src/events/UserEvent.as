package events
{
	import starling.events.Event;
	
	public class UserEvent extends Event
	{
		public static const MONEY_CHANGE:String = "money_change";
		public static const REPLAY:String = "replay";
		public static const CHOOSE_THEME:String = "choose_theme";
		public function UserEvent(type:String, bubbles:Boolean=false, data:Object=null)
		{
			super(type, bubbles, data);
		}
	}
}