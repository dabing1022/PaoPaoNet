package view.InfoBoard
{
	import flash.display.Bitmap;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.utils.Color;
	import starling.utils.HAlign;
	
	public class FloatScoreView extends Sprite
	{
		private var _scoreNumTxt:TextField;
		private var _plusSymbol:TextField;
		private var _timer:Timer;
		public function FloatScoreView()
		{
			super();
			var tempCls:Class = Assets.getClass("PublicResource_FloatScoreFontImg");
			var bmp:Bitmap = new tempCls();
			var texture:Texture = Texture.fromBitmap(bmp);
			tempCls = Assets.getClass("PublicResource_FloatScoreFontXml");
			var xml:XML = XML(new tempCls());
			var bmpFont:BitmapFont = new BitmapFont(texture, xml);
			TextField.registerBitmapFont(bmpFont,"scoreFont");
			
			_plusSymbol = new TextField(90, 50, "+", "scoreFont");
			_plusSymbol.fontSize = BitmapFont.NATIVE_SIZE;
			_plusSymbol.color = Color.WHITE;
			_plusSymbol.hAlign = HAlign.LEFT;
			addChild(_plusSymbol);
			
			_scoreNumTxt = new TextField(90, 50, "0", "scoreFont");
			_scoreNumTxt.fontSize = BitmapFont.NATIVE_SIZE;
			_scoreNumTxt.color = Color.WHITE;
			_scoreNumTxt.hAlign = HAlign.LEFT;
			addChild(_scoreNumTxt);
			_scoreNumTxt.x = 10;
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			_timer = new Timer(500, 1);
			_timer.addEventListener(TimerEvent.TIMER, floatAndFadeOut);
			_timer.start();
		}
		
		private function floatAndFadeOut(event:TimerEvent):void{
			var tween:Tween = new Tween(this, 1);
			tween.fadeTo(0);
			tween.animate("y", this.y - 10);
			Starling.juggler.add(tween);
			tween.onComplete = destroy;
			
			_timer.removeEventListener(TimerEvent.TIMER, floatAndFadeOut);
			_timer = null;
		}
		
		private function destroy():void{
			this.removeFromParent(true);
		}

		public function get scoreNumTxt():TextField
		{
			return _scoreNumTxt;
		}

		public function set scoreNumTxt(value:TextField):void
		{
			_scoreNumTxt = value;
		}

		
	}
}
