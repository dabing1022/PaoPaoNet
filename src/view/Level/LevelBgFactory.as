package view.Level
{
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.text.TextField;

	public class LevelBgFactory
	{
		private static var _bgQuad:Quad;
		private static var _bgTxt:TextField;
		private static var _bgSpr:Sprite;
		private static var _themeId:uint;
		private static var _levelId:uint;
		private static var _bgName:String;
		public function LevelBgFactory()
		{
		}
		
		public static function makeLevelBg(themeId:uint, levelId:uint):Sprite{
			_themeId = themeId;
			_levelId = levelId;
			_bgName = _themeId + "_" + _levelId;
			
			_bgQuad = new Quad(40, 40, 0x000000);
			_bgTxt = new TextField(40, 40, _bgName, "Verdana", 14, 0xffffff);
			_bgSpr = new Sprite();
			_bgSpr.addChild(_bgQuad);
			_bgSpr.addChild(_bgTxt);
			return _bgSpr;
		}
	}
}