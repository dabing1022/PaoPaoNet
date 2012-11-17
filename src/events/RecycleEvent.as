package events
{
	import starling.events.Event;
	
	public class RecycleEvent extends Event
	{
		public static const RECYCLE_NUM_CHANGE:String = "recycle_num_change";
		public function RecycleEvent(type:String, bubbles:Boolean=false, data:Object=null)
		{
			super(type, bubbles, data);
		}
	}
}