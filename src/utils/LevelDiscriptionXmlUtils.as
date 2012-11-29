package utils
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;

	/**
	 * 关卡配置XML数据
	 **/
	public class LevelDiscriptionXmlUtils extends EventDispatcher
	{
	 	private var _xml:XML;
		private var loader:URLLoader;
		private var urlReq:URLRequest;
		private static var _instance:LevelDiscriptionXmlUtils;
		
		public static function getInstance():LevelDiscriptionXmlUtils{
			return _instance ||= new LevelDiscriptionXmlUtils();
		}
		
		public function loadXml(url:String):void{
			loader = new URLLoader();
			urlReq = new URLRequest(Const.LEVEL_DISCRIPTION_URL);
			loader.addEventListener(Event.COMPLETE, onComplete);
			loader.load(urlReq);
		}
		
		private function onComplete(e:Event = null):void{
			_xml = new XML(loader.data);
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		public function get xml():XML{
			return _xml;
		}
	}
}