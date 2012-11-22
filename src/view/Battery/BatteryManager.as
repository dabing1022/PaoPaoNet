package view.Battery
{
	import model.BulletData;
	
	import starling.events.EventDispatcher;
	
	import utils.LayerUtils;

	public class BatteryManager extends EventDispatcher
	{
		private static var _instance:BatteryManager;
		private var _battery:BatteryView;
		/**提示子弹的数据信息*/
		public var nextBulletData:BulletData;
		public function BatteryManager()
		{
			super();
		}
		
		public static function getInstance():BatteryManager{
			return _instance ||= new BatteryManager();
		}

		public function start(bulletData:BulletData):void{
			_battery = new BatteryView(bulletData);
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
			_battery.gunSpr.rotation = deg;
		}
		
		public function showNextBulletTip():void{
			_battery.showNextBulletTip(nextBulletData);
		}

		public function gunBang():void{
			_battery.gunBang();
		}
		
		public function stopFire():void{
			_battery.stopFire();
		}
	}
}
