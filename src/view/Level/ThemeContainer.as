package view.Level
{
	import starling.display.Sprite;
	
	/**
	 * 主题容器 
	 **/
	public class ThemeContainer extends Sprite
	{
		private var _themeVector:Vector.<ThemeUnit>;
		private var _themeArr:Array;
		public function ThemeContainer(arr:Array):void
		{
			super();
			_themeArr = arr;
			_themeVector = new Vector.<ThemeUnit>();
			
			drawThemeUnit();
		}
		
		private function drawThemeUnit():void
		{
			var i:uint;
			var len:uint = _themeArr.length;
			for(i = 0; i < len; i++){
				var themeUnit:ThemeUnit = new ThemeUnit(_themeArr[i].id);
				addChild(themeUnit);
				_themeVector.push(themeUnit);
				themeUnit.x = 120 * i;
				themeUnit.setCanPlayOrNot(!_themeArr[i].locked);//locked == false,则 canPlay == true
			}
		}
	}
}