package events
{
	import starling.events.Event;
	
	public class PrizeEvent extends Event
	{
		public static const FLY_AWAY:String = "fly_away";
		public function PrizeEvent(type:String, bubbles:Boolean=false, data:Object=null)
		{
			super(type, bubbles, data);
		}
	}
}