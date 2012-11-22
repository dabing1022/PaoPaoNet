package utils
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.events.EventDispatcher;
    /**震动物体-角度方面*/
	public class ShakeObjUtils extends EventDispatcher
	{
		private var _startRad:Number;
		private var _target:DisplayObject;
		private var _maxRotateRad:Number;
		private var _count:int = 0;
		private var _rate:Number;
		private var dir:int = 1;   //用于反转方向
		
		private static var _instance:ShakeObjUtils;
		private var isAnimation:Boolean = false;
		public static function getInstance():ShakeObjUtils{
			return _instance ||= new ShakeObjUtils();
		}
		
		public function shakeObj(target:DisplayObject , time:Number ,rate:Number, maxRotateRad:Number):void
		{
			_target = target;
			_startRad = target.rotation;
			_maxRotateRad = maxRotateRad;
			_count = time * rate;
			_rate = rate;
			
			var timer:Timer = new Timer(1000 / rate, _count );
			timer.addEventListener(TimerEvent.TIMER, shaking);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, shakeComplete);
			timer.start();
		}
		
		private function shaking(e:TimerEvent):void 
		{
			if(isAnimation)	return;
			var tween:Tween = new Tween(_target, 1.0);
			Starling.juggler.add(tween);
			var desRad:Number = _startRad + Math.random() * _maxRotateRad * dir;
			tween.animate("rotation", desRad);
			dir *= -1;          //反转方向
		}
		
		private function shakeComplete(e:TimerEvent):void 
		{
			if(isAnimation) return;
			var tween:Tween = new Tween(_target, 1.0);
			Starling.juggler.add(tween);
			tween.animate("rotation", _startRad);
		}
	}
}
