package utils
{
	/**
	 * 关卡配置XML数据
	 **/
	public class LevelConfigXmlUtils
	{
	 	private var _xml:XML;
		private static var _instance:LevelConfigXmlUtils;
		
		public static function getInstance():LevelConfigXmlUtils{
			return _instance ||= new LevelConfigXmlUtils();
		}
		
		public function get xml():XML{
			return _xml;
		}

		public function set xml(value:XML):void
		{
			_xml = value;
		}
	}
}