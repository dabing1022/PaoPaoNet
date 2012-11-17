package view.Recycle
{
	import utils.LayerUtils;

	/**回收管理器*/
	public class RecycleManager
	{
		private var _recycleBarL:RecycleBarView;
		private var _recyeleBarR:RecycleBarView;
		public var recycleBarVec:Vector.<RecycleBarView>;
		private static var _instance:RecycleManager;
		public function RecycleManager()
		{
		}
		
		public static function getInstance():RecycleManager{
			if(_instance == null){
				_instance = new RecycleManager();
			}
			return _instance;
		}
		
		public function start():void{
			recycleBarVec = new Vector.<RecycleBarView>();
			
			_recycleBarL = new RecycleBarView();
			LayerUtils.getInstance().frameLayer.addChild(_recycleBarL);
			_recycleBarL.x = Const.RECYCLE_BAR1_X;
			_recycleBarL.y = Const.RECYCLE_BAR1_Y;
			recycleBarVec[0] = _recycleBarL;
			
			_recyeleBarR = new RecycleBarView();
			LayerUtils.getInstance().frameLayer.addChild(_recyeleBarR);
			_recyeleBarR.x = Const.RECYCLE_BAR2_X;
			_recyeleBarR.y = Const.RECYCLE_BAR2_Y;
			_recyeleBarR.numTxt.x = -48;
			recycleBarVec[1] = _recyeleBarR;
		}
		
		public function end():void{
			LayerUtils.getInstance().frameLayer.removeChild(_recycleBarL);
			LayerUtils.getInstance().frameLayer.removeChild(_recyeleBarR);
			_recycleBarL.dispose();
			_recyeleBarR.dispose();
			_recycleBarL = null;
			_recyeleBarR = null;
			recycleBarVec = null;
		}
	}
}