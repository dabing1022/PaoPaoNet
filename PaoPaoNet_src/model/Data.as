package model
{
	public class Data
	{
		private static var _instance:Data;
		public var bulletVec:Vector.<BulletData> = new Vector.<BulletData>();
		public static function getInstance():Data{
			if(_instance == null){
				_instance = new Data();
			}
			return _instance;
		}
		
		public function initBulletVec(arr:Array):void{
			bulletVec.splice(0, bulletVec.length);
			var len:uint = arr.length;
			var i:uint;
			for(i = 0;i < len;i++){
				var bullet:BulletData = new BulletData();
				bullet.bulletId = arr[i].bulletId;
				bullet.bulletName = arr[i].bulletName;
				bullet.price = arr[i].price;
				bullet.speed = arr[i].speed;
				bulletVec.push(bullet);
			}
		}
		
		public function initNewAddBulletVec(arr:Array):Vector.<BulletData>{
			var newAddBulletVec:Vector.<BulletData> = new Vector.<BulletData>();
			var len:uint = arr.length;
			var i:uint;
			for(i = 0;i < len;i++){
				var bullet:BulletData = new BulletData();
				bullet.bulletId = arr[i].bulletId;
				bullet.bulletName = arr[i].bulletName;
				bullet.price = arr[i].price;
				bullet.speed = arr[i].speed;
				newAddBulletVec.push(bullet);
			}
			return newAddBulletVec;
		}
	}
}