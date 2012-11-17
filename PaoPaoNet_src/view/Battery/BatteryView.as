package view.Battery
{
	import flash.display.BitmapData;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	
	public class BatteryView extends Sprite
	{
//		private var _batteryMc:MovieClip;
		internal var gun:Image;
		private var _base:Image;
		public function BatteryView()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
			drawBattery();
            this.touchable = false;
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);	
		}
		
		private function drawBattery():void
		{
//			_batteryMc = new MovieClip(Assets.getAtlas().getTextures("gun"), 20);
//			_batteryMc.stop();
//			Starling.juggler.add(_batteryMc);
//			addChild(_batteryMc);
			gun = new Image(Assets.getAtlas().getTexture("gun"));
			addChild(gun);
			gun.pivotX = 0;
			gun.pivotY = 38;
			gun.x = 40;
			gun.y = 30;
			_base = new Image(Assets.getAtlas().getTexture("battery"));
			addChild(_base);
		}
		
		/*public function gunBang():void{
			if(!_batteryMc.isPlaying)
				_batteryMc.play();
		}*/
		
		/*public function stopFire():void{
			if(_batteryMc.isPlaying){
				if(_batteryMc.currentFrame == 1){
					_batteryMc.stop();
				}else{
					_batteryMc.play();
				}
			}
		}*/
	}
}
