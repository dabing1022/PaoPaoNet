package view.InfoBoard
{
	import model.UserData;
	
	import utils.LayerUtils;

	public class InfoBoardViewManager
	{
		private var _infoBoardView:InfoBoardView;
		private static var _instance:InfoBoardViewManager;
		private var user:UserData;
		private var _money:uint;
		private var _score:uint;
		public function InfoBoardViewManager()
		{
			user = UserData.getInstance();
		}
		
		public static function getInstance():InfoBoardViewManager{
			return _instance ||= new InfoBoardViewManager();
		}
		
		public function start():void{
			_infoBoardView = new InfoBoardView();
			LayerUtils.getInstance().frameLayer.addChild(_infoBoardView);
		}
		
		public function end():void{
			LayerUtils.getInstance().frameLayer.removeChild(_infoBoardView);
			_infoBoardView.dispose();
			_infoBoardView = null;
		}
		
		public function set money(value:uint):void
		{
			_money = value;
			_infoBoardView.moneyView.moneyTxt.text = value.toString();
		}
		
		public function set score(value:uint):void
		{
			_score = value;
			_infoBoardView.scoreView.scoreNumTxt.text = value.toString();
		}
		
		public function updateLevelInfo():void{
			_infoBoardView.levelInfo.levelNameTxt.text = user.themeId + "_" + user.levelId;
		}

		public function get money():uint
		{
			return _money;
		}

		public function get score():uint
		{
			return _score;
		}
	}
}