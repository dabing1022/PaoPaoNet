package events
{
	import starling.events.Event;
	
	public class LoginEvent extends Event
	{
		public static const LOGIN:String = "login"; 
		public function LoginEvent(type:String, bubbles:Boolean=false, data:Object=null)
		{
			super(type, bubbles, data);
		}
	}
}