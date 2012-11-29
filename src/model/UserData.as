package model
{
	import events.UserEvent;
	
	import starling.events.EventDispatcher;
	
	public class UserData extends EventDispatcher
	{
		private var _tableId:int;
		private var _userName:String;
		private var _nickName:String;
		private var _passWord:String;
		private var _money:int;
		public var score:uint;
		private var _canPlayTheme:uint;
		public var themeId:uint;
		public var levelIndex:uint;	//当前关卡在某个主题中的索引号
		public var nextLevelIndex:uint; //下一个关卡在某个主题中的索引号
		public var levelId:uint;	//当前关卡唯一编号
		public var nextLevelId:uint;//下一个关卡唯一编号
		private static var _instance:UserData;
		public function UserData()
		{
			super();
		}
		
		public static function getInstance():UserData{
			if(_instance == null)
				_instance = new UserData();
			return _instance;
		}

/*------------------------------------getter and setter------------------------------------*/
		/**桌子ID*/
		public function get tableId():int
		{
			return _tableId;
		}

		public function set tableId(value:int):void
		{
			_tableId = value;
		}

		public function get userName():String
		{
			return _userName;
		}

		public function set userName(value:String):void
		{
			_userName = value;
		}

		public function get nickName():String
		{
			return _nickName;
		}

		public function set nickName(value:String):void
		{
			_nickName = value;
		}

		public function get passWord():String
		{
			return _passWord;
		}

		public function set passWord(value:String):void
		{
			_passWord = value;
		}

		public function get money():int
		{
			return _money;
		}

		public function set money(value:int):void
		{
			_money = value;
			dispatchEvent(new UserEvent(UserEvent.MONEY_CHANGE, false, _money));
		}

		public function get canPlayTheme():uint
		{
			return _canPlayTheme;
		}

		public function set canPlayTheme(value:uint):void
		{
			_canPlayTheme = value;
		}

	}
}