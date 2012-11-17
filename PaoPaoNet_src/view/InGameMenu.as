package view
{
	import events.UserEvent;
	
	import starling.display.Button;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	/**
	 * <ol><b>游戏关卡中的菜单</b>
	 * <li>重玩按钮</li>
	 * <li>选择关卡按钮</li>
	 * </ol>
	 */
	public class InGameMenu extends Sprite
	{
		private var replayBtn:Button;
		private var chooseThemeBtn:Button;
		public function InGameMenu()
		{
			super();
			addReplayBtn();
			addChooseLevelBtn();
			replayBtn.addEventListener(TouchEvent.TOUCH, onClickReplayBtn);
			chooseThemeBtn.addEventListener(TouchEvent.TOUCH, onClickChooseThemeBtn);
		}
		
		private function onClickChooseThemeBtn(event:TouchEvent):void
		{
			if(event.getTouch(this) == null)	return;
			if(event.getTouch(this).phase == TouchPhase.BEGAN){
				event.stopPropagation();
			}else if(event.getTouch(this).phase == TouchPhase.ENDED){
				dispatchEvent(new UserEvent(UserEvent.CHOOSE_THEME));
			}
		}
		
		private function onClickReplayBtn(event:TouchEvent):void
		{
			if(event.getTouch(this) == null)	return;
			if(event.getTouch(this).phase == TouchPhase.BEGAN){
				event.stopPropagation();
			}else if(event.getTouch(this).phase == TouchPhase.ENDED){
				dispatchEvent(new UserEvent(UserEvent.REPLAY));
			}
		}
		
		private function addReplayBtn():void
		{
			replayBtn = new Button(Assets.getAtlas().getTexture("loginBtnBg"), "重玩");
			with(replayBtn){
				fontSize = 14;
				fontColor = 0x000000;
			}
			addChild(replayBtn);
		}
		
		private function addChooseLevelBtn():void
		{
			chooseThemeBtn = new Button(Assets.getAtlas().getTexture("loginBtnBg"), "选择关卡");
			with(replayBtn){
				fontSize = 14;
				fontColor = 0x000000;
				x = 100;
			}
			addChild(chooseThemeBtn);
		}
	}
}