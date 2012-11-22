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
	
	public class LevelInfoShow extends Sprite
	{
		private var _themeId:uint;
		private var _levelId:uint;
		private var _levelImg:Image;
		public var levelNameTxt:TextField;
		private var _numBg:Image;
		private var _textureVec1:Vector.<Texture>;
		private var _textureVec2:Vector.<Texture>;
		private var _themeNumSpr:Sprite;
		private var _levelNumSpr:Sprite;
		private var _lineImg:Image;
		private const WIDTH:uint = 21;
		private var gap:uint = 1;
		public function LevelInfoShow(themeId:uint, levelIndex:uint):void
		{
			super();
			_textureVec1 = new Vector.<Texture>();
			_textureVec2 = new Vector.<Texture>();
			
			_levelImg = new Image(Assets.getPublicAtlas().getTexture("level"));
			addChild(_levelImg);
			
			_numBg = new Image(Assets.getPublicAtlas().getTexture("numBg2"));
			addChild(_numBg);
			_numBg.x = 60;
			
			_themeNumSpr = new Sprite();
			addChild(_themeNumSpr);
			_themeNumSpr.x = 70;
			_themeNumSpr.y = 5;
			
			_lineImg = new Image(Assets.getPublicAtlas().getTexture("numLine"));
			addChild(_lineImg);
			
			_levelNumSpr = new Sprite();
			addChild(_levelNumSpr);
		}
		
		public function setLevelName(themeId:uint,levelId:uint):void{
			_themeId = themeId;
			_levelId = levelId;
			_themeNumSpr.removeChildren(0, -1, true);
			_levelNumSpr.removeChildren(0, -1, true);
			
			_textureVec1 = NumberUtils.getInstance().getNumTextureVec(_themeId);
			var len1:uint = _textureVec1.length;
			for(var i:uint = 0; i < len1; i++){
				var img:Image = new Image(_textureVec1[i]);
				_themeNumSpr.addChild(img);
				img.x = (WIDTH + gap) * i;
			}
			
			_lineImg.x = _themeNumSpr.x + _themeNumSpr.width + 4;
			_lineImg.y = 5;
			
			_textureVec2 = NumberUtils.getInstance().getNumTextureVec(_levelId);
			var len2:uint = _textureVec2.length;
			for(var j:uint = 0; j < len2; j++){
				var img2:Image = new Image(_textureVec2[j]);
				_levelNumSpr.addChild(img2);
				img2.x = (WIDTH + gap) * j;
			}
			
			_levelNumSpr.x = _lineImg.x + _lineImg.width + 4;
			_levelNumSpr.y = 5;
		}
		
	}
}