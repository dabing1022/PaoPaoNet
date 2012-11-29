package view.Bullet
{
	import model.BulletData;
	
	import starling.display.Image;
	import starling.display.Sprite;
	
	import utils.LevelConfigXmlUtils;

	/**用于提示下一个出现的子弹*/
	public class BulletForTipView extends Sprite
	{
        /**提示子弹用的背景*/
		private var bulletForTipBg:Image;
        /**提示子弹用的子弹图片*/
		private var _bulletForTipImg:Image;
		/**提示子弹用的子弹颜色图片*/
		private var _bulletForTipColorImg:Image;
		private var _bulletName:String;
		private var _bulletData:BulletData;
        /**图片有所偏离，规整位置坐标*/
        private static const OFFSET_X:uint = 4;
        private static const OFFSET_Y:uint = 4;
		public function BulletForTipView(bulletData:BulletData):void
		{
			super();
			_bulletData = bulletData;
			_bulletName = _bulletData.bulletName + "1";
			drawBg();
			drawBulletForTipImg();
			this.touchable = false;
		}
		
		private function drawBulletForTipImg():void
		{
			_bulletForTipImg = new Image(Assets.getAtlas().getTexture(_bulletName));
			_bulletForTipImg.x = 4;
			_bulletForTipImg.y = 4;
			addChild(_bulletForTipImg);
			
			var colorName:String = "color" + _bulletData.colorId;
			_bulletForTipColorImg = new Image(Assets.getAtlas().getTexture(colorName));
			addChild(_bulletForTipColorImg);
			_bulletForTipColorImg.x = 10;
			_bulletForTipColorImg.y = 90;
		}
		
		private function drawBg():void{
			bulletForTipBg = new Image(Assets.getAtlas().getTexture("bulletForTip"));
			addChild(bulletForTipBg);
		}
		
		public function showNextBulletTip(bulletData:BulletData):void{
			var nextBulletName:String = bulletData.bulletName + "1";
			var colorName:String = "color" + bulletData.colorId;
			_bulletForTipImg.texture = Assets.getAtlas().getTexture(nextBulletName);
			_bulletForTipColorImg.texture = Assets.getAtlas().getTexture(colorName)
		}

/*-----------------------------getter and setter----------------------------*/
		/**提示子弹用的子弹Name*/
		public function get bulletName():String
		{
			return _bulletName;
		}

		public function set bulletName(value:String):void
		{
			_bulletName = value;
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
