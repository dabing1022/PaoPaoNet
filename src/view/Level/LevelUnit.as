package view.Level
{
	/**
	 * 关卡单元
	 **/
	import events.LevelChooseEvent;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	
	public class LevelUnit extends Sprite
	{
		private var _themeId:uint;
		private var _levelId:uint;
		private var _canPlay:Boolean = false;
		private var bg:Image;
		private var button:Button;
		/**关卡的唯一标识*/
		public var primaryKey:uint;
		private var themeIndexImg:Image;
		private var levelIndexImg:Image;
		private var lineImg:Image;
		public function LevelUnit(themeId:uint, levelId:uint)
		{
			super();
			_themeId = themeId;
			_levelId = levelId;
			
			bg = new Image(Assets.getPublicAtlas().getTexture("themeUnitDown"));
			addChild(bg);
			
			button = new Button(Assets.getPublicAtlas().getTexture("themeUnitNomal"), "", Assets.getPublicAtlas().getTexture("themeUnitDown"));
			addChild(button);
			button.visible = false;
			
			themeIndexImg = new Image(Assets.getPublicAtlas().getTexture("themeNum" + _themeId));
			addChild(themeIndexImg);
			themeIndexImg.x = 0;
			themeIndexImg.y = 30;
			
			lineImg = new Image(Assets.getPublicAtlas().getTexture("themeNumLine"));
			addChild(lineImg);
			lineImg.x = 30;
			lineImg.y = 68;
			
			levelIndexImg = new Image(Assets.getPublicAtlas().getTexture("themeNum" + _levelId));
			addChild(levelIndexImg);
			levelIndexImg.x = 52;
			levelIndexImg.y = 30;
			
			bg.touchable = false;
			button.touchable = false;
			themeIndexImg.touchable = false;
			lineImg.touchable = false;
			levelIndexImg.touchable = false;
		}
		
		public function setCanPlayOrNot(canPlay:Boolean):void{
			if(canPlay){
				this.useHandCursor = true;
				button.touchable = true;
				button.visible = true;
				if(!button.hasEventListener(Event.TRIGGERED))
					button.addEventListener(Event.TRIGGERED, onChooseLevel);
			}else{
				this.useHandCursor = false;
				button.touchable = false;
				if(button.hasEventListener(Event.TRIGGERED))
					button.removeEventListener(Event.TRIGGERED, onChooseLevel);
			}
		}
		
		private function onChooseLevel(event:Event):void{
			var obj:Object = {};
			obj.themeId = _themeId;
			obj.levelIndex = _levelId;
			obj.levelId = primaryKey;
			dispatchEvent(new LevelChooseEvent(LevelChooseEvent.LEVEL_CHOOSE, true, obj));
		}
		
		public function get levelId():uint
		{
			return _levelId;
		}

		public function set levelId(value:uint):void
		{
			_levelId = value;
		}
	}
}