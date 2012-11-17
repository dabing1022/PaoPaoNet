package model
{
	/**回收子弹数据*/
	import events.RecycleEvent;
	
	import starling.events.Event;
	import starling.events.EventDispatcher;
	
	public class RecycleData extends EventDispatcher
	{
		/**回收子弹回收到该数目时候兑换金币*/
		public var maxBulletNum:uint = 50;
		/**兑换金币数目*/
		public var exchangeMoney:uint;
		/**当前回收子弹数目*/
		private var _curBulletNum:uint;
		private static var _instance:RecycleData;
		public function RecycleData()
		{
			super();
			_curBulletNum = 0;
		}
		
		public static function getInstance():RecycleData{
			if(_instance == null){
				_instance = new RecycleData();
			}
			return _instance;
		}

		public function get curBulletNum():uint
		{
			return _curBulletNum;
		}

		public function set curBulletNum(value:uint):void
		{
			_curBulletNum = value;
			dispatchEvent(new RecycleEvent(RecycleEvent.RECYCLE_NUM_CHANGE, false, _curBulletNum));
		}

	}
}