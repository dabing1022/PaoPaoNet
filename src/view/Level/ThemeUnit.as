package view.Level
{
	/**
	 * 主题单元
	 **/
	import events.LevelChooseEvent;
	
	import model.ThemeData;
	
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;

	public class ThemeUnit extends Sprite
	{
        private var bg:Sprite;
		private var lockQuad:Quad;
		private var theme:ThemeData;
		public function ThemeUnit(themeId:uint)
		{
			super();
			theme = new ThemeData();
			theme.themeId = themeId;
			theme.locked = false;
			
			bg = ThemeBgFatory.makeThemeBg(themeId);
			addChild(bg);
			
			lockQuad = new Quad(60, 60, 0x000000);
			lockQuad.alpha = 0.4;
			addChild(lockQuad);
			
			addEventListener(TouchEvent.TOUCH, onChooseTheme);
			touchable = false;
		}
		
		public function setCanPlayOrNot(canPlay:Boolean):void{
			theme.locked = canPlay?false : true;
			lockQuad.visible = canPlay?false : true;
			if(canPlay){
				this.useHandCursor = true;
				this.touchable = true;
			}else{
				this.useHandCursor = false;
				this.touchable = false;
			}
		}
		
		private function onChooseTheme(event:TouchEvent):void{
			var touch:Touch = event.getTouch(stage);
			if(touch.phase == TouchPhase.ENDED){
				var e:LevelChooseEvent = new LevelChooseEvent(LevelChooseEvent.THEME_CHOOSE, true, theme.themeId);
				dispatchEvent(e);
			}
		}
	}
}
