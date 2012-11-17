package view.InfoBoard
{
	import flash.utils.Timer;
	
	import starling.display.Sprite;
	import starling.events.EventDispatcher;
	
	import utils.LayerUtils;
	
	public class FloatScoreManager extends EventDispatcher
	{
		private static var _instance:FloatScoreManager;
		private var _score:uint;
		private var _floatScoreContainer:Sprite;
		public function FloatScoreManager():void
		{
			super();
		}
		
		public function start():void{
			_floatScoreContainer = new Sprite();
			LayerUtils.getInstance().frameLayer.addChild(_floatScoreContainer);
		}
		
		public function end():void{
			LayerUtils.getInstance().frameLayer.removeChild(_floatScoreContainer);
			_floatScoreContainer.dispose();
			_floatScoreContainer = null;
		}
		
		public function showFloatScore(coordX:Number, coordY:Number, score:uint):void{
			var floatScoreView:FloatScoreView = new FloatScoreView();
			_floatScoreContainer.addChild(floatScoreView);
			floatScoreView.x = coordX;
			floatScoreView.y = coordY;
			floatScoreView.scoreNumTxt.text = score.toString();
		}
		
		public static function getInstance():FloatScoreManager{
			return _instance ||= new FloatScoreManager();
		}
		
	}
}