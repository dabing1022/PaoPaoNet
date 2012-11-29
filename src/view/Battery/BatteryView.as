package view.Battery
{
	import flash.display.BitmapData;
	
	import model.BulletData;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	
	import view.Bullet.BulletForTipView;
	
	public class BatteryView extends Sprite
	{
		private var _batteryMc:MovieClip;
		internal var gunSpr:Sprite;
		private var _base:Image;
		internal var bulletForTipView:BulletForTipView;
		/**提示子弹用的子弹颜色图片*/
		private var _bulletForTipColorImg:Image;
		private var _bulletName:String;
		private var _bulletData:BulletData;
		public function BatteryView(bulletData:BulletData)
		{
			_bulletData = bulletData;
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			this.touchable = false;
		}
		
		private function onAddedToStage(event:Event):void
		{
			drawBattery();
			drawBulletForTip();
            this.touchable = false;
			this.pivotX = _base.width * 0.5;
			this.pivotY = _base.height;
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);	
		}
		
		private function drawBattery():void
		{
			_batteryMc = new MovieClip(Assets.getPublicAtlas().getTextures("gun"), 20);
			_batteryMc.stop();
			Starling.juggler.add(_batteryMc);
			
			gunSpr = new Sprite();
			addChild(gunSpr);
			
			var colorName:String = "color" + _bulletData.colorId;
			_bulletForTipColorImg = new Image(Assets.getPublicAtlas().getTexture(colorName));
			_bulletForTipColorImg.pivotX = _bulletForTipColorImg.width * 0.5;
			_bulletForTipColorImg.pivotY = _bulletForTipColorImg.height * 0.5;
			
			gunSpr.addChild(_batteryMc);
			gunSpr.addChild(_bulletForTipColorImg);
			_bulletForTipColorImg.x = 90;
			_bulletForTipColorImg.y = 36;
			gunSpr.pivotX = 0;
			gunSpr.pivotY = 38;
			gunSpr.x = 40;
			gunSpr.y = 30;
			_base = new Image(Assets.getPublicAtlas().getTexture("battery"));
			addChild(_base);
		}
		
		private function drawBulletForTip():void
		{
			bulletForTipView = new BulletForTipView(_bulletData);
			bulletForTipView.rotation = Math.PI / 2;
			bulletForTipView.x = 30;
			bulletForTipView.y = 38;
			gunSpr.addChild(bulletForTipView);
		}
		
		public function showNextBulletTip(nextBulletData:BulletData):void{
			bulletForTipView.showNextBulletTip(nextBulletData);
			
			var colorName:String = "color" + nextBulletData.colorId;
			_bulletForTipColorImg.texture = Assets.getPublicAtlas().getTexture(colorName)
		}
		
		public function gunBang():void{
			if(!_batteryMc.isPlaying)
				_batteryMc.play();
		}
		
		public function stopFire():void{
			if(_batteryMc.isPlaying){
				if(_batteryMc.currentFrame == 1){
					_batteryMc.stop();
				}else{
					_batteryMc.play();
				}
			}
		}
	}
}
