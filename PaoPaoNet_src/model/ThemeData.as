package model
{
	import events.LevelChooseEvent;
	
	import starling.events.EventDispatcher;

	public class ThemeData extends EventDispatcher
	{
		private var _themeId:uint;
		private var _levelNum:uint;
		private var _canPlayLevelId:uint;
		private var _locked:Boolean;
		public function ThemeData():void
		{
		}
		
		/**该主题拥有的关卡数目*/
		public function get levelNum():uint
		{
			return _levelNum;
		}

		public function set levelNum(value:uint):void
		{
			_levelNum = value;
		}
		
		/**玩家在该主题下解锁的关卡编号*/
		public function get canPlayLevelId():uint
		{
			return _canPlayLevelId;
		}

		public function set canPlayLevelId(value:uint):void
		{
			_canPlayLevelId = value;
		}
		
		/**主题编号*/
		public function get themeId():uint
		{
			return _themeId;
		}

		public function set themeId(value:uint):void
		{
			_themeId = value;
		}
		
		/**该主题是否解锁*/
		public function get locked():Boolean
		{
			return _locked;
		}

		public function set locked(value:Boolean):void
		{
			_locked = value;
			dispatchEventWith(LevelChooseEvent.THEME_LOCK, true, _locked);
		}
	}
}