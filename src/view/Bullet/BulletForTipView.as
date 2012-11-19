package view.Bullet
{
	import model.BulletData;
	
	import starling.display.Image;
	import starling.display.Sprite;
	
	import utils.LevelConfigXmlUtils;

	/**用于提示下一个出现的子弹*/
	public class BulletForTipView extends Sprite
	{
        /**提示子弹用的子弹图片*/
		private var _bulletForTipImg:Image;
		private var _bulletName:String;
		private var _bulletData:BulletData;
		public function BulletForTipView(bulletData:BulletData):void
		{
			super();
			_bulletData = bulletData;
			_bulletName = _bulletData.bulletName + "2";
			drawBulletForTipImg();
			this.touchable = false;
		}
		
		private function drawBulletForTipImg():void
		{
			_bulletForTipImg = new Image(Assets.getAtlas().getTexture(_bulletName));
			_bulletForTipImg.pivotX = _bulletForTipImg.width * 0.5;
			_bulletForTipImg.pivotY = _bulletForTipImg.height * 0.5;
			addChild(_bulletForTipImg);
		}
		
		public function showNextBulletTip(bulletData:BulletData):void{
			var nextBulletName:String = bulletData.bulletName + "2";
			_bulletForTipImg.texture = Assets.getAtlas().getTexture(nextBulletName);
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
