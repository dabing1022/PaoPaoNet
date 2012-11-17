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
//		private var _batteryMc:MovieClip;
		private var gun:Image;
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
		}
		
		private function onAddedToStage(event:Event):void
		{
			drawBattery();
			drawBulletForTip();
            this.touchable = false;
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);	
		}
		
		private function drawBattery():void
		{
			//			_batteryMc = new MovieClip(Assets.getAtlas().getTextures("gun"), 20);
			//			_batteryMc.stop();
			//			Starling.juggler.add(_batteryMc);
			//			addChild(_batteryMc);
			gunSpr = new Sprite();
			
			gun = new Image(Assets.getAtlas().getTexture("gun"));
			addChild(gunSpr);
			
			var colorName:String = "color" + _bulletData.bulletId;
			_bulletForTipColorImg = new Image(Assets.getAtlas().getTexture(colorName));
			
			gunSpr.addChild(gun);
			gunSpr.addChild(_bulletForTipColorImg);
			_bulletForTipColorImg.x = 82;
			_bulletForTipColorImg.y = 28;
			gunSpr.pivotX = 0;
			gunSpr.pivotY = 38;
			gunSpr.x = 40;
			gunSpr.y = 30;
			_base = new Image(Assets.getAtlas().getTexture("battery"));
			addChild(_base);
		}
		
		private function drawBulletForTip():void
		{
			bulletForTipView = new BulletForTipView(_bulletData);
			bulletForTipView.x = 40;
			bulletForTipView.y = 20;
			addChild(bulletForTipView);
		}
		
		public function showNextBulletTip(nextBulletData:BulletData):void{
			bulletForTipView.showNextBulletTip(nextBulletData);
			
			var colorName:String = "color" + nextBulletData.bulletId;
			_bulletForTipColorImg.texture = Assets.getAtlas().getTexture(colorName)
		}
		
		/*public function gunBang():void{
			if(!_batteryMc.isPlaying)
				_batteryMc.play();
		}*/
		
		/*public function stopFire():void{
			if(_batteryMc.isPlaying){
				if(_batteryMc.currentFrame == 1){
					_batteryMc.stop();
				}else{
					_batteryMc.play();
				}
			}
		}*/
	}
}
