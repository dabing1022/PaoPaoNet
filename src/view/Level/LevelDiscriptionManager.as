package view.Level
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import model.UserData;
	
	import starling.events.EventDispatcher;
	
	import utils.LayerUtils;
	
	public class LevelDiscriptionManager extends EventDispatcher
	{
		private static var _instance:LevelDiscriptionManager;
		private var levelDiscription:LevelDiscription;
		private var _timer:Timer;
		public function LevelDiscriptionManager()
		{
			super();
			_timer = new Timer(500, 6);
			_timer.addEventListener(TimerEvent.TIMER, onTimer);
			_timer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete);
			
			levelDiscription = new LevelDiscription();
			LayerUtils.getInstance().frameLayer.addChild(levelDiscription);
			levelDiscription.x = 150;
			levelDiscription.y = 100;
		} 
		
		public static function getInstance():LevelDiscriptionManager{
			if(_instance == null)
				_instance = new LevelDiscriptionManager();
			return _instance;
		}
		
		public function twinkleLevelDiscription(themeId:uint, levelId:uint):void{
			levelDiscription.update(themeId, levelId);
			_timer.start();
		}
		
		private function onTimer(e:TimerEvent):void{
			if(_timer.currentCount % 2 == 0){
				levelDiscription.visible = false;
			}else{
				levelDiscription.visible = true;
			}
		}
		
		private function onTimerComplete(e:TimerEvent):void{
			_timer.reset();
		}
	}
}