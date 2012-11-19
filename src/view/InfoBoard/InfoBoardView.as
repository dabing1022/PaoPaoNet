package view.InfoBoard
{
	import events.UserEvent;
	
	import model.UserData;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	
	public class InfoBoardView extends Sprite
	{
		private var _infoBarBg:Image;
		internal var levelInfo:LevelInfoShow;
		internal var moneyView:MoneyView;
		internal var scoreView:ScoreView;
		private var user:UserData;
		//菜单按钮
		private var menuBtn:Button;
		public function InfoBoardView()
		{
			super();
			user = UserData.getInstance();
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void{
			_infoBarBg = new Image(Assets.getTexture("Resource1_InfoBarBg"));
			addChild(_infoBarBg);
			
			levelInfo = new LevelInfoShow(user.themeId, user.levelIndex);
			levelInfo.x = levelInfo.y = 8;
			addChild(levelInfo);
			
			moneyView = new MoneyView();
			moneyView.x = 280;
			moneyView.y = 8;
			addChild(moneyView);
			
			scoreView = new ScoreView();
			scoreView.x = 530;
			scoreView.y = 8;
			addChild(scoreView);
			
			menuBtn = new Button(Assets.getAtlas().getTexture("menuInGameNomal"), "", Assets.getAtlas().getTexture("menuInGameDown"));
			addChild(menuBtn);
			menuBtn.x = 800;
			menuBtn.y = 8;
			menuBtn.addEventListener(TouchEvent.TOUCH, onClickMenuBtn);
			
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
		}
		
		private function onClickMenuBtn(event:TouchEvent):void{
			if(event.getTouch(this) == null)	return;
			if(event.getTouch(this).phase == TouchPhase.BEGAN){
				event.stopPropagation();
			}else if(event.getTouch(this).phase == TouchPhase.ENDED){
				dispatchEvent(new UserEvent(UserEvent.SYSTEM_SET, true));
			}
		}
		
		private function onRemoveFromStage(e:Event):void{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
			
			_infoBarBg.dispose();
			levelInfo.dispose();
			moneyView.dispose();
			scoreView.dispose();
			menuBtn.dispose();
		}
	}
}