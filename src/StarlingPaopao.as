package
{
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.display3D.Context3DRenderMode;
	import flash.events.Event;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	import flash.utils.setTimeout;
	
	import starling.core.Starling;
	
	import utils.DebugConsole;
	
	[SWF(width="900", height="580", frameRate="60", backgroundColor="0xf3f3f3")]
	public class StarlingPaopao extends Sprite
	{
		private var expandmenu:ContextMenu;
		private var customMenu:ContextMenuItem;
		private var versionMenu:ContextMenuItem;
		private var mStarling:Starling;
		
		public function StarlingPaopao()
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			showRightClickMenu();
			setTimeout(initStarling,1000);
		}
		
		private function showRightClickMenu():void
		{
			expandmenu = new ContextMenu();
			expandmenu.hideBuiltInItems();
			customMenu = new ContextMenuItem("51高清娱乐", true);
			versionMenu = new ContextMenuItem("版本号:201211221240", true, false);
			expandmenu.customItems.push(versionMenu);
			expandmenu.customItems.push(customMenu);
			this.contextMenu = expandmenu;
		}
		
		private function initStarling():void{
			Starling.handleLostContext = true;
			mStarling = new Starling(Main,stage, null, null, Context3DRenderMode.AUTO);
			mStarling.antiAliasing = 1;
			mStarling.showStats = true;
			mStarling.start();
			DebugConsole.addDebugLog("");
			mStarling.stage3D.addEventListener(Event.CONTEXT3D_CREATE, onContextCreated);
		}
		
		private function onContextCreated(event:Event):void
		{
			if (Starling.context.driverInfo.toLowerCase().indexOf("software") != -1){
				Starling.current.nativeStage.frameRate = 60;
				DebugConsole.addDebugLog("Display Driver: software.");
			}else{
				DebugConsole.addDebugLog("Display Driver: DIRECTX.");
			}
		}
	}
}