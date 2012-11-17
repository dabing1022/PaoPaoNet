package view.Bullet
{
	import model.BulletData;
	import model.Data;
	
	import starling.display.Image;
	import starling.events.EventDispatcher;
	
	import utils.LayerUtils;
	public class BulletForTipManager extends EventDispatcher
	{
		private static var _instance:BulletForTipManager;
		private var _bulletForTipView:BulletForTipView;
		/**提示子弹的数据信息*/
		public var nextBulletData:BulletData;
		public function BulletForTipManager()
		{
			super();
		}
		
		public static function getInstance():BulletForTipManager{
			return _instance ||= new BulletForTipManager();
		}
		
		public function start(bulletData:BulletData):void{
			_bulletForTipView = new BulletForTipView(bulletData);
			_bulletForTipView.x = Const.WIDTH - _bulletForTipView.width;
			_bulletForTipView.y = 2;
			LayerUtils.getInstance().frameLayer.addChild(_bulletForTipView);
		}
		
		public function end():void{
			LayerUtils.getInstance().frameLayer.removeChild(_bulletForTipView);
			_bulletForTipView.dispose();
			_bulletForTipView = null;
		}
		
		public function showNextBulletTip():void{
			_bulletForTipView.showNextBulletTip(nextBulletData);
		}
	}
}
