package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	import flash.utils.setTimeout;
	
	import starling.core.Starling;
	
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
			customMenu = new ContextMenuItem("视讯科技", true);
			versionMenu = new ContextMenuItem("版本号:201210111030", true, false);
			expandmenu.customItems.push(versionMenu);
			expandmenu.customItems.push(customMenu);
			this.contextMenu = expandmenu;
		}
		
		private function initStarling():void{
			mStarling = new Starling(Main,stage);
			mStarling.antiAliasing = 1;
			mStarling.showStats = true;
			mStarling.start();
			mStarling.stage3D.addEventListener(Event.CONTEXT3D_CREATE, onContextCreated);
		}
		
		private function onContextCreated(event:Event):void
		{
			if (Starling.context.driverInfo.toLowerCase().indexOf("software") != -1)
				Starling.current.nativeStage.frameRate = 60;
		}
	}
}