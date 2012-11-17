package view.Battery
{
	import starling.events.EventDispatcher;
	
	import utils.LayerUtils;

	public class BatteryManager extends EventDispatcher
	{
		private static var _instance:BatteryManager;
		private var _battery:BatteryView;
		public function BatteryManager()
		{
			super();
		}
		
		public static function getInstance():BatteryManager{
			return _instance ||= new BatteryManager();
		}

		public function start():void{
			_battery = new BatteryView();
		}
		
		public function addBattery():void{
			LayerUtils.getInstance().gameLayer.addChild(_battery);
			_battery.x = Const.BATTERY_X;
			_battery.y = Const.BATTERY_Y;
		}
		
		public function end():void{
			LayerUtils.getInstance().gameLayer.removeChild(_battery);
			_battery.dispose();
			_battery = null;
		}
		
		public function gunRotate(deg:Number):void{
			_battery.gun.rotation = deg;
		}

	/*	public function gunBang():void{
			_battery.gunBang();
		}*/
		
	/*	public function stopFire():void{
			_battery.stopFire();
		}*/
	}
}
