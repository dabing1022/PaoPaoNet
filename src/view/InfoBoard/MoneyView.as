package view.InfoBoard
{
	import events.UserEvent;
	
	import flash.display.Bitmap;
	
	import model.UserData;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.utils.Color;
	import starling.utils.HAlign;
	
	import utils.NumberUtils;
	
	public class MoneyView extends Sprite
	{
		private var _moneyImg:Image;
		private var _moneyTxt:TextField;
		private var _numBg:Image;
		private var _numSpr:Sprite;
		public var money:uint;
		private var _textureVec:Vector.<Texture>;
		private const WIDTH:uint = 16;
		private var gap:Number = 0.5;
		public function MoneyView()
		{
			super();
			_textureVec = new Vector.<Texture>();
			
			_moneyImg = new Image(Assets.getAtlas().getTexture("coin"));
			addChild(_moneyImg);
			
			_numBg = new Image(Assets.getAtlas().getTexture("numBg2"));
			addChild(_numBg);
			_numBg.x = 40;
			
			_numSpr = new Sprite();
			addChild(_numSpr);
			_numSpr.x = 50;
			_numSpr.y = 5;
		}
		
		public function setMoney(value:uint):void{
			money = value;
			_textureVec = NumberUtils.getInstance().getNumTextureVec(money);
			_numSpr.removeChildren(0, -1, true);
			var len:uint = _textureVec.length;
			for(var i:uint = 0; i < len; i++){
				var img:Image = new Image(_textureVec[i]);
				_numSpr.addChild(img);
				img.x = (WIDTH + gap) * i;
			}
		}


	}
}