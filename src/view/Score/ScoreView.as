package view.Score
{
	import flash.display.Bitmap;
	
	import starling.display.Sprite;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.utils.Color;
	import starling.utils.HAlign;
	
	public class ScoreView extends Sprite
	{
		private var _scoreTxt:TextField;
		private var _scoreNumTxt:TextField;
		private var _score:uint;
		public function ScoreView()
		{
			super();
			var tempCls:Class = Assets.getClass("Resource1_1_ScoreFontImg");
			var bmp:Bitmap = new tempCls();
			var texture:Texture = Texture.fromBitmap(bmp);
			tempCls = Assets.getClass("Resource1_1_ScoreFontXml");
			var xml:XML = XML(new tempCls());
			var bmpFont:BitmapFont = new BitmapFont(texture, xml);
			TextField.registerBitmapFont(bmpFont,"scoreFont");
			
			_scoreTxt = new TextField(90, 50, "Score:", "scoreFont");
			_scoreTxt.fontSize = BitmapFont.NATIVE_SIZE;
			_scoreTxt.color = Color.WHITE;
			_scoreTxt.hAlign = HAlign.LEFT;
			addChild(_scoreTxt);
			
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