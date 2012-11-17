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
	
	public class LevelInfoShow extends Sprite
	{
		private var _levelName:String;
		private var _levelImg:Image;
		public var levelNameTxt:TextField;
		public function LevelInfoShow(themeId:uint, levelIndex:uint):void
		{
			super();
			_levelName = themeId + "-" + levelIndex;
			_levelImg = new Image(Assets.getAtlas().getTexture("level"));
			addChild(_levelImg);
			
			var tempCls:Class = Assets.getClass("Resource1_FloatScoreFontImg");
			var bmp:Bitmap = new tempCls();
			var texture:Texture = Texture.fromBitmap(bmp);
			tempCls = Assets.getClass("Resource1_FloatScoreFontXml");
			var xml:XML = XML(new tempCls());
			var bmpFont:BitmapFont = new BitmapFont(texture, xml);
			TextField.registerBitmapFont(bmpFont,"levelFont");
			
			levelNameTxt = new TextField(90, 50, _levelName, "levelFont");
			levelNameTxt.fontSize = BitmapFont.NATIVE_SIZE;
			levelNameTxt.color = Color.WHITE;
			levelNameTxt.hAlign = HAlign.LEFT;
			addChild(levelNameTxt);
			levelNameTxt.x = 60;
			levelNameTxt.y = -14;
			
		}
	}
}