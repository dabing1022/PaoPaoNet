package view.Bullet
{
	
	import model.BulletData;
	
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.EventDispatcher;
	import starling.textures.Texture;
	
	import utils.LayerUtils;
	import utils.Vector2D;
	
	public class BulletManager extends EventDispatcher
	{
		private static var _instance:BulletManager;
		private var _bulletVec:Vector.<BulletView> ;
		private var _bulletContainer:Sprite;
		public function BulletManager()
		{
			super();
		}
		
		public static function getInstance():BulletManager{
			return _instance||=new BulletManager();
		}
		
		public function start():void{
			_bulletVec = new Vector.<BulletView>();
			_bulletContainer = new Sprite();    
			_bulletContainer.addEventListener(Event.ENTER_FRAME, moveBullets);
			LayerUtils.getInstance().gameLayer.addChild(_bulletContainer);
		}
		
		public function end():void{
			_bulletVec.splice(0, _bulletVec.length);
			_bulletVec = null;
			_bulletContainer.removeEventListener(Event.ENTER_FRAME, moveBullets);
			LayerUtils.getInstance().gameLayer.removeChild(_bulletContainer);
			_bulletContainer.dispose();
			_bulletContainer = null;
		}
		
		public function addBullets(x1:int,y1:int,x2:int,y2:int,bulletData:BulletData):void{
			var bullet:BulletView = new BulletView(bulletData);
		    _bulletVec.push(bullet);
			_bulletContainer.addChild(bullet);
			
			bullet.position = new Vector2D(x1,y1);
	    	bullet.velocity.length = bullet.bulletData.speed;
		    var _angle:Number = Math.atan2(y2-Const.BATTERY_Y,x2-Const.BATTERY_X);
		    bullet.velocity.angle = _angle;
		}
		
		private function moveBullets(e:Event):void{
			var i:uint;
			for(i = 0; i< _bulletVec.length; i++){
				var bullet:BulletView = _bulletVec[i];
				bullet.update();
				
				if(isOutOfScreen(bullet)){
					_bulletVec.splice(i,1);
					_bulletContainer.removeChild(bullet);
					bullet.destroy();
					bullet = null;
				}
			}
		}
		
		private function isOutOfScreen(bullet:BulletView):Boolean{
            var len:Number = bullet.width;
			return bullet.x - len> Const.WIDTH || bullet.x + len < 0 || bullet.y + len < 0 || bullet.y - len> Const.HEIGHT;
		}

		/*** 发射出去子弹存放的数组 */
		public function get bulletVec():Vector.<BulletView>
		{
			return _bulletVec;
		}

		public function set bulletVec(value:Vector.<BulletView>):void
		{
			_bulletVec = value;
		}
	}
}
