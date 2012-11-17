package view.Prize
{
	/**
	 * 飞行物管理
	 * */
	import events.PrizeEvent;
	
	import model.PrizeData;
	
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.EventDispatcher;
	
	import utils.LayerUtils;
	import utils.Vector2D;
	
	public class PrizeManager extends EventDispatcher
	{
		private static var _instance:PrizeManager;
		public function PrizeManager()
		{
			super();
		}
		
		public static function getInstance():PrizeManager{
			return _instance ||= new PrizeManager();
		}
		
		/**舞台上道具存放的数组*/
		private var _prizeVec:Vector.<PrizeView>;
		/**舞台上道具存放的容器*/
		private var _prizeContainer:Sprite;
		
		public function start():void{
			_prizeVec = new Vector.<PrizeView>();
			_prizeContainer = new Sprite();
			_prizeContainer.touchable = false;
			
			_prizeContainer.addEventListener(Event.ENTER_FRAME, movePrize);
			LayerUtils.getInstance().gameLayer.addChild(_prizeContainer);
		}
		
		public function end():void{
			LayerUtils.getInstance().gameLayer.removeChild(_prizeContainer);
			_prizeContainer.removeEventListener(Event.ENTER_FRAME, movePrize);
			_prizeContainer.dispose();
			_prizeContainer = null;
			_prizeVec = null;
		}
		
		public function addPrize(prizeData:PrizeData):void{
			var startX:Number;
			var startY:Number;
			var prize:PrizeView  = new PrizeView(prizeData);
			_prizeVec.push(prize);
			_prizeContainer.addChild(prize);
			
			if(prizeData.pathType == 2 || prizeData.pathType == 3)//矩形或者圆形
			{
				var startPoint:Vector2D = prizeData.pathArr.shift();
				startX = startPoint.x;
				startY = startPoint.y;
			}else{
				startX = prizeData.pathArr[0].x;
				startY = prizeData.pathArr[0].y;
			}
			prize.position = new Vector2D(startX,startY);
//			prize.velocity.length = prizeData.speed;
			prize.velocity.length = prizeData.speed * PrizeView.FACTOR;
		}
		
		private function movePrize(event:Event):void
		{
			for(var i:int = _prizeVec.length-1;i>=0;i--){
				var prize:PrizeView = _prizeVec[i];
				var loop:Boolean = true;
				if(prize.prizeData.pathType == 0 || prize.prizeData.pathType == 1){
					loop = false;
				}
				prize.followPath(prize.prizeData.pathArr, loop);
				prize.update();
				
				if(isOutOfScreen(prize) && prize.pathIndex > 1){
					trace("---------------------------------------fly away");
					dispatchEvent(new PrizeEvent(PrizeEvent.FLY_AWAY, false, prize.prizeData.primaryKey));
					_prizeVec.splice(i,1);
					_prizeContainer.removeChild(prize);
					prize.dispose();
					prize = null;
				}
			}
		}
		
		private function isOutOfScreen(prize:PrizeView):Boolean{
			return prize.x - 100> Const.WIDTH || prize.x + 100 <0 || prize.y + 75 <0 || prize.y - 100 > Const.HEIGHT;
		}
		
		public function get prizeVec():Vector.<PrizeView>{
			return _prizeVec;
		}
		
		public function get prizeContainer():Sprite{
			return _prizeContainer;
		}
	}
}
