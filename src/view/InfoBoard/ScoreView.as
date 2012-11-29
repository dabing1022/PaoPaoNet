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
	
	import utils.NumberUtils;
	
	public class ScoreView extends Sprite
	{
		private var _scoreTxt:TextField;
		private var _scoreImg:Image;
		private var _scoreNumTxt:TextField;
		private var _score:uint;
		private var _scoreBg:Image;
		private var _scoreSpr:Sprite;
		private var _textureVec:Vector.<Texture>;
		private const WIDTH:uint = 16;
		private var gap:uint = 1;
		public function ScoreView()
		{
			super();
			_textureVec = new Vector.<Texture>();
			
			_scoreImg = new Image(Assets.getPublicAtlas().getTexture("score"));
			addChild(_scoreImg);
			_scoreImg.y = 4;
			
			_scoreBg = new Image(Assets.getPublicAtlas().getTexture("numBg2"));
			addChild(_scoreBg);
			_scoreBg.x = 80;
			
			_scoreSpr = new Sprite();
			addChild(_scoreSpr);
			_scoreSpr.x = 90;
			_scoreSpr.y = 5;
			
			setScore(0);
			
			this.touchable = false;
		}
		
		public function setScore(value:uint):void{
			_score = value;
			_textureVec = NumberUtils.getInstance().getNumTextureVec(_score);
			_scoreSpr.removeChildren(0, -1, true);
			var len:uint = _textureVec.length;
			for(var i:uint = 0; i < len; i++){
				var img:Image = new Image(_textureVec[i]);
				_scoreSpr.addChild(img);
				img.x = (WIDTH + gap) * i;
			}
		}

	}
}