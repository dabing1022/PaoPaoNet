package view.Level
{
	/**
	 * 主题单元
	 **/
	import events.LevelChooseEvent;
	
	import model.ThemeData;
	
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;

	public class ThemeUnit extends Sprite
	{
        private var bg:Image;
		private var theme:ThemeData;
		private var button:Button;
		private var themeFontImg:Image;
		private var themeIndexImg:Image;
		public function ThemeUnit(themeId:uint)
		{
			super();
			theme = new ThemeData();
			theme.themeId = themeId;
			theme.locked = false;
			
			bg = new Image(Assets.getPublicAtlas().getTexture("themeUnitDown"));
			addChild(bg);
			
			button = new Button(Assets.getPublicAtlas().getTexture("themeUnitNomal"), "", Assets.getPublicAtlas().getTexture("themeUnitDown"));
			addChild(button);
			button.visible = false;
			
			themeFontImg = new Image(Assets.getPublicAtlas().getTexture("themeFont"));
			addChild(themeFontImg);
			themeFontImg.x = 12;
			themeFontImg.y = 8;
			
			themeIndexImg = new Image(Assets.getPublicAtlas().getTexture("themeNum" + themeId));
			addChild(themeIndexImg);
			themeIndexImg.x = 28;
			themeIndexImg.y = 50;
			
			themeFontImg.touchable = false;
			themeIndexImg.touchable = false;
			button.touchable = false;
			bg.touchable = false;
		}
		
		public function setCanPlayOrNot(canPlay:Boolean):void{
			theme.locked = canPlay?false : true;
			button.visible = canPlay?true : false;
			if(canPlay){
				this.useHandCursor = true;
				button.touchable = true;
				bg.removeFromParent(true);
				bg = null;
				if(!button.hasEventListener(Event.TRIGGERED))
					button.addEventListener(Event.TRIGGERED, onChooseTheme);
			}else{
				this.useHandCursor = false;
				button.touchable = false;
				if(button.hasEventListener(Event.TRIGGERED))
					button.removeEventListener(Event.TRIGGERED, onChooseTheme);
			}
		}
		
		private function onChooseTheme(event:Event):void{
			dispatchEvent(new LevelChooseEvent(LevelChooseEvent.THEME_CHOOSE, true, theme.themeId));
		}
	}
}
