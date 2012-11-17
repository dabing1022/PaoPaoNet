package
{
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Shape;
	import flash.errors.IllegalOperationError;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.system.Security;
	
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.textures.Texture;
	
	import utils.LevelConfigXmlUtils;

	public class PreloadScreen extends Sprite
	{
		private var frameBmpd:BitmapData;
		private var frameLine:Shape;
		private var squareQuad:Quad;
		private static const RES_URL:String = "Resource1.swf";
		private var loader:Loader;
		private var loaderContext:LoaderContext;
		private var percentTxt:TextField;
		public function PreloadScreen()
		{
			super();
			addEventListener(starling.events.Event.ADDED_TO_STAGE,onAddedToStage);
		}
		
		private function onAddedToStage(e:starling.events.Event):void
		{
			removeEventListener(starling.events.Event.ADDED_TO_STAGE,onAddedToStage);
			init();
		}		
		
		private function init():void{
			squareQuad = new Quad(500,10,0x0099ff);
			squareQuad.x = stage.stageWidth - 500 >> 1;
			squareQuad.y = stage.stageHeight - 10 >> 1;
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
			
			percentTxt = new TextField(100,20,"0 %","Verdana",12,0x0099ff,true);
			percentTxt.x = 400;
			percentTxt.y = squareQuad.y - 20;
			addChild(percentTxt);
			
			
			loader = new Loader();
			loaderContext = new LoaderContext();
			loaderContext.applicationDomain = ApplicationDomain.currentDomain;
			loader.contentLoaderInfo.addEventListener(flash.events.ProgressEvent.PROGRESS,onProgress);
			loader.contentLoaderInfo.addEventListener(flash.events.Event.COMPLETE, onComplete);
			loader.load(new URLRequest(RES_URL),loaderContext);
		}
		
		private function onProgress(e:flash.events.ProgressEvent):void
		{
			var percent:Number = e.bytesLoaded / e.bytesTotal;
			squareQuad.scaleX = percent;
			percentTxt.text = Math.round(percent * 100) + " %";
		}
		
		private function onComplete(e:flash.events.Event):void{
			trace("load complete...");
			loader.contentLoaderInfo.removeEventListener(flash.events.ProgressEvent.PROGRESS, onProgress);
			loader.contentLoaderInfo.removeEventListener(flash.events.Event.COMPLETE, onComplete);
			dispatchEventWith(starling.events.Event.COMPLETE);
		}
	}
}