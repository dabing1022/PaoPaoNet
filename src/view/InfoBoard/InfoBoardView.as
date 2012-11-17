package view.InfoBoard
{
	import model.UserData;
	
	import starling.display.Image;
	import starling.display.Sprite;
	
	
	public class InfoBoardView extends Sprite
	{
		private var _infoBarBg:Image;
		internal var levelInfo:LevelInfoShow;
		internal var moneyView:MoneyView;
		internal var scoreView:ScoreView;
		private var user:UserData;
		public function InfoBoardView()
		{
			super();
			user = UserData.getInstance();
			
			_infoBarBg = new Image(Assets.getTexture("Resource1_InfoBarBg"));
			addChild(_infoBarBg);
			
			levelInfo = new LevelInfoShow(user.themeId, user.levelIndex);
			levelInfo.x = levelInfo.y = 8;
			addChild(levelInfo);
			
			moneyView = new MoneyView();
			moneyView.x = 360;
			moneyView.y = 8;
			addChild(moneyView);
			
			scoreView = new ScoreView();
			scoreView.x = 622;
			scoreView.y = 8;
			addChild(scoreView);
		}
	}
}