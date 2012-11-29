package utils
{
	import com.bit101.components.TextArea;
	
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	import starling.core.Starling;
	
	public class DebugConsole extends Sprite
	{
		private static var debug:TextArea;
		private static var lineNo:uint;
		private static var isDebug:Boolean = true;
		public function DebugConsole()
		{
			super();
		}
		
		public static function addDebugLog(info:String):void{
			if(!isDebug)	return;
			if(debug){
				debug.text += "\n" + lineNo + "--." + info;
				lineNo ++;
			}else{
				debug = new TextArea(null, 64, 64);
				debug.editable = false;
				debug.width = 700;
				debug.height = 450;
				lineNo = 0;
				debug.text = "============================================DEBUG HISTORY===========================================";
				Starling.current.nativeStage.addChild(debug);
				Starling.current.nativeStage.addEventListener(flash.events.KeyboardEvent.KEY_UP, onShowDebug);
				debug.visible = false;
			}
		}
		
		private static function onShowDebug(e:flash.events.KeyboardEvent):void{
			if(e.keyCode == Keyboard.HOME)
				debug.visible = !debug.visible;
		}
	}
}