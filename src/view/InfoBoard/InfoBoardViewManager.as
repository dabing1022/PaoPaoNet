package view.InfoBoard
{
	import events.UserEvent;
	
	import model.UserData;
	
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	
	import utils.LayerUtils;
	import utils.SoundManager;

	public class InfoBoardViewManager
	{
		private var _infoBoardView:InfoBoardView;
		private static var _instance:InfoBoardViewManager;
		private var _money:int;
		private var _score:uint;
		private var _themeId:uint;
		private var _levelId:uint;
		private var _inGameSystemPanel:InGameSystemPanel;
		private var _systemPanelStatus:String = "null";
		/**显示系统面板的补间tween*/
		private var showTween:Tween;
		/**隐藏系统面板的补间tween*/
		private var hideTween:Tween;
		public function InfoBoardViewManager()
		{
		}
		
		public static function getInstance():InfoBoardViewManager{
			return _instance ||= new InfoBoardViewManager();
		}
		
		public function start():void{
			_infoBoardView = new InfoBoardView();
			LayerUtils.getInstance().frameLayer.addChild(_infoBoardView);
			_infoBoardView.addEventListener(UserEvent.SYSTEM_SET, onSystemSet);
		}
		
		public function end():void{
			LayerUtils.getInstance().frameLayer.removeChild(_infoBoardView);
			_infoBoardView.dispose();
			_infoBoardView = null;
			
			if(_inGameSystemPanel && _inGameSystemPanel.parent){
				_inGameSystemPanel.removeFromParent(true);
				_inGameSystemPanel = null;
				_systemPanelStatus = "null";
			}
		}
		
		private function onSystemSet():void{
			if(_systemPanelStatus == "null"){
				showGameSystemPanel();
			}else if(_systemPanelStatus == "showing" && showTween.isComplete){
				hideGameSystemPanel();
			}else if(_systemPanelStatus == "destroyed" && hideTween.isComplete){
				showGameSystemPanel();
			}
		}
		
		public function showGameSystemPanel():void{
			_systemPanelStatus = "showing";
			_inGameSystemPanel = new InGameSystemPanel();
			LayerUtils.getInstance().frameLayer.addChild(_inGameSystemPanel);
			LayerUtils.getInstance().frameLayer.swapChildren(_inGameSystemPanel, _infoBoardView);
			_inGameSystemPanel.x = 700;
			_inGameSystemPanel.y = 0;
			showTween = new Tween(_inGameSystemPanel, 0.5, Transitions.EASE_OUT_ELASTIC);
			showTween.animate("y", 50);
			Starling.juggler.add(showTween); 

		}
		
		public function hideGameSystemPanel():void{
			_systemPanelStatus = "destroyed";
			hideTween = new Tween(_inGameSystemPanel, 0.5, Transitions.EASE_OUT_ELASTIC);
			hideTween.animate("y", -70);
			Starling.juggler.add(hideTween); 
			hideTween.onComplete = destroyGameSystemPanel;
		}
		
		private function destroyGameSystemPanel():void{
			_inGameSystemPanel.removeFromParent(true);
			_inGameSystemPanel = null;
		}
		
		public function set money(value:int):void
		{
			_money = value;
			_infoBoardView.moneyView.setMoney(_money);
		}
		
		public function set score(value:uint):void
		{
			_score = value;
			_infoBoardView.scoreView.setScore(_score);
		}
		
		public function updateLevelInfo(themeId:uint, levelId:uint):void{
			_themeId = themeId;
			_levelId = levelId;
			_infoBoardView.levelInfo.setLevelName(_themeId, _levelId);
		}

		public function get money():int
		{
			return _money;
		}

		public function get score():uint
		{
			return _score;
		}
	}
}