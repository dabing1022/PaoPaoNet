package view.Score
{
	import flash.utils.Timer;
	
	import starling.display.Sprite;
	import starling.events.EventDispatcher;
	
	import utils.LayerUtils;
	
	public class ScoreManager extends EventDispatcher
	{
		private static var _instance:ScoreManager;
		private var _scoreView:ScoreView;
		private var _score:uint;
		private var _floatScoreContainer:Sprite;
		public function ScoreManager()
		{
			super();
		}
		
		public function start():void{
			_floatScoreContainer = new Sprite();
			_scoreView = new ScoreView();
			_scoreView.x = 600;
			_scoreView.y = 10;
			LayerUtils.getInstance().frameLayer.addChild(_scoreView);
			LayerUtils.getInstance().frameLayer.addChild(_floatScoreContainer);
		}
		
		public function end():void{
			LayerUtils.getInstance().frameLayer.removeChild(_scoreView);
			LayerUtils.getInstance().frameLayer.removeChild(_floatScoreContainer);
			_floatScoreContainer.dispose();
			_scoreView.dispose();
			_floatScoreContainer = null;
			_scoreView = null;
		}
		
		public function showFloatScore(coordX:Number, coordY:Number, score:uint):void{
			var floatScoreView:FloatScoreView = new FloatScoreView();
			_floatScoreContainer.addChild(floatScoreView);
			floatScoreView.x = coordX;
			floatScoreView.y = coordY;
			floatScoreView.scoreNumTxt.text = score.toString();
		}
		
		public static function getInstance():ScoreManager{
			return _instance ||= new ScoreManager();
		}
		
		public function get score():uint
		{
			return _score;
		}
		
		public function set score(value:uint):void
		{
			_score = value;
			_scoreView.scoreNumTxt.text = _score.toString();
		}
	}
}