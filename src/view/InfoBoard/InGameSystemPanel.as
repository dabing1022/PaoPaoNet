package view.InfoBoard
{
	import events.UserEvent;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	/**
	 * 游戏中设置面板，包括静音、选择关卡、重新开始等按钮
	 */
	public class InGameSystemPanel extends Sprite
	{
		private var bg:Image;
		private var _muteBtn:Button;
		private var _unmuteBtn:Button;
		private var _chooseLevelBtn:Button;
		private var _replayBtn:Button;
		public function InGameSystemPanel()
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void{
			bg = new Image(Assets.getAtlas().getTexture("menuPopOutPanelBg"));
			addChild(bg);
			
			_muteBtn = new Button(Assets.getAtlas().getTexture("musicOffBtn"));
			addChild(_muteBtn);
			_muteBtn.x = 10;
			_muteBtn.y = 21;
			
			_unmuteBtn = new Button(Assets.getAtlas().getTexture("musicOnBtn"));
			addChild(_unmuteBtn);
			_unmuteBtn.x = 10;
			_unmuteBtn.y = 22;
			_unmuteBtn.visible = false;
			
			_chooseLevelBtn = new Button(Assets.getAtlas().getTexture("chooseLevelBtn"));
			addChild(_chooseLevelBtn);
			_chooseLevelBtn.x = 78;
			_chooseLevelBtn.y = 22;
			
			_replayBtn = new Button(Assets.getAtlas().getTexture("replayBtn"));
			addChild(_replayBtn);
			_replayBtn.x = 136;
			_replayBtn.y = 17;
			
			_muteBtn.addEventListener(TouchEvent.TOUCH, onClickMuteBtn);
			_unmuteBtn.addEventListener(TouchEvent.TOUCH, onClickUnMuteBtn);
			_chooseLevelBtn.addEventListener(TouchEvent.TOUCH, onClickChooseLevelBtn);
			_replayBtn.addEventListener(TouchEvent.TOUCH, onClickReplayBtn);
			
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
		}
		
		private function onClickMuteBtn(event:TouchEvent):void
		{
			if(event.getTouch(this) == null)	return;
			if(event.getTouch(this).phase == TouchPhase.BEGAN){
				event.stopPropagation();
			}else if(event.getTouch(this).phase == TouchPhase.ENDED){
				dispatchEvent(new UserEvent(UserEvent.MUTE, true));
				_muteBtn.visible = false;
				_unmuteBtn.visible = true;
			}
		}
		
		private function onClickUnMuteBtn(event:TouchEvent):void
		{
			if(event.getTouch(this) == null)	return;
			if(event.getTouch(this).phase == TouchPhase.BEGAN){
				event.stopPropagation();
			}else if(event.getTouch(this).phase == TouchPhase.ENDED){
				dispatchEvent(new UserEvent(UserEvent.UNMUTE, true));
				_muteBtn.visible = true;
				_unmuteBtn.visible = false;
			}
		}
		
		private function onClickChooseLevelBtn(event:TouchEvent):void
		{
			if(event.getTouch(this) == null)	return;
			if(event.getTouch(this).phase == TouchPhase.BEGAN){
				event.stopPropagation();
			}else if(event.getTouch(this).phase == TouchPhase.ENDED){
				dispatchEvent(new UserEvent(UserEvent.CHOOSE_THEME, true));
			}
		}
		
		private function onClickReplayBtn(event:TouchEvent):void
		{
			if(event.getTouch(this) == null)	return;
			if(event.getTouch(this).phase == TouchPhase.BEGAN){
				event.stopPropagation();
			}else if(event.getTouch(this).phase == TouchPhase.ENDED){
				dispatchEvent(new UserEvent(UserEvent.REPLAY, true));
			}
		}
		
		private function onRemoveFromStage(e:Event):void{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
			
			_muteBtn.dispose();
			_unmuteBtn.dispose();
			_chooseLevelBtn.dispose();
			_replayBtn.dispose();
		}
	}
}