package utils
{
	import starling.display.Sprite;
	import starling.display.Stage;
	
	/**
	 * 层管理工具
	 */
	public class LayerUtils
	{
		private var _frameLayer:starling.display.Sprite;
		private var _gameLayer:starling.display.Sprite;
		private var _baseLayer:starling.display.Sprite
		private static var _instance:LayerUtils;
		
		public static function getInstance():LayerUtils
		{
			return _instance||=new LayerUtils();
		}

		public function start(stage:Stage):void{
			_frameLayer = new starling.display.Sprite();
			_gameLayer = new starling.display.Sprite();
			_baseLayer = new starling.display.Sprite();
			stage.addChild(_baseLayer);
			stage.addChild(_gameLayer);
			stage.addChild(_frameLayer);
		}
		
		public function get frameLayer():starling.display.Sprite{
			return _frameLayer;
		}
		
		public function get gameLayer():starling.display.Sprite{
			return _gameLayer;
		}
		
		public function get baseLayer():starling.display.Sprite{
			return _baseLayer;
		}
	}
}
