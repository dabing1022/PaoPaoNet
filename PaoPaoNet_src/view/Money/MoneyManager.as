package view.Money
{
	import starling.events.EventDispatcher;
	
	import utils.LayerUtils;

	public class MoneyManager extends EventDispatcher
	{
		private static var _instance:MoneyManager;
		private var _moneyView:MoneyView;
		private var _money:uint;
		public function MoneyManager() 
		{
			super();
		}
		
		public static function getInstance():MoneyManager{
			return _instance ||= new MoneyManager();
		}
		
		public function start():void{
			_moneyView = new MoneyView();
			_moneyView.x = 700;
			_moneyView.y = 500;
			LayerUtils.getInstance().frameLayer.addChild(_moneyView);
		}
		
		public function end():void{
			LayerUtils.getInstance().frameLayer.removeChild(_moneyView);
			_moneyView.dispose();
			_moneyView = null;
		}
		
		public function get money():uint
		{
			return _money;
		}
		
		public function set money(value:uint):void
		{
			_money = value;
			_moneyView.moneyTxt.text = _money.toString();
		}
	}
}