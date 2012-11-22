package view.Level
{
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	
	import org.osmf.events.TimeEvent;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.textures.Texture;
	
	import utils.ScrollImage;
	
	public class WaitingNextLevelScreen extends Sprite
	{
		private var bg:Image;
		private var levelNameTxt:TextField;
		private var levelName:String;
		private var timer:Timer;
		
		private var loadingBarFrame:Image;
		private var loadingBarContent:ScrollImage;
		private var scale_x:Number = 0;
		public function WaitingNextLevelScreen(themeId:uint, levelId:uint):void
		{
			super();
			this.levelName = themeId + "_" + levelId;
			
			bg = new Image(Assets.getTexture("PublicResource_loginBg"));
			addChild(bg);
			
			levelNameTxt = new TextField(100, 100, levelName, "Verdana", 20, 0xffffff, true);
			addChild(levelNameTxt);
			levelNameTxt.x = 430;
			levelNameTxt.y = 280;
			
			loadingBarFrame = new Image(Assets.getPublicAtlas().getTexture("loadingBarFrame"));
			loadingBarFrame.x = Const.WIDTH - loadingBarFrame.width >> 1;
			loadingBarFrame.y = 320;
			addChild(loadingBarFrame);
			
			loadingBarContent = new ScrollImage(Assets.getPublicAtlas().getTexture("loadingBarContent"));
			var w:uint = loadingBarContent.width;
			var h:uint = loadingBarContent.height;
			loadingBarContent.clipMaskLeft = -2;
			loadingBarContent.clipMaskRight = -2;
			loadingBarContent.clipMaskTop = -2;
			loadingBarContent.clipMaskBottom = 26;
			
			loadingBarContent.x = (Const.WIDTH - w >> 1) + 3;
			loadingBarContent.y = 323;
			addChild(loadingBarContent);
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
			scale_x = 0;
			loadingBarContent.clipMaskRight = 0;
			timer = new Timer(1000 / 30);
			timer.addEventListener(TimerEvent.TIMER, onTimer);
			timer.start();
		}
		
		private function onTimer(event:TimerEvent):void{
			loadingBarContent.clipMaskRight = loadingBarContent.texture.width * scale_x;
			scale_x += 0.1;
			if(scale_x >= 1){
				scale_x = 1;
				timer.stop();
				timer.removeEventListener(TimerEvent.TIMER, onTimer);
				dispatchEventWith(starling.events.Event.COMPLETE);
			}
		}
		
		public function setLevelName(themeId:uint, levelId:uint):void{
			this.visible = true;
			this.levelName = themeId + "_" + levelId;;
			levelNameTxt.text = levelName;
		}
	}
}