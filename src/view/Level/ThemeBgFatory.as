package view.Level
{
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.text.TextField;

	public class ThemeBgFatory
	{
		private static var _themeQuad:Quad;
		private static var _themeTxt:TextField;
		private static var _themeSpr:Sprite;
		public function ThemeBgFatory()
		{
		}
		
		public static function makeThemeBg(themeId:uint):Sprite{
			var themeName:String = "主题\n" + themeId;
			_themeQuad = new Quad(60, 60, 0x000000);
			_themeTxt = new TextField(60, 60, themeName, "Verdana", 14, 0xffffff, true);
			_themeSpr = new Sprite();
			_themeSpr.addChild(_themeQuad);
			_themeSpr.addChild(_themeTxt);
			return _themeSpr;
		}
	}
}