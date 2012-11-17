package view.Level
{
	/**
	 * 关卡单元
	 **/
	import events.LevelChooseEvent;
	
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	
	public class LevelUnit extends Sprite
	{
		private var _themeId:uint;
		private var _levelId:uint;
		private var _canPlay:Boolean = false;
		private var bg:Sprite;
		private var lockQuad:Quad;
		/**关卡的唯一标识*/
		public var primaryKey:uint;
		public function LevelUnit(themeId:uint, levelId:uint)
		{
			super();
			_themeId = themeId;
			_levelId = levelId;
			
			bg = LevelBgFactory.makeLevelBg(_themeId, _levelId);
			addChild(bg);
			
			lockQuad = new Quad(40, 40, 0x000000);
			lockQuad.alpha = 0.4;
			addChild(lockQuad);
			
			addEventListener(TouchEvent.TOUCH, onChooseTheme);
			touchable = false;
		}
		
		public function setCanPlayOrNot(canPlay:Boolean):void{
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
				var obj:Object = new Object();
				obj.themeId = _themeId;
				obj.levelIndex = _levelId;
				obj.levelId = primaryKey;
				var e:LevelChooseEvent = new LevelChooseEvent(LevelChooseEvent.LEVEL_CHOOSE, true, obj);
				dispatchEvent(e);
			}
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