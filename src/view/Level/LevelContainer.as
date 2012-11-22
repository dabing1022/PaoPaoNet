package view.Level
{
	import events.LevelChooseEvent;
	
	import model.ThemeData;
	
	import starling.display.Button;
	import starling.display.Sprite;
	import starling.events.Event;
	
	/**
	 * 关卡容器
	 */
	public class LevelContainer extends Sprite
	{
		private var _theme:ThemeData;
		private var _levelVector:Vector.<LevelUnit>;
		/**返回到主题选择界面*/
		private var backThemeBtn:Button;
		private var _levelArr:Array;
		public function LevelContainer(arr:Array)
		{
			super();
			_levelArr = arr;
			_levelVector = new Vector.<LevelUnit>();
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
			drawLevelUnit();
			drawBackBtn();
			backThemeBtn.addEventListener(Event.TRIGGERED, onBackThemeContainer);
			
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onBackThemeContainer(event:Event):void
		{
			dispatchEvent(new LevelChooseEvent(LevelChooseEvent.BACK_TO_THEME));
		}
		
		private function drawLevelUnit():void
		{
			var i:uint;
			var len:uint = _levelArr.length;
			for(i = 0;i < len;i++){
				//背景及定位
				var levelUnit:LevelUnit = new LevelUnit(_levelArr[i].themeId, _levelArr[i].levelIndex);
				levelUnit.x = 120 * i;
				addChild(levelUnit);
				_levelVector.push(levelUnit);
				levelUnit.primaryKey = _levelArr[i].levelId;
				levelUnit.setCanPlayOrNot(!_levelArr[i].locked);
			}
		}
		
		private function drawBackBtn():void
		{
			backThemeBtn = new Button(Assets.getPublicAtlas().getTexture("backBtnNomal"), "",Assets.getPublicAtlas().getTexture("backBtnDown"));
			backThemeBtn.x = this.width - backThemeBtn.width >> 1;
			backThemeBtn.y = (this.height - backThemeBtn.height >> 1) + 150;
			addChild(backThemeBtn);
		}
		
		public function show():void{
			this.visible = true;
		}
	}
}