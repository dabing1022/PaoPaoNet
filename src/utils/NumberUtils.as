package utils
{
	import starling.display.Sprite;
	import starling.textures.Texture;

	public class NumberUtils
	{
		private var numberMap:Vector.<Texture>;
		private static var _instance:NumberUtils;
		
		public function NumberUtils()
		{
			numberMap = new Vector.<Texture>();
			init();
		}
		
		private function init():void{
			var i:uint;
			for(i = 0; i < 10; i++){
				var texture:Texture = Assets.getPublicAtlas().getTexture("num" + i);
				numberMap.push(texture);
			}
		}
		
		public static function getInstance():NumberUtils
		{
			if (_instance == null)
				_instance=new NumberUtils();
			return _instance;
		}
		
		public function getNumTextureVec(num:uint):Vector.<Texture>{
			var numString:String = num.toString();
			var len:uint = numString.length;
			var i:uint;
			var textureVec:Vector.<Texture> = new Vector.<Texture>();
			for(i = 0; i < len; i++){
				var singleNumStr:String = numString.substr(i, 1);
				var singleNumUint:uint = uint(singleNumStr);
				textureVec.push(numberMap[singleNumUint]);
			}
			return textureVec;
		}
	}
}