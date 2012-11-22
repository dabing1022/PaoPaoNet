package view.Level
{
	/**关卡载入过度界面*/
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Shape;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.textures.Texture;
	
	public class LevelLoadingScreen extends Sprite
	{
		/**关卡名称文本*/
		private var levelNameTxt:TextField;
		/**关卡名称*/
		private var levelName:String;
		private var frameBmpd:BitmapData;
		private var frameLine:Shape;
		private var squareQuad:Quad;
		private var loader:Loader;
		private var urlLoader:URLLoader;
		private var loaderContext:LoaderContext;
		private var resUrl:String;
		private var _themeId:uint;
		private var _levelId:uint;
		public function LevelLoadingScreen(themeId:uint, levelId:uint):void
		{
			super();
			_themeId = themeId;
			_levelId = levelId;
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			init();
		}
		
		private function init():void{
			levelName = _themeId + "_" + _levelId;
			levelNameTxt = new TextField(100, 100, levelName, "Verdana", 40, 0x000099, true);
			addChild(levelNameTxt);
			levelNameTxt.x = Const.WIDTH - levelNameTxt.width >> 1;
			levelNameTxt.y = 300;
			
			squareQuad = new Quad(500,10,0x0099ff);
			squareQuad.x = stage.stageWidth - 500 >> 1;
			squareQuad.y = 400;
			squareQuad.scaleX = 0;
			addChild(squareQuad);
			
			frameLine = new Shape();
			frameLine.graphics.lineStyle(3,0x0032ca);
			frameLine.graphics.drawRect(0,0,500,10);
			
			frameBmpd = new BitmapData(500,10,true,0x000000);
			frameBmpd.draw(frameLine);
			var texture:Texture = Texture.fromBitmapData(frameBmpd);
			var img:Image = new Image(texture);
			img.x = squareQuad.x;
			img.y = squareQuad.y;
			addChild(img);
			
			loader = new Loader();
			resUrl = "Theme" + _themeId + "Resource" + ".swf";
			loaderContext = new LoaderContext();
			loaderContext.applicationDomain = ApplicationDomain.currentDomain;
			loader.contentLoaderInfo.addEventListener(flash.events.ProgressEvent.PROGRESS,onProgress);
			loader.contentLoaderInfo.addEventListener(flash.events.Event.COMPLETE, onComplete);
			loader.load(new URLRequest(resUrl),loaderContext);
		}
		
		private function onProgress(e:flash.events.ProgressEvent):void
		{
			var percent:Number = e.bytesLoaded / e.bytesTotal;
			squareQuad.scaleX = percent;
		}
		
		private function onComplete(e:flash.events.Event):void{
			trace("load " + "主题" + _themeId + "资源" + " complete...");
			loader.contentLoaderInfo.removeEventListener(flash.events.ProgressEvent.PROGRESS, onProgress);
			loader.contentLoaderInfo.removeEventListener(flash.events.Event.COMPLETE, onComplete);
			dispatchEventWith(starling.events.Event.COMPLETE);
		}
	}
}