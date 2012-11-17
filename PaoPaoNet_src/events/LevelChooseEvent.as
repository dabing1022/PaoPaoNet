package events
{
	import starling.events.Event;
	
	public class LevelChooseEvent extends Event
	{
		public static const THEME_LOCK:String = "theme_lock";
		public static const LEVEL_LOCK:String = "level_lock";
		public static const THEME_CHOOSE:String = "theme_choose";
		public static const LEVEL_CHOOSE:String = "level_choose";
		public static const BACK_TO_THEME:String = "back_to_theme";
		/**解锁新的主题*/
		public static const UNLOCK_THEME:String = "unlock_theme";
		public function LevelChooseEvent(type:String, bubbles:Boolean=false, data:Object=null)
		{
			super(type, bubbles, data);
		}
	}
}