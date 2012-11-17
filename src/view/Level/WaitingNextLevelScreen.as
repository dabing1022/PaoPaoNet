package view.Level
{
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import org.osmf.events.TimeEvent;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.textures.Texture;
	
	public class WaitingNextLevelScreen extends Sprite
	{
		private var bg:Quad;
		private var levelNameTxt:TextField;
		private var levelName:String;
		private var chilunAni:MovieClip;
		private var frameBmpd:BitmapData;
		private var frameLine:Shape;
		private var squareQuad:Quad;
		private var timer:Timer;
		public function WaitingNextLevelScreen(themeId:uint, levelId:uint):void
		{
			super();
			
			bg = new Quad(Const.WIDTH, Const.HEIGHT, 0x000000, true);
			bg.alpha = 0.3;
			addChild(bg);
			
			levelNameTxt = new TextField(100, 100, levelName, "Verdana", 20, 0xffffff, true);
			addChild(levelNameTxt);
			levelNameTxt.x = 430;
			levelNameTxt.y = (Const.HEIGHT >> 1) - 20;
			
			chilunAni = new MovieClip(Assets.getAtlas().getTextures("chilun"), 30);
			addChild(chilunAni);
			Starling.juggler.add(chilunAni);
			chilunAni.x = 400;
			chilunAni.y = Const.HEIGHT >> 1;
			
			squareQuad = new Quad(500, 8, 0xffffff);
			squareQuad.x = 220;
			squareQuad.y = 350;
			squareQuad.scaleX = 0;
			addChild(squareQuad);
			
			frameLine = new Shape();
			frameLine.graphics.lineStyle(3,0xffffff);
			frameLine.graphics.drawRect(0,0,500,8);
			
			frameBmpd = new BitmapData(500,8,true,0xffffff);
			frameBmpd.draw(frameLine);
			var texture:Texture = Texture.fromBitmapData(frameBmpd);
			var img:Image = new Image(texture);
			img.x = squareQuad.x;
			img.y = squareQuad.y;
			addChild(img);
			this.levelName = themeId + "_" + levelId;
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
			squareQuad.scaleX = 0;
			timer = new Timer(1000 / 30);
			timer.addEventListener(TimerEvent.TIMER, onTimer);
			timer.start();
		}
		
		private function onTimer(event:TimerEvent):void{
			squareQuad.scaleX += 0.1;
			if(squareQuad.scaleX >= 1){
				squareQuad.scaleX = 1;
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