package view.Money
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
	
	public class MoneyView extends Sprite
	{
		private var _moneyImg:Image;
		private var _moneyTxt:TextField;
		public function MoneyView()
		{
			super();
			
			_moneyImg = new Image(Assets.getAtlas().getTexture("coin"));
			addChild(_moneyImg);
			
			var tempCls:Class = Assets.getClass("Resource1_1_ScoreFontImg");
			var bmp:Bitmap = new tempCls();
			var texture:Texture = Texture.fromBitmap(bmp);
			tempCls = Assets.getClass("Resource1_1_ScoreFontXml");
			var xml:XML = XML(new tempCls());
			var bmpFont:BitmapFont = new BitmapFont(texture, xml);
			TextField.registerBitmapFont(bmpFont,"moneyFont");
			
			_moneyTxt = new TextField(200, 50, "0", "moneyFont");
			_moneyTxt.fontSize = BitmapFont.NATIVE_SIZE;
			_moneyTxt.color = Color.WHITE;
			_moneyTxt.hAlign = HAlign.LEFT;
			addChild(_moneyTxt);
			_moneyTxt.x = 65;
		}

		public function get moneyTxt():TextField
		{
			return _moneyTxt;
		}

		public function set moneyTxt(value:TextField):void
		{
			_moneyTxt = value;
		}

	}
}