package view.Level
{
	import model.UserData;
	
	import utils.LayerUtils;

	public class LevelInfoManager
	{
		private var _levelInfo:LevelInfoShow;
		private static var _instance:LevelInfoManager;
		private var user:UserData;
		public function LevelInfoManager()
		{
			user = UserData.getInstance();
		}
		
		public function start():void{
			_levelInfo = new LevelInfoShow(user.themeId, user.levelIndex);
			LayerUtils.getInstance().frameLayer.addChild(_levelInfo);
			_levelInfo.x = 100;
			_levelInfo.y = 10;
		}
		
		public function end():void{
			LayerUtils.getInstance().frameLayer.removeChild(_levelInfo);
			_levelInfo.dispose();
			_levelInfo = null;
		}
		
		public static function getInstance():LevelInfoManager{
			if(_instance == null){
				_instance = new LevelInfoManager();
			}
			return _instance;
		}
		
		public function update():void{
			_levelInfo.levelNameTxt.text = user.themeId + "_" + user.levelId;
		}
	}
}