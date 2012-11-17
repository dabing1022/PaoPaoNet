package model
{
	/**关卡数据*/
	public class LevelConfigData 
	{
		public var bg:String;
		public var bgm:String;
		private static var _instance:LevelConfigData;
		public function LevelConfigData()
		{
			super();
		}
		
		public static function getInstance():LevelConfigData{
			if(_instance == null)
				_instance = new LevelConfigData();
			return _instance;
		}
	}
}