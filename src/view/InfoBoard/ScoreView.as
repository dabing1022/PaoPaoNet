package view.InfoBoard
{
	import flash.display.Bitmap;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.utils.Color;
	import starling.utils.HAlign;
	
	public class ScoreView extends Sprite
	{
		private var _scoreTxt:TextField;
		private var _scoreImg:Image;
		private var _scoreNumTxt:TextField;
		private var _score:uint;
		public function ScoreView()
		{
			super();
			var tempCls:Class = Assets.getClass("Resource1_FloatScoreFontImg");
			var bmp:Bitmap = new tempCls();
			var texture:Texture = Texture.fromBitmap(bmp);
			tempCls = Assets.getClass("Resource1_FloatScoreFontXml");
			var xml:XML = XML(new tempCls());
			var bmpFont:BitmapFont = new BitmapFont(texture, xml);
			TextField.registerBitmapFont(bmpFont,"scoreFont");
			
			_scoreImg = new Image(Assets.getAtlas().getTexture("score"));
			addChild(_scoreImg);
			
			_scoreNumTxt = new TextField(90, 50, "0", "scoreFont");
			_scoreNumTxt.fontSize = BitmapFont.NATIVE_SIZE;
			_scoreNumTxt.color = Color.WHITE;
			_scoreNumTxt.hAlign = HAlign.LEFT;
			_scoreNumTxt.autoScale = true;
			addChild(_scoreNumTxt);
			_scoreNumTxt.x = 90;
		}

		public function get scoreNumTxt():TextField
		{
			return _scoreNumTxt;
		}

		public function set scoreNumTxt(value:TextField):void
		{
			_scoreNumTxt = value;
		}
	}
}