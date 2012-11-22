package view.Bullet
{
	import flash.display.Bitmap;
	
	import model.BulletData;
	import model.UserData;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	
	import utils.LevelConfigXmlUtils;
	import utils.Vector2D;
	
	public class BulletView extends Sprite
	{
        /**子弹图片*/
        private var _bullet:Image;
		private var _position:Vector2D;
		private var _velocity:Vector2D;
		private var _bulletData:BulletData;
		private var _bulletName:String;
		public function BulletView(bulletData:BulletData):void
		{
			super();
			_bulletData = bulletData;
			_bulletName = _bulletData.bulletName + "2";
            addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}

        private function onAddedToStage(e:Event):void{
            removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
            init();
        }

        private function init():void{
			_position = new Vector2D();
			_velocity = new Vector2D();
			
			_bullet = new Image(Assets.getThemeAtlas(UserData.getInstance().themeId).getTexture(_bulletName));
			addChild(_bullet);
			_bullet.pivotX = _bullet.width * 0.5;
			_bullet.pivotY = _bullet.height * 0.5;
			
			this.touchable = false;
        }
		
		public function update():void{
			_position = _position.add(_velocity);
			x = _position.x;
			y = _position.y;
		}
		
		public function destroy():void{
			_bullet.removeFromParent(true);
			_bullet = null;
		}
		
		public function get position():Vector2D
		{
			return _position;
		}

		public function set position(value:Vector2D):void
		{
			_position = value;
			this.x = _position.x;
			this.y = _position.y;
		}

		public function get velocity():Vector2D
		{
			return _velocity;
		}

		public function set velocity(value:Vector2D):void
		{
			_velocity = value;
		}

		public function get bulletData():BulletData
		{
			return _bulletData;
		}

		public function set bulletData(value:BulletData):void
		{
			_bulletData = value;
		}
	}
}
